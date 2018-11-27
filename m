Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC23DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9540320659
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9540320659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731863AbeK1Eg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:36:56 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:46640 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbeK1Eg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:36:56 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4349x42kKlz9v0C0;
        Tue, 27 Nov 2018 18:38:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id cXrQIJ-qd4lY; Tue, 27 Nov 2018 18:38:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4349x423g9z9v0BP;
        Tue, 27 Nov 2018 18:38:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BA3208B83D;
        Tue, 27 Nov 2018 18:38:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UgaH0SuN8gZx; Tue, 27 Nov 2018 18:38:17 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7FFB08B827;
        Tue, 27 Nov 2018 18:38:17 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B520269AE1; Tue, 27 Nov 2018 17:38:16 +0000 (UTC)
Message-Id: <674bef4f0b56492b4c30644ccaaf318869c84992.1543340240.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: add exception frame marker
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 27 Nov 2018 17:38:16 +0000 (UTC)
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
 arch/powerpc/kernel/head_8xx.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 3b67b9533c82..5e72df2031cb 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -149,6 +149,9 @@ turn_on_mmu:
 	li	r10,MSR_KERNEL & ~(MSR_IR|MSR_DR); /* can take exceptions */ \
 	mtmsr	r10;		\
 	stw	r0,GPR0(r11);	\
+	lis	r10, STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */ \
+	addi	r10, r10, STACK_FRAME_REGS_MARKER@l; \
+	stw	r10, 8(r11);	\
 	SAVE_4GPRS(3, r11);	\
 	SAVE_2GPRS(7, r11)
 
-- 
2.13.3

