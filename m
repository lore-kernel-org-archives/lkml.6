Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEE2C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3B621902
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="SDoC3Gfm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfAaRpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:45:00 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:65208 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbfAaRo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:44:56 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43r70j4T7wz9vBKq;
        Thu, 31 Jan 2019 18:44:53 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=SDoC3Gfm; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id eKvne8ryPTPS; Thu, 31 Jan 2019 18:44:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43r70j30tgz9vBKn;
        Thu, 31 Jan 2019 18:44:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1548956693; bh=ugoZ4ISKI/Wbc3x+9e2KTETw23VmyIlLo+gOrAR3JkI=;
        h=From:Subject:To:Cc:Date:From;
        b=SDoC3Gfm7FV7wDF3RLUH1e5K9f7/WNELtvyy0QaqUYZ1EZd8/f7JIVcQlrFc20q1U
         0wIB9oyitc7HdE6fwM6VHAq5DX/KVsQDmdilrmt9nF7oDQY3QO05SG50EHfOdFhzjm
         uU/qxhSqh/dnwr9Xq5UxgZy9CRnLQwzs8CECC1XY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 18D5D8B83A;
        Thu, 31 Jan 2019 18:44:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Qx5-lQXDOIpQ; Thu, 31 Jan 2019 18:44:55 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EAEEF8B835;
        Thu, 31 Jan 2019 18:44:54 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id BA05F72E25; Thu, 31 Jan 2019 17:44:54 +0000 (UTC)
Message-Id: <9f9dd859d571e324c7412ed9db9da8cfba678257.1548956511.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH] powerpc/6xx: Don't set back MSR_RI before reenabling MMU
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 31 Jan 2019 17:44:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By delaying the setting of MSR_RI, a 1% improvment is optained on
null_syscall selftest on an mpc8321.

Without this patch:

root@vgoippro:~# ./null_syscall
   1134.33 ns     378.11 cycles

With this patch:

root@vgoippro:~# ./null_syscall
   1121.85 ns     373.95 cycles

The drawback is that a machine check during that period
would be unrecoverable, but as only main memory is accessed
during that period, it shouldn't be a concern.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 146385b1c2da..ea28a6ab56ec 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -282,8 +282,6 @@ __secondary_hold_acknowledge:
 	stw	r1,GPR1(r11);	\
 	stw	r1,0(r11);	\
 	tovirt(r1,r11);			/* set new kernel sp */	\
-	li	r10,MSR_KERNEL & ~(MSR_IR|MSR_DR); /* can take exceptions */ \
-	MTMSRD(r10);			/* (except for mach check in rtas) */ \
 	stw	r0,GPR0(r11);	\
 	lis	r10,STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */ \
 	addi	r10,r10,STACK_FRAME_REGS_MARKER@l; \
-- 
2.13.3

