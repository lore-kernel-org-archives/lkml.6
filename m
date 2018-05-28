Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423127AbeE1MLA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:11:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:25802 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1165028AbeE1MKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 08:10:47 -0400
Message-Id: <d5a7a0c8a6d9deecdeaaea007cbf7042e4b25af6.1527504742.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/32: implement strlen() in assembly
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 28 May 2018 12:10:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic implementation of strlen() reads strings byte per byte.

This patch implements strlen() in assembly for PPC32 based on
a read of entire words, in the same spirit as what some other
arches and glibc do.

For long strings, the time spent in strlen is reduced by 50-60%

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
Applies on top of serie "[v5 0/3] powerpc/lib: Optimisation of memcmp() and __clear_user() for PPC32"

Changes in v2:
 - Moved handling of unaligned strings outside of the main path as it is very unlikely.
 - Removed the verification of the fourth byte in case none of the three first ones are NUL.

 arch/powerpc/include/asm/string.h |  3 +++
 arch/powerpc/lib/string_32.S      | 41 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
index 9b8cedf618f4..5ecfdb776f87 100644
--- a/arch/powerpc/include/asm/string.h
+++ b/arch/powerpc/include/asm/string.h
@@ -13,6 +13,9 @@
 #define __HAVE_ARCH_MEMCHR
 #define __HAVE_ARCH_MEMSET16
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE
+#ifdef CONFIG_PPC32
+#define __HAVE_ARCH_STRLEN
+#endif
 
 extern char * strcpy(char *,const char *);
 extern char * strncpy(char *,const char *, __kernel_size_t);
diff --git a/arch/powerpc/lib/string_32.S b/arch/powerpc/lib/string_32.S
index 4fbaa046aa84..69593c917b35 100644
--- a/arch/powerpc/lib/string_32.S
+++ b/arch/powerpc/lib/string_32.S
@@ -47,6 +47,47 @@ _GLOBAL(memcmp)
 	blr
 EXPORT_SYMBOL(memcmp)
 
+_GLOBAL(strlen)
+	andi.   r9, r3, 3
+	addi	r10, r3, -4
+	bne-	1f
+2:	lis	r6, 0x8080
+	ori	r6, r6, 0x8080		/* r6 = 0x80808080 (himagic) */
+	rlwinm	r7, r6, 1, 0xffffffff	/* r7 = 0x01010101 (lomagic) */
+3:	lwzu	r9, 4(r10)
+	/* ((x - lomagic) & ~x & himagic) == 0 means no byte in x is NUL */
+	subf	r8, r7, r9
+	andc	r11, r6, r9
+	and.	r8, r8, r11
+	beq+	3b
+	rlwinm.	r8, r9, 0, 0xff000000
+	beq	20f
+	rlwinm.	r8, r9, 0, 0x00ff0000
+	beq	21f
+	rlwinm.	r8, r9, 0, 0x0000ff00
+	beq	22f
+	subf	r3, r3, r10
+	addi	r3, r3, 3
+	blr
+22:	subf	r3, r3, r10
+	addi	r3, r3, 2
+	blr
+21:	subf	r3, r3, r10
+	addi	r3, r3, 1
+	blr
+19:	addi	r10, r10, 3
+20:	subf	r3, r3, r10
+	blr
+
+1:	lbz	r9, 4(r10)
+	addi	r10, r10, 1
+	cmpwi	cr1, r9, 0
+	andi.	r9, r10, 3
+	beq	cr1, 19b
+	bne	1b
+	b	2b
+EXPORT_SYMBOL(strlen)
+
 CACHELINE_BYTES = L1_CACHE_BYTES
 LG_CACHELINE_BYTES = L1_CACHE_SHIFT
 CACHELINE_MASK = (L1_CACHE_BYTES-1)
-- 
2.13.3
