Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AF8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0A22084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjJl2Cll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0A22084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbeKLIUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388233AbeKLIUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:03 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33BF22243B;
        Sun, 11 Nov 2018 22:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975407;
        bh=ynZ55oLv51KH+WrFkLQ0zDYmgnrdeCQtRP3BA7VKZDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hjJl2Cll5Ok9v6INyEPP42RwkUjLwhFK2kTj+Ojw/nadv+2PeVIMOFUFgfs33kIfQ
         iOlxQ3vz7Nw3SF8c7jFH1Xl8dsEXxUKGklsZJ7wHqjxcFSBxa3hiXpz5ZXb5mU1gcM
         eAMrunTpSoloYZfVLCM7EW/ple3KHuUjk4x6t0nc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 112/350] arm64: entry: Allow handling of undefined instructions from EL1
Date:   Sun, 11 Nov 2018 14:19:36 -0800
Message-Id: <20181111221711.784284953@linuxfoundation.org>
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
@@ -599,7 +599,7 @@ el1_undef:
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


