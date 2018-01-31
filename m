Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751655AbeAaScS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:32:18 -0500
Received: from foss.arm.com ([217.140.101.70]:41526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751889AbeAaS24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:28:56 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        will.deacon@arm.com, mark.rutland@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, ckadabi@codeaurora.org, dave.martin@arm.com,
        jnair@caviumnetworks.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 07/20] arm64: capabilities: Filter the entries based on a given mask
Date: Wed, 31 Jan 2018 18:27:54 +0000
Message-Id: <20180131182807.32134-8-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131182807.32134-1-suzuki.poulose@arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While processing the list of capabilities, it is useful to
filter out some of the entries based on the given mask for the
scope of the capabilities to allow better control. This can be
used later for handling LOCAL vs SYSTEM wide capabilities and more.
All capabilities should have their scope set to either LOCAL_CPU or
SYSTEM. No functional/flow change.

Cc: Dave Martin <dave.martin@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  2 ++
 arch/arm64/kernel/cpufeature.c      | 35 ++++++++++++++++++++++++-----------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 69b5ce366598..cda62b70d338 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -198,6 +198,8 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
 /* Is it safe for a late CPU to miss this capability when system has it */
 #define ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU	((u16)BIT(5))
 
+#define ARM64_CPUCAP_SCOPE_ALL			 \
+	(ARM64_CPUCAP_SCOPE_LOCAL_CPU | ARM64_CPUCAP_SCOPE_SYSTEM)
 /*
  * CPU errata detected at boot time based on feature of one or more CPUs.
  * It is not safe for a late CPU to have this feature when the system doesn't
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 5e4d581c97f1..5163dc51b975 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1185,10 +1185,12 @@ static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
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
@@ -1210,12 +1212,14 @@ static int __enable_cpu_capability(void *arg)
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
@@ -1240,12 +1244,18 @@ static void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *
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
+
+		if (!(caps->type & scope_mask))
+			continue;
+
 		cpu_has_cap = __this_cpu_has_cap(caps_list, caps->capability);
 		system_has_cap =  cpus_have_cap(caps->capability);
 
@@ -1307,7 +1317,7 @@ verify_local_elf_hwcaps(const struct arm64_cpu_capabilities *caps)
 
 static void verify_local_cpu_features(void)
 {
-	if (!__verify_local_cpu_caps(arm64_features))
+	if (!__verify_local_cpu_caps(arm64_features, ARM64_CPUCAP_SCOPE_ALL))
 		cpu_die_early();
 }
 
@@ -1335,18 +1345,20 @@ static void verify_sve_features(void)
  */
 static void verify_local_cpu_errata_workarounds(void)
 {
-	if (!__verify_local_cpu_caps(arm64_errata))
+	if (!__verify_local_cpu_caps(arm64_errata, ARM64_CPUCAP_SCOPE_ALL))
 		cpu_die_early();
 }
 
 static void update_cpu_errata_workarounds(void)
 {
-	update_cpu_capabilities(arm64_errata, "enabling workaround for");
+	update_cpu_capabilities(arm64_errata,
+				ARM64_CPUCAP_SCOPE_ALL,
+				"enabling workaround for");
 }
 
 static void __init enable_errata_workarounds(void)
 {
-	enable_cpu_capabilities(arm64_errata);
+	enable_cpu_capabilities(arm64_errata, ARM64_CPUCAP_SCOPE_ALL);
 }
 
 /*
@@ -1395,8 +1407,9 @@ void check_local_cpu_capabilities(void)
 
 static void __init setup_feature_capabilities(void)
 {
-	update_cpu_capabilities(arm64_features, "detected feature:");
-	enable_cpu_capabilities(arm64_features);
+	update_cpu_capabilities(arm64_features,
+				ARM64_CPUCAP_SCOPE_ALL, "detected feature:");
+	enable_cpu_capabilities(arm64_features, ARM64_CPUCAP_SCOPE_ALL);
 }
 
 DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
-- 
2.14.3
