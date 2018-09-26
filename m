Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D46FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401F120843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401F120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeIZQ4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:56:25 -0400
Received: from foss.arm.com ([217.140.101.70]:42872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbeIZQ4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:56:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1FB9ED1;
        Wed, 26 Sep 2018 03:44:03 -0700 (PDT)
Received: from e110439-lin (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E40303F5BD;
        Wed, 26 Sep 2018 03:44:00 -0700 (PDT)
Date:   Wed, 26 Sep 2018 11:43:55 +0100
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
Message-ID: <20180926104355.GA3980@e110439-lin>
References: <20180828135324.21976-15-patrick.bellasi@arm.com>
 <20180904134748.GA4974@localhost.localdomain>
 <20180906144053.GD25636@e110439-lin>
 <20180914111003.GC24082@hirez.programming.kicks-ass.net>
 <20180914140732.GR1413@e110439-lin>
 <20180914142813.GM24124@hirez.programming.kicks-ass.net>
 <20180917122723.GS1413@e110439-lin>
 <20180921091308.GD24082@hirez.programming.kicks-ass.net>
 <20180924151400.GT1413@e110439-lin>
 <20180925154956.GA30146@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925154956.GA30146@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-Sep 17:49, Peter Zijlstra wrote:
> On Mon, Sep 24, 2018 at 04:14:00PM +0100, Patrick Bellasi wrote:

[...]

> Well, with DL there are well defined rules for what to put in and what
> to then expect.
> 
> For this thing, not so much I feel.

Maybe you'll prove me wrong, but that's not already something happening
for things like priorities?

When you set a prio for a CFS task you don't really know how much
more/less CPU time a CFS task will get, because it depends on other
tasks prios and tasks from higher prio classes.

The priority is thus a knob which defines an "intended behavior", a
preference, without being "legally binding" like in the case of DL
bandwidth... nevertheless we can still make a good use of prios.

[...]

> > In the clamping case, it's still the user-space that needs to figure
> > our an optimal clamp value, while considering your performance and
> > energy efficiency goals. This can be based on an automated profiling
> > process which comes up with "optimal" clamp values.
> > 
> > In the DL case, we are perfectly fine to have a running time
> > parameter, although we don't give any precise and deterministic
> > formula to quantify it. It's up to user-space to figure out the
> > required running time for a given app and platform.
> > It's also not unrealistic the case you need to close a control loop
> > with user-space to keep updating this requirement.
> > 
> > Why the same cannot hold for clamp values ?
> 
> The big difference is that if I request (and am granted) a runtime quota
> of a given amount, then that is what I'm guaranteed to get.

(I think not always... but that's a detail for a different discussion)

> Irrespective of the amount being sufficient for the work in question --
> which is where the platform dependency comes in.
> 
> But what am I getting when I set a specific clamp value? What does it
> mean to set the value to 80%

Exactly, that's a good point: which "expectations" can we set on users
based on a given value ?

> So far the only real meaning is when combined with the EAS OPP data, we
> get a direct translation to OPPs. Irrespective of how the utilization is
> measured and the capacity:OPP mapping established, once that's set, we
> can map a clamp value to an OPP and get meaning.

If we strictly follow this line of reasoning then we should probably
set a frequency value directly...  but still we will not be saying
anything about "expectations".

Give the current patchset, right now we can't do much more then
_biasing_ an OPP selection.
It's actually just a bias, we cannot really grant anything to users
based on clamping. For example, if you require util_min=1024 you are
not really granted anything about running at the maximum capacity,
especially in the current patchset where we are not biasing task
placement.

My fear then is, since we are not really granting/enforcing anything,
why should we base such an interface on an internal implementation
detail and/or platform specific values ?

Why a slightly more abstract interface is so much more confusing ?

> But without that, it doesn't mean anything much at all. And that is my
> complaint. It seems to get presented as: 'random knob that might do
> something'. The range it takes as input doesn't change a thing.

Can not the "range" help in defining the perceived expectations ?

If we use a percentage, IMHO it's more clear that's a _relative_ and
_not mandatory_ interface:

  relative: because, for example, a 50% capped task is expected
            (normally) to run slower then a 50% boosted task, although
            we don't know, or care to know, the exact frequency or cpu
            capacity

  not mandatory: because, for example, the 50% boosted task is not
                 granted to always run at an OPP which capacity is
                 not smaller then 512

> > > How are expecting people to determine what to put into the interface?

The same way people define priorities. Which means, with increasing
level of complexity:

 a) by guessing (or using the default, i.e. no clamps)

 b) by making an educated choice
   i.e. profiling your app to pick the value which makes more sense
        give the platform and a set of optimization goals

 c) by controlling in a closed feedback loop
    i.e. by periodically measuring some app specific power/perf metric
    and tuning the clamp values to close a gap with respect to a given
    power/perf

I think that the complexity of both b) and c) is not really impacted
by the scale/range used... but it also does not benefit much in
"clarity" if we use capacity values instead of percentages.

> > > Knee points, little capacity, those things make 'obvious' sense.

> > IMHO, they make "obvious" sense from a kernel-space perspective
> > exactly because they are implementation details and platform specific
> > concepts.
> > 
> > At the same time, I struggle to provide a definition of knee point and
> > I struggle to find a use-case where I can certainly say that a task
> > should be clamped exactly to the little capacity for example.
> > 
> > I'm more of the idea that the right clamp value is something a bit
> > fuzzy and possibly subject to change over time depending on the
> > specific application phase (e.g. cpu-vs-memory bounded) and/or
> > optimization goals (e.g. performance vs energy efficiency).

What do you think about this last my sentence above ?

> > Here we are thus at defining and agree about a "generic and abstract"
> > interface which allows user-space to feed input to kernel-space.
> > To this purpose, I think platform specific details and/or internal
> > implementation details are not "a bonus".
> 
> But unlike DL, which has well specified behaviour, and when I know my
> platform I can compute a usable value. This doesn't seem to gain meaning
> when I know the platform.
> 
> Or does it?

... or we don't really care about a platform specific meaning.

> If you say yes, then we need to be able to correlate to the platform
> data that gives it meaning; which would be the OPP states. And those
> come with capacity numbers.

The meaning, strictly speaking, should be just:

   I figured out (somehow) that if I set value X my app is now working
   as expected in terms of the acceptable power/performance
   optimization goal.

   I know that value X could require tuning over time depending on
   possible changes in platform status or tasks composition.

[...]

> > Internally, in kernel space, we use 1024 units. It's just the
> > user-space interface that speaks percentages but, as soon as a
> > percentage value is used to configure a clamp, it's translated into a
> > [0..1024] range value.
> > 
> > Is this not an acceptable compromise? We have a generic user-space
> > interface and an effective/consistent kernel-space implementation.
> 
> I really don't see how changing the unit changes anything. Either you
> want to relate to OPPs and those are exposed in 1/1024 unit capacity
> through the EAS files, or you don't and then the knob has no meaning.
> 
> And how the heck are we supposed to assign a value for something that
> has no meaning.
> 
> Again, with DL we ask for time, once I know the platform I can convert
> my work into instructions and time and all makes sense.
> 
> With this, you seem reluctant to allow us to close that loop. Why is
> that? Why not directly relate to the EAS OPPs, because that is directly
> what they end up mapping to.

I'm not really fighting against that, if people find it more intuitive
the usage of capacities we can certainly go for them.

My reluctance is really just tossing out a possible different
perspective considering we are adding a user-space API which
certainly set "expectations" to users.

Provided it's clear the concept that it's a _non mandatory_ and
_relative_ API, then any scale should be ok... I just personally
prefer a percentage for the reasons described above.

In both cases, who will use the interface can certainly close a
loop... especially an automated profiling or run-time control loop.

> When I know the platform, I can convert my work into instructions and
> obtain time, I can convert my clamp into an OPP and time*OPP gives an
> energy consumption.

What you describe makes sense, it can definitively help the human user
to set a value. I'm just not convinced this will be the main usage of
such an interface... or that a single value could fit all the
run-time scenarios.

I think in real workload scenarios we will have so many tasks, some
competing other cooperating, that it will not be possible to do the
exercise you describe above.

What we will do instead will probably be to close a profiling/control
loop from user-space and let the system figure out the optimal
value. In these cases, the platform details are just "informative"
and what we need is really just "random knob which can do
something"... provide that "something" is a consistent mapping of the
knob values on certain scheduler actions.

> Why muddle things up and make it complicated?

I'll not push this further, really, if you are strongly on the
opinion we should use capacity I'll drop percentages in the next v5.

Otherwise, if you also are like me still a bit unsure for what could
be the best API, we can hope in more feedbacks from other folks...
maybe I can ping someone in CC ?

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
