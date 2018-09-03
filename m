Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D777C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0EA20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0EA20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeICOVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:21:05 -0400
Received: from foss.arm.com ([217.140.101.70]:52804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbeICOVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:21:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8560080D;
        Mon,  3 Sep 2018 03:01:39 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0CB143F575;
        Mon,  3 Sep 2018 03:01:37 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     stable@vger.kernel.org
Cc:     suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org
Subject: [PATCH stable 1/2] arm64: Fix mismatched cache line size detection
Date:   Mon,  3 Sep 2018 11:01:32 +0100
Message-Id: <1535968893-5455-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 4c4a39dd5fe2d13e2d2fa5fceb8ef95d19fc389a upstream

If there is a mismatch in the I/D min line size, we must
always use the system wide safe value both in applications
and in the kernel, while performing cache operations. However,
we have been checking more bits than just the min line sizes,
which triggers false negatives. We may need to trap the user
accesses in such cases, but not necessarily patch the kernel.

This patch fixes the check to do the right thing as advertised.
A new capability will be added to check mismatches in other
fields and ensure we trap the CTR accesses.

Fixes: be68a8aaf925 ("arm64: cpufeature: Fix CTR_EL0 field definitions")
Cc: <stable@vger.kernel.org> # v4.14
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cache.h | 5 +++++
 arch/arm64/kernel/cpu_errata.c | 6 ++++--
 arch/arm64/kernel/cpufeature.c | 4 ++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index ea9bb4e..e40f8a2 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -20,9 +20,14 @@
 
 #define CTR_L1IP_SHIFT		14
 #define CTR_L1IP_MASK		3
+#define CTR_DMINLINE_SHIFT	16
+#define CTR_IMINLINE_SHIFT	0
 #define CTR_CWG_SHIFT		24
 #define CTR_CWG_MASK		15
 
+#define CTR_CACHE_MINLINE_MASK	\
+	(0xf << CTR_DMINLINE_SHIFT | 0xf << CTR_IMINLINE_SHIFT)
+
 #define CTR_L1IP(ctr)		(((ctr) >> CTR_L1IP_SHIFT) & CTR_L1IP_MASK)
 
 #define ICACHE_POLICY_VPIPT	0
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index eccdb28..3d1569c 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -48,9 +48,11 @@ static bool
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
 
 static int cpu_enable_trap_ctr_access(void *__unused)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 376cf12..003dd39 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -180,14 +180,14 @@ static const struct arm64_ftr_bits ftr_ctr[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 28, 1, 1),	/* IDC */
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_HIGHER_SAFE, 24, 4, 0),	/* CWG */
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_HIGHER_SAFE, 20, 4, 0),	/* ERG */
-	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 1),	/* DminLine */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, CTR_DMINLINE_SHIFT, 4, 1),
 	/*
 	 * Linux can handle differing I-cache policies. Userspace JITs will
 	 * make use of *minLine.
 	 * If we have differing I-cache policies, report it as the weakest - VIPT.
 	 */
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_EXACT, 14, 2, ICACHE_POLICY_VIPT),	/* L1Ip */
-	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),	/* IminLine */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, CTR_IMINLINE_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
-- 
2.7.4

