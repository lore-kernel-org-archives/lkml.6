Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCDDC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998A6205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998A6205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeH2VSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:18:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58650 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbeH2VSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:18:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F39C18A;
        Wed, 29 Aug 2018 10:20:12 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 399223F721;
        Wed, 29 Aug 2018 10:20:08 -0700 (PDT)
Date:   Wed, 29 Aug 2018 18:20:06 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v6 07/14] sched/topology: Introduce sched_energy_present
 static key
Message-ID: <20180829172004.afbe2oukprvptqs2@queper01-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-8-quentin.perret@arm.com>
 <20180829165058.GR2960@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829165058.GR2960@e110439-lin>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 Aug 2018 at 17:50:58 (+0100), Patrick Bellasi wrote:
> > +/*
> > + * The complexity of the Energy Model is defined as: nr_pd * (nr_cpus + nr_cs)
> > + * with: 'nr_pd' the number of performance domains; 'nr_cpus' the number of
> > + * CPUs; and 'nr_cs' the sum of the capacity states numbers of all performance
> > + * domains.
> > + *
> > + * It is generally not a good idea to use such a model in the wake-up path on
> > + * very complex platforms because of the associated scheduling overheads. The
> > + * arbitrary constraint below prevents that. It makes EAS usable up to 16 CPUs
> > + * with per-CPU DVFS and less than 8 capacity states each, for example.
> 
> According to the formula above, that should give a "complexity value" of:
> 
>   16 * (16 + 9) = 384
> 
> while, 2K complexity seems more like a 40xCPUs system with 8 OPPs.
> 
> Maybe we should update either the example or the constant below ?

Hmm I guess the example isn't really clear. 'nr_cs' is the _sum_ of the
number of OPPs of all perf. domains. So, in the example above, if you
have 16 CPUs with per-CPU DVFS, and each DVFS island has 8 OPPs, then
nr_cs = 16 * 8 = 128.

So if you apply the formula you get C = 16 * (16 + 128) = 2304, which is
more than EM_MAX_COMPLEXITY, so EAS cannot start.

If the DVFS island had 7 OPPs instead of 8 (for example) you would get
nr_cs = 112, C = 2048, and so EAS could start.

I can try to re-work that comment to explain things a bit better ...

> 
> > + */
> > +#define EM_MAX_COMPLEXITY 2048
> > +
> >  static void build_perf_domains(const struct cpumask *cpu_map)
> >  {
> > +	int i, nr_pd = 0, nr_cs = 0, nr_cpus = cpumask_weight(cpu_map);
> >  	struct perf_domain *pd = NULL, *tmp;
> >  	int cpu = cpumask_first(cpu_map);
> >  	struct root_domain *rd = cpu_rq(cpu)->rd;
> > -	int i;
> > +
> > +	/* EAS is enabled for asymmetric CPU capacity topologies. */
> > +	if (!per_cpu(sd_asym_cpucapacity, cpu)) {
> > +		if (sched_debug()) {
> > +			pr_info("rd %*pbl: CPUs do not have asymmetric capacities\n",
> > +					cpumask_pr_args(cpu_map));
> > +		}
> > +		goto free;
> > +	}
> >  
> >  	for_each_cpu(i, cpu_map) {
> >  		/* Skip already covered CPUs. */
> > @@ -288,6 +318,21 @@ static void build_perf_domains(const struct cpumask *cpu_map)
> >  			goto free;
> >  		tmp->next = pd;
> >  		pd = tmp;
> > +
> > +		/*
> > +		 * Count performance domains and capacity states for the
> > +		 * complexity check.
> > +		 */
> > +		nr_pd++;
> 
> A special case where EAS is not going to be used is for systems where
> nr_pd matches the number of online CPUs, isn't it ?

Well, it depends. Say you have only 4 CPUs with 3 OPPs each. Even with
per-CPU DVFS the complexity is low enough to start EAS. I don't really
see a good reason for not doing so no ?

> 
> If that's the case, then, by caching this nr_pd you can probably check
> this condition in the sched_energy_start() and bail out even faster by
> avoiding to scan all the doms_new's pd ?
> 
> 
> > +		nr_cs += em_pd_nr_cap_states(pd->obj);
> > +	}
> > +
> > +	/* Bail out if the Energy Model complexity is too high. */
> > +	if (nr_pd * (nr_cs + nr_cpus) > EM_MAX_COMPLEXITY) {
> > +		if (sched_debug())
> > +			pr_info("rd %*pbl: EM complexity is too high\n ",
> > +						cpumask_pr_args(cpu_map));
> > +		goto free;
> >  	}
> >  
> >  	perf_domain_debug(cpu_map, pd);
> > @@ -307,6 +352,35 @@ static void build_perf_domains(const struct cpumask *cpu_map)
> >  	if (tmp)
> >  		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
> >  }
> > +
> > +static void sched_energy_start(int ndoms_new, cpumask_var_t doms_new[])
> > +{
> > +	/*
> > +	 * The conditions for EAS to start are checked during the creation of
> > +	 * root domains. If one of them meets all conditions, it will have a
> > +	 * non-null list of performance domains.
> > +	 */
> > +	while (ndoms_new) {
> > +		if (cpu_rq(cpumask_first(doms_new[ndoms_new - 1]))->rd->pd)
> > +			goto enable;
> > +		ndoms_new--;
> > +	}
> > +
> > +	if (static_branch_unlikely(&sched_energy_present)) {
>                           ^^^^^^^^
> Is this defined unlikely to reduce overheads on systems which never
> satisfy all the conditions above while still rebuild SDs from time to
> time ?

Something like that. I just thought that the case where EAS needs to be
disabled after being enabled isn't very common. I mean, the most typical
use-case is, EAS is enabled at boot and stays enabled forever, or EAS
never gets enabled.

Enabling/disabling EAS because of hotplug (for example) can definitely
happen, but that shouldn't be the case very often in practice, I think.
So we can optimize things out a bit I suppose.

Thanks !
Quentin
