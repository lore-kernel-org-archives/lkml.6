Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbeFEOSR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:18:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49850 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbeFEOSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:18:16 -0400
Date: Tue, 5 Jun 2018 16:18:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v5 00/10] track CPU utilization
Message-ID: <20180605141809.GV12180@hirez.programming.kicks-ass.net>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <20180604165047.GU12180@hirez.programming.kicks-ass.net>
 <CAKfTPtDtx72OgxvA3vxnRiCW_UG24HSJ3oE_8j5Rx3-vP0gCeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDtx72OgxvA3vxnRiCW_UG24HSJ3oE_8j5Rx3-vP0gCeA@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 08:08:58PM +0200, Vincent Guittot wrote:
> On 4 June 2018 at 18:50, Peter Zijlstra <peterz@infradead.org> wrote:

> > So this patch-set tracks the !cfs occupation using the same function,
> > which is all good. But what, if instead of using that to compensate the
> > OPP selection, we employ that to renormalize the util signal?
> >
> > If we normalize util against the dynamic (rt_avg affected) cpu_capacity,
> > then I think your initial problem goes away. Because while the RT task
> > will push the util to .5, it will at the same time push the CPU capacity
> > to .5, and renormalized that gives 1.
> >
> >   NOTE: the renorm would then become something like:
> >         scale_cpu = arch_scale_cpu_capacity() / rt_frac();

Should probably be:

	scale_cpu = atch_scale_cpu_capacity() / (1 - rt_frac())

> >
> >
> > On IRC I mentioned stopping the CFS clock when preempted, and while that
> > would result in fixed numbers, Vincent was right in pointing out the
> > numbers will be difficult to interpret, since the meaning will be purely
> > CPU local and I'm not sure you can actually fix it again with
> > normalization.
> >
> > Imagine, running a .3 RT task, that would push the (always running) CFS
> > down to .7, but because we discard all !cfs time, it actually has 1. If
> > we try and normalize that we'll end up with ~1.43, which is of course
> > completely broken.
> >
> >
> > _However_, all that happens for util, also happens for load. So the above
> > scenario will also make the CPU appear less loaded than it actually is.
> 
> The load will continue to increase because we track runnable state and
> not running for the load

Duh yes. So renormalizing it once, like proposed for util would actually
do the right thing there too.  Would not that allow us to get rid of
much of the capacity magic in the load balance code?

/me thinks more..

Bah, no.. because you don't want this dynamic renormalization part of
the sums. So you want to keep it after the fact. :/

> As you mentioned, scale_rt_capacity give the remaining capacity for
> cfs and it will behave like cfs util_avg now that it uses PELT. So as
> long as cfs util_avg <  scale_rt_capacity(we probably need a margin)
> we keep using dl bandwidth + cfs util_avg + rt util_avg for selecting
> OPP because we have remaining spare capacity but if  cfs util_avg ==
> scale_rt_capacity, we make sure to use max OPP.

Good point, when cfs-util < cfs-cap then there is idle time and the util
number is 'right', when cfs-util == cfs-cap we're overcommitted and
should go max.

Since the util and cap values are aligned that should track nicely.
