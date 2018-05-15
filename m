Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752827AbeEOV3r (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:29:47 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:48538 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752537AbeEOV0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:26:12 -0400
From: Nadav Amit <namit@vmware.com>
To: <linux-kernel@vger.kernel.org>
CC: <nadav.amit@gmail.com>, Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC 2/8] x86: bug: prevent gcc distortions
Date: Tue, 15 May 2018 07:11:09 -0700
Message-ID: <20180515141124.84254-3-namit@vmware.com>
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
 arch/x86/include/asm/bug.h | 48 +++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 6804d6642767..a2d981beb6cb 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -30,33 +30,43 @@
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
-#define _BUG_FLAGS(ins, flags)						\
+asm("\n"
+	".macro __BUG_FLAGS ins:req file:req line:req flags:req size:req\n"
+	"1:\t \\ins\n\t"
+	".pushsection __bug_table,\"aw\"\n"
+	"2:\t "__BUG_REL(1b)            "\t# bug_entry::bug_addr\n\t"
+	__BUG_REL(\\file)		"\t# bug_entry::file\n\t"
+	".word \\line"			"\t# bug_entry::line\n\t"
+	".word \\flags"			"\t# bug_entry::flags\n\t"
+	".org 2b+\\size\n\t"
+	".popsection\n"
+	".endm");
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
 
+asm("\n"
+	".macro __BUG_FLAGS ins:req flags:req size:req\n"
+	"1:\t \\ins\n\t"
+	".pushsection __bug_table,\"aw\"\n"
+	"2:\t" __BUG_REL(1b)		"\t# bug_entry::bug_addr\n\t"
+	".word \\flags"			"\t# bug_entry::flags\n\t"
+	".org 2b+\\size\n\t"
+	".popsection\n"
+	".endm");
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
