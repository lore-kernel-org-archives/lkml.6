Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeBIR5T (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 12:57:19 -0500
Received: from foss.arm.com ([217.140.101.70]:50218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752248AbeBIR5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:57:15 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: dave.martin@arm.com, linux-kernel@vger.kernel.org, will.deacon@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        jnair@caviumnetworks.com, ckadabi@codeaurora.org, robin.murphy@arm.com,
        ard.biesheuvel@linaro.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v3 03/22] arm64: capabilities: Move errata processing code
Date: Fri,  9 Feb 2018 17:54:35 +0000
Message-Id: <20180209175513.17100-6-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180209175513.17100-1-suzuki.poulose@arm.com>
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have errata work around processing code in cpu_errata.c,
which calls back into helpers defined in cpufeature.c. Now
that we are going to make the handling of capabilities
generic, by adding the information to each capability,
move the errata work around specific processing code.
No functional changes.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  7 -------
 arch/arm64/kernel/cpu_errata.c      | 33 ------------------------------
 arch/arm64/kernel/cpufeature.c      | 40 +++++++++++++++++++++++++++++++++++--
 3 files changed, 38 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index f46eb7d1625f..7925e40c6ded 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -238,15 +238,8 @@ static inline bool id_aa64pfr0_sve(u64 pfr0)
 }
 
 void __init setup_cpu_features(void);
-
-void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
-			    const char *info);
-void enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps);
 void check_local_cpu_capabilities(void);
 
-void update_cpu_errata_workarounds(void);
-void __init enable_errata_workarounds(void);
-void verify_local_cpu_errata_workarounds(void);
 
 u64 read_sanitised_ftr_reg(u32 id);
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 51f969b7e770..0186788437a7 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -417,36 +417,3 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	{
 	}
 };
-
-/*
- * The CPU Errata work arounds are detected and applied at boot time
- * and the related information is freed soon after. If the new CPU requires
- * an errata not detected at boot, fail this CPU.
- */
-void verify_local_cpu_errata_workarounds(void)
-{
-	const struct arm64_cpu_capabilities *caps = arm64_errata;
-
-	for (; caps->matches; caps++) {
-		if (cpus_have_cap(caps->capability)) {
-			if (caps->cpu_enable)
-				caps->cpu_enable(caps);
-		} else if (caps->matches(caps, SCOPE_LOCAL_CPU)) {
-			pr_crit("CPU%d: Requires work around for %s, not detected"
-					" at boot time\n",
-				smp_processor_id(),
-				caps->desc ? : "an erratum");
-			cpu_die_early();
-		}
-	}
-}
-
-void update_cpu_errata_workarounds(void)
-{
-	update_cpu_capabilities(arm64_errata, "enabling workaround for");
-}
-
-void __init enable_errata_workarounds(void)
-{
-	enable_cpu_capabilities(arm64_errata);
-}
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 5c08d886b53d..359fd6b4d159 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -503,6 +503,9 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 	reg->user_mask = user_mask;
 }
 
+extern const struct arm64_cpu_capabilities arm64_errata[];
+static void update_cpu_errata_workarounds(void);
+
 void __init init_cpu_features(struct cpuinfo_arm64 *info)
 {
 	/* Before we start using the tables, make sure it is sorted */
@@ -1218,7 +1221,7 @@ static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
 	return false;
 }
 
-void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
+static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info)
 {
 	for (; caps->matches; caps++) {
@@ -1243,7 +1246,7 @@ static int __enable_cpu_capability(void *arg)
  * Run through the enabled capabilities and enable() it on all active
  * CPUs
  */
-void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
+static void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 {
 	for (; caps->matches; caps++) {
 		unsigned int num = caps->capability;
@@ -1326,6 +1329,39 @@ static void verify_sve_features(void)
 	/* Add checks on other ZCR bits here if necessary */
 }
 
+/*
+ * The CPU Errata work arounds are detected and applied at boot time
+ * and the related information is freed soon after. If the new CPU requires
+ * an errata not detected at boot, fail this CPU.
+ */
+static void verify_local_cpu_errata_workarounds(void)
+{
+	const struct arm64_cpu_capabilities *caps = arm64_errata;
+
+	for (; caps->matches; caps++) {
+		if (cpus_have_cap(caps->capability)) {
+			if (caps->cpu_enable)
+				caps->cpu_enable(caps);
+		} else if (caps->matches(caps, SCOPE_LOCAL_CPU)) {
+			pr_crit("CPU%d: Requires work around for %s, not detected"
+					" at boot time\n",
+				smp_processor_id(),
+				caps->desc ? : "an erratum");
+			cpu_die_early();
+		}
+	}
+}
+
+static void update_cpu_errata_workarounds(void)
+{
+	update_cpu_capabilities(arm64_errata, "enabling workaround for");
+}
+
+static void __init enable_errata_workarounds(void)
+{
+	enable_cpu_capabilities(arm64_errata);
+}
+
 /*
  * Run through the enabled system capabilities and enable() it on this CPU.
  * The capabilities were decided based on the available CPUs at the boot time.
-- 
2.14.3
