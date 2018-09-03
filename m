Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4FAC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D0120658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D0120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbeICVyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:54:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47636 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbeICVyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:54:24 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5221DD16;
        Mon,  3 Sep 2018 17:33:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 4.18 030/123] arm64: Handle mismatched cache type
Date:   Mon,  3 Sep 2018 18:56:14 +0200
Message-Id: <20180903165720.764050546@linuxfoundation.org>
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
@@ -49,7 +49,8 @@
 #define ARM64_HAS_CACHE_DIC			28
 #define ARM64_HW_DBM				29
 #define ARM64_SSBD				30
+#define ARM64_MISMATCHED_CACHE_TYPE		31
 
-#define ARM64_NCAPS				31
+#define ARM64_NCAPS				32
 
 #endif /* __ASM_CPUCAPS_H */
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -65,11 +65,15 @@ is_kryo_midr(const struct arm64_cpu_capa
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
@@ -615,7 +619,14 @@ const struct arm64_cpu_capabilities arm6
 	{
 		.desc = "Mismatched cache line size",
 		.capability = ARM64_MISMATCHED_CACHE_LINE_SIZE,
-		.matches = has_mismatched_cache_line_size,
+		.matches = has_mismatched_cache_type,
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
+		.cpu_enable = cpu_enable_trap_ctr_access,
+	},
+	{
+		.desc = "Mismatched cache type",
+		.capability = ARM64_MISMATCHED_CACHE_TYPE,
+		.matches = has_mismatched_cache_type,
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 		.cpu_enable = cpu_enable_trap_ctr_access,
 	},


