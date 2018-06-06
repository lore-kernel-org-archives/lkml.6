Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41CE6601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbeFFKM1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:12:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38994 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752073AbeFFKM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:12:26 -0400
Date: Wed, 6 Jun 2018 11:12:22 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v5 00/10] track CPU utilization
Message-ID: <20180606101222.GB10870@e108498-lin.cambridge.arm.com>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <20180604165047.GU12180@hirez.programming.kicks-ass.net>
 <CAKfTPtDtx72OgxvA3vxnRiCW_UG24HSJ3oE_8j5Rx3-vP0gCeA@mail.gmail.com>
 <20180605141809.GV12180@hirez.programming.kicks-ass.net>
 <20180606094409.GA10870@e108498-lin.cambridge.arm.com>
 <CAKfTPtB4YJm=8dqf=9_o+jkL2fjShPtwyO-8tDAKCp9pW0Y3jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB4YJm=8dqf=9_o+jkL2fjShPtwyO-8tDAKCp9pW0Y3jQ@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 Jun 2018 at 11:59:04 (+0200), Vincent Guittot wrote:
> On 6 June 2018 at 11:44, Quentin Perret <quentin.perret@arm.com> wrote:
> > On Tuesday 05 Jun 2018 at 16:18:09 (+0200), Peter Zijlstra wrote:
> >> On Mon, Jun 04, 2018 at 08:08:58PM +0200, Vincent Guittot wrote:
> >> > On 4 June 2018 at 18:50, Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> > > So this patch-set tracks the !cfs occupation using the same function,
> >> > > which is all good. But what, if instead of using that to compensate the
> >> > > OPP selection, we employ that to renormalize the util signal?
> >> > >
> >> > > If we normalize util against the dynamic (rt_avg affected) cpu_capacity,
> >> > > then I think your initial problem goes away. Because while the RT task
> >> > > will push the util to .5, it will at the same time push the CPU capacity
> >> > > to .5, and renormalized that gives 1.
> >> > >
> >> > >   NOTE: the renorm would then become something like:
> >> > >         scale_cpu = arch_scale_cpu_capacity() / rt_frac();
> >>
> >> Should probably be:
> >>
> >>       scale_cpu = atch_scale_cpu_capacity() / (1 - rt_frac())
> >>
> >> > >
> >> > >
> >> > > On IRC I mentioned stopping the CFS clock when preempted, and while that
> >> > > would result in fixed numbers, Vincent was right in pointing out the
> >> > > numbers will be difficult to interpret, since the meaning will be purely
> >> > > CPU local and I'm not sure you can actually fix it again with
> >> > > normalization.
> >> > >
> >> > > Imagine, running a .3 RT task, that would push the (always running) CFS
> >> > > down to .7, but because we discard all !cfs time, it actually has 1. If
> >> > > we try and normalize that we'll end up with ~1.43, which is of course
> >> > > completely broken.
> >> > >
> >> > >
> >> > > _However_, all that happens for util, also happens for load. So the above
> >> > > scenario will also make the CPU appear less loaded than it actually is.
> >> >
> >> > The load will continue to increase because we track runnable state and
> >> > not running for the load
> >>
> >> Duh yes. So renormalizing it once, like proposed for util would actually
> >> do the right thing there too.  Would not that allow us to get rid of
> >> much of the capacity magic in the load balance code?
> >>
> >> /me thinks more..
> >>
> >> Bah, no.. because you don't want this dynamic renormalization part of
> >> the sums. So you want to keep it after the fact. :/
> >>
> >> > As you mentioned, scale_rt_capacity give the remaining capacity for
> >> > cfs and it will behave like cfs util_avg now that it uses PELT. So as
> >> > long as cfs util_avg <  scale_rt_capacity(we probably need a margin)
> >> > we keep using dl bandwidth + cfs util_avg + rt util_avg for selecting
> >> > OPP because we have remaining spare capacity but if  cfs util_avg ==
> >> > scale_rt_capacity, we make sure to use max OPP.
> >>
> >> Good point, when cfs-util < cfs-cap then there is idle time and the util
> >> number is 'right', when cfs-util == cfs-cap we're overcommitted and
> >> should go max.
> >>
> >> Since the util and cap values are aligned that should track nicely.
> >
> > So Vincent proposed to have a margin between cfs util and cfs cap to be
> > sure there is a little bit of idle time. This is _exactly_ what the
> > overutilized flag in EAS does. That would actually make a lot of sense
> > to use that flag in schedutil. The idea is basically to say, if there
> > isn't enough idle time on all CPUs, the util signal are kinda wrong, so
> > let's not make any decisions (task placement or OPP selection) based on
> > that. If overutilized, go to max freq. Does that make sense ?
> 
> Yes it's similar to the overutilized except that
> - this is done per cpu and whereas overutilization is for the whole system

Is this a good thing ? It has to be discussed. Anyways, the patch from
Morten which is part of the latest EAS posting (v3) introduces a
cpu_overutilized() function which does what you want I think.

> - the test is done at every freq update and not only during some cfs
> event and it uses the last up to date value and not a periodically
> updated snapshot of the value

Yeah good point. Now, the overutilized flag is attached to the root domain
so you should be able to set/clear it from RT/DL whenever that makes sense
I suppose. That's just a flag about the current state of the system so I
don't see why it should be touched only by CFS.

> - this is done also without EAS

The overutilized flag doesn't have to come with EAS if it is useful for
something else (OPP selection).

> 
> Then for the margin, it has to be discussed if it is really needed or not

+1

Thanks,
Quentin
