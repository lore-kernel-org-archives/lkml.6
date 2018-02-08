Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbeBHOE1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:04:27 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:34691 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbeBHOEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:04:23 -0500
Date: Thu, 8 Feb 2018 15:04:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, morten.rasmussen@foss.arm.com,
        brendan.jackman@arm.com, dietmar.eggemann@arm.com,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 1/3] sched: Stop nohz stats when decayed
Message-ID: <20180208140418.GG25235@hirez.programming.kicks-ass.net>
References: <1517944987-343-1-git-send-email-vincent.guittot@linaro.org>
 <1517944987-343-2-git-send-email-vincent.guittot@linaro.org>
 <20180208140005.GH25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208140005.GH25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 03:00:05PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 06, 2018 at 08:23:05PM +0100, Vincent Guittot wrote:
> 
> > @@ -9207,13 +9231,15 @@ void nohz_balance_enter_idle(int cpu)
> >  	if (!housekeeping_cpu(cpu, HK_FLAG_SCHED))
> >  		return;
> >  
> > +	rq->has_blocked_load = 1;
> > +
> >  	if (rq->nohz_tick_stopped)
> > -		return;
> 
> this case is difficult... needs thinking
> 
> > +		goto out;
> >  
> >  	/*
> >  	 * If we're a completely isolated CPU, we don't play.
> >  	 */
> > -	if (on_null_domain(cpu_rq(cpu)))
> > +	if (on_null_domain(rq))
> >  		return;
> >  
> >  	rq->nohz_tick_stopped = 1;
> > @@ -9222,6 +9248,13 @@ void nohz_balance_enter_idle(int cpu)
> >  	atomic_inc(&nohz.nr_cpus);
> >  
> >  	set_cpu_sd_state_idle(cpu);
> 
> 	/*
> 	 * Ensures that if nohz_idle_balance() fails to observe our
> 	 * @idle_cpus_mask store, it must observe the @has_blocked
> 	 * store.
> 	 */
> 	smp_mb__after_atomic();
> 
> > +
> > +out:
> > +	/*
> > +	 * Each time a cpu enter idle, we assume that it has blocked load and
> > +	 * enable the periodic update of the load of idle cpus
> > +	 */
> > +	WRITE_ONCE(nohz.has_blocked, 1);
> >  }
> 
> 
> 
> > @@ -9374,6 +9407,16 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
> >  
> >  	SCHED_WARN_ON((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
> >  
> > +	/*
> > +	 * We assume there will be no idle load after this update and clear
> > +	 * the has_blocked flag. If a cpu enters idle in the mean time, it will
> > +	 * set the has_blocked flag and trig another update of idle load.
> > +	 * Because a cpu that becomes idle, is added to idle_cpus_mask before
> > +	 * setting the flag, we are sure to not clear the state and not
> > +	 * check the load of an idle cpu.
> > +	 */
> > +	WRITE_ONCE(nohz.has_blocked, 0);
> 
> 	/*
> 	 * Ensures that if we miss the CPU, we must see the has_blocked
> 	 * store from nohz_balance_enter_idle().
> 	 */
> 	smp_mb();
> 
> >  	for_each_cpu(balance_cpu, nohz.idle_cpus_mask) {
> >  		if (balance_cpu == this_cpu || !idle_cpu(balance_cpu))
> >  			continue;
> 
> 
> I _think_, but my brain isn't quite willing to turn on today.
> 
> Without this ordering I think it would be possible to loose has_blocked
> and not observe the CPU either.
> 
> 

might be the exact case from litmus-tests/R+mbonceonces.litmus but I
can't seem to get herd7 working today.
