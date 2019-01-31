Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86021C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FC92086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfAaJmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:42:19 -0500
Received: from foss.arm.com ([217.140.101.70]:40460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfAaJmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:42:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FE13A78;
        Thu, 31 Jan 2019 01:42:18 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C23023F71E;
        Thu, 31 Jan 2019 01:42:16 -0800 (PST)
Date:   Thu, 31 Jan 2019 09:42:15 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        nm@ti.com, sboyd@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 1/5] PM / OPP: Introduce a power estimation helper
Message-ID: <20190131094212.rjel77xcfvqj6tkr@queper01-lin>
References: <20190130170506.20450-1-quentin.perret@arm.com>
 <20190130170506.20450-2-quentin.perret@arm.com>
 <20190130190703.GM81583@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130190703.GM81583@google.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Wednesday 30 Jan 2019 at 11:07:03 (-0800), Matthias Kaehlcke wrote:
> > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > index 06f0f632ec47..4c8bf172e9ed 100644
> > --- a/drivers/opp/of.c
> > +++ b/drivers/opp/of.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/pm_domain.h>
> >  #include <linux/slab.h>
> >  #include <linux/export.h>
> > +#include <linux/energy_model.h>
> 
> nit: AFAIK typically alphabetical order is used for includes, though
> this file doesn't exactly adhere to it.

Yeah that's what I was thinking too. Since nothing is in order here I
figured there wasn't a best place to put it so I just stick it there. I
happy to re-order all of them if necessary.

> 
> >  #include "opp.h"
> >  
> > @@ -1047,3 +1048,90 @@ struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
> >  	return of_node_get(opp->np);
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
> > +
> > +/*
> > + * Callback function provided to the Energy Model framework upon registration.
> > + * This computes the power estimated by @CPU at the first OPP above @kHz (ceil),
> 
> that's not entirely correct, it could be the OPP at @kHz.

Right, I'll update that.

> 
> > + * and updates @kHz and @mW accordingly. The power is estimated as
> > + * P = C * V^2 * f with C being the CPU's capacitance and V and f respectively
> > + * the voltage and frequency of the OPP.
> > + *
> > + * Returns -ENODEV if the CPU device cannot be found, -EINVAL if the power
> > + * calculation failed because of missing parameters, 0 otherwise.
> > + */
> > +static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
> > +					 int cpu)
> 
> why __maybe_unused?

To avoid compiler warnings with CONFIG_ENERGY_MODEL=n, see my other
email ;-)

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
> > +	dev_pm_opp_put(opp);
> > +	if (!mV)
> > +		return -EINVAL;
> > +
> > +	tmp = (u64)cap * mV * mV * (Hz / 1000000);
> > +	do_div(tmp, 1000000000);
> > +
> > +	*mW = (unsigned long)tmp;
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
> 
> s/binding/property/ ?

Sounds good.

> 
> > + * been specified, and tries to register an Energy Model with it if it has.
> > + */
> > +void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
> 
> Is the nr_opp parameter really needed? The function looks up the CPU
> device and hence could determine the OPP count itself with
> dev_pm_opp_get_opp_count(). I see most cpufreq drivers call
> dev_pm_opp_get_opp_count() anyway, so passing the count as parameter
> can be considered a small optimization, not sure how relevant it is
> though, since dev_pm_opp_of_register_em() isn't called frequently.

Yeah, I figured since most callers of dev_pm_opp_of_register_em()
already counted the OPPs, I could as well use the data instead of
counting again. I mean, dev_pm_opp_get_count() has to traverse the whole
list every time, so there is no point in doing that twice. Not a huge
deal I guess.

> 
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
> 
> Tested-by: Matthias Kaehlcke <mka@chromium.org>

Thank you very much !
Quentin
