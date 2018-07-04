Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0B5C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 22:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BCCE2403E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 22:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCCE2403E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753105AbeGDWIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 18:08:12 -0400
Received: from foss.arm.com ([217.140.101.70]:43156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752815AbeGDWIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 18:08:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C22480D;
        Wed,  4 Jul 2018 15:08:09 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D975B3F5A0;
        Wed,  4 Jul 2018 15:08:07 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com,
        ard.biesheuvel@linaro.org, catalin.marinas@arm.com,
        dave.martin@arm.com
Subject: [PATCH 1/2] arm64: Fix mismatched cache line size detection
Date:   Wed,  4 Jul 2018 23:07:45 +0100
Message-Id: <1530742066-16276-2-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530742066-16276-1-git-send-email-suzuki.poulose@arm.com>
References: <1530742066-16276-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is a mismatch in the I/D min line size, we must
always use the system wide safe value both in applications
and in the kernel, while performing cache operations. However,
we have been checking more bits than just the min line sizes,
which triggers false negatives. We may need to trap the user
accesses in such cases, but not necessarily patch the kernel.

This patch fixes the check to do the right thing as advertised.
A new capability will be added to check mismatches in other
fields and ensure we trap the CTR accesses.

Reported-by: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cache.h | 4 ++++
 arch/arm64/kernel/cpu_errata.c | 6 ++++--
 arch/arm64/kernel/cpufeature.c | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 5df5cfe..5ee5bca 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -21,12 +21,16 @@
 #define CTR_L1IP_SHIFT		14
 #define CTR_L1IP_MASK		3
 #define CTR_DMINLINE_SHIFT	16
+#define CTR_IMINLINE_SHIFT	0
 #define CTR_ERG_SHIFT		20
 #define CTR_CWG_SHIFT		24
 #define CTR_CWG_MASK		15
 #define CTR_IDC_SHIFT		28
 #define CTR_DIC_SHIFT		29
 
+#define CTR_CACHE_MINLINE_MASK	\
+	(0xf << CTR_DMINLINE_SHIFT | 0xf << CTR_IMINLINE_SHIFT)
+
 #define CTR_L1IP(ctr)		(((ctr) >> CTR_L1IP_SHIFT) & CTR_L1IP_MASK)
 
 #define ICACHE_POLICY_VPIPT	0
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 1d2b6d7..5d1fa92 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -68,9 +68,11 @@ static bool
 has_mismatched_cache_line_size(const struct arm64_cpu_capabilities *entry,
 				int scope)
 {
+	u64 mask = CTR_CACHE_MINLINE_MASK;
+
 	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
-	return (read_cpuid_cachetype() & arm64_ftr_reg_ctrel0.strict_mask) !=
-		(arm64_ftr_reg_ctrel0.sys_val & arm64_ftr_reg_ctrel0.strict_mask);
+	return (read_cpuid_cachetype() & mask) !=
+	       (arm64_ftr_reg_ctrel0.sys_val & mask);
 }
 
 static void
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f24892a..25d5cef 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -214,7 +214,7 @@ static const struct arm64_ftr_bits ftr_ctr[] = {
 	 * If we have differing I-cache policies, report it as the weakest - VIPT.
 	 */
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_EXACT, 14, 2, ICACHE_POLICY_VIPT),	/* L1Ip */
-	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),	/* IminLine */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, CTR_IMINLINE_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
-- 
2.9.5

