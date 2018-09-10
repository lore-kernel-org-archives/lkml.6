Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F1DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573752086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573752086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbeIJPbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:31:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54912 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbeIJPbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:31:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBFB518A;
        Mon, 10 Sep 2018 03:38:10 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD08E3F575;
        Mon, 10 Sep 2018 03:38:06 -0700 (PDT)
Date:   Mon, 10 Sep 2018 11:38:05 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v6 03/14] PM: Introduce an Energy Model management
 framework
Message-ID: <20180910103802.l4zhewxgskchflsa@queper01-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-4-quentin.perret@arm.com>
 <1866195.ZKEIBQluJJ@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1866195.ZKEIBQluJJ@aspire.rjw.lan>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 Sep 2018 at 11:44:33 (+0200), Rafael J. Wysocki wrote:
> A kerneldoc comment would be useful here IMO.

OK

> > +struct em_cap_state {
> > +	unsigned long frequency; /* Kilo-hertz */
> 
> I wonder if the "frequency" field here could be changed into something a bit
> more abstract like "level" or similar?
> 
> The reason why is because in some cases we may end up with somewhat artificial
> values of "frequency" like when the intel_pstate driver is in use (it uses
> abstract "p-state" values internally and only produces "frequency" numbers for
> the cpufreq core and the way they are derived from the "p-states" is not always
> entirely clean).
> 
> The "level" could just be frequency on systems where cpufreq drivers operate on
> frequencies directly or something else on the other systems.

I see your point (and TBH we start to have same sort of problems on
Arm) but at this stage I would rather keep this field coherent with
what CPUFreq manages, that is, KHz. The only reason for that is because
the thermal subsystem (IPA) will look at this table to apply a max freq
capping on CPUFreq policies, so things need to be aligned.

I agree that even if the unit of this field wasn't specified we could
still build a system that works just fine. However if things are too
loosely specified, problems are allowed to happen, so they will.

Now, if the CPUFreq core is modified to manipulate abstract performance
levels one day, I'll be happy to change the EM framework the same way :-)

> 
> > +	unsigned long power; /* Milli-watts */
> > +	unsigned long cost; /* power * max_frequency / frequency */
> > +};
> > +
> 
> Like above, a kerneldoc comment documenting the structure below would be useful.

OK for that one too.

> > +struct em_perf_domain {
> > +	struct em_cap_state *table; /* Capacity states, in ascending order. */
> > +	int nr_cap_states;
> > +	unsigned long cpus[0]; /* CPUs of the frequency domain. */
> > +};
> > +
> > +#define EM_CPU_MAX_POWER 0xFFFF
> > +
> > +struct em_data_callback {
> > +	/**
> > +	 * active_power() - Provide power at the next capacity state of a CPU
> > +	 * @power	: Active power at the capacity state in mW (modified)
> > +	 * @freq	: Frequency at the capacity state in kHz (modified)
> > +	 * @cpu		: CPU for which we do this operation
> > +	 *
> > +	 * active_power() must find the lowest capacity state of 'cpu' above
> > +	 * 'freq' and update 'power' and 'freq' to the matching active power
> > +	 * and frequency.
> > +	 *
> > +	 * The power is the one of a single CPU in the domain, expressed in
> > +	 * milli-watts. It is expected to fit in the [0, EM_CPU_MAX_POWER]
> > +	 * range.
> > +	 *
> > +	 * Return 0 on success.
> > +	 */
> > +	int (*active_power)(unsigned long *power, unsigned long *freq, int cpu);
> > +};
> > +#define EM_DATA_CB(_active_power_cb) { .active_power = &_active_power_cb }
> > +
> > +struct em_perf_domain *em_cpu_get(int cpu);
> > +int em_register_perf_domain(cpumask_t *span, unsigned int nr_states,
> > +						struct em_data_callback *cb);
> > +
> > +/**
> > + * em_pd_energy() - Estimates the energy consumed by the CPUs of a perf. domain
> > + * @pd		: performance domain for which energy has to be estimated
> > + * @max_util	: highest utilization among CPUs of the domain
> > + * @sum_util	: sum of the utilization of all CPUs in the domain
> > + *
> > + * Return: the sum of the energy consumed by the CPUs of the domain assuming
> > + * a capacity state satisfying the max utilization of the domain.
> 
> Well, this confuses energy with power AFAICS.  The comment talks about energy,
> but the return value is in the units of power.
> 
> I guess this assumes constant power over the next scheduling interval, which is
> why energy and power can be treated as equivalent here, but that needs to be
> clarified as it is somewhat confusing right now.

That's right, manipulating power or energy is equivalent here (as in, it
leads to the same conclusions).

I can explain that better in the comment.

Thanks,
Quentin
