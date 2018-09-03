Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC7BC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8047520843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8047520843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeICOVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:21:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52816 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727459AbeICOVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:21:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4658FED1;
        Mon,  3 Sep 2018 03:01:41 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C25C83F575;
        Mon,  3 Sep 2018 03:01:39 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     stable@vger.kernel.org
Cc:     suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org
Subject: [PATCH stable 2/2] arm64: Handle mismatched cache type
Date:   Mon,  3 Sep 2018 11:01:33 +0100
Message-Id: <1535968893-5455-2-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535968893-5455-1-git-send-email-suzuki.poulose@arm.com>
References: <1535968893-5455-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 314d53d297980676011e6fd83dac60db4a01dc70 upstream

Track mismatches in the cache type register (CTR_EL0), other
than the D/I min line sizes and trap user accesses if there are any.

Fixes: be68a8aaf925 ("arm64: cpufeature: Fix CTR_EL0 field definitions")
Cc: <stable@vger.kernel.org> # v4.14
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cpucaps.h |  3 ++-
 arch/arm64/kernel/cpu_errata.c   | 17 ++++++++++++++---
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 76c0d23..7d6425d 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -44,7 +44,8 @@
 #define ARM64_HARDEN_BRANCH_PREDICTOR		24
 #define ARM64_HARDEN_BP_POST_GUEST_EXIT		25
 #define ARM64_SSBD				26
+#define ARM64_MISMATCHED_CACHE_TYPE		27
 
-#define ARM64_NCAPS				27
+#define ARM64_NCAPS				28
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 3d1569c..762b1ad 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -45,11 +45,15 @@ is_kryo_midr(const struct arm64_cpu_capabilities *entry, int scope)
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
@@ -513,7 +517,14 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
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
-- 
2.7.4

