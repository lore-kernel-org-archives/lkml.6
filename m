Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BE9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659B820658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659B820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeH3OBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:01:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38756 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbeH3OBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:01:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 895D87A9;
        Thu, 30 Aug 2018 03:00:26 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 941203F721;
        Thu, 30 Aug 2018 03:00:22 -0700 (PDT)
Date:   Thu, 30 Aug 2018 11:00:20 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Quentin Perret <quentin.perret@arm.com>
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
Message-ID: <20180830100019.GT2960@e110439-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-6-quentin.perret@arm.com>
 <20180829162238.GQ2960@e110439-lin>
 <20180829165603.astg32z3ep2qldfu@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829165603.astg32z3ep2qldfu@queper01-lin>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-Aug 17:56, Quentin Perret wrote:
> On Wednesday 29 Aug 2018 at 17:22:38 (+0100), Patrick Bellasi wrote:
> > > +static void build_perf_domains(const struct cpumask *cpu_map)
> > > +{
> > > +	struct perf_domain *pd = NULL, *tmp;
> > > +	int cpu = cpumask_first(cpu_map);
> > > +	struct root_domain *rd = cpu_rq(cpu)->rd;
> > > +	int i;
> > > +
> > > +	for_each_cpu(i, cpu_map) {
> > > +		/* Skip already covered CPUs. */
> > > +		if (find_pd(pd, i))
> > > +			continue;
> > > +
> > > +		/* Create the new pd and add it to the local list. */
> > > +		tmp = pd_init(i);
> > > +		if (!tmp)
> > > +			goto free;
> > > +		tmp->next = pd;
> > > +		pd = tmp;
> > > +	}
> > > +
> > > +	perf_domain_debug(cpu_map, pd);
> > > +
> > > +	/* Attach the new list of performance domains to the root domain. */
> > > +	tmp = rd->pd;
> > > +	rcu_assign_pointer(rd->pd, pd);
> > > +	if (tmp)
> > > +		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
> > 
> > We have:
> > 
> >   sched_cpu_activate/cpuset_cpu_inactive
> >     cpuset_cpu_active/sched_cpu_deactivate
> >       partition_sched_domains
> >         build_perf_domains
> > 
> > thus here we are building new SDs and, specifically, above we are
> > attaching the local list "pd" to a _new_ root domain... thus, there
> > cannot be already users of this new SDs and root domain at this stage,
> > isn't it ?
> 
> Hmm, actually you can end up here even if the rd isn't new. That would
> happen if you call rebuild_sched_domains() after the EM has been
> registered for example.
> At this point, you might skip
> detach_destroy_domains() and build_sched_domains() from
> partition_sched_domains(), but still call build_perf_domains(), which
> would then attach the pd list to the current rd.

Ok... then it's just me that need to go back and better study how and
when SD are rebuilds.

> That's one reason why rcu_assign_pointer() is probably a good idea. And
> it's also nice from a doc standpoint I suppose.

If we can call into build_perf_domains() and reach the assignement
above with an existing RD, then yes, it makes perfect sense.

> > Do we really need that rcu_assign_pointer ?
> > Is the rcu_assign_pointer there just to "match" the following call_rcu ?
> > 
> > What about this path:
> > 
> >   sched_init_domains
> >      partition_sched_domains
> > 
> > in which case we do not call build_perf_domains... is that intended ?
> 
> I assume you meant:
> 
>    sched_init_domains
>      build_sched_domains
> 
> Is that right ?

Mmm... yes... seems so.

> If yes, I didn't bother calling build_perf_domains() from there because
> I don't think there is a single platform out there which would have a
> registered Energy Model that early in the boot process. Or maybe there
> is one I don't know ?

Dunno... but, in any case, probably we don't care about using EAS until
the boot complete, isn't it?

Just to better understand, what is the most common activation path we expect ?

  1. system boot
  2. CPUs online
  3. CPUFreq initialization
  4. EM registered
  X. ???
  N. partition_sched_domains
        build_perf_domains

IOW, who do we expect to call build_perf_domains for the first time ?

> Anyway, that is probably easy to fix, if need be.
> 
> > > +
> > > +	return;
> > > +
> > > +free:
> > > +	free_pd(pd);
> > > +	tmp = rd->pd;
> > > +	rcu_assign_pointer(rd->pd, NULL);
> > > +	if (tmp)
> > > +		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
> > > +}
> > 
> > All the above functions use different naming conventions:
> > 
> >    "_pd" suffix, "pd_" prefix and "perf_domain_" prefix.
> > 
> > and you do it like that because it better matches the corresponding
> > call sites following down the file.
> 
> That's right. The functions are supposed to vaguely look like existing
> functions dealing with sched domains.
> 
> > However, since we are into a "CONFIG_ENERGY_MODEL" guarded section,
> > why not start using a common prefix for all PD related functions?
> > 
> > I very like "perf_domain_" (or "pd_") as a prefix and I would try to
> > use it for all the functions you defined above:
> > 
> >    perf_domain_free
> >    perf_domain_find
> >    perf_domain_debug
> >    perf_domain_destroy_rcu
> >    perf_domain_build
> 
> I kinda like the idea of keeping things consistent with the existing
> code TBH. Especially because I'm terrible at naming things ... But if
> there is a general agreement that I should rename everything I won't
> argue.

I've just got the impression that naming in this file is a bit
fuzzy and it could be worth a cleanup... but of course there is also
value in minimizing the changes.

Was just wondering if a better file organization in general could help
to make topology.c more easy to compile for humans... but yes... let's
keep this for another time ;)

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
