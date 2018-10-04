Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CF2C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D302064E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D302064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeJDRUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:20:06 -0400
Received: from foss.arm.com ([217.140.101.70]:34000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbeJDRUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:20:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62F117A9;
        Thu,  4 Oct 2018 03:27:28 -0700 (PDT)
Received: from queper01-lin (queper01-lin.Emea.Arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44CE03F5D3;
        Thu,  4 Oct 2018 03:27:24 -0700 (PDT)
Date:   Thu, 4 Oct 2018 11:27:22 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v7 12/14] sched/fair: Select an energy-efficient CPU on
 task wake-up
Message-ID: <20181004102722.izp7y42cvayq4pqg@queper01-lin>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-13-quentin.perret@arm.com>
 <20181004094412.GD19252@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004094412.GD19252@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 Oct 2018 at 11:44:12 (+0200), Peter Zijlstra wrote:
> On Wed, Sep 12, 2018 at 10:13:07AM +0100, Quentin Perret wrote:
> > +	while (pd) {
> > +		unsigned long cur_energy, spare_cap, max_spare_cap = 0;
> > +		int max_spare_cap_cpu = -1;
> > +
> > +		for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
> 
> Which of the two masks do we expect to be the smallest?

Typically, perf_domain_span is smaller.

> > +			if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
> > +				continue;
> > +
> > +			/* Skip CPUs that will be overutilized. */
> > +			util = cpu_util_next(cpu, p, cpu);
> > +			cpu_cap = capacity_of(cpu);
> > +			if (cpu_cap * 1024 < util * capacity_margin)
> > +				continue;
> > +
> > +			/* Always use prev_cpu as a candidate. */
> > +			if (cpu == prev_cpu) {
> > +				prev_energy = compute_energy(p, prev_cpu, head);
> > +				if (prev_energy < best_energy)
> > +					best_energy = prev_energy;
> 
> 				best_energy = min(best_energy, prev_energy);
> 
> That's both shorter and clearer.

OK.


> > +				continue;
> > +			}
> > +
> > +			/*
> > +			 * Find the CPU with the maximum spare capacity in
> > +			 * the performance domain
> > +			 */
> > +			spare_cap = cpu_cap - util;
> > +			if (spare_cap > max_spare_cap) {
> > +				max_spare_cap = spare_cap;
> > +				max_spare_cap_cpu = cpu;
> > +			}
> 
> Sometimes I wonder if something like:
> 
> #define min_filter(varp, val)		\
> ({					\
> 	typeof(varp) _varp = (varp);	\
> 	typeof(val)  _val  = (val);	\
> 	bool f = false;			\
> 					\
> 	if (_val < *_varp) {		\
> 		*_varp = _val;		\
> 		f = true;		\
> 	}				\
> 					\
> 	f;				\
> })
> 
> and the corresponding max_filter() are worth the trouble; it would allow
> writing:
> 
> 	if (max_filter(&max_spare_cap, spare_cap))
> 		max_spare_cap_cpu = cpu;
> 
> and:
> 
> > +		}
> > +
> > +		/* Evaluate the energy impact of using this CPU. */
> > +		if (max_spare_cap_cpu >= 0) {
> > +			cur_energy = compute_energy(p, max_spare_cap_cpu, head);
> > +			if (cur_energy < best_energy) {
> > +				best_energy = cur_energy;
> > +				best_energy_cpu = max_spare_cap_cpu;
> > +			}
> 
> 	if (min_filter(&best_energy, cur_energy))
> 		best_energy_cpu = max_spare_cap_cpu;
> 
> But then I figure, it is not... dunno. We do lots of this stuff.

If there are occurrences of this stuff all over the place, we could do
that in a separate clean-up patch that does just that, for the entire
file. Or maybe more ?

> > +		}
> > +		pd = pd->next;
> > +	}
> > +
> > +	/*
> > +	 * Pick the best CPU if prev_cpu cannot be used, or if it saves at
> > +	 * least 6% of the energy used by prev_cpu.
> > +	 */
> > +	if (prev_energy == ULONG_MAX ||
> > +			(prev_energy - best_energy) > (prev_energy >> 4))
> > +		return best_energy_cpu;
> 
> Does that become more readable if we split that into two conditions?
> 
> 	if (prev_energy == ULONG_MAX)
> 		return best_energy_cpu;
> 
> 	if ((prev_energy - best_energy) > (prev_energy >> 4))
> 		return best_energy_cpu;

Yeah, why not :-)

> > +	return prev_cpu;
> > +}
> > +
> >  /*
> >   * select_task_rq_fair: Select target runqueue for the waking task in domains
> >   * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
> > @@ -6360,13 +6468,37 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
> >  	int want_affine = 0;
> >  	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
> >  
> > +	rcu_read_lock();
> >  	if (sd_flag & SD_BALANCE_WAKE) {
> >  		record_wakee(p);
> > +
> > +		/*
> > +		 * Forkees are not accepted in the energy-aware wake-up path
> > +		 * because they don't have any useful utilization data yet and
> > +		 * it's not possible to forecast their impact on energy
> > +		 * consumption. Consequently, they will be placed by
> > +		 * find_idlest_cpu() on the least loaded CPU, which might turn
> > +		 * out to be energy-inefficient in some use-cases. The
> > +		 * alternative would be to bias new tasks towards specific types
> > +		 * of CPUs first, or to try to infer their util_avg from the
> > +		 * parent task, but those heuristics could hurt other use-cases
> > +		 * too. So, until someone finds a better way to solve this,
> > +		 * let's keep things simple by re-using the existing slow path.
> > +		 */
> > +		if (sched_feat(ENERGY_AWARE)) {
> > +			struct root_domain *rd = cpu_rq(cpu)->rd;
> > +			struct perf_domain *pd = rcu_dereference(rd->pd);
> > +
> > +			if (pd && !READ_ONCE(rd->overutilized)) {
> > +				new_cpu = find_energy_efficient_cpu(p, prev_cpu, pd);
> > +				goto unlock;
> > +			}
> > +		}
> > +
> > +		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu) &&
> > +			      cpumask_test_cpu(cpu, &p->cpus_allowed);
> >  	}
> 
> I would much prefer this to be something like:
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a8f601edd958..5475a885ec9f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6299,12 +6299,19 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>  {
>  	struct sched_domain *tmp, *sd = NULL;
>  	int cpu = smp_processor_id();
> -	int new_cpu = prev_cpu;
> +	unsigned int new_cpu = prev_cpu;
>  	int want_affine = 0;
>  	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
>  
>  	if (sd_flag & SD_BALANCE_WAKE) {
>  		record_wakee(p);
> +
> +		if (static_branch_unlikely(sched_eas_balance)) {
> +			new_cpu = select_task_rq_eas(p, prev_cpu, sd_flags, wake_flags);
> +			if (new_cpu < nr_cpu_ids)
> +				return new_cpu;
> +		}
> +
>  		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu)
>  			      && cpumask_test_cpu(cpu, &p->cpus_allowed);
>  	}
> and then hide everything (including that giant comment) in
> select_task_rq_eas().

So you think we should rename find_energy_efficient_cpu and put all the
checks in there ? Or should select_task_rq_eas do the checks and then
call find_energy_efficient_cpu ?

Not a huge deal, but that'll save some time if we agree on that one
upfront.

Thanks
