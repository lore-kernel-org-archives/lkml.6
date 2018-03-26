Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeCZOSq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:18:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41010 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752238AbeCZONY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:13:24 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, dave.martin@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        ckadabi@codeaurora.org, shankerd@codeaurora.org,
        ard.biesheuvel@linaro.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 05/22] arm64: capabilities: Add flags to handle the conflicts on late CPU
Date: Mon, 26 Mar 2018 15:12:32 +0100
Message-Id: <1522073569-29174-6-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522073569-29174-1-git-send-email-suzuki.poulose@arm.com>
References: <1522073569-29174-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a CPU is brought up, it is checked against the caps that are
known to be enabled on the system (via verify_local_cpu_capabilities()).
Based on the state of the capability on the CPU vs. that of System we
could have the following combinations of conflict.

	x-----------------------------x
	| Type  | System   | Late CPU |
	|-----------------------------|
	|  a    |   y      |    n     |
	|-----------------------------|
	|  b    |   n      |    y     |
	x-----------------------------x

Case (a) is not permitted for caps which are system features, which the
system expects all the CPUs to have (e.g VHE). While (a) is ignored for
all errata work arounds. However, there could be exceptions to the plain
filtering approach. e.g, KPTI is an optional feature for a late CPU as
long as the system already enables it.

Case (b) is not permitted for errata work arounds that cannot be activated
after the kernel has finished booting.And we ignore (b) for features. Here,
yet again, KPTI is an exception, where if a late CPU needs KPTI we are too
late to enable it (because we change the allocation of ASIDs etc).

Add two different flags to indicate how the conflict should be handled.

 ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU - CPUs may have the capability
 ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU - CPUs may not have the cappability.

Now that we have the flags to describe the behavior of the errata and
the features, as we treat them, define types for ERRATUM and FEATURE.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 68 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c      |  8 ++---
 arch/arm64/kernel/cpufeature.c      | 34 +++++++++----------
 3 files changed, 89 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 13fde09..b8d8e60 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -153,6 +153,7 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
  *    an action, based on the severity (e.g, a CPU could be prevented from
  *    booting or cause a kernel panic). The CPU is allowed to "affect" the
  *    state of the capability, if it has not been finalised already.
+ *    See section 5 for more details on conflicts.
  *
  * 4) Action: As mentioned in (2), the kernel can take an action for each
  *    detected capability, on all CPUs on the system. Appropriate actions
@@ -170,6 +171,34 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
  *
  *	  check_local_cpu_capabilities() -> verify_local_cpu_capabilities()
  *
+ * 5) Conflicts: Based on the state of the capability on a late CPU vs.
+ *    the system state, we could have the following combinations :
+ *
+ *		x-----------------------------x
+ *		| Type  | System   | Late CPU |
+ *		|-----------------------------|
+ *		|  a    |   y      |    n     |
+ *		|-----------------------------|
+ *		|  b    |   n      |    y     |
+ *		x-----------------------------x
+ *
+ *     Two separate flag bits are defined to indicate whether each kind of
+ *     conflict can be allowed:
+ *		ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU - Case(a) is allowed
+ *		ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU - Case(b) is allowed
+ *
+ *     Case (a) is not permitted for a capability that the system requires
+ *     all CPUs to have in order for the capability to be enabled. This is
+ *     typical for capabilities that represent enhanced functionality.
+ *
+ *     Case (b) is not permitted for a capability that must be enabled
+ *     during boot if any CPU in the system requires it in order to run
+ *     safely. This is typical for erratum work arounds that cannot be
+ *     enabled after the corresponding capability is finalised.
+ *
+ *     In some non-typical cases either both (a) and (b), or neither,
+ *     should be permitted. This can be described by including neither
+ *     or both flags in the capability's type field.
  */
 
 
@@ -183,6 +212,33 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
 #define SCOPE_SYSTEM				ARM64_CPUCAP_SCOPE_SYSTEM
 #define SCOPE_LOCAL_CPU				ARM64_CPUCAP_SCOPE_LOCAL_CPU
 
+/*
+ * Is it permitted for a late CPU to have this capability when system
+ * hasn't already enabled it ?
+ */
+#define ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU	((u16)BIT(4))
+/* Is it safe for a late CPU to miss this capability when system has it */
+#define ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU	((u16)BIT(5))
+
+/*
+ * CPU errata workarounds that need to be enabled at boot time if one or
+ * more CPUs in the system requires it. When one of these capabilities
+ * has been enabled, it is safe to allow any CPU to boot that doesn't
+ * require the workaround. However, it is not safe if a "late" CPU
+ * requires a workaround and the system hasn't enabled it already.
+ */
+#define ARM64_CPUCAP_LOCAL_CPU_ERRATUM		\
+	(ARM64_CPUCAP_SCOPE_LOCAL_CPU | ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU)
+/*
+ * CPU feature detected at boot time based on system-wide value of a
+ * feature. It is safe for a late CPU to have this feature even though
+ * the system hasn't enabled it, although the featuer will not be used
+ * by Linux in this case. If the system has enabled this feature already,
+ * then every late CPU must have it.
+ */
+#define ARM64_CPUCAP_SYSTEM_FEATURE	\
+	(ARM64_CPUCAP_SCOPE_SYSTEM | ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU)
+
 struct arm64_cpu_capabilities {
 	const char *desc;
 	u16 capability;
@@ -220,6 +276,18 @@ static inline int cpucap_default_scope(const struct arm64_cpu_capabilities *cap)
 	return cap->type & ARM64_CPUCAP_SCOPE_MASK;
 }
 
+static inline bool
+cpucap_late_cpu_optional(const struct arm64_cpu_capabilities *cap)
+{
+	return !!(cap->type & ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU);
+}
+
+static inline bool
+cpucap_late_cpu_permitted(const struct arm64_cpu_capabilities *cap)
+{
+	return !!(cap->type & ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU);
+}
+
 extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
 extern struct static_key_false arm64_const_caps_ready;
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 2b52331..f5ab954 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -238,14 +238,14 @@ qcom_enable_link_stack_sanitization(const struct arm64_cpu_capabilities *entry)
 #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
 
 #define MIDR_RANGE(model, min, max) \
-	.type = ARM64_CPUCAP_SCOPE_LOCAL_CPU, \
+	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM, \
 	.matches = is_affected_midr_range, \
 	.midr_model = model, \
 	.midr_range_min = min, \
 	.midr_range_max = max
 
 #define MIDR_ALL_VERSIONS(model) \
-	.type = ARM64_CPUCAP_SCOPE_LOCAL_CPU, \
+	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM, \
 	.matches = is_affected_midr_range, \
 	.midr_model = model, \
 	.midr_range_min = 0, \
@@ -361,7 +361,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.desc = "Mismatched cache line size",
 		.capability = ARM64_MISMATCHED_CACHE_LINE_SIZE,
 		.matches = has_mismatched_cache_line_size,
-		.type = ARM64_CPUCAP_SCOPE_LOCAL_CPU,
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 		.cpu_enable = cpu_enable_trap_ctr_access,
 	},
 #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
@@ -375,7 +375,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	{
 		.desc = "Qualcomm Technologies Kryo erratum 1003",
 		.capability = ARM64_WORKAROUND_QCOM_FALKOR_E1003,
-		.type = ARM64_CPUCAP_SCOPE_LOCAL_CPU,
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 		.midr_model = MIDR_QCOM_KRYO,
 		.matches = is_kryo_midr,
 	},
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 19955fd..0b8e6b9 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -975,7 +975,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
 		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
-		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_useable_gicv3_cpuif,
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.field_pos = ID_AA64PFR0_GIC_SHIFT,
@@ -986,7 +986,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "Privileged Access Never",
 		.capability = ARM64_HAS_PAN,
-		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64MMFR1_EL1,
 		.field_pos = ID_AA64MMFR1_PAN_SHIFT,
@@ -999,7 +999,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "LSE atomic instructions",
 		.capability = ARM64_HAS_LSE_ATOMICS,
-		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64ISAR0_EL1,
 		.field_pos = ID_AA64ISAR0_ATOMICS_SHIFT,
@@ -1010,14 +1010,14 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "Software prefetching using PRFM",
 		.capability = ARM64_HAS_NO_HW_PREFETCH,
-		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_no_hw_prefetch,
 	},
 #ifdef CONFIG_ARM64_UAO
 	{
 		.desc = "User Access Override",
 		.capability = ARM64_HAS_UAO,
-		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64MMFR2_EL1,
 		.field_pos = ID_AA64MMFR2_UAO_SHIFT,
@@ -1031,21 +1031,21 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 #ifdef CONFIG_ARM64_PAN
 	{
 		.capability = ARM64_ALT_PAN_NOT_UAO,
-		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = cpufeature_pan_not_uao,
 	},
 #endif /* CONFIG_ARM64_PAN */
 	{
 		.desc = "Virtualization Host Extensions",
 		.capability = ARM64_HAS_VIRT_HOST_EXTN,
-		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = runs_at_el2,
 		.cpu_enable = cpu_copy_el2regs,
 	},
 	{
 		.desc = "32-bit EL0 Support",
 		.capability = ARM64_HAS_32BIT_EL0,
-		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
@@ -1055,14 +1055,14 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "Reduced HYP mapping offset",
 		.capability = ARM64_HYP_OFFSET_LOW,
-		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = hyp_offset_low,
 	},
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	{
 		.desc = "Kernel page table isolation (KPTI)",
 		.capability = ARM64_UNMAP_KERNEL_AT_EL0,
-		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = unmap_kernel_at_el0,
 		.cpu_enable = kpti_install_ng_mappings,
 	},
@@ -1070,7 +1070,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		/* FP/SIMD is not implemented */
 		.capability = ARM64_HAS_NO_FPSIMD,
-		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.min_field_value = 0,
 		.matches = has_no_fpsimd,
 	},
@@ -1078,7 +1078,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "Data cache clean to Point of Persistence",
 		.capability = ARM64_HAS_DCPOP,
-		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64ISAR1_EL1,
 		.field_pos = ID_AA64ISAR1_DPB_SHIFT,
@@ -1088,7 +1088,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 #ifdef CONFIG_ARM64_SVE
 	{
 		.desc = "Scalable Vector Extension",
-		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.capability = ARM64_SVE,
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
@@ -1102,7 +1102,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "RAS Extension Support",
 		.capability = ARM64_HAS_RAS_EXTN,
-		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
@@ -1114,13 +1114,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "Data cache clean to the PoU not required for I/D coherence",
 		.capability = ARM64_HAS_CACHE_IDC,
-		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cache_idc,
 	},
 	{
 		.desc = "Instruction cache invalidation not required for I/D coherence",
 		.capability = ARM64_HAS_CACHE_DIC,
-		.type = ARM64_CPUCAP_SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cache_dic,
 	},
 	{},
@@ -1129,7 +1129,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 #define HWCAP_CAP(reg, field, s, min_value, cap_type, cap)	\
 	{							\
 		.desc = #cap,					\
-		.type = ARM64_CPUCAP_SCOPE_SYSTEM,		\
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,		\
 		.matches = has_cpuid_feature,			\
 		.sys_reg = reg,					\
 		.field_pos = field,				\
-- 
2.7.4
