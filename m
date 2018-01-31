Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbeAaS3t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:29:49 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41672 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750829AbeAaS3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:29:23 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        will.deacon@arm.com, mark.rutland@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, ckadabi@codeaurora.org, dave.martin@arm.com,
        jnair@caviumnetworks.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 19/20] arm64: Delay enabling hardware DBM feature
Date: Wed, 31 Jan 2018 18:28:06 +0000
Message-Id: <20180131182807.32134-20-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131182807.32134-1-suzuki.poulose@arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We enable hardware DBM bit in a capable CPU, very early in the
boot via __cpu_setup. This doesn't give us a flexibility of
optionally disable the feature, as the clearing the bit
is a bit costly as the TLB can cache the settings. Instead,
we delay enabling the feature until the CPU is brought up
into the kernel. We use the feature capability mechanism
to handle it.

The hardware DBM is a non-conflicting feature. i.e, the kernel
can safely run with a mix of CPUs with some using the feature
and the others don't. So, it is safe for a late CPU to have
this capability and enable it, even if the active CPUs don't.

To get this handled properly by the infrastructure, we
unconditionally set the capability and only enable it
on CPUs which really have the feature.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpucaps.h |  3 ++-
 arch/arm64/kernel/cpufeature.c   | 40 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/proc.S             |  9 +++------
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index bb263820de13..8df80cc828ac 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -45,7 +45,8 @@
 #define ARM64_HARDEN_BRANCH_PREDICTOR		24
 #define ARM64_HARDEN_BP_POST_GUEST_EXIT		25
 #define ARM64_HAS_RAS_EXTN			26
+#define ARM64_HW_DBM				27
 
-#define ARM64_NCAPS				27
+#define ARM64_NCAPS				28
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 13e30c1b1e99..1f695a998eed 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -903,6 +903,33 @@ static int __init parse_kpti(char *str)
 __setup("kpti=", parse_kpti);
 #endif	/* CONFIG_UNMAP_KERNEL_AT_EL0 */
 
+#ifdef CONFIG_ARM64_HW_AFDBM
+static bool has_hw_dbm(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	/*
+	 * DBM is a non-conflicting feature. i.e, the kernel can safely run
+	 * a mix of CPUs with and without the feature. So, we unconditionally
+	 * enable the capability to allow any late CPU to use the feature.
+	 * We only enable the control bits on the CPU, if it actually supports.
+	 */
+	return true;
+}
+
+static inline void __cpu_enable_hw_dbm(void)
+{
+	u64 tcr = read_sysreg(tcr_el1) | TCR_HD;
+
+	write_sysreg(tcr, tcr_el1);
+	isb();
+}
+
+static void cpu_enable_hw_dbm(struct arm64_cpu_capabilities const *cap)
+{
+	if (has_cpuid_feature(cap, SCOPE_LOCAL_CPU))
+		__cpu_enable_hw_dbm();
+}
+#endif
+
 static void cpu_copy_el2regs(const struct arm64_cpu_capabilities *__unused)
 {
 	/*
@@ -1059,6 +1086,19 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.cpu_enable = cpu_clear_disr,
 	},
 #endif /* CONFIG_ARM64_RAS_EXTN */
+#ifdef CONFIG_ARM64_HW_AFDBM
+	{
+		.desc = "Hardware pagetable Dirty Bit Management",
+		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
+		.capability = ARM64_HW_DBM,
+		.sys_reg = SYS_ID_AA64MMFR1_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64MMFR1_HADBS_SHIFT,
+		.min_field_value = 2,
+		.matches = has_hw_dbm,
+		.cpu_enable = cpu_enable_hw_dbm,
+	},
+#endif
 	{},
 };
 
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 9f177aac6390..68e08ad54944 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -253,12 +253,9 @@ ENTRY(__cpu_setup)
 	 */
 	mrs	x9, ID_AA64MMFR1_EL1
 	and	x9, x9, #0xf
-	cbz	x9, 2f
-	cmp	x9, #2
-	b.lt	1f
-	orr	x10, x10, #TCR_HD		// hardware Dirty flag update
-1:	orr	x10, x10, #TCR_HA		// hardware Access flag update
-2:
+	cbz	x9, 1f
+	orr	x10, x10, #TCR_HA		// hardware Access flag update
+1:
 #endif	/* CONFIG_ARM64_HW_AFDBM */
 	msr	tcr_el1, x10
 	ret					// return to head.S
-- 
2.14.3
