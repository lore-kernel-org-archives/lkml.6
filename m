Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbeBIR5o (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 12:57:44 -0500
Received: from foss.arm.com ([217.140.101.70]:50374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752534AbeBIR5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:57:41 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: dave.martin@arm.com, linux-kernel@vger.kernel.org, will.deacon@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        jnair@caviumnetworks.com, ckadabi@codeaurora.org, robin.murphy@arm.com,
        ard.biesheuvel@linaro.org, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 08/21] arm64: capabilities: Split the processing of errata work arounds
Date: Fri,  9 Feb 2018 17:54:46 +0000
Message-Id: <20180209175513.17100-17-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180209175513.17100-1-suzuki.poulose@arm.com>
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now we run through the errata workarounds check on all boot
active CPUs, with SCOPE_ALL. This doesn't help with detecting the
errata's with a SYSTEM_SCOPE. While nobody uses it, let us clean
this up in preparation for merging capability handling.

So, we run the checks with SCOPE_LOCAL_CPU on all CPUs and SCOPE_SYSTEM
checks are run only once after all the boot time CPUs are active.

Cc: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9f52678a4df1..a6e124063e21 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -554,7 +554,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	 * Run the errata work around checks on the boot CPU, once we have
 	 * initialised the cpu feature infrastructure.
 	 */
-	update_cpu_capabilities(arm64_errata, SCOPE_ALL,
+	update_cpu_capabilities(arm64_errata, SCOPE_LOCAL_CPU,
 				"enabling workaround for");
 }
 
@@ -1416,7 +1416,7 @@ void check_local_cpu_capabilities(void)
 	 * advertised capabilities.
 	 */
 	if (!sys_caps_initialised)
-		update_cpu_capabilities(arm64_errata, SCOPE_ALL,
+		update_cpu_capabilities(arm64_errata, SCOPE_LOCAL_CPU,
 					"enabling workaround for");
 	else
 		verify_local_cpu_capabilities();
@@ -1446,6 +1446,8 @@ void __init setup_cpu_features(void)
 	/* Set the CPU feature capabilies */
 	update_cpu_capabilities(arm64_features, SCOPE_ALL,
 				"detected feature:");
+	update_cpu_capabilities(arm64_errata, SCOPE_SYSTEM,
+				"enabling workaround for");
 	enable_cpu_capabilities(arm64_features, SCOPE_ALL);
 	enable_cpu_capabilities(arm64_errata, SCOPE_ALL);
 	mark_const_caps_ready();
-- 
2.14.3
