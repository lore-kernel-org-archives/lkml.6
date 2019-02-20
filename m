Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0512C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EEA21B24
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfBTSiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:38:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:47114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfBTSiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:38:07 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E11A92190B;
        Wed, 20 Feb 2019 18:38:05 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1gwWku-0006ei-TY; Wed, 20 Feb 2019 13:38:04 -0500
Message-Id: <20190220183804.803102229@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 20 Feb 2019 13:37:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>
Subject: [for-next][PATCH 10/29] tracing: Change the function format to display function names by perf
References: <20190220183737.034634614@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

Here is an example for this change.

$ sudo perf record -e 'ftrace:function' --filter='ip==schedule'
$ sudo perf report

The output of perf before this patch:

\# Samples: 100  of event 'ftrace:function'
\# Event count (approx.): 100
\#
\# Overhead  Trace output
\# ........  ......................................
\#
    51.00%   ffffffff81f6aaa0 <-- ffffffff81158e8d
    29.00%   ffffffff81f6aaa0 <-- ffffffff8116ccb2
     8.00%   ffffffff81f6aaa0 <-- ffffffff81f6f2ed
     4.00%   ffffffff81f6aaa0 <-- ffffffff811628db
     4.00%   ffffffff81f6aaa0 <-- ffffffff81f6ec5b
     2.00%   ffffffff81f6aaa0 <-- ffffffff81f6f21a
     1.00%   ffffffff81f6aaa0 <-- ffffffff811b04af
     1.00%   ffffffff81f6aaa0 <-- ffffffff8143ce17

After this patch:

\# Samples: 36  of event 'ftrace:function'
\# Event count (approx.): 36
\#
\# Overhead  Trace output
\# ........  ............................................
\#
    38.89%   schedule <-- schedule_hrtimeout_range_clock
    27.78%   schedule <-- worker_thread
    13.89%   schedule <-- schedule_timeout
    11.11%   schedule <-- smpboot_thread_fn
     5.56%   schedule <-- rcu_gp_kthread
     2.78%   schedule <-- exit_to_usermode_loop

Link: http://lkml.kernel.org/r/20190209161919.32350-1-changbin.du@gmail.com

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_entries.h | 41 +++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 06bb2fd9a56c..fc8e97328e54 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -65,7 +65,8 @@ FTRACE_ENTRY_REG(function, ftrace_entry,
 		__field(	unsigned long,	parent_ip	)
 	),
 
-	F_printk(" %lx <-- %lx", __entry->ip, __entry->parent_ip),
+	F_printk(" %ps <-- %ps",
+		 (void *)__entry->ip, (void *)__entry->parent_ip),
 
 	FILTER_TRACE_FN,
 
@@ -83,7 +84,7 @@ FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
 		__field_desc(	int,		graph_ent,	depth		)
 	),
 
-	F_printk("--> %lx (%d)", __entry->func, __entry->depth),
+	F_printk("--> %ps (%d)", (void *)__entry->func, __entry->depth),
 
 	FILTER_OTHER
 );
@@ -102,8 +103,8 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 		__field_desc(	int,		ret,		depth	)
 	),
 
-	F_printk("<-- %lx (%d) (start: %llx  end: %llx) over: %d",
-		 __entry->func, __entry->depth,
+	F_printk("<-- %ps (%d) (start: %llx  end: %llx) over: %d",
+		 (void *)__entry->func, __entry->depth,
 		 __entry->calltime, __entry->rettime,
 		 __entry->depth),
 
@@ -167,12 +168,6 @@ FTRACE_ENTRY_DUP(wakeup, ctx_switch_entry,
 
 #define FTRACE_STACK_ENTRIES	8
 
-#ifndef CONFIG_64BIT
-# define IP_FMT "%08lx"
-#else
-# define IP_FMT "%016lx"
-#endif
-
 FTRACE_ENTRY(kernel_stack, stack_entry,
 
 	TRACE_STACK,
@@ -182,12 +177,13 @@ FTRACE_ENTRY(kernel_stack, stack_entry,
 		__dynamic_array(unsigned long,	caller	)
 	),
 
-	F_printk("\t=> (" IP_FMT ")\n\t=> (" IP_FMT ")\n\t=> (" IP_FMT ")\n"
-		 "\t=> (" IP_FMT ")\n\t=> (" IP_FMT ")\n\t=> (" IP_FMT ")\n"
-		 "\t=> (" IP_FMT ")\n\t=> (" IP_FMT ")\n",
-		 __entry->caller[0], __entry->caller[1], __entry->caller[2],
-		 __entry->caller[3], __entry->caller[4], __entry->caller[5],
-		 __entry->caller[6], __entry->caller[7]),
+	F_printk("\t=> %ps\n\t=> %ps\n\t=> %ps\n"
+		 "\t=> %ps\n\t=> %ps\n\t=> %ps\n"
+		 "\t=> %ps\n\t=> %ps\n",
+		 (void *)__entry->caller[0], (void *)__entry->caller[1],
+		 (void *)__entry->caller[2], (void *)__entry->caller[3],
+		 (void *)__entry->caller[4], (void *)__entry->caller[5],
+		 (void *)__entry->caller[6], (void *)__entry->caller[7]),
 
 	FILTER_OTHER
 );
@@ -201,12 +197,13 @@ FTRACE_ENTRY(user_stack, userstack_entry,
 		__array(	unsigned long,	caller, FTRACE_STACK_ENTRIES	)
 	),
 
-	F_printk("\t=> (" IP_FMT ")\n\t=> (" IP_FMT ")\n\t=> (" IP_FMT ")\n"
-		 "\t=> (" IP_FMT ")\n\t=> (" IP_FMT ")\n\t=> (" IP_FMT ")\n"
-		 "\t=> (" IP_FMT ")\n\t=> (" IP_FMT ")\n",
-		 __entry->caller[0], __entry->caller[1], __entry->caller[2],
-		 __entry->caller[3], __entry->caller[4], __entry->caller[5],
-		 __entry->caller[6], __entry->caller[7]),
+	F_printk("\t=> %ps\n\t=> %ps\n\t=> %ps\n"
+		 "\t=> %ps\n\t=> %ps\n\t=> %ps\n"
+		 "\t=> %ps\n\t=> %ps\n",
+		 (void *)__entry->caller[0], (void *)__entry->caller[1],
+		 (void *)__entry->caller[2], (void *)__entry->caller[3],
+		 (void *)__entry->caller[4], (void *)__entry->caller[5],
+		 (void *)__entry->caller[6], (void *)__entry->caller[7]),
 
 	FILTER_OTHER
 );
-- 
2.20.1


