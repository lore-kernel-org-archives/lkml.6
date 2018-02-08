Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbeBHMNF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 07:13:05 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34130 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752020AbeBHMNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 07:13:04 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: dave.martin@arm.com
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 1/2] arm64: capabilities: Allow flexibility in scope
Date: Thu,  8 Feb 2018 12:12:37 +0000
Message-Id: <20180208121238.18792-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <86f23003-72bc-5bfc-af40-a92cc68def45@arm.com>
References: <86f23003-72bc-5bfc-af40-a92cc68def45@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far we have restricted the scopes for the capabilities
as follows :
 1) Errata workaround check are run all CPUs (i.e, always
    SCOPE_LOCAL_CPU)
 2) Arm64 features are run only once after the sanitised
    feature registers are available using the SCOPE_SYSTEM.

This prevents detecting cpu features that can be detected
on one or more CPUs with SCOPE_LOCAL_CPU (e.g KPTI). Similarly
for errata workaround with SCOPE_SYSTEM.

This patch makes sure that we allow flexibility of having
any scope for a capability. So, we now run through both
arm64_features and arm64_errata in two phases for detection:

 a) with SCOPE_LOCAL_CPU filter on each boot time enabled
    CPUs.
 b) with SCOPE_SYSTEM filter only once after all boot time
    enabled CPUs are active.

Cc: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 61d4c3cfb1cc..e1a56fa889a5 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -505,6 +505,7 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 
 extern const struct arm64_cpu_capabilities arm64_errata[];
 static void update_cpu_errata_workarounds(void);
+static void update_cpu_local_features(void);
 
 void __init init_cpu_features(struct cpuinfo_arm64 *info)
 {
@@ -554,6 +555,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	 * initialised the cpu feature infrastructure.
 	 */
 	update_cpu_errata_workarounds();
+	update_cpu_local_features();
 }
 
 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
@@ -1387,13 +1389,15 @@ static void verify_local_cpu_errata_workarounds(void)
 static void update_cpu_errata_workarounds(void)
 {
 	update_cpu_capabilities(arm64_errata,
-				ARM64_CPUCAP_SCOPE_ALL,
+				ARM64_CPUCAP_SCOPE_LOCAL_CPU,
 				"enabling workaround for");
 }
 
-static void __init enable_errata_workarounds(void)
+static void update_cpu_local_features(void)
 {
-	enable_cpu_capabilities(arm64_errata, ARM64_CPUCAP_SCOPE_ALL);
+	update_cpu_capabilities(arm64_features,
+				ARM64_CPUCAP_SCOPE_LOCAL_CPU,
+				"detected feature:");
 }
 
 /*
@@ -1430,23 +1434,34 @@ void check_local_cpu_capabilities(void)
 
 	/*
 	 * If we haven't finalised the system capabilities, this CPU gets
-	 * a chance to update the errata work arounds.
+	 * a chance to update the errata work arounds and local CPU features.
 	 * Otherwise, this CPU should verify that it has all the system
 	 * advertised capabilities.
 	 */
-	if (!sys_caps_initialised)
+	if (!sys_caps_initialised) {
 		update_cpu_errata_workarounds();
-	else
+		update_cpu_local_features();
+	} else {
 		verify_local_cpu_capabilities();
+	}
 }
 
 static void __init setup_feature_capabilities(void)
 {
 	update_cpu_capabilities(arm64_features,
-				ARM64_CPUCAP_SCOPE_ALL, "detected feature:");
+				ARM64_CPUCAP_SCOPE_SYSTEM,
+				"detected feature:");
 	enable_cpu_capabilities(arm64_features, ARM64_CPUCAP_SCOPE_ALL);
 }
 
+static void __init setup_errata_workarounds(void)
+{
+	update_cpu_capabilities(arm64_errata,
+				ARM64_CPUCAP_SCOPE_SYSTEM,
+				"enabling workaround for");
+	enable_cpu_capabilities(arm64_errata, ARM64_CPUCAP_SCOPE_ALL);
+}
+
 DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
 EXPORT_SYMBOL(arm64_const_caps_ready);
 
@@ -1468,9 +1483,9 @@ void __init setup_cpu_features(void)
 	u32 cwg;
 	int cls;
 
-	/* Set the CPU feature capabilies */
+	/* Finalise the CPU capabilities */
 	setup_feature_capabilities();
-	enable_errata_workarounds();
+	setup_errata_workarounds();
 	mark_const_caps_ready();
 	setup_elf_hwcaps(arm64_elf_hwcaps);
 
-- 
2.14.3
