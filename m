Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 573DDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3A02086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="niXDvMts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3A02086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934698AbeFLQaM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:30:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53334 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934610AbeFLQ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=a3kYewiZw7Axv+JdLs0iyIecILkUvbFlzH4bwTPGug4=; b=niXDvMtsWyM6iVSBVZMjJogG9e
        SAjk51xZLeDatWj6G1sZL7w8OqZQAfFgzcQNQXt3Zeip3Nxfp6xlNMze6Vgbrw2CZoECgbfABUEKk
        uWquYdAsA7WIOGVJ5+JSqS8+H3Lw3F3mmmTbgfX5QXislr2RXj3TXRlV+Mg91xxL4ZQWxt+VpUnzn
        gSH5y9FkTH9m4aYmLM/68/iGiKta1LEqN2eZN0+8ARtxUQFtibDcZyjqWkpTvOz2cMfr7Z94DcD87
        SeO4Nd8cLMnYbKN6m3/CkdrSaRsZmiXSKvOv4wteTVKImQ2GbjfGrtcbF7cbyvaMdMq3f83cSxjgG
        dGILQDfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSmAz-0004iQ-EQ; Tue, 12 Jun 2018 16:29:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CDB1E201EA7CE; Tue, 12 Jun 2018 18:29:43 +0200 (CEST)
Message-Id: <20180612161832.428662402@infradead.org>
User-Agent: quilt/0.63-1
Date:   Tue, 12 Jun 2018 18:12:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, oleg@redhat.com, gkohli@codeaurora.org
Cc:     tglx@linutronix.de, mpe@ellerman.id.au, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com,
        peterz@infradead.org, dzickus@redhat.com
Subject: [PATCH v2 2/4] watchdog/softlockup: Replace "watchdog/%u" threads with cpu_stop_work
References: <20180612161225.693133662@infradead.org>
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

Cc: Don Zickus <dzickus@redhat.com>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/cpuhotplug.h |    1 
 include/linux/nmi.h        |    5 +
 kernel/cpu.c               |    5 +
 kernel/watchdog.c          |  137 +++++++++++++++++++--------------------------
 4 files changed, 71 insertions(+), 77 deletions(-)

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
 
@@ -169,11 +165,10 @@ static void lockup_detector_update_enabl
 unsigned int __read_mostly softlockup_panic =
 			CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE;
 
-static bool softlockup_threads_initialized __read_mostly;
+static bool softlockup_initialized __read_mostly;
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
@@ -473,15 +484,14 @@ static void watchdog_enable(unsigned int
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
@@ -491,77 +501,63 @@ static void watchdog_disable(unsigned in
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
+	if (!softlockup_initialized)
+		return;
+
+	for_each_cpu(cpu, &watchdog_allowed_mask)
+		smp_call_on_cpu(cpu, softlockup_stop_fn, NULL, false);
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
+		smp_call_on_cpu(cpu, softlockup_start_fn, NULL, false);
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
@@ -580,8 +576,6 @@ static void lockup_detector_reconfigure(
  */
 static __init void lockup_detector_setup(void)
 {
-	int ret;
-
 	/*
 	 * If sysctl is off and watchdog got disabled on the command line,
 	 * nothing to do here.
@@ -592,24 +586,13 @@ static __init void lockup_detector_setup
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
-	softlockup_threads_initialized = true;
+	softlockup_initialized = true;
 	lockup_detector_reconfigure();
 	mutex_unlock(&watchdog_mutex);
 }
 
 #else /* CONFIG_SOFTLOCKUP_DETECTOR */
-static inline int watchdog_park_threads(void) { return 0; }
-static inline void watchdog_unpark_threads(void) { }
-static inline int watchdog_enable_all_cpus(void) { return 0; }
-static inline void watchdog_disable_all_cpus(void) { }
 static void lockup_detector_reconfigure(void)
 {
 	cpus_read_lock();


