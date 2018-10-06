Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB3BC65C31
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 14:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08972089D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 14:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08972089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeJFVrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 17:47:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54849 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbeJFVrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 17:47:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w96EgsEc3576870
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 6 Oct 2018 07:42:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w96EgrMd3576867;
        Sat, 6 Oct 2018 07:42:53 -0700
Date:   Sat, 6 Oct 2018 07:42:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-0474d5d9d2f7f3b11262f7bf87d0e7314ead9200@git.kernel.org>
Cc:     hpa@zytor.com, peterz@infradead.org, torvalds@linux-foundation.org,
        dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org, namit@vmware.com, bp@alien8.de,
        mingo@kernel.org, brgerst@gmail.com, luto@amacapital.net,
        tglx@linutronix.de, jpoimboe@redhat.com
Reply-To: namit@vmware.com, keescook@chromium.org,
          linux-kernel@vger.kernel.org, dvlasenk@redhat.com,
          jpoimboe@redhat.com, tglx@linutronix.de, luto@amacapital.net,
          brgerst@gmail.com, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
          torvalds@linux-foundation.org, peterz@infradead.org
In-Reply-To: <20181005202718.229565-2-namit@vmware.com>
References: <20181005202718.229565-2-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/extable: Macrofy inline assembly code to work
 around GCC inlining bugs
Git-Commit-ID: 0474d5d9d2f7f3b11262f7bf87d0e7314ead9200
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

Commit-ID:  0474d5d9d2f7f3b11262f7bf87d0e7314ead9200
Gitweb:     https://git.kernel.org/tip/0474d5d9d2f7f3b11262f7bf87d0e7314ead9200
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Fri, 5 Oct 2018 13:27:16 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 6 Oct 2018 15:52:15 +0200

x86/extable: Macrofy inline assembly code to work around GCC inlining bugs

As described in:

  77b0bf55bc67: ("kbuild/Makefile: Prepare for using macros in inline assembly code to work around asm() related GCC inlining bugs")

GCC's inlining heuristics are broken with common asm() patterns used in
kernel code, resulting in the effective disabling of inlining.

The workaround is to set an assembly macro and call it from the inline
assembly block - which is also a minor cleanup for the exception table
code.

Text size goes up a bit:

      text     data     bss      dec     hex  filename
  18162555 10226288 2957312 31346155 1de4deb  ./vmlinux before
  18162879 10226256 2957312 31346447 1de4f0f  ./vmlinux after (+292)

But this allows the inlining of functions such as nested_vmx_exit_reflected(),
set_segment_reg(), __copy_xstate_to_user() which is a net benefit.

Tested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181005202718.229565-2-namit@vmware.com
Link: https://lore.kernel.org/lkml/20181003213100.189959-9-namit@vmware.com/T/#u
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/asm.h | 53 +++++++++++++++++-----------------------------
 arch/x86/kernel/macros.S   |  1 +
 2 files changed, 21 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 6467757bb39f..21b086786404 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -120,12 +120,25 @@
 /* Exception table entry */
 #ifdef __ASSEMBLY__
 # define _ASM_EXTABLE_HANDLE(from, to, handler)			\
-	.pushsection "__ex_table","a" ;				\
-	.balign 4 ;						\
-	.long (from) - . ;					\
-	.long (to) - . ;					\
-	.long (handler) - . ;					\
+	ASM_EXTABLE_HANDLE from to handler
+
+.macro ASM_EXTABLE_HANDLE from:req to:req handler:req
+	.pushsection "__ex_table","a"
+	.balign 4
+	.long (\from) - .
+	.long (\to) - .
+	.long (\handler) - .
 	.popsection
+.endm
+#else /* __ASSEMBLY__ */
+
+# define _ASM_EXTABLE_HANDLE(from, to, handler)			\
+	"ASM_EXTABLE_HANDLE from=" #from " to=" #to		\
+	" handler=\"" #handler "\"\n\t"
+
+/* For C file, we already have NOKPROBE_SYMBOL macro */
+
+#endif /* __ASSEMBLY__ */
 
 # define _ASM_EXTABLE(from, to)					\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_default)
@@ -148,6 +161,7 @@
 	_ASM_PTR (entry);					\
 	.popsection
 
+#ifdef __ASSEMBLY__
 .macro ALIGN_DESTINATION
 	/* check for bad alignment of destination */
 	movl %edi,%ecx
@@ -171,34 +185,7 @@
 	_ASM_EXTABLE_UA(100b, 103b)
 	_ASM_EXTABLE_UA(101b, 103b)
 	.endm
-
-#else
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
+#endif /* __ASSEMBLY__ */
 
 #ifndef __ASSEMBLY__
 /*
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index 71d8b716b111..7baa40d5bf16 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -11,3 +11,4 @@
 #include <asm/alternative-asm.h>
 #include <asm/bug.h>
 #include <asm/paravirt.h>
+#include <asm/asm.h>
