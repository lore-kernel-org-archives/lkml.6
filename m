Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ECDECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE5820843
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e17hZJC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE5820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbeKAIIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:08:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbeKAIIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:08:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0956C20830;
        Wed, 31 Oct 2018 23:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027281;
        bh=XiB6+yoLpEVzXeY+1my8Pc8erEWPKE0vwUcdlH/oNSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e17hZJC7Mpg1LXVnScMAU92BwJxktm9w7mUFMwytrIAtNoMVOS1vTcnaEXucL9xVY
         x9x4Ou7i+6FvEPOWKtKxGGO0Ey+7jQwkTPmV/96MI/Vvt1g+ES5yhM3s+bsC7I8oR3
         CFFEjf96zmpghFQiBhhNQaAWW5o6ljU//0uSAQe8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Philip Elcan <pelcan@codeaurora.org>,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 007/126] arm64: cpufeature: ctr: Fix cpu capability check for late CPUs
Date:   Wed, 31 Oct 2018 19:05:55 -0400
Message-Id: <20181031230754.29029-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit 8ab66cbe63aeaf9e5970fb4aaef1c660fca59321 ]

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
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e4103b718a7c..b687c80a9c10 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -847,15 +847,29 @@ static bool has_no_fpsimd(const struct arm64_cpu_capabilities *entry, int __unus
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
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-- 
2.17.1

