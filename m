Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5666FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103822083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103822083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756021AbeFSH5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:57:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44318 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755536AbeFSH53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:57:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E64B91435;
        Tue, 19 Jun 2018 00:57:28 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F22753F589;
        Tue, 19 Jun 2018 00:57:24 -0700 (PDT)
Date:   Tue, 19 Jun 2018 08:57:23 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joelaf@google.com, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 09/10] sched/fair: Select an energy-efficient CPU
 on task wake-up
Message-ID: <20180619075723.GQ17720@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-10-quentin.perret@arm.com>
 <20180619050601.GA9208@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619050601.GA9208@codeaurora.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,

On Tuesday 19 Jun 2018 at 10:36:01 (+0530), Pavan Kondeti wrote:
> On Mon, May 21, 2018 at 03:25:04PM +0100, Quentin Perret wrote:
> 
> <snip>
> 
> > +	if (cpumask_test_cpu(prev_cpu, &p->cpus_allowed))
> > +		prev_energy = best_energy = compute_energy(p, prev_cpu);
> > +	else
> > +		prev_energy = best_energy = ULONG_MAX;
> > +
> > +	for_each_freq_domain(sfd) {
> > +		unsigned long spare_cap, max_spare_cap = 0;
> > +		int max_spare_cap_cpu = -1;
> > +		unsigned long util;
> > +
> > +		/* Find the CPU with the max spare cap in the freq. dom. */
> > +		for_each_cpu_and(cpu, freq_domain_span(sfd), sched_domain_span(sd)) {
> > +			if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
> > +				continue;
> > +
> > +			if (cpu == prev_cpu)
> > +				continue;
> > +
> > +			/* Skip CPUs that will be overutilized */
> > +			util = cpu_util_wake(cpu, p) + task_util;
> > +			cpu_cap = capacity_of(cpu);
> > +			if (cpu_cap * 1024 < util * capacity_margin)
> > +				continue;
> > +
> > +			spare_cap = cpu_cap - util;
> > +			if (spare_cap > max_spare_cap) {
> > +				max_spare_cap = spare_cap;
> > +				max_spare_cap_cpu = cpu;
> > +			}
> > +		}
> > +
> > +		/* Evaluate the energy impact of using this CPU. */
> > +		if (max_spare_cap_cpu >= 0) {
> > +			cur_energy = compute_energy(p, max_spare_cap_cpu);
> > +			if (cur_energy < best_energy) {
> > +				best_energy = cur_energy;
> > +				best_energy_cpu = max_spare_cap_cpu;
> > +			}
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * We pick the best CPU only if it saves at least 1.5% of the
> > +	 * energy used by prev_cpu.
> > +	 */
> > +	if ((prev_energy - best_energy) > (prev_energy >> 6))
> > +		return best_energy_cpu;
> > +
> > +	return prev_cpu;
> > +}
> 
> We are comparing the best_energy_cpu against prev_cpu even when prev_cpu
> can't accommodate the waking task. Is this intentional? Should not we
> discard the prev_cpu if it can't accommodate the task.
> 
> This can potentially make a BIG task run on a lower capacity CPU until
> load balancer kicks in and corrects the situation.

We shouldn't enter find_energy_efficient_cpu() in the first place if the
system is overutilized, so that shouldn't too much of an issue in
general.

But yeah, there is one small corner case where prev_cpu is overutilized
and the system has not been flagged as such yet (when the tasks wakes-up
shortly before the tick for ex). I think it's possible to cover this case
by extending the "if (cpumask_test_cpu(prev_cpu, &p->cpus_allowed))"
condition at the top of the function with a check on capacity_margin.

I'll change that in v4.

Thanks !
Quentin
