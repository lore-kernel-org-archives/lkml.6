Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029DDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C070020874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JznlQo5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeLSIcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:32:14 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55122 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLSIcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:32:14 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so8451235ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 00:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9k1TpXcrpJB8b5f/VAv3QpU0jHDC4asvO7Ey7FJ8yQU=;
        b=JznlQo5HiFXQ8Lm6AhqzQT4AFQgSTStfcwktFbCHcgzJ4xCe6R0LSw6uKV1B6ENfmV
         y9QqaQWnLiCB/3LxV9qVWyWlTN2DhfpwKZ6syxoNGKKXfAQ8bvgPMVPkrWfyyuoPyx5t
         AVgwV6M1Rx5Fx091VbItDiDBW1EkE3VDMI5Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9k1TpXcrpJB8b5f/VAv3QpU0jHDC4asvO7Ey7FJ8yQU=;
        b=QpfTeGoDp8p9XcTEF248E1dht8YoviWGRoBWpq51l9j1F6n8Gx447IxgNDQTsD4h1F
         7ehXuKA6b/wcifxwCVBFKDS6M7DPwYRWC9uHpEqlNM/mFgnEqVAmvxgKhFBMASsv9pvK
         8sQQ3s3yP+uDSgPPKViPlzKqmwMWsI9QF2Qh0h/B10Yvn2KLnNiuep4fb4wuNz1KsBpI
         taDuZG/FvqJO7wkP1eEaDAUL+YkHtctl/YUPRb1DEfK3qcUqw2At7l0OcWfE2dIT41Xw
         uz+RQzN6BbWC9+3dJCcOKeGgLlX/BgmokyM9TFlPMy00hc2r6rRiCBaM2z9ksjURHKBX
         JPrg==
X-Gm-Message-State: AA+aEWZeXxqEpjr+m17KftpFEAGk3zJgU+VQP2+OrbPY+vQHATm17sQF
        6MXNRj5GDXd1BbxWxPbLPnvkRF+17T+pkERUBCUxQg==
X-Google-Smtp-Source: AFSGD/WbyIhrcOP0EzH1lqAdjX+3XO9gxv4qHOBvytPcbtn4TM9WGRZEVk0Y3TAbfX4XisEoCWYZU6HweOXR8Kvn458=
X-Received: by 2002:a02:6019:: with SMTP id i25mr19393946jac.137.1545208333036;
 Wed, 19 Dec 2018 00:32:13 -0800 (PST)
MIME-Version: 1.0
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
 <1544803317-7610-2-git-send-email-vincent.guittot@linaro.org> <f2619d92-7367-abd4-97e8-e0f4e7cc96eb@arm.com>
In-Reply-To: <f2619d92-7367-abd4-97e8-e0f4e7cc96eb@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 19 Dec 2018 09:32:02 +0100
Message-ID: <CAKfTPtAEi=EBmSUEcYmkfSZVkBviQaJaqZXvt-=XbsgZs5t_OA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sched/fair: fix rounding issue for asym packing
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

On Tue, 18 Dec 2018 at 18:32, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 14/12/2018 16:01, Vincent Guittot wrote:
> > When check_asym_packing() is triggered, the imbalance is set to :
> > busiest_stat.avg_load * busiest_stat.group_capacity / SCHED_CAPACITY_SCALE
> > busiest_stat.avg_load also comes from a division and the final rounding
> > can make imbalance slightly lower than the weighted load of the cfs_rq.
> > But this is enough to skip the rq in find_busiest_queue and prevents asym
> > migration to happen.
> >
> > Add 1 to the avg_load to make sure that the targeted cpu will not be
> > skipped unexpectidly.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index ca46964..c215f7a 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8215,6 +8215,12 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >       /* Adjust by relative CPU capacity of the group */
> >       sgs->group_capacity = group->sgc->capacity;
> >       sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
> > +     /*
> > +      * Prevent division rounding to make the computation of imbalance
> > +      * slightly less than original value and to prevent the rq to be then
> > +      * selected as busiest queue
> > +      */
> > +     sgs->avg_load += 1;
>
> I've tried investigating this off-by-one issue by running lmbench, but it
> seems to be a gnarly one.
>
>
>
> The adventure starts in update_sg_lb_stats() where we compute
> sgs->avg_load:
>
>         sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity
>
> Then we drop by find_busiest_group() and call check_asym_packing() which,
> if we do need to pack, does:
>
>         env->imbalance = DIV_ROUND_CLOSEST(
>                 sds->busiest_stat.avg_load * sds->busiest_stat.group_capacity,
>                 SCHED_CAPACITY_SCALE);
>
> And finally the one check that seems to be failing, and that you're
> addressing with a +1 is in find_busiest_queue():
>
>         if (rq->nr_running == 1 && wl > env->imbalance &&
>             !check_cpu_capacity(rq, env->sd))
>                 continue;
>
>
>
> Now, running lmbench on my HiKey960 hacked up to use asym packing, I
> get an example where there's a task that should be migrated via asym
> packing but isn't:
>
> # This a DIE level balance
> update_sg_lb_stats():
>         cpu=0 load=1
>         cpu=1 load=1023
>         cpu=2 load=0
>         cpu=3 load=0
>
>         avg_load=568
>
> # Busiest group is [0-3]
> find_busiest_group(): check_asym_packing():
>         env->imbalance = 1022
>
> find_busiest_queue():
>         cpu=0 wl=1
>         cpu=1 wl=1023
>         cpu=2 wl=0
>         cpu=3 wl=0
>
> Only CPU1 has rq->nr_running > 0 (==1 actually), but wl > env->imbalance
> so we skip it in find_busiest_queue().
>
> Now, I thought it was due to IRQ/rt pressure - 1840 isn't the maximum
> group capacity for the LITTLE cluster, it should be (463 * 4) == 1852.
> I got curious and threw random group capacity values in that equation while
> keeping the same avg_load [1], and it gets wild: you have a signal that
> oscillates between 1024 and 1014!

hmm ... this seems to not be related with $subject

>
> [1]: https://gist.github.com/valschneider/f42252e83be943d276b901f57734b8ba
>
> Adding +1 to avg_load doesn't solve those pesky rounding errors that get
> worse as group_capacity grows, but it reverses the trend: the signal
> oscillates above 1024.
>
>
>
> So in the end a +1 *could* "fix" this, but
> a) It'd make more sense to have it in the check_asym_packing() code
> b) It's ugly and it makes me feel like this piece of code is flimsy AF.

This is another UC, asym packing is used at SMT level for now and we
don't face this kind of problem, it has been also tested and DynamiQ
configuration which is similar to SMT : 1 CPU per sched_group
The legacy b.L one was not the main target although it can be

The rounding error is there and should be fixed and your UC is another
case for legacy b.L that can be treated in another patch

>
> >
> >       if (sgs->sum_nr_running)
> >               sgs->load_per_task = sgs->sum_weighted_load / sgs->sum_nr_running;
> >
