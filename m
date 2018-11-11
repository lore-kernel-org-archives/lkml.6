Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA59C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D6D20871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYL8QAWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D6D20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731983AbeKLJ6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:58:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:60706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731526AbeKLIRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:34 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C987F214DB;
        Sun, 11 Nov 2018 22:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975258;
        bh=33PV/GUXeHGA8Ezr8WVCVruZi44fHfHLX7KvR6e9DoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NYL8QAWyGKm/ZIL0yaTWLqsYE64+a5xGtyJDDoVCRwJ0Wp3iGFepf0ewRo2MPIV7d
         UygEHCmkDmrYZyLs9iDfCtcSjcis4X0JEgiSxkpBdioOdJ6w0vMzz+7FuGbOI9f+aj
         sllQSIFBvCBNsCsiB7axwHtaeK+AHcfd54pnzdBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 104/361] arm64: entry: Allow handling of undefined instructions from EL1
Date:   Sun, 11 Nov 2018 14:17:31 -0800
Message-Id: <20181111221634.231771715@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit 0bf0f444b2c49241b2b39aa3cf210d7c95ef6c34 ]

Rather than panic() when taking an undefined instruction exception from
EL1, allow a hook to be registered in case we want to emulate the
instruction, like we will for the SSBS PSTATE manipulation instructions.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/entry.S |    2 +-
 arch/arm64/kernel/traps.c |   11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -589,7 +589,7 @@ el1_undef:
 	inherit_daif	pstate=x23, tmp=x2
 	mov	x0, sp
 	bl	do_undefinstr
-	ASM_BUG()
+	kernel_exit 1
 el1_dbg:
 	/*
 	 * Debug exception handling
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -310,10 +310,12 @@ static int call_undef_hook(struct pt_reg
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
@@ -407,6 +409,7 @@ asmlinkage void __exception do_undefinst
 		return;
 
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc);
+	BUG_ON(!user_mode(regs));
 }
 
 void cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)


