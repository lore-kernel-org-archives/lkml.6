Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D086DC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11B820834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11B820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeLAE2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:28:35 -0500
Received: from foss.arm.com ([217.140.101.70]:60992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbeLAE2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:28:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09E161684;
        Fri, 30 Nov 2018 09:18:36 -0800 (PST)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 83F213F5A0;
        Fri, 30 Nov 2018 09:18:34 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        catalin.marinas@arm.com, dave.martin@arm.com, mark.rutland@arm.com,
        vladimir.murzin@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 5/7] arm64: capabilities: Optimize this_cpu_has_cap
Date:   Fri, 30 Nov 2018 17:18:04 +0000
Message-Id: <1543598286-2663-6-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
References: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the sorted capability list to access the capability
entry in this_cpu_has_cap() to avoid iterating over the two
tables.

Reviewed-by: Vladimiri Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimiri Murzin <vladimir.murzin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6a2563b..618857f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1512,25 +1512,6 @@ static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
 			cap_set_elf_hwcap(hwcaps);
 }
 
-/*
- * Check if the current CPU has a given feature capability.
- * Should be called from non-preemptible context.
- */
-static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
-			       unsigned int cap)
-{
-	const struct arm64_cpu_capabilities *caps;
-
-	if (WARN_ON(preemptible()))
-		return false;
-
-	for (caps = cap_array; caps->matches; caps++)
-		if (caps->capability == cap)
-			return caps->matches(caps, SCOPE_LOCAL_CPU);
-
-	return false;
-}
-
 static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 				      u16 scope_mask, const char *info)
 {
@@ -1780,10 +1761,16 @@ static void __init mark_const_caps_ready(void)
 	static_branch_enable(&arm64_const_caps_ready);
 }
 
-bool this_cpu_has_cap(unsigned int cap)
+bool this_cpu_has_cap(unsigned int n)
 {
-	return (__this_cpu_has_cap(arm64_features, cap) ||
-		__this_cpu_has_cap(arm64_errata, cap));
+	if (!WARN_ON(preemptible()) && n < ARM64_NCAPS) {
+		const struct arm64_cpu_capabilities *cap = cpu_hwcaps_ptrs[n];
+
+		if (cap)
+			return cap->matches(cap, SCOPE_LOCAL_CPU);
+	}
+
+	return false;
 }
 
 static void __init setup_system_capabilities(void)
-- 
2.7.4

