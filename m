Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63A5C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4CB21EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4CB21EFC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeHIXdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbeHIXdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:33:31 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6273121F45;
        Thu,  9 Aug 2018 21:06:55 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fns90-0001QG-EM; Thu, 09 Aug 2018 17:06:54 -0400
Message-Id: <20180809210654.346880034@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 09 Aug 2018 17:03:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        joel@joelfernandes.org, Joel Fernandes <joelaf@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [for-next][PATCH 1/6] tracing: Partial revert of "tracing: Centralize preemptirq
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
by lockdep and irqsoff latency tracer. It made both use tracepoints. But it
caused lockdep to trigger several false positives. We have not figured out
why yet, but removing lockdep from using the trace event hooks and just call
its helper functions directly (like it use to), makes the problem go away.

This is a partial revert of the clean up patch c3bc8fd637a9 ("tracing:
Centralize preemptirq tracepoints and unify their usage") that adds direct
calls for lockdep, but also keeps most of the clean up done to get rid of
the horrible preprocessor if statements.

Link: http://lkml.kernel.org/r/20180806155058.5ee875f4@gandalf.local.home

Cc: Joel Fernandes <joelaf@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and unify their usage")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/irqflags.h        |  8 ++++++--
 include/linux/lockdep.h         |  2 --
 init/main.c                     |  2 --
 kernel/locking/lockdep.c        | 14 ++-----------
 kernel/trace/trace_preemptirq.c | 36 ++++++++++++++++++---------------
 5 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 50edb9cbbd26..21619c92c377 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -19,9 +19,13 @@
 #ifdef CONFIG_PROVE_LOCKING
   extern void trace_softirqs_on(unsigned long ip);
   extern void trace_softirqs_off(unsigned long ip);
+  extern void lockdep_hardirqs_on(unsigned long ip);
+  extern void lockdep_hardirqs_off(unsigned long ip);
 #else
-# define trace_softirqs_on(ip)	do { } while (0)
-# define trace_softirqs_off(ip)	do { } while (0)
+  static inline void trace_softirqs_on(unsigned long ip) { }
+  static inline void trace_softirqs_off(unsigned long ip) { }
+  static inline void lockdep_hardirqs_on(unsigned long ip) { }
+  static inline void lockdep_hardirqs_off(unsigned long ip) { }
 #endif
 
 #ifdef CONFIG_TRACE_IRQFLAGS
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index a8113357ceeb..b0d0b51c4d85 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -267,7 +267,6 @@ struct held_lock {
  * Initialization, self-test and debugging-output methods:
  */
 extern void lockdep_init(void);
-extern void lockdep_init_early(void);
 extern void lockdep_reset(void);
 extern void lockdep_reset_lock(struct lockdep_map *lock);
 extern void lockdep_free_key_range(void *start, unsigned long size);
@@ -408,7 +407,6 @@ static inline void lockdep_on(void)
 # define lock_set_class(l, n, k, s, i)		do { } while (0)
 # define lock_set_subclass(l, s, i)		do { } while (0)
 # define lockdep_init()				do { } while (0)
-# define lockdep_init_early()			do { } while (0)
 # define lockdep_init_map(lock, name, key, sub) \
 		do { (void)(name); (void)(key); } while (0)
 # define lockdep_set_class(lock, key)		do { (void)(key); } while (0)
diff --git a/init/main.c b/init/main.c
index 44fe43be84c1..5d42e577643a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -649,8 +649,6 @@ asmlinkage __visible void __init start_kernel(void)
 	call_function_init();
 	WARN(!irqs_disabled(), "Interrupts were enabled early\n");
 
-	lockdep_init_early();
-
 	early_boot_irqs_disabled = false;
 	local_irq_enable();
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 03bfaeb9f4e6..e406c5fdb41e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2840,8 +2840,7 @@ static void __trace_hardirqs_on_caller(unsigned long ip)
 	debug_atomic_inc(hardirqs_on_events);
 }
 
-static void lockdep_hardirqs_on(void *none, unsigned long ignore,
-				unsigned long ip)
+void lockdep_hardirqs_on(unsigned long ip)
 {
 	if (unlikely(!debug_locks || current->lockdep_recursion))
 		return;
@@ -2885,8 +2884,7 @@ static void lockdep_hardirqs_on(void *none, unsigned long ignore,
 /*
  * Hardirqs were disabled:
  */
-static void lockdep_hardirqs_off(void *none, unsigned long ignore,
-				 unsigned long ip)
+void lockdep_hardirqs_off(unsigned long ip)
 {
 	struct task_struct *curr = current;
 
@@ -4315,14 +4313,6 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 	raw_local_irq_restore(flags);
 }
 
-void __init lockdep_init_early(void)
-{
-#ifdef CONFIG_PROVE_LOCKING
-	register_trace_prio_irq_disable(lockdep_hardirqs_off, NULL, INT_MAX);
-	register_trace_prio_irq_enable(lockdep_hardirqs_on, NULL, INT_MIN);
-#endif
-}
-
 void __init lockdep_init(void)
 {
 	printk("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index e76b78bf258e..fa656b25f427 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -19,41 +19,45 @@ static DEFINE_PER_CPU(int, tracing_irq_cpu);
 
 void trace_hardirqs_on(void)
 {
-	if (!this_cpu_read(tracing_irq_cpu))
-		return;
+	if (this_cpu_read(tracing_irq_cpu)) {
+		trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+		this_cpu_write(tracing_irq_cpu, 0);
+	}
 
-	trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
-	this_cpu_write(tracing_irq_cpu, 0);
+	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_on);
 
 void trace_hardirqs_off(void)
 {
-	if (this_cpu_read(tracing_irq_cpu))
-		return;
+	if (!this_cpu_read(tracing_irq_cpu)) {
+		this_cpu_write(tracing_irq_cpu, 1);
+		trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+	}
 
-	this_cpu_write(tracing_irq_cpu, 1);
-	trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+	lockdep_hardirqs_off(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
 
 __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
 {
-	if (!this_cpu_read(tracing_irq_cpu))
-		return;
+	if (this_cpu_read(tracing_irq_cpu)) {
+		trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
+		this_cpu_write(tracing_irq_cpu, 0);
+	}
 
-	trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
-	this_cpu_write(tracing_irq_cpu, 0);
+	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_on_caller);
 
 __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
 {
-	if (this_cpu_read(tracing_irq_cpu))
-		return;
+	if (!this_cpu_read(tracing_irq_cpu)) {
+		this_cpu_write(tracing_irq_cpu, 1);
+		trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
+	}
 
-	this_cpu_write(tracing_irq_cpu, 1);
-	trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
+	lockdep_hardirqs_off(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_off_caller);
 #endif /* CONFIG_TRACE_IRQFLAGS */
-- 
2.18.0


