Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10427C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D136721920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391342AbeLUR6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:58:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390986AbeLUR46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:56:58 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7F5421974;
        Fri, 21 Dec 2018 17:56:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gaP2e-0002Ia-0L; Fri, 21 Dec 2018 12:56:56 -0500
Message-Id: <20181221175655.883112589@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Dec 2018 12:56:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [for-next][PATCH 04/24] x86/ftrace: Do not call function graph from dynamic trampolines
References: <20181221175618.968519903@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Since commit 79922b8009c07 ("ftrace: Optimize function graph to be
called directly"), dynamic trampolines should not be calling the
function graph tracer at the end. If they do, it could cause the function
graph tracer to trace functions that it filtered out.

Right now it does not cause a problem because there's a test to check if
the function graph tracer is attached to the same function as the
function tracer, which for now is true. But the function graph tracer is
undergoing changes that can make this no longer true which will cause
the function graph tracer to trace other functions.

 For example:

 # cd /sys/kernel/tracing/
 # echo do_IRQ > set_ftrace_filter
 # mkdir instances/foo
 # echo ip_rcv > instances/foo/set_ftrace_filter
 # echo function_graph > current_tracer
 # echo function > instances/foo/current_tracer

Would cause the function graph tracer to trace both do_IRQ and ip_rcv,
if the current tests change.

As the current tests prevent this from being a problem, this code does
not need to be backported. But it does make the code cleaner.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/kernel/ftrace.c    | 41 ++++++++++++++++++++-----------------
 arch/x86/kernel/ftrace_64.S |  8 ++++----
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 7ee8067cbf45..8257a59704ae 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -733,18 +733,20 @@ union ftrace_op_code_union {
 	} __attribute__((packed));
 };
 
+#define RET_SIZE		1
+
 static unsigned long
 create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 {
-	unsigned const char *jmp;
 	unsigned long start_offset;
 	unsigned long end_offset;
 	unsigned long op_offset;
 	unsigned long offset;
 	unsigned long size;
-	unsigned long ip;
+	unsigned long retq;
 	unsigned long *ptr;
 	void *trampoline;
+	void *ip;
 	/* 48 8b 15 <offset> is movq <offset>(%rip), %rdx */
 	unsigned const char op_ref[] = { 0x48, 0x8b, 0x15 };
 	union ftrace_op_code_union op_ptr;
@@ -764,27 +766,27 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 
 	/*
 	 * Allocate enough size to store the ftrace_caller code,
-	 * the jmp to ftrace_epilogue, as well as the address of
-	 * the ftrace_ops this trampoline is used for.
+	 * the iret , as well as the address of the ftrace_ops this
+	 * trampoline is used for.
 	 */
-	trampoline = alloc_tramp(size + MCOUNT_INSN_SIZE + sizeof(void *));
+	trampoline = alloc_tramp(size + RET_SIZE + sizeof(void *));
 	if (!trampoline)
 		return 0;
 
-	*tramp_size = size + MCOUNT_INSN_SIZE + sizeof(void *);
+	*tramp_size = size + RET_SIZE + sizeof(void *);
 
 	/* Copy ftrace_caller onto the trampoline memory */
 	ret = probe_kernel_read(trampoline, (void *)start_offset, size);
-	if (WARN_ON(ret < 0)) {
-		tramp_free(trampoline, *tramp_size);
-		return 0;
-	}
+	if (WARN_ON(ret < 0))
+		goto fail;
 
-	ip = (unsigned long)trampoline + size;
+	ip = trampoline + size;
 
-	/* The trampoline ends with a jmp to ftrace_epilogue */
-	jmp = ftrace_jmp_replace(ip, (unsigned long)ftrace_epilogue);
-	memcpy(trampoline + size, jmp, MCOUNT_INSN_SIZE);
+	/* The trampoline ends with ret(q) */
+	retq = (unsigned long)ftrace_stub;
+	ret = probe_kernel_read(ip, (void *)retq, RET_SIZE);
+	if (WARN_ON(ret < 0))
+		goto fail;
 
 	/*
 	 * The address of the ftrace_ops that is used for this trampoline
@@ -794,17 +796,15 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	 * the global function_trace_op variable.
 	 */
 
-	ptr = (unsigned long *)(trampoline + size + MCOUNT_INSN_SIZE);
+	ptr = (unsigned long *)(trampoline + size + RET_SIZE);
 	*ptr = (unsigned long)ops;
 
 	op_offset -= start_offset;
 	memcpy(&op_ptr, trampoline + op_offset, OP_REF_SIZE);
 
 	/* Are we pointing to the reference? */
-	if (WARN_ON(memcmp(op_ptr.op, op_ref, 3) != 0)) {
-		tramp_free(trampoline, *tramp_size);
-		return 0;
-	}
+	if (WARN_ON(memcmp(op_ptr.op, op_ref, 3) != 0))
+		goto fail;
 
 	/* Load the contents of ptr into the callback parameter */
 	offset = (unsigned long)ptr;
@@ -819,6 +819,9 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
 
 	return (unsigned long)trampoline;
+fail:
+	tramp_free(trampoline, *tramp_size);
+	return 0;
 }
 
 static unsigned long calc_trampoline_call_offset(bool save_regs)
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 91b2cff4b79a..75f2b36b41a6 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -171,9 +171,6 @@ GLOBAL(ftrace_call)
 	restore_mcount_regs
 
 	/*
-	 * The copied trampoline must call ftrace_epilogue as it
-	 * still may need to call the function graph tracer.
-	 *
 	 * The code up to this label is copied into trampolines so
 	 * think twice before adding any new code or changing the
 	 * layout here.
@@ -185,7 +182,10 @@ GLOBAL(ftrace_graph_call)
 	jmp ftrace_stub
 #endif
 
-/* This is weak to keep gas from relaxing the jumps */
+/*
+ * This is weak to keep gas from relaxing the jumps.
+ * It is also used to copy the retq for trampolines.
+ */
 WEAK(ftrace_stub)
 	retq
 ENDPROC(ftrace_caller)
-- 
2.19.2


