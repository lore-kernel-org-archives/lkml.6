Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22301C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B458D206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B458D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeK2Ftk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:49:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbeK2Ftk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:49:40 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65150206B2;
        Wed, 28 Nov 2018 18:47:02 +0000 (UTC)
Date:   Wed, 28 Nov 2018 13:47:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Rough idea of implementing blocking perf calls for system call
 tracepoints
Message-ID: <20181128134700.212ed035@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[
 Sorry for the late reply on this, when I got back from Plumbers, my
 work was really piled up, and then Turkey day came and just added more
 to the chaos.
]

From our discussion at the Linux Plumbers strace talk about
implementing strace with perf. As strace requires to be lossless, it
currently can not be implemented with perf because there's always a
chance to lose events. The idea here is to have a way to instrument a
way to record system calls from perf but also block when the perf ring
buffer is full.

Below is a patch I wrote that gives an idea of what needs to be done.
It is by no means a real patch (wont even compile). And I left out the
wake up part, as I'm not familiar enough with how perf works to
implement it. But hopefully someone on this list can :-)

The idea here is that we set the tracepoints sys_enter and sys_exit
with a new flag called TRACE_EVENT_FL_BLOCK. When the perf code records
the event, if the buffer is full, it will set a "perf_block" field in
the current task structure to point to the tp_event, if the tp_event
has the BLOCK flag set.

Then on the exit of the syscall tracepoints, the perf_block field is
checked, and if it is set, it knows that the event was dropped, and
will add itself to a wait queue. When the reader reads the perf buffer
and hits a water mark, it can wake whatever is on the queue (not sure
where to put this queue, but someone can figure it out).

Once woken, it will try to write to the perf system call tracepoint
again (notice that it only tries perf and doesn't call the generic
tracepoint code, as only perf requires a repeat).

This is just a basic idea patch, to hopefully give someone else an idea
of what I envision. I think it can work, and if it does, I can imagine
that it would greatly improve the performance of strace!

Thoughts?

-- Steve

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 3b2490b81918..57fe95950a24 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -123,8 +123,22 @@ static long syscall_trace_enter(struct pt_regs *regs)
 	}
 #endif
 
-	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
+	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT))) {
+		current->perf_block = NULL;
 		trace_sys_enter(regs, regs->orig_ax);
+		while (current->perf_block) {
+			DECLARE_WAITQUEUE(wait, current);
+			struct trace_event_call *tp_event = current->perf_block;
+
+			current->perf_block = NULL;
+
+			set_current_state(TASK_INTERRUPTIBLE);
+			add_wait_queue(&tp_event->block_queue, &wait);
+			perf_trace_sys_enter(tp_event, regs, regs->orig_ax);
+			if (current->perf_block)
+				schedule();
+		}
+	}
 
 	do_audit_syscall_entry(regs, arch);
 
@@ -224,8 +238,22 @@ static void syscall_slow_exit_work(struct pt_regs *regs, u32 cached_flags)
 
 	audit_syscall_exit(regs);
 
-	if (cached_flags & _TIF_SYSCALL_TRACEPOINT)
+	if (cached_flags & _TIF_SYSCALL_TRACEPOINT) {
+		current->perf_block = NULL;
 		trace_sys_exit(regs, regs->ax);
+		while (current->perf_block) {
+			DECLARE_WAITQUEUE(wait, current);
+			struct trace_event_call *tp_event = current->perf_block;
+
+			current->perf_block = NULL;
+
+			set_current_state(TASK_INTERRUPTIBLE);
+			add_wait_queue(&tp_event->block_queue, &wait);
+			perf_trace_sys_exit(tp_event, regs, regs->orig_ax);
+			if (current->perf_block)
+				schedule();
+		}
+	}
 
 	/*
 	 * If TIF_SYSCALL_EMU is set, we only get here because of
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d6183a55e8eb..39a98da0e03b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1009,6 +1009,7 @@ struct task_struct {
 	struct perf_event_context	*perf_event_ctxp[perf_nr_task_contexts];
 	struct mutex			perf_event_mutex;
 	struct list_head		perf_event_list;
+	struct trace_event_call		*perf_block;
 #endif
 #ifdef CONFIG_DEBUG_PREEMPT
 	unsigned long			preempt_disable_ip;
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 4130a5497d40..35a71f853d64 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -226,6 +226,7 @@ enum {
 	TRACE_EVENT_FL_TRACEPOINT_BIT,
 	TRACE_EVENT_FL_KPROBE_BIT,
 	TRACE_EVENT_FL_UPROBE_BIT,
+	TRACE_EVENT_FL_BLOCK_BIT,
 };
 
 /*
@@ -246,6 +247,7 @@ enum {
 	TRACE_EVENT_FL_TRACEPOINT	= (1 << TRACE_EVENT_FL_TRACEPOINT_BIT),
 	TRACE_EVENT_FL_KPROBE		= (1 << TRACE_EVENT_FL_KPROBE_BIT),
 	TRACE_EVENT_FL_UPROBE		= (1 << TRACE_EVENT_FL_UPROBE_BIT),
+	TRACE_EVENT_FL_BLOCK		= (1 << TRACE_EVENT_FL_BLOCK_BIT),
 };
 
 #define TRACE_EVENT_FL_UKPROBE (TRACE_EVENT_FL_KPROBE | TRACE_EVENT_FL_UPROBE)
diff --git a/include/trace/events/syscalls.h b/include/trace/events/syscalls.h
index 44a3259ed4a5..3fc4ecafebcf 100644
--- a/include/trace/events/syscalls.h
+++ b/include/trace/events/syscalls.h
@@ -39,7 +39,7 @@ TRACE_EVENT_FN(sys_enter,
 	syscall_regfunc, syscall_unregfunc
 );
 
-TRACE_EVENT_FLAGS(sys_enter, TRACE_EVENT_FL_CAP_ANY)
+TRACE_EVENT_FLAGS(sys_enter, TRACE_EVENT_FL_CAP_ANY | TRACE_EVENT_FL_BLOCK)
 
 TRACE_EVENT_FN(sys_exit,
 
@@ -63,7 +63,7 @@ TRACE_EVENT_FN(sys_exit,
 	syscall_regfunc, syscall_unregfunc
 );
 
-TRACE_EVENT_FLAGS(sys_exit, TRACE_EVENT_FL_CAP_ANY)
+TRACE_EVENT_FLAGS(sys_exit, TRACE_EVENT_FL_CAP_ANY | TRACE_EVENT_FL_BLOCK)
 
 #endif /* CONFIG_HAVE_SYSCALL_TRACEPOINTS */
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 84530ab358c3..64be3de9ee41 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6505,8 +6505,12 @@ __perf_event_output(struct perf_event *event,
 
 	perf_prepare_sample(&header, data, event, regs);
 
-	if (output_begin(&handle, event, header.size))
+	if (output_begin(&handle, event, header.size)) {
+		if (event->tp_event &&
+		    event->tp_event->flags & TRACE_EVENT_FL_BLOCK)
+			current->perf_block = event->tp_event;
 		goto exit;
+	}
 
 	perf_output_sample(&handle, &header, data, event);
 
