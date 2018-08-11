Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C162C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF38E217AE
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF38E217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbeHKQYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:24:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbeHKQYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:24:32 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1E9E21A2B;
        Sat, 11 Aug 2018 13:50:16 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1foUHX-0006Di-Qs; Sat, 11 Aug 2018 09:50:15 -0400
Message-Id: <20180811135015.738126021@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 11 Aug 2018 09:49:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [for-next][PATCH 26/34] trace: Use rcu_dereference_raw for hooks from trace-event subsystem
References: <20180811134928.034373761@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Since we switched to using SRCU for tracepoints used in the idle path,
we can no longer use rcu_dereference_sched for dereferencing points in
trace-event hooks.

Since tracepoints can now use either SRCU or sched-RCU, just use
rcu_dereference_raw for traceevents just like we're doing when
dereferencing the tracepoint table.

This prevents an RCU warning reported by Masami:

[  282.060593] WARNING: can't dereference registers at 00000000f3c7f62b
[  282.063200] =============================
[  282.064082] WARNING: suspicious RCU usage
[  282.064963] 4.18.0-rc6+ #15 Tainted: G        W
[  282.066048] -----------------------------
[  282.066923] /home/mhiramat/ksrc/linux/kernel/trace/trace_events.c:242
				suspicious rcu_dereference_check() usage!
[  282.068974]
[  282.068974] other info that might help us debug this:
[  282.068974]
[  282.070770]
[  282.070770] RCU used illegally from idle CPU!
[  282.070770] rcu_scheduler_active = 2, debug_locks = 1
[  282.072938] RCU used illegally from extended quiescent state!
[  282.074183] no locks held by swapper/0/0.
[  282.075071]
[  282.075071] stack backtrace:
[  282.076121] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
[  282.077782] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
[  282.079604] Call Trace:
[  282.080212]  <IRQ>
[  282.080755]  dump_stack+0x85/0xcb
[  282.081523]  trace_event_ignore_this_pid+0x66/0x70
[  282.082541]  trace_event_raw_event_preemptirq_template+0xa2/0xb0
[  282.083774]  ? interrupt_entry+0xc4/0xe0
[  282.084665]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  282.085669]  trace_hardirqs_off_caller+0x90/0xd0
[  282.086597]  trace_hardirqs_off_thunk+0x1a/0x1c
[  282.087433]  ? call_function_interrupt+0xa/0x20
[  282.088201]  interrupt_entry+0xc4/0xe0
[  282.088848]  ? call_function_interrupt+0xa/0x20
[  282.089579]  </IRQ>
[  282.090029]  ? native_safe_halt+0x2/0x10
[  282.090695]  ? default_idle+0x1f/0x160
[  282.091330]  ? default_idle_call+0x24/0x40
[  282.091997]  ? do_idle+0x210/0x250
[  282.092658]  ? cpu_startup_entry+0x6f/0x80
[  282.093338]  ? start_kernel+0x49d/0x4bd
[  282.093987]  ? secondary_startup_64+0xa5/0xb0

Link: http://lkml.kernel.org/r/20180803023407.225852-1-joel@joelfernandes.org

Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: e6753f23d961 ("tracepoint: Make rcuidle tracepoint callers use SRCU")
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 14ff4ff3caab..7b508ce8ac44 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -239,7 +239,7 @@ bool trace_event_ignore_this_pid(struct trace_event_file *trace_file)
 	struct trace_array_cpu *data;
 	struct trace_pid_list *pid_list;
 
-	pid_list = rcu_dereference_sched(tr->filtered_pids);
+	pid_list = rcu_dereference_raw(tr->filtered_pids);
 	if (!pid_list)
 		return false;
 
@@ -512,7 +512,7 @@ event_filter_pid_sched_process_exit(void *data, struct task_struct *task)
 	struct trace_pid_list *pid_list;
 	struct trace_array *tr = data;
 
-	pid_list = rcu_dereference_sched(tr->filtered_pids);
+	pid_list = rcu_dereference_raw(tr->filtered_pids);
 	trace_filter_add_remove_task(pid_list, NULL, task);
 }
 
-- 
2.18.0


