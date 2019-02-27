Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86391C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00AE20863
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="YoOosO45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfB0Lpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:45:33 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:5864 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfB0Lpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 06:45:33 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 448YlZ0Rz6z9v0Mp;
        Wed, 27 Feb 2019 12:45:30 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=YoOosO45; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id g5CZiu0gGOF2; Wed, 27 Feb 2019 12:45:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 448YlY6Qdnz9v0Ml;
        Wed, 27 Feb 2019 12:45:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1551267929; bh=HwxKsSueilo/aKyERpcm2BkgXwUmJORU/T6H3IaJq2c=;
        h=From:Subject:To:Cc:Date:From;
        b=YoOosO45qcufFlQBmVE1zKz8G+Sx2KtwG8gpdnrVfE3n7r9swhvexOmamhXFvHR3I
         WVmgIZwvkEyGlFRlE1Z3Xduwn2blEGkfY9ZpOX04NwKgll6ajhN7JXja9THhm1rVAm
         y77JNtZyG47azmgSsZVE96nTGLxD2TFXyfxY/3r8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 20D488B8BA;
        Wed, 27 Feb 2019 12:45:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id gpTQDLPIIV4Q; Wed, 27 Feb 2019 12:45:31 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 035D88B754;
        Wed, 27 Feb 2019 12:45:31 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id CE9D66F201; Wed, 27 Feb 2019 11:45:30 +0000 (UTC)
Message-Id: <d273fd9f1cc7ee36e1ee4da20631d507c39efe6d.1551267823.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32: Clear on-stack exception marker upon exception
 return
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicolai Stange <nstange@suse.de>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        stable@vger.kernel.org
Date:   Wed, 27 Feb 2019 11:45:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear the on-stack STACK_FRAME_REGS_MARKER on exception exit in order
to avoid confusing stacktrace like the one below.

Call Trace:
[c0e9dca0] [c01c42a0] print_address_description+0x64/0x2bc (unreliable)
[c0e9dcd0] [c01c4684] kasan_report+0xfc/0x180
[c0e9dd10] [c0895130] memchr+0x24/0x74
[c0e9dd30] [c00a9e38] msg_print_text+0x124/0x574
[c0e9dde0] [c00ab710] console_unlock+0x114/0x4f8
[c0e9de40] [c00adc60] vprintk_emit+0x188/0x1c4
--- interrupt: c0e9df00 at 0x400f330
    LR = init_stack+0x1f00/0x2000
[c0e9de80] [c00ae3c4] printk+0xa8/0xcc (unreliable)
[c0e9df20] [c0c27e44] early_irq_init+0x38/0x108
[c0e9df50] [c0c15434] start_kernel+0x310/0x488
[c0e9dff0] [00003484] 0x3484

With this patch the trace becomes:

Call Trace:
[c0e9dca0] [c01c42c0] print_address_description+0x64/0x2bc (unreliable)
[c0e9dcd0] [c01c46a4] kasan_report+0xfc/0x180
[c0e9dd10] [c0895150] memchr+0x24/0x74
[c0e9dd30] [c00a9e58] msg_print_text+0x124/0x574
[c0e9dde0] [c00ab730] console_unlock+0x114/0x4f8
[c0e9de40] [c00adc80] vprintk_emit+0x188/0x1c4
[c0e9de80] [c00ae3e4] printk+0xa8/0xcc
[c0e9df20] [c0c27e44] early_irq_init+0x38/0x108
[c0e9df50] [c0c15434] start_kernel+0x310/0x488
[c0e9dff0] [00003484] 0x3484

Cc: stable@vger.kernel.org
Cc: Nicolai Stange <nstange@suse.de>

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/entry_32.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 96dce6a4b61e..b61cfd29c76f 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -730,6 +730,9 @@ fast_exception_return:
 	mtcr	r10
 	lwz	r10,_LINK(r11)
 	mtlr	r10
+	/* Clear the exception_marker on the stack to avoid confusing stacktrace */
+	li	r10, 0
+	stw	r10, 8(r11)
 	REST_GPR(10, r11)
 #if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
 	mtspr	SPRN_NRI, r0
@@ -961,6 +964,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	mtcrf	0xFF,r10
 	mtlr	r11
 
+	/* Clear the exception_marker on the stack to avoid confusing stacktrace */
+	li	r10, 0
+	stw	r10, 8(r1)
 	/*
 	 * Once we put values in SRR0 and SRR1, we are in a state
 	 * where exceptions are not recoverable, since taking an
@@ -997,6 +1003,9 @@ exc_exit_restart_end:
 	mtlr	r11
 	lwz	r10,_CCR(r1)
 	mtcrf	0xff,r10
+	/* Clear the exception_marker on the stack to avoid confusing stacktrace */
+	li	r10, 0
+	stw	r10, 8(r1)
 	REST_2GPRS(9, r1)
 	.globl exc_exit_restart
 exc_exit_restart:
-- 
2.13.3

