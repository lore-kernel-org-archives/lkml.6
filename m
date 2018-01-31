Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeAaSaf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:30:35 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41636 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752042AbeAaS3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:29:16 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        will.deacon@arm.com, mark.rutland@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, ckadabi@codeaurora.org, dave.martin@arm.com,
        jnair@caviumnetworks.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 16/20] arm64: Handle shared capability entries
Date: Wed, 31 Jan 2018 18:28:03 +0000
Message-Id: <20180131182807.32134-17-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131182807.32134-1-suzuki.poulose@arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
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
of a capability and ensures :
 1) The capabilitiy is set when at least one of the entry detects
 2) Action is only taken for the entries that detects.

This avoids explicit checks in the call backs. The only constraint
here is that, all the entries should have the same "type".

Cc: Dave Martin <dave.martin@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  1 +
 arch/arm64/kernel/cpu_errata.c      | 53 ++++++++++++++++++++++++++++++++-----
 arch/arm64/kernel/cpufeature.c      |  7 +++--
 3 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 462c35d1a38c..b73247c27f00 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -290,6 +290,7 @@ struct arm64_cpu_capabilities {
 			bool sign;
 			unsigned long hwcap;
 		};
+		const struct arm64_cpu_capabilities *cap_list;
 	};
 };
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index eff5f4e380ac..b4f1c1c1f8ca 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -213,6 +213,36 @@ static void qcom_enable_link_stack_sanitization(
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
@@ -229,6 +259,18 @@ static const struct midr_range arm64_bp_harden_psci_cpus[] = {
 	{},
 };
 
+static const struct arm64_cpu_capabilities arm64_bp_harden_list[] = {
+	{
+		CAP_MIDR_RANGE_LIST(arm64_bp_harden_psci_cpus),
+		.cpu_enable = enable_psci_bp_hardening,
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
@@ -365,13 +407,10 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		ERRATA_MIDR_RANGE_LIST(arm64_bp_harden_psci_cpus),
-		.cpu_enable = enable_psci_bp_hardening,
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
index 65a8e5cc600c..13e30c1b1e99 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1181,9 +1181,8 @@ static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
 		return false;
 
 	for (caps = cap_array; caps->matches; caps++)
-		if (caps->capability == cap &&
-		    caps->matches(caps, SCOPE_LOCAL_CPU))
-			return true;
+		if (caps->capability == cap)
+			return caps->matches(caps, SCOPE_LOCAL_CPU);
 	return false;
 }
 
@@ -1275,7 +1274,7 @@ static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_li
 		if (!(caps->type & scope_mask))
 			continue;
 
-		cpu_has_cap = __this_cpu_has_cap(caps_list, caps->capability);
+		cpu_has_cap = caps->matches(caps, SCOPE_LOCAL_CPU);
 		system_has_cap =  cpus_have_cap(caps->capability);
 
 		if (system_has_cap) {
-- 
2.14.3
