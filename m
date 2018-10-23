Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3057C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8620420671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cc8ifwHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8620420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeJWUig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:38:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34090 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJWUig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:38:36 -0400
Received: by mail-io1-f68.google.com with SMTP id d80-v6so723524iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 05:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OgOZOCY3AWDdotWs/zMC00OKA/8EadT+gOwmlqdTiHk=;
        b=Cc8ifwHS51PIS+xS23Ta6PUTanV2BnLM9ap1MN+38FYIL61Wa2GMQGS/lbMrIa91+h
         69yq3QDFFtoVKhqJ1DlAovc1PQrm4GjgrEukng2gZcTbVE7Agynz8ZLbifX8OGsc9Nav
         pheygKgvTbuV2c77VliSVG+pE4DvfGnDF8Jnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgOZOCY3AWDdotWs/zMC00OKA/8EadT+gOwmlqdTiHk=;
        b=f7KtUyOC2m/lVesCpT6eL6K9vvptIIYGFDPgEkQv3N+jXilZ1qqrvVBJy1fRAi76B0
         zeWOGM9lic5LI6zQeij/NXjbsyUz+U/Rw4PJRt9OtIS4KWu+VPqOZMj1IXhvKgRvI3lW
         DkcSW0WM4jN9WNiQeRXFageuIxPinyC6zDnCUY25IdSLjgqQniY8MqERfCKLOeU6uKhe
         0azXFLqMA92AEkMCc+hzz7LPaio+K5Lyjp5C4rupJWAuJEtvXys/i0MmiizuPOloNbBG
         f/9aahUvSFxkCIobDMgSwsC6ATBQ8DJVH8fM42RsoJ0MZ0IvteHYCoVPchyTVY7c5abh
         QkwA==
X-Gm-Message-State: AGRZ1gLxZN6Owk2t8carS7aPPg1NdQ6NwS2nxUiwUGpJ+x1C+4Ne8VJd
        6AwZWa2XfIyTFZcooX0yzPH2z7V6hCWFulcmcYm6pg==
X-Google-Smtp-Source: AJdET5ebzeD9sN70c8xgYxkHf77xJr+y3q4hOvdG8cGDU5DW9yMHpH7NgKay0J/ch+ruvjAVjdoION6a0aG6mip+iBA=
X-Received: by 2002:a6b:fe11:: with SMTP id x17-v6mr285857ioh.294.1540296920629;
 Tue, 23 Oct 2018 05:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <1539965871-22410-1-git-send-email-vincent.guittot@linaro.org>
 <1539965871-22410-3-git-send-email-vincent.guittot@linaro.org> <20181023055937.GC27587@codeaurora.org>
In-Reply-To: <20181023055937.GC27587@codeaurora.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 23 Oct 2018 14:15:08 +0200
Message-ID: <CAKfTPtDv3GYx-AXYuoW3ubPvDjGiEaEhYA6=iGC-02mOqwuySQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] sched/fair: update scale invariance of PELT
To:     pkondeti@codeaurora.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,

On Tue, 23 Oct 2018 at 07:59, Pavan Kondeti <pkondeti@codeaurora.org> wrote:
>
> Hi Vincent,
>
> On Fri, Oct 19, 2018 at 06:17:51PM +0200, Vincent Guittot wrote:
> >
> >  /*
> > + * The clock_pelt scales the time to reflect the effective amount of
> > + * computation done during the running delta time but then sync back to
> > + * clock_task when rq is idle.
> > + *
> > + *
> > + * absolute time   | 1| 2| 3| 4| 5| 6| 7| 8| 9|10|11|12|13|14|15|16
> > + * @ max capacity  ------******---------------******---------------
> > + * @ half capacity ------************---------************---------
> > + * clock pelt      | 1| 2|    3|    4| 7| 8| 9|   10|   11|14|15|16
> > + *
> > + */
> > +void update_rq_clock_pelt(struct rq *rq, s64 delta)
> > +{
> > +
> > +     if (is_idle_task(rq->curr)) {
> > +             u32 divider = (LOAD_AVG_MAX - 1024 + rq->cfs.avg.period_contrib) << SCHED_CAPACITY_SHIFT;
> > +             u32 overload = rq->cfs.avg.util_sum + LOAD_AVG_MAX;
> > +             overload += rq->avg_rt.util_sum;
> > +             overload += rq->avg_dl.util_sum;
> > +
> > +             /*
> > +              * Reflecting some stolen time makes sense only if the idle
> > +              * phase would be present at max capacity. As soon as the
> > +              * utilization of a rq has reached the maximum value, it is
> > +              * considered as an always runnnig rq without idle time to
> > +              * steal. This potential idle time is considered as lost in
> > +              * this case. We keep track of this lost idle time compare to
> > +              * rq's clock_task.
> > +              */
> > +             if (overload >= divider)
> > +                     rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;
> > +
>
> I am trying to understand this better. I believe we run into this scenario, when
> the frequency is limited due to thermal/userspace constraints. Lets say

Yes these are the most common UCs but this can also happen after tasks
migration or with a cpufreq governor that doesn't increase OPP fast
enough for current utilization.

> frequency is limited to Fmax/2. A 50% task at Fmax, becomes 100% running at
> Fmax/2. The utilization is built up to 100% after several periods.
> The clock_pelt runs at 1/2 speed of the clock_task. We are loosing the idle time
> all along. What happens when the CPU enters idle for a short duration and comes
> back to run this 100% utilization task?

If you are at 100%, we only apply the short idle duration

>
> If the above block is not present i.e lost_idle_time is not tracked, we
> stretch the idle time (since clock_pelt is synced to clock_task) and the
> utilization is dropped. Right?

yes that 's what would happen. I gives more details below

>
> With the above block, we don't stretch the idle time. In fact we don't
> consider the idle time at all. Because,
>
> idle_time = now - last_time;
>
> idle_time = (rq->clock_pelt - rq->lost_idle_time) - last_time
> idle_time = (rq->clock_task - rq_clock_task + rq->clock_pelt_old) - last_time
> idle_time = rq->clock_pelt_old - last_time
>
> The last time is nothing but the last snapshot of the rq->clock_pelt when the
> task entered sleep due to which CPU entered idle.

The condition for dropping this idle time is quite important. This
only happens when the utilization reaches max compute capacity of the
CPU. Otherwise, the idle time will be fully applied

>
> Can you please explain the significance of the above block with an example?

The pelt signal reaches its max value after 323ms at full capacity,
which means that we can't make any difference between tasks running
323ms, 500ms or more at max capacity. As a result, we consider that
the CPU is fully used and there is no idle time when the utilization
equals max capacity. If CPU runs at half the capacity, it will run
626ms before reaching max utilization and at that time we will stop to
stretch the idle time because we consider that there is no idle time
to stretch. By default, we never drop the idle time which is a
necessary for being fully invariant and we always apply it. But we
have to drop it when we consider that it would not have been present
at max capacity too. That's all the purpose of the block that you
mention

Let take a task that runs 120 ms with a period of 330ms.
At max capacity, task utilization will vary in the range [10-949]
At half capacity, task will run 240ms and the range will stay the same
as the idle time and the running time will be the same once stretched
and scaled
At one third of the capacity, task should run 360ms in a period of 330
which means that the task will always run and will probably even lost
some events as it will have not finished when the new period will
start. In this case, the task/CPU utilization will reach the max value
just like an always running task. As we can't make any difference
anymore, we consider that there is no idle time to recover once the
cpu will become idle and the block of code that you mention above will
cancel the stretch of idle time.

>
> > +
> > +             /* The rq is idle, we can sync to clock_task */
> > +             rq->clock_pelt  = rq_clock_task(rq);
> > +
> > +
> > +     } else {
> > +             /*
> > +              * When a rq runs at a lower compute capacity, it will need
> > +              * more time to do the same amount of work than at max
> > +              * capacity: either because it takes more time to compute the
> > +              * same amount of work or because taking more time means
> > +              * sharing more often the CPU between entities.
> > +              * In order to be invariant, we scale the delta to reflect how
> > +              * much work has been really done.
> > +              * Running at lower capacity also means running longer to do
> > +              * the same amount of work and this results in stealing some
> > +              * idle time that will disturb the load signal compared to
> > +              * max capacity; This stolen idle time will be automaticcally
> > +              * reflected when the rq will be idle and the clock will be
> > +              * synced with rq_clock_task.
> > +              */
> > +
> > +             /*
> > +              * scale the elapsed time to reflect the real amount of
> > +              * computation
> > +              */
> > +             delta = cap_scale(delta, arch_scale_freq_capacity(cpu_of(rq)));
> > +             delta = cap_scale(delta, arch_scale_cpu_capacity(NULL, cpu_of(rq)));
> > +
> > +             rq->clock_pelt += delta;
>
> AFAICT, the rq->clock_pelt is used for both utilization and load. So the load
> also becomes a function of CPU uarch now. Is this intentional?

yes, it is. Load is not scaled with uarch in current implementation
because the load would cap by the max capacity of the local CPU and
this mess up the load balance.

Let take the example of CPU0 with max capacity of 1024 and CPU1 with
max capacity of 512.
We have 6 always running tasks  with same nice priority
Then, put 3 tasks on each CPU.
If the load is scaled/capped with uarch, LB will consider the system
balanced : 3*max_load / 1024 for CPU0 and 3*(max_load / 2) / 512 for
CPU1. But tasks on CPU0 have twice more compute capacity than tasks on
CPU1.

With the new scaling, we don't have this problem anymore so we can
take into account uarch and have more accurate load.

Regards,
Vincent

>
> Thanks,
> Pavan
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>
