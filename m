Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347BBC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2ECA20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2ECA20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeJDQ44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:56:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43717 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbeJDQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:56:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w94A3don2701893
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Oct 2018 03:03:39 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w94A3dpY2701890;
        Thu, 4 Oct 2018 03:03:39 -0700
Date:   Thu, 4 Oct 2018 03:03:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-f81f8ad56fd1c7b99b2ed1c314527f7d9ac447c6@git.kernel.org>
Cc:     dvlasenk@redhat.com, peterz@infradead.org, mingo@kernel.org,
        bp@alien8.de, brgerst@gmail.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, namit@vmware.com,
        luto@amacapital.net, torvalds@linux-foundation.org,
        tglx@linutronix.de, hpa@zytor.com, keescook@chromium.org
Reply-To: keescook@chromium.org, tglx@linutronix.de, hpa@zytor.com,
          luto@amacapital.net, torvalds@linux-foundation.org,
          namit@vmware.com, linux-kernel@vger.kernel.org,
          jpoimboe@redhat.com, brgerst@gmail.com, bp@alien8.de,
          mingo@kernel.org, dvlasenk@redhat.com, peterz@infradead.org
In-Reply-To: <20181003213100.189959-7-namit@vmware.com>
References: <20181003213100.189959-7-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/bug: Macrofy the BUG table section handling, to
 work around GCC inlining bugs
Git-Commit-ID: f81f8ad56fd1c7b99b2ed1c314527f7d9ac447c6
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

Commit-ID:  f81f8ad56fd1c7b99b2ed1c314527f7d9ac447c6
Gitweb:     https://git.kernel.org/tip/f81f8ad56fd1c7b99b2ed1c314527f7d9ac447c6
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Wed, 3 Oct 2018 14:30:56 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 4 Oct 2018 11:25:00 +0200

x86/bug: Macrofy the BUG table section handling, to work around GCC inlining bugs

As described in:

  77b0bf55bc67: ("kbuild/Makefile: Prepare for using macros in inline assembly code to work around asm() related GCC inlining bugs")

GCC's inlining heuristics are broken with common asm() patterns used in
kernel code, resulting in the effective disabling of inlining.

The workaround is to set an assembly macro and call it from the inline
assembly block. As a result GCC considers the inline assembly block as
a single instruction. (Which it isn't, but that's the best we can get.)

This patch increases the kernel size:

      text     data     bss      dec     hex  filename
  18146889 10225380 2957312 31329581 1de0d2d  ./vmlinux before
  18147336 10226688 2957312 31331336 1de1408  ./vmlinux after (+1755)

But enables more aggressive inlining (and probably better branch decisions).

The number of static text symbols in vmlinux is much lower:

 Before: 40218
 After:  40053 (-165)

The assembly code gets harder to read due to the extra macro layer.

[ mingo: Rewrote the changelog. ]

Tested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181003213100.189959-7-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/bug.h | 98 ++++++++++++++++++++++++++--------------------
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
index 20561a60db9c..cdafa5edea49 100644
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
