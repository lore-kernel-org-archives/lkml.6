Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E3CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61805206B2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61805206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbeIXVQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:16:44 -0400
Received: from foss.arm.com ([217.140.101.70]:37564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbeIXVQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:16:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BCB580D;
        Mon, 24 Sep 2018 08:14:05 -0700 (PDT)
Received: from e110439-lin (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DC483F5B7;
        Mon, 24 Sep 2018 08:14:02 -0700 (PDT)
Date:   Mon, 24 Sep 2018 16:14:00 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by
 default
Message-ID: <20180924151400.GT1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-15-patrick.bellasi@arm.com>
 <20180904134748.GA4974@localhost.localdomain>
 <20180906144053.GD25636@e110439-lin>
 <20180914111003.GC24082@hirez.programming.kicks-ass.net>
 <20180914140732.GR1413@e110439-lin>
 <20180914142813.GM24124@hirez.programming.kicks-ass.net>
 <20180917122723.GS1413@e110439-lin>
 <20180921091308.GD24082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921091308.GD24082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-Sep 11:13, Peter Zijlstra wrote:
> On Mon, Sep 17, 2018 at 01:27:23PM +0100, Patrick Bellasi wrote:
> > On 14-Sep 16:28, Peter Zijlstra wrote:
> 
> > > The thing is, the values you'd want to use are for example the capacity
> > > of the little CPUs. or the capacity of the most energy efficient OPP
> > > (the knee).
> > 
> > I don't think so.
> > 
> > On the knee topic, we had some thinking and on most platforms it seems
> > to be a rather arbitrary decision.
> > 
> > On sane platforms, the Energy Efficiency (EE) is monotonically
> > decreasing with frequency increase.  Maybe we can define a threshold
> > for a "EE derivative ratio", but it will still be quite arbitrary.
> > Moreover, it could be that in certain use-cases we want to push for
> > higher energy efficiency (i.e. lower derivatives) then others.
> 
> I remember IBM-power folks asking for knee related features a number of
> years ago (Dusseldorf IIRC) because after some point their chips start
> to _really_ suck power. Sure, the curve is monotonic, but the perf/watt
> takes a nose dive.
> 
> And given that: P = CfV^2, that seems like a fairly generic observation.
> 
> However, maybe, due to the very limited thermal capacity of these mobile
> things, the issue doesn't really arrise in them.

The curve is still following the equation above for mobile devices
too and it's exactly by looking at that curve that's rather arbitrary
to defined a knee point (more on that later)...

> Laptops with active cooling however...

How do you see active cooling playing a role ?

Are you thinking, for example, at reduced fan noise if we remain below
a certain OPP ?

Are you factoring fans power consumptions into the overall P consumption ?

> > > Similarly for boosting, how are we 'easily' going to find the values
> > > that correspond to the various available OPPs.
> > 
> > In our experience with SchedTune on Android, we found that we
> > generally focus on a small set of representative use-cases and then
> > run an exploration, by tuning the percentage of boost, to identify the
> > optimal trade-off between Performance and Energy.
> 
> So you basically do an automated optimization for a benchmark?

Not on one single benchmark, we consider a set of interesting
use-cases. We mostly focus on:
- interactivity: no jank frames while scrolling fast on list/views
- power efficiency: on common video/audio playback scenarios

The exploration of some optimization parameters can be automated.
However, at the end there is always a rather arbitrary decision to
take: you can be slightly more oriented towards interactive
performance or energy efficient.

Maybe (in the future) you can also see AI/ML, used from user-space, to
figure out the fine tuning based on user's usage patterns for different
apps... ;)

> > The value you get could be something which do not match exactly an OPP
> > but still, since we (will) bias not only OPP selection but also tasks
> > placement, it's the one which makes most sense.
> 
> *groan*, so how exactly does that work? By limiting the task capacity,
> we allow some stacking on the CPUs before we switch to regular
> load-balancing?

This is a big topic in itself, one of the reasons why we did not added
it in this series. We will need dedicated discussions to figure out
something reasonable.

In principle, however, by capping the utilization of tasks and their
CPUs we can aim at a way to remain in energy_aware mode, i.e. below
the tipping point, and thus with load-balancing disabled.

Utilization clamping can be used to bias the CPUs selection from the
EA code paths. Other mechanisms, e.g. bandwidth control, can also be
exploited to keep CPU utilization under control.

> > Thus, the capacity of little CPUs, or the exact capacity of an OPP, is
> > something we don't care to specify exactly, since:
> > 
> >  - schedutil will top the util request to the next frequency anyway
> > 
> >  - capacity by itself is a loosely defined metric, since it's usually
> >    measured considering a specific kind of instructions mix, which
> >    can be very different from the actual instruction mix (e.g. integer
> >    vs floating point)
> 
> Sure, things like pure SIMD workloads can skew things pretty bad, but on
> average it should not drastically change the overall shape of the curve
> and the knee point should not move around a lot.

There can be quite consistent skews based not just on instructions
type but also "app phases", e.g. memory-vs-cpu bound.
It's also true that's more likely a shift up/down in the capacity axis
then a change in shape.

However, I think my point here is that the actual capacity of each OPP
can be very different wrt the one reported by the EM.

> >  - certain platforms don't even expose OPPs, but just "performance
> >    levels"... which ultimately are a "percentage"
> 
> Well, the whole capacity thing is a 'percentage', it's just that 1024 is
> much nicer to work with (for computers) than 100 is (also it provides a
> wee bit more resolution).

Right, indeed in kernel-space we still use 1024 based values, we just
convert them at the syscall interface...

> But even the platforms with hidden OPPs (can) have knee points, and if
> you measure their power to capacity curve you can place a workload
> around the knee by capping capacity.

... still it's difficult to give a precise definition of knee point,
unless you know about platforms which have a sharp change in energy
efficiency.

The only cases we know about are those where:

A) multiple frequencies uses the same voltage, e.g.


     ^                                     *
     | Energy                              O
     | efficiency                         O+
     |                                   O |
     |                                 O*  |
     |                              O**    |
     |   O**                    O***       |
     |   +  O**            O****           |
     |   |     O**   O*****                |
     |   |        O**                      |
     |   |          +                      |
     |   |  Same V  |   Increasing V       |
     +---+----------+----------------------+----------->
         |          |                      | Frequency
         L          M                      H

B) there is a big frequency gap between low frequency OPPs and high
   frequency OPPs, e.g.

                                       O
    ^                                **+
    | Energy                       **  |
    | efficiency                 **    |
    |                          **      |
    |                        **        |
    |                      **          |
    |                    **            |
    |                  **              |
    |               O**                |
    |        O******+                  |
    |O*******       |                  |
    |               |                  |
    ++--------------+------------------+------>
     |              |                  |  Frequency
     L              M                  H


In case A, all the OPPs left of M are dominated by M in terms
of energy efficiency and normally they should be never used.
Unless you are under thermal constraints and you still want to keep
your code running even if at a lower rate and energy efficiency.
At this point, however, you already invalidated all the OPPs right of
M and, on the remaining, you still struggle do define the knee point.

In case B... I'm wondering it such a conf even makes sense ;)
Is there really some platform out there with such a "non homogeneously
distributed" set of available frequencies ?

> But yes, this gets trick real fast :/
> 
> >  - there are so many rounding errors around on utilization tracking
> >    and it aggregation that being exact on an OPP if of "relative"
> >    importance
> 
> I'm not sure I understand that argument; sure the measurement is subject
> to 'issues', but if we hard clip the result, that will exactly match the
> fixed points for OPP selection. Any issues on the measurement are lost
> after clipping.

My point is just that the clipping does not requires to be specified
as the actual capacity of an OPP.

If we give a "performance level" P then schedutil already knows how to
translate it into an OPP, it will pick the min capacity OPP which
capacity is greater then P.

However, given the knee definition is anyway fuzzy, selecting either
that OPP or the previous one, should almost always not make a big
difference from a "knee" standpoint, isn't it ?

> > Do you see specific use-cases where an exact OPP capacity is much
> > better then a percentage value ?
> 
> If I don't have algorithmic optimization available, hand selecting an
> OPP is the 'obvious' thing to do.

Agree, but that's still possible by passing in a percentage value.

> > Of course there can be scenarios in which wa want to clamp to a
> > specific OPP. But still, why should it be difficult for a platform
> > integrator to express it as a close enough percentage value ?
> 
> But why put him through the trouble of finding the capacity value in the
> EAS exposed data, converting that to a percentage that will work and
> then feeding it back in.
>
> I don't see the point or benefit of percentages, there's nothing magical
> about 1/100, _any_ other fraction works exactly the same.

If you wanna pass in an exact capacity data, you still need to look at
EAS exposed data, don't you?

I think the main problem is picking the right capacity, more then
converting it to a percentage.

Once you got a capacity, let say 654, it's conversion to percentage is
as simple as dropping the units, i.e. 654 ~= 65%, that's quite sure to
pick the 654 capacity OPP anyway.


> So why bother changing it around?

For two main reasons:

1) to expose userspace a more generic interface:
   a "performance percentage" is more generic then a "capacity value"
   while keep translating and using a 1024 based value in kernel space

2) to reduce the configuration space:
   it quite likely doesn't make sense to use, in the same system, 100
   difference clamp values... it makes even more sense to use 1024
   different clamp values, does it ?

> > > The EAS thing might have these around; but I forgot if/how they're
> > > exposed to userspace (I'll have to soon look at the latest posting).
> > 
> > The new "Energy Model Management" framework can certainly be use to
> > get the list of OPPs for each frequency domain. IMO this could be
> > used to identify the maximum number of clamp groups we can have.
> > In this case, the discretization patch can translate a generic
> > percentage clamp into the closest OPP capacity... 
> > 
> > ... but to me that's an internal detail which I'm not convinced we
> > don't need to expose to user-space.
> > 
> > IMHO we should instead focus just on defining a usable and generic
> > userspace interface. Then, platform specific tuning is something
> > user-space can do, either offline or on-line.
> 
> The thing I worry about is how do we determine the value to put in in
> the first place.

I agree that's the main problem, but I also think that's outside of
the kernel-space mechanism.

Is not all that quite similar to DEADLINE tasks configuration?

Given a DL task solving a certain issue, you can certainly define its
deadline (or period) on a completely platform independent way, by just
looking at the problem space. But when it comes to the run-time, we
always have to profile the task in a platform specific way.

In the DL case from user-space we figure out a bandwidth requirement.

In the clamping case, it's still the user-space that needs to figure
our an optimal clamp value, while considering your performance and
energy efficiency goals. This can be based on an automated profiling
process which comes up with "optimal" clamp values.

In the DL case, we are perfectly fine to have a running time
parameter, although we don't give any precise and deterministic
formula to quantify it. It's up to user-space to figure out the
required running time for a given app and platform.
It's also not unrealistic the case you need to close a control loop
with user-space to keep updating this requirement.

Why the same cannot hold for clamp values ?

> How are expecting people to determine what to put into the interface?
> Knee points, little capacity, those things make 'obvious' sense.

IMHO, they make "obvious" sense from a kernel-space perspective
exactly because they are implementation details and platform specific
concepts.

At the same time, I struggle to provide a definition of knee point and
I struggle to find a use-case where I can certainly say that a task
should be clamped exactly to the little capacity for example.

I'm more of the idea that the right clamp value is something a bit
fuzzy and possibly subject to change over time depending on the
specific application phase (e.g. cpu-vs-memory bounded) and/or
optimization goals (e.g. performance vs energy efficiency).

Here we are thus at defining and agree about a "generic and abstract"
interface which allows user-space to feed input to kernel-space.
To this purpose, I think platform specific details and/or internal
implementation details are not "a bonus".

> > > But changing the clamp metric to something different than these values
> > > is going to be pain.
> > 
> > Maybe I don't completely get what you mean here... are you saying that
> > not using exact capacity values to defined clamps is difficult ?
> > If that's the case why? Can you elaborate with an example ?
> 
> I meant changing the unit around, 1/1024 is what we use throughout and
> is what EAS is also exposing IIRC, so why make things complicated again
> and use 1/100 (which is a shit fraction for computers).

Internally, in kernel space, we use 1024 units. It's just the
user-space interface that speaks percentages but, as soon as a
percentage value is used to configure a clamp, it's translated into a
[0..1024] range value.

Is this not an acceptable compromise? We have a generic user-space
interface and an effective/consistent kernel-space implementation.

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
