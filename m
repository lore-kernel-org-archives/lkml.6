Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754070AbeCGLTT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 06:19:19 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36573 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbeCGLTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 06:19:16 -0500
X-Google-Smtp-Source: AG47ELuMO7pLE9xicJ3YroeS7Jm4Z3bnskZwQ+9US7xtVvcxM/boeahQhw3wntWmo4laS/6ODk4kQYJLn38OoCPQN80=
MIME-Version: 1.0
In-Reply-To: <20180306115010.GC25201@hirez.programming.kicks-ass.net>
References: <20180306093637.28247-1-linxiulei@gmail.com> <20180306115010.GC25201@hirez.programming.kicks-ass.net>
From: Lin Xiulei <linxiulei@gmail.com>
Date: Wed, 7 Mar 2018 19:19:15 +0800
Message-ID: <CALPjY3n+_uRQ70ZWan8zY+JwgzyUYoEwngna1EnGgLMtm1iuKA@mail.gmail.com>
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

2018-03-06 19:50 GMT+08:00 Peter Zijlstra <peterz@infradead.org>:
> On Tue, Mar 06, 2018 at 05:36:37PM +0800, linxiulei@gmail.com wrote:
>> From: "leilei.lin" <leilei.lin@alibaba-inc.com>
>>
>> Do not install cgroup event into the CPU context and schedule it
>> if the cgroup is not running on this CPU
>
> OK, so far so good, this explains the bit in
> __perf_install_in_context().
>

Actually, the new codes in __perf_install_in_context() only takes care whether
if events should be scheduled with PMU.

>> While there is no task of cgroup running specified CPU, current
>> kernel still install cgroup event into CPU context that causes
>> another cgroup event can't be installed into this CPU.
>>
>> This patch prevent scheduling events at __perf_install_in_context()
>> and installing events at list_update_cgroup_event() if cgroup isn't
>> running on specified CPU.
>
> This bit doesn't make sense, you don't in fact avoid anything in
> list_update_cgroup_event(), you do more, not less.
>

And the new codes in list_update_cgroup_event() don't want cpuctx->cgrp
to be set arbitrarily. The more logic, you mentioned, was added for making
sure cpuctx->cgrp is set consistently with the cgroup running on the cpu.

>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 4df5b69..f3ffa70 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -933,31 +933,45 @@ list_update_cgroup_event(struct perf_event *event,
>>  {
>>       struct perf_cpu_context *cpuctx;
>>       struct list_head *cpuctx_entry;
>> +     struct perf_cgroup *cgrp;
>>
>>       if (!is_cgroup_event(event))
>>               return;
>>
>>       /*
>>        * Because cgroup events are always per-cpu events,
>>        * this will always be called from the right CPU.
>>        */
>>       cpuctx = __get_cpu_context(ctx);
>> +     cgrp = perf_cgroup_from_task(current, ctx);
>> +
>> +     /*
>> +      * if only the cgroup is running on this cpu
>> +      * and cpuctx->cgrp == NULL (otherwise it would've
>> +      * been set with running cgroup), we put this cgroup
>> +      * into cpu context. Or it would case mismatch in
>> +      * following cgroup events at event_filter_match()
>> +      */
>
> This is utterly incomprehensible, what?

Yes, this is bit messy. I should've made it clear. This comment was supposed
to explain the reason why I modified the if statement below.

And the logic is

1) when cpuctx-> cgrp is NULL, we __must__ take care of how to set it
appropriately, that means, we __have to__ check if the cgroup is running
on the cpu

2) when cpuctx-> cgrp is __NOT__ NULL. It means cpuctx->cgrp had been
set appropriately by cgroup_switch() or list_update_cgroup_event() before.
Therefore, We do __nothing__ here

>
>> +     if (add && !cpuctx->cgrp &&
>> +                     cgroup_is_descendant(cgrp->css.cgroup,
>> +                     event->cgrp->css.cgroup)) {
>> +             cpuctx->cgrp = cgrp;
>> +     }
>
> And that's just horrible coding style. Maybe something like:
>
>         if (add && cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup)) {
>                 if (cpuctx->cgrp)
>                         WARN_ON_ONCE(cpuctx->cgrp != cgrp);
>                 cpuctx->cgrp = cgrp;
>         }
>
> that? But that still needs a comment to explain _why_ we do that here.
> Under what condition would we fail to have cpuctx->cgrp set while
> ctx->nr_cgroups. Your comment doesn't explain nor does your Changelog.
>

        if (cpuctx->cgrp == NULL) /* As I said above, we only take
care this case. */
             if (add && cgroup_is_descendant(cgrp->css.cgroup,
event->cgrp->css.cgroup)) {
                      /* only when this cgroup is running */
                      cpuctx->cgrp = cgrp;
         }

>> +
>> +     if (add && ctx->nr_cgroups++)
>> +             return;
>> +     else if (!add && --ctx->nr_cgroups)
>> +             return;
>>
>> +     /* no cgroup running */
>> +     if (!add)
>> +             cpuctx->cgrp = NULL;
>> +
>> +     cpuctx_entry = &cpuctx->cgrp_cpuctx_entry;
>> +     if (add)
>>               list_add(cpuctx_entry, this_cpu_ptr(&cgrp_cpuctx_list));
>> +     else
>>               list_del(cpuctx_entry);
>>  }
>>
>>  #else /* !CONFIG_CGROUP_PERF */
>> @@ -2311,6 +2325,20 @@ static int  __perf_install_in_context(void *info)
>>               raw_spin_lock(&task_ctx->lock);
>>       }
>>
>> +#ifdef CONFIG_CGROUP_PERF
>> +     if (is_cgroup_event(event)) {
>> +             /*
>> +              * Only care about cgroup events.
>> +              *
>
> That bit is entirely spurious, if it right after if (is_cgroup_event()),
> obviously this block is only for cgroup events.
>

Totally, : )

>> +              * If only the task belongs to cgroup of this event,
>> +              * we will continue the installment
>
> And that isn't really english. I think you meant to write something
> like:
>
>                 /*
>                  * If the current cgroup doesn't match the event's
>                  * cgroup, we should not try to schedule it.
>                  */
>

Totally again, : ) Thanks

>> +              */
>> +             struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
>> +             reprogram = cgroup_is_descendant(cgrp->css.cgroup,
>> +                                     event->cgrp->css.cgroup);
>> +     }
>> +#endif
>> +
>>       if (reprogram) {
>>               ctx_sched_out(ctx, cpuctx, EVENT_TIME);
>>               add_event_to_ctx(event, ctx);
>> --
>> 2.8.4.31.g9ed660f
>>
