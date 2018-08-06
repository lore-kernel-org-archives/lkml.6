Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E24C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEF721A68
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FEF721A68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387521AbeHFWBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 18:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727585AbeHFWBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 18:01:39 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D037721A65;
        Mon,  6 Aug 2018 19:50:59 +0000 (UTC)
Date:   Mon, 6 Aug 2018 15:50:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v12 3/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
Message-ID: <20180806155058.5ee875f4@gandalf.local.home>
In-Reply-To: <20180730222423.196630-4-joel@joelfernandes.org>
References: <20180730222423.196630-1-joel@joelfernandes.org>
        <20180730222423.196630-4-joel@joelfernandes.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


With this patch applied, I'm constantly getting lockdep errors. Instead
of doing a full revert of the patch, I did this, which makes all those
errors go away. I may apply this for now, and we can revisit having
lockdep use the tracepoint code. But since it's currently always
enabled, I'm thinking of just leaving this as is. The macros are still
clean from Joel's patch.

Thoughts?

-- Steve

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 50edb9cbbd26..a93476c6c954 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -19,6 +19,8 @@
 #ifdef CONFIG_PROVE_LOCKING
   extern void trace_softirqs_on(unsigned long ip);
   extern void trace_softirqs_off(unsigned long ip);
+  extern void lockdep_hardirqs_on(unsigned long ip);
+  extern void lockdep_hardirqs_off(unsigned long ip);
 #else
 # define trace_softirqs_on(ip)	do { } while (0)
 # define trace_softirqs_off(ip)	do { } while (0)
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index a8113357ceeb..30d0eb857f2e 100644
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
index e76b78bf258e..8326adcab0dc 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -20,40 +20,52 @@ static DEFINE_PER_CPU(int, tracing_irq_cpu);
 void trace_hardirqs_on(void)
 {
 	if (!this_cpu_read(tracing_irq_cpu))
-		return;
+		goto out;
 
 	trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
 	this_cpu_write(tracing_irq_cpu, 0);
+
+ out:
+	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_on);
 
 void trace_hardirqs_off(void)
 {
 	if (this_cpu_read(tracing_irq_cpu))
-		return;
+		goto out;
 
 	this_cpu_write(tracing_irq_cpu, 1);
 	trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+
+ out:
+	lockdep_hardirqs_off(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
 
 __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
 {
 	if (!this_cpu_read(tracing_irq_cpu))
-		return;
+		goto out;
 
 	trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
 	this_cpu_write(tracing_irq_cpu, 0);
+
+ out:
+	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_on_caller);
 
 __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
 {
 	if (this_cpu_read(tracing_irq_cpu))
-		return;
+		goto out;
 
 	this_cpu_write(tracing_irq_cpu, 1);
 	trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
+
+ out:
+	lockdep_hardirqs_off(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_off_caller);
 #endif /* CONFIG_TRACE_IRQFLAGS */
