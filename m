Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAC1C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A42321473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfA2JDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:03:39 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60334 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbfA2JDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:03:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F0EE80D;
        Tue, 29 Jan 2019 01:03:38 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 946403F7A6;
        Tue, 29 Jan 2019 01:03:35 -0800 (PST)
Date:   Tue, 29 Jan 2019 09:03:34 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, sudeep.holla@arm.com,
        liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH 1/7] PM / OPP: Introduce a power estimation helper
Message-ID: <20190129090331.fgygq3dsaoqvegsl@queper01-lin>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-2-quentin.perret@arm.com>
 <20190128190251.GH81583@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128190251.GH81583@google.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Monday 28 Jan 2019 at 11:02:51 (-0800), Matthias Kaehlcke wrote:
> > +/**
> > + * of_dev_pm_opp_get_cpu_power() - Estimates the power of a CPU
> > + * @mW:		pointer to the power estimate in milli-watts
> > + * @KHz:	pointer to the OPP's frequency, in kilo-hertz
> 
> nit: should be kHz

Right, I can change that :-)

> 
> > + * @cpu:	CPU for which power needs to be estimated
> > + *
> > + * Computes the power estimated by @CPU at the first OPP above @KHz (ceil),
> > + * and updates @KHz and @mW accordingly.
> > + *
> > + * The power is estimated as P = C * V^2 * f, with C the CPU's capacitance
> > + * (read from the 'dynamic-power-coefficient' devicetree binding) and V and f
> > + * respectively the voltage and frequency of the OPP.
> > + *
> > + * Return: -ENODEV if the CPU device cannot be found, -EINVAL if the power
> > + * calculation failed because of missing parameters, 0 otherwise.
> > + */
> > +int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu)
> 
> I think it is more common to put the input parameters first, then the
> output ones, i.e. cpu, kHz, mW.

Hmm, the issue is this must match the expectations of the EM framework:

https://elixir.bootlin.com/linux/v5.0-rc4/source/include/linux/energy_model.h#L62

So, I don't really have a choice. Or we can change the core code if this
_really_ is a problem -- we don't have users yet so now is the best time
to do so I guess ...

> 
> > +{
> > +	unsigned long mV, Hz, MHz;
> > +	struct device *cpu_dev;
> > +	struct dev_pm_opp *opp;
> > +	struct device_node *np;
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
> > +	Hz = *KHz * 1000;
> > +	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
> > +	if (IS_ERR(opp))
> > +		return -EINVAL;
> > +
> > +	mV = dev_pm_opp_get_voltage(opp) / 1000;
> > +	dev_pm_opp_put(opp);
> > +	if (!mV)
> > +		return -EINVAL;
> > +
> > +	MHz = Hz / 1000000;
> > +	tmp = (u64)cap * mV * mV * MHz;
> > +	do_div(tmp, 1000000000);
> > +
> > +	*mW = (unsigned long)tmp;
> > +	*KHz = Hz / 1000;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(of_dev_pm_opp_get_cpu_power);
> > diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> > index 0a2a88e5a383..fedde14f5187 100644
> > --- a/include/linux/pm_opp.h
> > +++ b/include/linux/pm_opp.h
> > @@ -322,6 +322,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
> >  struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
> >  struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
> >  int of_get_required_opp_performance_state(struct device_node *np, int index);
> > +int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu);
> >  #else
> >  static inline int dev_pm_opp_of_add_table(struct device *dev)
> >  {
> > @@ -364,6 +365,10 @@ static inline int of_get_required_opp_performance_state(struct device_node *np,
> >  {
> >  	return -ENOTSUPP;
> >  }
> > +static inline int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu)
> > +{
> > +	return -ENOTSUPP;
> > +}
> >  #endif
> >  
> >  #endif		/* __LINUX_OPP_H__ */
> 
> Besides the nits above:
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>

Thank you !
Quentin
