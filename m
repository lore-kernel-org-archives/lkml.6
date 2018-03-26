Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbeCZONl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:13:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41090 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752299AbeCZONj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:13:39 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, dave.martin@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        ckadabi@codeaurora.org, shankerd@codeaurora.org,
        ard.biesheuvel@linaro.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 11/22] arm64: capabilities: Group handling of features and errata workarounds
Date: Mon, 26 Mar 2018 15:12:38 +0100
Message-Id: <1522073569-29174-12-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522073569-29174-1-git-send-email-suzuki.poulose@arm.com>
References: <1522073569-29174-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the features and errata workarounds have the same
rules and flow, group the handling of the tables.

Reviewed-by: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V4:
 - Added Reviewed-by from Dave
---
 arch/arm64/kernel/cpufeature.c | 73 ++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7c5f329..d330135 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -510,9 +510,7 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 }
 
 extern const struct arm64_cpu_capabilities arm64_errata[];
-static const struct arm64_cpu_capabilities arm64_features[];
-static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
-				    u16 scope_mask, const char *info);
+static void update_cpu_capabilities(u16 scope_mask);
 
 void __init init_cpu_features(struct cpuinfo_arm64 *info)
 {
@@ -561,9 +559,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	 * Run the errata work around and local feature checks on the
 	 * boot CPU, once we have initialised the cpu feature infrastructure.
 	 */
-	update_cpu_capabilities(arm64_errata, SCOPE_LOCAL_CPU,
-				"enabling workaround for");
-	update_cpu_capabilities(arm64_features, SCOPE_LOCAL_CPU, "detected:");
+	update_cpu_capabilities(SCOPE_LOCAL_CPU);
 }
 
 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
@@ -1259,8 +1255,8 @@ static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
 	return false;
 }
 
-static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
-				    u16 scope_mask, const char *info)
+static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
+				      u16 scope_mask, const char *info)
 {
 	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
 	for (; caps->matches; caps++) {
@@ -1274,6 +1270,13 @@ static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 	}
 }
 
+static void update_cpu_capabilities(u16 scope_mask)
+{
+	__update_cpu_capabilities(arm64_features, scope_mask, "detected:");
+	__update_cpu_capabilities(arm64_errata, scope_mask,
+				  "enabling workaround for");
+}
+
 static int __enable_cpu_capability(void *arg)
 {
 	const struct arm64_cpu_capabilities *cap = arg;
@@ -1287,8 +1290,8 @@ static int __enable_cpu_capability(void *arg)
  * CPUs
  */
 static void __init
-enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
-			u16 scope_mask)
+__enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
+			  u16 scope_mask)
 {
 	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
 	for (; caps->matches; caps++) {
@@ -1313,6 +1316,12 @@ enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 	}
 }
 
+static void __init enable_cpu_capabilities(u16 scope_mask)
+{
+	__enable_cpu_capabilities(arm64_features, scope_mask);
+	__enable_cpu_capabilities(arm64_errata, scope_mask);
+}
+
 /*
  * Run through the list of capabilities to check for conflicts.
  * If the system has already detected a capability, take necessary
@@ -1371,6 +1380,12 @@ __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_list,
 	return true;
 }
 
+static bool verify_local_cpu_caps(u16 scope_mask)
+{
+	return __verify_local_cpu_caps(arm64_errata, scope_mask) &&
+	       __verify_local_cpu_caps(arm64_features, scope_mask);
+}
+
 /*
  * Check for CPU features that are used in early boot
  * based on the Boot CPU value.
@@ -1421,15 +1436,9 @@ static void verify_sve_features(void)
  */
 static void verify_local_cpu_capabilities(void)
 {
-	/*
-	 * The CPU Errata work arounds are detected and applied at boot time
-	 * and the related information is freed soon after. If the new CPU
-	 * requires an errata not detected at boot, fail this CPU.
-	 */
-	if (!__verify_local_cpu_caps(arm64_errata, SCOPE_ALL))
-		cpu_die_early();
-	if (!__verify_local_cpu_caps(arm64_features, SCOPE_ALL))
+	if (!verify_local_cpu_caps(SCOPE_ALL))
 		cpu_die_early();
+
 	verify_local_elf_hwcaps(arm64_elf_hwcaps);
 
 	if (system_supports_32bit_el0())
@@ -1453,14 +1462,10 @@ void check_local_cpu_capabilities(void)
 	 * Otherwise, this CPU should verify that it has all the system
 	 * advertised capabilities.
 	 */
-	if (!sys_caps_initialised) {
-		update_cpu_capabilities(arm64_errata, SCOPE_LOCAL_CPU,
-					"enabling workaround for");
-		update_cpu_capabilities(arm64_features, SCOPE_LOCAL_CPU,
-					"detected:");
-	} else {
+	if (!sys_caps_initialised)
+		update_cpu_capabilities(SCOPE_LOCAL_CPU);
+	else
 		verify_local_cpu_capabilities();
-	}
 }
 
 DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
@@ -1479,16 +1484,22 @@ bool this_cpu_has_cap(unsigned int cap)
 		__this_cpu_has_cap(arm64_errata, cap));
 }
 
+static void __init setup_system_capabilities(void)
+{
+	/*
+	 * We have finalised the system-wide safe feature
+	 * registers, finalise the capabilities that depend
+	 * on it. Also enable all the available capabilities.
+	 */
+	update_cpu_capabilities(SCOPE_SYSTEM);
+	enable_cpu_capabilities(SCOPE_ALL);
+}
+
 void __init setup_cpu_features(void)
 {
 	u32 cwg;
 
-	/* Set the CPU feature capabilies */
-	update_cpu_capabilities(arm64_features, SCOPE_SYSTEM, "detected:");
-	update_cpu_capabilities(arm64_errata, SCOPE_SYSTEM,
-				"enabling workaround for");
-	enable_cpu_capabilities(arm64_features, SCOPE_ALL);
-	enable_cpu_capabilities(arm64_errata, SCOPE_ALL);
+	setup_system_capabilities();
 	mark_const_caps_ready();
 	setup_elf_hwcaps(arm64_elf_hwcaps);
 
-- 
2.7.4
