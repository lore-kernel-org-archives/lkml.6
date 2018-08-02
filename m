Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B48AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1322152E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1322152E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbeHBSNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:13:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60310 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbeHBSNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:13:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 086DE80D;
        Thu,  2 Aug 2018 09:21:40 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12FF83F5D0;
        Thu,  2 Aug 2018 09:21:35 -0700 (PDT)
Date:   Thu, 2 Aug 2018 17:21:34 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [PATCH v5 12/14] sched/fair: Select an energy-efficient CPU on
 task wake-up
Message-ID: <20180802162132.7ur5poka5m7r2io2@queper01-lin>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-13-quentin.perret@arm.com>
 <20180802135426.GX2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802135426.GX2476@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 Aug 2018 at 15:54:26 (+0200), Peter Zijlstra wrote:
> On Tue, Jul 24, 2018 at 01:25:19PM +0100, Quentin Perret wrote:
> > @@ -6385,18 +6492,26 @@ static int
> >  select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
> >  {
> >  	struct sched_domain *tmp, *sd = NULL;
> > +	struct freq_domain *fd;
> >  	int cpu = smp_processor_id();
> >  	int new_cpu = prev_cpu;
> > -	int want_affine = 0;
> > +	int want_affine = 0, want_energy = 0;
> >  	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
> >  
> > +	rcu_read_lock();
> >  	if (sd_flag & SD_BALANCE_WAKE) {
> >  		record_wakee(p);
> > -		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu)
> > -			      && cpumask_test_cpu(cpu, &p->cpus_allowed);
> > +		fd = rd_freq_domain(cpu_rq(cpu)->rd);
> > +		want_energy = fd && !READ_ONCE(cpu_rq(cpu)->rd->overutilized);
> > +		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu) &&
> > +			      cpumask_test_cpu(cpu, &p->cpus_allowed);
> > +	}
> > +
> > +	if (want_energy) {
> > +		new_cpu = find_energy_efficient_cpu(p, prev_cpu, fd);
> > +		goto unlock;
> >  	}
> >  
> 
> And I suppose you rely on the compiler to optimize that for the static
> key inside rd_freq_domain()... Does it do a good job of that?

I does for sure when CONFIG_ENERGY_MODEL=n since rd_freq_domain() is
stubbed to false, but that's an easy one ;-)

> 
> That is, would not something like:
> 
> 
> 	rcu_read_lock();
> 	if (sd_flag & SD_BALANCE_WAKE) {
> 		record_wakee(p);
> 
> 		if (static_branch_unlikely(&sched_energy_present)) {
> 			struct root_domain *rd = cpu_rq(cpu)->rd;
> 			struct freq_domain *fd = rd_freq_domain(rd);
> 
> 			if (fd && !READ_ONCE(rd->overutilized)) {
> 				new_cpu = find_energy_efficient_cpu(p, prev_cpu, fd);
> 				goto unlock;
> 			}
> 		}
> 
> 		/* ... */
> 	}
> 
> 
> Be far more clear ?

It is clearer. Having the static key check in rd_freq_domain() makes
the change to find_busiest_group() smaller, but I can totally change it
with something like the above.

I'll do that in v6.

Thanks,
Quentin
