Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBA5C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AF020821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dz26IKTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AF020821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbeKAIIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730030AbeKAIIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:08:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AB0B2084A;
        Wed, 31 Oct 2018 23:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027321;
        bh=x6HF4QIL5OlTuHXmztarRGF4czZrSYY4uhoUeERyU+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dz26IKTnKEg/pFuqSn2qmiCdEKg1O191U9Q1u7nkm/Q6V+EBioM/Lk0WHrdz5aAel
         Sz58vsUNN0+XlphDYYUEpvczdV6cwHsqNMQ879sPo6NqAhMRCaRdvLRGXmIpE1xm8T
         pr9UQSOPnrKAosZ9DNTu+YlyLoQHzbqWQCkD6BAo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 051/126] arm64: entry: Allow handling of undefined instructions from EL1
Date:   Wed, 31 Oct 2018 19:06:39 -0400
Message-Id: <20181031230754.29029-51-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit 0bf0f444b2c49241b2b39aa3cf210d7c95ef6c34 ]

Rather than panic() when taking an undefined instruction exception from
EL1, allow a hook to be registered in case we want to emulate the
instruction, like we will for the SSBS PSTATE manipulation instructions.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/entry.S |  2 +-
 arch/arm64/kernel/traps.c | 11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 28ad8799406f..b0db91eefbde 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -599,7 +599,7 @@ el1_undef:
 	inherit_daif	pstate=x23, tmp=x2
 	mov	x0, sp
 	bl	do_undefinstr
-	ASM_BUG()
+	kernel_exit 1
 el1_dbg:
 	/*
 	 * Debug exception handling
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index d399d459397b..9fa3d69cceaa 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -310,10 +310,12 @@ static int call_undef_hook(struct pt_regs *regs)
 	int (*fn)(struct pt_regs *regs, u32 instr) = NULL;
 	void __user *pc = (void __user *)instruction_pointer(regs);
 
-	if (!user_mode(regs))
-		return 1;
-
-	if (compat_thumb_mode(regs)) {
+	if (!user_mode(regs)) {
+		__le32 instr_le;
+		if (probe_kernel_address((__force __le32 *)pc, instr_le))
+			goto exit;
+		instr = le32_to_cpu(instr_le);
+	} else if (compat_thumb_mode(regs)) {
 		/* 16-bit Thumb instruction */
 		__le16 instr_le;
 		if (get_user(instr_le, (__le16 __user *)pc))
@@ -407,6 +409,7 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 		return;
 
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc);
+	BUG_ON(!user_mode(regs));
 }
 
 void cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
-- 
2.17.1

