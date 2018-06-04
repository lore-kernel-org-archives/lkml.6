Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeFDSge (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:36:34 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:2727 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750779AbeFDSga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:36:30 -0400
From: Nadav Amit <namit@vmware.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: [PATCH v2 9/9] x86: jump-labels: use macros instead of inline assembly
Date: Mon, 4 Jun 2018 04:21:31 -0700
Message-ID: <20180604112131.59100-10-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180604112131.59100-1-namit@vmware.com>
References: <20180604112131.59100-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use assembly macros for jump-labels and call them from inline assembly.
This not only makes the code more readable, but also improves
compilation decision, specifically inline decisions which GCC base on
the number of new lines in inline assembly.

As a result the code size is slightly increased.

   text	   data	    bss	    dec	    hex	filename
18163528 10226300 2957312 31347140 1de51c4 ./vmlinux before
18163608 10227348 2957312 31348268 1de562c ./vmlinux after (+1128)

And functions such as intel_pstate_adjust_policy_max(),
kvm_cpu_accept_dm_intr(), kvm_register_read() are inlined.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/jump_label.h | 65 ++++++++++++++++++-------------
 arch/x86/kernel/macros.S          |  1 +
 2 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 8c0de4282659..ea0633a41122 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -2,19 +2,6 @@
 #ifndef _ASM_X86_JUMP_LABEL_H
 #define _ASM_X86_JUMP_LABEL_H
 
-#ifndef HAVE_JUMP_LABEL
-/*
- * For better or for worse, if jump labels (the gcc extension) are missing,
- * then the entire static branch patching infrastructure is compiled out.
- * If that happens, the code in here will malfunction.  Raise a compiler
- * error instead.
- *
- * In theory, jump labels and the static branch patching infrastructure
- * could be decoupled to fix this.
- */
-#error asm/jump_label.h included on a non-jump-label kernel
-#endif
-
 #define JUMP_LABEL_NOP_SIZE 5
 
 #ifdef CONFIG_X86_64
@@ -28,18 +15,27 @@
 
 #ifndef __ASSEMBLY__
 
+#ifndef HAVE_JUMP_LABEL
+/*
+ * For better or for worse, if jump labels (the gcc extension) are missing,
+ * then the entire static branch patching infrastructure is compiled out.
+ * If that happens, the code in here will malfunction.  Raise a compiler
+ * error instead.
+ *
+ * In theory, jump labels and the static branch patching infrastructure
+ * could be decoupled to fix this.
+ */
+#error asm/jump_label.h included on a non-jump-label kernel
+#endif
+
 #include <linux/stringify.h>
 #include <linux/types.h>
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("1:"
-		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
-		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
-		".popsection \n\t"
-		: :  "i" (key), "i" (branch) : : l_yes);
+	asm_volatile_goto("STATIC_BRANCH_GOTO l_yes=\"%l[l_yes]\" key=\"%c0\" "
+			  "branch=\"%c1\""
+			: :  "i" (key), "i" (branch) : : l_yes);
 
 	return false;
 l_yes:
@@ -48,13 +44,8 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("1:"
-		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
-		"2:\n\t"
-		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
-		".popsection \n\t"
+	asm_volatile_goto("STATIC_BRANCH_JUMP_GOTO l_yes=\"%l[l_yes]\" key=\"%c0\" "
+			  "branch=\"%c1\""
 		: :  "i" (key), "i" (branch) : : l_yes);
 
 	return false;
@@ -108,6 +99,26 @@ struct jump_entry {
 	.popsection
 .endm
 
+.macro STATIC_BRANCH_GOTO l_yes:req key:req branch:req
+1:
+	.byte STATIC_KEY_INIT_NOP
+	.pushsection __jump_table, "aw"
+	_ASM_ALIGN
+	_ASM_PTR 1b, \l_yes, \key + \branch
+	.popsection
+.endm
+
+.macro STATIC_BRANCH_JUMP_GOTO l_yes:req key:req branch:req
+1:
+	.byte 0xe9
+	.long \l_yes - 2f
+2:
+	.pushsection __jump_table, "aw"
+	_ASM_ALIGN
+	_ASM_PTR 1b, \l_yes, \key + \branch
+	.popsection
+.endm
+
 #endif	/* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index bf8b9c93e255..161c95059044 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -13,3 +13,4 @@
 #include <asm/paravirt.h>
 #include <asm/asm.h>
 #include <asm/cpufeature.h>
+#include <asm/jump_label.h>
-- 
2.17.0
