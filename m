Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C41EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D776C20652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfAPVFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:05:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbfAPVFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:05:09 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0685920652;
        Wed, 16 Jan 2019 21:05:07 +0000 (UTC)
Date:   Wed, 16 Jan 2019 16:05:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     mingo@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/tracing: Show stacktrace for wakeup tracers
Message-ID: <20190116160506.0d56e027@gandalf.local.home>
In-Reply-To: <20190116160249.7554-1-changbin.du@gmail.com>
References: <20190116160249.7554-1-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 00:02:49 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> This align the behavior of wakeup tracers with irqsoff latency tracer
> that we record stacktrace at the beginning and end of waking up. The
> stacktrace shows us what is happening in the kernel.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

I've applied your patch, but it may be a while before you see it in
linux-next. I'll be traveling for a bit and wont be able to do the full
tests which I do before pushing to my linux-next branch.

You may see them soon in my ftrace/core branch on kernel.org.

-- Steve

> ---
>  kernel/trace/trace_sched_wakeup.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
> index da5b6e012840..f4fe7d1781e9 100644
> --- a/kernel/trace/trace_sched_wakeup.c
> +++ b/kernel/trace/trace_sched_wakeup.c
> @@ -475,6 +475,7 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
>  
>  	__trace_function(wakeup_trace, CALLER_ADDR0, CALLER_ADDR1, flags, pc);
>  	tracing_sched_switch_trace(wakeup_trace, prev, next, flags, pc);
> +	__trace_stack(wakeup_trace, flags, 0, pc);
>  
>  	T0 = data->preempt_timestamp;
>  	T1 = ftrace_now(cpu);
> @@ -586,6 +587,7 @@ probe_wakeup(void *ignore, struct task_struct *p)
>  	data = per_cpu_ptr(wakeup_trace->trace_buffer.data, wakeup_cpu);
>  	data->preempt_timestamp = ftrace_now(cpu);
>  	tracing_sched_wakeup_trace(wakeup_trace, p, current, flags, pc);
> +	__trace_stack(wakeup_trace, flags, 0, pc);
>  
>  	/*
>  	 * We must be careful in using CALLER_ADDR2. But since wake_up

