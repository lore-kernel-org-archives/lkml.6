Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8889C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571422146D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544025920;
	bh=tR4lbvGi59ejM0LjJyN3bdOkJJ36WzkfLAIgovcTvdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x6mg+JlSmN4y2a8QM98ZCVV6MWBrt6k0ZH7y4uLvZPILV85a9gX0YjH0WzxFBszda
	 Mntom5ZUfwLYOLa7ZF2rx6WuQXAvuUdWnxAzztR5QVT5gMmTgGcFO4XGvdGxG6qtM5
	 AgTMeeBW+tgYCgHYMhLqaDRSekafIN7/kr/AsGJY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571422146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbeLEQFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:05:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbeLEQFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:05:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5297A3078A20;
        Wed,  5 Dec 2018 16:05:16 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64FB25C5FE;
        Wed,  5 Dec 2018 16:05:13 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Date:   Wed,  5 Dec 2018 17:05:02 +0100
Message-Id: <20181205160509.1168-2-jolsa@kernel.org>
In-Reply-To: <20181205160509.1168-1-jolsa@kernel.org>
References: <20181205160509.1168-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 05 Dec 2018 16:05:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support to specify 'block' bool in struct perf_event_attr
for syscalls tracepoints, allowing the event to block the process,
if there's no space in the ring buffer.

The blocking code will poll/periodically check for the space and
continue if the event was successfully written.

It's allowed only for syscall tracepoint events attached to
process. Following syscall events are supported:

  raw_syscalls:sys_enter
  raw_syscalls:sys_exit
  syscalls:sys_enter_accept
  syscalls:sys_enter_accept4
  syscalls:sys_enter_access
  syscalls:sys_enter_acct
  syscalls:sys_enter_add_key
  ...

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/n/tip-ocz7zwwkkx11v0mkxrtcddih@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/entry/common.c         | 36 +++++++++++++++++++++++++++--
 include/linux/perf_event.h      |  2 ++
 include/linux/sched.h           |  2 ++
 include/linux/syscalls.h        |  2 ++
 include/uapi/linux/perf_event.h |  3 ++-
 kernel/events/core.c            | 40 +++++++++++++++++++++++++++++++--
 kernel/events/ring_buffer.c     |  4 +++-
 kernel/trace/trace_event_perf.c |  4 ++++
 kernel/trace/trace_syscalls.c   | 28 +++++++++++++++++++----
 9 files changed, 111 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 3b2490b81918..e55cf9169a03 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -60,6 +60,32 @@ static void do_audit_syscall_entry(struct pt_regs *regs, u32 arch)
 	}
 }
 
+static void trace_block_syscall(struct pt_regs *regs, bool enter)
+{
+	current->perf_blocked = true;
+
+	do {
+		schedule_timeout(100 * HZ);
+		current->perf_blocked_cnt = 0;
+
+		if (enter) {
+			/* perf syscalls:* enter */
+			perf_trace_syscall_enter(regs);
+
+			/* perf raw_syscalls:* enter */
+			perf_trace_sys_enter(&event_sys_enter, regs, regs->orig_ax);
+		} else {
+			/* perf syscalls:* enter */
+			perf_trace_syscall_exit(regs);
+
+			/* perf raw_syscalls:* enter */
+			perf_trace_sys_exit(&event_sys_exit, regs, regs->ax);
+		}
+	} while (current->perf_blocked_cnt);
+
+	current->perf_blocked = false;
+}
+
 /*
  * Returns the syscall nr to run (which should match regs->orig_ax) or -1
  * to skip the syscall.
@@ -123,8 +149,11 @@ static long syscall_trace_enter(struct pt_regs *regs)
 	}
 #endif
 
-	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
+	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT))) {
 		trace_sys_enter(regs, regs->orig_ax);
+		if (current->perf_blocked_cnt)
+			trace_block_syscall(regs, true);
+	}
 
 	do_audit_syscall_entry(regs, arch);
 
@@ -224,8 +253,11 @@ static void syscall_slow_exit_work(struct pt_regs *regs, u32 cached_flags)
 
 	audit_syscall_exit(regs);
 
-	if (cached_flags & _TIF_SYSCALL_TRACEPOINT)
+	if (cached_flags & _TIF_SYSCALL_TRACEPOINT) {
 		trace_sys_exit(regs, regs->ax);
+		if (current->perf_blocked_cnt)
+			trace_block_syscall(regs, false);
+	}
 
 	/*
 	 * If TIF_SYSCALL_EMU is set, we only get here because of
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 47a31d01df5a..904b7245357a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -695,6 +695,8 @@ struct perf_event {
 #endif
 
 	struct list_head		sb_list;
+
+	bool				blocked;
 #endif /* CONFIG_PERF_EVENTS */
 };
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a51c13c2b1a0..aea741ef29ae 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1009,6 +1009,8 @@ struct task_struct {
 	struct perf_event_context	*perf_event_ctxp[perf_nr_task_contexts];
 	struct mutex			perf_event_mutex;
 	struct list_head		perf_event_list;
+	bool				perf_blocked;
+	unsigned int			perf_blocked_cnt;
 #endif
 #ifdef CONFIG_DEBUG_PREEMPT
 	unsigned long			preempt_disable_ip;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2ac3d13a915b..3c8012ca9aa3 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1296,4 +1296,6 @@ static inline unsigned int ksys_personality(unsigned int personality)
 	return old;
 }
 
+void perf_trace_syscall_enter(struct pt_regs *regs);
+void perf_trace_syscall_exit(struct pt_regs *regs);
 #endif
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 9de8780ac8d9..92bae4cf279c 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -372,7 +372,8 @@ struct perf_event_attr {
 				context_switch :  1, /* context switch data */
 				write_backward :  1, /* Write ring buffer from end to beginning */
 				namespaces     :  1, /* include namespaces data */
-				__reserved_1   : 35;
+				block          :  1, /* block process if there's no space in RB (syscall tracepoints only) */
+				__reserved_1   : 34;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7403a27363f8..8955c3ebbb58 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6489,6 +6489,23 @@ void perf_prepare_sample(struct perf_event_header *header,
 		data->phys_addr = perf_virt_to_phys(data->addr);
 }
 
+static bool perf_event_is_blocked(struct perf_event *event)
+{
+	bool blocked = event->attr.block && event->blocked;
+
+	if (blocked)
+		event->blocked = false;
+	return blocked;
+}
+
+static void perf_event_set_blocked(struct perf_event *event)
+{
+	if (event->attr.block) {
+		current->perf_blocked_cnt++;
+		event->blocked = true;
+	}
+}
+
 static __always_inline void
 __perf_event_output(struct perf_event *event,
 		    struct perf_sample_data *data,
@@ -6505,8 +6522,10 @@ __perf_event_output(struct perf_event *event,
 
 	perf_prepare_sample(&header, data, event, regs);
 
-	if (output_begin(&handle, event, header.size))
+	if (output_begin(&handle, event, header.size)) {
+		perf_event_set_blocked(event);
 		goto exit;
+	}
 
 	perf_output_sample(&handle, &header, data, event);
 
@@ -8264,7 +8283,7 @@ void perf_trace_run_bpf_submit(void *raw_data, int size, int rctx,
 			       struct pt_regs *regs, struct hlist_head *head,
 			       struct task_struct *task)
 {
-	if (bpf_prog_array_valid(call)) {
+	if (!current->perf_blocked && bpf_prog_array_valid(call)) {
 		*(struct pt_regs **)raw_data = regs;
 		if (!trace_call_bpf(call, raw_data) || hlist_empty(head)) {
 			perf_swevent_put_recursion_context(rctx);
@@ -8296,6 +8315,8 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 	perf_trace_buf_update(record, event_type);
 
 	hlist_for_each_entry_rcu(event, head, hlist_entry) {
+		if (current->perf_blocked && !perf_event_is_blocked(event))
+			continue;
 		if (perf_tp_event_match(event, &data, regs))
 			perf_swevent_event(event, count, &data, regs);
 	}
@@ -8314,6 +8335,8 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 			goto unlock;
 
 		list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
+			if (current->perf_blocked && !perf_event_is_blocked(event))
+				continue;
 			if (event->cpu != smp_processor_id())
 				continue;
 			if (event->attr.type != PERF_TYPE_TRACEPOINT)
@@ -10461,6 +10484,19 @@ SYSCALL_DEFINE5(perf_event_open,
 			return -EINVAL;
 	}
 
+	if (attr.block) {
+		/*
+		 * Allow only syscall tracepoints, check for syscall class
+		 * is made in the tracepoint event_init callback.
+		 */
+		if (attr.type != PERF_TYPE_TRACEPOINT)
+			return -EINVAL;
+
+		/* Allow to block only if we attach to a process. */
+		if (pid == -1)
+			return -EINVAL;
+	}
+
 	/* Only privileged users can get physical addresses */
 	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
 	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 4a9937076331..d28849365431 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -223,7 +223,9 @@ __perf_output_begin(struct perf_output_handle *handle,
 	return 0;
 
 fail:
-	local_inc(&rb->lost);
+	/* Do not count lost if we are going to block and try again. */
+	if (!event->attr.block)
+		local_inc(&rb->lost);
 	perf_output_put_handle(handle);
 out:
 	rcu_read_unlock();
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 76217bbef815..1efbb819539d 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -8,6 +8,7 @@
 
 #include <linux/module.h>
 #include <linux/kprobes.h>
+#include <linux/syscalls.h>
 #include "trace.h"
 #include "trace_probe.h"
 
@@ -85,6 +86,9 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
 	if (perf_paranoid_tracepoint_raw() && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (p_event->attr.block && !is_syscall_trace_event(tp_event))
+		return -EINVAL;
+
 	return 0;
 }
 
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index f93a56d2db27..a8fd7a81361e 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -578,7 +578,7 @@ static int perf_call_bpf_enter(struct trace_event_call *call, struct pt_regs *re
 	return trace_call_bpf(call, &param);
 }
 
-static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
+static void __perf_syscall_enter(struct pt_regs *regs, long id)
 {
 	struct syscall_metadata *sys_data;
 	struct syscall_trace_enter *rec;
@@ -616,7 +616,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	syscall_get_arguments(current, regs, 0, sys_data->nb_args,
 			       (unsigned long *)&rec->args);
 
-	if ((valid_prog_array &&
+	if ((!current->perf_blocked && valid_prog_array &&
 	     !perf_call_bpf_enter(sys_data->enter_event, regs, sys_data, rec)) ||
 	    hlist_empty(head)) {
 		perf_swevent_put_recursion_context(rctx);
@@ -628,6 +628,16 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 			      head, NULL);
 }
 
+static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
+{
+	__perf_syscall_enter(regs, id);
+}
+
+void perf_trace_syscall_enter(struct pt_regs *regs)
+{
+	__perf_syscall_enter(regs, regs->orig_ax);
+}
+
 static int perf_sysenter_enable(struct trace_event_call *call)
 {
 	int ret = 0;
@@ -677,7 +687,7 @@ static int perf_call_bpf_exit(struct trace_event_call *call, struct pt_regs *reg
 	return trace_call_bpf(call, &param);
 }
 
-static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
+static void __perf_syscall_exit(struct pt_regs *regs, long ret)
 {
 	struct syscall_metadata *sys_data;
 	struct syscall_trace_exit *rec;
@@ -713,7 +723,7 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 	rec->nr = syscall_nr;
 	rec->ret = syscall_get_return_value(current, regs);
 
-	if ((valid_prog_array &&
+	if ((!current->perf_blocked && valid_prog_array &&
 	     !perf_call_bpf_exit(sys_data->exit_event, regs, rec)) ||
 	    hlist_empty(head)) {
 		perf_swevent_put_recursion_context(rctx);
@@ -724,6 +734,16 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 			      1, regs, head, NULL);
 }
 
+static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
+{
+	__perf_syscall_exit(regs, ret);
+}
+
+void perf_trace_syscall_exit(struct pt_regs *regs)
+{
+	__perf_syscall_exit(regs, regs->ax);
+}
+
 static int perf_sysexit_enable(struct trace_event_call *call)
 {
 	int ret = 0;
-- 
2.17.2

