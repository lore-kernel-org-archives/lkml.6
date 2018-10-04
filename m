Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869C0C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C3520652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C3520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeJDQzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:55:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50245 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeJDQzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:55:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w94A2X4K2701490
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Oct 2018 03:02:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w94A2XwE2701483;
        Thu, 4 Oct 2018 03:02:33 -0700
Date:   Thu, 4 Oct 2018 03:02:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-9e1725b410594911cc5981b6c7b4cea4ec054ca8@git.kernel.org>
Cc:     namit@vmware.com, tglx@linutronix.de, brgerst@gmail.com,
        hpa@zytor.com, torvalds@linux-foundation.org, jpoimboe@redhat.com,
        dvlasenk@redhat.com, JBeulich@suse.com, bp@alien8.de,
        peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        keescook@chromium.org
Reply-To: jpoimboe@redhat.com, dvlasenk@redhat.com,
          torvalds@linux-foundation.org, JBeulich@suse.com,
          brgerst@gmail.com, hpa@zytor.com, namit@vmware.com,
          tglx@linutronix.de, mingo@kernel.org, luto@amacapital.net,
          keescook@chromium.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, bp@alien8.de
In-Reply-To: <20181003213100.189959-5-namit@vmware.com>
References: <20181003213100.189959-5-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/refcount: Work around GCC inlining bug
Git-Commit-ID: 9e1725b410594911cc5981b6c7b4cea4ec054ca8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9e1725b410594911cc5981b6c7b4cea4ec054ca8
Gitweb:     https://git.kernel.org/tip/9e1725b410594911cc5981b6c7b4cea4ec054ca8
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Wed, 3 Oct 2018 14:30:54 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 4 Oct 2018 11:24:59 +0200

x86/refcount: Work around GCC inlining bug

As described in:

  77b0bf55bc67: ("kbuild/Makefile: Prepare for using macros in inline assembly code to work around asm() related GCC inlining bugs")

GCC's inlining heuristics are broken with common asm() patterns used in
kernel code, resulting in the effective disabling of inlining.

The workaround is to set an assembly macro and call it from the inline
assembly block. As a result GCC considers the inline assembly block as
a single instruction. (Which it isn't, but that's the best we can get.)

This patch allows GCC to inline simple functions such as __get_seccomp_filter().

To no-one's surprise the result is that GCC performs more aggressive (read: correct)
inlining decisions in these senarios, which reduces the kernel size and presumably
also speeds it up:

      text     data     bss      dec     hex  filename
  18140970 10225412 2957312 31323694 1ddf62e  ./vmlinux before
  18140140 10225284 2957312 31322736 1ddf270  ./vmlinux after (-958)

16 fewer static text symbols:

   Before: 40302
    After: 40286 (-16)

these got inlined instead.

Functions such as kref_get(), free_user(), fuse_file_get() now get inlined. Hurray!

[ mingo: Rewrote the changelog. ]

Tested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jan Beulich <JBeulich@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181003213100.189959-5-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/refcount.h | 74 +++++++++++++++++++++++++----------------
 arch/x86/kernel/macros.S        |  1 +
 2 files changed, 46 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
index 19b90521954c..c92909da0686 100644
--- a/arch/x86/include/asm/refcount.h
+++ b/arch/x86/include/asm/refcount.h
@@ -4,6 +4,41 @@
  * x86-specific implementation of refcount_t. Based on PAX_REFCOUNT from
  * PaX/grsecurity.
  */
+
+#ifdef __ASSEMBLY__
+
+#include <asm/asm.h>
+#include <asm/bug.h>
+
+.macro REFCOUNT_EXCEPTION counter:req
+	.pushsection .text..refcount
+111:	lea \counter, %_ASM_CX
+112:	ud2
+	ASM_UNREACHABLE
+	.popsection
+113:	_ASM_EXTABLE_REFCOUNT(112b, 113b)
+.endm
+
+/* Trigger refcount exception if refcount result is negative. */
+.macro REFCOUNT_CHECK_LT_ZERO counter:req
+	js 111f
+	REFCOUNT_EXCEPTION counter="\counter"
+.endm
+
+/* Trigger refcount exception if refcount result is zero or negative. */
+.macro REFCOUNT_CHECK_LE_ZERO counter:req
+	jz 111f
+	REFCOUNT_CHECK_LT_ZERO counter="\counter"
+.endm
+
+/* Trigger refcount exception unconditionally. */
+.macro REFCOUNT_ERROR counter:req
+	jmp 111f
+	REFCOUNT_EXCEPTION counter="\counter"
+.endm
+
+#else /* __ASSEMBLY__ */
+
 #include <linux/refcount.h>
 #include <asm/bug.h>
 
@@ -15,34 +50,11 @@
  * central refcount exception. The fixup address for the exception points
  * back to the regular execution flow in .text.
  */
-#define _REFCOUNT_EXCEPTION				\
-	".pushsection .text..refcount\n"		\
-	"111:\tlea %[counter], %%" _ASM_CX "\n"		\
-	"112:\t" ASM_UD2 "\n"				\
-	ASM_UNREACHABLE					\
-	".popsection\n"					\
-	"113:\n"					\
-	_ASM_EXTABLE_REFCOUNT(112b, 113b)
-
-/* Trigger refcount exception if refcount result is negative. */
-#define REFCOUNT_CHECK_LT_ZERO				\
-	"js 111f\n\t"					\
-	_REFCOUNT_EXCEPTION
-
-/* Trigger refcount exception if refcount result is zero or negative. */
-#define REFCOUNT_CHECK_LE_ZERO				\
-	"jz 111f\n\t"					\
-	REFCOUNT_CHECK_LT_ZERO
-
-/* Trigger refcount exception unconditionally. */
-#define REFCOUNT_ERROR					\
-	"jmp 111f\n\t"					\
-	_REFCOUNT_EXCEPTION
 
 static __always_inline void refcount_add(unsigned int i, refcount_t *r)
 {
 	asm volatile(LOCK_PREFIX "addl %1,%0\n\t"
-		REFCOUNT_CHECK_LT_ZERO
+		"REFCOUNT_CHECK_LT_ZERO counter=\"%[counter]\""
 		: [counter] "+m" (r->refs.counter)
 		: "ir" (i)
 		: "cc", "cx");
@@ -51,7 +63,7 @@ static __always_inline void refcount_add(unsigned int i, refcount_t *r)
 static __always_inline void refcount_inc(refcount_t *r)
 {
 	asm volatile(LOCK_PREFIX "incl %0\n\t"
-		REFCOUNT_CHECK_LT_ZERO
+		"REFCOUNT_CHECK_LT_ZERO counter=\"%[counter]\""
 		: [counter] "+m" (r->refs.counter)
 		: : "cc", "cx");
 }
@@ -59,7 +71,7 @@ static __always_inline void refcount_inc(refcount_t *r)
 static __always_inline void refcount_dec(refcount_t *r)
 {
 	asm volatile(LOCK_PREFIX "decl %0\n\t"
-		REFCOUNT_CHECK_LE_ZERO
+		"REFCOUNT_CHECK_LE_ZERO counter=\"%[counter]\""
 		: [counter] "+m" (r->refs.counter)
 		: : "cc", "cx");
 }
@@ -67,13 +79,15 @@ static __always_inline void refcount_dec(refcount_t *r)
 static __always_inline __must_check
 bool refcount_sub_and_test(unsigned int i, refcount_t *r)
 {
-	GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl", REFCOUNT_CHECK_LT_ZERO,
+	GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
+				  "REFCOUNT_CHECK_LT_ZERO counter=\"%0\"",
 				  r->refs.counter, "er", i, "%0", e, "cx");
 }
 
 static __always_inline __must_check bool refcount_dec_and_test(refcount_t *r)
 {
-	GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl", REFCOUNT_CHECK_LT_ZERO,
+	GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
+				 "REFCOUNT_CHECK_LT_ZERO counter=\"%0\"",
 				 r->refs.counter, "%0", e, "cx");
 }
 
@@ -91,7 +105,7 @@ bool refcount_add_not_zero(unsigned int i, refcount_t *r)
 
 		/* Did we try to increment from/to an undesirable state? */
 		if (unlikely(c < 0 || c == INT_MAX || result < c)) {
-			asm volatile(REFCOUNT_ERROR
+			asm volatile("REFCOUNT_ERROR counter=\"%[counter]\""
 				     : : [counter] "m" (r->refs.counter)
 				     : "cc", "cx");
 			break;
@@ -107,4 +121,6 @@ static __always_inline __must_check bool refcount_inc_not_zero(refcount_t *r)
 	return refcount_add_not_zero(1, r);
 }
 
+#endif /* __ASSEMBLY__ */
+
 #endif
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index cee28c3246dc..f1fe1d570365 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -7,3 +7,4 @@
  */
 
 #include <linux/compiler.h>
+#include <asm/refcount.h>
