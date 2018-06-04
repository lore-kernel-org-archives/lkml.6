Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbeFDShh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:37:37 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:51805 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750999AbeFDSg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:36:29 -0400
From: Nadav Amit <namit@vmware.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2 4/9] x86: alternatives: macrofy locks for better inlining
Date: Mon, 4 Jun 2018 04:21:26 -0700
Message-ID: <20180604112131.59100-5-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180604112131.59100-1-namit@vmware.com>
References: <20180604112131.59100-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC considers the number of statements in inlined assembly blocks,
according to new-lines and semicolons, as an indication to the cost of
the block in time and space. This data is distorted by the kernel code,
which puts information in alternative sections. As a result, the
compiler may perform incorrect inlining and branch optimizations.

The solution is to set an assembly macro and call it from the inlined
assembly block. As a result GCC considers the inline assembly block as
a single instruction.

This patch handles the LOCK prefix, allowing more aggresive inlining.

   text	   data	    bss	    dec	    hex	filename
18140140 10225284 2957312 31322736 1ddf270 ./vmlinux before
18146889 10225380 2957312 31329581 1de0d2d ./vmlinux after (+6845)

Static text symbols:
Before:	40286
After:	40218	(-68)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/alternative-asm.h | 20 ++++++++++++++------
 arch/x86/include/asm/alternative.h     | 16 ++--------------
 arch/x86/kernel/macros.S               |  1 +
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/alternative-asm.h b/arch/x86/include/asm/alternative-asm.h
index 31b627b43a8e..8e4ea39e55d0 100644
--- a/arch/x86/include/asm/alternative-asm.h
+++ b/arch/x86/include/asm/alternative-asm.h
@@ -7,16 +7,24 @@
 #include <asm/asm.h>
 
 #ifdef CONFIG_SMP
-	.macro LOCK_PREFIX
-672:	lock
+.macro LOCK_PREFIX_HERE
 	.pushsection .smp_locks,"a"
 	.balign 4
-	.long 672b - .
+	.long 671f - .		# offset
 	.popsection
-	.endm
+671:
+.endm
+
+.macro LOCK_PREFIX insn:vararg
+	LOCK_PREFIX_HERE
+	lock \insn
+.endm
 #else
-	.macro LOCK_PREFIX
-	.endm
+.macro LOCK_PREFIX_HERE
+.endm
+
+.macro LOCK_PREFIX insn:vararg
+.endm
 #endif
 
 /*
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 4cd6a3b71824..c1a3d7c76151 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -30,20 +30,8 @@
  * and size information.  That keeps the table sizes small.
  */
 
-#ifdef CONFIG_SMP
-#define LOCK_PREFIX_HERE \
-		".pushsection .smp_locks,\"a\"\n"	\
-		".balign 4\n"				\
-		".long 671f - .\n" /* offset */		\
-		".popsection\n"				\
-		"671:"
-
-#define LOCK_PREFIX LOCK_PREFIX_HERE "\n\tlock; "
-
-#else /* ! CONFIG_SMP */
-#define LOCK_PREFIX_HERE ""
-#define LOCK_PREFIX ""
-#endif
+#define LOCK_PREFIX_HERE "LOCK_PREFIX_HERE\n\t"
+#define LOCK_PREFIX "LOCK_PREFIX "
 
 struct alt_instr {
 	s32 instr_offset;	/* original instruction */
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index f1fe1d570365..852487a9fc56 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -8,3 +8,4 @@
 
 #include <linux/compiler.h>
 #include <asm/refcount.h>
+#include <asm/alternative-asm.h>
-- 
2.17.0
