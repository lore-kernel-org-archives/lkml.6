Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933201AbeCMLwS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:52:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36494 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933051AbeCMLwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:52:15 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will.deacon@arm.com, dave.martin@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        ard.biesheuvel@linaro.org, jnair@caviumnetworks.com,
        ckadabi@codeaurora.org, robin.murphy@arm.com, shankerd@codeaurora.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 13/22] arm64: capabilities: Restrict KPTI detection to boot-time CPUs
Date: Tue, 13 Mar 2018 11:51:11 +0000
Message-Id: <20180313115120.17256-14-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313115120.17256-1-suzuki.poulose@arm.com>
References: <20180313115120.17256-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KPTI is treated as a system wide feature and is only detected if all
the CPUs in the sysetm needs the defense, unless it is forced via kernel
command line. This leaves a system with a mix of CPUs with and without
the defense vulnerable. Also, if a late CPU needs KPTI but KPTI was not
activated at boot time, the CPU is currently allowed to boot, which is a
potential security vulnerability.
This patch ensures that the KPTI is turned on if at least one CPU detects
the capability (i.e, change scope to SCOPE_LOCAL_CPU). Also rejetcs a late
CPU, if it requires the defense, when the system hasn't enabled it,

Cc: Will Deacon <will.deacon@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  9 +++++++++
 arch/arm64/kernel/cpufeature.c      | 16 +++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index effb1c038221..4f050259dff3 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -248,6 +248,15 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
 	 ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU	|	\
 	 ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU)
 
+/*
+ * CPU feature detected at boot time, on one or more CPUs. A late CPU
+ * is not allowed to have the capability when the system doesn't have it.
+ * It is Ok for a late CPU to miss the feature.
+ */
+#define ARM64_CPUCAP_BOOT_RESTRICTED_CPU_LOCAL_FEATURE	\
+	(ARM64_CPUCAP_SCOPE_LOCAL_CPU		|	\
+	 ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU)
+
 struct arm64_cpu_capabilities {
 	const char *desc;
 	u16 capability;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0955e02fa638..0bbab4bd7644 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -877,10 +877,9 @@ static bool has_cache_dic(const struct arm64_cpu_capabilities *entry,
 static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
 
 static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
-				int __unused)
+				int scope)
 {
 	char const *str = "command line option";
-	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
 
 	/*
 	 * For reasons that aren't entirely clear, enabling KPTI on Cavium
@@ -911,8 +910,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 	}
 
 	/* Defer to CPU feature registers */
-	return !cpuid_feature_extract_unsigned_field(pfr0,
-						     ID_AA64PFR0_CSV3_SHIFT);
+	return !has_cpuid_feature(entry, scope);
 }
 
 static void
@@ -1059,7 +1057,15 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "Kernel page table isolation (KPTI)",
 		.capability = ARM64_UNMAP_KERNEL_AT_EL0,
-		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.type = ARM64_CPUCAP_BOOT_RESTRICTED_CPU_LOCAL_FEATURE,
+		/*
+		 * The ID feature fields below are used to indicate that
+		 * the CPU doesn't need KPTI. See unmap_kernel_at_el0 for
+		 * more details.
+		 */
+		.sys_reg = SYS_ID_AA64PFR0_EL1,
+		.field_pos = ID_AA64PFR0_CSV3_SHIFT,
+		.min_field_value = 1,
 		.matches = unmap_kernel_at_el0,
 		.cpu_enable = kpti_install_ng_mappings,
 	},
-- 
2.14.3
