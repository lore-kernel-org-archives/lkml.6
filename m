Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598AAC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7C12177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfA2JJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:09:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60514 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfA2JJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:09:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DE2280D;
        Tue, 29 Jan 2019 01:09:54 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2A6B3F7A6;
        Tue, 29 Jan 2019 01:09:51 -0800 (PST)
Date:   Tue, 29 Jan 2019 09:09:50 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, sudeep.holla@arm.com, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, mka@chromium.org
Subject: Re: [PATCH 1/7] PM / OPP: Introduce a power estimation helper
Message-ID: <20190129090948.3yomjtpbdsar576w@queper01-lin>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-2-quentin.perret@arm.com>
 <20190129051030.gu5nhr6vmcd35bzk@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129051030.gu5nhr6vmcd35bzk@vireshk-i7>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On Tuesday 29 Jan 2019 at 10:40:30 (+0530), Viresh Kumar wrote:
> > +int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu)
> 
> I would suggest to change the return type to unsigned long and return 0 for
> errors and positive values for mW.

Well, I can't really do that -- this must match the API of PM_EM:

https://elixir.bootlin.com/linux/v5.0-rc4/source/include/linux/energy_model.h#L62

I'll make sure to make that explicit in the commit message for v2.

> 
> > +{
> > +	unsigned long mV, Hz, MHz;
> 
> MHz is used only once, I think you can get rid of it just open code the division
> by 1000000. Maybe remove Hz as well and directly use kHz.

I would expect/hope the compiler will optimize things like that for me
but yes, I can try to reduce a bit the temp variables if you prefer.

> 
> > +	struct device *cpu_dev;
> > +	struct dev_pm_opp *opp;
> > +	struct device_node *np;
> > +	u32 cap;
> > +	u64 tmp;
> 
> Name this mW with the above changes.

So that doesn't really work given what I mentioned above.

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
> 
> Add a blank line here. We missed adding the same before
> of_get_required_opp_performance_state() earlier, maybe add the new routine
> before of_get_required_opp_performance_state() and add blank line before and
> after it :)

Sounds good !

> 
> > +static inline int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu)
> > +{
> > +	return -ENOTSUPP;
> > +}
> >  #endif
> >  
> >  #endif		/* __LINUX_OPP_H__ */
> > -- 
> > 2.20.1
> 
> -- 
> viresh

Thanks,
Quentin
