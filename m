Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeAaSaz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:30:55 -0500
Received: from foss.arm.com ([217.140.101.70]:41600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752018AbeAaS3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:29:09 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        will.deacon@arm.com, mark.rutland@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, ckadabi@codeaurora.org, dave.martin@arm.com,
        jnair@caviumnetworks.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 13/20] arm64: capabilities: Clean up midr range helpers
Date: Wed, 31 Jan 2018 18:28:00 +0000
Message-Id: <20180131182807.32134-14-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131182807.32134-1-suzuki.poulose@arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are about to introduce generic MIDR range helpers. Clean
up the existing helpers in erratum handling, preparing them
to use generic version.

Cc: Dave Martin <dave.martin@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 100 +++++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 44 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 22ec3960a0c5..4351d48b0b0f 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -174,20 +174,35 @@ static void qcom_enable_link_stack_sanitization(
 }
 #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
 
-#define MIDR_RANGE(model, min, max) \
-	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM, \
-	.matches = is_affected_midr_range, \
-	.midr_model = model, \
-	.midr_range_min = min, \
-	.midr_range_max = max
+#define CAP_MIDR_RANGE(model, v_min, r_min, v_max, r_max)	\
+	.matches = is_affected_midr_range,			\
+	.midr_model = model,					\
+	.midr_range_min = MIDR_CPU_VAR_REV(v_min, r_min),	\
+	.midr_range_max = MIDR_CPU_VAR_REV(v_max, r_max)
 
-#define MIDR_ALL_VERSIONS(model) \
-	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM, \
-	.matches = is_affected_midr_range, \
-	.midr_model = model, \
-	.midr_range_min = 0, \
+#define CAP_MIDR_ALL_VERSIONS(model)					\
+	.matches = is_affected_midr_range,				\
+	.midr_model = model,						\
+	.midr_range_min = MIDR_CPU_VAR_REV(0, 0),			\
 	.midr_range_max = (MIDR_VARIANT_MASK | MIDR_REVISION_MASK)
 
+#define ERRATA_MIDR_RANGE(model, v_min, r_min, v_max, r_max)		\
+	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,				\
+	CAP_MIDR_RANGE(model, v_min, r_min, v_max, r_max)
+
+/* Errata affecting a range of revisions of  given model variant */
+#define ERRATA_MIDR_REV_RANGE(m, var, r_min, r_max)	 \
+	ERRATA_MIDR_RANGE(m, var, r_min, var, r_max)
+
+/* Errata affecting a single variant/revision of a model */
+#define ERRATA_MIDR_REV(model, var, rev)	\
+	ERRATA_MIDR_RANGE(model, var, rev, var, rev)
+
+/* Errata affecting all variants/revisions of a given a model */
+#define ERRATA_MIDR_ALL_VERSIONS(model)				\
+	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,			\
+	CAP_MIDR_ALL_VERSIONS(model)
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
 	defined(CONFIG_ARM64_ERRATUM_827319) || \
@@ -196,7 +211,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cortex-A53 r0p[012] */
 		.desc = "ARM errata 826319, 827319, 824069",
 		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
-		MIDR_RANGE(MIDR_CORTEX_A53, 0x00, 0x02),
+		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0x0, 0x0, 0x2),
 		.cpu_enable = cpu_enable_cache_maint_trap,
 	},
 #endif
@@ -205,7 +220,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cortex-A53 r0p[01] */
 		.desc = "ARM errata 819472",
 		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
-		MIDR_RANGE(MIDR_CORTEX_A53, 0x00, 0x01),
+		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0x0, 0x0, 0x01),
 		.cpu_enable = cpu_enable_cache_maint_trap,
 	},
 #endif
@@ -214,9 +229,9 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cortex-A57 r0p0 - r1p2 */
 		.desc = "ARM erratum 832075",
 		.capability = ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE,
-		MIDR_RANGE(MIDR_CORTEX_A57,
-			   MIDR_CPU_VAR_REV(0, 0),
-			   MIDR_CPU_VAR_REV(1, 2)),
+		ERRATA_MIDR_RANGE(MIDR_CORTEX_A57,
+				  0, 0,
+				  1, 2),
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_834220
@@ -224,9 +239,9 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cortex-A57 r0p0 - r1p2 */
 		.desc = "ARM erratum 834220",
 		.capability = ARM64_WORKAROUND_834220,
-		MIDR_RANGE(MIDR_CORTEX_A57,
-			   MIDR_CPU_VAR_REV(0, 0),
-			   MIDR_CPU_VAR_REV(1, 2)),
+		ERRATA_MIDR_RANGE(MIDR_CORTEX_A57,
+				  0, 0,
+				  1, 2),
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_845719
@@ -234,7 +249,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cortex-A53 r0p[01234] */
 		.desc = "ARM erratum 845719",
 		.capability = ARM64_WORKAROUND_845719,
-		MIDR_RANGE(MIDR_CORTEX_A53, 0x00, 0x04),
+		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0x0, 0x0, 0x4),
 	},
 #endif
 #ifdef CONFIG_CAVIUM_ERRATUM_23154
@@ -242,7 +257,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cavium ThunderX, pass 1.x */
 		.desc = "Cavium erratum 23154",
 		.capability = ARM64_WORKAROUND_CAVIUM_23154,
-		MIDR_RANGE(MIDR_THUNDERX, 0x00, 0x01),
+		ERRATA_MIDR_REV_RANGE(MIDR_THUNDERX, 0x0, 0x0, 0x01),
 	},
 #endif
 #ifdef CONFIG_CAVIUM_ERRATUM_27456
@@ -250,15 +265,15 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
 		.desc = "Cavium erratum 27456",
 		.capability = ARM64_WORKAROUND_CAVIUM_27456,
-		MIDR_RANGE(MIDR_THUNDERX,
-			   MIDR_CPU_VAR_REV(0, 0),
-			   MIDR_CPU_VAR_REV(1, 1)),
+		ERRATA_MIDR_RANGE(MIDR_THUNDERX,
+				  0, 0,
+				  1, 1),
 	},
 	{
 	/* Cavium ThunderX, T81 pass 1.0 */
 		.desc = "Cavium erratum 27456",
 		.capability = ARM64_WORKAROUND_CAVIUM_27456,
-		MIDR_RANGE(MIDR_THUNDERX_81XX, 0x00, 0x00),
+		ERRATA_MIDR_REV(MIDR_THUNDERX_81XX, 0x0, 0x0),
 	},
 #endif
 #ifdef CONFIG_CAVIUM_ERRATUM_30115
@@ -266,20 +281,21 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cavium ThunderX, T88 pass 1.x - 2.2 */
 		.desc = "Cavium erratum 30115",
 		.capability = ARM64_WORKAROUND_CAVIUM_30115,
-		MIDR_RANGE(MIDR_THUNDERX, 0x00,
-			   (1 << MIDR_VARIANT_SHIFT) | 2),
+		ERRATA_MIDR_RANGE(MIDR_THUNDERX,
+				      0x0, 0x0,
+				      0x1, 0x2),
 	},
 	{
 	/* Cavium ThunderX, T81 pass 1.0 - 1.2 */
 		.desc = "Cavium erratum 30115",
 		.capability = ARM64_WORKAROUND_CAVIUM_30115,
-		MIDR_RANGE(MIDR_THUNDERX_81XX, 0x00, 0x02),
+		ERRATA_MIDR_REV_RANGE(MIDR_THUNDERX_81XX, 0x0, 0x0, 0x02),
 	},
 	{
 	/* Cavium ThunderX, T83 pass 1.0 */
 		.desc = "Cavium erratum 30115",
 		.capability = ARM64_WORKAROUND_CAVIUM_30115,
-		MIDR_RANGE(MIDR_THUNDERX_83XX, 0x00, 0x00),
+		ERRATA_MIDR_REV(MIDR_THUNDERX_83XX, 0x0, 0x0),
 	},
 #endif
 	{
@@ -293,9 +309,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	{
 		.desc = "Qualcomm Technologies Falkor erratum 1003",
 		.capability = ARM64_WORKAROUND_QCOM_FALKOR_E1003,
-		MIDR_RANGE(MIDR_QCOM_FALKOR_V1,
-			   MIDR_CPU_VAR_REV(0, 0),
-			   MIDR_CPU_VAR_REV(0, 0)),
+		ERRATA_MIDR_REV(MIDR_QCOM_FALKOR_V1, 0, 0),
 	},
 	{
 		.desc = "Qualcomm Technologies Kryo erratum 1003",
@@ -309,9 +323,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	{
 		.desc = "Qualcomm Technologies Falkor erratum 1009",
 		.capability = ARM64_WORKAROUND_REPEAT_TLBI,
-		MIDR_RANGE(MIDR_QCOM_FALKOR_V1,
-			   MIDR_CPU_VAR_REV(0, 0),
-			   MIDR_CPU_VAR_REV(0, 0)),
+		ERRATA_MIDR_REV(MIDR_QCOM_FALKOR_V1, 0, 0),
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_858921
@@ -319,47 +331,47 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cortex-A73 all versions */
 		.desc = "ARM erratum 858921",
 		.capability = ARM64_WORKAROUND_858921,
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
 	},
 #endif
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
 		.cpu_enable = enable_psci_bp_hardening,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
 		.cpu_enable = enable_psci_bp_hardening,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
 		.cpu_enable = enable_psci_bp_hardening,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
 		.cpu_enable = enable_psci_bp_hardening,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
 		.cpu_enable = qcom_enable_link_stack_sanitization,
 	},
 	{
 		.capability = ARM64_HARDEN_BP_POST_GUEST_EXIT,
-		MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
 		.cpu_enable = enable_psci_bp_hardening,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
 		.cpu_enable = enable_psci_bp_hardening,
 	},
 #endif
-- 
2.14.3
