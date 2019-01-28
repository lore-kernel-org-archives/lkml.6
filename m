Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FBAC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8407921738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="It2VOLZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfA1LLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:11:35 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:7261 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbfA1LLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:11:30 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43p6Q10thhz9v1q9;
        Mon, 28 Jan 2019 12:11:21 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=It2VOLZ5; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id BTKxBnuJQN4c; Mon, 28 Jan 2019 12:11:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43p6Q06xzYz9v1q3;
        Mon, 28 Jan 2019 12:11:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1548673881; bh=Oyahhs2dPeEr1U/OySi46JgAIKGTXPGVCaOaBMFpyA0=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=It2VOLZ5WRfdc061ojDYvS2sXjoi0mY0Kq5vZrbzNUtOKABgRTgADWJEvSSyRk9m0
         0RPX58KszWYrReXaMY7nwInLpl0eEbRoPueIoJLe5knXwx2VxR6AI1C7HccFd/76Xr
         8QYey6g11WK4a/x2bqklNNgmDtxmaZylyCUxSjuI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6F39B8B79D;
        Mon, 28 Jan 2019 12:11:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id EX9woafcjlrO; Mon, 28 Jan 2019 12:11:27 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3604E8B796;
        Mon, 28 Jan 2019 12:11:27 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 288B372DE6; Mon, 28 Jan 2019 11:11:27 +0000 (UTC)
Message-Id: <96a6861f3b7ec6ca2a59ee50c327fa5f2d03bbee.1548673552.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548673552.git.christophe.leroy@c-s.fr>
References: <cover.1548673552.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 08/11] powerpc/40x: add exception frame marker
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 28 Jan 2019 11:11:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds STACK_FRAME_REGS_MARKER in the stack at exception entry
in order to see interrupts in call traces as below:

[    0.013964] Call Trace:
[    0.014014] [c0745db0] [c007a9d4] tick_periodic.constprop.5+0xd8/0x104 (unreliable)
[    0.014086] [c0745dc0] [c007aa20] tick_handle_periodic+0x20/0x9c
[    0.014181] [c0745de0] [c0009cd0] timer_interrupt+0xa0/0x264
[    0.014258] [c0745e10] [c000e484] ret_from_except+0x0/0x14
[    0.014390] --- interrupt: 901 at console_unlock.part.7+0x3f4/0x528
[    0.014390]     LR = console_unlock.part.7+0x3f0/0x528
[    0.014455] [c0745ee0] [c0050334] console_unlock.part.7+0x114/0x528 (unreliable)
[    0.014542] [c0745f30] [c00524e0] register_console+0x3d8/0x44c
[    0.014625] [c0745f60] [c0675aac] cpm_uart_console_init+0x18/0x2c
[    0.014709] [c0745f70] [c06614f4] console_init+0x114/0x1cc
[    0.014795] [c0745fb0] [c0658b68] start_kernel+0x300/0x3d8
[    0.014864] [c0745ff0] [c00022cc] start_here+0x44/0x98

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_40x.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 59f6f53f1ac2..f3bfb695f952 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -132,6 +132,9 @@ _ENTRY(saved_ksp_limit)
 	tovirt(r1,r11);			/* set new kernel sp */	\
 	rlwinm	r9,r9,0,14,12;		/* clear MSR_WE (necessary?)	   */\
 	stw	r0,GPR0(r11);						     \
+	lis	r10, STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */\
+	addi	r10, r10, STACK_FRAME_REGS_MARKER@l;			     \
+	stw	r10, 8(r11);						     \
 	SAVE_4GPRS(3, r11);						     \
 	SAVE_2GPRS(7, r11)
 
@@ -174,6 +177,9 @@ _ENTRY(saved_ksp_limit)
 	tovirt(r1,r11);							     \
 	rlwinm	r9,r9,0,14,12;		/* clear MSR_WE (necessary?)	   */\
 	stw	r0,GPR0(r11);						     \
+	lis	r10, STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */\
+	addi	r10, r10, STACK_FRAME_REGS_MARKER@l;			     \
+	stw	r10, 8(r11);						     \
 	SAVE_4GPRS(3, r11);						     \
 	SAVE_2GPRS(7, r11)
 
-- 
2.13.3

