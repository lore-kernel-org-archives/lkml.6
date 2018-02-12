Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753572AbeBLPiV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:38:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47288 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932145AbeBLPiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:38:12 -0500
Date: Mon, 12 Feb 2018 16:38:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, morten.rasmussen@foss.arm.com,
        brendan.jackman@arm.com, dietmar.eggemann@arm.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v3 3/3] sched: update blocked load when newly idle
Message-ID: <20180212153805.GW25201@hirez.programming.kicks-ass.net>
References: <1518422874-13216-1-git-send-email-vincent.guittot@linaro.org>
 <1518422874-13216-4-git-send-email-vincent.guittot@linaro.org>
 <20180212120411.GT25201@hirez.programming.kicks-ass.net>
 <20180212143444.GA12378@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180212143444.GA12378@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 03:34:44PM +0100, Vincent Guittot wrote:
> Le Monday 12 Feb 2018 à 13:04:11 (+0100), Peter Zijlstra a écrit :
> > On Mon, Feb 12, 2018 at 09:07:54AM +0100, Vincent Guittot wrote:

> > So I really hate this one, also I suspect its broken, because we do this
> > check before dropping rq->lock and _nohz_idle_balance() will take
> > rq->lock.
> 
> yes. it will take both newly idle rq and idle rq lock

Right, can't do that, there's ordering rules for multiple RQ locks etc..

> 
> >
> > 
> > Aside from the above being an unreadable mess, I dislike that it breaks
> > the various isolation crud, we should not touch CPUs outside of our
> > domain.
> >
> > 
> > Maybe something like the below? (unfinished)
> >
> 
> good catch. I completely miss the isolation stuff.
> But isn't already the case when kicking ilb ? I mean that an idle CPU touches
> all idle CPUs and some can be outside its domain during ilb.

> Shouldn't we test housekeeping_cpu(cpu, HK_FLAG_SCHED) instead if we want to
> make sure that an isolated/full nohz CPU will not be used for updating blocked
> load of CPUs outside its domain ?

I _thought_ we had some 'housekeeping' crud in the ilb selection logic,
but now I can't find it. Frederic?

> Is something below more readable:
>  
>  		/*
> +		 * This CPU doesn't want to be disturbed by scheduler
> +		 * houskeeping
>  		 */
> +		if (!housekeeping_cpu(cpu, HK_FLAG_SCHED))
> +			goto out;
> +
> +		/* Will wake up very soon. No time for doing anything else*/
> +		if (this_rq->avg_idle < sysctl_sched_migration_cost)
> +			goto out;
> +
> +		/* Don't need to update blocked load of idle CPUs*/
> +		if (!has_blocked || time_after_eq(jiffies, next_blocked)
> +			goto out;
> +
> +		raw_spin_unlock(&this_rq->lock);
> +		/*
> +		 * This CPU is going to be idle and blocked load of idle CPUs
> +		 * need to be updated. Run the ilb locally as it is a good
> +		 * candidate for ilb instead of waking up another idle CPU.
> +		 * Kick an normal ilb if we failed to do the update.
> +		 */
> +		if !_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
>  			kick_ilb(NOHZ_STATS_KICK);
> +		raw_spin_lock(&this_rq->lock);
>  
>  		goto out;

It is, but I think you're still doing that avg_idle thing twice now,
right?

> > @@ -7850,7 +7850,7 @@ static bool update_nohz_stats(struct rq
> >  	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
> >  		return false;
> >  
> > -	if (!time_after(jiffies, rq->last_blocked_load_update_tick))
> > +	if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick))
> 
> This fix the concern raised on the other thread, isn't it ?

Yes.

> > +static int nohz_age(struct sched_domain *sd)
> > +{
> > +	struct cpumask *cpus = this_cpu_cpumask_var_ptr(load_balance_mask);
> > +	bool has_blocked_load;
> > +
> > +	WRITE_ONCE(nohz.has_blocked, 0);
> > +
> > +	smp_mb();
> > +
> > +	cpumask_and(cpus, sched_domain_span(sd), nohz.idle_cpus_mask);
> > +
> > +	has_blocked_load = cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(sd));
> > +
> > +	for_each_cpu(cpu, cpus) {
> > +		struct rq *rq = cpu_rq(cpu);
> > +
> > +		has_blocked_load |= update_nohz_stats(rq, true);
> > +	}
> > +
> > +	if (has_blocked_load)
> > +		WRITE_ONCE(nohz.has_blocked, 1);
> > +}
> > +
> 
> we duplicate what is done in nohe_idle_balance

In parts yes.. I was too lazy to combine :-)

> > @@ -8919,9 +8955,13 @@ static int idle_balance(struct rq *this_
> >  		if (sd->flags & SD_BALANCE_NEWIDLE) {
> >  			t0 = sched_clock_cpu(this_cpu);
> >  
> > -			pulled_task = load_balance(this_cpu, this_rq,
> > -						   sd, CPU_NEWLY_IDLE,
> > -						   &continue_balancing);
> > +			if (nohz_blocked) {
> > +				nohz_age(sd);
> 
> Do we really need to loop all sched_domain of newly idle CPU and call
> nohz_age for each level ?
> Can't we only call  nohz_age with the widest/last sched_domain level ?

Yeah, dunno. I went back and forth on that a bit. The largest is
rq->rd->span. The reason I settled on this variant in the end is that it
keeps locality. When short idle, it will only scan nearby CPUs instead
of reaching half-way across the machine.

> Furthermore, we use sd->max_newidle_lb_cost to decide to abort the loop.
> But this is updated with full load balancing which is longer than just
> updating blocked load.
> This will increase the chance to abort before reaching the last level.

Yes.. I figured we'd take that hit :/

> > +			} else {
> > +				pulled_task = load_balance(this_cpu, this_rq,
> > +						sd, CPU_NEWLY_IDLE,
> > +						&continue_balancing);
> > +			}
> >  
> >  			domain_cost = sched_clock_cpu(this_cpu) - t0;
> >  			if (domain_cost > sd->max_newidle_lb_cost)
> 
> We have to kick an ilb if we must abort before looping all levels and all
> idle CPUs otherwise we can have situation where the load of some idle CPus
> could stay blocked

Yes, like said, was unfinished, I gave up before I got to that.
