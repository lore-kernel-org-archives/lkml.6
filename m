Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeAaS3U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:29:20 -0500
Received: from foss.arm.com ([217.140.101.70]:41648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752079AbeAaS3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:29:18 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        will.deacon@arm.com, mark.rutland@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, ckadabi@codeaurora.org, dave.martin@arm.com,
        jnair@caviumnetworks.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 17/20] arm64: bp hardening: Allow late CPUs to enable work around
Date: Wed, 31 Jan 2018 18:28:04 +0000
Message-Id: <20180131182807.32134-18-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131182807.32134-1-suzuki.poulose@arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We defend against branch predictor training based exploits by
taking specific actions (based on the CPU model) to invalidate
the Branch predictor buffer (BPB). This is implemented by per-CPU
ptr, which installs the specific actions for the CPU model.

The core code can handle the following cases where:
 1) some CPUs doesn't need any work around
 2) a CPU can install the work around, when it is brought up,
    irrespective of how late that happens.

This concludes that it is safe to bring up a CPU which requires
bp hardening defense. However, with the current settings, we
reject a late CPU, if none of the active CPUs didn't need it.

This patch solves issue by changing the flags for the capability
to indicate that it is safe for a late CPU to turn up with the
capability. This is not sufficient to get things working, as
we cannot change the system wide state of the capability established
at the kernel boot. So, we "set" the capability unconditionally
and make sure that the call backs are only installed for those
CPUs which actually needs them. This is done by adding a dummy
entry at the end of the list of shared entries, which :
 a) Always returns true for matches, to ensure we turn this on.
 b) has an empty "cpu_enable" call back, so that we don't take
    any action on the CPUs which weren't matched with the real
    entries.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 10 ++++++++++
 arch/arm64/kernel/cpu_errata.c      | 19 ++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index b73247c27f00..262fa213b1b1 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -252,6 +252,16 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
 	 ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU	|	\
 	 ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU)
 
+/*
+ * CPU errata work around detected at boot time based on one or more CPUs.
+ * All conflicts are ignored. This implies any work around shouldn't
+ * depend when a CPU could be brought up.
+ */
+#define ARM64_CPUCAP_WEAK_LOCAL_CPU_ERRATUM		\
+	(ARM64_CPUCAP_SCOPE_LOCAL_CPU		|	\
+	 ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU	|	\
+	 ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU)
+
 /*
  * CPU feature detected at boot time, on one or more CPUs. A late CPU
  * is not allowed to have the capability when the system doesn't have it.
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index b4f1c1c1f8ca..7f714a628480 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -259,6 +259,12 @@ static const struct midr_range arm64_bp_harden_psci_cpus[] = {
 	{},
 };
 
+static bool bp_hardening_always_on(const struct arm64_cpu_capabilities *cap,
+				   int scope)
+{
+	return true;
+}
+
 static const struct arm64_cpu_capabilities arm64_bp_harden_list[] = {
 	{
 		CAP_MIDR_RANGE_LIST(arm64_bp_harden_psci_cpus),
@@ -268,6 +274,17 @@ static const struct arm64_cpu_capabilities arm64_bp_harden_list[] = {
 		CAP_MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
 		.cpu_enable = qcom_enable_link_stack_sanitization,
 	},
+	/*
+	 * Always enable the capability to make sure a late CPU can
+	 * safely use the BP hardening call backs. Since we use per-CPU
+	 * pointers for the call backs, the work around only affects the
+	 * CPUs which have some methods installed by any real matching entries
+	 * above. As such we don't have any specific cpu_enable() callback
+	 * for this entry, as it is just to make sure we always "detect" it.
+	 */
+	{
+		.matches = bp_hardening_always_on,
+	},
 	{},
 };
 
@@ -407,7 +424,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
+		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_ERRATUM,
 		.matches = multi_entry_cap_matches,
 		.cpu_enable = multi_entry_cap_cpu_enable,
 		.cap_list = arm64_bp_harden_list,
-- 
2.14.3
