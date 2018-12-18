Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B0FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856382133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y1Mtq29R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbeLRJcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:32:52 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41729 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeLRJcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:32:51 -0500
Received: by mail-io1-f66.google.com with SMTP id s22so12230810ioc.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 01:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nnD/TVnVuhMz44DLAm141Uh0wL1dUKa0bfclTkZzLQo=;
        b=Y1Mtq29RfFUOBEApc9eBzYW49T2yVZZEtDlyl3+pNUDP7tIYnAGKF2ODP+SXPJrx6Q
         8t4tTL4elEYHQPdr/V7FldSTYBxhjoZVtith973V6VF0gmnXqBCqh1lbVSsKVxm64z5F
         bKOdb1N1fI8eesXxFR7epVaLppj94O5vWigYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nnD/TVnVuhMz44DLAm141Uh0wL1dUKa0bfclTkZzLQo=;
        b=U4XeBIfJ2hLZn2aF685dBuER/0MxKgzpCyqr10cKPwAGVxXml09/wf8dkTVkNOx3A7
         M6AT6JutRtIjJpcspc8/gzZ9C9XIXrUgrbhdeij/51DUCX+SeoaW3FNY+fIkUjqFnnFC
         PBkj98GqPUfthPQnhg1hV19HjNv7kBUCWYkoXK/1dDxZPxA7PKS8GB12F3ucvzqp8mfV
         ZLRBApvnvPzS24wBQbLJM7zCKQKPHJ2QPkF2Ayh0RzBJbNgwWC3PuuuinVT2c1hkuwQt
         B5HB6uqzVWzVjjFyQdlo1Z5ruOC95byFwVnt1w1mdSXhui/qXb+YKwQgI+BEpCUL8ZzG
         9Tyg==
X-Gm-Message-State: AJcUukc1WTMG/IdLA8T6/DlhtAo1Z5G+t8rChHZdqptP7G2aLSsg9TN9
        ubnf4nf89zytRpWwBfz55MA3IDw3cHBM4zRisEw+Y85mWgM=
X-Google-Smtp-Source: ALg8bN6VJFGLqh3Toaloxzi4K3OEu0qIH4NsNI7IPQiYDiKmqhZd28PttCzK0UALOTjKwaqCOO3SKXeoPEjxX4EolB0=
X-Received: by 2002:a6b:6b0d:: with SMTP id g13mr758681ioc.18.1545125570205;
 Tue, 18 Dec 2018 01:32:50 -0800 (PST)
MIME-Version: 1.0
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
 <1544803317-7610-4-git-send-email-vincent.guittot@linaro.org> <f6443ca2-3e82-d4eb-deb8-2aff44c618e2@arm.com>
In-Reply-To: <f6443ca2-3e82-d4eb-deb8-2aff44c618e2@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 18 Dec 2018 10:32:38 +0100
Message-ID: <CAKfTPtCJBGtmx7pQJCwhcMaxyXWoh04o_C+pR6z+YVykXwvv5Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] sched/fair: fix unnecessary increase of balance interval
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On Mon, 17 Dec 2018 at 17:56, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Hi Vincent,
>
> About time I had a look at this one...
>
> On 14/12/2018 16:01, Vincent Guittot wrote:
> > In case of active balance, we increase the balance interval to cover
> > pinned tasks cases not covered by all_pinned logic.
>
> AFAIUI the balance increase is there to have plenty of time to
> stop the task before going through another load_balance().
>
> Seeing as there is a cpus_allowed check that leads to
>
>     env.flags |= LBF_ALL_PINNED;
>     goto out_one_pinned;
>
> in the active balancing part of load_balance(), the condition you're
> changing should never be hit when we have pinned tasks. So you may want
> to rephrase that bit.

In this asym packing case, It has nothing to do with pinned tasks and
that's the root cause of the problem:
the active balance triggered by asym packing is wrongly assumed to be
an active balance due to pinned task(s) and the load balance interval
is increased without any reason

>
> > Neverthless, the active
> > migration triggered by asym packing should be treated as the normal
> > unbalanced case and reset the interval to default value otherwise active
> > migration for asym_packing can be easily delayed for hundreds of ms
> > because of this all_pinned detection mecanism.
>
> Mmm so it's not exactly clear why we need this change. If we double the
> interval because of a pinned task we wanted to active balance, well it's
> just regular pinned task issues and we can't do much about it.

As explained above, it's not a pinned task case

>
> The only scenario I can think of is if you had a workload where you wanted
> to do an active balance in several successive load_balance(), in which case
> you would keep increasing the interval even though you do migrate a task
> every time (which would harm every subsequent active_balance).
>
> In that case every active_balance "user" (pressured CPU, misfit) is
> affected, so maybe what we want is something like this:
>
> -----8<-----
> @@ -9136,13 +9149,11 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>                 sd->balance_interval = sd->min_interval;
>         } else {
>                 /*
> -                * If we've begun active balancing, start to back off. This
> -                * case may not be covered by the all_pinned logic if there
> -                * is only 1 task on the busy runqueue (because we don't call
> -                * detach_tasks).
> +                * If we've begun active balancing, start to back off.
> +                * Don't increase too much in case we have more active balances
> +                * coming up.
>                  */
> -               if (sd->balance_interval < sd->max_interval)
> -                       sd->balance_interval *= 2;
> +               sd->balance_interval = 2 * sd->min_interval;
>         }
>
>         goto out;
> ----->8-----
>
> Maybe we want a larger threshold - truth be told, it all depends on how
> long the cpu stopper can take and if that delay increase is still relevant
> nowadays.

hmm the increase of balance interval is not linked to cpu stopper but
to increase the load balance interval when we know that there is no
possible load balance to perform

Regards,
Vincent
>
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 27 +++++++++++++++------------
> >  1 file changed, 15 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 9591e7a..487287e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8857,21 +8857,24 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> >   */
> >  #define MAX_PINNED_INTERVAL  512
> >
> > +static inline bool
> > +asym_active_balance(struct lb_env *env)
> > +{
> > +     /*
> > +      * ASYM_PACKING needs to force migrate tasks from busy but
> > +      * lower priority CPUs in order to pack all tasks in the
> > +      * highest priority CPUs.
> > +      */
> > +     return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
> > +            sched_asym_prefer(env->dst_cpu, env->src_cpu);
> > +}
> > +
> >  static int need_active_balance(struct lb_env *env)
> >  {
> >       struct sched_domain *sd = env->sd;
> >
> > -     if (env->idle != CPU_NOT_IDLE) {
> > -
> > -             /*
> > -              * ASYM_PACKING needs to force migrate tasks from busy but
> > -              * lower priority CPUs in order to pack all tasks in the
> > -              * highest priority CPUs.
> > -              */
> > -             if ((sd->flags & SD_ASYM_PACKING) &&
> > -                 sched_asym_prefer(env->dst_cpu, env->src_cpu))
> > -                     return 1;
> > -     }
> > +     if (asym_active_balance(env))
> > +             return 1;
> >
> >       /*
> >        * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
> > @@ -9150,7 +9153,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> >       } else
> >               sd->nr_balance_failed = 0;
> >
> > -     if (likely(!active_balance)) {
> > +     if (likely(!active_balance) || asym_active_balance(&env)) {
>
> AFAICT this makes us reset the interval whenever we do an asym packing
> active balance (if the task is pinned we would goto out_one_pinned).
> This goes against the logic I had understood so far and that I explained
> higher up.
>
> >               /* We were unbalanced, so reset the balancing interval */
> >               sd->balance_interval = sd->min_interval;
> >       } else {
> >
