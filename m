Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D13C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1131020C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1131020C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJIVEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:04:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38202 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbeJIVEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:04:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FCD415BF;
        Tue,  9 Oct 2018 06:47:35 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CCA6D3F5B7;
        Tue,  9 Oct 2018 06:47:33 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com, pelcan@codeaurora.org,
        shankerd@codeaurora.org, suzuki.poulose@arm.com
Subject: [PATCH v2 1/3] arm64: cpufeature: ctr: Fix cpu capability check for late CPUs
Date:   Tue,  9 Oct 2018 14:47:05 +0100
Message-Id: <20181009134707.3479-3-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181009134707.3479-1-suzuki.poulose@arm.com>
References: <20181009134707.3479-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The matches() routine for a capability must honor the "scope"
passed to it and return the proper results.
i.e, when passed with SCOPE_LOCAL_CPU, it should check the
status of the capability on the current CPU. This is used by
verify_local_cpu_capabilities() on a late secondary CPU to make
sure that it's compliant with the established system features.
However, ARM64_HAS_CACHE_{IDC/DIC} always checks the system wide
registers and this could mean that a late secondary CPU could return
"true" (since the CPU hasn't updated the system wide registers yet)
and thus lead the system in an inconsistent state, where
the system assumes it has IDC/DIC feature, while the new CPU
doesn't.

Fixes: commit 6ae4b6e0578886eb36 ("arm64: Add support for new control bits CTR_EL0.DIC and CTR_EL0.IDC")
Cc: Philip Elcan <pelcan@codeaurora.org>
Cc: Shanker Donthineni <shankerd@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 00e7c313f088..ba16bb7762ca 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -854,15 +854,29 @@ static bool has_no_fpsimd(const struct arm64_cpu_capabilities *entry, int __unus
 }
 
 static bool has_cache_idc(const struct arm64_cpu_capabilities *entry,
-			  int __unused)
+			  int scope)
 {
-	return read_sanitised_ftr_reg(SYS_CTR_EL0) & BIT(CTR_IDC_SHIFT);
+	u64 ctr;
+
+	if (scope == SCOPE_SYSTEM)
+		ctr = arm64_ftr_reg_ctrel0.sys_val;
+	else
+		ctr = read_cpuid_cachetype();
+
+	return ctr & BIT(CTR_IDC_SHIFT);
 }
 
 static bool has_cache_dic(const struct arm64_cpu_capabilities *entry,
-			  int __unused)
+			  int scope)
 {
-	return read_sanitised_ftr_reg(SYS_CTR_EL0) & BIT(CTR_DIC_SHIFT);
+	u64 ctr;
+
+	if (scope == SCOPE_SYSTEM)
+		ctr = arm64_ftr_reg_ctrel0.sys_val;
+	else
+		ctr = read_cpuid_cachetype();
+
+	return ctr & BIT(CTR_DIC_SHIFT);
 }
 
 static bool __maybe_unused
-- 
2.19.0

