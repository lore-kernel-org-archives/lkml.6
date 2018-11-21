Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289C1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1C62174D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1C62174D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbeKVCkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:40:35 -0500
Received: from foss.arm.com ([217.140.101.70]:53854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730072AbeKVCke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:40:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97E3F1D70;
        Wed, 21 Nov 2018 08:05:32 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F39E3F5CF;
        Wed, 21 Nov 2018 08:05:28 -0800 (PST)
Date:   Wed, 21 Nov 2018 16:05:27 +0000
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
Subject: Re: [PATCH v9 13/15] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20181121160524.ulj6n3shb2fdwboj@queper01-lin>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-14-quentin.perret@arm.com>
 <20181121142803.GF2113@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121142803.GF2113@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 Nov 2018 at 15:28:03 (+0100), Peter Zijlstra wrote:
> On Mon, Nov 19, 2018 at 02:18:55PM +0000, Quentin Perret wrote:
> > +static long
> > +compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
> > +{
> > +	long util, max_util, sum_util, energy = 0;
> > +	int cpu;
> > +
> > +	for (; pd; pd = pd->next) {
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
> 
> Should that not be cpu_active_mask ?

Hmm, I must admit I'm sometimes a bit confused by the exact difference
between these masks, so maybe yeah ...

IIUC, cpu_active_mask is basically the set of CPUs on which the
scheduler is actually allowed to migrate tasks. Is that correct ?

I have always seen cpu_online_mask as a superset of cpu_active_mask
which can also include CPUs which are still running 'special' tasks
(kthreads and things like that I assume) although not allowed for
migration any more (or not yet) because we're in the process of
hotplugging that CPU.

So, the thing is, I'm not trying to select a CPU candidate for my task
here, I'm trying to understand what's the energy impact of a migration.
That involves all CPUs that are running _something_ in a perf domain
no matter if they're allowed to run more tasks or not. I mean, raising
the OPP will make running online && !active CPUs more expensive as well.
That's why I thought cpu_online_mask was good match here.

Or maybe I'm confused again :-)

> 
> > +			util = cpu_util_next(cpu, p, dst_cpu);
> > +			util = schedutil_energy_util(cpu, util);
> > +			max_util = max(util, max_util);
> > +			sum_util += util;
> > +		}
> > +
> > +		energy += em_pd_energy(pd->em_pd, max_util, sum_util);
> > +	}
> > +
> > +	return energy;
> > +}

Thanks,
Quentin
