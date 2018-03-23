Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeCWPN2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751657AbeCWPNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:13:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13D82183C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180323151322.712818282@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 23 Mar 2018 11:02:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>,
        =?ISO-8859-15?q?Am=C3=A9rico=20Wang?= <xiyou.wangcong@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/3] init, tracing: Add initcall trace events
References: <20180323150241.878778199@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0002-init-tracing-Add-initcall-trace-events.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Being able to trace the start and stop of initcalls is useful to see where
the timings are an issue. There is already an "initcall_debug" parameter,
but that can cause a large overhead itself, as the printing of the
information may take longer than the initcall functions.

Adding in a start and finish trace event around the initcall functions, as
well as a trace event that records the level of the initcalls, one can get a
much finer measurement of the times and interactions of the initcalls
themselves, as trace events are much lighter than printk()s.

Suggested-by: Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/events/initcall.h | 66 +++++++++++++++++++++++++++++++++++++++++
 init/main.c                     |  7 +++++
 2 files changed, 73 insertions(+)
 create mode 100644 include/trace/events/initcall.h

diff --git a/include/trace/events/initcall.h b/include/trace/events/initcall.h
new file mode 100644
index 000000000000..8d6cf10d27c9
--- /dev/null
+++ b/include/trace/events/initcall.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM initcall
+
+#if !defined(_TRACE_INITCALL_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_INITCALL_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(initcall_level,
+
+	TP_PROTO(const char *level),
+
+	TP_ARGS(level),
+
+	TP_STRUCT__entry(
+		__string(level, level)
+	),
+
+	TP_fast_assign(
+		__assign_str(level, level);
+	),
+
+	TP_printk("level=%s", __get_str(level))
+);
+
+TRACE_EVENT(initcall_start,
+
+	TP_PROTO(initcall_t func),
+
+	TP_ARGS(func),
+
+	TP_STRUCT__entry(
+		__field(initcall_t, func)
+	),
+
+	TP_fast_assign(
+		__entry->func = func;
+	),
+
+	TP_printk("func=%pS", __entry->func)
+);
+
+TRACE_EVENT(initcall_finish,
+
+	TP_PROTO(initcall_t func, int ret),
+
+	TP_ARGS(func, ret),
+
+	TP_STRUCT__entry(
+		__field(initcall_t,	func)
+		__field(int,		ret)
+	),
+
+	TP_fast_assign(
+		__entry->func = func;
+		__entry->ret = ret;
+	),
+
+	TP_printk("func=%pS ret=%d", __entry->func, __entry->ret)
+);
+
+#endif /* if !defined(_TRACE_GPIO_H) || defined(TRACE_HEADER_MULTI_READ) */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/init/main.c b/init/main.c
index 0ebdd5f15be8..2af8f2bb5ca8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -97,6 +97,9 @@
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/initcall.h>
+
 static int kernel_init(void *);
 
 extern void init_IRQ(void);
@@ -827,10 +830,12 @@ int __init_or_module do_one_initcall(initcall_t fn)
 	if (initcall_blacklisted(fn))
 		return -EPERM;
 
+	trace_initcall_start(fn);
 	if (initcall_debug)
 		ret = do_one_initcall_debug(fn);
 	else
 		ret = fn();
+	trace_initcall_finish(fn, ret);
 
 	msgbuf[0] = 0;
 
@@ -895,6 +900,7 @@ static void __init do_initcall_level(int level)
 		   level, level,
 		   NULL, &repair_env_string);
 
+	trace_initcall_level(initcall_level_names[level]);
 	for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
 		do_one_initcall(*fn);
 }
@@ -929,6 +935,7 @@ static void __init do_pre_smp_initcalls(void)
 {
 	initcall_t *fn;
 
+	trace_initcall_level("early");
 	for (fn = __initcall_start; fn < __initcall0_start; fn++)
 		do_one_initcall(*fn);
 }
-- 
2.15.1
