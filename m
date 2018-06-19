Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E46BC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F0720693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F0720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754497AbeFTDEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 23:04:36 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36637 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753862AbeFTDDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 23:03:44 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 19 Jun 2018 20:03:36 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 3484F40DF2;
        Tue, 19 Jun 2018 20:03:40 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v5 5/9] x86: bug: prevent gcc distortions
Date:   Tue, 19 Jun 2018 12:48:50 -0700
Message-ID: <20180619194854.69486-6-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180619194854.69486-1-namit@vmware.com>
References: <20180619194854.69486-1-namit@vmware.com>
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
 include/asm-generic/bug.h  |  8 ++--
 3 files changed, 61 insertions(+), 46 deletions(-)

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
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index a7613e1b0c87..cf7f4ef4749e 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -17,10 +17,8 @@
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
 
-#ifdef CONFIG_BUG
-
-#ifdef CONFIG_GENERIC_BUG
 struct bug_entry {
+#ifdef CONFIG_GENERIC_BUG
 #ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
 	unsigned long	bug_addr;
 #else
@@ -35,8 +33,10 @@ struct bug_entry {
 	unsigned short	line;
 #endif
 	unsigned short	flags;
-};
 #endif	/* CONFIG_GENERIC_BUG */
+};
+
+#ifdef CONFIG_BUG
 
 /*
  * Don't use BUG() or BUG_ON() unless there's really no way out; one
-- 
2.17.0

