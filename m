Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933186AbeCMLwO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:52:14 -0400
Received: from foss.arm.com ([217.140.101.70]:36478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933051AbeCMLwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:52:12 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will.deacon@arm.com, dave.martin@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        ard.biesheuvel@linaro.org, jnair@caviumnetworks.com,
        ckadabi@codeaurora.org, robin.murphy@arm.com, shankerd@codeaurora.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 12/22] arm64: capabilities: Introduce weak features based on local CPU
Date: Tue, 13 Mar 2018 11:51:10 +0000
Message-Id: <20180313115120.17256-13-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313115120.17256-1-suzuki.poulose@arm.com>
References: <20180313115120.17256-1-suzuki.poulose@arm.com>
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
Reviewed-by: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 8 ++++++++
 arch/arm64/kernel/cpufeature.c      | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index c187b926daf9..effb1c038221 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -239,6 +239,14 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
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
index fc6164bc9ef4..0955e02fa638 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1007,7 +1007,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
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
