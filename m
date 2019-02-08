Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D79AC282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4115D2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="jftFbt5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfBHMwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:52:30 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:28041 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbfBHMw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:52:27 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43ww7X19WJz9v0dP;
        Fri,  8 Feb 2019 13:52:24 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=jftFbt5y; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3tYoLmEof-0G; Fri,  8 Feb 2019 13:52:24 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43ww7X08K8z9v0dJ;
        Fri,  8 Feb 2019 13:52:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1549630344; bh=3cTg49j7kaqjz/JFl/xsM6+jMcAItBSkH7yaOvqokj0=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=jftFbt5yrL5S93+bF6eZO0T/rXrz5GDEsJ/1vNSyD5S5HAmdoggodftOE6U9fXeUX
         auK82zcQHj911upLEW/XBuyzbECvs6op7Hgazr1MzemmH/1Z52ZO7VDWq3DZI6jPIt
         Xm/0Q60VSmQKXMgwY/untJjyNjqmvetsHcInl4jo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3E66D8B8D7;
        Fri,  8 Feb 2019 13:52:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4Dt48y_dwCUa; Fri,  8 Feb 2019 13:52:25 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 123E08B756;
        Fri,  8 Feb 2019 13:52:25 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 05822653E8; Fri,  8 Feb 2019 12:52:25 +0000 (UTC)
Message-Id: <6f7163e3c49baceb21ac756dc79828abaf93ecbe.1549630193.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1549630193.git.christophe.leroy@c-s.fr>
References: <cover.1549630193.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 04/16] powerpc/32: make the 6xx/8xx EXC_XFER_TEMPLATE()
 similar to the 40x/booke one
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  8 Feb 2019 12:52:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

6xx/8xx EXC_XFER_TEMPLATE() macro adds a i##n symbol which is
unused and can be removed.
40x and booke EXC_XFER_TEMPLATE() macros takes msr from the caller
while the 6xx/8xx version uses only MSR_KERNEL as msr value.

This patch modifies the 6xx/8xx version to make it similar to the
40x and booke versions.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index cf3d00844597..985758cbf577 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -99,13 +99,12 @@
 	addi	r3,r1,STACK_FRAME_OVERHEAD;	\
 	xfer(n, hdlr)
 
-#define EXC_XFER_TEMPLATE(n, hdlr, trap, copyee, tfer, ret)	\
+#define EXC_XFER_TEMPLATE(hdlr, trap, msr, copyee, tfer, ret)	\
 	li	r10,trap;					\
 	stw	r10,_TRAP(r11);					\
-	LOAD_MSR_KERNEL(r10, MSR_KERNEL);			\
+	LOAD_MSR_KERNEL(r10, msr);				\
 	copyee(r10, r9);					\
 	bl	tfer;						\
-i##n:								\
 	.long	hdlr;						\
 	.long	ret
 
@@ -113,19 +112,19 @@ i##n:								\
 #define NOCOPY(d, s)
 
 #define EXC_XFER_STD(n, hdlr)		\
-	EXC_XFER_TEMPLATE(n, hdlr, n, NOCOPY, transfer_to_handler_full,	\
+	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, NOCOPY, transfer_to_handler_full,	\
 			  ret_from_except_full)
 
 #define EXC_XFER_LITE(n, hdlr)		\
-	EXC_XFER_TEMPLATE(n, hdlr, n+1, NOCOPY, transfer_to_handler, \
+	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, NOCOPY, transfer_to_handler, \
 			  ret_from_except)
 
 #define EXC_XFER_EE(n, hdlr)		\
-	EXC_XFER_TEMPLATE(n, hdlr, n, COPY_EE, transfer_to_handler_full, \
+	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, COPY_EE, transfer_to_handler_full, \
 			  ret_from_except_full)
 
 #define EXC_XFER_EE_LITE(n, hdlr)	\
-	EXC_XFER_TEMPLATE(n, hdlr, n+1, COPY_EE, transfer_to_handler, \
+	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, COPY_EE, transfer_to_handler, \
 			  ret_from_except)
 
 #endif /* __HEAD_32_H__ */
-- 
2.13.3

