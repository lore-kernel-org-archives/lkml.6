Return-Path: <maier@linux.ibm.com>
X-Google-Smtp-Source: AIpwx4/oC1OPgjJpoRvd+TOu2SxwvsZpUBUcCvtlqa0F94vL7HlHadeljh6tx6OgYGglkU7HenEA
ARC-Seal: i=1; a=rsa-sha256; t=1523624908; cv=none;
        d=google.com; s=arc-20160816;
        b=CxADstESgdYoxYzkpOP5Z5AAdOYYkV2i6B2K79mDc6NcHN38QPe+8DLSDloZDXrqZU
         8cLI+bLMyDLJqXOzikBH51DppTnrx//RfqrSsAxR53F4g+YOC2YhWFR6BJGxUc5qiAca
         Aik8lWG6Rj6/77XY1Ah/8sZHcAMZzC67wEO/S73d2A478CL1yU+puuo00Tp+ttaVntN0
         ClBHjuVWB3ccWs01zpWcpI0pIV1TTapT0YtV8sO+wRZPfrxX+b18iguIEl0V8GQdadF4
         2sxLgc003lrnGbqKHbZiTqBJjcw69CNS8uUvTZBSK9rvFF4994a4SroQZLG1jvnZgvPD
         uJrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=/Xlp0dSKYL31UAA+zQ2pP7XxsImooCp0UQZjGJZK9VU=;
        b=MaDjVOK5XoK1UcVfpzB4vfVHxtBP2mPg/XacrHNlUohyW2w/VMIP0kAieVPhrcfREd
         AXmq1RGL9VrnhTZkh1JQNpJGIKBZOxEcdOS8tV/XDWT+sdtvawPBGO5ApiBEznmtoYpk
         WLgn2LYGkyVLQaQSFgt4RPSyKlywpIvw7C6jKIbmRw2rRlOFclLjXHbhs/O38tvVKOYt
         SZ+dzxxhkATvEm++r28+JmijcDYfEvQ+cnEtw8l0b0JQ70uA8wB+8L4L/UbTEPbUuf7N
         bjRC7Q1vJFUA7e17uE/eUj3jInW5IYACxQGdvyKJD7OW1qMluubh88swvpwdX7UNV6tO
         sNQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of maier@linux.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=maier@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of maier@linux.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=maier@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Steffen Maier <maier@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Li Zefan <lizf@cn.fujitsu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steffen Maier <maier@linux.ibm.com>
Subject: [RFC] tracing/events: block: also try to get dev_t via driver core for some events
Date: Fri, 13 Apr 2018 15:07:19 +0200
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180413130719.22921-1-maier@linux.ibm.com>
References: <20180413130719.22921-1-maier@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041313-0044-0000-0000-00000546EEAA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041313-0045-0000-0000-000028872E79
Message-Id: <20180413130719.22921-4-maier@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804130122
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597636512361952197?=
X-GMAIL-MSGID: =?utf-8?q?1597636512361952197?=
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
index cffedc26e8a3..c476b7af404b 100644
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
