Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F33C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F1C208D5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F1C208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbeHJSdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:33:31 -0400
Received: from verein.lst.de ([213.95.11.211]:48610 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729262AbeHJSdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:33:31 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id C988D68CF4; Fri, 10 Aug 2018 18:03:11 +0200 (CEST)
From:   Torsten Duwe <duwe@lst.de>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: [PATCH 3/3] arm64: reliable stacktraces
In-Reply-To: <20180810160043.9E45568C76@newverein.lst.de>
References: <20180810160043.9E45568C76@newverein.lst.de>
Message-Id: <20180810160311.C988D68CF4@newverein.lst.de>
Date:   Fri, 10 Aug 2018 18:03:11 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is more an RFC in the original sense: is this basically
the correct approach? (as I had to tweak the API a bit).

In particular the code does not detect interrupts and exception
frames, and does not yet check whether the code address is valid.
The latter check would also have to be omitted for the latest frame
on other tasks' stacks. This would require some more tweaking.

unwind_frame() now reports whether we had to stop normally or due to
an error condition; walk_stackframe() will pass that info.
__save_stack_trace() is used for a start to check the validity of a
frame; maybe save_stack_trace_tsk_reliable() will need its own callback.

Any comments welcome.

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
 
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index d5718a060672..fe0dd4745ff3 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -81,23 +81,27 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
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
@@ -145,14 +149,15 @@ void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
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
@@ -171,11 +176,12 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
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
 
@@ -190,4 +196,12 @@ void save_stack_trace(struct stack_trace *trace)
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

