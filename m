Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1402DC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCD8213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCD8213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbeJAUzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:55:01 -0400
Received: from verein.lst.de ([213.95.11.211]:37917 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbeJAUzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:55:00 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id A856D68BC7; Mon,  1 Oct 2018 16:16:58 +0200 (CEST)
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: [PATCH v3 4/4] arm64: reliable stacktraces
In-Reply-To: <20181001140910.086E768BC7@newverein.lst.de>
References: <20181001140910.086E768BC7@newverein.lst.de>
Message-Id: <20181001141658.A856D68BC7@newverein.lst.de>
Date:   Mon,  1 Oct 2018 16:16:58 +0200 (CEST)
From:   duwe@lst.de (Torsten Duwe)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make unwind_frame() report whether it had to stop normally or due to
an error condition; walk_stackframe() will pass that info.
__save_stack_trace() is used to check the validity of a frame;
save_stack_trace_tsk_reliable() can now trivially be implemented.
Modify arch/arm64/kernel/time.c for the new semantics.

Signed-off-by: Torsten Duwe <duwe@suse.de>

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -127,8 +127,9 @@ config ARM64
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RCU_TABLE_FREE
+	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -33,7 +33,7 @@ struct stackframe {
 };
 
 extern int unwind_frame(struct task_struct *tsk, struct stackframe *frame);
-extern void walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
+extern int walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 			    int (*fn)(struct stackframe *, void *), void *data);
 extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk);
 
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -40,6 +40,13 @@
  *	ldp	x29, x30, [sp]
  *	add	sp, sp, #0x10
  */
+
+/*
+ * unwind_frame -- unwind a single stack frame.
+ * Returns 0 when there are more frames to go.
+ * 1 means reached end of stack; negative (error)
+ * means stopped because information is not reliable.
+ */
 int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 {
 	unsigned long fp = frame->fp;
@@ -81,23 +88,27 @@ int notrace unwind_frame(struct task_str
 	 * both are NULL.
 	 */
 	if (!frame->fp && !frame->pc)
-		return -EINVAL;
+		return 1;
 
 	return 0;
 }
 
-void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
+int notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 		     int (*fn)(struct stackframe *, void *), void *data)
 {
 	while (1) {
 		int ret;
 
-		if (fn(frame, data))
-			break;
+		ret = fn(frame, data);
+		if (ret)
+			return ret;
 		ret = unwind_frame(tsk, frame);
 		if (ret < 0)
+			return ret;
+		if (ret > 0)
 			break;
 	}
+	return 0;
 }
 
 #ifdef CONFIG_STACKTRACE
@@ -145,14 +156,15 @@ void save_stack_trace_regs(struct pt_reg
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 
-static noinline void __save_stack_trace(struct task_struct *tsk,
+static noinline int __save_stack_trace(struct task_struct *tsk,
 	struct stack_trace *trace, unsigned int nosched)
 {
 	struct stack_trace_data data;
 	struct stackframe frame;
+	int ret;
 
 	if (!try_get_task_stack(tsk))
-		return;
+		return -EBUSY;
 
 	data.trace = trace;
 	data.skip = trace->skip;
@@ -171,11 +183,12 @@ static noinline void __save_stack_trace(
 	frame.graph = tsk->curr_ret_stack;
 #endif
 
-	walk_stackframe(tsk, &frame, save_trace, &data);
+	ret = walk_stackframe(tsk, &frame, save_trace, &data);
 	if (trace->nr_entries < trace->max_entries)
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
 
 	put_task_stack(tsk);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
 
@@ -190,4 +203,12 @@ void save_stack_trace(struct stack_trace
 }
 
 EXPORT_SYMBOL_GPL(save_stack_trace);
+
+int save_stack_trace_tsk_reliable(struct task_struct *tsk,
+				  struct stack_trace *trace)
+{
+	return __save_stack_trace(tsk, trace, 1);
+}
+EXPORT_SYMBOL_GPL(save_stack_trace_tsk_reliable);
+
 #endif
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -56,7 +56,7 @@ unsigned long profile_pc(struct pt_regs
 #endif
 	do {
 		int ret = unwind_frame(NULL, &frame);
-		if (ret < 0)
+		if (ret)
 			return 0;
 	} while (in_lock_functions(frame.pc));
 
