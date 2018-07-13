Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372AEECDFAA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31CE2083C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eEA+PMF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31CE2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbeGMAcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:32:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46154 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387739AbeGMAcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:32:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id p23-v6so4242257pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 17:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fnTsDdJylOL65EXMjbSZ1AcjOhYpp2pajDcK66qFECw=;
        b=eEA+PMF5z9p+la/rUXqhrH/pdWwT9Q6YL58usds18tBhvSvhabJtJkGR0LAMeBMBaK
         UAacwSBPIpcMSjy9Plc8cDFJhQdtAc7RoBrwwzoKAfMm2kfUTkMvnnQkzDD5E9hNyxoe
         f+gmU7ayy+GDVigUEj97ExvR43X1V61kVwrRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fnTsDdJylOL65EXMjbSZ1AcjOhYpp2pajDcK66qFECw=;
        b=iqQzzt0o6Q49QQdRXjfBeo6aO5CC95QyKFccawQ2TT53UOChkeXFTCRFEjE5bHkaLh
         uA8BXIqvI0Fd1Y+rKP0yoX8SHDK/dV3g6y6Ygu85clxi3KdyOlpTCQpizrSD8o4Bjn4g
         26p5nNFWc1KkvqhtjZVpigzj0B3wUFz4hkUcDPQv/3SeFzD2etf0fnOt1H9q7/risanT
         /MBj894WseXG+2e6PrrGX5yuXJHiWvDa5JTepMCy0rVfULKreIb+Co9Ulhr28oGDNbOO
         rWTtdYXESdLsHM9DKtY/S34dbd5CmZc0CHVh+AjP+mTgkBijvAlfD6kebWI4RW2FMbRI
         7rYQ==
X-Gm-Message-State: AOUpUlHhhGx2ldm9n/s43mYGIPSV1dDGm9Bt/UqXeJ3KiGTLrJ4jCvQT
        MAnuR9BZAW8D6gmP5DMjk/YWCw==
X-Google-Smtp-Source: AAOMgpej/nyI2TTTvenKM+tCOS+b3V/88wwiDmoexgz5S1YQ9mc623h+69QdRFkKvBSndoCxF64ifw==
X-Received: by 2002:a63:8042:: with SMTP id j63-v6mr3948020pgd.230.1531441200719;
        Thu, 12 Jul 2018 17:20:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id b12-v6sm10651140pfe.148.2018.07.12.17.20.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 17:20:00 -0700 (PDT)
Date:   Thu, 12 Jul 2018 17:19:59 -0700
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
Subject: Re: [PATCH v5 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Message-ID: <20180713001959.GV129942@google.com>
References: <1531418745-19742-1-git-send-email-tdas@codeaurora.org>
 <1531418745-19742-3-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1531418745-19742-3-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 12, 2018 at 11:35:45PM +0530, Taniya Das wrote:
> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this hardware engine.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm       |  10 ++
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/qcom-cpufreq-hw.c | 344 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 355 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 52f5f1a..141ec3e 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -312,3 +312,13 @@ config ARM_PXA2xx_CPUFREQ
>  	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
> 
>  	  If in doubt, say N.
> +
> +config ARM_QCOM_CPUFREQ_HW
> +	bool "QCOM CPUFreq HW driver"
> +	help
> +	 Support for the CPUFreq HW driver.
> +	 Some QCOM chipsets have a HW engine to offload the steps
> +	 necessary for changing the frequency of the CPUs. Firmware loaded
> +	 in this engine exposes a programming interafce to the High-level OS.
> +	 The driver implements the cpufreq driver interface for this HW engine.
> +	 Say Y if you want to support CPUFreq HW.
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index fb4a2ec..1226a3e 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -86,6 +86,7 @@ obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
>  obj-$(CONFIG_ARM_TI_CPUFREQ)		+= ti-cpufreq.o
>  obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
> +obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)	+= qcom-cpufreq-hw.o
> 
> 
>  ##################################################################################
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> new file mode 100644
> index 0000000..fa25a95
> --- /dev/null
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/cpufreq.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +
> +#define INIT_RATE			300000000UL
> +#define XO_RATE				19200000UL
> +#define LUT_MAX_ENTRIES			40U
> +#define CORE_COUNT_VAL(val)		(((val) & (GENMASK(18, 16))) >> 16)
> +#define LUT_ROW_SIZE			32
> +
> +enum {
> +	REG_ENABLE,
> +	REG_LUT_TABLE,
> +	REG_PERF_STATE,
> +
> +	REG_ARRAY_SIZE,
> +};
> +
> +struct cpufreq_qcom {
> +	struct cpufreq_frequency_table *table;
> +	struct device *dev;
> +	const u16 *reg_offset;
> +	void __iomem *base;
> +	cpumask_t related_cpus;
> +	unsigned int max_cores;

Same comment as on v4:

Why *max*_cores? This seems to be the number of CPUs in a cluster and
qcom_read_lut() expects the core count read from the LUT to match
exactly. Maybe it's the name from the datasheet? Should it still be
'num_cores' or similer?

> +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];

It would be an option to limit this to the number of CPU clusters and
allocate it dynamically when the driver is initialized (key = first
core in the cluster). Probably not worth the hassle with the limited
number of cores though.

> +static int qcom_read_lut(struct platform_device *pdev,
> +			 struct cpufreq_qcom *c)
> +{
> +	struct device *dev = &pdev->dev;
> +	unsigned int offset;
> +	u32 data, src, lval, i, core_count, prev_cc, prev_freq, cur_freq;
> +
> +	c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
> +				sizeof(*c->table), GFP_KERNEL);
> +	if (!c->table)
> +		return -ENOMEM;
> +
> +	offset = c->reg_offset[REG_LUT_TABLE];
> +
> +	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> +		data = readl_relaxed(c->base + offset + i * LUT_ROW_SIZE);
> +		src = ((data & GENMASK(31, 30)) >> 30);
> +		lval = (data & GENMASK(7, 0));
> +		core_count = CORE_COUNT_VAL(data);
> +
> +		if (src == 0)
> +			c->table[i].frequency = INIT_RATE / 1000;
> +		else
> +			c->table[i].frequency = XO_RATE * lval / 1000;

You changed the condition from '!src' to 'src == 0'. My suggestion on
v4 was in part about a negative condition, but also about the
order. If it doesn't obstruct the code otherwise I think for an if-else
branch it is good practice to handle the more common case first and
then the 'exception'. I would expect most entries to have an actual
rate. Just a nit in any case, feel free to ignore if you prefer as is.

> +static int qcom_cpu_resources_init(struct platform_device *pdev,
> +				   struct device_node *np, unsigned int cpu)
> +{
> +	struct cpufreq_qcom *c;
> +	struct resource res;
> +	struct device *dev = &pdev->dev;
> +	unsigned int offset, cpu_r;
> +	int ret;
> +
> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
> +	if (!c)
> +		return -ENOMEM;
> +
> +	c->reg_offset = of_device_get_match_data(&pdev->dev);
> +	if (!c->reg_offset)
> +		return -EINVAL;
> +
> +	if (of_address_to_resource(np, 0, &res))
> +		return -ENOMEM;
> +
> +	c->base = devm_ioremap(dev, res.start, resource_size(&res));
> +	if (!c->base) {
> +		dev_err(dev, "Unable to map %s base\n", np->name);
> +		return -ENOMEM;
> +	}
> +
> +	offset = c->reg_offset[REG_ENABLE];
> +
> +	/* HW should be in enabled state to proceed */
> +	if (!(readl_relaxed(c->base + offset) & 0x1)) {
> +		dev_err(dev, "%s cpufreq hardware not enabled\n", np->name);
> +		return -ENODEV;
> +	}
> +
> +	ret = qcom_get_related_cpus(np, &c->related_cpus);
> +	if (ret) {
> +		dev_err(dev, "%s failed to get related CPUs\n", np->name);
> +		return ret;
> +	}
> +
> +	c->max_cores = cpumask_weight(&c->related_cpus);
> +	if (!c->max_cores)
> +		return -ENOENT;
> +
> +	ret = qcom_read_lut(pdev, c);
> +	if (ret) {
> +		dev_err(dev, "%s failed to read LUT\n", np->name);
> +		return ret;
> +	}
> +
> +	qcom_freq_domain_map[cpu] = c;

If the general code structure remains as is (see my comment below)
the assignment could be done in a 'if (cpu == cpu_r)' branch instead
of first assigning and then overwriting it for 'cpu != cpu_r'.

> +
> +	/* Related CPUs to keep a single copy */
> +	cpu_r = cpumask_first(&c->related_cpus);
> +	if (cpu != cpu_r) {
> +		qcom_freq_domain_map[cpu] = qcom_freq_domain_map[cpu_r];
> +		devm_kfree(dev, c);
> +	}

Couldn't we do this at the beginning of the function instead of going
through allocation, ioremap, read_lut for every core only to throw the
information away later for the 'related' CPUs?

qcom_cpu_resources_init() is called with increasing 'cpu' values, hence the
'first' CPU of the cluster is already initialized when the 'related'
ones are processed.

> +	return 0;
> +}
> +
> +static int qcom_resources_init(struct platform_device *pdev)
> +{
> +	struct device_node *np, *cpu_np;
> +	unsigned int cpu;
> +	int ret;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_np = of_cpu_device_node_get(cpu);
> +		if (!cpu_np) {
> +			dev_err(&pdev->dev, "Failed to get cpu %d device\n",
> +				cpu);
> +			continue;
> +		}
> +
> +		np = of_parse_phandle(cpu_np, "qcom,freq-domain", 0);
> +		if (!np) {
> +			dev_err(&pdev->dev, "Failed to get freq-domain device\n");

			of_node_put(cpu_np);

> +			return -EINVAL;
> +		}
> +
> +		of_node_put(cpu_np);
> +
> +		ret = qcom_cpu_resources_init(pdev, np, cpu);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

Thanks

Matthias
