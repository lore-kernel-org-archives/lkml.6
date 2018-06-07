Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jxh6NLBMGVs7YwAAmS7hNA
	; Thu, 07 Jun 2018 15:20:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CF607608B8; Thu,  7 Jun 2018 15:20:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 77CEF6089E;
	Thu,  7 Jun 2018 15:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77CEF6089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935534AbeFGPUH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:20:07 -0400
Received: from foss.arm.com ([217.140.101.70]:53216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935452AbeFGPUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:20:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDCB780D;
        Thu,  7 Jun 2018 08:20:03 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 051A63F59D;
        Thu,  7 Jun 2018 08:19:59 -0700 (PDT)
Date: Thu, 7 Jun 2018 16:19:55 +0100
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
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Message-ID: <20180607151954.GA3597@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180607144409.GB3311@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607144409.GB3311@localhost.localdomain>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juri,

On Thursday 07 Jun 2018 at 16:44:09 (+0200), Juri Lelli wrote:
> On 21/05/18 15:24, Quentin Perret wrote:
> > Several subsystems in the kernel (scheduler and/or thermal at the time
> > of writing) can benefit from knowing about the energy consumed by CPUs.
> > Yet, this information can come from different sources (DT or firmware for
> > example), in different formats, hence making it hard to exploit without
> > a standard API.
> > 
> > This patch attempts to solve this issue by introducing a centralized
> > Energy Model (EM) framework which can be used to interface the data
> > providers with the client subsystems. This framework standardizes the
> > API to expose power costs, and to access them from multiple locations.
> > 
> > The current design assumes that all CPUs in a frequency domain share the
> > same micro-architecture. As such, the EM data is structured in a
> > per-frequency-domain fashion. Drivers aware of frequency domains
> > (typically, but not limited to, CPUFreq drivers) are expected to register
> > data in the EM framework using the em_register_freq_domain() API. To do
> > so, the drivers must provide a callback function that will be called by
> > the EM framework to populate the tables. As of today, only the active
> > power of the CPUs is considered. For each frequency domain, the EM
> > includes a list of <frequency, power, capacity> tuples for the capacity
> > states of the domain alongside a cpumask covering the involved CPUs.
> > 
> > The EM framework also provides an API to re-scale the capacity values
> > of the model asynchronously, after it has been created. This is required
> > for architectures where the capacity scale factor of CPUs can change at
> > run-time. This is the case for Arm/Arm64 for example where the
> > arch_topology driver recomputes the capacity scale factors of the CPUs
> > after the maximum frequency of all CPUs has been discovered. Although
> > complex, the process of creating and re-scaling the EM has to be kept in
> > two separate steps to fulfill the needs of the different users. The thermal
> > subsystem doesn't use the capacity values and shouldn't have dependencies
> > on subsystems providing them. On the other hand, the task scheduler needs
> > the capacity values, and it will benefit from seeing them up-to-date when
> > applicable.
> > 
> > Because of this need for asynchronous update, the capacity state table
> > of each frequency domain is protected by RCU, hence guaranteeing a safe
> > modification of the table and a fast access to readers in latency-sensitive
> > code paths.
> > 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > ---
> 
> OK, I think I'll start with a few comments while I get more into
> understanding the set. :)

:-)

> 
> > +static void fd_update_cs_table(struct em_cs_table *cs_table, int cpu)
> > +{
> > +	unsigned long cmax = arch_scale_cpu_capacity(NULL, cpu);
> > +	int max_cap_state = cs_table->nr_cap_states - 1;
>                  ^
> You don't need this on the stack, right?

Oh, why not ?

> 
> > +	unsigned long fmax = cs_table->state[max_cap_state].frequency;
> > +	int i;
> > +
> > +	for (i = 0; i < cs_table->nr_cap_states; i++)
> > +		cs_table->state[i].capacity = cmax *
> > +					cs_table->state[i].frequency / fmax;
> > +}
> > +
> > +static struct em_freq_domain *em_create_fd(cpumask_t *span, int nr_states,
> > +						struct em_data_callback *cb)
> > +{
> > +	unsigned long opp_eff, prev_opp_eff = ULONG_MAX;
> > +	int i, ret, cpu = cpumask_first(span);
> > +	struct em_freq_domain *fd;
> > +	unsigned long power, freq;
> > +
> > +	if (!cb->active_power)
> > +		return NULL;
> > +
> > +	fd = kzalloc(sizeof(*fd), GFP_KERNEL);
> > +	if (!fd)
> > +		return NULL;
> > +
> > +	fd->cs_table = alloc_cs_table(nr_states);
> 
> Mmm, don't you need to rcu_assign_pointer this first one as well?

Hmmmm, nobody can be using this at this point, but yes, it'd be better
to keep that consistent I suppose ...

> 
> > +	if (!fd->cs_table)
> > +		goto free_fd;
> > +
> > +	/* Copy the span of the frequency domain */
> > +	cpumask_copy(&fd->cpus, span);
> > +
> > +	/* Build the list of capacity states for this freq domain */
> > +	for (i = 0, freq = 0; i < nr_states; i++, freq++) {
>                      ^                              ^
> The fact that this relies on active_power() to use ceil OPP for a given
> freq might deserve a comment. Also, is this behaviour of active_power()
> standardized?

Right, this can get confusing pretty quickly. There is a comment in
include/linux/energy_model.h where the expected behaviour of
active_power is explained, but a reminder above this function shouldn't
hurt.

> 
> > +		ret = cb->active_power(&power, &freq, cpu);
> > +		if (ret)
> > +			goto free_cs_table;
> > +
> > +		fd->cs_table->state[i].power = power;
> > +		fd->cs_table->state[i].frequency = freq;
> > +
> > +		/*
> > +		 * The hertz/watts efficiency ratio should decrease as the
> > +		 * frequency grows on sane platforms. If not, warn the user
> > +		 * that some high OPPs are more power efficient than some
> > +		 * of the lower ones.
> > +		 */
> > +		opp_eff = freq / power;
> > +		if (opp_eff >= prev_opp_eff)
> > +			pr_warn("%*pbl: hz/watt efficiency: OPP %d >= OPP%d\n",
> > +					cpumask_pr_args(span), i, i - 1);
> > +		prev_opp_eff = opp_eff;
> > +	}
> > +	fd_update_cs_table(fd->cs_table, cpu);
> > +
> > +	return fd;
> > +
> > +free_cs_table:
> > +	free_cs_table(fd->cs_table);
> > +free_fd:
> > +	kfree(fd);
> > +
> > +	return NULL;
> > +}
> > +
> > +static void rcu_free_cs_table(struct rcu_head *rp)
> > +{
> > +	struct em_cs_table *table;
> > +
> > +	table = container_of(rp, struct em_cs_table, rcu);
> > +	free_cs_table(table);
> > +}
> > +
> > +/**
> > + * em_rescale_cpu_capacity() - Re-scale capacity values of the Energy Model
> > + *
> > + * This re-scales the capacity values for all capacity states of all frequency
> > + * domains of the Energy Model. This should be used when the capacity values
> > + * of the CPUs are updated at run-time, after the EM was registered.
> > + */
> > +void em_rescale_cpu_capacity(void)
> 
> So, is this thought to be called eventually also after thermal capping
> events and such?

The true reason is that the frequency domains will typically be
registered in the EM framework _before_ the arch_topology driver kicks
in on arm/arm64. That means that the EM tables are created, and only
after, the cpu capacities are updated. So we basically need to update
those capacities to be up-to-date.

The reason we need to keep those two steps separate (registering the
freq domains and re-scaling the capacities) in the EM framework is
because thermal doesn't care about the cpu capacities. It is a perfectly
acceptable configuration to use IPA without having dmips-capacity-mhz
values in the DT for ex.

Now, since we have a RCU protection on the EM tables, we might decide in
the future to use the opportunity to modify the tables at run-time for
other reasons. Thermal capping could be one I guess.

> 
> > +{
> > +	struct em_cs_table *old_table, *new_table;
> > +	struct em_freq_domain *fd;
> > +	unsigned long flags;
> > +	int nr_states, cpu;
> > +
> > +	read_lock_irqsave(&em_data_lock, flags);
> 
> Don't you need write_lock_ here, since you are going to exchange the
> em tables?

This lock protects the per_cpu() variable itself. Here we only read
pointers from that per_cpu variable, and we modify one attribute in
the pointed structure. We don't modify the per_cpu table itself. Does
that make sense ?

> 
> > +	for_each_cpu(cpu, cpu_possible_mask) {
> > +		fd = per_cpu(em_data, cpu);
> > +		if (!fd || cpu != cpumask_first(&fd->cpus))
> > +			continue;
> > +
> > +		/* Copy the existing table. */
> > +		old_table = rcu_dereference(fd->cs_table);
> > +		nr_states = old_table->nr_cap_states;
> > +		new_table = alloc_cs_table(nr_states);
> > +		if (!new_table) {
> > +			read_unlock_irqrestore(&em_data_lock, flags);
> > +			return;
> > +		}
> > +		memcpy(new_table->state, old_table->state,
> > +					nr_states * sizeof(*new_table->state));
> > +
> > +		/* Re-scale the capacity values on the copy. */
> > +		fd_update_cs_table(new_table, cpumask_first(&fd->cpus));
> > +
> > +		/* Replace the table with the rescaled version. */
> > +		rcu_assign_pointer(fd->cs_table, new_table);
> > +		call_rcu(&old_table->rcu, rcu_free_cs_table);
> > +	}
> > +	read_unlock_irqrestore(&em_data_lock, flags);
> > +	pr_debug("Re-scaled CPU capacities\n");
> > +}
> > +EXPORT_SYMBOL_GPL(em_rescale_cpu_capacity);
> > +
> > +/**
> > + * em_cpu_get() - Return the frequency domain for a CPU
> > + * @cpu : CPU to find the frequency domain for
> > + *
> > + * Return: the frequency domain to which 'cpu' belongs, or NULL if it doesn't
> > + * exist.
> > + */
> > +struct em_freq_domain *em_cpu_get(int cpu)
> > +{
> > +	struct em_freq_domain *fd;
> > +	unsigned long flags;
> > +
> > +	read_lock_irqsave(&em_data_lock, flags);
> > +	fd = per_cpu(em_data, cpu);
> > +	read_unlock_irqrestore(&em_data_lock, flags);
> > +
> > +	return fd;
> > +}
> > +EXPORT_SYMBOL_GPL(em_cpu_get);
> 
> Mmm, this gets complicated pretty fast eh? :)

Yeah, hopefully I'll be able to explain/clarify that :-).

> 
> I had to go back and forth between patches to start understanding the
> different data structures and how they are use, and I'm not sure yet
> I've got the full picture. I guess some nice diagram (cover letter or
> documentation patch) would help a lot.

Right, so I'd like very much to write a nice documentation patch once we
are more or less OK with the overall design of this framework, but I
felt like it was a little bit early for that. If we finally decide that
what I did is totally stupid and that it'd be better to do things
completely differently, my nice documentation patch would be a lot of
efforts for nothing.

But I agree that at the same time all this complex code has to be
explained. Hopefully the existing comments can help with that.
Otherwise, I'm more than happy to answer all questions :-)

> 
> Locking of such data structures is pretty involved as well, adding
> comments/docs shouldn't harm. :)

Message received. If I do need to come-up with a brand new
design/implementation for v4, I'll make sure to add more comments.

> Best,
> 
> - Juri

Thanks !
Quentin
