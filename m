Return-Path: <maier@linux.ibm.com>
X-Google-Smtp-Source: AIpwx480dr5IMw8TNsh6D7jSVukPc7tkc38hSKQ3PoRkGQnbi8/QSeGgV550kooBn6gEi3XJT7uW
ARC-Seal: i=1; a=rsa-sha256; t=1523624884; cv=none;
        d=google.com; s=arc-20160816;
        b=F8rh6KHQ6/1N/yf2uBZX1uPsnNmndTeJDsxaCtrG9KvIWtom9jLs1LOIATP0S4qQMq
         np3OLqmyfS0f9ulbI4HwLt4ZMpGs3R34xRZWhGYxC62C3WlqupSTX/n/441v4yJVNbEl
         zbQEfmjq2NDV85jP6DkkkyB+tH63jH3z7AjuRRoZ+/bPVdpleSfmCYAg6h/dWsI7aNwU
         5xT55qGsMQ8YDLQwHj8VJqT2q4NgrhHiqcQ8gl7f5fVKj0MPE570TQBR/NnkTf2jZ7gR
         PoMK48JIm9X1aYWV+pA+57gi4lTzqNS51kkXKcf6/XYv9a24NyLnKZ2dcZVqK4llp18X
         vFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=TdX+at1bjp40kOiQMjAxFCJs12g2LQnyEqz6jaiIJbw=;
        b=0mRdHY7DBPNMPko8xk4ILm9wWAPiM+DJNefJOO7R2J+15KKqt0F8Se7YPg86r1/ttG
         dTcFKpmvLaw4ipwhC/63AUGhzr1Tl4UjjAaZsGFEVCDgZrcWaNGBlTh6i5ygVI+5A2IE
         6fdCqKg5LK6k0uFAJW6fGalrIR5ZapOxnoto/O+UcCa+Mzwqpb+duii1n1FdKTQ3lkAP
         Pn0N6B8qVB30s7Me1UUfo4ziTL9f9JkOM5RI3TMq9BjmmudpTu/5W1XgTnhJhPnxaN0P
         y7BCuI259slEwMg2BnRklLIYS8Ci05bx3UJ01YsuvUf78TdwB8FMuDdsTXxV+nPUDLTY
         NB/A==
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
Subject: [PATCH 1/2] tracing/events: block: track and print if unplug was explicit or schedule
Date: Fri, 13 Apr 2018 15:07:17 +0200
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180413130719.22921-1-maier@linux.ibm.com>
References: <20180413130719.22921-1-maier@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041313-0040-0000-0000-0000044D34C8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041313-0041-0000-0000-000020F16D38
Message-Id: <20180413130719.22921-2-maier@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804130122
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597636487135013741?=
X-GMAIL-MSGID: =?utf-8?q?1597636487135013741?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Just like blktrace distinguishes explicit and schedule by means of
BLK_TA_UNPLUG_IO and BLK_TA_UNPLUG_TIMER, actually make use of the
existing argument "explicit" to distinguish the two cases in the one
common tracepoint block_unplug.

Complements v2.6.39 commit 49cac01e1fa7 ("block: make unplug timer trace
event correspond to the schedule() unplug") and commit d9c978331790
("block: remove block_unplug_timer() trace point").

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 include/trace/events/block.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 81b43f5bdf23..a13613d27cee 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -470,6 +470,11 @@ TRACE_EVENT(block_plug,
 	TP_printk("[%s]", __entry->comm)
 );
 
+#define show_block_unplug_explicit(val)		\
+	__print_symbolic(val,			\
+			 {false, "schedule"},	\
+			 {true,	 "explicit"})
+
 DECLARE_EVENT_CLASS(block_unplug,
 
 	TP_PROTO(struct request_queue *q, unsigned int depth, bool explicit),
@@ -478,15 +483,18 @@ DECLARE_EVENT_CLASS(block_unplug,
 
 	TP_STRUCT__entry(
 		__field( int,		nr_rq			)
+		__field( bool,		explicit		)
 		__array( char,		comm,	TASK_COMM_LEN	)
 	),
 
 	TP_fast_assign(
 		__entry->nr_rq = depth;
+		__entry->explicit = explicit;
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
-	TP_printk("[%s] %d", __entry->comm, __entry->nr_rq)
+	TP_printk("[%s] %d %s", __entry->comm, __entry->nr_rq,
+		  show_block_unplug_explicit(__entry->explicit))
 );
 
 /**
-- 
2.13.5
