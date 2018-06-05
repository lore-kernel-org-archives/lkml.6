Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeFEPic (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:38:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57660 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751599AbeFEPib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:38:31 -0400
Date: Tue, 5 Jun 2018 16:38:26 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20180605153826.GE32302@e110439-lin>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <20180604165047.GU12180@hirez.programming.kicks-ass.net>
 <CAKfTPtDtx72OgxvA3vxnRiCW_UG24HSJ3oE_8j5Rx3-vP0gCeA@mail.gmail.com>
 <20180605141809.GV12180@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605141809.GV12180@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-Jun 16:18, Peter Zijlstra wrote:
> On Mon, Jun 04, 2018 at 08:08:58PM +0200, Vincent Guittot wrote:
> > On 4 June 2018 at 18:50, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > So this patch-set tracks the !cfs occupation using the same function,
> > > which is all good. But what, if instead of using that to compensate the
> > > OPP selection, we employ that to renormalize the util signal?
> > >
> > > If we normalize util against the dynamic (rt_avg affected) cpu_capacity,
> > > then I think your initial problem goes away. Because while the RT task
> > > will push the util to .5, it will at the same time push the CPU capacity
> > > to .5, and renormalized that gives 1.

And would not that mean also that a 50% task co-scheduled with the
same 50% RT task, will be reported as a 100% util_avg task?

> > >
> > >   NOTE: the renorm would then become something like:
> > >         scale_cpu = arch_scale_cpu_capacity() / rt_frac();
> 
> Should probably be:
> 
> 	scale_cpu = atch_scale_cpu_capacity() / (1 - rt_frac())
> 
> > >
> > >
> > > On IRC I mentioned stopping the CFS clock when preempted, and while that
> > > would result in fixed numbers, Vincent was right in pointing out the
> > > numbers will be difficult to interpret, since the meaning will be purely
> > > CPU local and I'm not sure you can actually fix it again with
> > > normalization.
> > >
> > > Imagine, running a .3 RT task, that would push the (always running) CFS
> > > down to .7, but because we discard all !cfs time, it actually has 1. If
> > > we try and normalize that we'll end up with ~1.43, which is of course
> > > completely broken.
> > >
> > >
> > > _However_, all that happens for util, also happens for load. So the above
> > > scenario will also make the CPU appear less loaded than it actually is.
> > 
> > The load will continue to increase because we track runnable state and
> > not running for the load
> 
> Duh yes. So renormalizing it once, like proposed for util would actually
> do the right thing there too.  Would not that allow us to get rid of
> much of the capacity magic in the load balance code?
> 
> /me thinks more..
> 
> Bah, no.. because you don't want this dynamic renormalization part of
> the sums. So you want to keep it after the fact. :/
> 
> > As you mentioned, scale_rt_capacity give the remaining capacity for
> > cfs and it will behave like cfs util_avg now that it uses PELT. So as
> > long as cfs util_avg <  scale_rt_capacity(we probably need a margin)
> > we keep using dl bandwidth + cfs util_avg + rt util_avg for selecting
> > OPP because we have remaining spare capacity but if  cfs util_avg ==
> > scale_rt_capacity, we make sure to use max OPP.

What will happen for the 50% task of the example above?

> Good point, when cfs-util < cfs-cap then there is idle time and the util
> number is 'right', when cfs-util == cfs-cap we're overcommitted and
> should go max.

Again I cannot easily read the example above...

Would that mean that a 50% CFS task, preempted by a 50% RT task (which
already set OPP to max while RUNNABLE) will end up running at the max
OPP too?

> Since the util and cap values are aligned that should track nicely.

True... the only potential issue I see is that we are steering PELT
behaviors towards better driving schedutil to run high-demand
workloads while _maybe_ affecting quite sensibly the capacity of PELT
to describe how much CPU a task uses.

Ultimately, utilization has always been a metric on "how much you
use"... while here it seems to me we are bending it to be something to
define "how fast you have to run".

-- 
#include <best/regards.h>

Patrick Bellasi
