Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A92C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4968206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iJkFFCqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388271AbeLQQLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:11:21 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:65347 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbeLQQLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:11:20 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id wBHG3bRg008119;
        Tue, 18 Dec 2018 01:03:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com wBHG3bRg008119
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545062624;
        bh=kHNal4UmUGn0s8J+K0Ap+BknqWU9QPW2PO6e5dHn7Rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJkFFCqRQUQzPzByJamvTnfzkMZR+YgIQ8wx4pAK+/4Xpfltk8zvFCcDzMPkZQjo7
         q0/F/MaxrxLoNISMfqPGOIqm0wRTdAnbChtFjAePEzf7M2ilHDWVlwv7kqvQtsW3mO
         jUur5BGmid1l4aAtAfyWgqHq7IKUE31dm4afZp7k9ZONdM0WSmkAraWfG7eI2ej+xF
         KL3pcI3+Dh9n5UwvGwkQGN1xSqe4aWfXBN9ow+CTZDTVZIvSgMdZK+apdggdE5aCfe
         qgpx1EA7nqI0nAx/3693NhGpCR5o8VzZodmT9lX1Dub8P6AJXBUqwawajgz1TtowHw
         FSw+aH+nCx/lw==
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
        Yonghong Song <yhs@fb.com>, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Nadav Amit <namit@vmware.com>, Jann Horn <jannh@google.com>
Subject: [PATCH v3 03/12] Revert "x86/extable: Macrofy inline assembly code to work around GCC inlining bugs"
Date:   Tue, 18 Dec 2018 01:03:18 +0900
Message-Id: <1545062607-8599-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
References: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 0474d5d9d2f7f3b11262f7bf87d0e7314ead9200.

The in-kernel workarounds will be replaced with GCC's new
"asm inline" syntax.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I blindly reverted here, but I will clean it up
in a different way later.

 arch/x86/include/asm/asm.h | 53 +++++++++++++++++++++++++++++-----------------
 arch/x86/kernel/macros.S   |  1 -
 2 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 21b0867..6467757b 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -120,25 +120,12 @@
 /* Exception table entry */
 #ifdef __ASSEMBLY__
 # define _ASM_EXTABLE_HANDLE(from, to, handler)			\
-	ASM_EXTABLE_HANDLE from to handler
-
-.macro ASM_EXTABLE_HANDLE from:req to:req handler:req
-	.pushsection "__ex_table","a"
-	.balign 4
-	.long (\from) - .
-	.long (\to) - .
-	.long (\handler) - .
+	.pushsection "__ex_table","a" ;				\
+	.balign 4 ;						\
+	.long (from) - . ;					\
+	.long (to) - . ;					\
+	.long (handler) - . ;					\
 	.popsection
-.endm
-#else /* __ASSEMBLY__ */
-
-# define _ASM_EXTABLE_HANDLE(from, to, handler)			\
-	"ASM_EXTABLE_HANDLE from=" #from " to=" #to		\
-	" handler=\"" #handler "\"\n\t"
-
-/* For C file, we already have NOKPROBE_SYMBOL macro */
-
-#endif /* __ASSEMBLY__ */
 
 # define _ASM_EXTABLE(from, to)					\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_default)
@@ -161,7 +148,6 @@
 	_ASM_PTR (entry);					\
 	.popsection
 
-#ifdef __ASSEMBLY__
 .macro ALIGN_DESTINATION
 	/* check for bad alignment of destination */
 	movl %edi,%ecx
@@ -185,7 +171,34 @@
 	_ASM_EXTABLE_UA(100b, 103b)
 	_ASM_EXTABLE_UA(101b, 103b)
 	.endm
-#endif /* __ASSEMBLY__ */
+
+#else
+# define _EXPAND_EXTABLE_HANDLE(x) #x
+# define _ASM_EXTABLE_HANDLE(from, to, handler)			\
+	" .pushsection \"__ex_table\",\"a\"\n"			\
+	" .balign 4\n"						\
+	" .long (" #from ") - .\n"				\
+	" .long (" #to ") - .\n"				\
+	" .long (" _EXPAND_EXTABLE_HANDLE(handler) ") - .\n"	\
+	" .popsection\n"
+
+# define _ASM_EXTABLE(from, to)					\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_default)
+
+# define _ASM_EXTABLE_UA(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
+
+# define _ASM_EXTABLE_FAULT(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
+
+# define _ASM_EXTABLE_EX(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_ext)
+
+# define _ASM_EXTABLE_REFCOUNT(from, to)			\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_refcount)
+
+/* For C file, we already have NOKPROBE_SYMBOL macro */
+#endif
 
 #ifndef __ASSEMBLY__
 /*
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index 7baa40d..71d8b71 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -11,4 +11,3 @@
 #include <asm/alternative-asm.h>
 #include <asm/bug.h>
 #include <asm/paravirt.h>
-#include <asm/asm.h>
-- 
2.7.4

