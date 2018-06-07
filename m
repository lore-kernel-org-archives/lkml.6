Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 53D1ANgnGVvZeQAAmS7hNA
	; Thu, 07 Jun 2018 12:42:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6BC5C608B8; Thu,  7 Jun 2018 12:42:04 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BMg4Hole"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E3F05608BA;
	Thu,  7 Jun 2018 12:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3F05608BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932608AbeFGMmA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:42:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58644 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932456AbeFGMlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vIQxvZ0GDXfFvUMtCJi60k3PGv1WvQ6ekOw1uRqJG7w=; b=BMg4Hole6WsIscbx4zbrf1VOY7
        7smlh2NOSLkADS6H893mEC1+F+7PHWe022KK0+hwPX/xrWUXlnYtPEws/vqPj+cMZO+ltFheGu8cc
        y5hr/g/x1meDCA9mIDCUw/KtGfBwRcZcn34NxnI/cr4Jyw+VtOYJ7Y8n2kQ/CRuxTDji5W6pIcZVB
        IvM7YOWnjur4o294Qn0RTsfwY2Uv1c6xEeYBRbCCH6B0VgW7DzTOm1stUrqlEu4ZCLQjMU9131BLL
        cNG20ZVWK4Piav8SblzDDaAWOkfEcSr1D4aCGMGUCDH0DQEDV1vTKhoyEHDOiL6wtdVKJNoWiFsHf
        +PF55ahw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQuEI-0001Xc-Ry; Thu, 07 Jun 2018 12:41:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9C4A1201EA7A9; Thu,  7 Jun 2018 14:41:18 +0200 (CEST)
Message-Id: <20180607124006.158330973@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 07 Jun 2018 14:33:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, oleg@redhat.com, gkohli@codeaurora.org
Cc: tglx@linutronix.de, mpe@ellerman.id.au, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 2/4] watchdog/softlockup: Replace "watchdog/%u" threads with cpu_stop_work
References: <20180607123310.866085998@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-kthread-1.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg suggested to replace the "watchdog/%u" threads with
cpu_stop_work. That removes one thread per cpu while at the same time
fixes softlockup vs SCHED_DEADLINE.

But more importantly, it does away with the single
smpboot_update_cpumask_percpu_thread() user, which allows
cleanups/shrinkage of the smpboot interface.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/cpuhotplug.h |    1 
 include/linux/nmi.h        |    5 +
 kernel/cpu.c               |    5 +
 kernel/watchdog.c          |  132 +++++++++++++++++++--------------------------
 4 files changed, 67 insertions(+), 76 deletions(-)

--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -164,6 +164,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
+	CPUHP_AP_WATCHDOG_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -33,10 +33,15 @@ extern int sysctl_hardlockup_all_cpu_bac
 #define sysctl_hardlockup_all_cpu_backtrace 0
 #endif /* !CONFIG_SMP */
 
+extern int lockup_detector_online_cpu(unsigned int cpu);
+extern int lockup_detector_offline_cpu(unsigned int cpu);
+
 #else /* CONFIG_LOCKUP_DETECTOR */
 static inline void lockup_detector_init(void) { }
 static inline void lockup_detector_soft_poweroff(void) { }
 static inline void lockup_detector_cleanup(void) { }
+#define lockup_detector_online_cpu	NULL
+#define lockup_detector_offline_cpu	NULL
 #endif /* !CONFIG_LOCKUP_DETECTOR */
 
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1344,6 +1344,11 @@ static struct cpuhp_step cpuhp_hp_states
 		.startup.single		= perf_event_init_cpu,
 		.teardown.single	= perf_event_exit_cpu,
 	},
+	[CPUHP_AP_WATCHDOG_ONLINE] = {
+		.name			= "lockup_detector:online",
+		.startup.single		= lockup_detector_online_cpu,
+		.teardown.single	= lockup_detector_offline_cpu,
+	},
 	[CPUHP_AP_WORKQUEUE_ONLINE] = {
 		.name			= "workqueue:online",
 		.startup.single		= workqueue_online_cpu,
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -18,18 +18,14 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/sysctl.h>
-#include <linux/smpboot.h>
-#include <linux/sched/rt.h>
-#include <uapi/linux/sched/types.h>
 #include <linux/tick.h>
-#include <linux/workqueue.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/isolation.h>
+#include <linux/stop_machine.h>
 
 #include <asm/irq_regs.h>
 #include <linux/kvm_para.h>
-#include <linux/kthread.h>
 
 static DEFINE_MUTEX(watchdog_mutex);
 
@@ -173,7 +169,6 @@ static bool softlockup_threads_initializ
 static u64 __read_mostly sample_period;
 
 static DEFINE_PER_CPU(unsigned long, watchdog_touch_ts);
-static DEFINE_PER_CPU(struct task_struct *, softlockup_watchdog);
 static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer);
 static DEFINE_PER_CPU(bool, softlockup_touch_sync);
 static DEFINE_PER_CPU(bool, soft_watchdog_warn);
@@ -335,6 +330,25 @@ static void watchdog_interrupt_count(voi
 	__this_cpu_inc(hrtimer_interrupts);
 }
 
+/*
+ * The watchdog thread function - touches the timestamp.
+ *
+ * It only runs once every sample_period seconds (4 seconds by
+ * default) to reset the softlockup timestamp. If this gets delayed
+ * for more than 2*watchdog_thresh seconds then the debug-printout
+ * triggers in watchdog_timer_fn().
+ */
+static int softlockup_fn(void *data)
+{
+	__this_cpu_write(soft_lockup_hrtimer_cnt,
+			 __this_cpu_read(hrtimer_interrupts));
+	__touch_watchdog();
+
+	return 0;
+}
+
+static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
+
 /* watchdog kicker functions */
 static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 {
@@ -350,7 +364,9 @@ static enum hrtimer_restart watchdog_tim
 	watchdog_interrupt_count();
 
 	/* kick the softlockup detector */
-	wake_up_process(__this_cpu_read(softlockup_watchdog));
+	stop_one_cpu_nowait(smp_processor_id(),
+			softlockup_fn, NULL,
+			this_cpu_ptr(&softlockup_stop_work));
 
 	/* .. and repeat */
 	hrtimer_forward_now(hrtimer, ns_to_ktime(sample_period));
@@ -448,17 +464,12 @@ static enum hrtimer_restart watchdog_tim
 	return HRTIMER_RESTART;
 }
 
-static void watchdog_set_prio(unsigned int policy, unsigned int prio)
-{
-	struct sched_param param = { .sched_priority = prio };
-
-	sched_setscheduler(current, policy, &param);
-}
-
 static void watchdog_enable(unsigned int cpu)
 {
 	struct hrtimer *hrtimer = this_cpu_ptr(&watchdog_hrtimer);
 
+	WARN_ON_ONCE(cpu != smp_processor_id());
+
 	/*
 	 * Start the timer first to prevent the NMI watchdog triggering
 	 * before the timer has a chance to fire.
@@ -466,22 +477,21 @@ static void watchdog_enable(unsigned int
 	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	hrtimer->function = watchdog_timer_fn;
 	hrtimer_start(hrtimer, ns_to_ktime(sample_period),
-		      HRTIMER_MODE_REL_PINNED);
+			HRTIMER_MODE_REL_PINNED);
 
 	/* Initialize timestamp */
 	__touch_watchdog();
 	/* Enable the perf event */
 	if (watchdog_enabled & NMI_WATCHDOG_ENABLED)
 		watchdog_nmi_enable(cpu);
-
-	watchdog_set_prio(SCHED_FIFO, MAX_RT_PRIO - 1);
 }
 
 static void watchdog_disable(unsigned int cpu)
 {
 	struct hrtimer *hrtimer = this_cpu_ptr(&watchdog_hrtimer);
 
-	watchdog_set_prio(SCHED_NORMAL, 0);
+	WARN_ON_ONCE(cpu != smp_processor_id());
+
 	/*
 	 * Disable the perf event first. That prevents that a large delay
 	 * between disabling the timer and disabling the perf event causes
@@ -491,77 +501,60 @@ static void watchdog_disable(unsigned in
 	hrtimer_cancel(hrtimer);
 }
 
-static void watchdog_cleanup(unsigned int cpu, bool online)
+static int softlockup_stop_fn(void *data)
 {
-	watchdog_disable(cpu);
+	watchdog_disable(smp_processor_id());
+	return 0;
 }
 
-static int watchdog_should_run(unsigned int cpu)
+static void softlockup_stop_all(void)
 {
-	return __this_cpu_read(hrtimer_interrupts) !=
-		__this_cpu_read(soft_lockup_hrtimer_cnt);
+	int cpu;
+
+	for_each_cpu(cpu, &watchdog_allowed_mask)
+		stop_one_cpu(cpu, softlockup_stop_fn, NULL);
+
+	cpumask_clear(&watchdog_allowed_mask);
 }
 
-/*
- * The watchdog thread function - touches the timestamp.
- *
- * It only runs once every sample_period seconds (4 seconds by
- * default) to reset the softlockup timestamp. If this gets delayed
- * for more than 2*watchdog_thresh seconds then the debug-printout
- * triggers in watchdog_timer_fn().
- */
-static void watchdog(unsigned int cpu)
+static int softlockup_start_fn(void *data)
 {
-	__this_cpu_write(soft_lockup_hrtimer_cnt,
-			 __this_cpu_read(hrtimer_interrupts));
-	__touch_watchdog();
+	watchdog_enable(smp_processor_id());
+	return 0;
 }
 
-static struct smp_hotplug_thread watchdog_threads = {
-	.store			= &softlockup_watchdog,
-	.thread_should_run	= watchdog_should_run,
-	.thread_fn		= watchdog,
-	.thread_comm		= "watchdog/%u",
-	.setup			= watchdog_enable,
-	.cleanup		= watchdog_cleanup,
-	.park			= watchdog_disable,
-	.unpark			= watchdog_enable,
-};
-
-static void softlockup_update_smpboot_threads(void)
+static void softlockup_start_all(void)
 {
-	lockdep_assert_held(&watchdog_mutex);
-
-	if (!softlockup_threads_initialized)
-		return;
+	int cpu;
 
-	smpboot_update_cpumask_percpu_thread(&watchdog_threads,
-					     &watchdog_allowed_mask);
+	cpumask_copy(&watchdog_allowed_mask, &watchdog_cpumask);
+	for_each_cpu(cpu, &watchdog_allowed_mask)
+		stop_one_cpu(cpu, softlockup_start_fn, NULL);
 }
 
-/* Temporarily park all watchdog threads */
-static void softlockup_park_all_threads(void)
+int lockup_detector_online_cpu(unsigned int cpu)
 {
-	cpumask_clear(&watchdog_allowed_mask);
-	softlockup_update_smpboot_threads();
+	watchdog_enable(cpu);
+	return 0;
 }
 
-/* Unpark enabled threads */
-static void softlockup_unpark_threads(void)
+int lockup_detector_offline_cpu(unsigned int cpu)
 {
-	cpumask_copy(&watchdog_allowed_mask, &watchdog_cpumask);
-	softlockup_update_smpboot_threads();
+	watchdog_disable(cpu);
+	return 0;
 }
 
 static void lockup_detector_reconfigure(void)
 {
 	cpus_read_lock();
 	watchdog_nmi_stop();
-	softlockup_park_all_threads();
+
+	softlockup_stop_all();
 	set_sample_period();
 	lockup_detector_update_enable();
 	if (watchdog_enabled && watchdog_thresh)
-		softlockup_unpark_threads();
+		softlockup_start_all();
+
 	watchdog_nmi_start();
 	cpus_read_unlock();
 	/*
@@ -580,8 +573,6 @@ static void lockup_detector_reconfigure(
  */
 static __init void lockup_detector_setup(void)
 {
-	int ret;
-
 	/*
 	 * If sysctl is off and watchdog got disabled on the command line,
 	 * nothing to do here.
@@ -592,13 +583,6 @@ static __init void lockup_detector_setup
 	    !(watchdog_enabled && watchdog_thresh))
 		return;
 
-	ret = smpboot_register_percpu_thread_cpumask(&watchdog_threads,
-						     &watchdog_allowed_mask);
-	if (ret) {
-		pr_err("Failed to initialize soft lockup detector threads\n");
-		return;
-	}
-
 	mutex_lock(&watchdog_mutex);
 	softlockup_threads_initialized = true;
 	lockup_detector_reconfigure();
@@ -606,10 +590,6 @@ static __init void lockup_detector_setup
 }
 
 #else /* CONFIG_SOFTLOCKUP_DETECTOR */
-static inline int watchdog_park_threads(void) { return 0; }
-static inline void watchdog_unpark_threads(void) { }
-static inline int watchdog_enable_all_cpus(void) { return 0; }
-static inline void watchdog_disable_all_cpus(void) { }
 static void lockup_detector_reconfigure(void)
 {
 	cpus_read_lock();
