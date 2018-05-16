Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752566AbeEPEvS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 00:51:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:1167 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751213AbeEPEtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 00:49:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="41300340"
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net
Cc: x86@kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
        juri.lelli@arm.com, linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [RFC/RFT] [PATCH 01/10] x86,sched: Add support for frequency invariance
Date: Tue, 15 May 2018 21:49:02 -0700
Message-Id: <20180516044911.28797-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Implement arch_scale_freq_capacity() for 'modern' x86. This function
is used by the scheduler to correctly account usage in the face of
DVFS.

For example; suppose a CPU has two frequencies: 500 and 1000 Mhz. When
running a task that would consume 1/3rd of a CPU at 1000 MHz, it would
appear to consume 2/3rd (or 66.6%) when running at 500 MHz, giving the
false impression this CPU is almost at capacity, even though it can go
faster [*].

Since modern x86 has hardware control over the actual frequency we run
at (because amongst other things, Turbo-Mode), we cannot simply use
the frequency as requested through cpufreq.

Instead we use the APERF/MPERF MSRs to compute the effective frequency
over the recent past. Also, because reading MSRs is expensive, don't
do so every time we need the value, but amortize the cost by doing it
every tick.

[*] this assumes a linear frequency/performance relation; which
everybody knows to be false, but given realities its the best
approximation we can make.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---

Changes on top of Peter's patch:
-Ported to the latest 4.17-rc4
-Added KNL/KNM related changes
-Account for Turbo boost disabled on a system in BIOS
-New interface to disable tick processing when we don't want

 arch/x86/include/asm/topology.h |  29 ++++++
 arch/x86/kernel/smpboot.c       | 196 +++++++++++++++++++++++++++++++++++++++-
 kernel/sched/core.c             |   1 +
 kernel/sched/sched.h            |   7 ++
 4 files changed, 232 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index c1d2a98..3fb5346 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -172,4 +172,33 @@ static inline void sched_clear_itmt_support(void)
 }
 #endif /* CONFIG_SCHED_MC_PRIO */
 
+#ifdef CONFIG_SMP
+#include <asm/cpufeature.h>
+
+#define arch_scale_freq_tick arch_scale_freq_tick
+#define arch_scale_freq_capacity arch_scale_freq_capacity
+
+DECLARE_PER_CPU(unsigned long, arch_cpu_freq);
+
+static inline long arch_scale_freq_capacity(int cpu)
+{
+	if (static_cpu_has(X86_FEATURE_APERFMPERF))
+		return per_cpu(arch_cpu_freq, cpu);
+
+	return 1024 /* SCHED_CAPACITY_SCALE */;
+}
+
+extern void arch_scale_freq_tick(void);
+extern void x86_arch_scale_freq_tick_enable(void);
+extern void x86_arch_scale_freq_tick_disable(void);
+#else
+static inline void x86_arch_scale_freq_tick_enable(void)
+{
+}
+
+static inline void x86_arch_scale_freq_tick_disable(void)
+{
+}
+#endif
+
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0f1cbb0..9e2cb82 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -148,6 +148,8 @@ static inline void smpboot_restore_warm_reset_vector(void)
 	*((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) = 0;
 }
 
+static void set_cpu_max_freq(void);
+
 /*
  * Report back to the Boot Processor during boot time or to the caller processor
  * during CPU online.
@@ -189,6 +191,8 @@ static void smp_callin(void)
 	 */
 	set_cpu_sibling_map(raw_smp_processor_id());
 
+	set_cpu_max_freq();
+
 	/*
 	 * Get our bogomips.
 	 * Update loops_per_jiffy in cpu_data. Previous call to
@@ -1259,7 +1263,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	set_sched_topology(x86_topology);
 
 	set_cpu_sibling_map(0);
-
+	set_cpu_max_freq();
 	smp_sanity_check();
 
 	switch (apic_intr_mode) {
@@ -1676,3 +1680,193 @@ void native_play_dead(void)
 }
 
 #endif
+
+/*
+ * APERF/MPERF frequency ratio computation.
+ *
+ * The scheduler wants to do frequency invariant accounting and needs a <1
+ * ratio to account for the 'current' frequency.
+ *
+ * Since the frequency on x86 is controlled by micro-controller and our P-state
+ * setting is little more than a request/hint, we need to observe the effective
+ * frequency. We do this with APERF/MPERF.
+ *
+ * One complication is that the APERF/MPERF ratio can be >1, specifically
+ * APERF/MPERF gives the ratio relative to the max non-turbo P-state. Therefore
+ * we need to re-normalize the ratio.
+ *
+ * We do this by tracking the max APERF/MPERF ratio previously observed and
+ * scaling our MPERF delta with that. Every time our ratio goes over 1, we
+ * proportionally scale up our old max.
+ *
+ * The down-side to this runtime max search is that you have to trigger the
+ * actual max frequency before your scale is right. Therefore allow
+ * architectures to initialize the max ratio on CPU bringup.
+ */
+
+static DEFINE_PER_CPU(u64, arch_prev_aperf);
+static DEFINE_PER_CPU(u64, arch_prev_mperf);
+static DEFINE_PER_CPU(u64, arch_prev_max_freq) = SCHED_CAPACITY_SCALE;
+
+static bool turbo_disabled(void)
+{
+	u64 misc_en;
+	int err;
+
+	err = rdmsrl_safe(MSR_IA32_MISC_ENABLE, &misc_en);
+	if (err)
+		return false;
+
+	return (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
+}
+
+static bool atom_set_cpu_max_freq(void)
+{
+	u64 ratio, turbo_ratio;
+	int err;
+
+	if (turbo_disabled()) {
+		this_cpu_write(arch_prev_max_freq, SCHED_CAPACITY_SCALE);
+		return true;
+	}
+
+	err = rdmsrl_safe(MSR_ATOM_CORE_RATIOS, &ratio);
+	if (err)
+		return false;
+
+	err = rdmsrl_safe(MSR_ATOM_CORE_TURBO_RATIOS, &turbo_ratio);
+	if (err)
+		return false;
+
+	ratio = (ratio >> 16) & 0x7F;     /* max P state ratio */
+	turbo_ratio = turbo_ratio & 0x7F; /* 1C turbo ratio */
+
+	this_cpu_write(arch_prev_max_freq,
+			 div_u64(turbo_ratio * SCHED_CAPACITY_SCALE, ratio));
+	return true;
+}
+
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
+
+#define ICPU(model) \
+	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_APERFMPERF, 0}
+
+static const struct x86_cpu_id intel_turbo_ratio_adjust[] __initconst = {
+	ICPU(INTEL_FAM6_XEON_PHI_KNL),
+	ICPU(INTEL_FAM6_XEON_PHI_KNM),
+	{}
+};
+
+static bool core_set_cpu_max_freq(void)
+{
+	const struct x86_cpu_id *id;
+	u64 ratio, turbo_ratio;
+	int err;
+
+	if (turbo_disabled()) {
+		this_cpu_write(arch_prev_max_freq, SCHED_CAPACITY_SCALE);
+		return true;
+	}
+
+	err = rdmsrl_safe(MSR_PLATFORM_INFO, &ratio);
+	if (err)
+		return false;
+
+	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &turbo_ratio);
+	if (err)
+		return false;
+
+	ratio = (ratio >> 8) & 0xFF;      /* base ratio */
+	id = x86_match_cpu(intel_turbo_ratio_adjust);
+	if (id)
+		turbo_ratio = (turbo_ratio >> 8) & 0xFF; /* 1C turbo ratio */
+	else
+		turbo_ratio = turbo_ratio & 0xFF; /* 1C turbo ratio */
+
+	this_cpu_write(arch_prev_max_freq,
+			 div_u64(turbo_ratio * SCHED_CAPACITY_SCALE, ratio));
+	return true;
+}
+
+static void intel_set_cpu_max_freq(void)
+{
+	if (atom_set_cpu_max_freq())
+		return;
+
+	if (core_set_cpu_max_freq())
+		return;
+}
+
+static void set_cpu_max_freq(void)
+{
+	u64 aperf, mperf;
+
+	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
+		return;
+
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_INTEL:
+		intel_set_cpu_max_freq();
+		break;
+	default:
+		break;
+	}
+
+	rdmsrl(MSR_IA32_APERF, aperf);
+	rdmsrl(MSR_IA32_MPERF, mperf);
+
+	this_cpu_write(arch_prev_aperf, aperf);
+	this_cpu_write(arch_prev_mperf, mperf);
+}
+
+DEFINE_PER_CPU(unsigned long, arch_cpu_freq);
+
+static bool tick_disable;
+
+void arch_scale_freq_tick(void)
+{
+	u64 freq, max_freq = this_cpu_read(arch_prev_max_freq);
+	u64 aperf, mperf;
+	u64 acnt, mcnt;
+
+	if (!static_cpu_has(X86_FEATURE_APERFMPERF) || tick_disable)
+		return;
+
+	rdmsrl(MSR_IA32_APERF, aperf);
+	rdmsrl(MSR_IA32_MPERF, mperf);
+
+	acnt = aperf - this_cpu_read(arch_prev_aperf);
+	mcnt = mperf - this_cpu_read(arch_prev_mperf);
+	if (!mcnt)
+		return;
+
+	this_cpu_write(arch_prev_aperf, aperf);
+	this_cpu_write(arch_prev_mperf, mperf);
+
+	acnt <<= 2*SCHED_CAPACITY_SHIFT;
+	mcnt *= max_freq;
+
+	freq = div64_u64(acnt, mcnt);
+
+	if (unlikely(freq > SCHED_CAPACITY_SCALE)) {
+		max_freq *= freq;
+		max_freq >>= SCHED_CAPACITY_SHIFT;
+
+		this_cpu_write(arch_prev_max_freq, max_freq);
+
+		freq = SCHED_CAPACITY_SCALE;
+	}
+
+	this_cpu_write(arch_cpu_freq, freq);
+}
+
+void x86_arch_scale_freq_tick_enable(void)
+{
+	tick_disable = false;
+}
+
+void x86_arch_scale_freq_tick_disable(void)
+{
+	tick_disable = true;
+}
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 092f7c4..2bdef36 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3076,6 +3076,7 @@ void scheduler_tick(void)
 	struct task_struct *curr = rq->curr;
 	struct rq_flags rf;
 
+	arch_scale_freq_tick();
 	sched_clock_tick();
 
 	rq_lock(rq, &rf);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 15750c2..71851af 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1713,6 +1713,13 @@ static inline int hrtick_enabled(struct rq *rq)
 
 #endif /* CONFIG_SCHED_HRTICK */
 
+#ifndef arch_scale_freq_tick
+static __always_inline
+void arch_scale_freq_tick(void)
+{
+}
+#endif
+
 #ifndef arch_scale_freq_capacity
 static __always_inline
 unsigned long arch_scale_freq_capacity(int cpu)
-- 
2.9.5
