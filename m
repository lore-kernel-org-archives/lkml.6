Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD33C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE4A2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE4A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeLAE2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:28:34 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60984 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727588AbeLAE2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:28:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4763C1682;
        Fri, 30 Nov 2018 09:18:34 -0800 (PST)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C11C63F5A0;
        Fri, 30 Nov 2018 09:18:32 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        catalin.marinas@arm.com, dave.martin@arm.com, mark.rutland@arm.com,
        vladimir.murzin@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 4/7] arm64: capabilities: Speed up capability lookup
Date:   Fri, 30 Nov 2018 17:18:03 +0000
Message-Id: <1543598286-2663-5-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
References: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We maintain two separate tables of capabilities, errata and features,
which decide the system capabilities. We iterate over each of these
tables for various operations (e.g, detection, verification etc.).
We do not have a way to map a system "capability" to its entry,
(i.e, cap -> struct arm64_cpu_capabilities) which is needed for
this_cpu_has_cap(). So we iterate over the table one by one to
find the entry and then do the operation. Also, this prevents
us from optimizing the way we "enable" the capabilities on the
CPUs, where we now issue a stop_machine() for each available
capability.

One solution is to merge the two tables into a single table,
sorted by the capability. But this is has the following
disadvantages:
  - We loose the "classification" of an errata vs. feature
  - It is quite easy to make a mistake when adding an entry,
    unless we sort the table at runtime.

So we maintain a list of pointers to the capability entry, sorted
by the "cap number" in a separate array, initialized at boot time.
The only restriction is that we can have one "entry" per capability.
While at it, remove the duplicate declaration of arm64_errata table.

Reviewed-by: Vladimiri Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimiri Murzin <vladimir.murzin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index aec5ecb..6a2563b 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -52,6 +52,7 @@ unsigned int compat_elf_hwcap2 __read_mostly;
 
 DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 EXPORT_SYMBOL(cpu_hwcaps);
+static struct arm64_cpu_capabilities const __ro_after_init *cpu_hwcaps_ptrs[ARM64_NCAPS];
 
 /*
  * Flag to indicate if we have computed the system wide
@@ -518,6 +519,29 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 }
 
 extern const struct arm64_cpu_capabilities arm64_errata[];
+static const struct arm64_cpu_capabilities arm64_features[];
+
+static void __init
+init_cpu_hwcaps_indirect_list_from_array(const struct arm64_cpu_capabilities *caps)
+{
+	for (; caps->matches; caps++) {
+		if (WARN(caps->capability > ARM64_NCAPS,
+			"Invalid capability %d\n", caps->capability))
+			continue;
+		if (WARN(cpu_hwcaps_ptrs[caps->capability],
+			"Duplicate entry for capability %d\n",
+			caps->capability))
+			continue;
+		cpu_hwcaps_ptrs[caps->capability] = caps;
+	}
+}
+
+static void __init init_cpu_hwcaps_indirect_list(void)
+{
+	init_cpu_hwcaps_indirect_list_from_array(arm64_features);
+	init_cpu_hwcaps_indirect_list_from_array(arm64_errata);
+}
+
 static void __init setup_boot_cpu_capabilities(void);
 
 void __init init_cpu_features(struct cpuinfo_arm64 *info)
@@ -564,6 +588,12 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	}
 
 	/*
+	 * Initialize the indirect array of CPU hwcaps capabilities pointers
+	 * before we handle the boot CPU below.
+	 */
+	init_cpu_hwcaps_indirect_list();
+
+	/*
 	 * Detect and enable early CPU capabilities based on the boot CPU,
 	 * after we have initialised the CPU feature infrastructure.
 	 */
@@ -1750,8 +1780,6 @@ static void __init mark_const_caps_ready(void)
 	static_branch_enable(&arm64_const_caps_ready);
 }
 
-extern const struct arm64_cpu_capabilities arm64_errata[];
-
 bool this_cpu_has_cap(unsigned int cap)
 {
 	return (__this_cpu_has_cap(arm64_features, cap) ||
-- 
2.7.4

