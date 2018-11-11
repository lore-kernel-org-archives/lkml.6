Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B94CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD52D20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFyTheiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD52D20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbeKLJaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:30:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387993AbeKLITp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:45 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03A16215EA;
        Sun, 11 Nov 2018 22:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975389;
        bh=TDH477Tyq0YJqIgJeHqg23PEG6feRLaCzKWsdanqKe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nFyTheiKL0Lv1ENSX2iwsvzr3VNrjtdHzmBcV1DEO4DRqsK6KvF8OjIIMtN/wWpiY
         36mXlU3d/6R4CL3iHF4p9ikkyDJjJ+3SNM6n1ndv5/zM8Qc/sNRm3uZTvcN4XIEsfZ
         Cae6+Ml9sc+QhVADDdhLK8CvCKT/0vx+y14SEt2g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philip Elcan <pelcan@codeaurora.org>,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 069/350] arm64: cpufeature: ctr: Fix cpu capability check for late CPUs
Date:   Sun, 11 Nov 2018 14:18:53 -0800
Message-Id: <20181111221710.030635098@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpufeature.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -847,15 +847,29 @@ static bool has_no_fpsimd(const struct a
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


