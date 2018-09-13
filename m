Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30943C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BBC20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BBC20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbeIMSuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:50:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59900 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeIMSuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:50:12 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BD9A4CF3;
        Thu, 13 Sep 2018 13:40:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 4.9 78/78] arm64: Handle mismatched cache type
Date:   Thu, 13 Sep 2018 15:32:05 +0200
Message-Id: <20180913131813.418840100@linuxfoundation.org>
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

commit 314d53d297980676011e6fd83dac60db4a01dc70 upstream.

Track mismatches in the cache type register (CTR_EL0), other
than the D/I min line sizes and trap user accesses if there are any.

Fixes: be68a8aaf925 ("arm64: cpufeature: Fix CTR_EL0 field definitions")
Cc: <stable@vger.kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/cpucaps.h |    3 ++-
 arch/arm64/kernel/cpu_errata.c   |   17 ++++++++++++++---
 2 files changed, 16 insertions(+), 4 deletions(-)

--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -37,7 +37,8 @@
 #define ARM64_UNMAP_KERNEL_AT_EL0		16
 #define ARM64_HARDEN_BRANCH_PREDICTOR		17
 #define ARM64_SSBD				18
+#define ARM64_MISMATCHED_CACHE_TYPE		19
 
-#define ARM64_NCAPS				19
+#define ARM64_NCAPS				20
 
 #endif /* __ASM_CPUCAPS_H */
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -32,11 +32,15 @@ is_affected_midr_range(const struct arm6
 }
 
 static bool
-has_mismatched_cache_line_size(const struct arm64_cpu_capabilities *entry,
-				int scope)
+has_mismatched_cache_type(const struct arm64_cpu_capabilities *entry,
+			  int scope)
 {
 	u64 mask = CTR_CACHE_MINLINE_MASK;
 
+	/* Skip matching the min line sizes for cache type check */
+	if (entry->capability == ARM64_MISMATCHED_CACHE_TYPE)
+		mask ^= arm64_ftr_reg_ctrel0.strict_mask;
+
 	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
 	return (read_cpuid_cachetype() & mask) !=
 	       (arm64_ftr_reg_ctrel0.sys_val & mask);
@@ -449,7 +453,14 @@ const struct arm64_cpu_capabilities arm6
 	{
 		.desc = "Mismatched cache line size",
 		.capability = ARM64_MISMATCHED_CACHE_LINE_SIZE,
-		.matches = has_mismatched_cache_line_size,
+		.matches = has_mismatched_cache_type,
+		.def_scope = SCOPE_LOCAL_CPU,
+		.enable = cpu_enable_trap_ctr_access,
+	},
+	{
+		.desc = "Mismatched cache type",
+		.capability = ARM64_MISMATCHED_CACHE_TYPE,
+		.matches = has_mismatched_cache_type,
 		.def_scope = SCOPE_LOCAL_CPU,
 		.enable = cpu_enable_trap_ctr_access,
 	},


