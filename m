Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752346AbeEQX3N (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 19:29:13 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:31398 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752204AbeEQX2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 19:28:44 -0400
From: Nadav Amit <namit@vmware.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <nadav.amit@gmail.com>, Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
        Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 5/6] x86: refcount: prevent gcc distortions
Date: Thu, 17 May 2018 09:14:01 -0700
Message-ID: <20180517161402.78089-6-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517161402.78089-1-namit@vmware.com>
References: <20180517161402.78089-1-namit@vmware.com>
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
 arch/x86/include/asm/refcount.h | 62 +++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
index 4cf11d88d3b3..3126141f2c80 100644
--- a/arch/x86/include/asm/refcount.h
+++ b/arch/x86/include/asm/refcount.h
@@ -13,35 +13,49 @@
  * the exception handler to use (in mm/extable.c), and then triggers the
  * central refcount exception. The fixup address for the exception points
  * back to the regular execution flow in .text.
+ *
+ * The logic and data are encapsulated within an assembly macro, which is then
+ * called on each use. This hack is necessary to prevent GCC from considering
+ * the inline assembly blocks as costly in time and space, which can prevent
+ * function inlining and lead to other bad compilation decisions. GCC computes
+ * inline assembly cost according to the number of perceived number of assembly
+ * instruction, based on the number of new-lines and semicolons in the assembly
+ * block. The macros will eventually be compiled into a single instruction that
+ * will be actually executed (unless an exception happens). This scheme allows
+ * GCC to better understand the inline asm cost.
  */
-#define _REFCOUNT_EXCEPTION				\
-	".pushsection .text..refcount\n"		\
-	"111:\tlea %[counter], %%" _ASM_CX "\n"		\
-	"112:\t" ASM_UD2 "\n"				\
-	ASM_UNREACHABLE					\
-	".popsection\n"					\
-	"113:\n"					\
-	_ASM_EXTABLE_REFCOUNT(112b, 113b)
+asm(".macro __REFCOUNT_EXCEPTION counter:req\n\t"
+    ".pushsection .text..refcount\n"
+    "111:\tlea \\counter, %" _ASM_CX "\n"
+    "112:\t" ASM_UD2 "\n\t"
+    ASM_UNREACHABLE
+    ".popsection\n"
+    "113:\n\t"
+    _ASM_EXTABLE_REFCOUNT(112b, 113b) "\n\t"
+    ".endm");
 
 /* Trigger refcount exception if refcount result is negative. */
-#define REFCOUNT_CHECK_LT_ZERO				\
-	"js 111f\n\t"					\
-	_REFCOUNT_EXCEPTION
+asm(".macro __REFCOUNT_CHECK_LT_ZERO counter:req\n\t"
+    "js 111f\n\t"
+    "__REFCOUNT_EXCEPTION \\counter\n\t"
+    ".endm");
 
 /* Trigger refcount exception if refcount result is zero or negative. */
-#define REFCOUNT_CHECK_LE_ZERO				\
-	"jz 111f\n\t"					\
-	REFCOUNT_CHECK_LT_ZERO
+asm(".macro __REFCOUNT_CHECK_LE_ZERO counter:req\n\t"
+    "jz 111f\n\t"
+    "__REFCOUNT_CHECK_LT_ZERO counter=\\counter\n\t"
+    ".endm");
 
 /* Trigger refcount exception unconditionally. */
-#define REFCOUNT_ERROR					\
-	"jmp 111f\n\t"					\
-	_REFCOUNT_EXCEPTION
+asm(".macro __REFCOUNT_ERROR counter:req\n\t"
+    "jmp 111f\n\t"
+    "__REFCOUNT_EXCEPTION counter=\\counter\n\t"
+    ".endm");
 
 static __always_inline void refcount_add(unsigned int i, refcount_t *r)
 {
 	asm volatile(LOCK_PREFIX "addl %1,%0\n\t"
-		REFCOUNT_CHECK_LT_ZERO
+		"__REFCOUNT_CHECK_LT_ZERO %[counter]"
 		: [counter] "+m" (r->refs.counter)
 		: "ir" (i)
 		: "cc", "cx");
@@ -50,7 +64,7 @@ static __always_inline void refcount_add(unsigned int i, refcount_t *r)
 static __always_inline void refcount_inc(refcount_t *r)
 {
 	asm volatile(LOCK_PREFIX "incl %0\n\t"
-		REFCOUNT_CHECK_LT_ZERO
+		"__REFCOUNT_CHECK_LT_ZERO %[counter]"
 		: [counter] "+m" (r->refs.counter)
 		: : "cc", "cx");
 }
@@ -58,7 +72,7 @@ static __always_inline void refcount_inc(refcount_t *r)
 static __always_inline void refcount_dec(refcount_t *r)
 {
 	asm volatile(LOCK_PREFIX "decl %0\n\t"
-		REFCOUNT_CHECK_LE_ZERO
+		"__REFCOUNT_CHECK_LE_ZERO %[counter]"
 		: [counter] "+m" (r->refs.counter)
 		: : "cc", "cx");
 }
@@ -66,13 +80,15 @@ static __always_inline void refcount_dec(refcount_t *r)
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
 
@@ -90,7 +106,7 @@ bool refcount_add_not_zero(unsigned int i, refcount_t *r)
 
 		/* Did we try to increment from/to an undesirable state? */
 		if (unlikely(c < 0 || c == INT_MAX || result < c)) {
-			asm volatile(REFCOUNT_ERROR
+			asm volatile("__REFCOUNT_ERROR %[counter]"
 				     : : [counter] "m" (r->refs.counter)
 				     : "cc", "cx");
 			break;
-- 
2.17.0
