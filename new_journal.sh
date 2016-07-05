cat create-journal.sh

#!/bin/bash

### Stop osd

echo "stop osd.$1 service"

#service ceph stop osd.$1

stop ceph-osd id=$1

 

### Flush Journal

echo "Flush Journal of osd.$1"

ceph-osd --flush-journal -i $1

 

echo "move file base journal and make journal from SSD disk"

mv /var/lib/ceph/osd/ceph-$1/journal /var/lib/ceph/osd/ceph-$1/journal-file.old

ln -s /dev/$2 /var/lib/ceph/osd/ceph-$1/journal

 

### Create new journal

echo " create journal on SSD partition"

ceph-osd --mkjournal -i $1

start ceph-osd id=$1
