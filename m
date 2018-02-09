Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbeBIBwt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 20:52:49 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34040 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752285AbeBIBwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 20:52:47 -0500
X-Google-Smtp-Source: AH8x227x27Ut05lNpJJp1DKWaU6GkFGtaFLmYZa8H04iPeYFLkGHCPVmT44hREfwSMdiZcX5FDjD+6crTtMCfzR8vXA=
MIME-Version: 1.0
In-Reply-To: <20180208153648.GC12817@krava>
References: <20180208033344.71933-1-linxiulei@gmail.com> <20180208153648.GC12817@krava>
From: Lin Xiulei <linxiulei@gmail.com>
Date: Fri, 9 Feb 2018 09:52:46 +0800
Message-ID: <CALPjY3ky4kKbJbVfbigZ87MMiqpn8Q1EX1EKwJ8F+e8P=euzzg@mail.gmail.com>
Subject: Re: [PATCH RESEND v4] perf/core: Fix installing cgroup event into cpu
To: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, Stephane Eranian <eranian@gmail.com>,
        torvalds@linux-foundation.org,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        yang_oliver@hotmail.com, jinli.zjl@alibaba-inc.com,
        "leilei.lin" <leilei.lin@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-08 23:36 GMT+08:00 Jiri Olsa <jolsa@redhat.com>:
>
> On Thu, Feb 08, 2018 at 11:33:44AM +0800, linxiulei@gmail.com wrote:
> > From: "leilei.lin" <leilei.lin@alibaba-inc.com>
> >
> > Do not install cgroup event into the CPU context and schedule it
> > if the cgroup is not running on this CPU
> >
> > While there is no task of cgroup running specified CPU, current
> > kernel still install cgroup event into CPU context that causes
> > another cgroup event can't be installed into this CPU.
> >
> > This patch prevent scheduling events at __perf_install_in_context()
> > and installing events at list_update_cgroup_event() if cgroup isn't
> > running on specified CPU.
> >
> > Signed-off-by: leilei.lin <leilei.lin@alibaba-inc.com>
> > ---
> >  v2: Set cpuctx->cgrp only if the same cgroup is running on this
> >    CPU otherwise following events couldn't be activated immediately
> >  v3: Enhance the comments and commit message
> >  v4: Adjust to config
> >
> >  kernel/events/core.c | 50 +++++++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 37 insertions(+), 13 deletions(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 4df5b69..fd28d61 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -933,31 +933,41 @@ list_update_cgroup_event(struct perf_event *event,
> >  {
> >       struct perf_cpu_context *cpuctx;
> >       struct list_head *cpuctx_entry;
> > +     struct perf_cgroup *cgrp;
> >
> >       if (!is_cgroup_event(event))
> >               return;
> >
> > -     if (add && ctx->nr_cgroups++)
> > -             return;
> > -     else if (!add && --ctx->nr_cgroups)
> > -             return;
>
> I might be missing something, but should this check stay on
> the top regardles of the cgroup_is_descendant check below?
>

I don't think so,  if event A on cgroup A is opened and immediately
followed by a event B opened on cgroup B, then
"if (add && ctx->nr_cgroups++)" would __return__ with
 cpuctx->cgrp = cgroup A, that is incorrect.

And previous thread is here https://lkml.org/lkml/2018/1/24/79

>
> you could put NULL into cpuctx->cgrp on context with cgroup
> event in the list
>

what's the harm? It's invoked by perf_remove_from_context() when
an event is ready to be released. And whenever process/cgroup is
scheduled, cpuctx->cgrp will be set

In case that the patch was not sorted well, I put the patched code

```
static inline void
list_update_cgroup_event(struct perf_event *event,
             struct perf_event_context *ctx, bool add)
{
    struct perf_cpu_context *cpuctx;
    struct list_head *cpuctx_entry;
    struct perf_cgroup *cgrp;

    if (!is_cgroup_event(event))
        return;

    /*
     * Because cgroup events are always per-cpu events,
     * this will always be called from the right CPU.
     */
    cpuctx = __get_cpu_context(ctx);
    cgrp = perf_cgroup_from_task(current, ctx);

    /*
     * if only the cgroup is running on this cpu,
     * we put/remove this cgroup into cpu context.
     * Or it would case mismatch in following cgroup
     * events at event_filter_match()
     */
    if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup)) {
        if (add)
            cpuctx->cgrp = cgrp;
        else
            cpuctx->cgrp = NULL;
    }

    if (add && ctx->nr_cgroups++)
        return;
    else if (!add && --ctx->nr_cgroups)
        return;

    cpuctx_entry = &cpuctx->cgrp_cpuctx_entry;
    if (add)
        list_add(cpuctx_entry, this_cpu_ptr(&cgrp_cpuctx_list));
    else
        list_del(cpuctx_entry);
}
```

thanks

>
> thanks,
> jirka
>
> >       /*
> >        * Because cgroup events are always per-cpu events,
> >        * this will always be called from the right CPU.
> >        */
> >       cpuctx = __get_cpu_context(ctx);
> > -     cpuctx_entry = &cpuctx->cgrp_cpuctx_entry;
> > -     /* cpuctx->cgrp is NULL unless a cgroup event is active in this CPU .*/
> > -     if (add) {
> > -             struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
> > +     cgrp = perf_cgroup_from_task(current, ctx);
> >
> > -             list_add(cpuctx_entry, this_cpu_ptr(&cgrp_cpuctx_list));
> > -             if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup))
> > +     /*
> > +      * if only the cgroup is running on this cpu,
> > +      * we put/remove this cgroup into cpu context.
> > +      * Or it would case mismatch in following cgroup
> > +      * events at event_filter_match()
> > +      */
> > +     if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup)) {
> > +             if (add)
> >                       cpuctx->cgrp = cgrp;
> > -     } else {
> > -             list_del(cpuctx_entry);
> > -             cpuctx->cgrp = NULL;
> > +             else
> > +                     cpuctx->cgrp = NULL;
>
> SNIP
>
