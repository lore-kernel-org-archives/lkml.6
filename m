Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeDQHjL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 03:39:11 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:7728 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752177AbeDQHir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 03:38:47 -0400
Message-Id: <79db4096efe199b5b0e489de6805405a4f20b918.1523950415.git.christophe.leroy@c-s.fr>
In-Reply-To: <a04660fd2b51246f8feeb49e49334fc943c1b9e8.1523950415.git.christophe.leroy@c-s.fr>
References: <a04660fd2b51246f8feeb49e49334fc943c1b9e8.1523950415.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH  6/7] powerpc/lib: inline more NUL size verifications
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 17 Apr 2018 09:38:45 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(), strncpy(), memchr() are often called with constant
size.

This patch gives GCC a chance to optimise NULL size verification out

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/string.h | 24 ++++++++++++++++++++++++
 arch/powerpc/lib/string.S         |  8 ++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
index 196ac5d587fb..1465d5629ef2 100644
--- a/arch/powerpc/include/asm/string.h
+++ b/arch/powerpc/include/asm/string.h
@@ -30,6 +30,22 @@ extern void * memchr(const void *,int,__kernel_size_t);
 extern void * memcpy_flushcache(void *,const void *,__kernel_size_t);
 
 #ifndef CONFIG_FORTIFY_SOURCE
+static inline char *__strncpy(char *p, const char *q, __kernel_size_t size)
+{
+	if (unlikely(!size))
+		return p;
+	return strncpy(p, q, size);
+}
+#define strncpy __strncpy
+
+static inline int __strncmp(const char *p, const char *q, __kernel_size_t size)
+{
+	if (unlikely(!size))
+		return 0;
+	return strncmp(p, q, size);
+}
+#define strncmp __strncmp
+
 static inline int ___memcmp(const void *p,const void *q,__kernel_size_t size, int offset)
 {
 	int dif;
@@ -72,6 +88,14 @@ static inline int __memcmp(const void *p,const void *q,__kernel_size_t size)
 	return memcmp(p, q, size);
 }
 #define memcmp __memcmp
+
+static inline void *__memchr(const void *p, int c, __kernel_size_t size)
+{
+	if (unlikely(!size))
+		return NULL;
+	return memchr(p, c, size);
+}
+#define memchr __memchr
 #endif
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/lib/string.S b/arch/powerpc/lib/string.S
index cbb90fdc672d..89af53b08b4a 100644
--- a/arch/powerpc/lib/string.S
+++ b/arch/powerpc/lib/string.S
@@ -18,8 +18,10 @@
 /* This clears out any unused part of the destination buffer,
    just as the libc version does.  -- paulus */
 _GLOBAL(strncpy)
+#ifdef CONFIG_FORTIFY_SOURCE
 	PPC_LCMPI 0,r5,0
 	beqlr
+#endif
 	mtctr	r5
 	addi	r6,r3,-1
 	addi	r4,r4,-1
@@ -38,8 +40,10 @@ _GLOBAL(strncpy)
 EXPORT_SYMBOL(strncpy)
 
 _GLOBAL(strncmp)
+#ifdef CONFIG_FORTIFY_SOURCE
 	PPC_LCMPI 0,r5,0
 	beq-	2f
+#endif
 	mtctr	r5
 	addi	r5,r3,-1
 	addi	r4,r4,-1
@@ -51,13 +55,17 @@ _GLOBAL(strncmp)
 	beqlr	1
 	bdnzt	eq,1b
 	blr
+#ifdef CONFIG_FORTIFY_SOURCE
 2:	li	r3,0
 	blr
+#endif
 EXPORT_SYMBOL(strncmp)
 
 _GLOBAL(memchr)
+#ifdef CONFIG_FORTIFY_SOURCE
 	PPC_LCMPI 0,r5,0
 	beq-	2f
+#endif
 	mtctr	r5
 	addi	r3,r3,-1
 	.balign 16
-- 
2.13.3
