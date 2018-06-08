Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id i5UENjKuGltbcAAAmS7hNA
	; Fri, 08 Jun 2018 16:26:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CA2CE6089E; Fri,  8 Jun 2018 16:26:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 419B9602FC;
	Fri,  8 Jun 2018 16:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 419B9602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752693AbeFHQ0X (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 12:26:23 -0400
Received: from foss.arm.com ([217.140.101.70]:35560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752356AbeFHQ0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 12:26:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0EE31435;
        Fri,  8 Jun 2018 09:26:21 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9E183F557;
        Fri,  8 Jun 2018 09:26:17 -0700 (PDT)
Date: Fri, 8 Jun 2018 17:26:12 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joelaf@google.com, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 09/10] sched/fair: Select an energy-efficient CPU
 on task wake-up
Message-ID: <20180608162612.GA17720@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-10-quentin.perret@arm.com>
 <20180608102446.GE658@localhost.localdomain>
 <20180608111909.GC418@e108498-lin.cambridge.arm.com>
 <20180608115928.GC16089@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608115928.GC16089@localhost.localdomain>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 Jun 2018 at 13:59:28 (+0200), Juri Lelli wrote:
> On 08/06/18 12:19, Quentin Perret wrote:
> > On Friday 08 Jun 2018 at 12:24:46 (+0200), Juri Lelli wrote:
> > > Hi,
> > > 
> > > On 21/05/18 15:25, Quentin Perret wrote:
> > > 
> > > [...]
> > > 
> > > > +static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > > > +{
> > > > +	unsigned long cur_energy, prev_energy, best_energy, cpu_cap, task_util;
> > > > +	int cpu, best_energy_cpu = prev_cpu;
> > > > +	struct sched_energy_fd *sfd;
> > > > +	struct sched_domain *sd;
> > > > +
> > > > +	sync_entity_load_avg(&p->se);
> > > > +
> > > > +	task_util = task_util_est(p);
> > > > +	if (!task_util)
> > > > +		return prev_cpu;
> > > > +
> > > > +	/*
> > > > +	 * Energy-aware wake-up happens on the lowest sched_domain starting
> > > > +	 * from sd_ea spanning over this_cpu and prev_cpu.
> > > > +	 */
> > > > +	sd = rcu_dereference(*this_cpu_ptr(&sd_ea));
> > > > +	while (sd && !cpumask_test_cpu(prev_cpu, sched_domain_span(sd)))
> > > > +		sd = sd->parent;
> > > > +	if (!sd)
> > > > +		return -1;
> > > 
> > > Shouldn't this be return prev_cpu?
> > 
> > Well, you shouldn't be entering this function without an sd_ea pointer,
> > so this case is a sort of bug I think. By returning -1 I think we should
> > end-up picking a CPU using select_fallback_rq(), which sort of makes
> > sense ?
> 
> I fear cpumask_test_cpu() and such won't be happy with a -1 arg.
> If it's a recoverable bug, I'd say return prev and WARN_ON_ONCE() ?

Hmmm, yes, prev + WARN_ON_ONCE is probably appropriate here then.

> 
> > > > +
> > > > +	if (cpumask_test_cpu(prev_cpu, &p->cpus_allowed))
> > > > +		prev_energy = best_energy = compute_energy(p, prev_cpu);
> > > > +	else
> > > > +		prev_energy = best_energy = ULONG_MAX;
> > > > +
> > > > +	for_each_freq_domain(sfd) {
> > > > +		unsigned long spare_cap, max_spare_cap = 0;
> > > > +		int max_spare_cap_cpu = -1;
> > > > +		unsigned long util;
> > > > +
> > > > +		/* Find the CPU with the max spare cap in the freq. dom. */
> > > 
> > > I undestand this being a heuristic to cut some overhead, but shouldn't
> > > the model tell between packing vs. spreading?
> > 
> > Ah, that's a very interesting one :-) !
> > 
> > So, with only active costs of the CPUs in the model, we can't really
> > tell what's best between packing or spreading between identical CPUs if
> > the migration of the task doesn't change the OPP request.
> > 
> > In a frequency domain, all the "best" CPU candidates for a task are
> > those for which we'll request a low OPP. When there are several CPUs for
> > which the OPP request will be the same, we just don't know which one to
> > pick from an energy standpoint, because we don't have other energy costs
> > (for idle states for ex) to break the tie.
> > 
> > With this EM, the interesting thing is that if you assume that OPP
> > requests follow utilization, you are _guaranteed_ that the CPU with
> > the max spare capacity in a freq domain will always be among the best
> > candidates of this freq domain. And since we don't know how to
> > differentiate those candidates, why not using this one ?
> > 
> > Yes, it _might_ be better from an energy standpoint to pack small tasks
> > on a CPU in order to let other CPUs go in deeper idle states. But that
> > also hurts your chances to go cluster idle. Which solution is the best ?
> > It depends, and we have no ways to tell with this EM.
> > 
> > This approach basically favors cluster-packing, and spreading inside a
> > cluster. That should at least be a good thing for latency, and this is
> > consistent with the idea that most of the energy savings come from the
> > asymmetry of the system, and not so much from breaking the tie between
> > identical CPUs. That's also the reason why EAS is enabled only if your
> > system has SD_ASYM_CPUCAPACITY set, as we already discussed for patch
> > 05/10 :-).
> > 
> > Does that make sense ?
> 
> Yes, thanks for the explanation. It would probably make sense to copy
> and paste your text above somewhere in comment/doc for future ref.

OK, will do.

Thanks !
Quentin
