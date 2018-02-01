Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbeBAMdm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 07:33:42 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:51481 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbeBAMdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 07:33:41 -0500
Date: Thu, 1 Feb 2018 13:33:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: subhra mazumdar <subhra.mazumdar@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        steven.sistare@oracle.com, dhaval.giani@oracle.com
Subject: Re: [RESEND RFC PATCH V3] sched: Improve scalability of
 select_idle_sibling using SMT balance
Message-ID: <20180201123335.GV2249@hirez.programming.kicks-ass.net>
References: <20180129233102.19018-1-subhra.mazumdar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129233102.19018-1-subhra.mazumdar@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 03:31:02PM -0800, subhra mazumdar wrote:
> +#ifdef CONFIG_SCHED_SMT
> +
> +/*
> + * From sd_llc downward update the SMT utilization.

Please don't use utilization for this, we already use that word for
something else.

> + * Skip the lowest level 0.
> + */
> +void smt_util(struct rq *rq, int prev_busy, int next_busy)
> +{
> +	struct sched_domain *sd;
> +	struct sched_group *sg_cpu;
> +	int this_cpu = rq->cpu;
> +	int util;
> +
> +	if (rq->curr_util == UTIL_UNINITIALIZED)
> +		prev_busy = 0;
> +
> +	util = next_busy - prev_busy;
> +	rcu_read_lock();
> +	sd = rcu_dereference(per_cpu(sd_llc, this_cpu));
> +	if (util) {
> +		for_each_lower_domain(sd) {
> +			if (sd->level == 0)
> +				break;

afaict you really only need this for the core, and here you're assuming
everything below the LLC is cores. Would it not be much clearer if you
introduce sd_core.

As is, for_each_lower_domain includes the starting domain, sd->group
then is the first core group for this cpu. But then you continue to the
smt domain (on Intel, on other architectures there could be a cluster
domain in between) and then you bail using that sd->level == 0 hack
because otherwise things would go *bang*.

Really rather messy this.

I think you want to go allocate sched_domain_shared for the MC level and
use that, much like sd_llc_shared.

> +			sg_cpu = sd->groups;
> +
> +			/* atomically add/subtract the util */
> +			if (util > 0)
> +				atomic_inc((atomic_t *)&sg_cpu->utilization);
> +			else
> +				atomic_dec((atomic_t *)&sg_cpu->utilization);

*sigh*, wth do you need that cast? You didn't get the memo that spurious
casts are where bugs happen and are terrible style at the best of times?

> +		}
> +	}
> +
> +	if (sd)
> +		rq->curr_util = next_busy;
> +	rcu_read_unlock();
> +}

> +	smt_util(rq, 1, 0);

> +	smt_util(rq, 0, 1);

That all seems like an overly complex way to write inc/dec. You turned
what should be a boolean state space (2^1) into something like 2^64.

Also, I think if you count idle instead of busy, you'll do away with the
need for that whole uninitialized thing.


> +#define	CPU_PSEUDO_RANDOM(cpu)	(cpu_rq(cpu)->rotor++)

That's a bit of a stretch calling that pseudo random..

> +/*
> + * Find an idle cpu in the core starting search from random index.
> + */
> +static int select_idle_smt(struct task_struct *p, struct sched_group *sg)
>  {
> +	int i, rand_index, rand_cpu;
> +	int this_cpu = smp_processor_id();
>  
> +	rand_index = CPU_PSEUDO_RANDOM(this_cpu) % sg->group_weight;
> +	rand_cpu = sg->cp_array[rand_index];

Right, so yuck.. I know why you need that, but that extra array and
dereference is the reason I never went there.

How much difference does it really make vs the 'normal' wrapping search
from last CPU ?

This really should be a separate patch with separate performance numbers
on.

> +	for_each_cpu_wrap(i, sched_group_span(sg), rand_cpu) {
> +		if (!cpumask_test_cpu(i, &p->cpus_allowed))
> +			continue;
> +		if (idle_cpu(i))
> +			return i;
> +	}
>  
> +	return -1;
>  }
>  
>  /*
> + * Compare the SMT utilization of the two groups and select the one which
> + * has more capacity left.
>   */
> +static int smt_should_migrate(struct sched_group *here,
> +			      struct sched_group *there, int self_util)
>  {
> +	int this_cpu = smp_processor_id();
> +	int here_util = here->utilization, there_util = there->utilization;
>  
> +	/* Discount self utilization if it belongs to here or there */
> +	if (self_util > 0) {
> +		if (cpumask_test_cpu(this_cpu, sched_group_span(here)))
> +			here_util -= self_util;
> +		else if (cpumask_test_cpu(this_cpu, sched_group_span(there)))
> +			there_util -= self_util;
>  	}
>  
> +	/* Return true if other group has more capacity left */
> +	return (there->group_weight - there_util >
> +		here->group_weight - here_util);
>  }

OK, so this effectively picks the least-busiest/idlest SMT sibling of
two.

>  /*
> + * SMT balancing works by comparing the target cpu group with a random group
> + * in llc domain. It calls smt_should_migrate to decide which group has more
> + * capacity left. The balancing starts top down fom sd_llc to SMT core level.
> + * Finally idle cpu search is only done in the core.
>   */
> +static int smt_balance(struct task_struct *p, struct sched_domain *sd, int cpu)
>  {
> +	struct sched_group *sg, *src_sg, *start_sg, *tgt_sg;
> +	struct cpumask *span;
> +	int rand_idx, weight;
> +	int cpu_orig = cpu;
> +	int rand_cpu;
> +	int this_cpu = smp_processor_id();
> +	struct rq *this_rq = cpu_rq(this_cpu);
> +	struct rq *rq = cpu_rq(cpu);
> +	int self_util = 0;
> +	int balanced = 0;
>  
> +	if (p == this_rq->curr)
> +		self_util = rq->curr_util;
>  
> +	for_each_lower_domain(sd) {

Again, I don't think we want to do that. You want to iterate all cores,
and this is a rather cumbersome way to go about doing that.

Esp. if there's a domain in between. Imagine an ARM bit.little with
shared L3 growing SMT or something along those lines.

> +		if (sd->level == 0)
> +			break;
>  
> +		/* Pick a random group that has cpus where the thread can run */
> +		src_sg = sd->groups;
> +		tgt_sg = NULL;
> +		rand_idx = CPU_PSEUDO_RANDOM(this_cpu) % sd->sg_num;
> +		start_sg = sd->sg_array[rand_idx];

> +		sg = start_sg;
> +		do {
> +			span = sched_group_span(sg);
> +			if (sg != src_sg &&
> +			    cpumask_intersects(span, &p->cpus_allowed)) {
> +				tgt_sg = sg;
> +				break;
> +			}
> +			sg = sg->next;
> +		} while (sg != start_sg);

OK, so this picks a 'random' group that has CPUs where our task is
allowed to run (per the above this group could be a cluster, not a
core).

> +		/*
> +		 * Compare the target group with random group and select the
> +		 * one which has more SMT capacity left. Choose a random CPU in
> +		 * the group to spread the load, then find the group's parent sd
> +		 * so the group's sd is used on the next main loop iteration.
> +		 */
> +		if (tgt_sg && smt_should_migrate(src_sg, tgt_sg, self_util)) {
> +			weight = tgt_sg->group_weight;
> +			rand_idx = CPU_PSEUDO_RANDOM(this_cpu) % weight;
> +			rand_cpu = tgt_sg->cp_array[rand_idx];
> +			for_each_cpu_wrap(cpu, span, rand_cpu) {
> +				if (cpumask_test_cpu(cpu, &p->cpus_allowed))
> +					break;
> +			}
> +			for_each_domain(cpu, sd) {
> +				if (weight < sd->span_weight)
> +					break;
> +			}
> +			balanced = 1;
>  		}

I really wonder how much that fake random stuff yields you vs the rest
of this.

In any case, this will not do for facebook I'm afraid, as is they
already disable SIS_AVG_CPU and SIS_PROP (iirc) and always take the hit
of doing a full LLC search.

Yes that is expensive, but they really want to keep that tail latency
down.

Also, only ever considering _one_ other core might affect other
workloads. If you look at those two features above, we should already
reduce the amount of searching we do when there's not a lot of idle
time.

>  	}
>  
> +	/* sd is now lowest level SMT core */
> +	if (sd->parent && (balanced || !idle_cpu(cpu_orig))) {
> +		cpu = select_idle_smt(p, sd->parent->groups);
> +		if (cpu >= 0)
>  			return cpu;
>  	}
>  
> +	return cpu_orig;
>  }
>  

> @@ -6302,6 +6266,31 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
>  	return min_cap * 1024 < task_util(p) * capacity_margin;
>  }
>  
> +static int select_idle_sibling(struct task_struct *p, int prev, int target)
> +{
> +	struct sched_domain *sd;
> +
> +	if (idle_cpu(target))
> +		return target;
> +
> +	/*
> +	 * If the previous cpu is cache affine and idle, don't be stupid.
> +	 */
> +	if (prev != target && cpus_share_cache(prev, target) && idle_cpu(prev))
> +		return prev;
> +
> +	sd = rcu_dereference(per_cpu(sd_llc, target));
> +	if (!sd)
> +		return target;
> +
> +#ifdef CONFIG_SCHED_SMT
> +	return smt_balance(p, sd, target);
> +#else
> +
> +	return select_idle_cpu(p, sd, target);
> +#endif

And that is just wrong....

> +}



So while there are things in there that _might_ work, I really don't
want to see this one giant horrible patch again.
