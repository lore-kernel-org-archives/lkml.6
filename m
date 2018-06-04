Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeFDSgd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:36:33 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:2727 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751058AbeFDSg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:36:29 -0400
From: Nadav Amit <namit@vmware.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2 5/9] x86: bug: prevent gcc distortions
Date: Mon, 4 Jun 2018 04:21:27 -0700
Message-ID: <20180604112131.59100-6-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180604112131.59100-1-namit@vmware.com>
References: <20180604112131.59100-1-namit@vmware.com>
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

The solution is to set an assembly macro and call it from the inlinedv
assembly block. As a result GCC considers the inline assembly block as
a single instruction.

This patch increases the kernel size:

   text	   data	    bss	    dec	    hex	filename
18146889 10225380 2957312 31329581 1de0d2d ./vmlinux before
18147336 10226688 2957312 31331336 1de1408 ./vmlinux after (+1755)

But enables more aggressive inlining (and probably branch decisions).
The number of static text symbols in vmlinux is lower.

Static text symbols:
Before:	40218
After:	40053	(-165)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/bug.h | 98 ++++++++++++++++++++++----------------
 arch/x86/kernel/macros.S   |  1 +
 2 files changed, 57 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 6804d6642767..5090035e6d16 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -4,6 +4,8 @@
 
 #include <linux/stringify.h>
 
+#ifndef __ASSEMBLY__
+
 /*
  * Despite that some emulators terminate on UD2, we use it for WARN().
  *
@@ -20,53 +22,15 @@
 
 #define LEN_UD2		2
 
-#ifdef CONFIG_GENERIC_BUG
-
-#ifdef CONFIG_X86_32
-# define __BUG_REL(val)	".long " __stringify(val)
-#else
-# define __BUG_REL(val)	".long " __stringify(val) " - 2b"
-#endif
-
-#ifdef CONFIG_DEBUG_BUGVERBOSE
-
-#define _BUG_FLAGS(ins, flags)						\
-do {									\
-	asm volatile("1:\t" ins "\n"					\
-		     ".pushsection __bug_table,\"aw\"\n"		\
-		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
-		     "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"	\
-		     "\t.word %c1"        "\t# bug_entry::line\n"	\
-		     "\t.word %c2"        "\t# bug_entry::flags\n"	\
-		     "\t.org 2b+%c3\n"					\
-		     ".popsection"					\
-		     : : "i" (__FILE__), "i" (__LINE__),		\
-			 "i" (flags),					\
-			 "i" (sizeof(struct bug_entry)));		\
-} while (0)
-
-#else /* !CONFIG_DEBUG_BUGVERBOSE */
-
 #define _BUG_FLAGS(ins, flags)						\
 do {									\
-	asm volatile("1:\t" ins "\n"					\
-		     ".pushsection __bug_table,\"aw\"\n"		\
-		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
-		     "\t.word %c0"        "\t# bug_entry::flags\n"	\
-		     "\t.org 2b+%c1\n"					\
-		     ".popsection"					\
-		     : : "i" (flags),					\
+	asm volatile("ASM_BUG ins=\"" ins "\" file=%c0 line=%c1 "	\
+		     "flags=%c2 size=%c3"				\
+		     : : "i" (__FILE__), "i" (__LINE__),                \
+			 "i" (flags),                                   \
 			 "i" (sizeof(struct bug_entry)));		\
 } while (0)
 
-#endif /* CONFIG_DEBUG_BUGVERBOSE */
-
-#else
-
-#define _BUG_FLAGS(ins, flags)  asm volatile(ins)
-
-#endif /* CONFIG_GENERIC_BUG */
-
 #define HAVE_ARCH_BUG
 #define BUG()							\
 do {								\
@@ -82,4 +46,54 @@ do {								\
 
 #include <asm-generic/bug.h>
 
+#else /* __ASSEMBLY__ */
+
+#ifdef CONFIG_GENERIC_BUG
+
+#ifdef CONFIG_X86_32
+.macro __BUG_REL val:req
+	.long \val
+.endm
+#else
+.macro __BUG_REL val:req
+	.long \val - 2b
+.endm
+#endif
+
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+
+.macro ASM_BUG ins:req file:req line:req flags:req size:req
+1:	\ins
+	.pushsection __bug_table,"aw"
+2:	__BUG_REL val=1b	# bug_entry::bug_addr
+	__BUG_REL val=\file	# bug_entry::file
+	.word \line		# bug_entry::line
+	.word \flags		# bug_entry::flags
+	.org 2b+\size
+	.popsection
+.endm
+
+#else /* !CONFIG_DEBUG_BUGVERBOSE */
+
+.macro ASM_BUG ins:req file:req line:req flags:req size:req
+1:	\ins
+	.pushsection __bug_table,"aw"
+2:	__BUG_REL val=1b	# bug_entry::bug_addr
+	.word \flags		# bug_entry::flags
+	.org 2b+\size
+	.popsection
+.endm
+
+#endif /* CONFIG_DEBUG_BUGVERBOSE */
+
+#else /* CONFIG_GENERIC_BUG */
+
+.macro ASM_BUG ins:req file:req line:req flags:req size:req
+	\ins
+.endm
+
+#endif /* CONFIG_GENERIC_BUG */
+
+#endif /* __ASSEMBLY__ */
+
 #endif /* _ASM_X86_BUG_H */
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index 852487a9fc56..66ccb8e823b1 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -9,3 +9,4 @@
 #include <linux/compiler.h>
 #include <asm/refcount.h>
 #include <asm/alternative-asm.h>
+#include <asm/bug.h>
-- 
2.17.0
