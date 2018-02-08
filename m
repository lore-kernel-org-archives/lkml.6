Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeBHNPa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:15:30 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46278 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbeBHNP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:15:28 -0500
Date: Thu, 8 Feb 2018 14:15:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <valentin.schneider@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, morten.rasmussen@foss.arm.com,
        brendan.jackman@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 1/3] sched: Stop nohz stats when decayed
Message-ID: <20180208131522.GG25201@hirez.programming.kicks-ass.net>
References: <1517944987-343-1-git-send-email-vincent.guittot@linaro.org>
 <1517944987-343-2-git-send-email-vincent.guittot@linaro.org>
 <780a5b3a-4829-4195-c8fd-95da27248a82@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <780a5b3a-4829-4195-c8fd-95da27248a82@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 12:46:53PM +0000, Valentin Schneider wrote:
> On 02/06/2018 07:23 PM, Vincent Guittot wrote:
> > [...]
> > @@ -7826,8 +7842,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >  	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
> >  		struct rq *rq = cpu_rq(i);
> >  
> > -		if (env->flags & LBF_NOHZ_STATS)
> > -			update_nohz_stats(rq);
> > +		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq))
> > +			env->flags |= LBF_NOHZ_AGAIN;
> >  
> >  		/* Bias balancing toward cpus of our domain */
> >  		if (local_group)
> > @@ -7979,18 +7995,15 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >  	struct sg_lb_stats *local = &sds->local_stat;
> >  	struct sg_lb_stats tmp_sgs;
> >  	int load_idx, prefer_sibling = 0;
> > +	int has_blocked = READ_ONCE(nohz.has_blocked);
> >  	bool overload = false;
> >  
> >  	if (child && child->flags & SD_PREFER_SIBLING)
> >  		prefer_sibling = 1;
> >  
> >  #ifdef CONFIG_NO_HZ_COMMON
> > -	if (env->idle == CPU_NEWLY_IDLE) {
> > +	if (env->idle == CPU_NEWLY_IDLE && has_blocked)
> >  		env->flags |= LBF_NOHZ_STATS;
> > -
> > -		if (cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd)))
> > -			nohz.next_stats = jiffies + msecs_to_jiffies(LOAD_AVG_PERIOD);
> > -	}
> >  #endif
> >  
> >  	load_idx = get_sd_load_idx(env->sd, env->idle);
> > @@ -8046,6 +8059,15 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >  		sg = sg->next;
> >  	} while (sg != env->sd->groups);
> >  
> > +#ifdef CONFIG_NO_HZ_COMMON
> > +	if ((env->flags & LBF_NOHZ_AGAIN) &&
> > +	    cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd))) {
> > +
> > +		WRITE_ONCE(nohz.next_blocked,
> > +				jiffies + msecs_to_jiffies(LOAD_AVG_PERIOD));
> 
> Here we push the stats update forward if we visited all the nohz CPUs but they
> still have blocked load. IMO we should also clear the nohz.has_blocked flag
> if we visited all the nohz CPUs and none had blocked load left.

You can't, new cpu's can have joined the set. I used to detect that, but
that requires atomic ops.
