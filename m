Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A236C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12816218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbfAaJvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:51:08 -0500
Received: from foss.arm.com ([217.140.101.70]:40588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfAaJvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:51:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74474A78;
        Thu, 31 Jan 2019 01:51:07 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A80393F71E;
        Thu, 31 Jan 2019 01:51:05 -0800 (PST)
Date:   Thu, 31 Jan 2019 09:51:04 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     sudeep.holla@arm.com, rjw@rjwysocki.net, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 1/5] PM / OPP: Introduce a power estimation helper
Message-ID: <20190131095101.g64h32wxqa5rhbqh@queper01-lin>
References: <20190130170506.20450-1-quentin.perret@arm.com>
 <20190130170506.20450-2-quentin.perret@arm.com>
 <20190131072633.bcqc75s6jmyt7fgx@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131072633.bcqc75s6jmyt7fgx@vireshk-i7>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 Jan 2019 at 12:56:33 (+0530), Viresh Kumar wrote:
> On 30-01-19, 17:05, Quentin Perret wrote:
> > +static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
> > +					 int cpu)
> > +{
> > +	struct device *cpu_dev;
> > +	struct dev_pm_opp *opp;
> > +	struct device_node *np;
> > +	unsigned long mV, Hz;
> > +	u32 cap;
> > +	u64 tmp;
> > +	int ret;
> > +
> > +	cpu_dev = get_cpu_device(cpu);
> > +	if (!cpu_dev)
> > +		return -ENODEV;
> > +
> > +	np = of_node_get(cpu_dev->of_node);
> > +	if (!np)
> > +		return -EINVAL;
> > +
> > +	ret = of_property_read_u32(np, "dynamic-power-coefficient", &cap);
> > +	of_node_put(np);
> > +	if (ret)
> > +		return -EINVAL;
> > +
> > +	Hz = *kHz * 1000;
> > +	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
> > +	if (IS_ERR(opp))
> > +		return -EINVAL;
> > +
> > +	mV = dev_pm_opp_get_voltage(opp) / 1000;
> 
> The voltage is also stored as triplet now a days and we must consider
> the higher value for these calculations. Also what about the case of
> multiple regulators here or performance-states ?

Well at least this is not worst than what we already do for IPA :-)

https://elixir.bootlin.com/linux/latest/source/drivers/thermal/cpu_cooling.c#L245

In the case of multiple regulators, then maybe that should be dealt with
at the dev_pm_op_get_voltage() ? Not sure.

> 
> > +	dev_pm_opp_put(opp);
> > +	if (!mV)
> > +		return -EINVAL;
> > +
> > +	tmp = (u64)cap * mV * mV * (Hz / 1000000);
> > +	do_div(tmp, 1000000000);
> > +
> > +	*mW = (unsigned long)tmp;
> 
> I was thinking will it be better if we just save this information in
> opp->power field during init, so we can just read a value here
> instead. But I am still not sure :(

Yeah, I had the exact same question. But, then I thought, we're only
gonna use that once, so it's not clear we need to cache the value. And I
don't think we want other subsystems to ask PM_OPP for power values
directly. Those subsystems should ask the EM framework instead (which
exists for that very reason). So we're probably not gonna expose a
dev_pm_opp_get_power() accessor or so, I think.

That's why I went that way.

> 
> > +	*kHz = Hz / 1000;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * dev_pm_opp_of_register_em() - Attempt to register an Energy Model
> > + * @cpus	: CPUs for which an Energy Model has to be registered
> > + * @nr_opp	: Number of OPPs to register in the Energy Model
> > + *
> > + * This checks whether the "dynamic-power-coefficient" devicetree binding has
> > + * been specified, and tries to register an Energy Model with it if it has.
> > + */
> > +void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
> > +{
> > +	struct em_data_callback em_cb = EM_DATA_CB(_get_cpu_power);
> > +	int ret, cpu = cpumask_first(cpus);
> > +	struct device *cpu_dev;
> > +	struct device_node *np;
> > +	u32 cap;
> > +
> > +	cpu_dev = get_cpu_device(cpu);
> > +	if (!cpu_dev)
> > +		return;
> > +
> > +	np = of_node_get(cpu_dev->of_node);
> > +	if (!np)
> > +		return;
> > +
> > +	/* Don't register an EM without the right DT binding */
> > +	ret = of_property_read_u32(np, "dynamic-power-coefficient", &cap);
> > +	of_node_put(np);
> > +	if (ret || !cap)
> > +		return;
> 
> What if no voltage is supplied in DT ?

Then don't provide 'dynamic-power-coefficient' ? There is nothing you
can do with that without voltages I think.

With this implementation you'll get an error message at some point,
which is probably sane.

> 
> > +
> > +	em_register_perf_domain(cpus, nr_opp, &em_cb);
> > +}
> > +EXPORT_SYMBOL_GPL(dev_pm_opp_of_register_em);
> > diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> > index b895f4e79868..58ae08b024bd 100644
> > --- a/include/linux/pm_opp.h
> > +++ b/include/linux/pm_opp.h
> > @@ -327,6 +327,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
> >  struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
> >  struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
> >  int of_get_required_opp_performance_state(struct device_node *np, int index);
> > +void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp);
> >  #else
> >  static inline int dev_pm_opp_of_add_table(struct device *dev)
> >  {
> > @@ -365,6 +366,11 @@ static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
> >  {
> >  	return NULL;
> >  }
> > +
> > +static inline void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
> > +{
> > +}
> > +
> >  static inline int of_get_required_opp_performance_state(struct device_node *np, int index)
> >  {
> >  	return -ENOTSUPP;
> > -- 
> > 2.20.1
> 
> -- 
> viresh

Thanks,
Quentin
