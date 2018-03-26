Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbeCZOOD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:14:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41184 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752122AbeCZON7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:13:59 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, dave.martin@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        ckadabi@codeaurora.org, shankerd@codeaurora.org,
        ard.biesheuvel@linaro.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 19/22] arm64: capabilities: Handle shared entries
Date: Mon, 26 Mar 2018 15:12:46 +0100
Message-Id: <1522073569-29174-20-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522073569-29174-1-git-send-email-suzuki.poulose@arm.com>
References: <1522073569-29174-1-git-send-email-suzuki.poulose@arm.com>
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

Cc: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V4:
 - Added Reviewed-by from Dave
---
 arch/arm64/include/asm/cpufeature.h | 12 ++++++++
 arch/arm64/kernel/cpu_errata.c      | 55 ++++++++++++++++++++++++++++++++-----
 arch/arm64/kernel/cpufeature.c      | 13 ++++-----
 3 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index a16eb07..09b0f2a 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -323,6 +323,18 @@ struct arm64_cpu_capabilities {
 			bool sign;
 			unsigned long hwcap;
 		};
+		/*
+		 * A list of "matches/cpu_enable" pair for the same
+		 * "capability" of the same "type" as described by the parent.
+		 * Only matches(), cpu_enable() and fields relevant to these
+		 * methods are significant in the list. The cpu_enable is
+		 * invoked only if the corresponding entry "matches()".
+		 * However, if a cpu_enable() method is associated
+		 * with multiple matches(), care should be taken that either
+		 * the match criteria are mutually exclusive, or that the
+		 * method is robust against being called multiple times.
+		 */
+		const struct arm64_cpu_capabilities *match_list;
 	};
 };
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 9490b560..6de823a 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -280,6 +280,38 @@ qcom_enable_link_stack_sanitization(const struct arm64_cpu_capabilities *entry)
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
+	const struct arm64_cpu_capabilities *caps;
+
+	for (caps = entry->match_list; caps->matches; caps++)
+		if (caps->matches(caps, scope))
+			return true;
+
+	return false;
+}
+
+/*
+ * Take appropriate action for all matching entries in the shared capability
+ * entry.
+ */
+static void
+multi_entry_cap_cpu_enable(const struct arm64_cpu_capabilities *entry)
+{
+	const struct arm64_cpu_capabilities *caps;
+
+	for (caps = entry->match_list; caps->matches; caps++)
+		if (caps->matches(caps, SCOPE_LOCAL_CPU) &&
+		    caps->cpu_enable)
+			caps->cpu_enable(caps);
+}
+
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 
 /*
@@ -302,6 +334,18 @@ static const struct midr_range qcom_bp_harden_cpus[] = {
 	{},
 };
 
+static const struct arm64_cpu_capabilities arm64_bp_harden_list[] = {
+	{
+		CAP_MIDR_RANGE_LIST(arm64_bp_harden_smccc_cpus),
+		.cpu_enable = enable_smccc_arch_workaround_1,
+	},
+	{
+		CAP_MIDR_RANGE_LIST(qcom_bp_harden_cpus),
+		.cpu_enable = qcom_enable_link_stack_sanitization,
+	},
+	{},
+};
+
 #endif
 
 const struct arm64_cpu_capabilities arm64_errata[] = {
@@ -447,13 +491,10 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		ERRATA_MIDR_RANGE_LIST(arm64_bp_harden_smccc_cpus),
-		.cpu_enable = enable_smccc_arch_workaround_1,
-	},
-	{
-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		ERRATA_MIDR_RANGE_LIST(qcom_bp_harden_cpus),
-		.cpu_enable = qcom_enable_link_stack_sanitization,
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
+		.matches = multi_entry_cap_matches,
+		.cpu_enable = multi_entry_cap_cpu_enable,
+		.match_list = arm64_bp_harden_list,
 	},
 	{
 		.capability = ARM64_HARDEN_BP_POST_GUEST_EXIT,
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 86e2b98..00ed753 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1259,9 +1259,9 @@ static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
 		return false;
 
 	for (caps = cap_array; caps->matches; caps++)
-		if (caps->capability == cap &&
-		    caps->matches(caps, SCOPE_LOCAL_CPU))
-			return true;
+		if (caps->capability == cap)
+			return caps->matches(caps, SCOPE_LOCAL_CPU);
+
 	return false;
 }
 
@@ -1351,19 +1351,18 @@ static void __init enable_cpu_capabilities(u16 scope_mask)
  * Returns "false" on conflicts.
  */
 static bool
-__verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_list,
+__verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps,
 			u16 scope_mask)
 {
 	bool cpu_has_cap, system_has_cap;
-	const struct arm64_cpu_capabilities *caps;
 
 	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
 
-	for (caps = caps_list; caps->matches; caps++) {
+	for (; caps->matches; caps++) {
 		if (!(caps->type & scope_mask))
 			continue;
 
-		cpu_has_cap = __this_cpu_has_cap(caps_list, caps->capability);
+		cpu_has_cap = caps->matches(caps, SCOPE_LOCAL_CPU);
 		system_has_cap = cpus_have_cap(caps->capability);
 
 		if (system_has_cap) {
-- 
2.7.4
