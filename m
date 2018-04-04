Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeDDUqg convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 16:46:36 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:51860 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751754AbeDDUqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 16:46:35 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: linux-kernel@vger.kernel.org
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20180330150132.16903-1-chris@chris-wilson.co.uk>
Cc: intel-gfx@lists.freedesktop.org,
        "Steven Rostedt" <rostedt@goodmis.org>
References: <20180330150132.16903-1-chris@chris-wilson.co.uk>
Message-ID: <152287477878.1494.3258504745278636088@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [PATCH v2 1/2] trace: Default to using trace_global_clock if sched_clock
 is unstable
Date: Wed, 04 Apr 2018 21:46:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wilson (2018-03-30 16:01:31)
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
> 
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> v2: Tell the user what's happening and what they can do to correct it.
> ---
>  kernel/trace/trace.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 13baf85b27d8..7c155fa879e1 100644
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
> @@ -8505,3 +8506,21 @@ __init static int clear_boot_tracer(void)
>  
>  fs_initcall(tracer_init_tracefs);
>  late_initcall_sync(clear_boot_tracer);
> +
> +#ifdef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
> +__init static int tracing_set_default_clock(void)
> +{
> +       /* sched_clock_stable() is determined in late_initcall */
> +       if (trace_boot_clock || sched_clock_stable()) {

Oh flip, I reversed the logic from v1.

I was going to do an early return:

	if (trace_boot_clock || sched_clock_stable())
		return;

to shift the message to the left slightly, at left it half way.

(I was wondering why CI didn't show the same results as v1!)
-Chris
