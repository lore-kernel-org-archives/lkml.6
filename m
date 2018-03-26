Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752347AbeCZONg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:13:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41042 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752299AbeCZONc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:13:32 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, dave.martin@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        ckadabi@codeaurora.org, shankerd@codeaurora.org,
        ard.biesheuvel@linaro.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 08/22] arm64: capabilities: Prepare for grouping features and errata work arounds
Date: Mon, 26 Mar 2018 15:12:35 +0100
Message-Id: <1522073569-29174-9-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522073569-29174-1-git-send-email-suzuki.poulose@arm.com>
References: <1522073569-29174-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are about to group the handling of all capabilities (features
and errata workarounds). This patch open codes the wrapper routines
to make it easier to merge the handling.

Reviewed-by: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 58 +++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index c49535d..703215f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -510,7 +510,8 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 }
 
 extern const struct arm64_cpu_capabilities arm64_errata[];
-static void update_cpu_errata_workarounds(void);
+static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
+				    u16 scope_mask, const char *info);
 
 void __init init_cpu_features(struct cpuinfo_arm64 *info)
 {
@@ -559,7 +560,8 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	 * Run the errata work around checks on the boot CPU, once we have
 	 * initialised the cpu feature infrastructure.
 	 */
-	update_cpu_errata_workarounds();
+	update_cpu_capabilities(arm64_errata, SCOPE_ALL,
+				"enabling workaround for");
 }
 
 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
@@ -1389,12 +1391,6 @@ verify_local_elf_hwcaps(const struct arm64_cpu_capabilities *caps)
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
@@ -1412,27 +1408,6 @@ static void verify_sve_features(void)
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
@@ -1444,8 +1419,15 @@ static void __init enable_errata_workarounds(void)
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
@@ -1470,17 +1452,12 @@ void check_local_cpu_capabilities(void)
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
-	update_cpu_capabilities(arm64_features, SCOPE_ALL, "detected:");
-	enable_cpu_capabilities(arm64_features, SCOPE_ALL);
-}
-
 DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
 EXPORT_SYMBOL(arm64_const_caps_ready);
 
@@ -1502,8 +1479,9 @@ void __init setup_cpu_features(void)
 	u32 cwg;
 
 	/* Set the CPU feature capabilies */
-	setup_feature_capabilities();
-	enable_errata_workarounds();
+	update_cpu_capabilities(arm64_features, SCOPE_ALL, "detected:");
+	enable_cpu_capabilities(arm64_features, SCOPE_ALL);
+	enable_cpu_capabilities(arm64_errata, SCOPE_ALL);
 	mark_const_caps_ready();
 	setup_elf_hwcaps(arm64_elf_hwcaps);
 
-- 
2.7.4
