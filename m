Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeBIR53 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 12:57:29 -0500
Received: from foss.arm.com ([217.140.101.70]:50288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752337AbeBIR51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:57:27 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: dave.martin@arm.com, linux-kernel@vger.kernel.org, will.deacon@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        jnair@caviumnetworks.com, ckadabi@codeaurora.org, robin.murphy@arm.com,
        ard.biesheuvel@linaro.org, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 05/21] arm64: capabilities: Unify the verification
Date: Fri,  9 Feb 2018 17:54:40 +0000
Message-Id: <20180209175513.17100-11-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180209175513.17100-1-suzuki.poulose@arm.com>
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that each capability describes how to treat the conflicts
of CPU cap state vs System wide cap state, we can unify the
verification logic to a single place.

Reviewed-by: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 89 ++++++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7df82c9daeb0..48ed6d71094f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1269,6 +1269,56 @@ static void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *
 	}
 }
 
+/*
+ * Run through the list of capabilities to check for conflicts.
+ * If the system has already detected a capability, take necessary
+ * action on this CPU.
+ *
+ * Returns "false" on conflicts.
+ */
+static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_list)
+{
+	bool cpu_has_cap, system_has_cap;
+	const struct arm64_cpu_capabilities *caps = caps_list;
+
+	for (; caps->matches; caps++) {
+		cpu_has_cap = __this_cpu_has_cap(caps_list, caps->capability);
+		system_has_cap = cpus_have_cap(caps->capability);
+
+		if (system_has_cap) {
+			/*
+			 * Check if the new CPU misses an advertised feature, which is not
+			 * safe to miss.
+			 */
+			if (!cpu_has_cap && !cpucap_late_cpu_optional(caps))
+				break;
+			/*
+			 * We have to issue cpu_enable() irrespective of whether the CPU
+			 * has it or not, as it is enabeld system wide. It is upto
+			 * the call back to take appropriate action on this CPU.
+			 */
+			if (caps->cpu_enable)
+				caps->cpu_enable(caps);
+		} else {
+			/*
+			 * Check if the CPU has this capability if it isn't safe to
+			 * have when the system doesn't.
+			 */
+			if (cpu_has_cap && !cpucap_late_cpu_permitted(caps))
+				break;
+		}
+	}
+
+	if (caps->matches) {
+		pr_crit("CPU%d: Detected conflict for capability %d (%s), System: %d, CPU: %d\n",
+			smp_processor_id(), caps->capability,
+			caps->desc, system_has_cap, cpu_has_cap);
+		return false;
+	}
+
+	return true;
+}
+
 /*
  * Check for CPU features that are used in early boot
  * based on the Boot CPU value.
@@ -1291,25 +1341,10 @@ verify_local_elf_hwcaps(const struct arm64_cpu_capabilities *caps)
 		}
 }
 
-static void
-verify_local_cpu_features(const struct arm64_cpu_capabilities *caps_list)
+static void verify_local_cpu_features(void)
 {
-	const struct arm64_cpu_capabilities *caps = caps_list;
-	for (; caps->matches; caps++) {
-		if (!cpus_have_cap(caps->capability))
-			continue;
-		/*
-		 * If the new CPU misses an advertised feature, we cannot proceed
-		 * further, park the cpu.
-		 */
-		if (!__this_cpu_has_cap(caps_list, caps->capability)) {
-			pr_crit("CPU%d: missing feature: %s\n",
-					smp_processor_id(), caps->desc);
-			cpu_die_early();
-		}
-		if (caps->cpu_enable)
-			caps->cpu_enable(caps);
-	}
+	if (!__verify_local_cpu_caps(arm64_features))
+		cpu_die_early();
 }
 
 static void verify_sve_features(void)
@@ -1336,20 +1371,8 @@ static void verify_sve_features(void)
  */
 static void verify_local_cpu_errata_workarounds(void)
 {
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
+	if (!__verify_local_cpu_caps(arm64_errata))
+		cpu_die_early();
 }
 
 static void update_cpu_errata_workarounds(void)
@@ -1373,7 +1396,7 @@ static void __init enable_errata_workarounds(void)
 static void verify_local_cpu_capabilities(void)
 {
 	verify_local_cpu_errata_workarounds();
-	verify_local_cpu_features(arm64_features);
+	verify_local_cpu_features();
 	verify_local_elf_hwcaps(arm64_elf_hwcaps);
 
 	if (system_supports_32bit_el0())
-- 
2.14.3
