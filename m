Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20805C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8A820663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8A820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390083AbeKVTz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:55:59 -0500
Received: from foss.arm.com ([217.140.101.70]:43274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731656AbeKVTz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:55:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A688D361A;
        Thu, 22 Nov 2018 01:17:21 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC75D3F5CF;
        Thu, 22 Nov 2018 01:17:17 -0800 (PST)
Date:   Thu, 22 Nov 2018 09:17:16 +0000
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
Message-ID: <20181122091715.6kvhcbgoqrd54nbs@queper01-lin>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-10-quentin.perret@arm.com>
 <20181121130822.GE2113@hirez.programming.kicks-ass.net>
 <20181121151444.t3zye5l5iycfni2s@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121151444.t3zye5l5iycfni2s@queper01-lin>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 Nov 2018 at 15:14:45 (+0000), Quentin Perret wrote:
> Hi Peter,
> 
> On Wednesday 21 Nov 2018 at 14:08:22 (+0100), Peter Zijlstra wrote:
> > On Mon, Nov 19, 2018 at 02:18:51PM +0000, Quentin Perret wrote:
> > 
> > > +static void sched_energy_start(int ndoms_new, cpumask_var_t doms_new[])
> > > +{
> > > +	/*
> > > +	 * The conditions for EAS to start are checked during the creation of
> > > +	 * root domains. If one of them meets all conditions, it will have a
> > > +	 * non-null list of performance domains.
> > > +	 */
> > > +	while (ndoms_new) {
> > > +		if (cpu_rq(cpumask_first(doms_new[ndoms_new - 1]))->rd->pd)
> > > +			goto enable;
> > > +		ndoms_new--;
> > > +	}
> > 
> > That seems quite ugly; can't you simply return a bool from
> > build_perf_domains() ?
> > 
> > Something like the below, but less fugly ;-)
> > 
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -299,7 +299,7 @@ static void destroy_perf_domain_rcu(stru
> >  #define EM_MAX_COMPLEXITY 2048
> >  
> >  extern struct cpufreq_governor schedutil_gov;
> > -static void build_perf_domains(const struct cpumask *cpu_map)
> > +static bool build_perf_domains(const struct cpumask *cpu_map)
> >  {
> >  	int i, nr_pd = 0, nr_cs = 0, nr_cpus = cpumask_weight(cpu_map);
> >  	struct perf_domain *pd = NULL, *tmp;
> > @@ -365,7 +365,7 @@ static void build_perf_domains(const str
> >  	if (tmp)
> >  		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
> >  
> > -	return;
> > +	return !!pd;
> >  
> >  free:
> >  	free_pd(pd);
> > @@ -373,6 +373,8 @@ static void build_perf_domains(const str
> >  	rcu_assign_pointer(rd->pd, NULL);
> >  	if (tmp)
> >  		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
> > +
> > +	return false;
> >  }
> >  #else
> >  static void free_pd(struct perf_domain *pd) { }
> > @@ -2173,6 +2175,9 @@ void partition_sched_domains(int ndoms_n
> >  	}
> >  
> >  #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> > +	{
> > +	bool has_eas = false;
> 
> That one wants to be declared '__maybe_unused' at the top of
> partition_sched_domains() perhaps ? Just to avoid the { } section.
> Hopefully the compiler will be smart enough to not use stack space for
> it if not needed.
> 
> > +
> >  	/* Build perf. domains: */
> >  	for (i = 0; i < ndoms_new; i++) {
> >  		for (j = 0; j < n && !sched_energy_update; j++) {
> > @@ -2181,10 +2186,13 @@ void partition_sched_domains(int ndoms_n
> >  				goto match3;
> 
> And we want to do 'has_eas = true' just before 'goto match3' here.
> Otherwise we'll end up disabling EAS if we hit 'goto match3' for all
> root domains.
> 
> >  		}
> >  		/* No match - add perf. domains for a new rd */
> > -		build_perf_domains(doms_new[i]);
> > +		has_eas |= build_perf_domains(doms_new[i]);
> >  match3:
> >  		;
> >  	}
> > +
> > +	sched_energy_set(has_eas);
> > +	}
> >  #endif
> >  
> >  	/* Remember the new sched domains: */
> 
> Other than that I guess that should work OK :-)

So I actually just came across your patch that does
static_branch_{inc,dec} on sched_smt_present. Maybe I could do something
similar here ?

How about something like the below (totally untested):

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8f9dfea60344..10ac32a0dc2e 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -298,6 +298,7 @@ static void destroy_perf_domain_rcu(struct rcu_head *rp)
 
        pd = container_of(rp, struct perf_domain, rcu);
        free_pd(pd);
+       static_branch_dec_cpuslocked(&sched_energy_present);
 }
 
 static void sched_energy_start(int ndoms_new, cpumask_var_t doms_new[])
@@ -421,6 +422,8 @@ static void build_perf_domains(const struct cpumask *cpu_map)
        /* Attach the new list of performance domains to the root domain. */
        tmp = rd->pd;
        rcu_assign_pointer(rd->pd, pd);
+       static_branch_inc_cpuslocked(&sched_energy_present);
+
        if (tmp)
                call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
 
@@ -2246,7 +2249,6 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 match3:
                ;
        }
-       sched_energy_start(ndoms_new, doms_new);
 #endif
 
        /* Remember the new sched domains: */

