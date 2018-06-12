Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D909EC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD5A20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD5A20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933463AbeFLJPP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:15:15 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:31999 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932711AbeFLJOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:14:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 414kjk6WPYz9ttkr;
        Tue, 12 Jun 2018 11:14:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id L6sGCG025pll; Tue, 12 Jun 2018 11:14:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 414kjk5wcGz9ttBy;
        Tue, 12 Jun 2018 11:14:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0F0348B925;
        Tue, 12 Jun 2018 11:14:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5KzpGsFbYJVi; Tue, 12 Jun 2018 11:14:53 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DAFDF8B924;
        Tue, 12 Jun 2018 11:14:53 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D05336F83E; Tue, 12 Jun 2018 09:14:53 +0000 (UTC)
Message-Id: <8b89f2e21f7e3a865105eeeeda509243db393454.1528791416.git.christophe.leroy@c-s.fr>
In-Reply-To: <85de16f5629ac9f4a815230cced361908758b53a.1528791416.git.christophe.leroy@c-s.fr>
References: <85de16f5629ac9f4a815230cced361908758b53a.1528791416.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 3/4] powerpc/lib: implement strlen() in assembly
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, wei.guo.simon@gmail.com,
        segher@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 12 Jun 2018 09:14:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic implementation of strlen() reads strings byte per byte.

This patch implements strlen() in assembly based on a read of entire
words, in the same spirit as what some other arches and glibc do.

On a 8xx the time spent in strlen is reduced by 3/4 for long strings.

strlen() selftest on an 8xx provides the following values:

Before the patch (ie with the generic strlen() in lib/string.c):

len 256 : time = 1.195055
len 016 : time = 0.083745
len 008 : time = 0.046828
len 004 : time = 0.028390

After the patch:

len 256 : time = 0.272185 ==> 78% improvment
len 016 : time = 0.040632 ==> 51% improvment
len 008 : time = 0.033060 ==> 29% improvment
len 004 : time = 0.029149 ==> 2% degradation

On a 832x:

Before the patch:

len 256 : time = 0.236125
len 016 : time = 0.018136
len 008 : time = 0.011000
len 004 : time = 0.007229

After the patch:

len 256 : time = 0.094950 ==> 60% improvment
len 016 : time = 0.013357 ==> 26% improvment
len 008 : time = 0.010586 ==> 4% improvment
len 004 : time = 0.008784

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
Not tested on PPC64.

Changes in v6:
 - Reworked for having branchless conclusion

Changes in v5:
 - Fixed for PPC64 LITTLE ENDIAN

Changes in v4:
 - Added alignment of the loop
 - doing the andc only if still not 0 as it happends only for bytes above 0x7f which is pretty rare in a string

Changes in v3:
 - Made it common to PPC32 and PPC64

Changes in v2:
 - Moved handling of unaligned strings outside of the main path as it is very unlikely.
 - Removed the verification of the fourth byte in case none of the three first ones are NUL.

 arch/powerpc/include/asm/asm-compat.h |  6 +++
 arch/powerpc/include/asm/string.h     |  1 +
 arch/powerpc/lib/string.S             | 81 +++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
index 7f2a7702596c..fe2b459c8486 100644
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -20,8 +20,11 @@
 
 /* operations for longs and pointers */
 #define PPC_LL		stringify_in_c(ld)
+#define PPC_LLU		stringify_in_c(ldu)
 #define PPC_STL		stringify_in_c(std)
 #define PPC_STLU	stringify_in_c(stdu)
+#define PPC_ROTLI	stringify_in_c(rotldi)
+#define PPC_SRLI	stringify_in_c(srdi)
 #define PPC_LCMPI	stringify_in_c(cmpdi)
 #define PPC_LCMPLI	stringify_in_c(cmpldi)
 #define PPC_LCMP	stringify_in_c(cmpd)
@@ -53,8 +56,11 @@
 
 /* operations for longs and pointers */
 #define PPC_LL		stringify_in_c(lwz)
+#define PPC_LLU		stringify_in_c(lwzu)
 #define PPC_STL		stringify_in_c(stw)
 #define PPC_STLU	stringify_in_c(stwu)
+#define PPC_ROTLI	stringify_in_c(rotlwi)
+#define PPC_SRLI	stringify_in_c(srwi)
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
index 4b41970e9ed8..1d0593cba9d4 100644
--- a/arch/powerpc/lib/string.S
+++ b/arch/powerpc/lib/string.S
@@ -67,3 +67,84 @@ _GLOBAL(memchr)
 2:	li	r3,0
 	blr
 EXPORT_SYMBOL(memchr)
+
+/*
+ * Algorigthm:
+ *
+ * 1) Given a word 'x', we can test to see if it contains any 0 bytes
+ *    by subtracting 0x01010101, and seeing if any of the high bits of each
+ *    byte changed from 0 to 1. This works because the least significant
+ *    0 byte must have had no incoming carry (otherwise it's not the least
+ *    significant), so it is 0x00 - 0x01 == 0xff. For all other
+ *    byte values, either they have the high bit set initially, or when
+ *    1 is subtracted you get a value in the range 0x00-0x7f, none of which
+ *    have their high bit set. The expression here is
+ *    (x - 0x01010101) & ~x & 0x80808080), which gives 0x00000000 when
+ *    there were no 0x00 bytes in the word.  You get 0x80 in bytes that
+ *    match, but possibly false 0x80 matches in the next more significant
+ *    byte to a true match due to carries.  For little-endian this is
+ *    of no consequence since the least significant match is the one
+ *    we're interested in, but big-endian needs method 2 to find which
+ *    byte matches.
+ * 2) Given a word 'x', we can test to see _which_ byte was zero by
+ *    calculating ~(((x & ~0x80808080) - 0x80808080 - 1) | x | ~0x80808080).
+ *    This produces 0x80 in each byte that was zero, and 0x00 in all
+ *    the other bytes. The '| ~0x80808080' clears the low 7 bits in each
+ *    byte, and the '| x' part ensures that bytes with the high bit set
+ *    produce 0x00. The addition will carry into the high bit of each byte
+ *    iff that byte had one of its low 7 bits set. We can then just see
+ *    which was the most significant bit set and divide by 8 to find how
+ *    many to add to the index.
+ *    This is from the book 'The PowerPC Compiler Writer's Guide',
+ *    by Steve Hoxey, Faraydon Karim, Bill Hay and Hank Warren.
+ */
+
+_GLOBAL(strlen)
+	andi.   r9, r3, (SZL - 1)
+	lis	r7, 0x0101
+	addi	r10, r3, -SZL
+	addic	r7, r7, 0x0101		/* r7 = 0x01010101 (lomagic) & clr CA */
+#ifdef CONFIG_PPC64
+	rldimi	r7, r7, 32, 0		/* r7 = 0x0101010101010101 (lomagic) */
+#endif
+	bne-	1f
+2:	PPC_ROTLI	r6, r7, 31 	/* r6 = 0x80808080(80808080) (himagic)*/
+	.balign IFETCH_ALIGN_BYTES
+3:	PPC_LLU	r9, SZL(r10)
+	/* ((x - lomagic) & ~x & himagic) == 0 means no byte in x is NUL */
+	subf	r8, r7, r9
+	and.	r8, r8, r6
+	beq+	3b
+	andc.	r8, r8, r9
+	beq+	3b
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	andc	r8, r9, r6
+	orc	r9, r9, r6
+	subfe	r8, r6, r8
+	nor	r8, r8, r9
+	PPC_CNTLZL	r8, r8
+	subf	r3, r3, r10
+	PPC_SRLI	r8, r8, 3
+	add	r3, r3, r8
+#else
+	addi	r9, r8, -1
+	addi	r10, r10, (SZL - 1)
+	andc	r8, r9, r8
+	PPC_CNTLZL	r8, r8
+	subf	r3, r3, r10
+	PPC_SRLI	r8, r8, 3
+	subf	r3, r8, r3
+#endif
+	blr
+
+1:	lbz	r9, SZL(r10)
+	addi	r10, r10, 1
+	cmpwi	cr1, r9, 0
+	andi.	r9, r10, (SZL - 1)
+	beq	cr1, 4f
+	bne	1b
+	b	2b
+4:	addi	r10, r10, (SZL - 1)
+	subf	r3, r3, r10
+	blr
+EXPORT_SYMBOL(strlen)
-- 
2.13.3

