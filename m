Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeAaSce (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:32:34 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41512 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751782AbeAaS2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:28:54 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        will.deacon@arm.com, mark.rutland@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, ckadabi@codeaurora.org, dave.martin@arm.com,
        jnair@caviumnetworks.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 06/20] arm64: capabilities: Unify the verification
Date: Wed, 31 Jan 2018 18:27:53 +0000
Message-Id: <20180131182807.32134-7-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131182807.32134-1-suzuki.poulose@arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that each capability describes how to treat the conflicts
of CPU cap state vs System wide cap state, we can unify the
verification logic to a single place.

Cc: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  1 +
 arch/arm64/kernel/cpufeature.c      | 89 +++++++++++++++++++++++--------------
 2 files changed, 57 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 7460b1f7e611..69b5ce366598 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -155,6 +155,7 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
  *
  *	b) Any late CPU, brought up after (1), the action is triggered via:
  *		check_local_cpu_capabilities() -> verify_local_cpu_capabilities()
+ *		  -> __verify_local_cpu_caps()
  *
  * 5) Conflicts: Based on the state of the capability on a late CPU vs. the system
  *    state, we could have the following combinations :
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 1b29b3f0a1bc..5e4d581c97f1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1233,6 +1233,56 @@ static void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *
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
+		system_has_cap =  cpus_have_cap(caps->capability);
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
@@ -1255,25 +1305,10 @@ verify_local_elf_hwcaps(const struct arm64_cpu_capabilities *caps)
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
@@ -1300,20 +1335,8 @@ static void verify_sve_features(void)
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
@@ -1337,7 +1360,7 @@ static void __init enable_errata_workarounds(void)
 static void verify_local_cpu_capabilities(void)
 {
 	verify_local_cpu_errata_workarounds();
-	verify_local_cpu_features(arm64_features);
+	verify_local_cpu_features();
 	verify_local_elf_hwcaps(arm64_elf_hwcaps);
 
 	if (system_supports_32bit_el0())
-- 
2.14.3
