Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37F5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824CA20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824CA20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbeICVyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:54:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47616 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbeICVyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:54:16 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EB4F2D24;
        Mon,  3 Sep 2018 17:33:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 4.18 029/123] arm64: Fix mismatched cache line size detection
Date:   Mon,  3 Sep 2018 18:56:13 +0200
Message-Id: <20180903165720.726434146@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suzuki K Poulose <suzuki.poulose@arm.com>

commit 4c4a39dd5fe2d13e2d2fa5fceb8ef95d19fc389a upstream.

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
Cc: <stable@vger.kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/cache.h |    4 ++++
 arch/arm64/kernel/cpu_errata.c |    6 ++++--
 arch/arm64/kernel/cpufeature.c |    2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

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
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -214,7 +214,7 @@ static const struct arm64_ftr_bits ftr_c
 	 * If we have differing I-cache policies, report it as the weakest - VIPT.
 	 */
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_EXACT, 14, 2, ICACHE_POLICY_VIPT),	/* L1Ip */
-	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),	/* IminLine */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, CTR_IMINLINE_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 


