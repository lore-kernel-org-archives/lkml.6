Return-Path: <maier@linux.ibm.com>
X-Google-Smtp-Source: AIpwx48jlMOhZe+lqYOf8uK0oJXBk1BTEt0sgx9vsNN+4WZjRn6YudZ18ziHf+XknfRa4Yr0iRTt
ARC-Seal: i=1; a=rsa-sha256; t=1523624897; cv=none;
        d=google.com; s=arc-20160816;
        b=0R1xnzjM72sKnLZAsAosiWXzjVq5rZNie8mTD+kYdmQjU4eetX6n5FNPYbzRlXlt1u
         JNAoQmcoCKe7Uch5DohArNWSKkP40hjZ31IClFu4FgnY3EaBo0TRKx8t1BAazuYDobtC
         26Sg+VfCbnpPxbxIgQ0KgMlWu1cr6Ng4KedEsHUqsLKnVemhqHcmVqZCEW9TIXKLy7Bt
         zp+xx8Mabh+9lKaZeCRnOBg+EBcGCYzhHFGk2WDITu7oy5H9uzzzi9Q5UTzlxEp0TDx1
         QXqXN1QIbfpaRo6ogZ1qKW2C/H2dfuGz0pEB8izYYRfn6veb+3LgTOT66szP3uLyoywI
         5YcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=XUCGLu7VgPhYFZjFy+Hh6t/oASScTF1JoyQKBHkEkdg=;
        b=LMHonX2Z4NHAWKkMNvAuFWMUR2NHwM9McRs5sDYeuJT4wUh8i/0klxbxf+6vUkdKQl
         +VIquSuUO7CEpFlrZAPMqYpYdlNENlTz9ok38Eg0HKh6Hg1HxsnTawSE/HWKJPyxQoML
         UJkk9nqNuc6SKjUx2v2u5D64/tkVHJ+OxUCqK3XpGqQx4h2UyB0xa07Km1Rj4Xito6y+
         HGY859L0KRZbAFMPio/76/Lxxl0kp7fMWGuDrgLGO0VRlQsbSVEumFRcP1ARY8CCBUUZ
         7M6j7m4dj003u+cwTeujkHFl2M3qtYbtvgbd5K/oPstepNZBXPsyH51PvanPCNntLsvU
         TRnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of maier@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=maier@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of maier@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=maier@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Steffen Maier <maier@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Li Zefan <lizf@cn.fujitsu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steffen Maier <maier@linux.ibm.com>
Subject: [PATCH 2/2] tracing/events: block: dev_t via driver core for plug and unplug events
Date: Fri, 13 Apr 2018 15:07:18 +0200
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180413130719.22921-1-maier@linux.ibm.com>
References: <20180413130719.22921-1-maier@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041313-0044-0000-0000-00000546EEA6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041313-0045-0000-0000-000028872E75
Message-Id: <20180413130719.22921-3-maier@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804130122
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597636500726736984?=
X-GMAIL-MSGID: =?utf-8?q?1597636500726736984?=
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
index a13613d27cee..cffedc26e8a3 100644
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
