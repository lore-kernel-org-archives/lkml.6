Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32446C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30A220878
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30A220878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbeKVBtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:49:42 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52606 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbeKVBtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:49:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C45231DC8;
        Wed, 21 Nov 2018 07:14:51 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA4543F5CF;
        Wed, 21 Nov 2018 07:14:47 -0800 (PST)
Date:   Wed, 21 Nov 2018 15:14:46 +0000
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
Subject: Re: [PATCH v9 09/15] sched: Introduce sched_energy_present static key
Message-ID: <20181121151444.t3zye5l5iycfni2s@queper01-lin>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-10-quentin.perret@arm.com>
 <20181121130822.GE2113@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121130822.GE2113@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wednesday 21 Nov 2018 at 14:08:22 (+0100), Peter Zijlstra wrote:
> On Mon, Nov 19, 2018 at 02:18:51PM +0000, Quentin Perret wrote:
> 
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
> 
> That seems quite ugly; can't you simply return a bool from
> build_perf_domains() ?
> 
> Something like the below, but less fugly ;-)
> 
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -299,7 +299,7 @@ static void destroy_perf_domain_rcu(stru
>  #define EM_MAX_COMPLEXITY 2048
>  
>  extern struct cpufreq_governor schedutil_gov;
> -static void build_perf_domains(const struct cpumask *cpu_map)
> +static bool build_perf_domains(const struct cpumask *cpu_map)
>  {
>  	int i, nr_pd = 0, nr_cs = 0, nr_cpus = cpumask_weight(cpu_map);
>  	struct perf_domain *pd = NULL, *tmp;
> @@ -365,7 +365,7 @@ static void build_perf_domains(const str
>  	if (tmp)
>  		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
>  
> -	return;
> +	return !!pd;
>  
>  free:
>  	free_pd(pd);
> @@ -373,6 +373,8 @@ static void build_perf_domains(const str
>  	rcu_assign_pointer(rd->pd, NULL);
>  	if (tmp)
>  		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
> +
> +	return false;
>  }
>  #else
>  static void free_pd(struct perf_domain *pd) { }
> @@ -2173,6 +2175,9 @@ void partition_sched_domains(int ndoms_n
>  	}
>  
>  #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> +	{
> +	bool has_eas = false;

That one wants to be declared '__maybe_unused' at the top of
partition_sched_domains() perhaps ? Just to avoid the { } section.
Hopefully the compiler will be smart enough to not use stack space for
it if not needed.

> +
>  	/* Build perf. domains: */
>  	for (i = 0; i < ndoms_new; i++) {
>  		for (j = 0; j < n && !sched_energy_update; j++) {
> @@ -2181,10 +2186,13 @@ void partition_sched_domains(int ndoms_n
>  				goto match3;

And we want to do 'has_eas = true' just before 'goto match3' here.
Otherwise we'll end up disabling EAS if we hit 'goto match3' for all
root domains.

>  		}
>  		/* No match - add perf. domains for a new rd */
> -		build_perf_domains(doms_new[i]);
> +		has_eas |= build_perf_domains(doms_new[i]);
>  match3:
>  		;
>  	}
> +
> +	sched_energy_set(has_eas);
> +	}
>  #endif
>  
>  	/* Remember the new sched domains: */

Other than that I guess that should work OK :-)

Thanks,
Quentin
