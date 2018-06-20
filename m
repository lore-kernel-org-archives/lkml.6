Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D88C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CAE2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CAE2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754319AbeFTAcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:32:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50459 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752853AbeFTAc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:32:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0WOUf3300445
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:32:24 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0WOHm3300442;
        Tue, 19 Jun 2018 17:32:24 -0700
Date:   Tue, 19 Jun 2018 17:32:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-7f769acc36542bea407b8fd83f2d226cda46513c@git.kernel.org>
Cc:     reinette.chatre@intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: reinette.chatre@intel.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <8ac0d22a62d419266bcc26fdd0e6c4fb6d320d5a.1527593971.git.reinette.chatre@intel.com>
References: <8ac0d22a62d419266bcc26fdd0e6c4fb6d320d5a.1527593971.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: More precise L2 hit/miss
 measurements
Git-Commit-ID: 7f769acc36542bea407b8fd83f2d226cda46513c
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

Commit-ID:  7f769acc36542bea407b8fd83f2d226cda46513c
Gitweb:     https://git.kernel.org/tip/7f769acc36542bea407b8fd83f2d226cda46513c
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 29 May 2018 05:58:01 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:39 +0200

x86/intel_rdt: More precise L2 hit/miss measurements

Intel Goldmont processors supports non-architectural precise events that
can be used to give us more insight into the success of L2 cache
pseudo-locking on these platforms.

Introduce a new measurement trigger that will enable two precise events,
MEM_LOAD_UOPS_RETIRED.L2_HIT and MEM_LOAD_UOPS_RETIRED.L2_MISS, while
accessing pseudo-locked data. A new tracepoint, pseudo_lock_l2, is
created to make these results visible to the user.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/8ac0d22a62d419266bcc26fdd0e6c4fb6d320d5a.1527593971.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c       | 145 ++++++++++++++++++++--
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h |  10 ++
 2 files changed, 146 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 652c95ab51c8..acaec07134c7 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -21,6 +21,7 @@
 #include <asm/cacheflush.h>
 #include <asm/intel-family.h>
 #include <asm/intel_rdt_sched.h>
+#include <asm/perf_event.h>
 #include "intel_rdt.h"
 
 #define CREATE_TRACE_POINTS
@@ -60,6 +61,9 @@ static struct class *pseudo_lock_class;
  * hardware prefetch disable bits are included here as they are documented
  * in the SDM.
  *
+ * When adding a platform here also add support for its cache events to
+ * measure_cycles_perf_fn()
+ *
  * Return:
  * If platform is supported, the bits to disable hardware prefetchers, 0
  * if platform is not supported.
@@ -98,6 +102,16 @@ static u64 get_prefetch_disable_bits(void)
 	return 0;
 }
 
+/*
+ * Helper to write 64bit value to MSR without tracing. Used when
+ * use of the cache should be restricted and use of registers used
+ * for local variables avoided.
+ */
+static inline void pseudo_wrmsrl_notrace(unsigned int msr, u64 val)
+{
+	__wrmsr(msr, (u32)(val & 0xffffffffULL), (u32)(val >> 32));
+}
+
 /**
  * pseudo_lock_minor_get - Obtain available minor number
  * @minor: Pointer to where new minor number will be stored
@@ -831,6 +845,107 @@ static int measure_cycles_lat_fn(void *_plr)
 	return 0;
 }
 
+static int measure_cycles_perf_fn(void *_plr)
+{
+	struct pseudo_lock_region *plr = _plr;
+	unsigned long long l2_hits, l2_miss;
+	u64 l2_hit_bits, l2_miss_bits;
+	u64 i;
+#ifdef CONFIG_KASAN
+	/*
+	 * The registers used for local register variables are also used
+	 * when KASAN is active. When KASAN is active we use regular variables
+	 * at the cost of including cache access latency to these variables
+	 * in the measurements.
+	 */
+	unsigned int line_size;
+	unsigned int size;
+	void *mem_r;
+#else
+	register unsigned int line_size asm("esi");
+	register unsigned int size asm("edi");
+#ifdef CONFIG_X86_64
+	register void *mem_r asm("rbx");
+#else
+	register void *mem_r asm("ebx");
+#endif /* CONFIG_X86_64 */
+#endif /* CONFIG_KASAN */
+
+	/*
+	 * Non-architectural event for the Goldmont Microarchitecture
+	 * from Intel x86 Architecture Software Developer Manual (SDM):
+	 * MEM_LOAD_UOPS_RETIRED D1H (event number)
+	 * Umask values:
+	 *     L1_HIT   01H
+	 *     L2_HIT   02H
+	 *     L1_MISS  08H
+	 *     L2_MISS  10H
+	 */
+
+	/*
+	 * Start by setting flags for IA32_PERFEVTSELx:
+	 *     OS  (Operating system mode)  0x2
+	 *     INT (APIC interrupt enable)  0x10
+	 *     EN  (Enable counter)         0x40
+	 *
+	 * Then add the Umask value and event number to select performance
+	 * event.
+	 */
+
+	switch (boot_cpu_data.x86_model) {
+	case INTEL_FAM6_ATOM_GOLDMONT:
+	case INTEL_FAM6_ATOM_GEMINI_LAKE:
+		l2_hit_bits = (0x52ULL << 16) | (0x2 << 8) | 0xd1;
+		l2_miss_bits = (0x52ULL << 16) | (0x10 << 8) | 0xd1;
+		break;
+	default:
+		goto out;
+	}
+
+	local_irq_disable();
+	/*
+	 * Call wrmsr direcly to avoid the local register variables from
+	 * being overwritten due to reordering of their assignment with
+	 * the wrmsr calls.
+	 */
+	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
+	/* Disable events and reset counters */
+	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0, 0x0);
+	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 1, 0x0);
+	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_PERFCTR0, 0x0);
+	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_PERFCTR0 + 1, 0x0);
+	/* Set and enable the L2 counters */
+	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0, l2_hit_bits);
+	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 1, l2_miss_bits);
+	mem_r = plr->kmem;
+	size = plr->size;
+	line_size = plr->line_size;
+	for (i = 0; i < size; i += line_size) {
+		asm volatile("mov (%0,%1,1), %%eax\n\t"
+			     :
+			     : "r" (mem_r), "r" (i)
+			     : "%eax", "memory");
+	}
+	/*
+	 * Call wrmsr directly (no tracing) to not influence
+	 * the cache access counters as they are disabled.
+	 */
+	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0,
+			      l2_hit_bits & ~(0x40ULL << 16));
+	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 1,
+			      l2_miss_bits & ~(0x40ULL << 16));
+	l2_hits = native_read_pmc(0);
+	l2_miss = native_read_pmc(1);
+	wrmsr(MSR_MISC_FEATURE_CONTROL, 0x0, 0x0);
+	local_irq_enable();
+	trace_pseudo_lock_l2(l2_hits, l2_miss);
+
+out:
+	plr->thread_done = 1;
+	wake_up_interruptible(&plr->lock_thread_wq);
+	return 0;
+}
+
 /**
  * pseudo_lock_measure_cycles - Trigger latency measure to pseudo-locked region
  *
@@ -841,12 +956,12 @@ static int measure_cycles_lat_fn(void *_plr)
  *
  * Return: 0 on success, <0 on failure
  */
-static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp)
+static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
 {
 	struct pseudo_lock_region *plr = rdtgrp->plr;
 	struct task_struct *thread;
 	unsigned int cpu;
-	int ret;
+	int ret = -1;
 
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
@@ -863,9 +978,19 @@ static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp)
 		goto out;
 	}
 
-	thread = kthread_create_on_node(measure_cycles_lat_fn, plr,
-					cpu_to_node(cpu),
-					"pseudo_lock_measure/%u", cpu);
+	if (sel == 1)
+		thread = kthread_create_on_node(measure_cycles_lat_fn, plr,
+						cpu_to_node(cpu),
+						"pseudo_lock_measure/%u",
+						cpu);
+	else if (sel == 2)
+		thread = kthread_create_on_node(measure_cycles_perf_fn, plr,
+						cpu_to_node(cpu),
+						"pseudo_lock_measure/%u",
+						cpu);
+	else
+		goto out;
+
 	if (IS_ERR(thread)) {
 		ret = PTR_ERR(thread);
 		goto out;
@@ -894,19 +1019,21 @@ static ssize_t pseudo_lock_measure_trigger(struct file *file,
 	size_t buf_size;
 	char buf[32];
 	int ret;
-	bool bv;
+	int sel;
 
 	buf_size = min(count, (sizeof(buf) - 1));
 	if (copy_from_user(buf, user_buf, buf_size))
 		return -EFAULT;
 
 	buf[buf_size] = '\0';
-	ret = strtobool(buf, &bv);
-	if (ret == 0 && bv) {
+	ret = kstrtoint(buf, 10, &sel);
+	if (ret == 0) {
+		if (sel != 1 && sel != 2)
+			return -EINVAL;
 		ret = debugfs_file_get(file->f_path.dentry);
 		if (ret)
 			return ret;
-		ret = pseudo_lock_measure_cycles(rdtgrp);
+		ret = pseudo_lock_measure_cycles(rdtgrp, sel);
 		if (ret == 0)
 			ret = count;
 		debugfs_file_put(file->f_path.dentry);
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
index 3cd0fa27d5fe..efad50d2ee2f 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
@@ -15,6 +15,16 @@ TRACE_EVENT(pseudo_lock_mem_latency,
 	    TP_printk("latency=%u", __entry->latency)
 	   );
 
+TRACE_EVENT(pseudo_lock_l2,
+	    TP_PROTO(u64 l2_hits, u64 l2_miss),
+	    TP_ARGS(l2_hits, l2_miss),
+	    TP_STRUCT__entry(__field(u64, l2_hits)
+			     __field(u64, l2_miss)),
+	    TP_fast_assign(__entry->l2_hits = l2_hits;
+			   __entry->l2_miss = l2_miss;),
+	    TP_printk("hits=%llu miss=%llu",
+		      __entry->l2_hits, __entry->l2_miss));
+
 #endif /* _TRACE_PSEUDO_LOCK_H */
 
 #undef TRACE_INCLUDE_PATH
