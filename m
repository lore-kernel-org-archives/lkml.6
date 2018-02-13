Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966277AbeBMXts (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:49:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:53398 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966232AbeBMXtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="29822355"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH V2 18/22] x86/intel_rdt: More precise L2 hit/miss measurements
Date: Tue, 13 Feb 2018 07:47:02 -0800
Message-Id: <06a6e32eb4c903e9912727b9ecf6f4b9aded7038.1518443616.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Goldmont processors supports non-architectural precise events that
can be used to give us more insight into the success of L2 cache
pseudo-locking on these platforms.

Introduce a new measurement trigger that will enable two precise events,
MEM_LOAD_UOPS_RETIRED.L2_HIT and MEM_LOAD_UOPS_RETIRED.L2_MISS, while
accessing pseudo-locked data. A new tracepoint, pseudo_lock_l2, is
created to make these results visible to the user.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c       | 146 ++++++++++++++++++++--
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h |  15 +++
 2 files changed, 148 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index b4923aa4314c..34b2de387c3a 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -36,6 +36,7 @@
 #include "intel_rdt.h"
 
 #ifdef CONFIG_INTEL_RDT_DEBUGFS
+#include <asm/perf_event.h>
 #define CREATE_TRACE_POINTS
 #include "intel_rdt_pseudo_lock_event.h"
 #endif
@@ -338,7 +339,7 @@ bool cbm_pseudo_locked(unsigned long cbm, struct rdt_domain *d)
 }
 
 #ifdef CONFIG_INTEL_RDT_DEBUGFS
-static int measure_cycles_fn(void *_plr)
+static int measure_cycles_hist_fn(void *_plr)
 {
 	struct pseudo_lock_region *plr = _plr;
 	unsigned long flags;
@@ -387,11 +388,115 @@ static int measure_cycles_fn(void *_plr)
 	return 0;
 }
 
-static int pseudo_measure_cycles(struct pseudo_lock_region *plr)
+static int measure_cycles_perf_fn(void *_plr)
+{
+	struct pseudo_lock_region *plr = _plr;
+	unsigned long long l2_hits, l2_miss;
+	u64 l2_hit_bits, l2_miss_bits;
+	unsigned long flags;
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
+	preempt_disable();
+	local_irq_save(flags);
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
+	local_irq_restore(flags);
+	preempt_enable();
+	trace_pseudo_lock_l2(l2_hits, l2_miss);
+
+out:
+	thread_done = 1;
+	wake_up_interruptible(&wq);
+	return 0;
+}
+
+static int pseudo_measure_cycles(struct pseudo_lock_region *plr, int sel)
 {
 	struct task_struct *thread;
 	unsigned int cpu;
-	int ret;
+	int ret = -1;
 
 	cpus_read_lock();
 	mutex_lock(&rdt_pseudo_lock_mutex);
@@ -408,9 +513,19 @@ static int pseudo_measure_cycles(struct pseudo_lock_region *plr)
 		goto out;
 	}
 
-	thread = kthread_create_on_node(measure_cycles_fn, plr,
-					cpu_to_node(cpu),
-					"pseudo_lock_measure/%u", cpu);
+	if (sel == 1)
+		thread = kthread_create_on_node(measure_cycles_hist_fn, plr,
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
@@ -438,21 +553,23 @@ static ssize_t pseudo_measure_trigger(struct file *file,
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
+	ret = kstrtoint(buf, 10, &sel);
 	if (ret == 0) {
+		if (sel != 1 && sel != 2)
+			return -EINVAL;
 		ret = debugfs_file_get(file->f_path.dentry);
-		if (ret == 0 && bv) {
-			ret = pseudo_measure_cycles(plr);
-			if (ret == 0)
-				ret = count;
-		}
+		if (unlikely(ret))
+			return ret;
+		ret = pseudo_measure_cycles(plr, sel);
+		if (ret == 0)
+			ret = count;
 		debugfs_file_put(file->f_path.dentry);
 	}
 
@@ -1249,6 +1366,9 @@ int rdt_pseudo_lock_rmdir(struct kernfs_node *kn)
  * hardware prefetch disable bits are included here as they are documented
  * in the SDM.
  *
+ * When adding a platform here also add support for its cache events to
+ * measure_cycles_perf_fn()
+ *
  * RETURNS
  * If platform is supported, the bits to disable hardware prefetchers, 0
  * if platform is not supported.
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
index cd74d1a0f592..45f6d1e35378 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
@@ -14,6 +14,21 @@ TRACE_EVENT(pseudo_lock_mem_latency,
 	    TP_printk("latency=%u", __entry->latency)
 	   );
 
+TRACE_EVENT(pseudo_lock_l2,
+	    TP_PROTO(u64 l2_hits, u64 l2_miss),
+	    TP_ARGS(l2_hits, l2_miss),
+	    TP_STRUCT__entry(
+			     __field(u64, l2_hits)
+			     __field(u64, l2_miss)
+	    ),
+	    TP_fast_assign(
+			   __entry->l2_hits = l2_hits;
+			   __entry->l2_miss = l2_miss;
+	    ),
+	    TP_printk("hits=%llu miss=%llu",
+		      __entry->l2_hits, __entry->l2_miss)
+	   );
+
 #endif /* _TRACE_PSEUDO_LOCK_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.13.6
