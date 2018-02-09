Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbeBISEO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 13:04:14 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50386 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752631AbeBIR5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:57:43 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: dave.martin@arm.com, linux-kernel@vger.kernel.org, will.deacon@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        jnair@caviumnetworks.com, ckadabi@codeaurora.org, robin.murphy@arm.com,
        ard.biesheuvel@linaro.org, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 09/21] arm64: capabilities: Allow features based on local CPU scope
Date: Fri,  9 Feb 2018 17:54:47 +0000
Message-Id: <20180209175513.17100-18-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180209175513.17100-1-suzuki.poulose@arm.com>
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far we have treated the feature capabilities as system wide
and this doesn't help with features that could be detected on
one or more CPUs (e.g, KPTI, Software prefetch). This patch
splits the feature detection to two phases :

 1) Local CPU features are checked on all boot time active CPUs.
 2) System wide features are checked only once after all CPUs are
    active.

Cc: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a6e124063e21..45bac0c4ae91 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -551,11 +551,13 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	}
 
 	/*
-	 * Run the errata work around checks on the boot CPU, once we have
-	 * initialised the cpu feature infrastructure.
+	 * Run the errata work around and local feature checks on the
+	 * boot CPU, once we have initialised the cpu feature infrastructure.
 	 */
 	update_cpu_capabilities(arm64_errata, SCOPE_LOCAL_CPU,
 				"enabling workaround for");
+	update_cpu_capabilities(arm64_features, SCOPE_LOCAL_CPU,
+				"detected feature:");
 }
 
 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
@@ -1411,15 +1413,18 @@ void check_local_cpu_capabilities(void)
 
 	/*
 	 * If we haven't finalised the system capabilities, this CPU gets
-	 * a chance to update the errata work arounds.
+	 * a chance to update the errata work arounds and local features.
 	 * Otherwise, this CPU should verify that it has all the system
 	 * advertised capabilities.
 	 */
-	if (!sys_caps_initialised)
+	if (!sys_caps_initialised) {
 		update_cpu_capabilities(arm64_errata, SCOPE_LOCAL_CPU,
 					"enabling workaround for");
-	else
+		update_cpu_capabilities(arm64_features, SCOPE_LOCAL_CPU,
+					"detected feature:");
+	} else {
 		verify_local_cpu_capabilities();
+	}
 }
 
 DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
@@ -1444,7 +1449,7 @@ void __init setup_cpu_features(void)
 	int cls;
 
 	/* Set the CPU feature capabilies */
-	update_cpu_capabilities(arm64_features, SCOPE_ALL,
+	update_cpu_capabilities(arm64_features, SCOPE_SYSTEM,
 				"detected feature:");
 	update_cpu_capabilities(arm64_errata, SCOPE_SYSTEM,
 				"enabling workaround for");
-- 
2.14.3
