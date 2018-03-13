Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933154AbeCMLwJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:52:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36456 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933051AbeCMLwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:52:07 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will.deacon@arm.com, dave.martin@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        ard.biesheuvel@linaro.org, jnair@caviumnetworks.com,
        ckadabi@codeaurora.org, robin.murphy@arm.com, shankerd@codeaurora.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 10/22] arm64: capabilities: Allow features based on local CPU scope
Date: Tue, 13 Mar 2018 11:51:08 +0000
Message-Id: <20180313115120.17256-11-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313115120.17256-1-suzuki.poulose@arm.com>
References: <20180313115120.17256-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far we have treated the feature capabilities as system wide
and this wouldn't help with features that could be detected locally
on one or more CPUs (e.g, KPTI, Software prefetch). This patch
splits the feature detection to two phases :

 1) Local CPU features are checked on all boot time active CPUs.
 2) System wide features are checked only once after all CPUs are
    active.

Reviewed-by: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9f2152858c05..0a286be446c3 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -507,6 +507,7 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 }
 
 extern const struct arm64_cpu_capabilities arm64_errata[];
+static const struct arm64_cpu_capabilities arm64_features[];
 static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 				    u16 scope_mask, const char *info);
 
@@ -554,11 +555,12 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	}
 
 	/*
-	 * Run the errata work around checks on the boot CPU, once we have
-	 * initialised the cpu feature infrastructure.
+	 * Run the errata work around and local feature checks on the
+	 * boot CPU, once we have initialised the cpu feature infrastructure.
 	 */
 	update_cpu_capabilities(arm64_errata, SCOPE_LOCAL_CPU,
 				"enabling workaround for");
+	update_cpu_capabilities(arm64_features, SCOPE_LOCAL_CPU, "detected:");
 }
 
 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
@@ -1440,15 +1442,18 @@ void check_local_cpu_capabilities(void)
 
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
+					"detected:");
+	} else {
 		verify_local_cpu_capabilities();
+	}
 }
 
 DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
@@ -1472,7 +1477,7 @@ void __init setup_cpu_features(void)
 	u32 cwg;
 
 	/* Set the CPU feature capabilies */
-	update_cpu_capabilities(arm64_features, SCOPE_ALL, "detected:");
+	update_cpu_capabilities(arm64_features, SCOPE_SYSTEM, "detected:");
 	update_cpu_capabilities(arm64_errata, SCOPE_SYSTEM,
 				"enabling workaround for");
 	enable_cpu_capabilities(arm64_features, SCOPE_ALL);
-- 
2.14.3
