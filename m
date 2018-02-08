Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeBHPpI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:45:08 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47690 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752176AbeBHPpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:45:06 -0500
Date: Thu, 8 Feb 2018 16:44:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 1/3] sched: Stop nohz stats when decayed
Message-ID: <20180208154459.GA25181@hirez.programming.kicks-ass.net>
References: <1517944987-343-1-git-send-email-vincent.guittot@linaro.org>
 <1517944987-343-2-git-send-email-vincent.guittot@linaro.org>
 <20180208140005.GH25201@hirez.programming.kicks-ass.net>
 <CAKfTPtB0dDmovt=iM=efXUG1EY7GnOAuTTCf0VqTvx08fatWeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB0dDmovt=iM=efXUG1EY7GnOAuTTCf0VqTvx08fatWeQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 04:05:58PM +0100, Vincent Guittot wrote:
> On 8 February 2018 at 15:00, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, Feb 06, 2018 at 08:23:05PM +0100, Vincent Guittot wrote:
> >
> >> @@ -9207,13 +9231,15 @@ void nohz_balance_enter_idle(int cpu)
> >>       if (!housekeeping_cpu(cpu, HK_FLAG_SCHED))
> >>               return;
> >>
> >> +     rq->has_blocked_load = 1;

Should we not set that with rq->lock held? We already clear it while
holding rq->lock.

> >> +
> >>       if (rq->nohz_tick_stopped)
> >> -             return;
> >
> > this case is difficult... needs thinking
> 
> The use case happens when a CPU wakes up and goes back to idle before
> the tick fires and clears nohz_tick_stopped.

Yes, and so we could have accrued blocked load. Now in this case the CPU
must already be set in the cpumask, but we could've already cleared
has_blocked.

My question is mostly about needing that "goto out" to set the flag,
because I think we can loose it on a store collision vs clearing it. But
in that case I suppose the iteration must already be in progress, which
in turn will observe rq->has_blocked_load and re-set nohz.has_blocked.

So yes, this is good, but could use a comment.

> > Without this ordering I think it would be possible to loose has_blocked
> > and not observe the CPU either.
> 
> I think that you are right.
> I also wondered if some barriers were necessary but wrongly concluded
> that set operation on nohz.idle_cpus_mask and WRITE_ONCE with volatile
> would be enough to ensure the right ordering

Yeah, so I forgot to write the comment in my patch, but it had the
barriers implied by cmpxchg.
