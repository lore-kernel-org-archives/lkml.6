Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeFDSiF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:38:05 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:2727 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750987AbeFDSg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:36:28 -0400
From: Nadav Amit <namit@vmware.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2 7/9] x86: extable: use macros instead of inline assembly
Date: Mon, 4 Jun 2018 04:21:29 -0700
Message-ID: <20180604112131.59100-8-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180604112131.59100-1-namit@vmware.com>
References: <20180604112131.59100-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
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
