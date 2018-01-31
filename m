Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbeAaS3C (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:29:02 -0500
Received: from foss.arm.com ([217.140.101.70]:41552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751931AbeAaS3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:29:01 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        will.deacon@arm.com, mark.rutland@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, ckadabi@codeaurora.org, dave.martin@arm.com,
        jnair@caviumnetworks.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 09/20] arm64: capabilities: Introduce weak features based on local CPU
Date: Wed, 31 Jan 2018 18:27:56 +0000
Message-Id: <20180131182807.32134-10-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131182807.32134-1-suzuki.poulose@arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have the flexibility of defining system features based
on individual CPUs, introduce CPU feature type that can be detected
on a local SCOPE and ignores the conflict on late CPUs. This is
applicable for ARM64_HAS_NO_HW_PREFETCH, where it is fine for
the system to have CPUs without hardware prefetch turning up
later. We only suffer a performance penalty, nothing fatal.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 8 ++++++++
 arch/arm64/kernel/cpufeature.c      | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index cda62b70d338..7bb3fdec827e 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -214,6 +214,14 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
  */
 #define ARM64_CPUCAP_SYSTEM_FEATURE	\
 	(ARM64_CPUCAP_SCOPE_SYSTEM | ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU)
+/*
+ * CPU feature detected at boot time based on feature of one or more CPUs.
+ * All possible conflicts for a late CPU are ignored.
+ */
+#define ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE		\
+	(ARM64_CPUCAP_SCOPE_LOCAL_CPU		|	\
+	 ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU	|	\
+	 ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU)
 
 struct arm64_cpu_capabilities {
 	const char *desc;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index c710ef28524e..ecc87aa74c64 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -956,7 +956,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "Software prefetching using PRFM",
 		.capability = ARM64_HAS_NO_HW_PREFETCH,
-		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
 		.matches = has_no_hw_prefetch,
 	},
 #ifdef CONFIG_ARM64_UAO
-- 
2.14.3
