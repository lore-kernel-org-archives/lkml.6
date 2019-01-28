Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2973CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96A42171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="OJ3FUpvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfA1LLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:11:47 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:40113 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbfA1LLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:11:33 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43p6Q50LSKz9v1q7;
        Mon, 28 Jan 2019 12:11:25 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=OJ3FUpvC; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id lhJjYgCsHVxX; Mon, 28 Jan 2019 12:11:24 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43p6Q46RdMz9v1q3;
        Mon, 28 Jan 2019 12:11:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1548673884; bh=V5Zs6OxuW6c1FUUrQ3/4deI2JBpQTqXJNy62hF+5F7E=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=OJ3FUpvCqmUYYvdPk/x4VXeXz908/3Lhd0NmTz8UFRaBHcgWxJWBYxPYiHiWemOqf
         ZLubxmrREyA3fNApsqCJiYN3yQRLRznqOIeo7kqghwZyHk+O+vHlwUgfmQoopmgAx6
         JrhPC1bpJtCsJh/X0lqHvbr7yDuDdgdnMgSiYWmg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5FF0D8B79D;
        Mon, 28 Jan 2019 12:11:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id uEfJQUaUVeUc; Mon, 28 Jan 2019 12:11:31 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 469178B796;
        Mon, 28 Jan 2019 12:11:31 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 32D1572DE6; Mon, 28 Jan 2019 11:11:31 +0000 (UTC)
Message-Id: <1b0d65d644079e205901f198bfa9ac0fdbafb05b.1548673552.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548673552.git.christophe.leroy@c-s.fr>
References: <cover.1548673552.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 10/11] powerpc/40x: Add EXC_XFER_TEMPLATE_CRITICAL()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 28 Jan 2019 11:11:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds EXC_XFER_TEMPLATE_CRITICAL() for handling
transfer to critical exception handler. This will allow
to move the normal exception to using the standard
EXC_XFER_TEMPLATE() defined in head_32.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_40x.S | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 1203075c0c1a..d52e460ea85e 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -219,9 +219,7 @@ label:
 	START_EXCEPTION(n, label);				\
 	CRITICAL_EXCEPTION_PROLOG;				\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
-	EXC_XFER_TEMPLATE(hdlr, n+2, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
-			  NOCOPY, crit_transfer_to_handler,	\
-			  ret_from_crit_exc)
+	EXC_XFER_TEMPLATE_CRITICAL(hdlr, n+2)
 
 #define EXC_XFER_TEMPLATE(hdlr, trap, msr, copyee, tfer, ret)	\
 	li	r10,trap;					\
@@ -233,6 +231,14 @@ label:
 	.long	hdlr;						\
 	.long	ret
 
+#define EXC_XFER_TEMPLATE_CRITICAL(hdlr, trap)			\
+	li	r10,trap;					\
+	stw	r10,_TRAP(r11);					\
+	li	r10, MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE);	\
+	bl	crit_transfer_to_handler;		 	\
+	.long	hdlr;						\
+	.long	ret_from_crit_exc
+
 #define COPY_EE(d, s)		rlwimi d,s,0,16,16
 #define NOCOPY(d, s)
 
@@ -733,9 +739,7 @@ label:
 	/* continue normal handling for a critical exception... */
 2:	mfspr	r4,SPRN_DBSR
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_TEMPLATE(DebugException, 0x2002, \
-		(MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
-		NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
+	EXC_XFER_TEMPLATE_CRITICAL(DebugException, 0x2002)
 
 	/* Programmable Interval Timer (PIT) Exception. (from 0x1000) */
 Decrementer:
@@ -755,10 +759,7 @@ FITException:
 WDTException:
 	CRITICAL_EXCEPTION_PROLOG;
 	addi	r3,r1,STACK_FRAME_OVERHEAD;
-	EXC_XFER_TEMPLATE(WatchdogException, 0x1020+2,
-	                  (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)),
-			  NOCOPY, crit_transfer_to_handler,
-			  ret_from_crit_exc)
+	EXC_XFER_TEMPLATE_CRITICAL(WatchdogException, 0x1020+2)
 
 /*
  * The other Data TLB exceptions bail out to this point
-- 
2.13.3

