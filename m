Return-Path: <maier@linux.ibm.com>
X-Google-Smtp-Source: AIpwx495BaLYFwtG2LHlVG4Ks7FquG1AYBeeC5kZmWtYK5L23h4WYVoIIkHpQmA5qwoemQmnkRN/
ARC-Seal: i=1; a=rsa-sha256; t=1523637403; cv=none;
        d=google.com; s=arc-20160816;
        b=uTMt2QtCEDOqibbq4leivSSYchhCTnX73c74DswoDC/ooNH7U7oAv1LCXzgtCP0YYZ
         4CAmuGRfOAiJBPkmdfTQ6Ik3vtGQWQFjJ5XdJS+JxqddiB2DD1hwOaSArKERM7V2cFl6
         D4e3WmNtyJ5Q/vImYOKRwNOqZni+J4BvpT6kOE636lAW/PyzaoycdRBzhQMJO4ztxw0F
         SeKJbshV8gX6hUxEQ+4QvkN9diqoZ1tsOsQDIPDAG4oeDdUg0RAlaxxeBzwlToDNmYYc
         piQyeI4DQvKv4OmE4XAAnWOVkdJ5Znu9SJ8zr3Ep7DQsTPyVzIqDtKK13YgK6RlOn5qw
         KoXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=U6a1jOpL1a/s8g7xqcBg4HcJV2x1hrrKb4vxjMVtW5c=;
        b=qqsrgB7Scgm6oj26hR9JdKTchouhVNwJ3npB1Nvx3z8k6F8e4o1eexMsJWjF5C02P1
         79oDArrkkT9RG5EpIBiJtk5SxrBLVnfH9X236AcZMqmFMJRQmAqZhKXS3O6A95Ses0Zv
         4k2qVycOCs/aHMMout/sUyWE16uZwOrDzvpylGdgwclSdi3rQ5uUS9jxRb6A2ybUM68w
         V6sgR/lwWMahNxswLPF4WHBtoeRbi8q6EuBT1Fl6Y2rHUZC0OfnSg7wCj2IjRbZ20jNk
         /fgT8TEyRbx1+Ivsgx9m4Ay4dsRhOZYuSRfrZbZ9LEcM1JiM0QIe5BHcAW9hu452lB2V
         d7BA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of maier@linux.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=maier@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of maier@linux.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=maier@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Steffen Maier <maier@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Li Zefan <lizefan@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steffen Maier <maier@linux.ibm.com>
Subject: [RFC v2] tracing/events: block: also try to get dev_t via driver core for some events
Date: Fri, 13 Apr 2018 18:36:23 +0200
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180413163623.11282-1-maier@linux.ibm.com>
References: <20180413163623.11282-1-maier@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041316-0008-0000-0000-000004EA49D8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041316-0009-0000-0000-00001E7E589C
Message-Id: <20180413163623.11282-4-maier@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804130152
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597636512361952197?=
X-GMAIL-MSGID: =?utf-8?q?1597649613356721194?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Complements v2.6.31 commit 55782138e47d ("tracing/events: convert block
trace points to TRACE_EVENT()") for cases where rq->rq_disk == NULL:
  block_rq_requeue, block_rq_insert, block_rq_issue;
and for cases where bio == NULL:
  block_getrq, block_sleeprq.

NB: The NULL pointer check for q->kobj.parent is certainly racy and
I don't have enough experience if it's good enough for a trace event.

Since I don't know when above cases would occur,
I'm not sure this is worth it.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 include/trace/events/block.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 6ea5a3899c2e..001e4f369df9 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -86,7 +86,9 @@ TRACE_EVENT(block_rq_requeue,
 	),
 
 	TP_fast_assign(
-		__entry->dev	   = rq->rq_disk ? disk_devt(rq->rq_disk) : 0;
+		__entry->dev	   = rq->rq_disk ? disk_devt(rq->rq_disk) :
+		(q->kobj.parent ?
+		 container_of(q->kobj.parent, struct device, kobj)->devt : 0);
 		__entry->sector    = blk_rq_trace_sector(rq);
 		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
 
@@ -162,7 +164,9 @@ DECLARE_EVENT_CLASS(block_rq,
 	),
 
 	TP_fast_assign(
-		__entry->dev	   = rq->rq_disk ? disk_devt(rq->rq_disk) : 0;
+		__entry->dev	   = rq->rq_disk ? disk_devt(rq->rq_disk) :
+		(q->kobj.parent ?
+		 container_of(q->kobj.parent, struct device, kobj)->devt : 0);
 		__entry->sector    = blk_rq_trace_sector(rq);
 		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
 		__entry->bytes     = blk_rq_bytes(rq);
@@ -397,7 +401,9 @@ DECLARE_EVENT_CLASS(block_get_rq,
         ),
 
 	TP_fast_assign(
-		__entry->dev		= bio ? bio_dev(bio) : 0;
+		__entry->dev		= bio ? bio_dev(bio) :
+		(q->kobj.parent ?
+		 container_of(q->kobj.parent, struct device, kobj)->devt : 0);
 		__entry->sector		= bio ? bio->bi_iter.bi_sector : 0;
 		__entry->nr_sector	= bio ? bio_sectors(bio) : 0;
 		blk_fill_rwbs(__entry->rwbs,
-- 
2.13.5
