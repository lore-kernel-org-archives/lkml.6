Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbeCXQ55 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 12:57:57 -0400
Received: from orthanc.universe-factory.net ([104.238.176.138]:54052 "EHLO
        orthanc.universe-factory.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752400AbeCXQ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 12:57:56 -0400
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: ralf@linux-mips.org, rostedt@goodmis.org, mingo@redhat.com
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        mschiffer@universe-factory.net
Subject: [PATCH] mips: ftrace: fix static function graph tracing
Date: Sat, 24 Mar 2018 17:57:49 +0100
Message-Id: <7dc2bb7f712c1e3cfeaafaefe3a3f97668dee549.1521909650.git.mschiffer@universe-factory.net>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ftrace_graph_caller was never run after calling ftrace_trace_function,
breaking the function graph tracer. Fix this, bringing it in line with the
x86 implementation.

While we're at it, also streamline the control flow of _mcount a bit to
reduce the number of branches.

This issue was reported before:
https://www.linux-mips.org/archives/linux-mips/2014-11/msg00295.html

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---

Caveats: I've only tested this on 32bit; it would be great if someone with
MIPS64 hardware or a working emulator setup could give it a spin. My test
device runs on kernel 4.9.y, but I don't expect any problems applying the
fix to newer kernels, given that this code is basically unchanged since
2014.

I'm not sure what the correct Fixes: line would be. I did not bother to
bisect the issue and could not find the commit introducing it by inspecting
the log (assuming the tracer worked at some point).


 arch/mips/kernel/mcount.S | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index f2ee7e1e3342..cff52b283e03 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -119,10 +119,20 @@ NESTED(_mcount, PT_SIZE, ra)
 EXPORT_SYMBOL(_mcount)
 	PTR_LA	t1, ftrace_stub
 	PTR_L	t2, ftrace_trace_function /* Prepare t2 for (1) */
-	bne	t1, t2, static_trace
+	beq	t1, t2, fgraph_trace
 	 nop
 
+	MCOUNT_SAVE_REGS
+
+	move	a0, ra		/* arg1: self return address */
+	jalr	t2		/* (1) call *ftrace_trace_function */
+	 move	a1, AT		/* arg2: parent's return address */
+
+	MCOUNT_RESTORE_REGS
+
+fgraph_trace:
 #ifdef	CONFIG_FUNCTION_GRAPH_TRACER
+	PTR_LA	t1, ftrace_stub
 	PTR_L	t3, ftrace_graph_return
 	bne	t1, t3, ftrace_graph_caller
 	 nop
@@ -131,24 +141,11 @@ EXPORT_SYMBOL(_mcount)
 	bne	t1, t3, ftrace_graph_caller
 	 nop
 #endif
-	b	ftrace_stub
-#ifdef CONFIG_32BIT
-	 addiu sp, sp, 8
-#else
-	 nop
-#endif
 
-static_trace:
-	MCOUNT_SAVE_REGS
-
-	move	a0, ra		/* arg1: self return address */
-	jalr	t2		/* (1) call *ftrace_trace_function */
-	 move	a1, AT		/* arg2: parent's return address */
-
-	MCOUNT_RESTORE_REGS
 #ifdef CONFIG_32BIT
 	addiu sp, sp, 8
 #endif
+
 	.globl ftrace_stub
 ftrace_stub:
 	RETURN_BACK
-- 
2.16.2
