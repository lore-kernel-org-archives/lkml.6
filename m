Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeCZOPd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:15:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41172 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752478AbeCZON4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:13:56 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, dave.martin@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        ckadabi@codeaurora.org, shankerd@codeaurora.org,
        ard.biesheuvel@linaro.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 18/22] arm64: capabilities: Add support for checks based on a list of MIDRs
Date: Mon, 26 Mar 2018 15:12:45 +0100
Message-Id: <1522073569-29174-19-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522073569-29174-1-git-send-email-suzuki.poulose@arm.com>
References: <1522073569-29174-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helpers for detecting an errata on list of midr ranges
of affected CPUs, with the same work around.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  1 +
 arch/arm64/include/asm/cputype.h    |  9 +++++
 arch/arm64/kernel/cpu_errata.c      | 81 ++++++++++++++++++++-----------------
 arch/arm64/kernel/cpufeature.c      | 10 +++--
 4 files changed, 60 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index cd24587..a16eb07 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -314,6 +314,7 @@ struct arm64_cpu_capabilities {
 			} * const fixed_revs;
 		};
 
+		const struct midr_range *midr_range_list;
 		struct {	/* Feature register checking */
 			u32 sys_reg;
 			u8 field_pos;
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index bf6cfda..e86e65c 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -147,6 +147,15 @@ static inline bool is_midr_in_range(u32 midr, struct midr_range const *range)
 				 range->rv_min, range->rv_max);
 }
 
+static inline bool
+is_midr_in_range_list(u32 midr, struct midr_range const *ranges)
+{
+	while (ranges->model)
+		if (is_midr_in_range(midr, ranges++))
+			return true;
+	return false;
+}
+
 /*
  * The CPU ID never changes at run time, so we might as well tell the
  * compiler that it's constant.  Use this function to read the CPU ID
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 3c0bb6c..9490b560 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -41,6 +41,14 @@ is_affected_midr_range(const struct arm64_cpu_capabilities *entry, int scope)
 }
 
 static bool __maybe_unused
+is_affected_midr_range_list(const struct arm64_cpu_capabilities *entry,
+			    int scope)
+{
+	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
+	return is_midr_in_range_list(read_cpuid_id(), entry->midr_range_list);
+}
+
+static bool __maybe_unused
 is_kryo_midr(const struct arm64_cpu_capabilities *entry, int scope)
 {
 	u32 model;
@@ -250,6 +258,10 @@ qcom_enable_link_stack_sanitization(const struct arm64_cpu_capabilities *entry)
 	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,				\
 	CAP_MIDR_RANGE(model, v_min, r_min, v_max, r_max)
 
+#define CAP_MIDR_RANGE_LIST(list)				\
+	.matches = is_affected_midr_range_list,			\
+	.midr_range_list = list
+
 /* Errata affecting a range of revisions of  given model variant */
 #define ERRATA_MIDR_REV_RANGE(m, var, r_min, r_max)	 \
 	ERRATA_MIDR_RANGE(m, var, r_min, var, r_max)
@@ -263,6 +275,35 @@ qcom_enable_link_stack_sanitization(const struct arm64_cpu_capabilities *entry)
 	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,			\
 	CAP_MIDR_ALL_VERSIONS(model)
 
+/* Errata affecting a list of midr ranges, with same work around */
+#define ERRATA_MIDR_RANGE_LIST(midr_list)			\
+	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,			\
+	CAP_MIDR_RANGE_LIST(midr_list)
+
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+
+/*
+ * List of CPUs where we need to issue a psci call to
+ * harden the branch predictor.
+ */
+static const struct midr_range arm64_bp_harden_smccc_cpus[] = {
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
+	MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
+	MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
+	{},
+};
+
+static const struct midr_range qcom_bp_harden_cpus[] = {
+	MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
+	MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR),
+	{},
+};
+
+#endif
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
 	defined(CONFIG_ARM64_ERRATUM_827319) || \
@@ -406,51 +447,17 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
+		ERRATA_MIDR_RANGE_LIST(arm64_bp_harden_smccc_cpus),
 		.cpu_enable = enable_smccc_arch_workaround_1,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
-		.cpu_enable = enable_smccc_arch_workaround_1,
-	},
-	{
-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
-		.cpu_enable = enable_smccc_arch_workaround_1,
-	},
-	{
-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
-		.cpu_enable = enable_smccc_arch_workaround_1,
-	},
-	{
-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		ERRATA_MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
+		ERRATA_MIDR_RANGE_LIST(qcom_bp_harden_cpus),
 		.cpu_enable = qcom_enable_link_stack_sanitization,
 	},
 	{
 		.capability = ARM64_HARDEN_BP_POST_GUEST_EXIT,
-		ERRATA_MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
-	},
-	{
-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		ERRATA_MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR),
-		.cpu_enable = qcom_enable_link_stack_sanitization,
-	},
-	{
-		.capability = ARM64_HARDEN_BP_POST_GUEST_EXIT,
-		ERRATA_MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR),
-	},
-	{
-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		ERRATA_MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
-		.cpu_enable = enable_smccc_arch_workaround_1,
-	},
-	{
-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		ERRATA_MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
-		.cpu_enable = enable_smccc_arch_workaround_1,
+		ERRATA_MIDR_RANGE_LIST(qcom_bp_harden_cpus),
 	},
 #endif
 	{
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 17132a1..86e2b98 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -882,6 +882,11 @@ static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
 static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 				int scope)
 {
+	/* List of CPUs that are not vulnerable and don't need KPTI */
+	static const struct midr_range kpti_safe_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
+		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
+	};
 	char const *str = "command line option";
 
 	/*
@@ -906,11 +911,8 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 		return true;
 
 	/* Don't force KPTI for CPUs that are not vulnerable */
-	switch (read_cpuid_id() & MIDR_CPU_MODEL_MASK) {
-	case MIDR_CAVIUM_THUNDERX2:
-	case MIDR_BRCM_VULCAN:
+	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
 		return false;
-	}
 
 	/* Defer to CPU feature registers */
 	return !has_cpuid_feature(entry, scope);
-- 
2.7.4
