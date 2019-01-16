Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6C7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F35206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbfAPDZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 22:25:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731039AbfAPDZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 22:25:04 -0500
Received: from vmware.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B383B206C2;
        Wed, 16 Jan 2019 03:25:02 +0000 (UTC)
Date:   Tue, 15 Jan 2019 22:25:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     mingo@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] sched/tracing: Show stacktrace for wakeup tracers
Message-ID: <20190115222500.6b1ca824@vmware.local.home>
In-Reply-To: <20190101154614.8887-5-changbin.du@gmail.com>
References: <20190101154614.8887-1-changbin.du@gmail.com>
        <20190101154614.8887-5-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 Jan 2019 23:46:13 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> This align the behavior of wakeup tracers with irqsoff latency tracer
> that we record stacktrace at the beginning and end of waking up. The
> stacktrace shows us what is happening in the kernel.

OK, so I've applied (locally) all of the patches in this series except
this one.

> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  kernel/trace/trace_sched_wakeup.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
> index da5b6e012840..0ec136d408ff 100644
> --- a/kernel/trace/trace_sched_wakeup.c
> +++ b/kernel/trace/trace_sched_wakeup.c
> @@ -474,6 +474,8 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
>  	data = per_cpu_ptr(wakeup_trace->trace_buffer.data, wakeup_cpu);
>  
>  	__trace_function(wakeup_trace, CALLER_ADDR0, CALLER_ADDR1, flags, pc);
> +	/* Skip 2 functions to get to the task switch function */
> +	__trace_stack(wakeup_trace, flags, 2, pc);

1) Just put in zero for skip. I found that with all the new updates to
the unwinders, you can never get this number right :-(, as well as with
gcc playing games, and retpolines and all that jazz.

>  	tracing_sched_switch_trace(wakeup_trace, prev, next, flags, pc);

2) Have the stack trace go after the sched_switch trace, otherwise it
looks funny:

      285 us |   5)    <idle>-0    |  dN.2 |   1.632 us    |    }
      286 us |   5)    <idle>-0    |  d..3 |   0.000 us    |  __schedule();
  <idle>-0       5d..3  299us : <stack trace>
 => schedule_idle
 => do_idle
 => cpu_startup_entry
 => start_secondary
 => secondary_startup_64
      299 us |   5)    <idle>-0    |  d..3 |               |  /*      0:120:R ==> [005]   811: 98:R i915/signal:0 */

Note, I removed the skip and moved the trace and it looks like this:

      180 us |   3)    <idle>-0    |  dN.2 |   0.944 us    |    }
      181 us |   3)    <idle>-0    |  d..3 |   0.000 us    |  __schedule();
      181 us |   3)    <idle>-0    |  d..3 |               |  /*      0:120:R ==> [003]    25:  0:R migration/3 */
  <idle>-0       3d..3  195us : <stack trace>
 => probe_wakeup_sched_switch
 => __schedule
 => schedule_idle
 => do_idle
 => cpu_startup_entry
 => start_secondary
 => secondary_startup_64

Yeah, it shows the "probe_wakeup_sched" but its better to show too much
than not enough. I've had a hard time debugging some kernels because
the skip was too high.

Please resend this patch with the above updates. Just this patch.

Thanks!

-- Steve

>  
>  	T0 = data->preempt_timestamp;
> @@ -593,6 +595,8 @@ probe_wakeup(void *ignore, struct task_struct *p)
>  	 * it should be safe to use it here.
>  	 */
>  	__trace_function(wakeup_trace, CALLER_ADDR1, CALLER_ADDR2, flags, pc);
> +	/* Skip 2 functions to get to the task wakeup function */
> +	__trace_stack(wakeup_trace, flags, 2, pc);
>  
>  out_locked:
>  	arch_spin_unlock(&wakeup_lock);

