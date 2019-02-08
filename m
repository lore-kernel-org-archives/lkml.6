Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32B0C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCE920857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="eWeKl4UQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfBHMxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:53:42 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:63368 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbfBHMwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:52:24 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43ww7V1qJSz9v0dN;
        Fri,  8 Feb 2019 13:52:22 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=eWeKl4UQ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zCn_h22xBjln; Fri,  8 Feb 2019 13:52:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43ww7V0pS0z9v0dJ;
        Fri,  8 Feb 2019 13:52:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1549630342; bh=v39Yv2nCAjGALaP9WAqaQxXxMbLYvvHMp4UEgCBdEzI=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=eWeKl4UQrEvU76ujptCMLEiIBPhdhGi0ThFgUKgVkPI8I/qwcSkutkCVmG38i1nAl
         yt1a1wR0wUJrp8oP+33/9KdHmv3aYyLP/uHglq/K2C6xANN1NjrFTNByvMZI1yvZkJ
         bnjiYpR3JXEjDqobF7Hyuuw8DGhL39oOVKDAPbEA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 28CDD8B8D9;
        Fri,  8 Feb 2019 13:52:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id dLzLGRLd2gVy; Fri,  8 Feb 2019 13:52:23 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 092C58B756;
        Fri,  8 Feb 2019 13:52:23 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id F3B4D653E8; Fri,  8 Feb 2019 12:52:22 +0000 (UTC)
Message-Id: <1946d8ed86a92a9a6827ec260d0d9c99e0d88184.1549630193.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1549630193.git.christophe.leroy@c-s.fr>
References: <cover.1549630193.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 03/16] powerpc/32: move LOAD_MSR_KERNEL() into
 head_32.h and use it
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  8 Feb 2019 12:52:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As preparation for using head_32.h for head_40x.S, move
LOAD_MSR_KERNEL() there and use it to load r10 with MSR_KERNEL value.

In the mean time, this patch modifies it so that it takes into account
the size of the passed value to determine if 'li' can be used or if
'lis/ori' is needed instead of using the size of MSR_KERNEL. This is
done by using gas macro.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/entry_32.S |  9 +--------
 arch/powerpc/kernel/head_32.h  | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index a5e2d5585dcb..b489aebdc5c5 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -37,14 +37,7 @@
 #include <asm/feature-fixups.h>
 #include <asm/barrier.h>
 
-/*
- * MSR_KERNEL is > 0x10000 on 4xx/Book-E since it include MSR_CE.
- */
-#if MSR_KERNEL >= 0x10000
-#define LOAD_MSR_KERNEL(r, x)	lis r,(x)@h; ori r,r,(x)@l
-#else
-#define LOAD_MSR_KERNEL(r, x)	li r,(x)
-#endif
+#include "head_32.h"
 
 /*
  * Align to 4k in order to ensure that all functions modyfing srr0/srr1
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 7456e2a45acc..cf3d00844597 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -5,6 +5,19 @@
 #include <asm/ptrace.h>	/* for STACK_FRAME_REGS_MARKER */
 
 /*
+ * MSR_KERNEL is > 0x8000 on 4xx/Book-E since it include MSR_CE.
+ */
+.macro __LOAD_MSR_KERNEL r, x
+.if \x >= 0x8000
+	lis \r, (\x)@h
+	ori \r, \r, (\x)@l
+.else
+	li \r, (\x)
+.endif
+.endm
+#define LOAD_MSR_KERNEL(r, x) __LOAD_MSR_KERNEL r, x
+
+/*
  * Exception entry code.  This code runs with address translation
  * turned off, i.e. using physical addresses.
  * We assume sprg3 has the physical address of the current
@@ -89,7 +102,7 @@
 #define EXC_XFER_TEMPLATE(n, hdlr, trap, copyee, tfer, ret)	\
 	li	r10,trap;					\
 	stw	r10,_TRAP(r11);					\
-	li	r10,MSR_KERNEL;					\
+	LOAD_MSR_KERNEL(r10, MSR_KERNEL);			\
 	copyee(r10, r9);					\
 	bl	tfer;						\
 i##n:								\
-- 
2.13.3

