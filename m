Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEE8C7112C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406BF207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TkEEn7qU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BKCiqAwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406BF207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbeJXNTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 09:19:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55368 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeJXNTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 09:19:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6412660C5F; Wed, 24 Oct 2018 04:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540356794;
        bh=BjCkCj4IFsZMcNq6Uy4Y+NORrdg2qFo3anwvyPPup1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TkEEn7qUV+d6WZ/7TSqHN6LdRzODDEl2JPCjCpXnSSHYJQUxAa+0AOk2dvvK8LikO
         7EQ7CNHFTzCVhUstGH6NK4Jbdzq6d6CUFLK/6DpAa3WAy/DB8NAa72spygu+Mptn3B
         veF6YFRKewx+xKRioOLN2PIRNCjoFMVVJyWk+1YY=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5866260BDE;
        Wed, 24 Oct 2018 04:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540356793;
        bh=BjCkCj4IFsZMcNq6Uy4Y+NORrdg2qFo3anwvyPPup1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BKCiqAwhk7pzCDqWjHcfVZ0anlHGF+d7iWI6EErz7NnFVyskQ/SrN9Kn22HnlZJQD
         1CCQ8kpF8odpLGmWs+8J+oa7IQruzQPd9fdI+tGAz4eklPjd2nFpQEacNVjOOOaiFA
         dsLDFpknVDToDaMsLLn4fwpdvNHKJexNRcFsU9Ao=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5866260BDE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Wed, 24 Oct 2018 10:23:05 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH v4 2/2] sched/fair: update scale invariance of PELT
Message-ID: <20181024045305.GD27587@codeaurora.org>
References: <1539965871-22410-1-git-send-email-vincent.guittot@linaro.org>
 <1539965871-22410-3-git-send-email-vincent.guittot@linaro.org>
 <20181023055937.GC27587@codeaurora.org>
 <CAKfTPtDv3GYx-AXYuoW3ubPvDjGiEaEhYA6=iGC-02mOqwuySQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDv3GYx-AXYuoW3ubPvDjGiEaEhYA6=iGC-02mOqwuySQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

Thanks for the detailed explanation.

On Tue, Oct 23, 2018 at 02:15:08PM +0200, Vincent Guittot wrote:
> Hi Pavan,
> 
> On Tue, 23 Oct 2018 at 07:59, Pavan Kondeti <pkondeti@codeaurora.org> wrote:
> >
> > Hi Vincent,
> >
> > On Fri, Oct 19, 2018 at 06:17:51PM +0200, Vincent Guittot wrote:
> > >
> > >  /*
> > > + * The clock_pelt scales the time to reflect the effective amount of
> > > + * computation done during the running delta time but then sync back to
> > > + * clock_task when rq is idle.
> > > + *
> > > + *
> > > + * absolute time   | 1| 2| 3| 4| 5| 6| 7| 8| 9|10|11|12|13|14|15|16
> > > + * @ max capacity  ------******---------------******---------------
> > > + * @ half capacity ------************---------************---------
> > > + * clock pelt      | 1| 2|    3|    4| 7| 8| 9|   10|   11|14|15|16
> > > + *
> > > + */
> > > +void update_rq_clock_pelt(struct rq *rq, s64 delta)
> > > +{
> > > +
> > > +     if (is_idle_task(rq->curr)) {
> > > +             u32 divider = (LOAD_AVG_MAX - 1024 + rq->cfs.avg.period_contrib) << SCHED_CAPACITY_SHIFT;
> > > +             u32 overload = rq->cfs.avg.util_sum + LOAD_AVG_MAX;
> > > +             overload += rq->avg_rt.util_sum;
> > > +             overload += rq->avg_dl.util_sum;
> > > +
> > > +             /*
> > > +              * Reflecting some stolen time makes sense only if the idle
> > > +              * phase would be present at max capacity. As soon as the
> > > +              * utilization of a rq has reached the maximum value, it is
> > > +              * considered as an always runnnig rq without idle time to
> > > +              * steal. This potential idle time is considered as lost in
> > > +              * this case. We keep track of this lost idle time compare to
> > > +              * rq's clock_task.
> > > +              */
> > > +             if (overload >= divider)
> > > +                     rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;
> > > +
> >
> > I am trying to understand this better. I believe we run into this scenario, when
> > the frequency is limited due to thermal/userspace constraints. Lets say
> 
> Yes these are the most common UCs but this can also happen after tasks
> migration or with a cpufreq governor that doesn't increase OPP fast
> enough for current utilization.
> 
> > frequency is limited to Fmax/2. A 50% task at Fmax, becomes 100% running at
> > Fmax/2. The utilization is built up to 100% after several periods.
> > The clock_pelt runs at 1/2 speed of the clock_task. We are loosing the idle time
> > all along. What happens when the CPU enters idle for a short duration and comes
> > back to run this 100% utilization task?
> 
> If you are at 100%, we only apply the short idle duration
> 
> >
> > If the above block is not present i.e lost_idle_time is not tracked, we
> > stretch the idle time (since clock_pelt is synced to clock_task) and the
> > utilization is dropped. Right?
> 
> yes that 's what would happen. I gives more details below
> 
> >
> > With the above block, we don't stretch the idle time. In fact we don't
> > consider the idle time at all. Because,
> >
> > idle_time = now - last_time;
> >
> > idle_time = (rq->clock_pelt - rq->lost_idle_time) - last_time
> > idle_time = (rq->clock_task - rq_clock_task + rq->clock_pelt_old) - last_time
> > idle_time = rq->clock_pelt_old - last_time
> >
> > The last time is nothing but the last snapshot of the rq->clock_pelt when the
> > task entered sleep due to which CPU entered idle.
> 
> The condition for dropping this idle time is quite important. This
> only happens when the utilization reaches max compute capacity of the
> CPU. Otherwise, the idle time will be fully applied

Right.

rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt

This not only tracks the lost idle time due to running slow but also the
absolute/real sleep time. For example, when the slow running 100% task
sleeps for 100 msec, are not we ignoring the 100 msec sleep there?

For example a task ran 323 msec at full capacity and sleeps for (1000-323)
msec. when it wakes up the utilization is dropped. If the same task runs
for 626 msec at the half capacity and sleeps for (1000-626), should not
drop the utilization by taking (1000-626) sleep time into account. I
understand that why we don't strech idle time to (1000-323) but it is not
clear to me why we completely drop the idle time.

> 
> >
> > Can you please explain the significance of the above block with an example?
> 
> The pelt signal reaches its max value after 323ms at full capacity,
> which means that we can't make any difference between tasks running
> 323ms, 500ms or more at max capacity. As a result, we consider that
> the CPU is fully used and there is no idle time when the utilization
> equals max capacity. If CPU runs at half the capacity, it will run
> 626ms before reaching max utilization and at that time we will stop to
> stretch the idle time because we consider that there is no idle time
> to stretch. By default, we never drop the idle time which is a
> necessary for being fully invariant and we always apply it. But we
> have to drop it when we consider that it would not have been present
> at max capacity too. That's all the purpose of the block that you
> mention

This is very much clear.

> 
> Let take a task that runs 120 ms with a period of 330ms.
> At max capacity, task utilization will vary in the range [10-949]
> At half capacity, task will run 240ms and the range will stay the same
> as the idle time and the running time will be the same once stretched
> and scaled
> At one third of the capacity, task should run 360ms in a period of 330
> which means that the task will always run and will probably even lost
> some events as it will have not finished when the new period will
> start. In this case, the task/CPU utilization will reach the max value
> just like an always running task. As we can't make any difference
> anymore, we consider that there is no idle time to recover once the
> cpu will become idle and the block of code that you mention above will
> cancel the stretch of idle time.
> 

Got it.

> >
> > > +
> > > +             /* The rq is idle, we can sync to clock_task */
> > > +             rq->clock_pelt  = rq_clock_task(rq);
> > > +
> > > +
> > > +     } else {
> > > +             /*
> > > +              * When a rq runs at a lower compute capacity, it will need
> > > +              * more time to do the same amount of work than at max
> > > +              * capacity: either because it takes more time to compute the
> > > +              * same amount of work or because taking more time means
> > > +              * sharing more often the CPU between entities.
> > > +              * In order to be invariant, we scale the delta to reflect how
> > > +              * much work has been really done.
> > > +              * Running at lower capacity also means running longer to do
> > > +              * the same amount of work and this results in stealing some
> > > +              * idle time that will disturb the load signal compared to
> > > +              * max capacity; This stolen idle time will be automaticcally
> > > +              * reflected when the rq will be idle and the clock will be
> > > +              * synced with rq_clock_task.
> > > +              */
> > > +
> > > +             /*
> > > +              * scale the elapsed time to reflect the real amount of
> > > +              * computation
> > > +              */
> > > +             delta = cap_scale(delta, arch_scale_freq_capacity(cpu_of(rq)));
> > > +             delta = cap_scale(delta, arch_scale_cpu_capacity(NULL, cpu_of(rq)));
> > > +
> > > +             rq->clock_pelt += delta;
> >
> > AFAICT, the rq->clock_pelt is used for both utilization and load. So the load
> > also becomes a function of CPU uarch now. Is this intentional?
> 
> yes, it is. Load is not scaled with uarch in current implementation
> because the load would cap by the max capacity of the local CPU and
> this mess up the load balance.
> 
> Let take the example of CPU0 with max capacity of 1024 and CPU1 with
> max capacity of 512.
> We have 6 always running tasks  with same nice priority
> Then, put 3 tasks on each CPU.
> If the load is scaled/capped with uarch, LB will consider the system
> balanced : 3*max_load / 1024 for CPU0 and 3*(max_load / 2) / 512 for
> CPU1. But tasks on CPU0 have twice more compute capacity than tasks on
> CPU1.
> 
> With the new scaling, we don't have this problem anymore so we can
> take into account uarch and have more accurate load.
> 
Got it.

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

