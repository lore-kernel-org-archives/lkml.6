Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932094AbeFEW1k (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 18:27:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932070AbeFEW1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 18:27:39 -0400
Date: Wed, 6 Jun 2018 00:27:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v5 00/10] track CPU utilization
Message-ID: <20180605222730.GA12180@hirez.programming.kicks-ass.net>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <20180604165047.GU12180@hirez.programming.kicks-ass.net>
 <CAKfTPtDtx72OgxvA3vxnRiCW_UG24HSJ3oE_8j5Rx3-vP0gCeA@mail.gmail.com>
 <20180605141809.GV12180@hirez.programming.kicks-ass.net>
 <20180605153826.GE32302@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605153826.GE32302@e110439-lin>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 04:38:26PM +0100, Patrick Bellasi wrote:
> On 05-Jun 16:18, Peter Zijlstra wrote:
> > On Mon, Jun 04, 2018 at 08:08:58PM +0200, Vincent Guittot wrote:

> > > As you mentioned, scale_rt_capacity give the remaining capacity for
> > > cfs and it will behave like cfs util_avg now that it uses PELT. So as
> > > long as cfs util_avg <  scale_rt_capacity(we probably need a margin)
> > > we keep using dl bandwidth + cfs util_avg + rt util_avg for selecting
> > > OPP because we have remaining spare capacity but if  cfs util_avg ==
> > > scale_rt_capacity, we make sure to use max OPP.
> 
> What will happen for the 50% task of the example above?

When the cfs-cap reaches 50% (where cfs_cap := 1 - rt_avg - dl_avg -
stop_avg - irq_avg) a cfs-util of 50% means that there is no idle time.

So util will still be 50%, nothing funny. But frequency selection will
see util==cap and select max (it might not have because reduction could
be due to IRQ pressure for example).

At the moment cfs-cap rises (>50%), and the cfs-util stays at 50%, we'll
have 50% utilization. We know there is idle time, the task could use
more if it wanted to.

> > Good point, when cfs-util < cfs-cap then there is idle time and the util
> > number is 'right', when cfs-util == cfs-cap we're overcommitted and
> > should go max.
> 
> Again I cannot easily read the example above...
> 
> Would that mean that a 50% CFS task, preempted by a 50% RT task (which
> already set OPP to max while RUNNABLE) will end up running at the max
> OPP too?

Yes, because there is no idle time. When there is no idle time, max freq
is the right frequency.

The moment cfs-util drops below cfs-cap, we'll stop running at max,
because at that point we've found idle time to reduce frequency with.

> > Since the util and cap values are aligned that should track nicely.
> 
> True... the only potential issue I see is that we are steering PELT
> behaviors towards better driving schedutil to run high-demand
> workloads while _maybe_ affecting quite sensibly the capacity of PELT
> to describe how much CPU a task uses.
> 
> Ultimately, utilization has always been a metric on "how much you
> use"... while here it seems to me we are bending it to be something to
> define "how fast you have to run".

This latest proposal does not in fact change the util tracking. But in
general, 'how much do you use' can be a very difficult question, see the
whole turbo / hardware managed dvfs discussion a week or so ago.
