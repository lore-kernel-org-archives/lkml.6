Return-Path: <maier@linux.ibm.com>
X-Google-Smtp-Source: AIpwx4+a9oTaMowjvbT09PC71GRw5x/3JW0nnBV/26ODk798Oxgp0QSHQ7LyoG6zrEiDMMTSd2wx
ARC-Seal: i=1; a=rsa-sha256; t=1523637397; cv=none;
        d=google.com; s=arc-20160816;
        b=zPExFVLKUvxFnO7CREi6Bxyrpw4e0HCNS0cmhS2iki4tq7cB0PekcHAD+TUs/WC0ic
         xxVHtZjowc8GpDrygE9yiFN0WI5oGC1PzWg+owl1uxaKeUBy0B4bdTSCfIzHegC8DJdR
         WZte3xH8iV5tNTLMayZd+1MERMexHKzFTUzZKaiJwUlPoEf6Qboxi/HpcOdpKKOxZyZ8
         EjBve3uvdObAZtff6CIkbCta/1un8eEQy9HaMagQFRwQd5iocMFbaJjoszgulNKISW6g
         qrOIH5Crrd3Da7rj7LnCzSIUgu6ZUCwvyigDBzECXZsXBHRr1IBts29D7vDlgn1r0rM2
         1+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=866Uy8WAFFe64AkaIT3hMDMg8fsaDxr+Kscy9Oeenv8=;
        b=mok2q0FZr9GlEssD7w/f+0vcic2rPD/GNaahzNAXXz0vcxsOvu0s+YPFHbvD8tBjwo
         svvpoWQC4Qtg/nBcUaGVTIBkJjnmUw9p5Ir8vhDlP3p170m1twdrBS0Sk9YNpB6bhaf0
         QUNSgnKA65RoAXegn76ltAd0vloJwCwNvl5RKEYKyFY2/4dsXNz5MDJFqLif6RfS7xx5
         gvSLYbURFD7AG7gVejx/T+r2Xe65++8tH0/F9HwKRARIjD3zk+r4BvJZv/AFGvbgvAns
         XFMNNCZ5PYt+4XMQqEXhG97rCsTNIsAurlDKTJEr230ekxrV2oTrlFcMYScAnTwlJPKB
         tx/Q==
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
Subject: [PATCH v2 1/2] tracing/events: block: track and print if unplug was explicit or schedule
Date: Fri, 13 Apr 2018 18:36:21 +0200
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180413163623.11282-1-maier@linux.ibm.com>
References: <20180413163623.11282-1-maier@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041316-0040-0000-0000-0000044D4849
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041316-0041-0000-0000-000020F181B2
Message-Id: <20180413163623.11282-2-maier@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804130152
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649607782125135?=
X-GMAIL-MSGID: =?utf-8?q?1597649607782125135?=
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

Changes since v1:
Use 0 and 1 instead of false and true for __print_symbolic table.
Now "trace-cmd report" can decode it. [Steven Rostedt]

 include/trace/events/block.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 81b43f5bdf23..e90bb6eb8097 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -470,6 +470,11 @@ TRACE_EVENT(block_plug,
 	TP_printk("[%s]", __entry->comm)
 );
 
+#define show_block_unplug_explicit(val)		\
+	__print_symbolic(val,			\
+			 {0, "schedule"},	\
+			 {1, "explicit"})
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
