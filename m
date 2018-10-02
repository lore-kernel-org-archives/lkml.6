Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAF1C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDF320684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EDF320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeJBThg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:37:36 -0400
Received: from foss.arm.com ([217.140.101.70]:36690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbeJBThf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:37:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EACD47A9;
        Tue,  2 Oct 2018 05:54:22 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC9173F5B7;
        Tue,  2 Oct 2018 05:54:18 -0700 (PDT)
Date:   Tue, 2 Oct 2018 13:54:17 +0100
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
Subject: Re: [PATCH v7 03/14] PM: Introduce an Energy Model management
 framework
Message-ID: <20181002125414.aufsalllqf25rwsq@queper01-lin>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-4-quentin.perret@arm.com>
 <20181002122535.GY3439@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002122535.GY3439@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 Oct 2018 at 14:25:35 (+0200), Peter Zijlstra wrote:
> On Wed, Sep 12, 2018 at 10:12:58AM +0100, Quentin Perret wrote:
> > +/**
> > + * em_pd_energy() - Estimates the energy consumed by the CPUs of a perf. domain
> > + * @pd		: performance domain for which energy has to be estimated
> > + * @max_util	: highest utilization among CPUs of the domain
> > + * @sum_util	: sum of the utilization of all CPUs in the domain
> > + *
> > + * Return: the sum of the energy consumed by the CPUs of the domain assuming
> > + * a capacity state satisfying the max utilization of the domain.
> > + */
> > +static inline unsigned long em_pd_energy(struct em_perf_domain *pd,
> > +				unsigned long max_util, unsigned long sum_util)
> > +{
> > +	unsigned long freq, scale_cpu;
> > +	struct em_cap_state *cs;
> > +	int i, cpu;
> > +
> > +	/*
> > +	 * In order to predict the capacity state, map the utilization of the
> > +	 * most utilized CPU of the performance domain to a requested frequency,
> > +	 * like schedutil.
> > +	 */
> > +	cpu = cpumask_first(to_cpumask(pd->cpus));
> > +	scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
> > +	cs = &pd->table[pd->nr_cap_states - 1];
> > +	freq = map_util_freq(max_util, cs->frequency, scale_cpu);
> > +
> > +	/*
> > +	 * Find the lowest capacity state of the Energy Model above the
> > +	 * requested frequency.
> > +	 */
> > +	for (i = 0; i < pd->nr_cap_states; i++) {
> > +		cs = &pd->table[i];
> > +		if (cs->frequency >= freq)
> > +			break;
> > +	}
> > +
> > +	/*
> > +	 * The capacity of a CPU in the domain at that capacity state (cs)
> > +	 * can be computed as:
> > +	 *
> > +	 *             cs->freq * scale_cpu
> > +	 *   cs->cap = --------------------                          (1)
> > +	 *                 cpu_max_freq
> > +	 *
> > +	 * So, the energy consumed by this CPU at that capacity state is:
> > +	 *
> > +	 *             cs->power * cpu_util
> > +	 *   cpu_nrg = --------------------                          (2)
> > +	 *                   cs->cap
> > +	 *
> > +	 * since 'cpu_util / cs->cap' represents its percentage of busy time.
> > +	 *
> > +	 *   NOTE: Although the result of this computation actually is in
> > +	 *         units of power, it can be manipulated as an energy value
> > +	 *         over a scheduling period, since it is assumed to be
> > +	 *         constant during that interval.
> > +	 *
> > +	 * By injecting (1) in (2), 'cpu_nrg' can be re-expressed as a product
> > +	 * of two terms:
> > +	 *
> > +	 *             cs->power * cpu_max_freq   cpu_util
> > +	 *   cpu_nrg = ------------------------ * ---------          (3)
> > +	 *                    cs->freq            scale_cpu
> > +	 *
> > +	 * The first term is static, and is stored in the em_cap_state struct
> > +	 * as 'cs->cost'.
> > +	 *
> > +	 * Since all CPUs of the domain have the same micro-architecture, they
> > +	 * share the same 'cs->cost', and the same CPU capacity. Hence, the
> > +	 * total energy of the domain (which is the simple sum of the energy of
> > +	 * all of its CPUs) can be factorized as:
> > +	 *
> > +	 *            cs->cost * \Sum cpu_util
> > +	 *   pd_nrg = ------------------------                       (4)
> > +	 *                  scale_cpu
> > +	 */
> > +	return cs->cost * sum_util / scale_cpu;
> > +}
> 
> Should we explicitly mention that this ignores idle costs?

More doc shouldn't hurt so I can add a little something if you feel it's
needed.

Thanks,
Quentin
