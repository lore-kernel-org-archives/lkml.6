Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeBIR5b (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 12:57:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50310 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752534AbeBIR53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:57:29 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: dave.martin@arm.com, linux-kernel@vger.kernel.org, will.deacon@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        jnair@caviumnetworks.com, ckadabi@codeaurora.org, robin.murphy@arm.com,
        ard.biesheuvel@linaro.org, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 06/21] arm64: capabilities: Filter the entries based on a given mask
Date: Fri,  9 Feb 2018 17:54:41 +0000
Message-Id: <20180209175513.17100-12-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180209175513.17100-1-suzuki.poulose@arm.com>
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While processing the list of capabilities, it is useful to
filter out some of the entries based on the given mask for the
scope of the capabilities to allow better control. This can be
used later for handling LOCAL vs SYSTEM wide capabilities and more.
All capabilities should have their scope set to either LOCAL_CPU or
SYSTEM. No functional/flow change.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v2:
 - Use SCOPE_ALL instead of ARM64_CPUCAP_SCOPE_ALL in the code
---
 arch/arm64/include/asm/cpufeature.h |  1 +
 arch/arm64/kernel/cpufeature.c      | 33 ++++++++++++++++++++++-----------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 5f58623a4599..6e354a98bc24 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -202,6 +202,7 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
 
 #define SCOPE_SYSTEM				ARM64_CPUCAP_SCOPE_SYSTEM
 #define SCOPE_LOCAL_CPU				ARM64_CPUCAP_SCOPE_LOCAL_CPU
+#define SCOPE_ALL				ARM64_CPUCAP_SCOPE_MASK
 
 /*
  * Is it permitted for a late CPU to have this capability when system
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 48ed6d71094f..3447821bec5a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1222,10 +1222,12 @@ static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
 }
 
 static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
-			    const char *info)
+				    u16 scope_mask, const char *info)
 {
+	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
 	for (; caps->matches; caps++) {
-		if (!caps->matches(caps, cpucap_default_scope(caps)))
+		if (!(caps->type & scope_mask) ||
+		    !caps->matches(caps, cpucap_default_scope(caps)))
 			continue;
 
 		if (!cpus_have_cap(caps->capability) && caps->desc)
@@ -1246,12 +1248,14 @@ static int __enable_cpu_capability(void *arg)
  * Run through the enabled capabilities and enable() it on all active
  * CPUs
  */
-static void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
+static void __init
+enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps, u16 scope_mask)
 {
+	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
 	for (; caps->matches; caps++) {
 		unsigned int num = caps->capability;
 
-		if (!cpus_have_cap(num))
+		if (!(caps->type & scope_mask) || !cpus_have_cap(num))
 			continue;
 
 		/* Ensure cpus_have_const_cap(num) works */
@@ -1276,12 +1280,17 @@ static void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *
  *
  * Returns "false" on conflicts.
  */
-static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_list)
+static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_list,
+				    u16 scope_mask)
 {
 	bool cpu_has_cap, system_has_cap;
 	const struct arm64_cpu_capabilities *caps = caps_list;
 
+	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
 	for (; caps->matches; caps++) {
+		if (!(caps->type & scope_mask))
+			continue;
+
 		cpu_has_cap = __this_cpu_has_cap(caps_list, caps->capability);
 		system_has_cap = cpus_have_cap(caps->capability);
 
@@ -1343,7 +1352,7 @@ verify_local_elf_hwcaps(const struct arm64_cpu_capabilities *caps)
 
 static void verify_local_cpu_features(void)
 {
-	if (!__verify_local_cpu_caps(arm64_features))
+	if (!__verify_local_cpu_caps(arm64_features, SCOPE_ALL))
 		cpu_die_early();
 }
 
@@ -1371,18 +1380,19 @@ static void verify_sve_features(void)
  */
 static void verify_local_cpu_errata_workarounds(void)
 {
-	if (!__verify_local_cpu_caps(arm64_errata))
+	if (!__verify_local_cpu_caps(arm64_errata, SCOPE_ALL))
 		cpu_die_early();
 }
 
 static void update_cpu_errata_workarounds(void)
 {
-	update_cpu_capabilities(arm64_errata, "enabling workaround for");
+	update_cpu_capabilities(arm64_errata, SCOPE_ALL,
+				"enabling workaround for");
 }
 
 static void __init enable_errata_workarounds(void)
 {
-	enable_cpu_capabilities(arm64_errata);
+	enable_cpu_capabilities(arm64_errata, SCOPE_ALL);
 }
 
 /*
@@ -1431,8 +1441,9 @@ void check_local_cpu_capabilities(void)
 
 static void __init setup_feature_capabilities(void)
 {
-	update_cpu_capabilities(arm64_features, "detected feature:");
-	enable_cpu_capabilities(arm64_features);
+	update_cpu_capabilities(arm64_features, SCOPE_ALL,
+				"detected feature:");
+	enable_cpu_capabilities(arm64_features, SCOPE_ALL);
 }
 
 DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
-- 
2.14.3
