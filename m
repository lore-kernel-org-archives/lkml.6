Return-Path: <maier@linux.ibm.com>
X-Google-Smtp-Source: AIpwx49VP8XkjjPH89BZY2GMrIL27fyNsjW3ilbsYHL7J+uH6aPVTkfhuEf0RoES2yQH+k24yMQy
ARC-Seal: i=1; a=rsa-sha256; t=1523637399; cv=none;
        d=google.com; s=arc-20160816;
        b=D09uoOrPh7Yem9zh8wxCAIitOLA233GwofBZIY4lkcgGYykWh1PXtzyrqMtx3HDgcW
         Yl33NF3NHAxBZmtxjEMGEz9cW5DcTUcZEZz5aBo84RlD85JQ/UfFhuT2nDnPjvU8+6s5
         snNL3TfxCFaxsyCsgnmsC90c0VxpOTIugWXy25NZZeWeoEQaQtI9Y+Xh03rJsLffbWy3
         /8V9rNc8X0ymommywv+Ds1vhg/xk0QeqRDxqCEL0EVAoZfyscEb0OslLQQuLIeMHrwUA
         JdRc7ZmK61EMd6A1sPNInlxjhdBAQdehVRFCIIPaq5CetzMQb01o2hH5k+bm/jcpZ+C+
         zQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Lh9kzF4AgxVgIto34JuF9HivQbjuV5MQBMLZopLoP9I=;
        b=yr+n6WbQ2TOGgZqLTSz/vHPGR6WiWUBoxsTXimJQ7Z07OwRxqqrxNcvrBOYKz6CFP1
         +IbLwuZyvWtDUf6fYxsLBDxYf7nloyFpVoQ+lV0CvKAG5MZY90gRKUvXykD0XMuyTYuE
         jkbI3EfBLEX4GQz9KT84nQK5hVx0wNg/QTDT7lMNmJU1fZfWpwXYScZW1OdOuJpjAVUS
         OnNMOFkxBLalw85xcQ1sdWTQnqUrxTRkLad88b5svr8XOdoevUzgvniYhUaB6TdXNSXj
         w9wklzGibGpXWrwV2YcdQYXui7xuTF+vXynzpJ589MDUqd7lV750ekBwgfEUcFh0ppYl
         SvVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of maier@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=maier@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of maier@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=maier@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Steffen Maier <maier@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Li Zefan <lizefan@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steffen Maier <maier@linux.ibm.com>
Subject: [PATCH v2 2/2] tracing/events: block: dev_t via driver core for plug and unplug events
Date: Fri, 13 Apr 2018 18:36:22 +0200
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180413163623.11282-1-maier@linux.ibm.com>
References: <20180413163623.11282-1-maier@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041316-0020-0000-0000-00000411A2A2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041316-0021-0000-0000-000042A5D638
Message-Id: <20180413163623.11282-3-maier@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804130152
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597636500726736984?=
X-GMAIL-MSGID: =?utf-8?q?1597649610007955460?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Complements v2.6.31 commit 55782138e47d ("tracing/events: convert block
trace points to TRACE_EVENT()") to be equivalent to traditional blktrace
output. Also this allows event filtering to not always get all (un)plug
events.

NB: The NULL pointer check for q->kobj.parent is certainly racy and
I don't have enough experience if it's good enough for a trace event.
The change did work for my cases (block device read/write I/O on
zfcp-attached SCSI disks and dm-mpath on top).

While I haven't seen any prior art using driver core (parent) relations
for trace events, there are other cases using this when no direct pointer
exists between objects, such as:
 #define to_scsi_target(d)	container_of(d, struct scsi_target, dev)
 static inline struct scsi_target *scsi_target(struct scsi_device *sdev)
 {
	return to_scsi_target(sdev->sdev_gendev.parent);
 }

This is the object model we make use of here:

struct gendisk {
        struct hd_struct {
                struct device {      /*container_of*/
                        struct kobject kobj; <--+
                        dev_t  devt; /*deref*/  |
                } __dev;                        |
        } part0;                                |
        struct request_queue *queue; ..+        |
}                                      :        |
                                       :        |
struct request_queue {  <..............+        |
        /* queue kobject */                     |
        struct kobject {                        |
                struct kobject *parent; --------+
        } kobj;
}

The parent pointer comes from:
 #define disk_to_dev(disk)	(&(disk)->part0.__dev)
int blk_register_queue(struct gendisk *disk)
	struct device *dev = disk_to_dev(disk);
	struct request_queue *q = disk->queue;
	ret = kobject_add(&q->kobj, kobject_get(&dev->kobj), "%s", "queue");
	                            ^^^parent

$ ls -d /sys/block/sdf/queue
/sys/block/sda/queue
$ cat /sys/block/sdf/dev
80:0

A partition does not have its own request queue:

$ cat /sys/block/sdf/sdf1/dev
8:81
$ ls -d /sys/block/sdf/sdf1/queue
ls: cannot access '/sys/block/sdf/sdf1/queue': No such file or directory

The difference to blktrace parsed output is that block events don't use the
partition's minor number but the containing block device's minor number:

$ dd if=/dev/sdf1 count=1

$ cat /sys/kernel/debug/tracing/trace
block_bio_remap: 8,80 R 2048 + 32 <- (8,81) 0
block_bio_queue: 8,80 R 2048 + 32 [dd]
block_getrq: 8,80 R 2048 + 32 [dd]
block_plug: 8,80 [dd]
            ^^^^
block_rq_insert: 8,80 R 16384 () 2048 + 32 [dd]
block_unplug: 8,80 [dd] 1 explicit
              ^^^^
block_rq_issue: 8,80 R 16384 () 2048 + 32 [dd]
block_rq_complete: 8,80 R () 2048 + 32 [0]

$ btrace /dev/sdf1
  8,80   1        1     0.000000000 240240  A   R 2048 + 32 <- (8,81) 0
  8,81   1        2     0.000220890 240240  Q   R 2048 + 32 [dd]
  8,81   1        3     0.000229639 240240  G   R 2048 + 32 [dd]
  8,81   1        4     0.000231805 240240  P   N [dd]
    ^^
  8,81   1        5     0.000234671 240240  I   R 2048 + 32 [dd]
  8,81   1        6     0.000236365 240240  U   N [dd] 1
    ^^
  8,81   1        7     0.000238527 240240  D   R 2048 + 32 [dd]
  8,81   2        2     0.000613741     0  C   R 2048 + 32 [0]

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 include/trace/events/block.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index e90bb6eb8097..6ea5a3899c2e 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -460,14 +460,18 @@ TRACE_EVENT(block_plug,
 	TP_ARGS(q),
 
 	TP_STRUCT__entry(
+		__field( dev_t,		dev			)
 		__array( char,		comm,	TASK_COMM_LEN	)
 	),
 
 	TP_fast_assign(
+		__entry->dev = q->kobj.parent ?
+		container_of(q->kobj.parent, struct device, kobj)->devt : 0;
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
-	TP_printk("[%s]", __entry->comm)
+	TP_printk("%d,%d [%s]",
+		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->comm)
 );
 
 #define show_block_unplug_explicit(val)		\
@@ -482,18 +486,23 @@ DECLARE_EVENT_CLASS(block_unplug,
 	TP_ARGS(q, depth, explicit),
 
 	TP_STRUCT__entry(
+		__field( dev_t,		dev			)
 		__field( int,		nr_rq			)
 		__field( bool,		explicit		)
 		__array( char,		comm,	TASK_COMM_LEN	)
 	),
 
 	TP_fast_assign(
+		__entry->dev   = q->kobj.parent ?
+		container_of(q->kobj.parent, struct device, kobj)->devt : 0;
 		__entry->nr_rq = depth;
 		__entry->explicit = explicit;
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
-	TP_printk("[%s] %d %s", __entry->comm, __entry->nr_rq,
+	TP_printk("%d,%d [%s] %d %s",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->comm, __entry->nr_rq,
 		  show_block_unplug_explicit(__entry->explicit))
 );
 
-- 
2.13.5
