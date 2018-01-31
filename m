Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeAaS3R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:29:17 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41620 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751736AbeAaS3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:29:14 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        will.deacon@arm.com, mark.rutland@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, ckadabi@codeaurora.org, dave.martin@arm.com,
        jnair@caviumnetworks.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 15/20] arm64: capabilities: Add support for checks based on a list of MIDRs
Date: Wed, 31 Jan 2018 18:28:02 +0000
Message-Id: <20180131182807.32134-16-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131182807.32134-1-suzuki.poulose@arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helpers for detecting an errata on list of midr ranges
of affected CPUs, with the same work around.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  1 +
 arch/arm64/kernel/cpu_errata.c      | 61 +++++++++++++++++++++----------------
 arch/arm64/kernel/cpufeature.c      | 10 +++---
 3 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 0cfe42c3225c..462c35d1a38c 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -281,6 +281,7 @@ struct arm64_cpu_capabilities {
 	void (*cpu_enable)(const struct arm64_cpu_capabilities *cap);
 	union {
 		struct midr_range midr_range;	/* To be used for erratum handling only */
+		const struct midr_range *midr_range_list;
 		struct {	/* Feature register checking */
 			u32 sys_reg;
 			u8 field_pos;
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index bc3f7dce42ba..eff5f4e380ac 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -28,6 +28,13 @@ is_affected_midr_range(const struct arm64_cpu_capabilities *entry, int scope)
 	return is_midr_in_range(read_cpuid_id(), &entry->midr_range);
 }
 
+static bool __maybe_unused
+is_affected_midr_range_list(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
+	return is_midr_in_range_list(read_cpuid_id(), entry->midr_range_list);
+}
+
 static bool __maybe_unused
 is_kryo_midr(const struct arm64_cpu_capabilities *entry, int scope)
 {
@@ -184,6 +191,10 @@ static void qcom_enable_link_stack_sanitization(
 	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,				\
 	CAP_MIDR_RANGE(model, v_min, r_min, v_max, r_max)
 
+#define CAP_MIDR_RANGE_LIST(list)				\
+	.matches = is_affected_midr_range_list,			\
+	.midr_range_list = list
+
 /* Errata affecting a range of revisions of  given model variant */
 #define ERRATA_MIDR_REV_RANGE(m, var, r_min, r_max)	 \
 	ERRATA_MIDR_RANGE(m, var, r_min, var, r_max)
@@ -197,6 +208,29 @@ static void qcom_enable_link_stack_sanitization(
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
+static const struct midr_range arm64_bp_harden_psci_cpus[] = {
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
+	MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
+	MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
+	{},
+};
+
+#endif
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
 	defined(CONFIG_ARM64_ERRATUM_827319) || \
@@ -331,22 +365,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
-		.cpu_enable = enable_psci_bp_hardening,
-	},
-	{
-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
-		.cpu_enable = enable_psci_bp_hardening,
-	},
-	{
-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
-		.cpu_enable = enable_psci_bp_hardening,
-	},
-	{
-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
+		ERRATA_MIDR_RANGE_LIST(arm64_bp_harden_psci_cpus),
 		.cpu_enable = enable_psci_bp_hardening,
 	},
 	{
@@ -358,16 +377,6 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.capability = ARM64_HARDEN_BP_POST_GUEST_EXIT,
 		ERRATA_MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
 	},
-	{
-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		ERRATA_MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
-		.cpu_enable = enable_psci_bp_hardening,
-	},
-	{
-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		ERRATA_MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
-		.cpu_enable = enable_psci_bp_hardening,
-	},
 #endif
 	{
 	}
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 247d34ea6b5e..65a8e5cc600c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -864,6 +864,11 @@ static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
 static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 				int scope)
 {
+	/* List of CPUs that are not vulnerable and don't need KPTI */
+	static const struct midr_range kpti_safe_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
+		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
+	};
 
 	/* Forced on command line? */
 	if (__kpti_forced) {
@@ -877,11 +882,8 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
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
2.14.3
