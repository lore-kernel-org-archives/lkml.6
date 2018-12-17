Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6ABC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6E4206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="IZLqzfz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388182AbeLQQIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:08:04 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:61874 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbeLQQID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:08:03 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id wBHG3bRp008119;
        Tue, 18 Dec 2018 01:03:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com wBHG3bRp008119
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545062637;
        bh=x/KQxi9+ntHpo7b3spoLqqCNx8iz55GVWCoL7isyaps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IZLqzfz7V0GW9pfJ5UnzRYH8Xk/+//PqcZXdl7IFAO+xhowqoQQGUH3nxlo6GDcBQ
         xne7Xpw0Zb+6d6K2pN4rQYZGc3b+FuATeCqlSw5BZ7QHitzhJkm5Uyjtnzps+LEyW+
         2RU62YXl9cXOK6ifslTv8DxzXKYtldWP4jTfkH5oYXkGkhnq9bMqLdtsSk4XW6k4Pu
         GBsULmDgm0qBYydXoAXR5h6e8M2aoNKxJIfXzKp8YSpxlsb5o0w/UFdxyQeX9H1Ics
         Nb+byTkTF08h80ANnleavUGFJPk8ekzh+WYVCWmfggwq2OBk7elg/+ZQSIl03miSbQ
         jKOu+gRqiOWDw==
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
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Nadav Amit <namit@vmware.com>, Jann Horn <jannh@google.com>
Subject: [PATCH v3 12/12] x86/asm: consolidate ASM_EXTABLE_* macros
Date:   Tue, 18 Dec 2018 01:03:27 +0900
Message-Id: <1545062607-8599-13-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
References: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These macros are used by .c and .S files.

Let's unify the definition by using ASM() macro.

This was previously cleaned up by 0474d5d9d2f7 ("x86/extable:
Macrofy inline assembly code to work around GCC inlining bugs").

Now, I am refactoring the code without using the macros approach.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/include/asm/asm.h | 57 ++++++++++++----------------------------------
 1 file changed, 15 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 6467757b..cff3b0a 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -118,36 +118,36 @@
 #endif
 
 /* Exception table entry */
-#ifdef __ASSEMBLY__
-# define _ASM_EXTABLE_HANDLE(from, to, handler)			\
-	.pushsection "__ex_table","a" ;				\
-	.balign 4 ;						\
-	.long (from) - . ;					\
-	.long (to) - . ;					\
-	.long (handler) - . ;					\
-	.popsection
-
-# define _ASM_EXTABLE(from, to)					\
+#define _ASM_EXTABLE_HANDLE(from, to, handler)			 \
+ASM(	.pushsection "__ex_table","a" ;				)\
+ASM(	.balign 4 ;						)\
+ASM(	.long (from) - . ;					)\
+ASM(	.long (to) - . ;					)\
+ASM(	.long (handler) - . ;					)\
+ASM(	.popsection						)
+
+#define _ASM_EXTABLE(from, to)					\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_default)
 
-# define _ASM_EXTABLE_UA(from, to)				\
+#define _ASM_EXTABLE_UA(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
 
-# define _ASM_EXTABLE_FAULT(from, to)				\
+#define _ASM_EXTABLE_FAULT(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
 
-# define _ASM_EXTABLE_EX(from, to)				\
+#define _ASM_EXTABLE_EX(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_ext)
 
-# define _ASM_EXTABLE_REFCOUNT(from, to)			\
+#define _ASM_EXTABLE_REFCOUNT(from, to)			\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_refcount)
 
-# define _ASM_NOKPROBE(entry)					\
+#define _ASM_NOKPROBE(entry)					\
 	.pushsection "_kprobe_blacklist","aw" ;			\
 	_ASM_ALIGN ;						\
 	_ASM_PTR (entry);					\
 	.popsection
 
+#ifdef __ASSEMBLY__
 .macro ALIGN_DESTINATION
 	/* check for bad alignment of destination */
 	movl %edi,%ecx
@@ -173,34 +173,7 @@
 	.endm
 
 #else
-# define _EXPAND_EXTABLE_HANDLE(x) #x
-# define _ASM_EXTABLE_HANDLE(from, to, handler)			\
-	" .pushsection \"__ex_table\",\"a\"\n"			\
-	" .balign 4\n"						\
-	" .long (" #from ") - .\n"				\
-	" .long (" #to ") - .\n"				\
-	" .long (" _EXPAND_EXTABLE_HANDLE(handler) ") - .\n"	\
-	" .popsection\n"
-
-# define _ASM_EXTABLE(from, to)					\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_default)
-
-# define _ASM_EXTABLE_UA(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
-
-# define _ASM_EXTABLE_FAULT(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
-
-# define _ASM_EXTABLE_EX(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_ext)
-
-# define _ASM_EXTABLE_REFCOUNT(from, to)			\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_refcount)
-
-/* For C file, we already have NOKPROBE_SYMBOL macro */
-#endif
 
-#ifndef __ASSEMBLY__
 /*
  * This output constraint should be used for any inline asm which has a "call"
  * instruction.  Otherwise the asm may be inserted before the frame pointer
-- 
2.7.4

