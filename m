Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbeBISCH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 13:02:07 -0500
Received: from foss.arm.com ([217.140.101.70]:50512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752781AbeBIR6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:58:04 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: dave.martin@arm.com, linux-kernel@vger.kernel.org, will.deacon@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        jnair@caviumnetworks.com, ckadabi@codeaurora.org, robin.murphy@arm.com,
        ard.biesheuvel@linaro.org, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 13/22] arm64: capabilities: Restrict KPTI detection to boot-time CPUs
Date: Fri,  9 Feb 2018 17:54:56 +0000
Message-Id: <20180209175513.17100-27-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180209175513.17100-1-suzuki.poulose@arm.com>
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
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
index 49c4ae331ca7..383c69c95f23 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -239,6 +239,15 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
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
index 373173bc3ab3..a15be4db6bf4 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -862,10 +862,9 @@ static bool has_no_fpsimd(const struct arm64_cpu_capabilities *entry, int __unus
 static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
 
 static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
-				int __unused)
+				int scope)
 {
 	char const *str = "command line option";
-	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
 
 	/*
 	 * For reasons that aren't entirely clear, enabling KPTI on Cavium
@@ -896,8 +895,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 	}
 
 	/* Defer to CPU feature registers */
-	return !cpuid_feature_extract_unsigned_field(pfr0,
-						     ID_AA64PFR0_CSV3_SHIFT);
+	return !has_cpuid_feature(entry, scope);
 }
 
 static void
@@ -1044,7 +1042,15 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
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
