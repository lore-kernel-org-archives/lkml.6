Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeEQX3q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 19:29:46 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:31398 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751986AbeEQX2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 19:28:42 -0400
From: Nadav Amit <namit@vmware.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <nadav.amit@gmail.com>, Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 3/6] x86: alternative: macrofy locks for better inlining
Date: Thu, 17 May 2018 09:13:59 -0700
Message-ID: <20180517161402.78089-4-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517161402.78089-1-namit@vmware.com>
References: <20180517161402.78089-1-namit@vmware.com>
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
18127205 10068388 2936832 31132425 1db0b09 ./vmlinux before
18131468 10068488 2936832 31136788 1db1c14 ./vmlinux after (+4363)

Static text symbols:
Before:	39860
After:	39788	(-72)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/alternative.h | 34 +++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 4cd6a3b71824..1dc47c9fd480 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -28,17 +28,35 @@
  * The very common lock prefix is handled as special case in a
  * separate table which is a pure address list without replacement ptr
  * and size information.  That keeps the table sizes small.
+ *
+ * Saving the lock data is encapsulated within an assembly macro, which is then
+ * called on each use. This hack is necessary to prevent GCC from considering
+ * the inline assembly blocks as costly in time and space, which can prevent
+ * function inlining and lead to other bad compilation decisions. GCC computes
+ * inline assembly cost according to the number of perceived number of assembly
+ * instruction, based on the number of new-lines and semicolons in the assembly
+ * block. The macro will eventually be compiled into a single instruction (and
+ * some data). This scheme allows GCC to better understand the inline asm cost.
  */
 
 #ifdef CONFIG_SMP
-#define LOCK_PREFIX_HERE \
-		".pushsection .smp_locks,\"a\"\n"	\
-		".balign 4\n"				\
-		".long 671f - .\n" /* offset */		\
-		".popsection\n"				\
-		"671:"
-
-#define LOCK_PREFIX LOCK_PREFIX_HERE "\n\tlock; "
+
+asm(".macro __LOCK_PREFIX_HERE\n\t"
+    ".pushsection .smp_locks,\"a\"\n\t"
+    ".balign 4\n\t"
+    ".long 671f - .\n\t" /* offset */
+    ".popsection\n"
+    "671:\n\t"
+    ".endm");
+
+#define LOCK_PREFIX_HERE "__LOCK_PREFIX_HERE\n\t"
+
+asm(".macro __LOCK_PREFIX ins:vararg\n\t"
+    "__LOCK_PREFIX_HERE\n\t"
+    "lock; \\ins\n\t"
+    ".endm");
+
+#define LOCK_PREFIX "__LOCK_PREFIX "
 
 #else /* ! CONFIG_SMP */
 #define LOCK_PREFIX_HERE ""
-- 
2.17.0
