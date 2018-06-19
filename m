Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1502C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFC320693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFC320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754380AbeFTDEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 23:04:07 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36637 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754289AbeFTDDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 23:03:46 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 19 Jun 2018 20:03:36 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 5275640DEF;
        Tue, 19 Jun 2018 20:03:40 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v5 7/9] x86: extable: use macros instead of inline assembly
Date:   Tue, 19 Jun 2018 12:48:52 -0700
Message-ID: <20180619194854.69486-8-namit@vmware.com>
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

Use assembly macros for exception-tables and call them from inline
assembly.  This not only makes the code more readable and allows to
avoid the duplicate implementation, but also improves compilation
decision, specifically inline decisions which GCC base on the number of
new lines in inline assembly.

   text	   data	    bss	    dec	    hex	filename
18162555 10226288 2957312 31346155 1de4deb ./vmlinux before
18162879 10226256 2957312 31346447 1de4f0f ./vmlinux after (+292)

This allows to inline functions such as nested_vmx_exit_reflected(),
set_segment_reg(), __copy_xstate_to_user().

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/asm.h | 61 +++++++++++++++++---------------------
 arch/x86/kernel/macros.S   |  1 +
 2 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 219faaec51df..30bc1b0058ef 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -58,28 +58,44 @@
 # define CC_OUT(c) [_cc_ ## c] "=qm"
 #endif
 
-/* Exception table entry */
 #ifdef __ASSEMBLY__
 # define _ASM_EXTABLE_HANDLE(from, to, handler)			\
-	.pushsection "__ex_table","a" ;				\
-	.balign 4 ;						\
-	.long (from) - . ;					\
-	.long (to) - . ;					\
-	.long (handler) - . ;					\
-	.popsection
+	ASM_EXTABLE_HANDLE from to handler
+
+#else /* __ASSEMBLY__ */
+
+# define _ASM_EXTABLE_HANDLE(from, to, handler)			\
+	"ASM_EXTABLE_HANDLE from=" #from " to=" #to		\
+	" handler=\"" #handler "\"\n\t"
+
+/* For C file, we already have NOKPROBE_SYMBOL macro */
+
+#endif /* __ASSEMBLY__ */
 
-# define _ASM_EXTABLE(from, to)					\
+#define _ASM_EXTABLE(from, to)					\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_default)
 
-# define _ASM_EXTABLE_FAULT(from, to)				\
+#define _ASM_EXTABLE_FAULT(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
 
-# define _ASM_EXTABLE_EX(from, to)				\
+#define _ASM_EXTABLE_EX(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_ext)
 
-# define _ASM_EXTABLE_REFCOUNT(from, to)			\
+#define _ASM_EXTABLE_REFCOUNT(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_refcount)
 
+/* Exception table entry */
+#ifdef __ASSEMBLY__
+
+.macro ASM_EXTABLE_HANDLE from:req to:req handler:req
+	.pushsection "__ex_table","a"
+	.balign 4
+	.long (\from) - .
+	.long (\to) - .
+	.long (\handler) - .
+	.popsection
+.endm
+
 # define _ASM_NOKPROBE(entry)					\
 	.pushsection "_kprobe_blacklist","aw" ;			\
 	_ASM_ALIGN ;						\
@@ -110,29 +126,6 @@
 	_ASM_EXTABLE(101b,103b)
 	.endm
 
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
 #endif
 
 #ifndef __ASSEMBLY__
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
2.17.0

