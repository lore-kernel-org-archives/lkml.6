Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB89C65BBE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B34D208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B34D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbeJFD3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:29:24 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:51649 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728170AbeJFD3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:29:23 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 5 Oct 2018 13:28:53 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id C81DD40402;
        Fri,  5 Oct 2018 13:29:02 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 1/3] x86/extable: Macrofy inline assembly code to work around GCC inlining bugs
Date:   Fri, 5 Oct 2018 13:27:16 -0700
Message-ID: <20181005202718.229565-2-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005202718.229565-1-namit@vmware.com>
References: <20181005093108.GA24723@gmail.com>
 <20181005202718.229565-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/20181003213100.189959-9-namit@vmware.com/T/#u
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/asm.h | 53 ++++++++++++++------------------------
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
-- 
2.17.1

