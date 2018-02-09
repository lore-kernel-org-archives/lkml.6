Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeBIR5i (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 12:57:38 -0500
Received: from foss.arm.com ([217.140.101.70]:50342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752534AbeBIR5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:57:36 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: dave.martin@arm.com, linux-kernel@vger.kernel.org, will.deacon@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        jnair@caviumnetworks.com, ckadabi@codeaurora.org, robin.murphy@arm.com,
        ard.biesheuvel@linaro.org, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 07/21] arm64: capabilities: Prepare for grouping features and errata work arounds
Date: Fri,  9 Feb 2018 17:54:44 +0000
Message-Id: <20180209175513.17100-15-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180209175513.17100-1-suzuki.poulose@arm.com>
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are about to group the handling of all capabilities (features
and errata workarounds). This patch open codes the wrapper routines
to make it easier to merge the handling.

Cc: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 60 +++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 3447821bec5a..9f52678a4df1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -504,7 +504,8 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 }
 
 extern const struct arm64_cpu_capabilities arm64_errata[];
-static void update_cpu_errata_workarounds(void);
+static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
+				    u16 scope_mask, const char *info);
 
 void __init init_cpu_features(struct cpuinfo_arm64 *info)
 {
@@ -553,7 +554,8 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	 * Run the errata work around checks on the boot CPU, once we have
 	 * initialised the cpu feature infrastructure.
 	 */
-	update_cpu_errata_workarounds();
+	update_cpu_capabilities(arm64_errata, SCOPE_ALL,
+				"enabling workaround for");
 }
 
 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
@@ -1350,12 +1352,6 @@ verify_local_elf_hwcaps(const struct arm64_cpu_capabilities *caps)
 		}
 }
 
-static void verify_local_cpu_features(void)
-{
-	if (!__verify_local_cpu_caps(arm64_features, SCOPE_ALL))
-		cpu_die_early();
-}
-
 static void verify_sve_features(void)
 {
 	u64 safe_zcr = read_sanitised_ftr_reg(SYS_ZCR_EL1);
@@ -1373,27 +1369,6 @@ static void verify_sve_features(void)
 	/* Add checks on other ZCR bits here if necessary */
 }
 
-/*
- * The CPU Errata work arounds are detected and applied at boot time
- * and the related information is freed soon after. If the new CPU requires
- * an errata not detected at boot, fail this CPU.
- */
-static void verify_local_cpu_errata_workarounds(void)
-{
-	if (!__verify_local_cpu_caps(arm64_errata, SCOPE_ALL))
-		cpu_die_early();
-}
-
-static void update_cpu_errata_workarounds(void)
-{
-	update_cpu_capabilities(arm64_errata, SCOPE_ALL,
-				"enabling workaround for");
-}
-
-static void __init enable_errata_workarounds(void)
-{
-	enable_cpu_capabilities(arm64_errata, SCOPE_ALL);
-}
 
 /*
  * Run through the enabled system capabilities and enable() it on this CPU.
@@ -1405,8 +1380,15 @@ static void __init enable_errata_workarounds(void)
  */
 static void verify_local_cpu_capabilities(void)
 {
-	verify_local_cpu_errata_workarounds();
-	verify_local_cpu_features();
+	/*
+	 * The CPU Errata work arounds are detected and applied at boot time
+	 * and the related information is freed soon after. If the new CPU
+	 * requires an errata not detected at boot, fail this CPU.
+	 */
+	if (!__verify_local_cpu_caps(arm64_errata, SCOPE_ALL))
+		cpu_die_early();
+	if (!__verify_local_cpu_caps(arm64_features, SCOPE_ALL))
+		cpu_die_early();
 	verify_local_elf_hwcaps(arm64_elf_hwcaps);
 
 	if (system_supports_32bit_el0())
@@ -1434,18 +1416,12 @@ void check_local_cpu_capabilities(void)
 	 * advertised capabilities.
 	 */
 	if (!sys_caps_initialised)
-		update_cpu_errata_workarounds();
+		update_cpu_capabilities(arm64_errata, SCOPE_ALL,
+					"enabling workaround for");
 	else
 		verify_local_cpu_capabilities();
 }
 
-static void __init setup_feature_capabilities(void)
-{
-	update_cpu_capabilities(arm64_features, SCOPE_ALL,
-				"detected feature:");
-	enable_cpu_capabilities(arm64_features, SCOPE_ALL);
-}
-
 DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
 EXPORT_SYMBOL(arm64_const_caps_ready);
 
@@ -1468,8 +1444,10 @@ void __init setup_cpu_features(void)
 	int cls;
 
 	/* Set the CPU feature capabilies */
-	setup_feature_capabilities();
-	enable_errata_workarounds();
+	update_cpu_capabilities(arm64_features, SCOPE_ALL,
+				"detected feature:");
+	enable_cpu_capabilities(arm64_features, SCOPE_ALL);
+	enable_cpu_capabilities(arm64_errata, SCOPE_ALL);
 	mark_const_caps_ready();
 	setup_elf_hwcaps(arm64_elf_hwcaps);
 
-- 
2.14.3
