Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21E7C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A367120684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A367120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeJBTeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:34:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36642 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbeJBTef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:34:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E4DA7A9;
        Tue,  2 Oct 2018 05:51:23 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 607C13F5B7;
        Tue,  2 Oct 2018 05:51:19 -0700 (PDT)
Date:   Tue, 2 Oct 2018 13:51:17 +0100
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
Subject: Re: [PATCH v7 03/14] PM: Introduce an Energy Model management
 framework
Message-ID: <20181002125115.245r3ocusvyiexno@queper01-lin>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-4-quentin.perret@arm.com>
 <20181002123031.GZ3439@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002123031.GZ3439@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 Oct 2018 at 14:30:31 (+0200), Peter Zijlstra wrote:
> On Wed, Sep 12, 2018 at 10:12:58AM +0100, Quentin Perret wrote:
> > +/**
> > + * em_register_perf_domain() - Register the Energy Model of a performance domain
> > + * @span	: Mask of CPUs in the performance domain
> > + * @nr_states	: Number of capacity states to register
> > + * @cb		: Callback functions providing the data of the Energy Model
> > + *
> > + * Create Energy Model tables for a performance domain using the callbacks
> > + * defined in cb.
> > + *
> > + * If multiple clients register the same performance domain, all but the first
> > + * registration will be ignored.
> > + *
> > + * Return 0 on success
> > + */
> > +int em_register_perf_domain(cpumask_t *span, unsigned int nr_states,
> > +						struct em_data_callback *cb)
> > +{
> > +	unsigned long cap, prev_cap = 0;
> > +	struct em_perf_domain *pd;
> > +	int cpu, ret = 0;
> > +
> > +	if (!span || !nr_states || !cb)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Use a mutex to serialize the registration of performance domains and
> > +	 * let the driver-defined callback functions sleep.
> > +	 */
> > +	mutex_lock(&em_pd_mutex);
> > +
> > +	for_each_cpu(cpu, span) {
> > +		/* Make sure we don't register again an existing domain. */
> > +		if (READ_ONCE(per_cpu(em_data, cpu))) {
> > +			ret = -EEXIST;
> > +			goto unlock;
> > +		}
> > +
> > +		/*
> > +		 * All CPUs of a domain must have the same micro-architecture
> > +		 * since they all share the same table.
> > +		 */
> > +		cap = arch_scale_cpu_capacity(NULL, cpu);
> > +		if (prev_cap && prev_cap != cap) {
> > +			pr_err("CPUs of %*pbl must have the same capacity\n",
> > +							cpumask_pr_args(span));
> > +			ret = -EINVAL;
> > +			goto unlock;
> > +		}
> > +		prev_cap = cap;
> > +	}
> > +
> > +	/* Create the performance domain and add it to the Energy Model. */
> > +	pd = em_create_pd(span, nr_states, cb);
> > +	if (!pd) {
> > +		ret = -EINVAL;
> > +		goto unlock;
> > +	}
> > +
> > +	for_each_cpu(cpu, span)
> > +		WRITE_ONCE(per_cpu(em_data, cpu), pd);
> 
> It's not immediately obvious to me why this doesn't need to be
> smp_store_release(). The moment you publish that pointer, it can be
> read, right?
> 
> Even if you never again change the pointer value, you want to ensure the
> content of pd is stable before pd itself is observable, right?

So, I figured the mutex already gives me some of that. I mean, AFAIU it
should guarantee that concurrent callers to em_register_perf_domain are
serialized correctly.

For example, if I have two concurrent calls (let's name them A and B) to
em_register_perf_domain(), and say A takes the mutex first, then B
should be guaranteed to always see the totality of the update that A
made to the per_cpu table. Is that right ?

If the above is correct, then it's pretty much all I can do, I think ...
In the case of concurrent readers and writers to em_data, the
smp_store_release() call still doesn't give me the guarantee that the
per_cpu table is stable since em_cpu_get() is lock-free ...

If I want to be sure the per_cpu thing is stable from em_cpu_get() then
I can add a mutex_lock/unlock there too, but even then I won't need the
smp_store_release(), I think. Or maybe I got confused again ?

Thanks,
Quentin
