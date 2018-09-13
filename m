Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A8FC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1E020C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1E020C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbeIMSuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:50:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59892 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeIMSuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:50:09 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 66E74CF3;
        Thu, 13 Sep 2018 13:40:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 4.9 77/78] arm64: Fix mismatched cache line size detection
Date:   Thu, 13 Sep 2018 15:32:04 +0200
Message-Id: <20180913131813.350744435@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131805.732342940@linuxfoundation.org>
References: <20180913131805.732342940@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 arch/arm64/include/asm/cachetype.h |    5 +++++
 arch/arm64/kernel/cpu_errata.c     |    7 +++++--
 arch/arm64/kernel/cpufeature.c     |    4 ++--
 3 files changed, 12 insertions(+), 4 deletions(-)

--- a/arch/arm64/include/asm/cachetype.h
+++ b/arch/arm64/include/asm/cachetype.h
@@ -22,6 +22,11 @@
 #define CTR_L1IP_MASK		3
 #define CTR_CWG_SHIFT		24
 #define CTR_CWG_MASK		15
+#define CTR_DMINLINE_SHIFT	16
+#define CTR_IMINLINE_SHIFT	0
+
+#define CTR_CACHE_MINLINE_MASK	\
+	((0xf << CTR_DMINLINE_SHIFT) | (0xf << CTR_IMINLINE_SHIFT))
 
 #define ICACHE_POLICY_RESERVED	0
 #define ICACHE_POLICY_AIVIVT	1
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/types.h>
+#include <asm/cachetype.h>
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/cpufeature.h>
@@ -34,9 +35,11 @@ static bool
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
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -152,7 +152,7 @@ static const struct arm64_ftr_bits ftr_c
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 28, 3, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_HIGHER_SAFE, 24, 4, 0),	/* CWG */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),	/* ERG */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 1),	/* DminLine */
+	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, CTR_DMINLINE_SHIFT, 4, 1),
 	/*
 	 * Linux can handle differing I-cache policies. Userspace JITs will
 	 * make use of *minLine.
@@ -160,7 +160,7 @@ static const struct arm64_ftr_bits ftr_c
 	 */
 	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_EXACT, 14, 2, ICACHE_POLICY_AIVIVT),	/* L1Ip */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 4, 10, 0),	/* RAZ */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),	/* IminLine */
+	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, CTR_IMINLINE_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 


