Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeEOV0O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:26:14 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:48538 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752226AbeEOV0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:26:11 -0400
From: Nadav Amit <namit@vmware.com>
To: <linux-kernel@vger.kernel.org>
CC: <nadav.amit@gmail.com>, Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC 3/8] x86: alternative: macrofy locks for better inlining
Date: Tue, 15 May 2018 07:11:10 -0700
Message-ID: <20180515141124.84254-4-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515141124.84254-1-namit@vmware.com>
References: <20180515141124.84254-1-namit@vmware.com>
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
 arch/x86/include/asm/alternative.h | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 4cd6a3b71824..daa68ad51665 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -31,14 +31,26 @@
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
+asm ("\n"
+	".macro __LOCK_PREFIX_HERE\n\t"
+	".pushsection .smp_locks,\"a\"\n\t"
+	".balign 4\n\t"
+	".long 671f - .\n\t" /* offset */
+	".popsection\n"
+	"671:\n"
+	".endm");
+
+#define LOCK_PREFIX_HERE "__LOCK_PREFIX_HERE"
+
+asm ("\n"
+	".macro __LOCK_PREFIX ins:vararg\n\t"
+	"__LOCK_PREFIX_HERE\n\t"
+	"lock; \\ins\n"
+	".endm");
+
+#define LOCK_PREFIX "__LOCK_PREFIX "
+
 
 #else /* ! CONFIG_SMP */
 #define LOCK_PREFIX_HERE ""
-- 
2.17.0
