Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbeAaS3K (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:29:10 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41588 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751931AbeAaS3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:29:07 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        will.deacon@arm.com, mark.rutland@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, ckadabi@codeaurora.org, dave.martin@arm.com,
        jnair@caviumnetworks.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 12/20] arm64: capabilities: Change scope of VHE to Boot CPU feature
Date: Wed, 31 Jan 2018 18:27:59 +0000
Message-Id: <20180131182807.32134-13-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131182807.32134-1-suzuki.poulose@arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We expect all CPUs to be running at the same EL inside the kernel
with or without VHE enabled and we have strict checks to ensure
that any mismatch triggers a kernel panic. If VHE is enabled,
we use the feature based on the boot CPU and all other CPUs
should follow. This makes it a perfect candidate for a cpability
based on the boot CPU,  which should be matched by all the CPUs
(both when is ON and OFF). This saves us some not-so-pretty
hooks and special code, just for verifying the conflict.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  7 +++++++
 arch/arm64/include/asm/virt.h       |  6 ------
 arch/arm64/kernel/cpufeature.c      |  3 +--
 arch/arm64/kernel/smp.c             | 38 -------------------------------------
 4 files changed, 8 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 04161aac0f06..42292a0b93a4 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -260,6 +260,13 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
 	(ARM64_CPUCAP_SCOPE_LOCAL_CPU		|	\
 	 ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU)
 
+/*
+ * Critical CPU feature used early in the boot based on the boot CPU.
+ * The feature should be matched by all booting CPU (both miss and hit
+ * cases).
+ */
+#define ARM64_CPUCAP_CRITICAL_BOOT_CPU_FEATURE ARM64_CPUCAP_SCOPE_BOOT_CPU
+
 struct arm64_cpu_capabilities {
 	const char *desc;
 	u16 capability;
diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index c5f89442785c..9d1e24e030b3 100644
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
index 6d759f068de1..247d34ea6b5e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -982,7 +982,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "Virtualization Host Extensions",
 		.capability = ARM64_HAS_VIRT_HOST_EXTN,
-		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.type = ARM64_CPUCAP_CRITICAL_BOOT_CPU_FEATURE,
 		.matches = runs_at_el2,
 		.cpu_enable = cpu_copy_el2regs,
 	},
@@ -1322,7 +1322,6 @@ static bool verify_local_cpu_caps(u16 scope_mask)
  */
 static void check_early_cpu_features(void)
 {
-	verify_cpu_run_el();
 	verify_cpu_asid_bits();
 	/*
 	 * Early features are used by the kernel already. If there
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 5cef11450183..f3e2e3aec0b0 100644
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
2.14.3
