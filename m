Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752964AbeBISAk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 13:00:40 -0500
Received: from foss.arm.com ([217.140.101.70]:50602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752866AbeBIR6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:58:21 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: dave.martin@arm.com, linux-kernel@vger.kernel.org, will.deacon@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        jnair@caviumnetworks.com, ckadabi@codeaurora.org, robin.murphy@arm.com,
        ard.biesheuvel@linaro.org, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 17/22] arm64: Add helpers for checking CPU MIDR against a range
Date: Fri,  9 Feb 2018 17:55:03 +0000
Message-Id: <20180209175513.17100-34-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180209175513.17100-1-suzuki.poulose@arm.com>
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helpers for checking if the given CPU midr falls in a range
of variants/revisions for a given model.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  7 ++-----
 arch/arm64/include/asm/cputype.h    | 30 ++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c      | 16 +++++-----------
 3 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index dfce93f79ae7..e47f39f62440 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -10,6 +10,7 @@
 #define __ASM_CPUFEATURE_H
 
 #include <asm/cpucaps.h>
+#include <asm/cputype.h>
 #include <asm/fpsimd.h>
 #include <asm/hwcap.h>
 #include <asm/sigcontext.h>
@@ -295,11 +296,7 @@ struct arm64_cpu_capabilities {
 	 */
 	void (*cpu_enable)(const struct arm64_cpu_capabilities *cap);
 	union {
-		struct {	/* To be used for erratum handling only */
-			u32 midr_model;
-			u32 midr_range_min, midr_range_max;
-		};
-
+		struct midr_range midr_range;	/* To be used for erratum handling only */
 		struct {	/* Feature register checking */
 			u32 sys_reg;
 			u8 field_pos;
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 2f8d39ed9c2e..6c45acb6ef38 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -115,6 +115,36 @@
 
 #define read_cpuid(reg)			read_sysreg_s(SYS_ ## reg)
 
+/*
+ * Represent a range of MIDR values for a given CPU model and a
+ * range of variant/revision values.
+ *
+ * @model	- CPU model as defined by MIDR_CPU_MODEL
+ * @rv_min	- Minimum value for the revision/variant as defined by
+ *		  MIDR_CPU_VAR_REV
+ * @rv_max	- Maximum value for the variant/revision for the range.
+ */
+struct midr_range {
+	u32 model;
+	u32 rv_min;
+	u32 rv_max;
+};
+
+#define MIDR_RANGE(m, v_min, r_min, v_max, r_max)		\
+	{							\
+		.model = m,					\
+		.rv_min = MIDR_CPU_VAR_REV(v_min, r_min),	\
+		.rv_max = MIDR_CPU_VAR_REV(v_max, r_max),	\
+	}
+
+#define MIDR_ALL_VERSIONS(m) MIDR_RANGE(m, 0, 0, 0xf, 0xf)
+
+static inline bool is_midr_in_range(u32 midr, struct midr_range const *range)
+{
+	return MIDR_IS_CPU_MODEL_RANGE(midr, range->model,
+				 range->rv_min, range->rv_max);
+}
+
 /*
  * The CPU ID never changes at run time, so we might as well tell the
  * compiler that it's constant.  Use this function to read the CPU ID
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 22ea61141596..5f903e37a267 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -25,9 +25,7 @@ static bool __maybe_unused
 is_affected_midr_range(const struct arm64_cpu_capabilities *entry, int scope)
 {
 	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
-	return MIDR_IS_CPU_MODEL_RANGE(read_cpuid_id(), entry->midr_model,
-				       entry->midr_range_min,
-				       entry->midr_range_max);
+	return is_midr_in_range(read_cpuid_id(), &entry->midr_range);
 }
 
 static bool __maybe_unused
@@ -41,7 +39,7 @@ is_kryo_midr(const struct arm64_cpu_capabilities *entry, int scope)
 	model &= MIDR_IMPLEMENTOR_MASK | (0xf00 << MIDR_PARTNUM_SHIFT) |
 		 MIDR_ARCHITECTURE_MASK;
 
-	return model == entry->midr_model;
+	return model == entry->midr_range.model;
 }
 
 static bool
@@ -227,15 +225,11 @@ qcom_enable_link_stack_sanitization(const struct arm64_cpu_capabilities *entry)
 
 #define CAP_MIDR_RANGE(model, v_min, r_min, v_max, r_max)	\
 	.matches = is_affected_midr_range,			\
-	.midr_model = model,					\
-	.midr_range_min = MIDR_CPU_VAR_REV(v_min, r_min),	\
-	.midr_range_max = MIDR_CPU_VAR_REV(v_max, r_max)
+	.midr_range = MIDR_RANGE(model, v_min, r_min, v_max, r_max)
 
 #define CAP_MIDR_ALL_VERSIONS(model)					\
 	.matches = is_affected_midr_range,				\
-	.midr_model = model,						\
-	.midr_range_min = MIDR_CPU_VAR_REV(0, 0),			\
-	.midr_range_max = (MIDR_VARIANT_MASK | MIDR_REVISION_MASK)
+	.midr_range = MIDR_ALL_VERSIONS(model)
 
 #define ERRATA_MIDR_RANGE(model, v_min, r_min, v_max, r_max)		\
 	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,				\
@@ -366,7 +360,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.desc = "Qualcomm Technologies Kryo erratum 1003",
 		.capability = ARM64_WORKAROUND_QCOM_FALKOR_E1003,
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
-		.midr_model = MIDR_QCOM_KRYO,
+		.midr_range.model = MIDR_QCOM_KRYO,
 		.matches = is_kryo_midr,
 	},
 #endif
-- 
2.14.3
