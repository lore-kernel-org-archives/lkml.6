Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD443C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902B32172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCrhZ0aE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902B32172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeHCJ1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbeHCJ1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:27:12 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC92B2170A;
        Fri,  3 Aug 2018 07:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533281532;
        bh=JyUTnRKLYs46FFbTE13GHcqilFhvX0hkHdMzcvaN5vc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eCrhZ0aEPK4w04kpE9GS8y634MveY46V2AOkKaGcDVWzmnK0yytosS6cWF7PRvujj
         xpzf261CUXRQYy/CF7yiwZuFtBN8fCW30iNXocAYCn2dUUrVk5YSwTjS5Z3h5S32L+
         mfn/EPbzDTtIl2VEuP7i1zzr1Tz/uCOg7/7X4idI=
Date:   Fri, 3 Aug 2018 16:32:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
        paulmck@linux.vnet.ibm.com, peterz@infradead.org
Subject: Re: [PATCH] trace: Use rcu_dereference_raw for hooks from
 trace-event subsystem
Message-Id: <20180803163209.20ebd9dc3f25fd9994764370@kernel.org>
In-Reply-To: <20180803023407.225852-1-joel@joelfernandes.org>
References: <20180803023407.225852-1-joel@joelfernandes.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Aug 2018 19:34:07 -0700
"Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> Since we switched to using SRCU for tracepoints used in the idle path,
> we can no longer use rcu_dereference_sched for dereferencing points in
> trace-event hooks.
> 
> Since tracepoints can now use either SRCU or sched-RCU, just use
> rcu_dereference_raw for traceevents just like we're doing when
> dereferencing the tracepoint table.

OK, I've tested that this fixes the bug.

/mnt/ftrace # ./ftracetest test.d/event/toplevel-enable.tc 
=== Ftrace unit tests ===
[1] event tracing - enable/disable with top level files	[PASS]

# of passed:  1
# of failed:  0
# of unresolved:  0
# of untested:  0
# of unsupported:  0
# of xfailed:  0
# of undefined(test bug):  0

Tested-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> This prevents an RCU warning reported by Masami:
> 
> [  282.060593] WARNING: can't dereference registers at 00000000f3c7f62b
> [  282.063200] =============================
> [  282.064082] WARNING: suspicious RCU usage
> [  282.064963] 4.18.0-rc6+ #15 Tainted: G        W        
> [  282.066048] -----------------------------
> [  282.066923] /home/mhiramat/ksrc/linux/kernel/trace/trace_events.c:242
> 				suspicious rcu_dereference_check() usage!
> [  282.068974] 
> [  282.068974] other info that might help us debug this:
> [  282.068974] 
> [  282.070770] 
> [  282.070770] RCU used illegally from idle CPU!
> [  282.070770] rcu_scheduler_active = 2, debug_locks = 1
> [  282.072938] RCU used illegally from extended quiescent state!
> [  282.074183] no locks held by swapper/0/0.
> [  282.075071] 
> [  282.075071] stack backtrace:
> [  282.076121] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
> [  282.077782] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> [  282.079604] Call Trace:
> [  282.080212]  <IRQ>
> [  282.080755]  dump_stack+0x85/0xcb
> [  282.081523]  trace_event_ignore_this_pid+0x66/0x70
> [  282.082541]  trace_event_raw_event_preemptirq_template+0xa2/0xb0
> [  282.083774]  ? interrupt_entry+0xc4/0xe0
> [  282.084665]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [  282.085669]  trace_hardirqs_off_caller+0x90/0xd0
> [  282.086597]  trace_hardirqs_off_thunk+0x1a/0x1c
> [  282.087433]  ? call_function_interrupt+0xa/0x20
> [  282.088201]  interrupt_entry+0xc4/0xe0
> [  282.088848]  ? call_function_interrupt+0xa/0x20
> [  282.089579]  </IRQ>
> [  282.090029]  ? native_safe_halt+0x2/0x10
> [  282.090695]  ? default_idle+0x1f/0x160
> [  282.091330]  ? default_idle_call+0x24/0x40
> [  282.091997]  ? do_idle+0x210/0x250
> [  282.092658]  ? cpu_startup_entry+0x6f/0x80
> [  282.093338]  ? start_kernel+0x49d/0x4bd
> [  282.093987]  ? secondary_startup_64+0xa5/0xb0
> 
> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> Fixes: e6753f23d961 ("tracepoint: Make rcuidle tracepoint callers use SRCU")
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/trace/trace_events.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 14ff4ff3caab..7b508ce8ac44 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -239,7 +239,7 @@ bool trace_event_ignore_this_pid(struct trace_event_file *trace_file)
>  	struct trace_array_cpu *data;
>  	struct trace_pid_list *pid_list;
>  
> -	pid_list = rcu_dereference_sched(tr->filtered_pids);
> +	pid_list = rcu_dereference_raw(tr->filtered_pids);
>  	if (!pid_list)
>  		return false;
>  
> @@ -512,7 +512,7 @@ event_filter_pid_sched_process_exit(void *data, struct task_struct *task)
>  	struct trace_pid_list *pid_list;
>  	struct trace_array *tr = data;
>  
> -	pid_list = rcu_dereference_sched(tr->filtered_pids);
> +	pid_list = rcu_dereference_raw(tr->filtered_pids);
>  	trace_filter_add_remove_task(pid_list, NULL, task);
>  }
>  
> -- 
> 2.18.0.597.ga71716f1ad-goog
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
