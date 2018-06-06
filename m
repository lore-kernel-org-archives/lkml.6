Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BED1960555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeFFOKt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:10:49 -0400
Received: from foss.arm.com ([217.140.101.70]:40916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751851AbeFFOKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:10:48 -0400
Date: Wed, 6 Jun 2018 15:10:44 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Claudio Scordino <claudio@evidence.eu.com>
Cc: Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>
Subject: Re: [PATCH v5 00/10] track CPU utilization
Message-ID: <20180606141044.GE10870@e108498-lin.cambridge.arm.com>
References: <CAKfTPtB0MHN3=VbS4mYqVH_0fv1WwKq6N1-ogU84mNUAxfCwjw@mail.gmail.com>
 <20180605105721.GA12193@e108498-lin.cambridge.arm.com>
 <20180605121153.GD16081@localhost.localdomain>
 <20180605130548.GB12193@e108498-lin.cambridge.arm.com>
 <20180605131518.GG16081@localhost.localdomain>
 <20180605140101.GE12193@e108498-lin.cambridge.arm.com>
 <20180605141317.GJ16081@localhost.localdomain>
 <6c2dc1aa-3e19-be14-0ed8-b29003c72e61@evidence.eu.com>
 <20180606132046.GC10870@e108498-lin.cambridge.arm.com>
 <CAGWmfYrUGPABWB3MY+zOaB3HWhsX=Wkacx17B20aq04dcWtZjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWmfYrUGPABWB3MY+zOaB3HWhsX=Wkacx17B20aq04dcWtZjg@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 Jun 2018 at 15:53:27 (+0200), Claudio Scordino wrote:
> Hi Quentin,
> 
> 2018-06-06 15:20 GMT+02:00 Quentin Perret <quentin.perret@arm.com>:
> >
> > Hi Claudio,
> >
> > On Wednesday 06 Jun 2018 at 15:05:58 (+0200), Claudio Scordino wrote:
> > > Hi Quentin,
> > >
> > > Il 05/06/2018 16:13, Juri Lelli ha scritto:
> > > > On 05/06/18 15:01, Quentin Perret wrote:
> > > > > On Tuesday 05 Jun 2018 at 15:15:18 (+0200), Juri Lelli wrote:
> > > > > > On 05/06/18 14:05, Quentin Perret wrote:
> > > > > > > On Tuesday 05 Jun 2018 at 14:11:53 (+0200), Juri Lelli wrote:
> > > > > > > > Hi Quentin,
> > > > > > > >
> > > > > > > > On 05/06/18 11:57, Quentin Perret wrote:
> > > > > > > >
> > > > > > > > [...]
> > > > > > > >
> > > > > > > > > What about the diff below (just a quick hack to show the idea) applied
> > > > > > > > > on tip/sched/core ?
> > > > > > > > >
> > > > > > > > > ---8<---
> > > > > > > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > > > > > > > index a8ba6d1f262a..23a4fb1c2c25 100644
> > > > > > > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > > > > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > > > > > > @@ -180,9 +180,12 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
> > > > > > > > >           sg_cpu->util_dl  = cpu_util_dl(rq);
> > > > > > > > >   }
> > > > > > > > > +unsigned long scale_rt_capacity(int cpu);
> > > > > > > > >   static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> > > > > > > > >   {
> > > > > > > > >           struct rq *rq = cpu_rq(sg_cpu->cpu);
> > > > > > > > > + int cpu = sg_cpu->cpu;
> > > > > > > > > + unsigned long util, dl_bw;
> > > > > > > > >           if (rq->rt.rt_nr_running)
> > > > > > > > >                   return sg_cpu->max;
> > > > > > > > > @@ -197,7 +200,14 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> > > > > > > > >            * util_cfs + util_dl as requested freq. However, cpufreq is not yet
> > > > > > > > >            * ready for such an interface. So, we only do the latter for now.
> > > > > > > > >            */
> > > > > > > > > - return min(sg_cpu->max, (sg_cpu->util_dl + sg_cpu->util_cfs));
> > > > > > > > > + util = arch_scale_cpu_capacity(NULL, cpu) * scale_rt_capacity(cpu);
> > > > > > > >
> > > > > > > > Sorry to be pedantinc, but this (ATM) includes DL avg contribution, so,
> > > > > > > > since we use max below, we will probably have the same problem that we
> > > > > > > > discussed on Vincent's approach (overestimation of DL contribution while
> > > > > > > > we could use running_bw).
> > > > > > >
> > > > > > > Ah no, you're right, this isn't great for long running deadline tasks.
> > > > > > > We should definitely account for the running_bw here, not the dl avg...
> > > > > > >
> > > > > > > I was trying to address the issue of RT stealing time from CFS here, but
> > > > > > > the DL integration isn't quite right which this patch as-is, I agree ...
> > > > > > >
> > > > > > > >
> > > > > > > > > + util >>= SCHED_CAPACITY_SHIFT;
> > > > > > > > > + util = arch_scale_cpu_capacity(NULL, cpu) - util;
> > > > > > > > > + util += sg_cpu->util_cfs;
> > > > > > > > > + dl_bw = (rq->dl.this_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
> > > > > > > >
> > > > > > > > Why this_bw instead of running_bw?
> > > > > > >
> > > > > > > So IIUC, this_bw should basically give you the absolute reservation (== the
> > > > > > > sum of runtime/deadline ratios of all DL tasks on that rq).
> > > > > >
> > > > > > Yep.
> > > > > >
> > > > > > > The reason I added this max is because I'm still not sure to understand
> > > > > > > how we can safely drop the freq below that point ? If we don't guarantee
> > > > > > > to always stay at least at the freq required by DL, aren't we risking to
> > > > > > > start a deadline tasks stuck at a low freq because of rate limiting ? In
> > > > > > > this case, if that tasks uses all of its runtime then you might start
> > > > > > > missing deadlines ...
> > > > > >
> > > > > > We decided to avoid (software) rate limiting for DL with e97a90f7069b
> > > > > > ("sched/cpufreq: Rate limits for SCHED_DEADLINE").
> > > > >
> > > > > Right, I spotted that one, but yeah you could also be limited by HW ...
> > > > >
> > > > > >
> > > > > > > My feeling is that the only safe thing to do is to guarantee to never go
> > > > > > > below the freq required by DL, and to optimistically add CFS tasks
> > > > > > > without raising the OPP if we have good reasons to think that DL is
> > > > > > > using less than it required (which is what we should get by using
> > > > > > > running_bw above I suppose). Does that make any sense ?
> > > > > >
> > > > > > Then we can't still avoid the hardware limits, so using running_bw is a
> > > > > > trade off between safety (especially considering soft real-time
> > > > > > scenarios) and energy consumption (which seems to be working in
> > > > > > practice).
> > > > >
> > > > > Ok, I see ... Have you guys already tried something like my patch above
> > > > > (keeping the freq >= this_bw) in real world use cases ? Is this costing
> > > > > that much energy in practice ? If we fill the gaps left by DL (when it
> > > >
> > > > IIRC, Claudio (now Cc-ed) did experiment a bit with both approaches, so
> > > > he might add some numbers to my words above. I didn't (yet). But, please
> > > > consider that I might be reserving (for example) 50% of bandwidth for my
> > > > heavy and time sensitive task and then have that task wake up only once
> > > > in a while (but I'll be keeping clock speed up for the whole time). :/
> > >
> > > As far as I can remember, we never tested energy consumption of running_bw
> > > vs this_bw, as at OSPM'17 we had already decided to use running_bw
> > > implementing GRUB-PA.
> > > The rationale is that, as Juri pointed out, the amount of spare (i.e.
> > > reclaimable) bandwidth in this_bw is very user-dependent. For example,
> > > the user can let this_bw be much higher than the measured bandwidth, just
> > > to be sure that the deadlines are met even in corner cases.
> >
> > Ok I see the issue. Trusting userspace isn't necessarily the right thing
> > to do, I totally agree with that.
> >
> > > In practice, this means that the task executes for quite a short time and
> > > then blocks (with its bandwidth reclaimed, hence the CPU frequency reduced,
> > > at the 0lag time).
> > > Using this_bw rather than running_bw, the CPU frequency would remain at
> > > the same fixed value even when the task is blocked.
> > > I understand that on some cases it could even be better (i.e. no waste
> > > of energy in frequency switch).
> >
> > +1, I'm pretty sure using this_bw is pretty much always worst than
> > using running_bw from an energy standpoint,. The waste of energy in
> > frequency changes should be less than the energy wasted by staying at a
> > too high frequency for a long time, otherwise DVFS isn't a good idea to
> > begin with :-)
> >
> > > However, IMHO, these are corner cases and in the average case it is better
> > > to rely on running_bw and reduce the CPU frequency accordingly.
> >
> > My point was that accepting to go at a lower frequency than required by
> > this_bw is fundamentally unsafe. If you're at a low frequency when a DL
> > task starts, there are real situations where you won't be able to
> > increase the frequency immediately, which can eventually lead to missing
> > deadlines.
> 
> 
> I see. Unfortunately, I'm having quite crazy days so I couldn't follow
> the original discussion on LKML properly. My fault.

No problem !

> Anyway, to answer your question (if this time I have understood it correctly).
> 
> You're right: the tests have shown that whenever the DL task period
> gets comparable with the time for switching frequency, the amount of
> missed deadlines becomes not negligible.
> To give you a rough idea, this already happens with periods of 10msec
> on a Odroid XU4.
> The reason is that the task instance starts at a too low frequency,
> and the system can't switch frequency in time for meeting the
> deadline.

Ok that's very interesting ...

> 
> This is a known issue, partially discussed during the RT Summit'17.
> However, the community has been more in favour of reducing the energy
> consumption than meeting firm deadlines.
> If you need a safe system, in fact, you'd better thinking about
> disabling DVFS completely and relying on a fixed CPU frequency.

Yeah, understood. My proposition was sort of a middle-ground solution. I
was basically suggesting to select OPPs with something like:

        max(this_bw, running_bw + cfs_util)

The idea is that you're always guaranteed to always request a high enough
frequency for this_bw, and you can opportunistically try to run CFS tasks
without raising the OPP if running_bw is low. In the worst case, the CFS
tasks will be preempted and delayed a bit. But DL should always be safe.
And if the CFS activity is sufficient to fill the gap between running_bw
and this_bw, then you should be pretty energy efficient as well.

Now, that doesn't always solve the issue you mentioned earlier. If there
isn't much CFS traffic going on, and if the delta between this_bw and
running_bw is high, they you'll be stuck at a high freq although the
system utilization is low ... As usual, it's just a trade off :-)

> 
> A possible trade-off could be a further entry in sys to let system
> designers switching from (default) running_bw to (more pessimistic)
> this_bw.
> However, I'm not sure the community wants a further knob on sysfs just
> to make RT people happier :)
> 
> Best,
> 
>               Claudio
