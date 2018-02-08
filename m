Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbeBHMNL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 07:13:11 -0500
Received: from foss.arm.com ([217.140.101.70]:34146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752403AbeBHMNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 07:13:09 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: dave.martin@arm.com
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 2/2] arm64: capabilities: Group handling of features and errata workarounds
Date: Thu,  8 Feb 2018 12:12:38 +0000
Message-Id: <20180208121238.18792-2-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180208121238.18792-1-suzuki.poulose@arm.com>
References: <86f23003-72bc-5bfc-af40-a92cc68def45@arm.com>
 <20180208121238.18792-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can now handle each capability entry independent of whether
it is a feature or an errata workaround. This patch consolidates
the handling of the capabilities, by grouping them, to streamline
the code flow.

Cc: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 99 +++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 49 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e1a56fa889a5..31d1e02ed5be 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -504,8 +504,7 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 }
 
 extern const struct arm64_cpu_capabilities arm64_errata[];
-static void update_cpu_errata_workarounds(void);
-static void update_cpu_local_features(void);
+static void update_cpu_local_capabilities(void);
 
 void __init init_cpu_features(struct cpuinfo_arm64 *info)
 {
@@ -554,8 +553,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	 * Run the errata work around checks on the boot CPU, once we have
 	 * initialised the cpu feature infrastructure.
 	 */
-	update_cpu_errata_workarounds();
-	update_cpu_local_features();
+	update_cpu_local_capabilities();
 }
 
 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
@@ -1223,8 +1221,8 @@ static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
 	return false;
 }
 
-static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
-				    u16 scope_mask, const char *info)
+static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
+				      u16 scope_mask, const char *info)
 {
 	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
 	for (; caps->matches; caps++) {
@@ -1238,6 +1236,15 @@ static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 	}
 }
 
+/* Detect all capabilities which match the given scope_mask */
+static void update_cpu_capabilities(u16 scope_mask)
+{
+	__update_cpu_capabilities(arm64_features, scope_mask,
+				"detected feature:");
+	__update_cpu_capabilities(arm64_errata, scope_mask,
+				"enabling work around for");
+}
+
 static int __enable_cpu_capability(void *arg)
 {
 	const struct arm64_cpu_capabilities *cap = arg;
@@ -1251,7 +1258,7 @@ static int __enable_cpu_capability(void *arg)
  * CPUs
  */
 static void __init
-enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps, u16 scope_mask)
+__enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps, u16 scope_mask)
 {
 	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
 	for (; caps->matches; caps++) {
@@ -1330,6 +1337,13 @@ static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_li
 	return true;
 }
 
+/* Verify this CPU against all the capabilities that match the scope */
+static bool verify_local_cpu_caps(u16 scope_mask)
+{
+	return __verify_local_cpu_caps(arm64_features, scope_mask) &&
+	       __verify_local_cpu_caps(arm64_errata, scope_mask);
+}
+
 /*
  * Check for CPU features that are used in early boot
  * based on the Boot CPU value.
@@ -1352,12 +1366,6 @@ verify_local_elf_hwcaps(const struct arm64_cpu_capabilities *caps)
 		}
 }
 
-static void verify_local_cpu_features(void)
-{
-	if (!__verify_local_cpu_caps(arm64_features, ARM64_CPUCAP_SCOPE_ALL))
-		cpu_die_early();
-}
-
 static void verify_sve_features(void)
 {
 	u64 safe_zcr = read_sanitised_ftr_reg(SYS_ZCR_EL1);
@@ -1376,28 +1384,29 @@ static void verify_sve_features(void)
 }
 
 /*
- * The CPU Errata work arounds are detected and applied at boot time
- * and the related information is freed soon after. If the new CPU requires
- * an errata not detected at boot, fail this CPU.
+ * Check for all capablities within the scope of local CPU.
+ * This is run on all boot time activated CPUs.
  */
-static void verify_local_cpu_errata_workarounds(void)
+static void update_cpu_local_capabilities(void)
 {
-	if (!__verify_local_cpu_caps(arm64_errata, ARM64_CPUCAP_SCOPE_ALL))
-		cpu_die_early();
+	update_cpu_capabilities(ARM64_CPUCAP_SCOPE_LOCAL_CPU);
 }
 
-static void update_cpu_errata_workarounds(void)
+/*
+ * Check for all capablities with a system wide scope.
+ * This is run only once after all the boot CPUs are
+ * brought online.
+ */
+static void update_system_capabilities(void)
 {
-	update_cpu_capabilities(arm64_errata,
-				ARM64_CPUCAP_SCOPE_LOCAL_CPU,
-				"enabling workaround for");
+	update_cpu_capabilities(ARM64_CPUCAP_SCOPE_SYSTEM);
 }
 
-static void update_cpu_local_features(void)
+/* Enable all the capabilities matching the given scope mask */
+static void enable_cpu_capabilities(u16 scope_mask)
 {
-	update_cpu_capabilities(arm64_features,
-				ARM64_CPUCAP_SCOPE_LOCAL_CPU,
-				"detected feature:");
+	__enable_cpu_capabilities(arm64_errata, scope_mask);
+	__enable_cpu_capabilities(arm64_features, scope_mask);
 }
 
 /*
@@ -1410,8 +1419,8 @@ static void update_cpu_local_features(void)
  */
 static void verify_local_cpu_capabilities(void)
 {
-	verify_local_cpu_errata_workarounds();
-	verify_local_cpu_features();
+	if (!verify_local_cpu_caps(ARM64_CPUCAP_SCOPE_ALL))
+		cpu_die_early();
 	verify_local_elf_hwcaps(arm64_elf_hwcaps);
 
 	if (system_supports_32bit_el0())
@@ -1438,28 +1447,21 @@ void check_local_cpu_capabilities(void)
 	 * Otherwise, this CPU should verify that it has all the system
 	 * advertised capabilities.
 	 */
-	if (!sys_caps_initialised) {
-		update_cpu_errata_workarounds();
-		update_cpu_local_features();
-	} else {
+	if (!sys_caps_initialised)
+		update_cpu_local_capabilities();
+	else
 		verify_local_cpu_capabilities();
-	}
 }
 
-static void __init setup_feature_capabilities(void)
+static void __init setup_system_capabilities(void)
 {
-	update_cpu_capabilities(arm64_features,
-				ARM64_CPUCAP_SCOPE_SYSTEM,
-				"detected feature:");
-	enable_cpu_capabilities(arm64_features, ARM64_CPUCAP_SCOPE_ALL);
-}
-
-static void __init setup_errata_workarounds(void)
-{
-	update_cpu_capabilities(arm64_errata,
-				ARM64_CPUCAP_SCOPE_SYSTEM,
-				"enabling workaround for");
-	enable_cpu_capabilities(arm64_errata, ARM64_CPUCAP_SCOPE_ALL);
+	/*
+	 * We have finalised the system wide safe feature registers,
+	 * finalise the capabilities that depend on it.
+	 */
+	update_system_capabilities();
+	/* Enable all the available capabilities */
+	enable_cpu_capabilities(ARM64_CPUCAP_SCOPE_ALL);
 }
 
 DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
@@ -1484,8 +1486,7 @@ void __init setup_cpu_features(void)
 	int cls;
 
 	/* Finalise the CPU capabilities */
-	setup_feature_capabilities();
-	setup_errata_workarounds();
+	setup_system_capabilities();
 	mark_const_caps_ready();
 	setup_elf_hwcaps(arm64_elf_hwcaps);
 
-- 
2.14.3
