Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeAaS2s (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:28:48 -0500
Received: from foss.arm.com ([217.140.101.70]:41456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbeAaS2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:28:43 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        will.deacon@arm.com, mark.rutland@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, ckadabi@codeaurora.org, dave.martin@arm.com,
        jnair@caviumnetworks.com, Robin Murphy <robin.murphy@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 01/20] arm64: capabilities: Update prototype for enable call back
Date: Wed, 31 Jan 2018 18:27:48 +0000
Message-Id: <20180131182807.32134-2-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131182807.32134-1-suzuki.poulose@arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Martin <dave.martin@arm.com>

We issue the enable() call back for all CPU hwcaps capabilities
available on the system, on all the CPUs. So far we have ignored
the argument passed to the call back, which had a prototype to
accept a "void *" for use with on_each_cpu() and later with
stop_machine(). However, with commit 0a0d111d40fd1
("arm64: cpufeature: Pass capability structure to ->enable callback"),
there are some users of the argument who wants the matching capability
struct pointer where there are multiple matching criteria for a single
capability. Clean up the declaration of the call back to make it clear.

 1) Renamed to cpu_enable(), to imply taking necessary actions on the
    called CPU for the entry.
 2) Pass const pointer to the capability, to allow the call back to
    check the entry. (e.,g to check if any action is needed on the CPU)
 3) We don't care about the result of the call back, turning this to
    a void.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: James Morse <james.morse@arm.com>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Dave Martin <dave.martin@arm.com>
[
 Rebased to for-next/core converting more users, rename call back,
 drop call back results
]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  7 ++++++-
 arch/arm64/include/asm/fpsimd.h     |  4 +++-
 arch/arm64/include/asm/processor.h  |  7 ++++---
 arch/arm64/kernel/cpu_errata.c      | 41 +++++++++++++++----------------------
 arch/arm64/kernel/cpufeature.c      | 33 ++++++++++++++++-------------
 arch/arm64/kernel/fpsimd.c          |  5 ++---
 arch/arm64/kernel/traps.c           |  4 ++--
 arch/arm64/mm/fault.c               |  3 +--
 8 files changed, 54 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index ac67cfc2585a..f46eb7d1625f 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -97,7 +97,12 @@ struct arm64_cpu_capabilities {
 	u16 capability;
 	int def_scope;			/* default scope */
 	bool (*matches)(const struct arm64_cpu_capabilities *caps, int scope);
-	int (*enable)(void *);		/* Called on all active CPUs */
+	/*
+	 * Take the appropriate actions to enable this capability for this CPU.
+	 * For each successfully booted CPU, this method is called for each
+	 * globally detected capability.
+	 */
+	void (*cpu_enable)(const struct arm64_cpu_capabilities *cap);
 	union {
 		struct {	/* To be used for erratum handling only */
 			u32 midr_model;
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 8857a0f0d0f7..7623762f7fa6 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -83,7 +83,9 @@ extern void sve_save_state(void *state, u32 *pfpsr);
 extern void sve_load_state(void const *state, u32 const *pfpsr,
 			   unsigned long vq_minus_1);
 extern unsigned int sve_get_vl(void);
-extern int sve_kernel_enable(void *);
+
+struct arm64_cpu_capabilities;
+extern void sve_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 
 extern int __ro_after_init sve_max_vl;
 
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index cee4ae25a5d1..83a3d2887ca6 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -34,6 +34,7 @@
 #include <linux/string.h>
 
 #include <asm/alternative.h>
+#include <asm/cpufeature.h>
 #include <asm/fpsimd.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/lse.h>
@@ -214,9 +215,9 @@ static inline void spin_lock_prefetch(const void *ptr)
 
 #endif
 
-int cpu_enable_pan(void *__unused);
-int cpu_enable_cache_maint_trap(void *__unused);
-int cpu_clear_disr(void *__unused);
+void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused);
+void cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused);
+void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused);
 
 /* Userspace interface for PR_SVE_{SET,GET}_VL prctl()s: */
 #define SVE_SET_VL(arg)	sve_set_current_vl(arg)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index ed6881882231..e34bee500692 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -53,11 +53,11 @@ has_mismatched_cache_line_size(const struct arm64_cpu_capabilities *entry,
 		(arm64_ftr_reg_ctrel0.sys_val & arm64_ftr_reg_ctrel0.strict_mask);
 }
 
-static int cpu_enable_trap_ctr_access(void *__unused)
+static void cpu_enable_trap_ctr_access(
+	const struct arm64_cpu_capabilities *__unused)
 {
 	/* Clear SCTLR_EL1.UCT */
 	config_sctlr_el1(SCTLR_EL1_UCT, 0);
-	return 0;
 }
 
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
@@ -144,17 +144,13 @@ static void  install_bp_hardening_cb(const struct arm64_cpu_capabilities *entry,
 
 #include <linux/psci.h>
 
-static int enable_psci_bp_hardening(void *data)
+static void enable_psci_bp_hardening(const struct arm64_cpu_capabilities *entry)
 {
-	const struct arm64_cpu_capabilities *entry = data;
-
 	if (psci_ops.get_version)
 		install_bp_hardening_cb(entry,
 				       (bp_hardening_cb_t)psci_ops.get_version,
 				       __psci_hyp_bp_inval_start,
 				       __psci_hyp_bp_inval_end);
-
-	return 0;
 }
 
 static void qcom_link_stack_sanitization(void)
@@ -169,15 +165,12 @@ static void qcom_link_stack_sanitization(void)
 		     : "=&r" (tmp));
 }
 
-static int qcom_enable_link_stack_sanitization(void *data)
+static void qcom_enable_link_stack_sanitization(
+			const struct arm64_cpu_capabilities *entry)
 {
-	const struct arm64_cpu_capabilities *entry = data;
-
 	install_bp_hardening_cb(entry, qcom_link_stack_sanitization,
 				__qcom_hyp_sanitize_link_stack_start,
 				__qcom_hyp_sanitize_link_stack_end);
-
-	return 0;
 }
 #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
 
@@ -204,7 +197,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.desc = "ARM errata 826319, 827319, 824069",
 		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
 		MIDR_RANGE(MIDR_CORTEX_A53, 0x00, 0x02),
-		.enable = cpu_enable_cache_maint_trap,
+		.cpu_enable = cpu_enable_cache_maint_trap,
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_819472
@@ -213,7 +206,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.desc = "ARM errata 819472",
 		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
 		MIDR_RANGE(MIDR_CORTEX_A53, 0x00, 0x01),
-		.enable = cpu_enable_cache_maint_trap,
+		.cpu_enable = cpu_enable_cache_maint_trap,
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_832075
@@ -294,7 +287,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.capability = ARM64_MISMATCHED_CACHE_LINE_SIZE,
 		.matches = has_mismatched_cache_line_size,
 		.def_scope = SCOPE_LOCAL_CPU,
-		.enable = cpu_enable_trap_ctr_access,
+		.cpu_enable = cpu_enable_trap_ctr_access,
 	},
 #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
 	{
@@ -333,27 +326,27 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
-		.enable = enable_psci_bp_hardening,
+		.cpu_enable = enable_psci_bp_hardening,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
-		.enable = enable_psci_bp_hardening,
+		.cpu_enable = enable_psci_bp_hardening,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
-		.enable = enable_psci_bp_hardening,
+		.cpu_enable = enable_psci_bp_hardening,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
-		.enable = enable_psci_bp_hardening,
+		.cpu_enable = enable_psci_bp_hardening,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
 		MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
-		.enable = qcom_enable_link_stack_sanitization,
+		.cpu_enable = qcom_enable_link_stack_sanitization,
 	},
 	{
 		.capability = ARM64_HARDEN_BP_POST_GUEST_EXIT,
@@ -362,12 +355,12 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
 		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
-		.enable = enable_psci_bp_hardening,
+		.cpu_enable = enable_psci_bp_hardening,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
 		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
-		.enable = enable_psci_bp_hardening,
+		.cpu_enable = enable_psci_bp_hardening,
 	},
 #endif
 	{
@@ -385,8 +378,8 @@ void verify_local_cpu_errata_workarounds(void)
 
 	for (; caps->matches; caps++) {
 		if (cpus_have_cap(caps->capability)) {
-			if (caps->enable)
-				caps->enable((void *)caps);
+			if (caps->cpu_enable)
+				caps->cpu_enable(caps);
 		} else if (caps->matches(caps, SCOPE_LOCAL_CPU)) {
 			pr_crit("CPU%d: Requires work around for %s, not detected"
 					" at boot time\n",
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 4b6f9051cf0c..0b881d9fcde2 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -894,7 +894,7 @@ static int __init parse_kpti(char *str)
 __setup("kpti=", parse_kpti);
 #endif	/* CONFIG_UNMAP_KERNEL_AT_EL0 */
 
-static int cpu_copy_el2regs(void *__unused)
+static void cpu_copy_el2regs(const struct arm64_cpu_capabilities *__unused)
 {
 	/*
 	 * Copy register values that aren't redirected by hardware.
@@ -906,8 +906,6 @@ static int cpu_copy_el2regs(void *__unused)
 	 */
 	if (!alternatives_applied)
 		write_sysreg(read_sysreg(tpidr_el1), tpidr_el2);
-
-	return 0;
 }
 
 static const struct arm64_cpu_capabilities arm64_features[] = {
@@ -931,7 +929,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.field_pos = ID_AA64MMFR1_PAN_SHIFT,
 		.sign = FTR_UNSIGNED,
 		.min_field_value = 1,
-		.enable = cpu_enable_pan,
+		.cpu_enable = cpu_enable_pan,
 	},
 #endif /* CONFIG_ARM64_PAN */
 #if defined(CONFIG_AS_LSE) && defined(CONFIG_ARM64_LSE_ATOMICS)
@@ -979,7 +977,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_HAS_VIRT_HOST_EXTN,
 		.def_scope = SCOPE_SYSTEM,
 		.matches = runs_at_el2,
-		.enable = cpu_copy_el2regs,
+		.cpu_enable = cpu_copy_el2regs,
 	},
 	{
 		.desc = "32-bit EL0 Support",
@@ -1033,7 +1031,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.field_pos = ID_AA64PFR0_SVE_SHIFT,
 		.min_field_value = ID_AA64PFR0_SVE,
 		.matches = has_cpuid_feature,
-		.enable = sve_kernel_enable,
+		.cpu_enable = sve_kernel_enable,
 	},
 #endif /* CONFIG_ARM64_SVE */
 #ifdef CONFIG_ARM64_RAS_EXTN
@@ -1046,7 +1044,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64PFR0_RAS_SHIFT,
 		.min_field_value = ID_AA64PFR0_RAS_V1,
-		.enable = cpu_clear_disr,
+		.cpu_enable = cpu_clear_disr,
 	},
 #endif /* CONFIG_ARM64_RAS_EXTN */
 	{},
@@ -1190,6 +1188,15 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 	}
 }
 
+
+static int __enable_cpu_capability(void *arg)
+{
+	const struct arm64_cpu_capabilities *cap = arg;
+
+	cap->cpu_enable(cap);
+	return 0;
+}
+
 /*
  * Run through the enabled capabilities and enable() it on all active
  * CPUs
@@ -1205,14 +1212,14 @@ void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 		/* Ensure cpus_have_const_cap(num) works */
 		static_branch_enable(&cpu_hwcap_keys[num]);
 
-		if (caps->enable) {
+		if (caps->cpu_enable) {
 			/*
 			 * Use stop_machine() as it schedules the work allowing
 			 * us to modify PSTATE, instead of on_each_cpu() which
 			 * uses an IPI, giving us a PSTATE that disappears when
 			 * we return.
 			 */
-			stop_machine(caps->enable, (void *)caps, cpu_online_mask);
+			stop_machine(__enable_cpu_capability, (void *)caps, cpu_online_mask);
 		}
 	}
 }
@@ -1255,8 +1262,8 @@ verify_local_cpu_features(const struct arm64_cpu_capabilities *caps_list)
 					smp_processor_id(), caps->desc);
 			cpu_die_early();
 		}
-		if (caps->enable)
-			caps->enable((void *)caps);
+		if (caps->cpu_enable)
+			caps->cpu_enable(caps);
 	}
 }
 
@@ -1479,10 +1486,8 @@ static int __init enable_mrs_emulation(void)
 
 core_initcall(enable_mrs_emulation);
 
-int cpu_clear_disr(void *__unused)
+void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused)
 {
 	/* Firmware may have left a deferred SError in this register. */
 	write_sysreg_s(0, SYS_DISR_EL1);
-
-	return 0;
 }
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 55fb544072f6..35c563536b0c 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -40,6 +40,7 @@
 #include <linux/sysctl.h>
 
 #include <asm/fpsimd.h>
+#include <asm/cpufeature.h>
 #include <asm/cputype.h>
 #include <asm/simd.h>
 #include <asm/sigcontext.h>
@@ -757,12 +758,10 @@ static void __init sve_efi_setup(void)
  * Enable SVE for EL1.
  * Intended for use by the cpufeatures code during CPU boot.
  */
-int sve_kernel_enable(void *__always_unused p)
+void sve_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
 {
 	write_sysreg(read_sysreg(CPACR_EL1) | CPACR_EL1_ZEN_EL1EN, CPACR_EL1);
 	isb();
-
-	return 0;
 }
 
 void __init sve_setup(void)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index bbb0fde2780e..a2f6492b4ea3 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -38,6 +38,7 @@
 
 #include <asm/atomic.h>
 #include <asm/bug.h>
+#include <asm/cpufeature.h>
 #include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
@@ -374,10 +375,9 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
 }
 
-int cpu_enable_cache_maint_trap(void *__unused)
+void cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
 {
 	config_sctlr_el1(SCTLR_EL1_UCI, 0);
-	return 0;
 }
 
 #define __user_cache_maint(insn, address, res)			\
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 0e671ddf4855..ccfbe979be17 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -813,7 +813,7 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 NOKPROBE_SYMBOL(do_debug_exception);
 
 #ifdef CONFIG_ARM64_PAN
-int cpu_enable_pan(void *__unused)
+void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
 {
 	/*
 	 * We modify PSTATE. This won't work from irq context as the PSTATE
@@ -823,6 +823,5 @@ int cpu_enable_pan(void *__unused)
 
 	config_sctlr_el1(SCTLR_EL1_SPAN, 0);
 	asm(SET_PSTATE_PAN(1));
-	return 0;
 }
 #endif /* CONFIG_ARM64_PAN */
-- 
2.14.3
