Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeAaS3H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:29:07 -0500
Received: from foss.arm.com ([217.140.101.70]:41580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751931AbeAaS3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:29:05 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        will.deacon@arm.com, mark.rutland@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, ckadabi@codeaurora.org, dave.martin@arm.com,
        jnair@caviumnetworks.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v2 11/20] arm64: capabilities: Add support for features enabled early
Date: Wed, 31 Jan 2018 18:27:58 +0000
Message-Id: <20180131182807.32134-12-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131182807.32134-1-suzuki.poulose@arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel detects and uses some of the features based on the boot
CPU and expects that all the following CPUs conform to it. e.g,
with VHE and the boot CPU running at EL2, the kernel decides to
keep the kernel running at EL2. If another CPU is brought up without
this capability, we use custom hooks (via check_early_cpu_features())
to handle it. To handle such capabilities add support for detecting
and enabling capabilities based on the boot CPU.

A bit is added to indicate if the capability should be detected
early on the boot CPU. The infrastructure then ensures that such
capabilities are probed and "enabled" early on in the boot CPU
and, enabled on the subsequent CPUs.

Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 48 +++++++++++++++++++++++++++++--------
 arch/arm64/kernel/cpufeature.c      | 48 +++++++++++++++++++++++++++----------
 2 files changed, 74 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 71993dd4afae..04161aac0f06 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -104,7 +104,7 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
  *    some checks at runtime. This could be, e.g, checking the value of a field
  *    in CPU ID feature register or checking the cpu model. The capability
  *    provides a call back ( @matches() ) to perform the check.
- *    Scope defines how the checks should be performed. There are two cases:
+ *    Scope defines how the checks should be performed. There are three cases:
  *
  *     a) SCOPE_LOCAL_CPU: check all the CPUs and "detect" if at least one
  *        matches. This implies, we have to run the check on all the booting
@@ -117,6 +117,11 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
  *        field in one of the CPU ID feature registers, we use the sanitised
  *        value of the register from the CPU feature infrastructure to make
  *        the decision.
+ *		Or
+ *     c) SCOPE_BOOT_CPU: Check only on the primary boot CPU to detect the feature.
+ *        This category is for features that are "finalised" (or used) by the kernel
+ *        very early even before the SMP cpus are brought up.
+ *
  *    The process of detection is usually denoted by "update" capability state
  *    in the code.
  *
@@ -129,6 +134,10 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
  *    EL2 with Virtualisation Host Extensions). The kernel usually disallows
  *    any changes to the state of a capability once it finalises the capability
  *    and takes any action, as it may be impossible to execute the actions safely.
+ *    At the moment there are two passes of finalising the capabilities.
+ *      a) Boot CPU scope capabilities - Finalised by primary boot CPU via
+ *         setup_boot_cpu_capabilities().
+ *      b) Everything except (a) - Run via setup_system_capabilities().
  *
  * 3) Verification: When a CPU is brought online (e.g, by user or by the kernel),
  *    the kernel should make sure that it is safe to use the CPU, by verifying
@@ -139,11 +148,22 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
  *
  *    As explained in (2) above, capabilities could be finalised at different
  *    points in the execution. Each CPU is verified against the "finalised"
- *    capabilities and if there is a conflict, the kernel takes an action, based
- *    on the severity (e.g, a CPU could be prevented from booting or cause a
- *    kernel panic). The CPU is allowed to "affect" the state of the capability,
- *    if it has not been finalised already. See section 5 for more details on
- *    conflicts.
+ *    capabilities.
+ *
+ *	x------------------------------------------------------------------- x
+ *	| Verification:       | Boot CPU | SMP CPUs by kernel | CPUs by user |
+ *	|--------------------------------------------------------------------|
+ *	| Primary boot CPU    |          |                    |              |
+ *	|  capability         |   n      |      y             |       y      |
+ *	|--------------------------------------------------------------------|
+ *	| All others          |   n      |      n             |       y      |
+ *	x--------------------------------------------------------------------x
+ *
+ *
+ *    If there is a conflict, the kernel takes an action, based on the severity
+ *    (e.g, a CPU could be prevented from booting or cause a kernel panic).
+ *    The CPU is allowed to "affect" the state of the capability, if it has not
+ *    been finalised already. See section 5 for more details on conflicts.
  *
  * 4) Action: As mentioned in (2), the kernel can take an action for each detected
  *    capability, on all CPUs on the system. This is always initiated only after
@@ -186,20 +206,28 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
  */
 
 
-/* Decide how the capability is detected. On a local CPU vs System wide */
-#define ARM64_CPUCAP_SCOPE_MASK			0x3
+/*
+ * Decide how the capability is detected.
+ * On any local CPU vs System wide vs the primary boot CPU
+ */
+#define ARM64_CPUCAP_SCOPE_MASK			0x7
 #define ARM64_CPUCAP_SCOPE_LOCAL_CPU		((u16)BIT(0))
 #define ARM64_CPUCAP_SCOPE_SYSTEM		((u16)BIT(1))
+/*
+ * The capabilitiy is detected on the Boot CPU and is used by kernel
+ * during early boot. i.e, the capability should be "detected" and "enabled"
+ * as early as possibly on all booting CPUs.
+ */
+#define ARM64_CPUCAP_SCOPE_BOOT_CPU		((u16)BIT(2))
 #define SCOPE_SYSTEM				ARM64_CPUCAP_SCOPE_SYSTEM
 #define SCOPE_LOCAL_CPU				ARM64_CPUCAP_SCOPE_LOCAL_CPU
+#define SCOPE_BOOT_CPU				ARM64_CPUCAP_SCOPE_BOOT_CPU
 
 /* Is it permitted for a late CPU to have this capability when system doesn't already have */
 #define ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU	((u16)BIT(4))
 /* Is it safe for a late CPU to miss this capability when system has it */
 #define ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU	((u16)BIT(5))
 
-#define ARM64_CPUCAP_SCOPE_ALL			 \
-	(ARM64_CPUCAP_SCOPE_LOCAL_CPU | ARM64_CPUCAP_SCOPE_SYSTEM)
 /*
  * CPU errata detected at boot time based on feature of one or more CPUs.
  * It is not safe for a late CPU to have this feature when the system doesn't
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 4a55492784b7..6d759f068de1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -504,7 +504,7 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 }
 
 extern const struct arm64_cpu_capabilities arm64_errata[];
-static void update_cpu_local_capabilities(void);
+static void __init setup_boot_cpu_capabilities(void);
 
 void __init init_cpu_features(struct cpuinfo_arm64 *info)
 {
@@ -550,10 +550,10 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	}
 
 	/*
-	 * Run the errata work around checks on the boot CPU, once we have
-	 * initialised the cpu feature infrastructure.
+	 * Detect and enable early CPU features based on the boot CPU, after
+	 * we have initialised the CPU feature infrastructure.
 	 */
-	update_cpu_local_capabilities();
+	setup_boot_cpu_capabilities();
 }
 
 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
@@ -1235,12 +1235,21 @@ __enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps, u16 scope_m
 
 		if (caps->cpu_enable) {
 			/*
-			 * Use stop_machine() as it schedules the work allowing
-			 * us to modify PSTATE, instead of on_each_cpu() which
-			 * uses an IPI, giving us a PSTATE that disappears when
-			 * we return.
+			 * If we are dealing with EARLY detected features, we
+			 * have to enable this only on the Boot CPU, where it
+			 * is detected. All the secondaries enable it via
+			 * verify_early_cpu_capabilities().
+			 *
+			 * Otherwise, use stop_machine() as it schedules the
+			 * work allowing us to modify PSTATE, instead of
+			 * on_each_cpu() which uses an IPI, giving us a PSTATE
+			 * that disappears when we return.
 			 */
-			stop_machine(__enable_cpu_capability, (void *)caps, cpu_online_mask);
+			if (scope_mask & ARM64_CPUCAP_SCOPE_BOOT_CPU)
+				caps->cpu_enable(caps);
+			else
+				stop_machine(__enable_cpu_capability,
+					(void *)caps, cpu_online_mask);
 		}
 	}
 }
@@ -1315,6 +1324,12 @@ static void check_early_cpu_features(void)
 {
 	verify_cpu_run_el();
 	verify_cpu_asid_bits();
+	/*
+	 * Early features are used by the kernel already. If there
+	 * is a conflict, we cannot proceed further.
+	 */
+	if (!verify_local_cpu_caps(ARM64_CPUCAP_SCOPE_BOOT_CPU))
+		cpu_panic_kernel();
 }
 
 static void
@@ -1381,7 +1396,7 @@ static void enable_cpu_capabilities(u16 scope_mask)
  */
 static void verify_local_cpu_capabilities(void)
 {
-	if (!verify_local_cpu_caps(ARM64_CPUCAP_SCOPE_ALL))
+	if (!verify_local_cpu_caps(~ARM64_CPUCAP_SCOPE_BOOT_CPU))
 		cpu_die_early();
 	verify_local_elf_hwcaps(arm64_elf_hwcaps);
 
@@ -1415,6 +1430,15 @@ void check_local_cpu_capabilities(void)
 		verify_local_cpu_capabilities();
 }
 
+static void __init setup_boot_cpu_capabilities(void)
+{
+	/* Detect capabilities with either SCOPE_BOOT_CPU or SCOPE_LOCAL_CPU */
+	update_cpu_capabilities(ARM64_CPUCAP_SCOPE_BOOT_CPU |
+				 ARM64_CPUCAP_SCOPE_LOCAL_CPU);
+	/* Enable the SCOPE_BOOT_CPU capabilities alone right away */
+	enable_cpu_capabilities(ARM64_CPUCAP_SCOPE_BOOT_CPU);
+}
+
 static void __init setup_system_capabilities(void)
 {
 	/*
@@ -1422,8 +1446,8 @@ static void __init setup_system_capabilities(void)
 	 * finalise the capabilities that depend on it.
 	 */
 	update_system_capabilities();
-	/* Enable all the available capabilities */
-	enable_cpu_capabilities(ARM64_CPUCAP_SCOPE_ALL);
+	/* Enable all the available capabilities, which are not already enabled. */
+	enable_cpu_capabilities(~ARM64_CPUCAP_SCOPE_BOOT_CPU);
 }
 
 DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
-- 
2.14.3
