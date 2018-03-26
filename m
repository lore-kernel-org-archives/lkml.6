Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbeCZONv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:13:51 -0400
Received: from foss.arm.com ([217.140.101.70]:41130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752462AbeCZONt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:13:49 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, dave.martin@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        ckadabi@codeaurora.org, shankerd@codeaurora.org,
        ard.biesheuvel@linaro.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 15/22] arm64: capabilities: Change scope of VHE to Boot CPU feature
Date: Mon, 26 Mar 2018 15:12:42 +0100
Message-Id: <1522073569-29174-16-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522073569-29174-1-git-send-email-suzuki.poulose@arm.com>
References: <1522073569-29174-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We expect all CPUs to be running at the same EL inside the kernel
with or without VHE enabled and we have strict checks to ensure
that any mismatch triggers a kernel panic. If VHE is enabled,
we use the feature based on the boot CPU and all other CPUs
should follow. This makes it a perfect candidate for a capability
based on the boot CPU,  which should be matched by all the CPUs
(both when is ON and OFF). This saves us some not-so-pretty
hooks and special code, just for verifying the conflict.

The patch also makes the VHE capability entry depend on
CONFIG_ARM64_VHE.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V4:
 - Fixed typo in the commit description pointed out by Dave
 - Added Dave's Reviewed-by
---
 arch/arm64/include/asm/cpufeature.h |  6 ++++++
 arch/arm64/include/asm/virt.h       |  6 ------
 arch/arm64/kernel/cpufeature.c      |  5 +++--
 arch/arm64/kernel/smp.c             | 38 -------------------------------------
 4 files changed, 9 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 2f5edef..6a12804 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -287,6 +287,12 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
 	(ARM64_CPUCAP_SCOPE_LOCAL_CPU		|	\
 	 ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU)
 
+/*
+ * CPU feature used early in the boot based on the boot CPU. All secondary
+ * CPUs must match the state of the capability as detected by the boot CPU.
+ */
+#define ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE ARM64_CPUCAP_SCOPE_BOOT_CPU
+
 struct arm64_cpu_capabilities {
 	const char *desc;
 	u16 capability;
diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index c5f8944..9d1e24e 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -102,12 +102,6 @@ static inline bool has_vhe(void)
 	return false;
 }
 
-#ifdef CONFIG_ARM64_VHE
-extern void verify_cpu_run_el(void);
-#else
-static inline void verify_cpu_run_el(void) {}
-#endif
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* ! __ASM__VIRT_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b2903d5..17132a1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1033,13 +1033,15 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = cpufeature_pan_not_uao,
 	},
 #endif /* CONFIG_ARM64_PAN */
+#ifdef CONFIG_ARM64_VHE
 	{
 		.desc = "Virtualization Host Extensions",
 		.capability = ARM64_HAS_VIRT_HOST_EXTN,
-		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
 		.matches = runs_at_el2,
 		.cpu_enable = cpu_copy_el2regs,
 	},
+#endif	/* CONFIG_ARM64_VHE */
 	{
 		.desc = "32-bit EL0 Support",
 		.capability = ARM64_HAS_32BIT_EL0,
@@ -1409,7 +1411,6 @@ static bool verify_local_cpu_caps(u16 scope_mask)
  */
 static void check_early_cpu_features(void)
 {
-	verify_cpu_run_el();
 	verify_cpu_asid_bits();
 	/*
 	 * Early features are used by the kernel already. If there
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 5cef114..f3e2e3a 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -85,43 +85,6 @@ enum ipi_msg_type {
 	IPI_WAKEUP
 };
 
-#ifdef CONFIG_ARM64_VHE
-
-/* Whether the boot CPU is running in HYP mode or not*/
-static bool boot_cpu_hyp_mode;
-
-static inline void save_boot_cpu_run_el(void)
-{
-	boot_cpu_hyp_mode = is_kernel_in_hyp_mode();
-}
-
-static inline bool is_boot_cpu_in_hyp_mode(void)
-{
-	return boot_cpu_hyp_mode;
-}
-
-/*
- * Verify that a secondary CPU is running the kernel at the same
- * EL as that of the boot CPU.
- */
-void verify_cpu_run_el(void)
-{
-	bool in_el2 = is_kernel_in_hyp_mode();
-	bool boot_cpu_el2 = is_boot_cpu_in_hyp_mode();
-
-	if (in_el2 ^ boot_cpu_el2) {
-		pr_crit("CPU%d: mismatched Exception Level(EL%d) with boot CPU(EL%d)\n",
-					smp_processor_id(),
-					in_el2 ? 2 : 1,
-					boot_cpu_el2 ? 2 : 1);
-		cpu_panic_kernel();
-	}
-}
-
-#else
-static inline void save_boot_cpu_run_el(void) {}
-#endif
-
 #ifdef CONFIG_HOTPLUG_CPU
 static int op_cpu_kill(unsigned int cpu);
 #else
@@ -447,7 +410,6 @@ void __init smp_prepare_boot_cpu(void)
 	 */
 	jump_label_init();
 	cpuinfo_store_boot_cpu();
-	save_boot_cpu_run_el();
 }
 
 static u64 __init of_get_cpu_mpidr(struct device_node *dn)
-- 
2.7.4
