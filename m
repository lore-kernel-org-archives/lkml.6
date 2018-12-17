Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99322C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B542145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="DQIWUNZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388282AbeLQQLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:11:31 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:65527 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbeLQQL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:11:29 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id wBHG3bRk008119;
        Tue, 18 Dec 2018 01:03:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com wBHG3bRk008119
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545062630;
        bh=Ncxd2084CDNaDsykqqCM0ja6cXudxZXMCOcG57w78u4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DQIWUNZWUM0NwJM0cC8xuPxPsCtjgGQrOYu0DQxt4dwzfD9gqV2PumQQLjS5Hdv+s
         7SqvYKdfPxVwNVY5G5zZOU4DJu9pjCDqEAIrf0ZCujiw1Tj0KJIHd+SmmDciqGDFCU
         vTgNoLKduUZj06nE6KtwKilGdxKeZoA++dsBYDQ/FmxgPAtTRak4paxHyAR16ZBuJi
         bOLF0f4W8jBdVCngKy5RWgEYmvT1EGWqOhcBGw5hM3kC2kNFKl/YemVi86Kss+WLnz
         NajeEnKPi8COqXsk4a0GZe3CFgeRrHWnPtBlND5VrLwNU+sLQTt1UAw9zU1wMh69Mn
         XHnK8NelQmzOA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Richard Biener <rguenther@suse.de>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@suse.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 07/12] Revert "x86/refcount: Work around GCC inlining bug"
Date:   Tue, 18 Dec 2018 01:03:22 +0900
Message-Id: <1545062607-8599-8-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
References: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9e1725b410594911cc5981b6c7b4cea4ec054ca8.

The in-kernel workarounds will be replaced with GCC's new
"asm inline" syntax.

Resolved conflicts caused by 288e4521f0f6 ("x86/asm: 'Simplify'
GEN_*_RMWcc() macros").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/include/asm/refcount.h | 81 +++++++++++++++++------------------------
 arch/x86/kernel/macros.S        |  1 -
 2 files changed, 33 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
index a8b5e1e..dbaed55 100644
--- a/arch/x86/include/asm/refcount.h
+++ b/arch/x86/include/asm/refcount.h
@@ -4,41 +4,6 @@
  * x86-specific implementation of refcount_t. Based on PAX_REFCOUNT from
  * PaX/grsecurity.
  */
-
-#ifdef __ASSEMBLY__
-
-#include <asm/asm.h>
-#include <asm/bug.h>
-
-.macro REFCOUNT_EXCEPTION counter:req
-	.pushsection .text..refcount
-111:	lea \counter, %_ASM_CX
-112:	ud2
-	ASM_UNREACHABLE
-	.popsection
-113:	_ASM_EXTABLE_REFCOUNT(112b, 113b)
-.endm
-
-/* Trigger refcount exception if refcount result is negative. */
-.macro REFCOUNT_CHECK_LT_ZERO counter:req
-	js 111f
-	REFCOUNT_EXCEPTION counter="\counter"
-.endm
-
-/* Trigger refcount exception if refcount result is zero or negative. */
-.macro REFCOUNT_CHECK_LE_ZERO counter:req
-	jz 111f
-	REFCOUNT_CHECK_LT_ZERO counter="\counter"
-.endm
-
-/* Trigger refcount exception unconditionally. */
-.macro REFCOUNT_ERROR counter:req
-	jmp 111f
-	REFCOUNT_EXCEPTION counter="\counter"
-.endm
-
-#else /* __ASSEMBLY__ */
-
 #include <linux/refcount.h>
 #include <asm/bug.h>
 
@@ -50,12 +15,35 @@
  * central refcount exception. The fixup address for the exception points
  * back to the regular execution flow in .text.
  */
+#define _REFCOUNT_EXCEPTION				\
+	".pushsection .text..refcount\n"		\
+	"111:\tlea %[var], %%" _ASM_CX "\n"		\
+	"112:\t" ASM_UD2 "\n"				\
+	ASM_UNREACHABLE					\
+	".popsection\n"					\
+	"113:\n"					\
+	_ASM_EXTABLE_REFCOUNT(112b, 113b)
+
+/* Trigger refcount exception if refcount result is negative. */
+#define REFCOUNT_CHECK_LT_ZERO				\
+	"js 111f\n\t"					\
+	_REFCOUNT_EXCEPTION
+
+/* Trigger refcount exception if refcount result is zero or negative. */
+#define REFCOUNT_CHECK_LE_ZERO				\
+	"jz 111f\n\t"					\
+	REFCOUNT_CHECK_LT_ZERO
+
+/* Trigger refcount exception unconditionally. */
+#define REFCOUNT_ERROR					\
+	"jmp 111f\n\t"					\
+	_REFCOUNT_EXCEPTION
 
 static __always_inline void refcount_add(unsigned int i, refcount_t *r)
 {
 	asm volatile(LOCK_PREFIX "addl %1,%0\n\t"
-		"REFCOUNT_CHECK_LT_ZERO counter=\"%[counter]\""
-		: [counter] "+m" (r->refs.counter)
+		REFCOUNT_CHECK_LT_ZERO
+		: [var] "+m" (r->refs.counter)
 		: "ir" (i)
 		: "cc", "cx");
 }
@@ -63,32 +51,31 @@ static __always_inline void refcount_add(unsigned int i, refcount_t *r)
 static __always_inline void refcount_inc(refcount_t *r)
 {
 	asm volatile(LOCK_PREFIX "incl %0\n\t"
-		"REFCOUNT_CHECK_LT_ZERO counter=\"%[counter]\""
-		: [counter] "+m" (r->refs.counter)
+		REFCOUNT_CHECK_LT_ZERO
+		: [var] "+m" (r->refs.counter)
 		: : "cc", "cx");
 }
 
 static __always_inline void refcount_dec(refcount_t *r)
 {
 	asm volatile(LOCK_PREFIX "decl %0\n\t"
-		"REFCOUNT_CHECK_LE_ZERO counter=\"%[counter]\""
-		: [counter] "+m" (r->refs.counter)
+		REFCOUNT_CHECK_LE_ZERO
+		: [var] "+m" (r->refs.counter)
 		: : "cc", "cx");
 }
 
 static __always_inline __must_check
 bool refcount_sub_and_test(unsigned int i, refcount_t *r)
 {
-
 	return GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
-					 "REFCOUNT_CHECK_LT_ZERO counter=\"%[var]\"",
+					 REFCOUNT_CHECK_LT_ZERO,
 					 r->refs.counter, e, "er", i, "cx");
 }
 
 static __always_inline __must_check bool refcount_dec_and_test(refcount_t *r)
 {
 	return GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
-					"REFCOUNT_CHECK_LT_ZERO counter=\"%[var]\"",
+					REFCOUNT_CHECK_LT_ZERO,
 					r->refs.counter, e, "cx");
 }
 
@@ -106,8 +93,8 @@ bool refcount_add_not_zero(unsigned int i, refcount_t *r)
 
 		/* Did we try to increment from/to an undesirable state? */
 		if (unlikely(c < 0 || c == INT_MAX || result < c)) {
-			asm volatile("REFCOUNT_ERROR counter=\"%[counter]\""
-				     : : [counter] "m" (r->refs.counter)
+			asm volatile(REFCOUNT_ERROR
+				     : : [var] "m" (r->refs.counter)
 				     : "cc", "cx");
 			break;
 		}
@@ -122,6 +109,4 @@ static __always_inline __must_check bool refcount_inc_not_zero(refcount_t *r)
 	return refcount_add_not_zero(1, r);
 }
 
-#endif /* __ASSEMBLY__ */
-
 #endif
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index f1fe1d5..cee28c3 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -7,4 +7,3 @@
  */
 
 #include <linux/compiler.h>
-#include <asm/refcount.h>
-- 
2.7.4

