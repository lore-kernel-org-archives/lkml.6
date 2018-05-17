Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeEQX2p (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 19:28:45 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:31398 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751293AbeEQX2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 19:28:40 -0400
From: Nadav Amit <namit@vmware.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <nadav.amit@gmail.com>, Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 2/6] x86: bug: prevent gcc distortions
Date: Thu, 17 May 2018 09:13:58 -0700
Message-ID: <20180517161402.78089-3-namit@vmware.com>
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

The solution is to set an assembly macro and call it from the inlinedv
assembly block. As a result GCC considers the inline assembly block as
a single instruction.

This patch increases the kernel size:

   text	   data	    bss	    dec	    hex	filename
18126824 10067268 2936832 31130924 1db052c ./vmlinux before
18127205 10068388 2936832 31132425 1db0b09 ./vmlinux after (+1501)

But enables more aggressive inlining (and probably branch decisions).
The number of static text symbols in vmlinux is lower.

Before:	40015
After:	39860	(-155)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/bug.h | 56 +++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 6804d6642767..1167e4822a34 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -30,33 +30,51 @@
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
-#define _BUG_FLAGS(ins, flags)						\
+/*
+ * Saving the bug data is encapsulated within an assembly macro, which is then
+ * called on each use. This hack is necessary to prevent GCC from considering
+ * the inline assembly blocks as costly in time and space, which can prevent
+ * function inlining and lead to other bad compilation decisions. GCC computes
+ * inline assembly cost according to the number of perceived number of assembly
+ * instruction, based on the number of new-lines and semicolons in the assembly
+ * block. The macro will eventually be compiled into a single instruction (and
+ * some data). This scheme allows GCC to better understand the inline asm cost.
+ */
+asm(".macro __BUG_FLAGS ins:req file:req line:req flags:req size:req\n"
+    "1:\t \\ins\n\t"
+    ".pushsection __bug_table,\"aw\"\n"
+    "2:\t "__BUG_REL(1b)		"\t# bug_entry::bug_addr\n\t"
+    __BUG_REL(\\file)			"\t# bug_entry::file\n\t"
+    ".word \\line"			"\t# bug_entry::line\n\t"
+    ".word \\flags"			"\t# bug_entry::flags\n\t"
+    ".org 2b+\\size\n\t"
+    ".popsection\n\t"
+    ".endm");
+
+#define _BUG_FLAGS(ins, flags)                                          \
 do {									\
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
+	asm volatile("__BUG_FLAGS \"" ins "\" %c0 %c1 %c2 %c3"		\
+		     : : "i" (__FILE__), "i" (__LINE__),                \
+			 "i" (flags),                                   \
 			 "i" (sizeof(struct bug_entry)));		\
 } while (0)
 
 #else /* !CONFIG_DEBUG_BUGVERBOSE */
 
+asm(".macro __BUG_FLAGS ins:req flags:req size:req\n"
+    "1:\t\\ins\n\t"
+    ".pushsection __bug_table,\"aw\"\n"
+    "2:\t" __BUG_REL(1b)		"\t# bug_entry::bug_addr\n\t"
+    ".word \\flags"			"\t# bug_entry::flags\n\t"
+    ".org 2b+\\size\n\t"
+    ".popsection\n\t"
+    ".endm");
+
 #define _BUG_FLAGS(ins, flags)						\
 do {									\
-	asm volatile("1:\t" ins "\n"					\
-		     ".pushsection __bug_table,\"aw\"\n"		\
-		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
-		     "\t.word %c0"        "\t# bug_entry::flags\n"	\
-		     "\t.org 2b+%c1\n"					\
-		     ".popsection"					\
-		     : : "i" (flags),					\
-			 "i" (sizeof(struct bug_entry)));		\
+	asm volatile("__BUG_FLAGS \"" ins "\" %c0 %c1"			\
+		    : : "i" (flags),					\
+			"i" (sizeof(struct bug_entry)));		\
 } while (0)
 
 #endif /* CONFIG_DEBUG_BUGVERBOSE */
-- 
2.17.0
