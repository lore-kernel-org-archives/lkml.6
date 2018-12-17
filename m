Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82B8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5EAC2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uutzTQnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbeLQQLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:11:01 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:64948 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388139AbeLQQK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:10:58 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id wBHG3bRi008119;
        Tue, 18 Dec 2018 01:03:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com wBHG3bRi008119
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545062627;
        bh=XsfYrfLZf85NxXPieKuHNNRf8I2glcI/qdIVKn3J7kY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uutzTQnL21q2QZDhUPf4psTVjZy0+/QJsWpElxrBnOAhrsOagz/uEC7B7aeDv00O6
         9SHdNTTXtKHH+VUv73W+oNC/qvPxtn+8/3kAY8f+NgtF/tpBS6oQzQRSrVCjvcvgFb
         Ma5Q39i+32vtzlNcj0yE1FXmDYzxe+Y5Pvdwp+uQsL442mm/e2uoVzYqZE/ybTNGHC
         BFO/SZf/Wd5aR/o/m0DC0ymv9/vIqtfK5+BgR25RMmJm3Mp5hFdAhIDjv84TnV+Dns
         PuP84ulppu9LzgGqTHGs9mquVTjSu9Ky20p5gav0SN/gV71qK+w4pBz2mRLBShB7An
         gg4m7RQvpWqtA==
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
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 05/12] Revert "x86/bug: Macrofy the BUG table section handling, to work around GCC inlining bugs"
Date:   Tue, 18 Dec 2018 01:03:20 +0900
Message-Id: <1545062607-8599-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
References: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit f81f8ad56fd1c7b99b2ed1c314527f7d9ac447c6.

The in-kernel workarounds will be replaced with GCC's new
"asm inline" syntax.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/include/asm/bug.h | 98 ++++++++++++++++++++--------------------------
 arch/x86/kernel/macros.S   |  1 -
 include/asm-generic/bug.h  |  8 ++--
 3 files changed, 46 insertions(+), 61 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 5090035..6804d66 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -4,8 +4,6 @@
 
 #include <linux/stringify.h>
 
-#ifndef __ASSEMBLY__
-
 /*
  * Despite that some emulators terminate on UD2, we use it for WARN().
  *
@@ -22,15 +20,53 @@
 
 #define LEN_UD2		2
 
+#ifdef CONFIG_GENERIC_BUG
+
+#ifdef CONFIG_X86_32
+# define __BUG_REL(val)	".long " __stringify(val)
+#else
+# define __BUG_REL(val)	".long " __stringify(val) " - 2b"
+#endif
+
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+
+#define _BUG_FLAGS(ins, flags)						\
+do {									\
+	asm volatile("1:\t" ins "\n"					\
+		     ".pushsection __bug_table,\"aw\"\n"		\
+		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
+		     "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"	\
+		     "\t.word %c1"        "\t# bug_entry::line\n"	\
+		     "\t.word %c2"        "\t# bug_entry::flags\n"	\
+		     "\t.org 2b+%c3\n"					\
+		     ".popsection"					\
+		     : : "i" (__FILE__), "i" (__LINE__),		\
+			 "i" (flags),					\
+			 "i" (sizeof(struct bug_entry)));		\
+} while (0)
+
+#else /* !CONFIG_DEBUG_BUGVERBOSE */
+
 #define _BUG_FLAGS(ins, flags)						\
 do {									\
-	asm volatile("ASM_BUG ins=\"" ins "\" file=%c0 line=%c1 "	\
-		     "flags=%c2 size=%c3"				\
-		     : : "i" (__FILE__), "i" (__LINE__),                \
-			 "i" (flags),                                   \
+	asm volatile("1:\t" ins "\n"					\
+		     ".pushsection __bug_table,\"aw\"\n"		\
+		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
+		     "\t.word %c0"        "\t# bug_entry::flags\n"	\
+		     "\t.org 2b+%c1\n"					\
+		     ".popsection"					\
+		     : : "i" (flags),					\
 			 "i" (sizeof(struct bug_entry)));		\
 } while (0)
 
+#endif /* CONFIG_DEBUG_BUGVERBOSE */
+
+#else
+
+#define _BUG_FLAGS(ins, flags)  asm volatile(ins)
+
+#endif /* CONFIG_GENERIC_BUG */
+
 #define HAVE_ARCH_BUG
 #define BUG()							\
 do {								\
@@ -46,54 +82,4 @@ do {								\
 
 #include <asm-generic/bug.h>
 
-#else /* __ASSEMBLY__ */
-
-#ifdef CONFIG_GENERIC_BUG
-
-#ifdef CONFIG_X86_32
-.macro __BUG_REL val:req
-	.long \val
-.endm
-#else
-.macro __BUG_REL val:req
-	.long \val - 2b
-.endm
-#endif
-
-#ifdef CONFIG_DEBUG_BUGVERBOSE
-
-.macro ASM_BUG ins:req file:req line:req flags:req size:req
-1:	\ins
-	.pushsection __bug_table,"aw"
-2:	__BUG_REL val=1b	# bug_entry::bug_addr
-	__BUG_REL val=\file	# bug_entry::file
-	.word \line		# bug_entry::line
-	.word \flags		# bug_entry::flags
-	.org 2b+\size
-	.popsection
-.endm
-
-#else /* !CONFIG_DEBUG_BUGVERBOSE */
-
-.macro ASM_BUG ins:req file:req line:req flags:req size:req
-1:	\ins
-	.pushsection __bug_table,"aw"
-2:	__BUG_REL val=1b	# bug_entry::bug_addr
-	.word \flags		# bug_entry::flags
-	.org 2b+\size
-	.popsection
-.endm
-
-#endif /* CONFIG_DEBUG_BUGVERBOSE */
-
-#else /* CONFIG_GENERIC_BUG */
-
-.macro ASM_BUG ins:req file:req line:req flags:req size:req
-	\ins
-.endm
-
-#endif /* CONFIG_GENERIC_BUG */
-
-#endif /* __ASSEMBLY__ */
-
 #endif /* _ASM_X86_BUG_H */
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index 66ccb8e..852487a 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -9,4 +9,3 @@
 #include <linux/compiler.h>
 #include <asm/refcount.h>
 #include <asm/alternative-asm.h>
-#include <asm/bug.h>
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index cdafa5e..20561a6 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -17,8 +17,10 @@
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
 
-struct bug_entry {
+#ifdef CONFIG_BUG
+
 #ifdef CONFIG_GENERIC_BUG
+struct bug_entry {
 #ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
 	unsigned long	bug_addr;
 #else
@@ -33,10 +35,8 @@ struct bug_entry {
 	unsigned short	line;
 #endif
 	unsigned short	flags;
-#endif	/* CONFIG_GENERIC_BUG */
 };
-
-#ifdef CONFIG_BUG
+#endif	/* CONFIG_GENERIC_BUG */
 
 /*
  * Don't use BUG() or BUG_ON() unless there's really no way out; one
-- 
2.7.4

