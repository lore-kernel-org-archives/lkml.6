Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeCZONb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:13:31 -0400
Received: from foss.arm.com ([217.140.101.70]:41034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751658AbeCZON3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:13:29 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, dave.martin@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        ckadabi@codeaurora.org, shankerd@codeaurora.org,
        ard.biesheuvel@linaro.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 07/22] arm64: capabilities: Filter the entries based on a given mask
Date: Mon, 26 Mar 2018 15:12:34 +0100
Message-Id: <1522073569-29174-8-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522073569-29174-1-git-send-email-suzuki.poulose@arm.com>
References: <1522073569-29174-1-git-send-email-suzuki.poulose@arm.com>
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
 arch/arm64/include/asm/cpufeature.h |  1 +
 arch/arm64/kernel/cpufeature.c      | 33 ++++++++++++++++++++++-----------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index b8d8e60..c187b92 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -211,6 +211,7 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
 
 #define SCOPE_SYSTEM				ARM64_CPUCAP_SCOPE_SYSTEM
 #define SCOPE_LOCAL_CPU				ARM64_CPUCAP_SCOPE_LOCAL_CPU
+#define SCOPE_ALL				ARM64_CPUCAP_SCOPE_MASK
 
 /*
  * Is it permitted for a late CPU to have this capability when system
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 1fda957..c49535d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1256,10 +1256,12 @@ static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
 }
 
 static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
-				    const char *info)
+				    u16 scope_mask, const char *info)
 {
+	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
 	for (; caps->matches; caps++) {
-		if (!caps->matches(caps, cpucap_default_scope(caps)))
+		if (!(caps->type & scope_mask) ||
+		    !caps->matches(caps, cpucap_default_scope(caps)))
 			continue;
 
 		if (!cpus_have_cap(caps->capability) && caps->desc)
@@ -1281,12 +1283,14 @@ static int __enable_cpu_capability(void *arg)
  * CPUs
  */
 static void __init
-enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
+enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
+			u16 scope_mask)
 {
+	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
 	for (; caps->matches; caps++) {
 		unsigned int num = caps->capability;
 
-		if (!cpus_have_cap(num))
+		if (!(caps->type & scope_mask) || !cpus_have_cap(num))
 			continue;
 
 		/* Ensure cpus_have_const_cap(num) works */
@@ -1313,12 +1317,18 @@ enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
  * Returns "false" on conflicts.
  */
 static bool
-__verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_list)
+__verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_list,
+			u16 scope_mask)
 {
 	bool cpu_has_cap, system_has_cap;
 	const struct arm64_cpu_capabilities *caps;
 
+	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
+
 	for (caps = caps_list; caps->matches; caps++) {
+		if (!(caps->type & scope_mask))
+			continue;
+
 		cpu_has_cap = __this_cpu_has_cap(caps_list, caps->capability);
 		system_has_cap = cpus_have_cap(caps->capability);
 
@@ -1381,7 +1391,7 @@ verify_local_elf_hwcaps(const struct arm64_cpu_capabilities *caps)
 
 static void verify_local_cpu_features(void)
 {
-	if (!__verify_local_cpu_caps(arm64_features))
+	if (!__verify_local_cpu_caps(arm64_features, SCOPE_ALL))
 		cpu_die_early();
 }
 
@@ -1409,18 +1419,19 @@ static void verify_sve_features(void)
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
@@ -1466,8 +1477,8 @@ void check_local_cpu_capabilities(void)
 
 static void __init setup_feature_capabilities(void)
 {
-	update_cpu_capabilities(arm64_features, "detected:");
-	enable_cpu_capabilities(arm64_features);
+	update_cpu_capabilities(arm64_features, SCOPE_ALL, "detected:");
+	enable_cpu_capabilities(arm64_features, SCOPE_ALL);
 }
 
 DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
-- 
2.7.4
