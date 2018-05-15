Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752991AbeEOV1U (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:27:20 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:48538 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752095AbeEOV0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:26:16 -0400
From: Nadav Amit <namit@vmware.com>
To: <linux-kernel@vger.kernel.org>
CC: <nadav.amit@gmail.com>, Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>, "Jan Beulich" <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC 5/8] x86: refcount: prevent gcc distortions
Date: Tue, 15 May 2018 07:11:21 -0700
Message-ID: <20180515141124.84254-15-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515141124.84254-1-namit@vmware.com>
References: <20180515141124.84254-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
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
The effect of the patch is as follows on the kernel size:

   text	   data	    bss	    dec	    hex	filename
18146418 10064100 2936832 31147350 1db4556 ./vmlinux before
18148228 10063968 2936832 31149028 1db4be4 ./vmlinux after (+1678)

Static text symbols:
Before:	39673
After:	39649	(-24)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Kees Cook <keescook@chromium.org>
Cc: Jan Beulich <JBeulich@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/refcount.h | 55 ++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
index 4cf11d88d3b3..a668c534206d 100644
--- a/arch/x86/include/asm/refcount.h
+++ b/arch/x86/include/asm/refcount.h
@@ -14,34 +14,43 @@
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
+
+asm ("\n"
+	".macro __REFCOUNT_EXCEPTION counter:vararg\n\t"
+	".pushsection .text..refcount\n"
+	"111:\tlea \\counter, %" _ASM_CX "\n"
+	"112:\t" ASM_UD2 "\n\t"
+	ASM_UNREACHABLE
+	".popsection\n\t"
+	"113:\n"
 	_ASM_EXTABLE_REFCOUNT(112b, 113b)
+	".endm");
 
 /* Trigger refcount exception if refcount result is negative. */
-#define REFCOUNT_CHECK_LT_ZERO				\
-	"js 111f\n\t"					\
-	_REFCOUNT_EXCEPTION
+asm ("\n"
+	".macro __REFCOUNT_CHECK_LT_ZERO counter:vararg\n"
+	"js 111f\n\t"
+	"__REFCOUNT_EXCEPTION \\counter\n"
+	".endm");
 
 /* Trigger refcount exception if refcount result is zero or negative. */
-#define REFCOUNT_CHECK_LE_ZERO				\
-	"jz 111f\n\t"					\
-	REFCOUNT_CHECK_LT_ZERO
+asm ("\n"
+	".macro __REFCOUNT_CHECK_LE_ZERO counter:vararg\n"
+	"jz 111f\n\t"
+	"__REFCOUNT_CHECK_LT_ZERO counter=\\counter\n"
+	".endm");
 
 /* Trigger refcount exception unconditionally. */
-#define REFCOUNT_ERROR					\
-	"jmp 111f\n\t"					\
-	_REFCOUNT_EXCEPTION
+asm ("\n"
+	".macro __REFCOUNT_ERROR counter:vararg\n\t"
+	"jmp 111f\n\t"
+	"__REFCOUNT_EXCEPTION counter=\\counter\n"
+	".endm");
 
 static __always_inline void refcount_add(unsigned int i, refcount_t *r)
 {
 	asm volatile(LOCK_PREFIX "addl %1,%0\n\t"
-		REFCOUNT_CHECK_LT_ZERO
+		"__REFCOUNT_CHECK_LT_ZERO %[counter]"
 		: [counter] "+m" (r->refs.counter)
 		: "ir" (i)
 		: "cc", "cx");
@@ -50,7 +59,7 @@ static __always_inline void refcount_add(unsigned int i, refcount_t *r)
 static __always_inline void refcount_inc(refcount_t *r)
 {
 	asm volatile(LOCK_PREFIX "incl %0\n\t"
-		REFCOUNT_CHECK_LT_ZERO
+		"__REFCOUNT_CHECK_LT_ZERO %[counter]"
 		: [counter] "+m" (r->refs.counter)
 		: : "cc", "cx");
 }
@@ -58,7 +67,7 @@ static __always_inline void refcount_inc(refcount_t *r)
 static __always_inline void refcount_dec(refcount_t *r)
 {
 	asm volatile(LOCK_PREFIX "decl %0\n\t"
-		REFCOUNT_CHECK_LE_ZERO
+		"__REFCOUNT_CHECK_LE_ZERO %[counter]"
 		: [counter] "+m" (r->refs.counter)
 		: : "cc", "cx");
 }
@@ -66,13 +75,15 @@ static __always_inline void refcount_dec(refcount_t *r)
 static __always_inline __must_check
 bool refcount_sub_and_test(unsigned int i, refcount_t *r)
 {
-	GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl", REFCOUNT_CHECK_LT_ZERO,
+	GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
+				  "__REFCOUNT_CHECK_LT_ZERO %[counter]",
 				  r->refs.counter, "er", i, "%0", e, "cx");
 }
 
 static __always_inline __must_check bool refcount_dec_and_test(refcount_t *r)
 {
-	GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl", REFCOUNT_CHECK_LT_ZERO,
+	GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
+				 "__REFCOUNT_CHECK_LT_ZERO %[counter]",
 				 r->refs.counter, "%0", e, "cx");
 }
 
@@ -90,7 +101,7 @@ bool refcount_add_not_zero(unsigned int i, refcount_t *r)
 
 		/* Did we try to increment from/to an undesirable state? */
 		if (unlikely(c < 0 || c == INT_MAX || result < c)) {
-			asm volatile(REFCOUNT_ERROR
+			asm volatile("__REFCOUNT_ERROR %[counter]"
 				     : : [counter] "m" (r->refs.counter)
 				     : "cc", "cx");
 			break;
-- 
2.17.0
