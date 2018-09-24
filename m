Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC34C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986252145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D8hlfShh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986252145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732883AbeIXXFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:05:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34360 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730682AbeIXXFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:05:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id f18-v6so514933plr.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=alUF8nTRq4ZcAdmzhtlZrkIssUHcy7+DfFN3h9wj34E=;
        b=D8hlfShhoq3I8928YTR/9adKZBidfOAVIkG0ROuxQV9XUQg0M/5EsizSOFqWf3f4NL
         Pqj+OoZmDnauRJ7vHJTh2sRjafzfNJWo9fhmfox+B5EU+Ut7K1DWo1frQWvey0OEoJ4x
         nwtgUuM7VBgZ+AMVOY44Fuc+7hS+UwRxhhipY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=alUF8nTRq4ZcAdmzhtlZrkIssUHcy7+DfFN3h9wj34E=;
        b=XLnJUBmaPCICyQUdOBmbJuUmI5mCXoVCd4SVVfj9purQwfiueFIoCwSbgm4CvwyZr9
         d30onqxik5JwSg2EdMzT0oJWa6CitMnlItYPo/sGvJcHWAOV5Hyydh5pp7nnE1S2Psbi
         VmYG/nqWmnY2V8MztL5jYvqs1/CgJdciv7HYtg68I3pLjcGPNx3VS3YtOzZ3hxusWGyB
         WOjKIl5RcsZg61Y/KmIfp8k0CLgUyFqJ7vz9Wntj4ojXNv7zETtD0NFh2qVI6j+nC3RO
         3i+bx8W+Ga8rx88OTvteOrMTL4OROquXwoELqICAUrHOFocdTDAGaAJabbSjH/tcjtKh
         Ghhw==
X-Gm-Message-State: ABuFfoiys0Iim+CZA5S9+LPKpL8J+yVoc6R0zP67g0j5CZBLUbxPwbn7
        Muy0657JeTuoaBBMKVIbfvTVmw==
X-Google-Smtp-Source: ACcGV638+iTFrbMcCGFxZBQak3Yi8hQNv2bpllaWzhYba5HOUz+6uG0AoY1Szn16Xa5h44ZOt0el8g==
X-Received: by 2002:a17:902:163:: with SMTP id 90-v6mr11548535plb.322.1537808521302;
        Mon, 24 Sep 2018 10:02:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id s14-v6sm3020520pfh.142.2018.09.24.10.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 10:02:00 -0700 (PDT)
Date:   Mon, 24 Sep 2018 10:02:00 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, amit.kucheria@linaro.org,
        evgreen@google.com
Subject: Re: [PATCH v7 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Message-ID: <20180924170200.GZ22824@google.com>
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-3-git-send-email-tdas@codeaurora.org>
 <20180829180122.GC10879@google.com>
 <8c19c840-292c-a5c4-f3d3-0c6fb14b15fb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8c19c840-292c-a5c4-f3d3-0c6fb14b15fb@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 03:10:55PM +0530, Taniya Das wrote:
> Hello Matthias,
> 
> Thanks for your review comments.
> 
> On 8/29/2018 11:31 PM, Matthias Kaehlcke wrote:
> > Hi Taniya,
> > 
> > On Tue, Jul 24, 2018 at 04:12:50PM +0530, Taniya Das wrote:
> > > The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
> > > for changing the frequency of CPUs. The driver implements the cpufreq
> > > driver interface for this hardware engine.
> > > 
> > > Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> > > Signed-off-by: Taniya Das <tdas@codeaurora.org>
> > > ---
> > >   drivers/cpufreq/Kconfig.arm       |  11 ++
> > >   drivers/cpufreq/Makefile          |   1 +
> > >   drivers/cpufreq/qcom-cpufreq-hw.c | 348 ++++++++++++++++++++++++++++++++++++++
> > >   3 files changed, 360 insertions(+)
> > >   create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c
> > > 
> > > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > > index 0cd8eb7..93a9d72 100644
> > > --- a/drivers/cpufreq/Kconfig.arm
> > > +++ b/drivers/cpufreq/Kconfig.arm
> > > @@ -298,3 +298,14 @@ config ARM_PXA2xx_CPUFREQ
> > >   	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
> > > 
> > >   	  If in doubt, say N.
> > > +
> > > +config ARM_QCOM_CPUFREQ_HW
> > > +	bool "QCOM CPUFreq HW driver"
> > > +	depends on ARCH_QCOM
> > > +	help
> > > +	 Support for the CPUFreq HW driver.
> > > +	 Some QCOM chipsets have a HW engine to offload the steps
> > > +	 necessary for changing the frequency of the CPUs. Firmware loaded
> > > +	 in this engine exposes a programming interface to the OS.
> > > +	 The driver implements the cpufreq interface for this HW engine.
> > > +	 Say Y if you want to support CPUFreq HW.
> > > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> > > index c1ffeab..ca48a1d 100644
> > > --- a/drivers/cpufreq/Makefile
> > > +++ b/drivers/cpufreq/Makefile
> > > @@ -85,6 +85,7 @@ obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
> > >   obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
> > >   obj-$(CONFIG_ARM_TI_CPUFREQ)		+= ti-cpufreq.o
> > >   obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
> > > +obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)	+= qcom-cpufreq-hw.o
> > > 
> > > 
> > >   ##################################################################################
> > > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > new file mode 100644
> > > index 0000000..ea8f7d1
> > > --- /dev/null
> > > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > @@ -0,0 +1,348 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> > > + */
> > > +
> > > +#include <linux/cpufreq.h>
> > > +#include <linux/init.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/of_platform.h>
> > > +
> > > +#define INIT_RATE			300000000UL
> > > +#define LUT_MAX_ENTRIES			40U
> > > +#define CORE_COUNT_VAL(val)		(((val) & (GENMASK(18, 16))) >> 16)
> > > +#define LUT_ROW_SIZE			32
> > > +
> > > +enum {
> > > +	REG_ENABLE,
> > > +	REG_LUT_TABLE,
> > > +	REG_PERF_STATE,
> > > +
> > > +	REG_ARRAY_SIZE,
> > > +};
> > > +
> > > +struct cpufreq_qcom {
> > > +	struct cpufreq_frequency_table *table;
> > > +	struct device *dev;
> > 
> > 'dev' is not used and can be removed.
> > 
> 
> Thanks, would remove in the next patch.
> 
> > > ...
> > > 
> > > +static int qcom_cpu_resources_init(struct platform_device *pdev,
> > > +				   struct device_node *np, unsigned int cpu,
> > > +				   unsigned long xo_rate)
> > > +{
> > > +	struct cpufreq_qcom *c;
> > > +	struct resource res;
> > > +	struct device *dev = &pdev->dev;
> > > +	const u16 *offsets;
> > > +	int ret, i, cpu_first, cpu_r;
> > > +	void __iomem *base;
> > > +
> > > +	if (qcom_freq_domain_map[cpu])
> > > +		return 0;
> > > +
> > > +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
> > > +	if (!c)
> > > +		return -ENOMEM;
> > > +
> > > +	offsets = of_device_get_match_data(&pdev->dev);
> > > +	if (!offsets)
> > > +		return -EINVAL;
> > > +
> > > +	if (of_address_to_resource(np, 0, &res))
> > > +		return -ENOMEM;
> > > +
> > > +	base = devm_ioremap_resource(dev, &res);
> > > +	if (!base)
> > > +		return -ENOMEM;
> > > +
> > > +	for (i = REG_ENABLE; i < REG_ARRAY_SIZE; i++)
> > > +		c->reg_bases[i] = base + offsets[i];
> > > +
> > > +	/* HW should be in enabled state to proceed */
> > > +	if (!(readl_relaxed(c->reg_bases[REG_ENABLE]) & 0x1)) {
> > > +		dev_err(dev, "%s cpufreq hardware not enabled\n", np->name);
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	ret = qcom_get_related_cpus(np, &c->related_cpus);
> > > +	if (ret) {
> > > +		dev_err(dev, "%s failed to get related CPUs\n", np->name);
> > > +		return ret;
> > > +	}
> > > +
> > > +	c->max_cores = cpumask_weight(&c->related_cpus);
> > > +	if (!c->max_cores)
> > > +		return -ENOENT;
> > > +
> > > +	c->xo_rate = xo_rate;
> > > +
> > > +	ret = qcom_cpufreq_hw_read_lut(pdev, c);
> > > +	if (ret) {
> > > +		dev_err(dev, "%s failed to read LUT\n", np->name);
> > > +		return ret;
> > > +	}
> > > +
> > > +	qcom_freq_domain_map[cpu] = c;
> > > +
> > > +	/* Related CPUs */
> > > +	cpu_first = cpumask_first(&c->related_cpus);
> > > +
> > > +	for_each_cpu(cpu_r, &c->related_cpus) {
> > > +		if (cpu_r != cpu_first)
> > > +			qcom_freq_domain_map[cpu_r] =
> > > +				qcom_freq_domain_map[cpu_first];
> > > +	}
> > 
> > The above ten lines could be simplified to:
> > 
> > 	for_each_cpu(cpu_r, &c->related_cpus)
> > 		qcom_freq_domain_map[cpu_r] = c;
> > 
> 
> Would clean it up in the next patch.
> 
> > > ...
> > > 
> > > +static int __init qcom_cpufreq_hw_init(void)
> > > +{
> > > +	return platform_driver_register(&qcom_cpufreq_hw_driver);
> > > +}
> > > +subsys_initcall(qcom_cpufreq_hw_init);
> > 
> > Is subsys_initcall used for a particular reason? It will cause
> > problems when registering cooling devices, since the thermal device
> > class is initialized through an fs_initcall, which are executed
> > later.
> > 
> > Most cpufreq drivers use module_init, device_initcall or
> > late_initcall, can't this driver use one of those?
> > 
> 
> We want the CPU to be scaling to the highest frequency at the
> earliest.

I guess you also want thermal management for the CPU. With the
subsys_initcall registration of cooling devices fails, as mentioned in
my earlier comment. Do you plan to defer the registration of cooling
devices?

Cheers

Matthias
