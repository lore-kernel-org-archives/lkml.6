Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE3BC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B95D2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B95D2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeJDPym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:54:42 -0400
Received: from foss.arm.com ([217.140.101.70]:60890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727190AbeJDPyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:54:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68A6B80D;
        Thu,  4 Oct 2018 02:02:24 -0700 (PDT)
Received: from queper01-lin (queper01-lin.Emea.Arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49B063F5A0;
        Thu,  4 Oct 2018 02:02:20 -0700 (PDT)
Date:   Thu, 4 Oct 2018 10:02:13 +0100
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
Subject: Re: [PATCH v7 11/14] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20181004090211.ponos72a26ybemjh@queper01-lin>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-12-quentin.perret@arm.com>
 <20181004083457.GC19252@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004083457.GC19252@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thursday 04 Oct 2018 at 10:34:57 (+0200), Peter Zijlstra wrote:
> On Wed, Sep 12, 2018 at 10:13:06AM +0100, Quentin Perret wrote:
> > +static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
> > +{
> > +	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
> > +	unsigned long util_est, util = READ_ONCE(cfs_rq->avg.util_avg);
> > +
> > +	/*
> > +	 * If @p migrates from @cpu to another, remove its contribution. Or,
> > +	 * if @p migrates from another CPU to @cpu, add its contribution. In
> > +	 * the other cases, @cpu is not impacted by the migration, so the
> > +	 * util_avg should already be correct.
> > +	 */
> > +	if (task_cpu(p) == cpu && dst_cpu != cpu)
> > +		util = max_t(long, util - task_util(p), 0);
> 
> That's not quite right; what you want to check for is underflow, but the
> above also results in 0 if util - task_util() > LONG_MAX without an
> underflow.

Hmm, I basically took that from capacity_spare_wake(). So I guess that
function wants fixing too ... :/

Now, is it actually possible to hit that case (util - task_util() > LONG_MAX)
given that util numbers are in the 1024 scale ? I guess that _could_
become a problem if we decided to increase the resolution one day.

> You could write: sub_positive(&util, task_util(p));

Ah right, I forgot about that macro. It seems to have a slightly
stronger semantics than what I need here though. I don't really care if
the intermediate value hits the memory and task_util() already has a
READ_ONCE. Not sure if that's a big deal.

> 
> > +	else if (task_cpu(p) != cpu && dst_cpu == cpu)
> > +		util += task_util(p);
> > +
> > +	if (sched_feat(UTIL_EST)) {
> > +		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> > +
> > +		/*
> > +		 * During wake-up, the task isn't enqueued yet and doesn't
> > +		 * appear in the cfs_rq->avg.util_est.enqueued of any rq,
> > +		 * so just add it (if needed) to "simulate" what will be
> > +		 * cpu_util() after the task has been enqueued.
> > +		 */
> > +		if (dst_cpu == cpu)
> > +			util_est += _task_util_est(p);
> > +
> > +		util = max(util, util_est);
> > +	}
> > +
> > +	return min_t(unsigned long, util, capacity_orig_of(cpu));
> 
> AFAICT both @util and capacity_orig_of() have 'unsigned long' as type.

Indeed, no need for min_t.

> > +}
> > +
> > +/*
> > + * compute_energy(): Estimates the energy that would be consumed if @p was
> > + * migrated to @dst_cpu. compute_energy() predicts what will be the utilization
> > + * landscape of the * CPUs after the task migration, and uses the Energy Model
> > + * to compute what would be the energy if we decided to actually migrate that
> > + * task.
> > + */
> > +static long compute_energy(struct task_struct *p, int dst_cpu,
> > +							struct perf_domain *pd)
> 
> static long
> compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)

OK.

> > +{
> > +	long util, max_util, sum_util, energy = 0;
> > +	int cpu;
> > +
> > +	while (pd) {
> > +		max_util = sum_util = 0;
> > +		/*
> > +		 * The capacity state of CPUs of the current rd can be driven by
> > +		 * CPUs of another rd if they belong to the same performance
> > +		 * domain. So, account for the utilization of these CPUs too
> > +		 * by masking pd with cpu_online_mask instead of the rd span.
> > +		 *
> > +		 * If an entire performance domain is outside of the current rd,
> > +		 * it will not appear in its pd list and will not be accounted
> > +		 * by compute_energy().
> > +		 */
> > +		for_each_cpu_and(cpu, perf_domain_span(pd), cpu_online_mask) {
> > +			util = cpu_util_next(cpu, p, dst_cpu);
> > +			util = schedutil_freq_util(cpu, util, ENERGY_UTIL);
> > +			max_util = max(util, max_util);
> > +			sum_util += util;
> > +		}
> > +
> > +		energy += em_pd_energy(pd->obj, max_util, sum_util);
> > +		pd = pd->next;
> > +	}
> 
> No real strong preference, but you could write that like:
> 
> 	for (; pd; pd = pd->next) {
> 	}

And OK for that one too. That saves one line. The next patch has the
same pattern, I'll change it too.

Thanks,
Quentin
