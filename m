Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667B0C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EF420834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EF420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeLAE2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:28:38 -0500
Received: from foss.arm.com ([217.140.101.70]:32774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbeLAE2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:28:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82AB0EBD;
        Fri, 30 Nov 2018 09:18:39 -0800 (PST)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 08D4F3F5A0;
        Fri, 30 Nov 2018 09:18:37 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        catalin.marinas@arm.com, dave.martin@arm.com, mark.rutland@arm.com,
        vladimir.murzin@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 7/7] arm64: capabilities: Batch cpu_enable callbacks
Date:   Fri, 30 Nov 2018 17:18:06 +0000
Message-Id: <1543598286-2663-8-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
References: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use a stop_machine call for each available capability to
enable it on all the CPUs available at boot time. Instead
we could batch the cpu_enable callbacks to a single stop_machine()
call to save us some time.

Reviewed-by: Vladimiri Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimiri Murzin <vladimir.murzin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  3 ++
 arch/arm64/kernel/cpufeature.c      | 70 +++++++++++++++++++++++--------------
 2 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 7e2ec64..0a15e2c 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -357,6 +357,9 @@ extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
 extern struct static_key_false arm64_const_caps_ready;
 
+#define for_each_available_cap(cap)		\
+	for_each_set_bit(cap, cpu_hwcaps, ARM64_NCAPS)
+
 bool this_cpu_has_cap(unsigned int cap);
 
 static inline bool cpu_have_feature(unsigned int num)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 13d729c..b12b9933 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1531,11 +1531,27 @@ static void update_cpu_capabilities(u16 scope_mask)
 	}
 }
 
-static int __enable_cpu_capability(void *arg)
+/*
+ * Enable all the available capabilities on this CPU. The capabilities
+ * with BOOT_CPU scope are handled separately and hence skipped here.
+ */
+static int cpu_enable_non_boot_scope_capabilities(void *__unused)
 {
-	const struct arm64_cpu_capabilities *cap = arg;
+	int i;
+	u16 non_boot_scope = SCOPE_ALL & ~SCOPE_BOOT_CPU;
 
-	cap->cpu_enable(cap);
+	for_each_available_cap(i) {
+		const struct arm64_cpu_capabilities *cap = cpu_hwcaps_ptrs[i];
+
+		if (WARN_ON(!cap))
+			continue;
+
+		if (!(cap->type & non_boot_scope))
+			continue;
+
+		if (cap->cpu_enable)
+			cap->cpu_enable(cap);
+	}
 	return 0;
 }
 
@@ -1543,21 +1559,29 @@ static int __enable_cpu_capability(void *arg)
  * Run through the enabled capabilities and enable() it on all active
  * CPUs
  */
-static void __init
-__enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
-			  u16 scope_mask)
+static void __init enable_cpu_capabilities(u16 scope_mask)
 {
+	int i;
+	const struct arm64_cpu_capabilities *caps;
+	bool boot_scope;
+
 	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
-	for (; caps->matches; caps++) {
-		unsigned int num = caps->capability;
+	boot_scope = !!(scope_mask & SCOPE_BOOT_CPU);
 
-		if (!(caps->type & scope_mask) || !cpus_have_cap(num))
+	for (i = 0; i < ARM64_NCAPS; i++) {
+		unsigned int num;
+
+		caps = cpu_hwcaps_ptrs[i];
+		if (!caps || !(caps->type & scope_mask))
+			continue;
+		num = caps->capability;
+		if (!cpus_have_cap(num))
 			continue;
 
 		/* Ensure cpus_have_const_cap(num) works */
 		static_branch_enable(&cpu_hwcap_keys[num]);
 
-		if (caps->cpu_enable) {
+		if (boot_scope && caps->cpu_enable)
 			/*
 			 * Capabilities with SCOPE_BOOT_CPU scope are finalised
 			 * before any secondary CPU boots. Thus, each secondary
@@ -1566,25 +1590,19 @@ __enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			 * the boot CPU, for which the capability must be
 			 * enabled here. This approach avoids costly
 			 * stop_machine() calls for this case.
-			 *
-			 * Otherwise, use stop_machine() as it schedules the
-			 * work allowing us to modify PSTATE, instead of
-			 * on_each_cpu() which uses an IPI, giving us a PSTATE
-			 * that disappears when we return.
 			 */
-			if (scope_mask & SCOPE_BOOT_CPU)
-				caps->cpu_enable(caps);
-			else
-				stop_machine(__enable_cpu_capability,
-					     (void *)caps, cpu_online_mask);
-		}
+			caps->cpu_enable(caps);
 	}
-}
 
-static void __init enable_cpu_capabilities(u16 scope_mask)
-{
-	__enable_cpu_capabilities(arm64_errata, scope_mask);
-	__enable_cpu_capabilities(arm64_features, scope_mask);
+	/*
+	 * For all non-boot scope capabilities, use stop_machine()
+	 * as it schedules the work allowing us to modify PSTATE,
+	 * instead of on_each_cpu() which uses an IPI, giving us a
+	 * PSTATE that disappears when we return.
+	 */
+	if (!boot_scope)
+		stop_machine(cpu_enable_non_boot_scope_capabilities,
+			     NULL, cpu_online_mask);
 }
 
 /*
-- 
2.7.4

