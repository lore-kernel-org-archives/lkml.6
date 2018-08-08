Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E084AC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6182152B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="beZG179h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6182152B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbeHIAWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:22:31 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45946 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHIAWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:22:31 -0400
Received: by mail-qt0-f195.google.com with SMTP id y5-v6so4296528qti.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 15:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OgjEYPnoPMaoZ5a1DCCQehUkVupohp9lqzarB+QDvn4=;
        b=beZG179hyyMcXFXHIAdaw9zAoEC+EvWC4qtixjnqINHEMSI5Jk4hAtyhvnWe5DOFhW
         bdCmIU0cQ+ASUu0yWhSnLAs8vxtf8cvSbKB1YPkzBTdEBSsHpGcnho47UDahg4749j2L
         Vbzo7QFF/4VQ1ExP9Q86QCUu+FiOrAotpwq+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OgjEYPnoPMaoZ5a1DCCQehUkVupohp9lqzarB+QDvn4=;
        b=kNqya0+Ub7JWhRGcGYogylDu5F6pLEj2MEzcxdNGhUehSgYvzTF3D4g6tRgWXDPkRp
         ZxNEsSvFzYoz9Tup95XpasOLQPGjrbtG6jOXFPAdFbvTFfiSX67aQny6tX7lcwigBn6H
         FPpb2VHVHEI+3euAXfNwmzoe+iAr2CCI5/BUS8R1cT8Ayy4FqF99YscyAyGB6Wyn93AH
         u5OYLsD3hBoywAifZMfG8VljEeSkjJILLE6QoKSAGAgCvpuY0ZXZCFHebqeUpPUgQO5D
         la43nahzbThlSZpiRVERtmkHLabUFiVCRpLYtlPRqqpZWBYavuC+Rnsvy1dlQOUux6Ob
         6c4Q==
X-Gm-Message-State: AOUpUlEsNTTGd2+coeCDPt5O/PZHXwrN5wqcyPoI4coC2z9SOPrrXQf4
        fuen8GizpXzkX45VLKp4aHl7i6fNt2Y=
X-Google-Smtp-Source: AA+uWPwdN7c4+pS6ewx5icGvGbhy04MZwxzW7FhP4go5oJTLZGEl+p4GB/osOEq9Y8oh/mZE1dTI3Q==
X-Received: by 2002:a0c:8c05:: with SMTP id n5-v6mr4174633qvb.185.1533765652445;
        Wed, 08 Aug 2018 15:00:52 -0700 (PDT)
Received: from joelaf-glaptop0.roam.corp.google.com ([2601:5c2:201:936::a37e])
        by smtp.gmail.com with ESMTPSA id v41-v6sm3316752qtk.70.2018.08.08.15.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 15:00:51 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>, paulmck@linux.vnet.ibm.com,
        mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
        namhyung@kernel.org, byungchul.park@lge.com
Subject: [PATCH RFC ftrace/core] tracing: Directly call tracer and lockdep probes
Date:   Wed,  8 Aug 2018 15:00:22 -0700
Message-Id: <20180808220022.65184-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

Due to various problems with using tracepoints as probes for IRQ
enable/disable and preempt enable/disable: such as using SRCU in NMI
context and other issues with the irqsoff/preemptoff tracer, directly
call the lockdep and irqsoff tracer probes for now. This keeps all the
other benefits and clean ups of the patch being partially reverted.

Based on Steve's original Partial revert patch. I added directly calling
irqsoff tracer probes as well.

Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and unify their usage")
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
Steve, I expanded your partial revert such that it fixes the remaining
issues as well while keeping the clean ups and benefits of my original
patch. Its based on the latest ftrace/core. I'm still testing it, but it
works so far. What do you think?  I feel like it could still be a step
forward for this merge window.
Also you could drop "tracepoint: Make rcuidle tracepoint callers use
SRCU" since its not needed anymore for this merge window.

Tests passing so far:
- ftrace startup tests
- locking api self-tests
- manually tested preemptoff and irqsoff tracers
- manually tested preempt/irq disable and enable events
- boot tested without warnings

 include/linux/irqflags.h        |  4 ++
 include/linux/lockdep.h         |  2 -
 init/main.c                     |  2 -
 kernel/locking/lockdep.c        | 14 +------
 kernel/trace/trace.h            | 16 ++++++++
 kernel/trace/trace_irqsoff.c    | 26 ++-----------
 kernel/trace/trace_preemptirq.c | 66 ++++++++++++++++++++++++---------
 7 files changed, 75 insertions(+), 55 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 50edb9cbbd26..19a90ac7c87d 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -19,9 +19,13 @@
 #ifdef CONFIG_PROVE_LOCKING
   extern void trace_softirqs_on(unsigned long ip);
   extern void trace_softirqs_off(unsigned long ip);
+  extern void lockdep_hardirqs_on(unsigned long ip);
+  extern void lockdep_hardirqs_off(unsigned long ip);
 #else
 # define trace_softirqs_on(ip)	do { } while (0)
 # define trace_softirqs_off(ip)	do { } while (0)
+# define lockdep_hardirqs_on(ip) do { } while (0)
+# define lockdep_hardirqs_off(ip) do { } while (0)
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
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index e1c8a1d6f240..74db16fe1fab 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1829,4 +1829,20 @@ static inline int tracing_alloc_snapshot_instance(struct trace_array *tr)
 
 extern struct trace_iterator *tracepoint_print_iter;
 
+#ifdef CONFIG_IRQSOFF_TRACER
+void tracer_hardirqs_on(void *none, unsigned long a0, unsigned long a1);
+void tracer_hardirqs_off(void *none, unsigned long a0, unsigned long a1);
+#else
+void tracer_hardirqs_on(void *none, unsigned long a0, unsigned long a1) { }
+void tracer_hardirqs_off(void *none, unsigned long a0, unsigned long a1) { }
+#endif
+
+#ifdef CONFIG_PREEMPT_TRACER
+void tracer_preempt_on(void *none, unsigned long a0, unsigned long a1);
+void tracer_preempt_off(void *none, unsigned long a0, unsigned long a1);
+#else
+void tracer_preempt_on(void *none, unsigned long a0, unsigned long a1) { }
+void tracer_preempt_off(void *none, unsigned long a0, unsigned long a1) { }
+#endif
+
 #endif /* _LINUX_KERNEL_TRACE_H */
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 770cd30cda40..d61d42e431e9 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -601,13 +601,13 @@ static void irqsoff_tracer_stop(struct trace_array *tr)
 /*
  * We are only interested in hardirq on/off events:
  */
-static void tracer_hardirqs_on(void *none, unsigned long a0, unsigned long a1)
+void tracer_hardirqs_on(void *none, unsigned long a0, unsigned long a1)
 {
 	if (!preempt_trace() && irq_trace())
 		stop_critical_timing(a0, a1);
 }
 
-static void tracer_hardirqs_off(void *none, unsigned long a0, unsigned long a1)
+void tracer_hardirqs_off(void *none, unsigned long a0, unsigned long a1)
 {
 	if (!preempt_trace() && irq_trace())
 		start_critical_timing(a0, a1);
@@ -617,15 +617,11 @@ static int irqsoff_tracer_init(struct trace_array *tr)
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
 
@@ -651,13 +647,13 @@ static struct tracer irqsoff_tracer __read_mostly =
 #endif /*  CONFIG_IRQSOFF_TRACER */
 
 #ifdef CONFIG_PREEMPT_TRACER
-static void tracer_preempt_on(void *none, unsigned long a0, unsigned long a1)
+void tracer_preempt_on(void *none, unsigned long a0, unsigned long a1)
 {
 	if (preempt_trace() && !irq_trace())
 		stop_critical_timing(a0, a1);
 }
 
-static void tracer_preempt_off(void *none, unsigned long a0, unsigned long a1)
+void tracer_preempt_off(void *none, unsigned long a0, unsigned long a1)
 {
 	if (preempt_trace() && !irq_trace())
 		start_critical_timing(a0, a1);
@@ -667,15 +663,11 @@ static int preemptoff_tracer_init(struct trace_array *tr)
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
 
@@ -706,21 +698,11 @@ static int preemptirqsoff_tracer_init(struct trace_array *tr)
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
index e76b78bf258e..bd5654e9f886 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -9,6 +9,7 @@
 #include <linux/uaccess.h>
 #include <linux/module.h>
 #include <linux/ftrace.h>
+#include "trace.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/preemptirq.h>
@@ -19,54 +20,85 @@ static DEFINE_PER_CPU(int, tracing_irq_cpu);
 
 void trace_hardirqs_on(void)
 {
-	if (!this_cpu_read(tracing_irq_cpu))
-		return;
+	if (this_cpu_read(tracing_irq_cpu)) {
+		trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
 
-	trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
-	this_cpu_write(tracing_irq_cpu, 0);
+		/* irqsoff tracer */
+		tracer_hardirqs_on(NULL /* unused */, CALLER_ADDR0, CALLER_ADDR1);
+
+		this_cpu_write(tracing_irq_cpu, 0);
+	}
+
+	/* Call last so future IRQ state is noted last */
+	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_on);
 
 void trace_hardirqs_off(void)
 {
-	if (this_cpu_read(tracing_irq_cpu))
-		return;
+	/* Call first so IRQ state is updated */
+	lockdep_hardirqs_off(CALLER_ADDR0);
+
+	if (!this_cpu_read(tracing_irq_cpu)) {
+		/* prevent recursion */
+		this_cpu_write(tracing_irq_cpu, 1);
 
-	this_cpu_write(tracing_irq_cpu, 1);
-	trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+		trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+
+		/* irqsoff tracer */
+		tracer_hardirqs_off(NULL /* unused */, CALLER_ADDR0, CALLER_ADDR1);
+	}
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
 
 __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
 {
-	if (!this_cpu_read(tracing_irq_cpu))
-		return;
+	if (this_cpu_read(tracing_irq_cpu)) {
+		trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
+
+		/* irqsoff tracer */
+		tracer_hardirqs_on(NULL /* unused */, CALLER_ADDR0, caller_addr);
+
+		this_cpu_write(tracing_irq_cpu, 0);
+	}
 
-	trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
-	this_cpu_write(tracing_irq_cpu, 0);
+	/* Call last so future IRQ state is noted last */
+	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_on_caller);
 
 __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
 {
-	if (this_cpu_read(tracing_irq_cpu))
-		return;
+	/* Call first so IRQ state is updated */
+	lockdep_hardirqs_off(CALLER_ADDR0);
 
-	this_cpu_write(tracing_irq_cpu, 1);
-	trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
+	if (!this_cpu_read(tracing_irq_cpu)) {
+		/* prevent recursion */
+		this_cpu_write(tracing_irq_cpu, 1);
+
+		trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+
+		/* irqsoff tracer */
+		tracer_hardirqs_off(NULL /* unused */, CALLER_ADDR0, CALLER_ADDR1);
+	}
 }
 EXPORT_SYMBOL(trace_hardirqs_off_caller);
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
 #ifdef CONFIG_TRACE_PREEMPT_TOGGLE
-
 void trace_preempt_on(unsigned long a0, unsigned long a1)
 {
 	trace_preempt_enable_rcuidle(a0, a1);
+
+	/* preemptoff tracer */
+	tracer_preempt_on(NULL /* unused */, a0, a1);
 }
 
 void trace_preempt_off(unsigned long a0, unsigned long a1)
 {
 	trace_preempt_disable_rcuidle(a0, a1);
+
+	/* preemptoff tracer */
+	tracer_preempt_off(NULL /* unused */, a0, a1);
 }
 #endif
-- 
2.18.0.597.ga71716f1ad-goog

