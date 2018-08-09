Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952E7C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EA021EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42EA021EFC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeHIXdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727319AbeHIXdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:33:33 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E89E322392;
        Thu,  9 Aug 2018 21:06:55 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fns90-0001RU-NN; Thu, 09 Aug 2018 17:06:54 -0400
Message-Id: <20180809210654.622445925@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 09 Aug 2018 17:03:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        joel@joelfernandes.org, Joel Fernandes <joelaf@google.com>
Subject: [for-next][PATCH 3/6] tracing: More reverting of "tracing: Centralize preemptirq
 tracepoints and unify their usage"
References: <20180809210333.588854137@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Joel Fernandes created a nice patch that cleaned up the duplicate hooks used
by lockdep and irqsoff latency tracer. It made both use tracepoints. But the
latency tracer is triggering warnings when using tracepoints to call into
the latency tracer's routines. Mainly, they can be called from NMI context.
If that happens, then the SRCU may not work properly because on some
architectures, SRCU is not safe to be called in both NMI and non-NMI
context.

This is a partial revert of the clean up patch c3bc8fd637a9 ("tracing:
Centralize preemptirq tracepoints and unify their usage") that adds back the
direct calls into the latency tracer. It also only calls the trace events
when not in NMI.

Cc: Joel Fernandes <joelaf@google.com>
Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and unify their usage")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.h            | 15 +++++++++++
 kernel/trace/trace_irqsoff.c    | 48 +++------------------------------
 kernel/trace/trace_preemptirq.c | 25 ++++++++++++-----
 3 files changed, 38 insertions(+), 50 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d88cd9bb72f4..a62b678731e3 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1827,6 +1827,21 @@ static inline int tracing_alloc_snapshot_instance(struct trace_array *tr)
 }
 #endif
 
+#ifdef CONFIG_PREEMPT_TRACER
+void tracer_preempt_on(unsigned long a0, unsigned long a1);
+void tracer_preempt_off(unsigned long a0, unsigned long a1);
+#else
+static inline void tracer_preempt_on(unsigned long a0, unsigned long a1) { }
+static inline void tracer_preempt_off(unsigned long a0, unsigned long a1) { }
+#endif
+#ifdef CONFIG_IRQSOFF_TRACER
+void tracer_hardirqs_on(unsigned long a0, unsigned long a1);
+void tracer_hardirqs_off(unsigned long a0, unsigned long a1);
+#else
+static inline void tracer_hardirqs_on(unsigned long a0, unsigned long a1) { }
+static inline void tracer_hardirqs_off(unsigned long a0, unsigned long a1) { }
+#endif
+
 extern struct trace_iterator *tracepoint_print_iter;
 
 #endif /* _LINUX_KERNEL_TRACE_H */
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 4af990e9c594..94c1ba139b3b 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -605,40 +605,18 @@ static void irqsoff_tracer_stop(struct trace_array *tr)
 /*
  * We are only interested in hardirq on/off events:
  */
-static void tracer_hardirqs_on(void *none, unsigned long a0, unsigned long a1)
+void tracer_hardirqs_on(unsigned long a0, unsigned long a1)
 {
 	unsigned int pc = preempt_count();
 
-	/*
-	 * Tracepoint probes are expected to be called with preempt disabled,
-	 * We don't care about being called with preempt disabled but we need
-	 * to know in the future if that changes so we can remove the next
-	 * preempt_enable.
-	 */
-	WARN_ON_ONCE(pc < PREEMPT_DISABLE_OFFSET);
-
-	/* Use PREEMPT_DISABLE_OFFSET to handle !CONFIG_PREEMPT cases */
-	pc -= PREEMPT_DISABLE_OFFSET;
-
 	if (!preempt_trace(pc) && irq_trace())
 		stop_critical_timing(a0, a1, pc);
 }
 
-static void tracer_hardirqs_off(void *none, unsigned long a0, unsigned long a1)
+void tracer_hardirqs_off(unsigned long a0, unsigned long a1)
 {
 	unsigned int pc = preempt_count();
 
-	/*
-	 * Tracepoint probes are expected to be called with preempt disabled,
-	 * We don't care about being called with preempt disabled but we need
-	 * to know in the future if that changes so we can remove the next
-	 * preempt_enable.
-	 */
-	WARN_ON_ONCE(pc < PREEMPT_DISABLE_OFFSET);
-
-	/* Use PREEMPT_DISABLE_OFFSET to handle !CONFIG_PREEMPT cases */
-	pc -= PREEMPT_DISABLE_OFFSET;
-
 	if (!preempt_trace(pc) && irq_trace())
 		start_critical_timing(a0, a1, pc);
 }
@@ -647,15 +625,11 @@ static int irqsoff_tracer_init(struct trace_array *tr)
 {
 	trace_type = TRACER_IRQS_OFF;
 
-	register_trace_irq_disable(tracer_hardirqs_off, NULL);
-	register_trace_irq_enable(tracer_hardirqs_on, NULL);
 	return __irqsoff_tracer_init(tr);
 }
 
 static void irqsoff_tracer_reset(struct trace_array *tr)
 {
-	unregister_trace_irq_disable(tracer_hardirqs_off, NULL);
-	unregister_trace_irq_enable(tracer_hardirqs_on, NULL);
 	__irqsoff_tracer_reset(tr);
 }
 
@@ -681,7 +655,7 @@ static struct tracer irqsoff_tracer __read_mostly =
 #endif /*  CONFIG_IRQSOFF_TRACER */
 
 #ifdef CONFIG_PREEMPT_TRACER
-static void tracer_preempt_on(void *none, unsigned long a0, unsigned long a1)
+void tracer_preempt_on(unsigned long a0, unsigned long a1)
 {
 	int pc = preempt_count();
 
@@ -689,7 +663,7 @@ static void tracer_preempt_on(void *none, unsigned long a0, unsigned long a1)
 		stop_critical_timing(a0, a1, pc);
 }
 
-static void tracer_preempt_off(void *none, unsigned long a0, unsigned long a1)
+void tracer_preempt_off(unsigned long a0, unsigned long a1)
 {
 	int pc = preempt_count();
 
@@ -701,15 +675,11 @@ static int preemptoff_tracer_init(struct trace_array *tr)
 {
 	trace_type = TRACER_PREEMPT_OFF;
 
-	register_trace_preempt_disable(tracer_preempt_off, NULL);
-	register_trace_preempt_enable(tracer_preempt_on, NULL);
 	return __irqsoff_tracer_init(tr);
 }
 
 static void preemptoff_tracer_reset(struct trace_array *tr)
 {
-	unregister_trace_preempt_disable(tracer_preempt_off, NULL);
-	unregister_trace_preempt_enable(tracer_preempt_on, NULL);
 	__irqsoff_tracer_reset(tr);
 }
 
@@ -740,21 +710,11 @@ static int preemptirqsoff_tracer_init(struct trace_array *tr)
 {
 	trace_type = TRACER_IRQS_OFF | TRACER_PREEMPT_OFF;
 
-	register_trace_irq_disable(tracer_hardirqs_off, NULL);
-	register_trace_irq_enable(tracer_hardirqs_on, NULL);
-	register_trace_preempt_disable(tracer_preempt_off, NULL);
-	register_trace_preempt_enable(tracer_preempt_on, NULL);
-
 	return __irqsoff_tracer_init(tr);
 }
 
 static void preemptirqsoff_tracer_reset(struct trace_array *tr)
 {
-	unregister_trace_irq_disable(tracer_hardirqs_off, NULL);
-	unregister_trace_irq_enable(tracer_hardirqs_on, NULL);
-	unregister_trace_preempt_disable(tracer_preempt_off, NULL);
-	unregister_trace_preempt_enable(tracer_preempt_on, NULL);
-
 	__irqsoff_tracer_reset(tr);
 }
 
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index fa656b25f427..71f553cceb3c 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -9,6 +9,7 @@
 #include <linux/uaccess.h>
 #include <linux/module.h>
 #include <linux/ftrace.h>
+#include "trace.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/preemptirq.h>
@@ -20,7 +21,9 @@ static DEFINE_PER_CPU(int, tracing_irq_cpu);
 void trace_hardirqs_on(void)
 {
 	if (this_cpu_read(tracing_irq_cpu)) {
-		trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+		if (!in_nmi())
+			trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
 
@@ -32,7 +35,9 @@ void trace_hardirqs_off(void)
 {
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
-		trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
+		if (!in_nmi())
+			trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
 	}
 
 	lockdep_hardirqs_off(CALLER_ADDR0);
@@ -42,7 +47,9 @@ EXPORT_SYMBOL(trace_hardirqs_off);
 __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
 {
 	if (this_cpu_read(tracing_irq_cpu)) {
-		trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
+		if (!in_nmi())
+			trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
+		tracer_hardirqs_on(CALLER_ADDR0, caller_addr);
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
 
@@ -54,7 +61,9 @@ __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
 {
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
-		trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
+		tracer_hardirqs_off(CALLER_ADDR0, caller_addr);
+		if (!in_nmi())
+			trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
 	}
 
 	lockdep_hardirqs_off(CALLER_ADDR0);
@@ -66,11 +75,15 @@ EXPORT_SYMBOL(trace_hardirqs_off_caller);
 
 void trace_preempt_on(unsigned long a0, unsigned long a1)
 {
-	trace_preempt_enable_rcuidle(a0, a1);
+	if (!in_nmi())
+		trace_preempt_enable_rcuidle(a0, a1);
+	tracer_preempt_on(a0, a1);
 }
 
 void trace_preempt_off(unsigned long a0, unsigned long a1)
 {
-	trace_preempt_disable_rcuidle(a0, a1);
+	if (!in_nmi())
+		trace_preempt_disable_rcuidle(a0, a1);
+	tracer_preempt_off(a0, a1);
 }
 #endif
-- 
2.18.0


