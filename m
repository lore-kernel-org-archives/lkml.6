Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D1CC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C3E24071
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C3E24071
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbeGEIx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 04:53:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:9536 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753207AbeGEIx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 04:53:58 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41Ls902Mzcz9ttSS;
        Thu,  5 Jul 2018 10:53:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id kkHodDIKIpkp; Thu,  5 Jul 2018 10:53:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41Ls901nL7z9ttS3;
        Thu,  5 Jul 2018 10:53:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 538B28B7C3;
        Thu,  5 Jul 2018 10:53:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id A1ISo0UFPnQ7; Thu,  5 Jul 2018 10:53:57 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 30E2A8B7BC;
        Thu,  5 Jul 2018 10:53:57 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2A3DD6FFC6; Thu,  5 Jul 2018 08:53:57 +0000 (UTC)
Message-Id: <a272622d3444a1787a0fc4bf61e9192fb0c3cd64.1530780629.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH 1/3] powerpc/lib: implement strlen() in assembly for PPC64
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, wei.guo.simon@gmail.com,
        segher@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  5 Jul 2018 08:53:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic implementation of strlen() reads strings byte per byte.

This patch implements strlen() in assembly based on a read of entire
words, in the same spirit as what some other arches and glibc do.

strlen() selftest on an XXXXXXXX provides the following values:

Before the patch (ie with the generic strlen() in lib/string.c):

After the patch:

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 This serie applies on top of the PPC32 strlen optimisation serie

 Untested

 arch/powerpc/include/asm/string.h |  3 +-
 arch/powerpc/lib/Makefile         |  4 +-
 arch/powerpc/lib/strlen_64.S      | 88 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/lib/strlen_64.S

diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
index 1647de15a31e..8fdcb532de72 100644
--- a/arch/powerpc/include/asm/string.h
+++ b/arch/powerpc/include/asm/string.h
@@ -13,6 +13,7 @@
 #define __HAVE_ARCH_MEMCHR
 #define __HAVE_ARCH_MEMSET16
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE
+#define __HAVE_ARCH_STRLEN
 
 extern char * strcpy(char *,const char *);
 extern char * strncpy(char *,const char *, __kernel_size_t);
@@ -50,8 +51,6 @@ static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
 	return __memset64(p, v, n * 8);
 }
 #else
-#define __HAVE_ARCH_STRLEN
-
 extern void *memset16(uint16_t *, uint16_t, __kernel_size_t);
 #endif
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 670286808928..93706b4cdbde 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -12,7 +12,7 @@ CFLAGS_REMOVE_feature-fixups.o = $(CC_FLAGS_FTRACE)
 
 obj-y += string.o alloc.o code-patching.o feature-fixups.o
 
-obj-$(CONFIG_PPC32)	+= div64.o copy_32.o crtsavres.o strlen_32.o
+obj-$(CONFIG_PPC32)	+= div64.o copy_32.o crtsavres.o
 
 # See corresponding test in arch/powerpc/Makefile
 # 64-bit linker creates .sfpr on demand for final link (vmlinux),
@@ -33,7 +33,7 @@ obj64-$(CONFIG_ALTIVEC)	+= vmx-helper.o
 obj64-$(CONFIG_KPROBES_SANITY_TEST) += test_emulate_step.o
 
 obj-y			+= checksum_$(BITS).o checksum_wrappers.o \
-			   string_$(BITS).o memcmp_$(BITS).o
+			   string_$(BITS).o memcmp_$(BITS).o strlen_$(BITS).o
 
 obj-y			+= sstep.o ldstfp.o quad.o
 obj64-y			+= quad.o
diff --git a/arch/powerpc/lib/strlen_64.S b/arch/powerpc/lib/strlen_64.S
new file mode 100644
index 000000000000..c9704f2b697d
--- /dev/null
+++ b/arch/powerpc/lib/strlen_64.S
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * strlen() for PPC64
+ *
+ * Copyright (C) 2018 Christophe Leroy CS Systemes d'Information.
+ *
+ * Inspired from glibc implementation
+ */
+#include <asm/ppc_asm.h>
+#include <asm/export.h>
+#include <asm/cache.h>
+
+	.text
+
+/*
+ * Algorithm:
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
+	andi.   r0, r3, 7
+	lis	r7, 0x0101
+	addi	r10, r3, -8
+	addic	r7, r7, 0x0101	/* r7 = 0x01010101 (lomagic) & clear XER[CA] */
+	rldimi	r7, r7, 32, 0	/* r7 = 0x0101010101010101 (lomagic) */
+	rotldi	r6, r7, 31 	/* r6 = 0x8080808080808080 (himagic) */
+	bne-	3f
+	.balign IFETCH_ALIGN_BYTES
+1:	ldu	r9, 8(r10)
+2:	subf	r8, r7, r9
+	andc	r11, r6, r9
+	and.	r8, r8, r11
+	beq+	1b
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	andc	r8, r9, r6
+	orc	r9, r9, r6
+	subfe	r8, r6, r8
+	nor	r8, r8, r9
+	cntlzd	r8, r8
+	subf	r3, r3, r10
+	srdi	r8, r8, 3
+	add	r3, r3, r8
+#else
+	addi	r9, r8, -1
+	addi	r10, r10, 7
+	andc	r8, r9, r8
+	cntlzd	r8, r8
+	subf	r3, r3, r10
+	srdi	r8, r8, 3
+	subf	r3, r8, r3
+#endif
+	blr
+
+	/* Missaligned string: make sure bytes before string are seen not 0 */
+3:	xor	r10, r10, r0
+	orc	r8, r8, r8
+	ldu	r9, 8(r10)
+	slwi	r0, r0, 3
+	srw	r8, r8, r0
+	orc	r9, r9, r8
+	b	2b
+EXPORT_SYMBOL(strlen)
-- 
2.13.3

