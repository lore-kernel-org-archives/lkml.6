Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbeCLNKi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:10:38 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:39698 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeCLNKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:10:37 -0400
X-Google-Smtp-Source: AG47ELtxeYPMrSQQwamnws4eLmMSumS5HGCsDHzgYlfBIjD6BgP0YgXGvpe4RDUf6Uh1cBnTfpLqL4i7uuvCgMqNjbI=
MIME-Version: 1.0
In-Reply-To: <20180312122437.GE4043@hirez.programming.kicks-ass.net>
References: <20180306093637.28247-1-linxiulei@gmail.com> <20180306115010.GC25201@hirez.programming.kicks-ass.net>
 <CALPjY3n+_uRQ70ZWan8zY+JwgzyUYoEwngna1EnGgLMtm1iuKA@mail.gmail.com> <20180312122437.GE4043@hirez.programming.kicks-ass.net>
From: Lin Xiulei <linxiulei@gmail.com>
Date: Mon, 12 Mar 2018 21:10:35 +0800
Message-ID: <CALPjY3mLExjKT-DTtaS+r7h-ad9EYuGtdbHRM+yJ7KZrX6UBqA@mail.gmail.com>
Subject: Re: [PATCH RESEND v5] perf/core: Fix installing arbitrary cgroup
 event into cpu
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@redhat.com>, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Stephane Eranian <eranian@gmail.com>,
        torvalds@linux-foundation.org, linux-perf-users@vger.kernel.org,
        Brendan Gregg <brendan.d.gregg@gmail.com>, yang_oliver@hotmail.com,
        "leilei.lin" <leilei.lin@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-12 20:24 GMT+08:00 Peter Zijlstra <peterz@infradead.org>:
> On Wed, Mar 07, 2018 at 07:19:15PM +0800, Lin Xiulei wrote:
>
>> >> +     /*
>> >> +      * if only the cgroup is running on this cpu
>> >> +      * and cpuctx->cgrp == NULL (otherwise it would've
>> >> +      * been set with running cgroup), we put this cgroup
>> >> +      * into cpu context. Or it would case mismatch in
>> >> +      * following cgroup events at event_filter_match()
>> >> +      */
>> >
>> > This is utterly incomprehensible, what?
>>
>> Yes, this is bit messy. I should've made it clear. This comment was supposed
>> to explain the reason why I modified the if statement below.
>>
>> And the logic is
>>
>> 1) when cpuctx-> cgrp is NULL, we __must__ take care of how to set it
>> appropriately, that means, we __have to__ check if the cgroup is running
>> on the cpu
>
> Yes, however, the changelog needs to explain why this was
> changed, and the above does not explain where the old code was wrong.
>

Yes, it's good to be involved in community since you guys give great opinions

> In what case do we fail to do 1 with the current code?
>

With current code, it doesn't check if the cgroup is running on the
CPU. then problem happens when two cgroup events on the same CPU are
opened in a row, which means no schedule happen between it

1) event A on cgroup A has no tasks running on this CPU
2) event B on cgroup B has some task running on the CPU

With the current code, cpuctx->cgrp would be set as cgroup A
arbitrarily, then it opens event B, cpuctx->cgrp will not be set
anymore, and it fails in event_filter_match() because cpuctx->cgrp !=
cgroup B. We have to wait schedule() happened to correct it. But in
this situation, we lost a slight period that measures event B.


> The existing nr_cgroups logic ensures we only continue for the
> first/last cgroup event for that context. Is the problem that if the
> first cgroup is _not_ of the current cgroup and we correctly do _not_
> set cpuctx->cgrp, a second event that _is_ of the right cgroup will then
> not have the opportunity to set cpuctx->cgrp ?
>

Yes, You got it.

>> 2) when cpuctx-> cgrp is __NOT__ NULL. It means cpuctx->cgrp had been
>> set appropriately by cgroup_switch() or list_update_cgroup_event() before.
>> Therefore, We do __nothing__ here
>
> Right, but my variant doubled checked it. If its _not_ NULL it must be
> the current task's cgrp, otherwise we have a problem. Same difference,
> more paranoia :-)
>
> But I suppose you're right and we can avoid a bunch of looking up if
> cpuctx->cgrp is already set.
>

Yes, actually you have a good instinct. But what my further concern is
when we should set cpuctx->cgrp to NULL again when one running event
is closed ? By this way, we can avoid a bunch of checking
cgroup_is_descendant(). I didn't figure it out in this patch, and of
course I didn't make it worse. :-)

>
> How is the below patch?
>

You're AWESOME : )

> ---
> Subject: perf/core: Fix installing cgroup events on CPU
> From: "leilei.lin" <leilei.lin@alibaba-inc.com>
> Date: Tue, 6 Mar 2018 17:36:37 +0800
>
> There's two problems when installing cgroup events on CPUs: firstly
> list_update_cgroup_event() only tries to set cpuctx->cgrp for the
> first event, if that mismatches on @cgrp we'll not try again for later
> additions.
>
> Secondly, when we install a cgroup event into an active context, only
> issue an event reprogram when the event matches the current cgroup
> context. This avoids a pointless event reprogramming.
>
> Cc: acme@kernel.org
> Cc: yang_oliver@hotmail.com
> Cc: mingo@redhat.com
> Cc: jolsa@redhat.com
> Cc: eranian@gmail.com
> Cc: torvalds@linux-foundation.org
> Cc: tglx@linutronix.de
> Cc: brendan.d.gregg@gmail.com
> Cc: alexander.shishkin@linux.intel.com
> Signed-off-by: leilei.lin <leilei.lin@alibaba-inc.com>
> [peterz: Changelog and comments]
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: http://lkml.kernel.org/r/20180306093637.28247-1-linxiulei@gmail.com
> ---
>  kernel/events/core.c |   46 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 11 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -937,27 +937,39 @@ list_update_cgroup_event(struct perf_eve
>         if (!is_cgroup_event(event))
>                 return;
>
> -       if (add && ctx->nr_cgroups++)
> -               return;
> -       else if (!add && --ctx->nr_cgroups)
> -               return;
>         /*
>          * Because cgroup events are always per-cpu events,
>          * this will always be called from the right CPU.
>          */
>         cpuctx = __get_cpu_context(ctx);
> -       cpuctx_entry = &cpuctx->cgrp_cpuctx_entry;
> -       /* cpuctx->cgrp is NULL unless a cgroup event is active in this CPU .*/
> -       if (add) {
> +
> +       /*
> +        * Since setting cpuctx->cgrp is conditional on the current @cgrp
> +        * matching the event's cgroup, we must do this for every new event,
> +        * because if the first would mismatch, the second would not try again
> +        * and we would leave cpuctx->cgrp unset.
> +        */
> +       if (add && !cpuctx->cgrp) {
>                 struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
>
> -               list_add(cpuctx_entry, this_cpu_ptr(&cgrp_cpuctx_list));
>                 if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup))
>                         cpuctx->cgrp = cgrp;
> -       } else {
> -               list_del(cpuctx_entry);
> -               cpuctx->cgrp = NULL;
>         }
> +
> +       if (add && ctx->nr_cgroups++)
> +               return;
> +       else if (!add && --ctx->nr_cgroups)
> +               return;
> +
> +       /* no cgroup running */
> +       if (!add)
> +               cpuctx->cgrp = NULL;
> +
> +       cpuctx_entry = &cpuctx->cgrp_cpuctx_entry;
> +       if (add)
> +               list_add(cpuctx_entry, this_cpu_ptr(&cgrp_cpuctx_list));
> +       else
> +               list_del(cpuctx_entry);
>  }
>
>  #else /* !CONFIG_CGROUP_PERF */
> @@ -2491,6 +2503,18 @@ static int  __perf_install_in_context(vo
>                 raw_spin_lock(&task_ctx->lock);
>         }
>
> +#ifdef CONFIG_CGROUP_PERF
> +       if (is_cgroup_event(event)) {
> +               /*
> +                * If the current cgroup doesn't match the event's
> +                * cgroup, we should not try to schedule it.
> +                */
> +               struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
> +               reprogram = cgroup_is_descendant(cgrp->css.cgroup,
> +                                       event->cgrp->css.cgroup);
> +       }
> +#endif
> +
>         if (reprogram) {
>                 ctx_sched_out(ctx, cpuctx, EVENT_TIME);
>                 add_event_to_ctx(event, ctx);
