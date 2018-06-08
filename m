Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ERmpG6lvGlu8EwAAmS7hNA
	; Fri, 08 Jun 2018 11:59:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 59CE66089E; Fri,  8 Jun 2018 11:59:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CED33605A5;
	Fri,  8 Jun 2018 11:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CED33605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbeFHL7e (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:59:34 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52686 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751679AbeFHL7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:59:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id p126-v6so2906091wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 04:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PtHAwRDJDpgBZiB/oXvYncLWLjBKL7enY885K1EvJcw=;
        b=H4z2qS0R1da5N3VcuSLJIDuCpq/lRsJ5N++zcrJCMFWDngksLU82YiqJQUgxeLAanY
         2QXNPIXz7HnpMo7khP0vDekYMIXfofUQp89rmdNROKJPicH6cTVVjpr3aZ4RcXMUcEGa
         vE7s74BGGvYfZwKsgRQOMs0kVCGJereR/lzhxLOweN+pFuHnD0jPNZ94RkmQeeSp+uN5
         YXjxmQxhbA7yuR+aFyPJ7TxcfWeWjh47xP68CxPWBZzj2wTHKSffZehnZ3eqW85NGCHt
         9vw2qSeci2Jnm/UeI/5RzMEAvwjkloXlo213z6ZgPHPLtBJWmniY2LRkjsIl7hXc0vm6
         pAmQ==
X-Gm-Message-State: APt69E0zdzaXYXAo551TiOZI+mIeSKuBcS6ZcJdU9461QoQKxvXLBmkV
        4XWQdsIjo4ipfNc3vpnsVftPNQ==
X-Google-Smtp-Source: ADUXVKJVVjQtHzqvFsTzz54D9+uy4lMM9ebuctRaXJMWKVX4Ct2euKkoNheeJLDIqkOmc5PB+Klwdg==
X-Received: by 2002:a1c:7212:: with SMTP id n18-v6mr1390027wmc.5.1528459171441;
        Fri, 08 Jun 2018 04:59:31 -0700 (PDT)
Received: from localhost.localdomain ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id n11-v6sm23101704wro.13.2018.06.08.04.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 04:59:30 -0700 (PDT)
Date: Fri, 8 Jun 2018 13:59:28 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Quentin Perret <quentin.perret@arm.com>
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
Message-ID: <20180608115928.GC16089@localhost.localdomain>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-10-quentin.perret@arm.com>
 <20180608102446.GE658@localhost.localdomain>
 <20180608111909.GC418@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608111909.GC418@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/18 12:19, Quentin Perret wrote:
> On Friday 08 Jun 2018 at 12:24:46 (+0200), Juri Lelli wrote:
> > Hi,
> > 
> > On 21/05/18 15:25, Quentin Perret wrote:
> > 
> > [...]
> > 
> > > +static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > > +{
> > > +	unsigned long cur_energy, prev_energy, best_energy, cpu_cap, task_util;
> > > +	int cpu, best_energy_cpu = prev_cpu;
> > > +	struct sched_energy_fd *sfd;
> > > +	struct sched_domain *sd;
> > > +
> > > +	sync_entity_load_avg(&p->se);
> > > +
> > > +	task_util = task_util_est(p);
> > > +	if (!task_util)
> > > +		return prev_cpu;
> > > +
> > > +	/*
> > > +	 * Energy-aware wake-up happens on the lowest sched_domain starting
> > > +	 * from sd_ea spanning over this_cpu and prev_cpu.
> > > +	 */
> > > +	sd = rcu_dereference(*this_cpu_ptr(&sd_ea));
> > > +	while (sd && !cpumask_test_cpu(prev_cpu, sched_domain_span(sd)))
> > > +		sd = sd->parent;
> > > +	if (!sd)
> > > +		return -1;
> > 
> > Shouldn't this be return prev_cpu?
> 
> Well, you shouldn't be entering this function without an sd_ea pointer,
> so this case is a sort of bug I think. By returning -1 I think we should
> end-up picking a CPU using select_fallback_rq(), which sort of makes
> sense ?

I fear cpumask_test_cpu() and such won't be happy with a -1 arg.
If it's a recoverable bug, I'd say return prev and WARN_ON_ONCE() ?

> > > +
> > > +	if (cpumask_test_cpu(prev_cpu, &p->cpus_allowed))
> > > +		prev_energy = best_energy = compute_energy(p, prev_cpu);
> > > +	else
> > > +		prev_energy = best_energy = ULONG_MAX;
> > > +
> > > +	for_each_freq_domain(sfd) {
> > > +		unsigned long spare_cap, max_spare_cap = 0;
> > > +		int max_spare_cap_cpu = -1;
> > > +		unsigned long util;
> > > +
> > > +		/* Find the CPU with the max spare cap in the freq. dom. */
> > 
> > I undestand this being a heuristic to cut some overhead, but shouldn't
> > the model tell between packing vs. spreading?
> 
> Ah, that's a very interesting one :-) !
> 
> So, with only active costs of the CPUs in the model, we can't really
> tell what's best between packing or spreading between identical CPUs if
> the migration of the task doesn't change the OPP request.
> 
> In a frequency domain, all the "best" CPU candidates for a task are
> those for which we'll request a low OPP. When there are several CPUs for
> which the OPP request will be the same, we just don't know which one to
> pick from an energy standpoint, because we don't have other energy costs
> (for idle states for ex) to break the tie.
> 
> With this EM, the interesting thing is that if you assume that OPP
> requests follow utilization, you are _guaranteed_ that the CPU with
> the max spare capacity in a freq domain will always be among the best
> candidates of this freq domain. And since we don't know how to
> differentiate those candidates, why not using this one ?
> 
> Yes, it _might_ be better from an energy standpoint to pack small tasks
> on a CPU in order to let other CPUs go in deeper idle states. But that
> also hurts your chances to go cluster idle. Which solution is the best ?
> It depends, and we have no ways to tell with this EM.
> 
> This approach basically favors cluster-packing, and spreading inside a
> cluster. That should at least be a good thing for latency, and this is
> consistent with the idea that most of the energy savings come from the
> asymmetry of the system, and not so much from breaking the tie between
> identical CPUs. That's also the reason why EAS is enabled only if your
> system has SD_ASYM_CPUCAPACITY set, as we already discussed for patch
> 05/10 :-).
> 
> Does that make sense ?

Yes, thanks for the explanation. It would probably make sense to copy
and paste your text above somewhere in comment/doc for future ref.
