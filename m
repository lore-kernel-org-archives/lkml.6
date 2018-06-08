Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UNbJBGZYGls1VQAAmS7hNA
	; Fri, 08 Jun 2018 10:21:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 418EC607A4; Fri,  8 Jun 2018 10:21:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8F90D60590;
	Fri,  8 Jun 2018 10:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F90D60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeFHKVI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 06:21:08 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:49295 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752357AbeFHKUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:20:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 412JMY1r1Rz9ttqc;
        Fri,  8 Jun 2018 12:20:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id aqKxpFSYwY61; Fri,  8 Jun 2018 12:20:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 412JMY19scz9ttmq;
        Fri,  8 Jun 2018 12:20:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5C6EA8BB57;
        Fri,  8 Jun 2018 12:20:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lMdmLeFmOtk2; Fri,  8 Jun 2018 12:20:42 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0D1B98BB51;
        Fri,  8 Jun 2018 12:20:42 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 008B06F846; Fri,  8 Jun 2018 10:20:41 +0000 (UTC)
Message-Id: <8d65b5876f55efbd2243f6b43c758e452bee3b54.1528452373.git.christophe.leroy@c-s.fr>
In-Reply-To: <a348f4ffda6349467e4270e754d12150fa773462.1528452373.git.christophe.leroy@c-s.fr>
References: <a348f4ffda6349467e4270e754d12150fa773462.1528452373.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 3/4] powerpc/lib: implement strlen() in assembly
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, wei.guo.simon@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  8 Jun 2018 10:20:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic implementation of strlen() reads strings byte per byte.

This patch implements strlen() in assembly based on a read of entire
words, in the same spirit as what some other arches and glibc do.

On a 8xx the time spent in strlen is reduced by 2/3 for long strings.

strlen() selftest on an 8xx provides the following values:

Before the patch (ie with the generic strlen() in lib/string.c):

len 256 : time = 0.803648
len 16  : time = 0.062989
len 4   : time = 0.026269

After the patch:

len 256 : time = 0.267791  ==>  66% improvment
len 16  : time = 0.037902  ==>  41% improvment
len 4   : time = 0.026124  ==>  no degradation

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
Not tested on PPC64.

Changes in v4:
 - Added alignment of the loop
 - doing the andc only if still not 0 as it happends only for bytes above 0x7f which is pretty rare in a string

Changes in v3:
 - Made it common to PPC32 and PPC64

Changes in v2:
 - Moved handling of unaligned strings outside of the main path as it is very unlikely.
 - Removed the verification of the fourth byte in case none of the three first ones are NUL.


 arch/powerpc/include/asm/asm-compat.h |  4 +++
 arch/powerpc/include/asm/string.h     |  1 +
 arch/powerpc/lib/string.S             | 57 +++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
index 7f2a7702596c..0e99fe7570c0 100644
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -20,8 +20,10 @@
 
 /* operations for longs and pointers */
 #define PPC_LL		stringify_in_c(ld)
+#define PPC_LLU		stringify_in_c(ldu)
 #define PPC_STL		stringify_in_c(std)
 #define PPC_STLU	stringify_in_c(stdu)
+#define PPC_ROTLI	stringify_in_c(rotldi)
 #define PPC_LCMPI	stringify_in_c(cmpdi)
 #define PPC_LCMPLI	stringify_in_c(cmpldi)
 #define PPC_LCMP	stringify_in_c(cmpd)
@@ -53,8 +55,10 @@
 
 /* operations for longs and pointers */
 #define PPC_LL		stringify_in_c(lwz)
+#define PPC_LLU		stringify_in_c(lwzu)
 #define PPC_STL		stringify_in_c(stw)
 #define PPC_STLU	stringify_in_c(stwu)
+#define PPC_ROTLI	stringify_in_c(rotlwi)
 #define PPC_LCMPI	stringify_in_c(cmpwi)
 #define PPC_LCMPLI	stringify_in_c(cmplwi)
 #define PPC_LCMP	stringify_in_c(cmpw)
diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
index 9b8cedf618f4..8fdcb532de72 100644
--- a/arch/powerpc/include/asm/string.h
+++ b/arch/powerpc/include/asm/string.h
@@ -13,6 +13,7 @@
 #define __HAVE_ARCH_MEMCHR
 #define __HAVE_ARCH_MEMSET16
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE
+#define __HAVE_ARCH_STRLEN
 
 extern char * strcpy(char *,const char *);
 extern char * strncpy(char *,const char *, __kernel_size_t);
diff --git a/arch/powerpc/lib/string.S b/arch/powerpc/lib/string.S
index 4b41970e9ed8..238f61e2024f 100644
--- a/arch/powerpc/lib/string.S
+++ b/arch/powerpc/lib/string.S
@@ -67,3 +67,60 @@ _GLOBAL(memchr)
 2:	li	r3,0
 	blr
 EXPORT_SYMBOL(memchr)
+
+_GLOBAL(strlen)
+	andi.   r9, r3, (SZL - 1)
+	addi	r10, r3, -SZL
+	bne-	1f
+2:	lis	r6, 0x8080
+	ori	r6, r6, 0x8080		/* r6 = 0x80808080 (himagic) */
+#ifdef CONFIG_PPC64
+	rldimi	r6, r6, 32, 0		/* r6 = 0x8080808080808080 (himagic) */
+#endif
+	PPC_ROTLI  r7, r6, 1 		/* r7 = 0x01010101(01010101) (lomagic)*/
+	.balign IFETCH_ALIGN_BYTES
+3:	PPC_LLU	r9, SZL(r10)
+	/* ((x - lomagic) & ~x & himagic) == 0 means no byte in x is NUL */
+	subf	r8, r7, r9
+	and.	r8, r8, r6
+	beq+	3b
+	andc.	r8, r8, r9
+	beq+	3b
+#ifdef CONFIG_PPC64
+	rldicl.	r8, r9, 8, 56
+	beq	20f
+	rldicl.	r8, r9, 16, 56
+	beq	21f
+	rldicl.	r8, r9, 24, 56
+	beq	22f
+	rldicl.	r8, r9, 32, 56
+	beq	23f
+	addi	r10, r10, 4
+#endif
+	rlwinm.	r8, r9, 0, 0xff000000
+	beq	20f
+	rlwinm.	r8, r9, 0, 0x00ff0000
+	beq	21f
+	rlwinm.	r8, r9, 0, 0x0000ff00
+	beq	22f
+23:	subf	r3, r3, r10
+	addi	r3, r3, 3
+	blr
+22:	subf	r3, r3, r10
+	addi	r3, r3, 2
+	blr
+21:	subf	r3, r3, r10
+	addi	r3, r3, 1
+	blr
+19:	addi	r10, r10, (SZL - 1)
+20:	subf	r3, r3, r10
+	blr
+
+1:	lbz	r9, SZL(r10)
+	addi	r10, r10, 1
+	cmpwi	cr1, r9, 0
+	andi.	r9, r10, (SZL - 1)
+	beq	cr1, 19b
+	bne	1b
+	b	2b
+EXPORT_SYMBOL(strlen)
-- 
2.13.3
