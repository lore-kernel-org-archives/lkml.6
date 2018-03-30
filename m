Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeC3Nst (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 09:48:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbeC3Nss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 09:48:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D17D217A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 30 Mar 2018 09:48:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] trace: Default to using trace_global_clock if
 sched_clock is unstable
Message-ID: <20180330094845.068a9a81@gandalf.local.home>
In-Reply-To: <20180329222557.6274-1-chris@chris-wilson.co.uk>
References: <20180329222557.6274-1-chris@chris-wilson.co.uk>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2018 23:25:57 +0100
Chris Wilson <chris@chris-wilson.co.uk> wrote:

> Across suspend, we may see a very large drift in timestamps if the sched
> clock is unstable, prompting the global trace's ringbuffer code to warn
> and suggest switching to the global clock. Preempt this request by
> detecting when the sched clock is unstable (determined during
> late_initcall) and automatically switching the default clock over to
> trace_global_clock.
> 
> This should prevent requiring user interaction to resolve warnings such
> as:
> 
>     Delta way too big! 18446743856563626466 ts=18446744054496180323 write stamp = 197932553857
>     If you just came from a suspend/resume,
>     please switch to the trace global clock:
>     echo global > /sys/kernel/debug/tracing/trace_clock

global clock has a much higher overhead than the local clock. I rather
not have it automatically switch even when there's no stable TSC. That
will be annoying to myself as I have boxes that this would switch on
and I prefer to keep the local clock.

One can also decide the clock with the kernel command line. Should we
update that message to also say:

  Or set the global clock via the kernel command line with
  "trace_clock=global"

?

-- Steve


> 
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 13baf85b27d8..c5462513db90 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -41,6 +41,7 @@
>  #include <linux/nmi.h>
>  #include <linux/fs.h>
>  #include <linux/trace.h>
> +#include <linux/sched/clock.h>
>  #include <linux/sched/rt.h>
>  
>  #include "trace.h"
> @@ -8505,3 +8506,15 @@ __init static int clear_boot_tracer(void)
>  
>  fs_initcall(tracer_init_tracefs);
>  late_initcall_sync(clear_boot_tracer);
> +
> +#ifdef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
> +__init static int tracing_set_default_clock(void)
> +{
> +	/* sched_clock_stable() is determined in late_initcall */
> +	if (!trace_boot_clock && !sched_clock_stable())
> +		tracing_set_clock(&global_trace, "global");
> +
> +	return 0;
> +}
> +late_initcall_sync(tracing_set_default_clock);
> +#endif
