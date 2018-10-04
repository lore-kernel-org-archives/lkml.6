Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8B8C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4126421470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2tN7CwtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4126421470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeJDP1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:27:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48938 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbeJDP1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e8U+/urkzYqlitKMfwT5j0pj7ljxJp33+rtV8av5VeQ=; b=2tN7CwtEHrzX4M1kEj4tB7Mwy
        Xhu1wroTJbLgYGx22VIC4Yulkfik8k7fWOvdZ2Dq7kpHD54hfQoUeh011Y/iAz9WmHvUue4hF+k9q
        NdK+7PW3MBRzhxZqml88V/KFTHz2JWO9KWaV0Ih1m14i94zR+FMnQdx2k0HvrjRaCVdKRjzthByoI
        2ryDJrKrH51fjzmE0izsVX8yRLFV419xTHDimEA5nG1mVfd+N+zSNcmw6TOO1zG/YVMOvQb3OPAbh
        hoCNeBtn9gbZocXirzftnEpq+Q6mDi/KHDVOm3jfr+v/QW9vtkaMIEvHO8h3yQ2KL5Uw1RDQUH8EB
        VGO4iHwyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7z65-0007IP-PP; Thu, 04 Oct 2018 08:35:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6958320595D12; Thu,  4 Oct 2018 10:34:57 +0200 (CEST)
Date:   Thu, 4 Oct 2018 10:34:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
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
Message-ID: <20181004083457.GC19252@hirez.programming.kicks-ass.net>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-12-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912091309.7551-12-quentin.perret@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 10:13:06AM +0100, Quentin Perret wrote:
> +static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
> +{
> +	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
> +	unsigned long util_est, util = READ_ONCE(cfs_rq->avg.util_avg);
> +
> +	/*
> +	 * If @p migrates from @cpu to another, remove its contribution. Or,
> +	 * if @p migrates from another CPU to @cpu, add its contribution. In
> +	 * the other cases, @cpu is not impacted by the migration, so the
> +	 * util_avg should already be correct.
> +	 */
> +	if (task_cpu(p) == cpu && dst_cpu != cpu)
> +		util = max_t(long, util - task_util(p), 0);

That's not quite right; what you want to check for is underflow, but the
above also results in 0 if util - task_util() > LONG_MAX without an
underflow.

You could write: sub_positive(&util, task_util(p));

> +	else if (task_cpu(p) != cpu && dst_cpu == cpu)
> +		util += task_util(p);
> +
> +	if (sched_feat(UTIL_EST)) {
> +		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> +
> +		/*
> +		 * During wake-up, the task isn't enqueued yet and doesn't
> +		 * appear in the cfs_rq->avg.util_est.enqueued of any rq,
> +		 * so just add it (if needed) to "simulate" what will be
> +		 * cpu_util() after the task has been enqueued.
> +		 */
> +		if (dst_cpu == cpu)
> +			util_est += _task_util_est(p);
> +
> +		util = max(util, util_est);
> +	}
> +
> +	return min_t(unsigned long, util, capacity_orig_of(cpu));

AFAICT both @util and capacity_orig_of() have 'unsigned long' as type.

> +}
> +
> +/*
> + * compute_energy(): Estimates the energy that would be consumed if @p was
> + * migrated to @dst_cpu. compute_energy() predicts what will be the utilization
> + * landscape of the * CPUs after the task migration, and uses the Energy Model
> + * to compute what would be the energy if we decided to actually migrate that
> + * task.
> + */
> +static long compute_energy(struct task_struct *p, int dst_cpu,
> +							struct perf_domain *pd)

static long
compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)

> +{
> +	long util, max_util, sum_util, energy = 0;
> +	int cpu;
> +
> +	while (pd) {
> +		max_util = sum_util = 0;
> +		/*
> +		 * The capacity state of CPUs of the current rd can be driven by
> +		 * CPUs of another rd if they belong to the same performance
> +		 * domain. So, account for the utilization of these CPUs too
> +		 * by masking pd with cpu_online_mask instead of the rd span.
> +		 *
> +		 * If an entire performance domain is outside of the current rd,
> +		 * it will not appear in its pd list and will not be accounted
> +		 * by compute_energy().
> +		 */
> +		for_each_cpu_and(cpu, perf_domain_span(pd), cpu_online_mask) {
> +			util = cpu_util_next(cpu, p, dst_cpu);
> +			util = schedutil_freq_util(cpu, util, ENERGY_UTIL);
> +			max_util = max(util, max_util);
> +			sum_util += util;
> +		}
> +
> +		energy += em_pd_energy(pd->obj, max_util, sum_util);
> +		pd = pd->next;
> +	}

No real strong preference, but you could write that like:

	for (; pd; pd = pd->next) {
	}


> +
> +	return energy;
> +}
