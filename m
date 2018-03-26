Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeCZORs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:17:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41062 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751997AbeCZONe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:13:34 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, dave.martin@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        ckadabi@codeaurora.org, shankerd@codeaurora.org,
        ard.biesheuvel@linaro.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 09/22] arm64: capabilities: Split the processing of errata work arounds
Date: Mon, 26 Mar 2018 15:12:36 +0100
Message-Id: <1522073569-29174-10-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522073569-29174-1-git-send-email-suzuki.poulose@arm.com>
References: <1522073569-29174-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now we run through the errata workarounds check on all boot
active CPUs, with SCOPE_ALL. This wouldn't help for detecting erratum
workarounds with a SYSTEM_SCOPE. There are none yet, but we plan to
introduce some: let us clean this up so that such workarounds can be
detected and enabled correctly.

So, we run the checks with SCOPE_LOCAL_CPU on all CPUs and SCOPE_SYSTEM
checks are run only once after all the boot time CPUs are active.

Reviewed-by: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 703215f..b8d23f4 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -560,7 +560,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	 * Run the errata work around checks on the boot CPU, once we have
 	 * initialised the cpu feature infrastructure.
 	 */
-	update_cpu_capabilities(arm64_errata, SCOPE_ALL,
+	update_cpu_capabilities(arm64_errata, SCOPE_LOCAL_CPU,
 				"enabling workaround for");
 }
 
@@ -1452,7 +1452,7 @@ void check_local_cpu_capabilities(void)
 	 * advertised capabilities.
 	 */
 	if (!sys_caps_initialised)
-		update_cpu_capabilities(arm64_errata, SCOPE_ALL,
+		update_cpu_capabilities(arm64_errata, SCOPE_LOCAL_CPU,
 					"enabling workaround for");
 	else
 		verify_local_cpu_capabilities();
@@ -1480,6 +1480,8 @@ void __init setup_cpu_features(void)
 
 	/* Set the CPU feature capabilies */
 	update_cpu_capabilities(arm64_features, SCOPE_ALL, "detected:");
+	update_cpu_capabilities(arm64_errata, SCOPE_SYSTEM,
+				"enabling workaround for");
 	enable_cpu_capabilities(arm64_features, SCOPE_ALL);
 	enable_cpu_capabilities(arm64_errata, SCOPE_ALL);
 	mark_const_caps_ready();
-- 
2.7.4
