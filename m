Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB2AC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B78022399
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B78022399
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbeHIW7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:59:09 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:12122 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726890AbeHIW7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:59:09 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Aug 2018 18:59:08 EDT
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 9 Aug 2018 13:17:21 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 95288406DA;
        Thu,  9 Aug 2018 13:17:37 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v7 04/10] x86: refcount: prevent gcc distortions
Date:   Thu, 9 Aug 2018 13:15:47 -0700
Message-ID: <20180809201554.168804-5-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180809201554.168804-1-namit@vmware.com>
References: <20180809201554.168804-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC considers the number of statements in inlined assembly blocks,
according to new-lines and semicolons, as an indication to the cost of
the block in time and space. This data is distorted by the kernel code,
which puts information in alternative sections. As a result, the
compiler may perform incorrect inlining and branch optimizations.

The solution is to set an assembly macro and call it from the inlined
assembly block. As a result GCC considers the inline assembly block as
a single instruction.

This patch allows to inline functions such as __get_seccomp_filter().
Interestingly, this allows more aggressive inlining while reducing the
kernel size.

   text	   data	    bss	    dec	    hex	filename
18140970 10225412 2957312 31323694 1ddf62e ./vmlinux before
18140140 10225284 2957312 31322736 1ddf270 ./vmlinux after (-958)

Static text symbols:
Before:	40302
After:	40286	(-16)

Functions such as kref_get(), free_user(), fuse_file_get() now get
inlined.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Kees Cook <keescook@chromium.org>
Cc: Jan Beulich <JBeulich@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/refcount.h | 74 ++++++++++++++++++++-------------
 arch/x86/kernel/macros.S        |  1 +
 2 files changed, 46 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
index 4cf11d88d3b3..6b2809a4d8e9 100644
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
 
 /*
@@ -14,34 +49,11 @@
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
@@ -50,7 +62,7 @@ static __always_inline void refcount_add(unsigned int i, refcount_t *r)
 static __always_inline void refcount_inc(refcount_t *r)
 {
 	asm volatile(LOCK_PREFIX "incl %0\n\t"
-		REFCOUNT_CHECK_LT_ZERO
+		"REFCOUNT_CHECK_LT_ZERO counter=\"%[counter]\""
 		: [counter] "+m" (r->refs.counter)
 		: : "cc", "cx");
 }
@@ -58,7 +70,7 @@ static __always_inline void refcount_inc(refcount_t *r)
 static __always_inline void refcount_dec(refcount_t *r)
 {
 	asm volatile(LOCK_PREFIX "decl %0\n\t"
-		REFCOUNT_CHECK_LE_ZERO
+		"REFCOUNT_CHECK_LE_ZERO counter=\"%[counter]\""
 		: [counter] "+m" (r->refs.counter)
 		: : "cc", "cx");
 }
@@ -66,13 +78,15 @@ static __always_inline void refcount_dec(refcount_t *r)
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
 
@@ -90,7 +104,7 @@ bool refcount_add_not_zero(unsigned int i, refcount_t *r)
 
 		/* Did we try to increment from/to an undesirable state? */
 		if (unlikely(c < 0 || c == INT_MAX || result < c)) {
-			asm volatile(REFCOUNT_ERROR
+			asm volatile("REFCOUNT_ERROR counter=\"%[counter]\""
 				     : : [counter] "m" (r->refs.counter)
 				     : "cc", "cx");
 			break;
@@ -106,4 +120,6 @@ static __always_inline __must_check bool refcount_inc_not_zero(refcount_t *r)
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
-- 
2.17.1

