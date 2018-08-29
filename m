Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9EFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246B52064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246B52064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeH2UyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:54:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58284 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727245AbeH2Ux7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:53:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E80218A;
        Wed, 29 Aug 2018 09:56:11 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 994463F557;
        Wed, 29 Aug 2018 09:56:07 -0700 (PDT)
Date:   Wed, 29 Aug 2018 17:56:06 +0100
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
Subject: Re: [PATCH v6 05/14] sched/topology: Reference the Energy Model of
 CPUs when available
Message-ID: <20180829165603.astg32z3ep2qldfu@queper01-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-6-quentin.perret@arm.com>
 <20180829162238.GQ2960@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829162238.GQ2960@e110439-lin>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 Aug 2018 at 17:22:38 (+0100), Patrick Bellasi wrote:
> > +static void build_perf_domains(const struct cpumask *cpu_map)
> > +{
> > +	struct perf_domain *pd = NULL, *tmp;
> > +	int cpu = cpumask_first(cpu_map);
> > +	struct root_domain *rd = cpu_rq(cpu)->rd;
> > +	int i;
> > +
> > +	for_each_cpu(i, cpu_map) {
> > +		/* Skip already covered CPUs. */
> > +		if (find_pd(pd, i))
> > +			continue;
> > +
> > +		/* Create the new pd and add it to the local list. */
> > +		tmp = pd_init(i);
> > +		if (!tmp)
> > +			goto free;
> > +		tmp->next = pd;
> > +		pd = tmp;
> > +	}
> > +
> > +	perf_domain_debug(cpu_map, pd);
> > +
> > +	/* Attach the new list of performance domains to the root domain. */
> > +	tmp = rd->pd;
> > +	rcu_assign_pointer(rd->pd, pd);
> > +	if (tmp)
> > +		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
> 
> We have:
> 
>   sched_cpu_activate/cpuset_cpu_inactive
>     cpuset_cpu_active/sched_cpu_deactivate
>       partition_sched_domains
>         build_perf_domains
> 
> thus here we are building new SDs and, specifically, above we are
> attaching the local list "pd" to a _new_ root domain... thus, there
> cannot be already users of this new SDs and root domain at this stage,
> isn't it ?

Hmm, actually you can end up here even if the rd isn't new. That would
happen if you call rebuild_sched_domains() after the EM has been
registered for example. At this point, you might skip
detach_destroy_domains() and build_sched_domains() from
partition_sched_domains(), but still call build_perf_domains(), which
would then attach the pd list to the current rd.

That's one reason why rcu_assign_pointer() is probably a good idea. And
it's also nice from a doc standpoint I suppose.

> 
> Do we really need that rcu_assign_pointer ?
> Is the rcu_assign_pointer there just to "match" the following call_rcu ?
> 
> What about this path:
> 
>   sched_init_domains
>      partition_sched_domains
> 
> in which case we do not call build_perf_domains... is that intended ?

I assume you meant:

   sched_init_domains
     build_sched_domains

Is that right ?

If yes, I didn't bother calling build_perf_domains() from there because
I don't think there is a single platform out there which would have a
registered Energy Model that early in the boot process. Or maybe there
is one I don't know ?

Anyway, that is probably easy to fix, if need be.

> > +
> > +	return;
> > +
> > +free:
> > +	free_pd(pd);
> > +	tmp = rd->pd;
> > +	rcu_assign_pointer(rd->pd, NULL);
> > +	if (tmp)
> > +		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
> > +}
> 
> All the above functions use different naming conventions:
> 
>    "_pd" suffix, "pd_" prefix and "perf_domain_" prefix.
> 
> and you do it like that because it better matches the corresponding
> call sites following down the file.

That's right. The functions are supposed to vaguely look like existing
functions dealing with sched domains.

> However, since we are into a "CONFIG_ENERGY_MODEL" guarded section,
> why not start using a common prefix for all PD related functions?
> 
> I very like "perf_domain_" (or "pd_") as a prefix and I would try to
> use it for all the functions you defined above:
> 
>    perf_domain_free
>    perf_domain_find
>    perf_domain_debug
>    perf_domain_destroy_rcu
>    perf_domain_build

I kinda like the idea of keeping things consistent with the existing
code TBH. Especially because I'm terrible at naming things ... But if
there is a general agreement that I should rename everything I won't
argue.

> > +#else
> > +static void free_pd(struct perf_domain *pd) { }
> > +#endif
> 
> Maybe better:
> 
>   #endif /* CONFIG_ENERGY_MODEL */

Ack

> 
> > +
> >  static void free_rootdomain(struct rcu_head *rcu)
> >  {
> >  	struct root_domain *rd = container_of(rcu, struct root_domain, rcu);
> > @@ -211,6 +321,7 @@ static void free_rootdomain(struct rcu_head *rcu)
> >  	free_cpumask_var(rd->rto_mask);
> >  	free_cpumask_var(rd->online);
> >  	free_cpumask_var(rd->span);
> > +	free_pd(rd->pd);
> >  	kfree(rd);
> >  }
> >  
> > @@ -1964,8 +2075,8 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> >  	/* Destroy deleted domains: */
> >  	for (i = 0; i < ndoms_cur; i++) {
> >  		for (j = 0; j < n && !new_topology; j++) {
> > -			if (cpumask_equal(doms_cur[i], doms_new[j])
> > -			    && dattrs_equal(dattr_cur, i, dattr_new, j))
> > +			if (cpumask_equal(doms_cur[i], doms_new[j]) &&
> > +			    dattrs_equal(dattr_cur, i, dattr_new, j))
> 
> This chunk looks more like a cleanup which is not really changing
> anything: is it intentional?

Yep, that's a cleanup Peter requested:
	20180705181407.GI2494@hirez.programming.kicks-ass.net

> 
> >  				goto match1;
> >  		}
> >  		/* No match - a current sched domain not in new doms_new[] */
> > @@ -1985,8 +2096,8 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> >  	/* Build new domains: */
> >  	for (i = 0; i < ndoms_new; i++) {
> >  		for (j = 0; j < n && !new_topology; j++) {
> > -			if (cpumask_equal(doms_new[i], doms_cur[j])
> > -			    && dattrs_equal(dattr_new, i, dattr_cur, j))
> > +			if (cpumask_equal(doms_new[i], doms_cur[j]) &&
> > +			    dattrs_equal(dattr_new, i, dattr_cur, j))
> 
> 
> Same comment for the chunk above

Ditto :-)

> 
> >  				goto match2;
> >  		}
> >  		/* No match - add a new doms_new */
> > @@ -1995,6 +2106,21 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> >  		;
> >  	}
> >  
> > +#ifdef CONFIG_ENERGY_MODEL
> > +	/* Build perf. domains: */
> > +	for (i = 0; i < ndoms_new; i++) {
> > +		for (j = 0; j < n; j++) {
> > +			if (cpumask_equal(doms_new[i], doms_cur[j]) &&
> > +			    cpu_rq(cpumask_first(doms_cur[j]))->rd->pd)
> > +				goto match3;
> > +		}
> > +		/* No match - add perf. domains for a new rd */
> > +		build_perf_domains(doms_new[i]);
> > +match3:
> > +		;
> > +	}
> > +#endif
> > +
> 
> 
> Since we already have a CONFIG_ENERGY_MODEL guarded section above,
> maybe we can s/build_perf_domains/build_perf_root_domain/ and use
> build_perf_domains to provide an inline function for the chunk above
> in the guarded section at the beginning of the file ?
> 
> The #else section will then provide just an empty implementation.

The only reason I didn't do this was because I wanted to keep all the
logic to skip (or not) building things centralized in
partition_sched_domains(), simply because I find it easier to
understand.

> Something like The diff below seems to work and it should do the
> "cleanup" job by also moving at the beginning of the source file the
> definition of the global variables (required by some functions).
> 
> Perhaps that's a bit of cleanup code that maintainer can accept...
> but... to be verified. ;)

Right, I guess it's mainly a matter of 'taste' here. So let's see ... :-)

Thanks !
Quentin
