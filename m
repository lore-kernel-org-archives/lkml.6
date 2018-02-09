Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753010AbeBISAS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 13:00:18 -0500
Received: from foss.arm.com ([217.140.101.70]:50634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752900AbeBIR62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:58:28 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: dave.martin@arm.com, linux-kernel@vger.kernel.org, will.deacon@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        jnair@caviumnetworks.com, ckadabi@codeaurora.org, robin.murphy@arm.com,
        ard.biesheuvel@linaro.org, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 18/21] arm64: capabilities: Handle shared entries
Date: Fri,  9 Feb 2018 17:55:06 +0000
Message-Id: <20180209175513.17100-37-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180209175513.17100-1-suzuki.poulose@arm.com>
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some capabilities have different criteria for detection and associated
actions based on the matching criteria, even though they all share the
same capability bit. So far we have used multiple entries with the same
capability bit to handle this. This is prone to errors, as the
cpu_enable is invoked for each entry, irrespective of whether the
detection rule applies to the CPU or not. And also this complicates
other helpers, e.g, __this_cpu_has_cap.

This patch adds a wrapper entry to cover all the possible variations
of a capability by maintaining list of matches + cpu_enable callbacks.
To avoid complicating the prototypes for the "matches()", we use
arm64_cpu_capabilities maintain the list and we ignore all the other
fields except the matches & cpu_enable.

This ensures :

 1) The capabilitiy is set when at least one of the entry detects
 2) Action is only taken for the entries that "matches".

This avoids explicit checks in the cpu_enable() take some action.
The only constraint here is that, all the entries should have the
same "type" (i.e, scope and conflict rules).

If a cpu_enable() method is associated with multiple matches for a
single capability, care should be taken that either the match criteria
are mutually exclusive, or that the method is robust against being
called multiple times.

This also reverts the changes introduced by commit 67948af41f2e6818ed
("arm64: capabilities: Handle duplicate entries for a capability").

Cc: Dave Martin <dave.martin@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 11 ++++++++
 arch/arm64/kernel/cpu_errata.c      | 53 ++++++++++++++++++++++++++++++++-----
 arch/arm64/kernel/cpufeature.c      | 10 +++----
 3 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 3ab1c3422f14..074537acc08b 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -306,6 +306,17 @@ struct arm64_cpu_capabilities {
 			bool sign;
 			unsigned long hwcap;
 		};
+		/*
+		 * A list of "matches/cpu_enable" pair for the same "capability"
+		 * of the same "type" as described by the parent. All the
+		 * fields, except "matches"/"cpu_enable" are ignored in the list.
+		 * The cpu_enable is invoked only if the corresponding entry
+		 * "matches()". However, if a cpu_enable() method is associated
+		 * with multiple matches, care should be taken that either the
+		 * match criteria are mutually exclusive, or that the method is
+		 * robust against being called multiple times.
+		 */
+		const struct arm64_cpu_capabilities *cap_list;
 	};
 };
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index a602a3049404..902d281ea26f 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -264,6 +264,36 @@ qcom_enable_link_stack_sanitization(const struct arm64_cpu_capabilities *entry)
 	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,			\
 	CAP_MIDR_RANGE_LIST(midr_list)
 
+/*
+ * Generic helper for handling capabilties with multiple (match,enable) pairs
+ * of call backs, sharing the same capability bit.
+ * Iterate over each entry to see if at least one matches.
+ */
+static bool multi_entry_cap_matches(const struct arm64_cpu_capabilities *entry,
+				    int scope)
+{
+	const struct arm64_cpu_capabilities *caps = entry->cap_list;
+
+	for (; caps->matches; caps++)
+		if (caps->matches(caps, scope))
+			return true;
+	return false;
+}
+
+/*
+ * Take appropriate action for all matching entries in the shared capability
+ * entry.
+ */
+static void multi_entry_cap_cpu_enable(const struct arm64_cpu_capabilities *entry)
+{
+	const struct arm64_cpu_capabilities *caps = entry->cap_list;
+
+	for (; caps->matches; caps++)
+		if (caps->matches(caps, SCOPE_LOCAL_CPU) &&
+		    caps->cpu_enable)
+			caps->cpu_enable(caps);
+}
+
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 
 /*
@@ -280,6 +310,18 @@ static const struct midr_range arm64_bp_harden_psci_cpus[] = {
 	{},
 };
 
+static const struct arm64_cpu_capabilities arm64_bp_harden_list[] = {
+	{
+		CAP_MIDR_RANGE_LIST(arm64_bp_harden_psci_cpus),
+		.cpu_enable = enable_smccc_arch_workaround_1,
+	},
+	{
+		CAP_MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
+		.cpu_enable = qcom_enable_link_stack_sanitization,
+	},
+	{},
+};
+
 #endif
 
 const struct arm64_cpu_capabilities arm64_errata[] = {
@@ -416,13 +458,10 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		ERRATA_MIDR_RANGE_LIST(arm64_bp_harden_psci_cpus),
-		.cpu_enable = enable_smccc_arch_workaround_1,
-	},
-	{
-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		ERRATA_MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
-		.cpu_enable = qcom_enable_link_stack_sanitization,
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
+		.matches = multi_entry_cap_matches,
+		.cpu_enable = multi_entry_cap_cpu_enable,
+		.cap_list = arm64_bp_harden_list,
 	},
 	{
 		.capability = ARM64_HARDEN_BP_POST_GUEST_EXIT,
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9eb9e9570468..d8663822c604 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1225,9 +1225,8 @@ static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
 		return false;
 
 	for (caps = cap_array; caps->matches; caps++)
-		if (caps->capability == cap &&
-		    caps->matches(caps, SCOPE_LOCAL_CPU))
-			return true;
+		if (caps->capability == cap)
+			return caps->matches(caps, SCOPE_LOCAL_CPU);
 	return false;
 }
 
@@ -1313,18 +1312,17 @@ static void __init enable_cpu_capabilities(u16 scope_mask)
  *
  * Returns "false" on conflicts.
  */
-static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_list,
+static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps,
 				    u16 scope_mask)
 {
 	bool cpu_has_cap, system_has_cap;
-	const struct arm64_cpu_capabilities *caps = caps_list;
 
 	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
 	for (; caps->matches; caps++) {
 		if (!(caps->type & scope_mask))
 			continue;
 
-		cpu_has_cap = __this_cpu_has_cap(caps_list, caps->capability);
+		cpu_has_cap = caps->matches(caps, SCOPE_LOCAL_CPU);
 		system_has_cap = cpus_have_cap(caps->capability);
 
 		if (system_has_cap) {
-- 
2.14.3
