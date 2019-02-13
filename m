Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D497CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A05222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391176AbfBMJDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:03:50 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43247 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfBMJDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:03:49 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1D920wE196211
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 13 Feb 2019 01:02:00 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1D9202e196208;
        Wed, 13 Feb 2019 01:02:00 -0800
Date:   Wed, 13 Feb 2019 01:02:00 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-eeeb080bae906a57b6513d37efe3c38f2cb87a1c@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        jolsa@redhat.com, torvalds@linux-foundation.org, acme@redhat.com,
        righi.andrea@gmail.com, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Reply-To: torvalds@linux-foundation.org, mingo@kernel.org,
          jolsa@redhat.com, peterz@infradead.org, tglx@linutronix.de,
          hpa@zytor.com, alexander.shishkin@linux.intel.com,
          mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
          mhiramat@kernel.org, righi.andrea@gmail.com, rostedt@goodmis.org,
          acme@redhat.com
In-Reply-To: <154998802073.31052.17255044712514564153.stgit@devbox>
References: <154998802073.31052.17255044712514564153.stgit@devbox>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] kprobes: Prohibit probing on hardirq tracers
Git-Commit-ID: eeeb080bae906a57b6513d37efe3c38f2cb87a1c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  eeeb080bae906a57b6513d37efe3c38f2cb87a1c
Gitweb:     https://git.kernel.org/tip/eeeb080bae906a57b6513d37efe3c38f2cb87a1c
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Wed, 13 Feb 2019 01:13:40 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 13 Feb 2019 08:16:40 +0100

kprobes: Prohibit probing on hardirq tracers

Since kprobes breakpoint handling involves hardirq tracer,
probing these functions cause breakpoint recursion problem.

Prohibit probing on those functions.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrea Righi <righi.andrea@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/154998802073.31052.17255044712514564153.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/trace/trace_irqsoff.c    | 9 +++++++--
 kernel/trace/trace_preemptirq.c | 5 +++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index d3294721f119..d42a473b8240 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -14,6 +14,7 @@
 #include <linux/uaccess.h>
 #include <linux/module.h>
 #include <linux/ftrace.h>
+#include <linux/kprobes.h>
 
 #include "trace.h"
 
@@ -365,7 +366,7 @@ out:
 	__trace_function(tr, CALLER_ADDR0, parent_ip, flags, pc);
 }
 
-static inline void
+static nokprobe_inline void
 start_critical_timing(unsigned long ip, unsigned long parent_ip, int pc)
 {
 	int cpu;
@@ -401,7 +402,7 @@ start_critical_timing(unsigned long ip, unsigned long parent_ip, int pc)
 	atomic_dec(&data->disabled);
 }
 
-static inline void
+static nokprobe_inline void
 stop_critical_timing(unsigned long ip, unsigned long parent_ip, int pc)
 {
 	int cpu;
@@ -443,6 +444,7 @@ void start_critical_timings(void)
 		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1, pc);
 }
 EXPORT_SYMBOL_GPL(start_critical_timings);
+NOKPROBE_SYMBOL(start_critical_timings);
 
 void stop_critical_timings(void)
 {
@@ -452,6 +454,7 @@ void stop_critical_timings(void)
 		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1, pc);
 }
 EXPORT_SYMBOL_GPL(stop_critical_timings);
+NOKPROBE_SYMBOL(stop_critical_timings);
 
 #ifdef CONFIG_FUNCTION_TRACER
 static bool function_enabled;
@@ -611,6 +614,7 @@ void tracer_hardirqs_on(unsigned long a0, unsigned long a1)
 	if (!preempt_trace(pc) && irq_trace())
 		stop_critical_timing(a0, a1, pc);
 }
+NOKPROBE_SYMBOL(tracer_hardirqs_on);
 
 void tracer_hardirqs_off(unsigned long a0, unsigned long a1)
 {
@@ -619,6 +623,7 @@ void tracer_hardirqs_off(unsigned long a0, unsigned long a1)
 	if (!preempt_trace(pc) && irq_trace())
 		start_critical_timing(a0, a1, pc);
 }
+NOKPROBE_SYMBOL(tracer_hardirqs_off);
 
 static int irqsoff_tracer_init(struct trace_array *tr)
 {
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 71f553cceb3c..4d8e99fdbbbe 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -9,6 +9,7 @@
 #include <linux/uaccess.h>
 #include <linux/module.h>
 #include <linux/ftrace.h>
+#include <linux/kprobes.h>
 #include "trace.h"
 
 #define CREATE_TRACE_POINTS
@@ -30,6 +31,7 @@ void trace_hardirqs_on(void)
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_on);
+NOKPROBE_SYMBOL(trace_hardirqs_on);
 
 void trace_hardirqs_off(void)
 {
@@ -43,6 +45,7 @@ void trace_hardirqs_off(void)
 	lockdep_hardirqs_off(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
+NOKPROBE_SYMBOL(trace_hardirqs_off);
 
 __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
 {
@@ -56,6 +59,7 @@ __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_on_caller);
+NOKPROBE_SYMBOL(trace_hardirqs_on_caller);
 
 __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
 {
@@ -69,6 +73,7 @@ __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
 	lockdep_hardirqs_off(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_off_caller);
+NOKPROBE_SYMBOL(trace_hardirqs_off_caller);
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
 #ifdef CONFIG_TRACE_PREEMPT_TOGGLE
