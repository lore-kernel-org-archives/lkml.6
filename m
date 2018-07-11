Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4B3C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B565F20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lBgE0s6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B565F20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390385AbeGKUnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:43:23 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41251 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732892AbeGKUnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:43:22 -0400
Received: by mail-pl0-f66.google.com with SMTP id w8-v6so9659706ply.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4E+PN71sBaKHIYJKO5c0H9eoqFpa1sEJG9i7cv3O3D0=;
        b=lBgE0s6Z3B5FKQEVDEo1wHEX04phi/NrjSbLjdcVfi/0Ap8qvri0GawmfjG1cY6A4K
         gehB9et6atwVyxiJAFMMo1w/A+yYeX8w9A06IEpE0wWuzt4o0X1vf8HqXzGFzM+JHrG9
         gU2HmzX0wy5TmeNCoO8WTHCYkkL0h1XYFIRug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4E+PN71sBaKHIYJKO5c0H9eoqFpa1sEJG9i7cv3O3D0=;
        b=YfiA9/leMqd92gmLz16fWOJUM/a01YBc2BYXqnTKEnXpnTH5Vmcdw1l2u4No5L7ASu
         xLCHCEVOlnd2fzCA3mKR498/I85yYleAT8EnpeDwrTXL+YoSlqUsh4OQw/VYcmk/mUet
         RJtgxaf2aWRVHq+8sqZXyoNDI2lORSdsd/ZKteq+CPJr51y4Z6vTT36L/dN5k5n8Gvok
         gxgPiqxm2EYoroKHDFh3L/bXnt808GKDbbdKkdJImrHPnMCU09e/Sf4AVXqD7JHIgqKC
         uA7uivTCFIXtfsSdCNtAFMiyDHxS8sEEGiAkYdY6Q+3bYzd/WRGKVW6x9lrEWtkAsurZ
         KJ6g==
X-Gm-Message-State: AOUpUlF2bEW6GXvmtIPwvMrXN6rOUIRhcgSV9UuIey17xSenOFv60go7
        WwfZn1aQ5oF+FGKj03v1//j2LQ==
X-Google-Smtp-Source: AAOMgpdAskiGtvR6/Ad/NVk4pslpBPFr44DPkht2J+dYFkRJrjNDUNLXE6kalpsQW0Ch4woturdSkg==
X-Received: by 2002:a17:902:5857:: with SMTP id f23-v6mr146694plj.206.1531341438712;
        Wed, 11 Jul 2018 13:37:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id 84-v6sm34236291pfj.33.2018.07.11.13.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:37:18 -0700 (PDT)
Date:   Wed, 11 Jul 2018 13:37:17 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org
Subject: Re: [PATCH v4 2/2] cpufreq: qcom-fw: Add support for QCOM cpufreq FW
 driver
Message-ID: <20180711203717.GS129942@google.com>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-3-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1528801355-18719-3-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 12, 2018 at 04:32:35PM +0530, Taniya Das wrote:
> The CPUfreq FW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this firmware.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm       |   9 +
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/qcom-cpufreq-fw.c | 336 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 346 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-fw.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 52f5f1a..2683716 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -312,3 +312,12 @@ config ARM_PXA2xx_CPUFREQ
>  	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
> 
>  	  If in doubt, say N.
> +
> +config ARM_QCOM_CPUFREQ_FW
> +	bool "QCOM CPUFreq FW driver"
> +	help
> +	 Support for the CPUFreq FW driver.
> +	 The CPUfreq FW preset in some QCOM chipsets offloads the steps
> +	 necessary for changing the frequency of CPUs. The driver
> +	 implements the cpufreq driver interface for this firmware.
> +	 Say Y if you want to support CPUFreq FW.
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index fb4a2ec..34691a2 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -86,6 +86,7 @@ obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
>  obj-$(CONFIG_ARM_TI_CPUFREQ)		+= ti-cpufreq.o
>  obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
> +obj-$(CONFIG_ARM_QCOM_CPUFREQ_FW)	+= qcom-cpufreq-fw.o
> 
> 
>  ##################################################################################
> diff --git a/drivers/cpufreq/qcom-cpufreq-fw.c b/drivers/cpufreq/qcom-cpufreq-fw.c
> new file mode 100644
> index 0000000..62f4452
> --- /dev/null
> +++ b/drivers/cpufreq/qcom-cpufreq-fw.c
> @@ -0,0 +1,336 @@
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
> +struct cpufreq_qcom {
> +	struct cpufreq_frequency_table *table;
> +	struct device *dev;
> +	void __iomem *perf_base;
> +	void __iomem *lut_base;
> +	cpumask_t related_cpus;
> +	unsigned int max_cores;

Why *max*_cores? This seems to be the number of CPUs in a cluster and
qcom_read_lut() expects the core count read from the LUT to match
exactly.

> +static int qcom_read_lut(struct platform_device *pdev,
> +			 struct cpufreq_qcom *c)
> +{
> +	struct device *dev = &pdev->dev;
> +	u32 data, src, lval, i, core_count, prev_cc, prev_freq, cur_freq;
> +
> +	c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
> +				sizeof(*c->table), GFP_KERNEL);
> +	if (!c->table)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> +		data = readl_relaxed(c->lut_base + i * LUT_ROW_SIZE);
> +		src = ((data & GENMASK(31, 30)) >> 30);
> +		lval = (data & GENMASK(7, 0));
> +		core_count = CORE_COUNT_VAL(data);
> +
> +		if (!src)
> +			c->table[i].frequency = INIT_RATE / 1000;
> +		else
> +			c->table[i].frequency = XO_RATE * lval / 1000;

nit: any particular reason to use negative logic here? Why not check
for 'src[ != NULL]', which also seems to be the more common case.

> +static int qcom_get_related_cpus(struct device_node *np, struct cpumask *m)
> +{
> +	struct device_node *cpu_np, *freq_np;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_np = of_cpu_device_node_get(cpu);
> +		if (!cpu_np)
> +			continue;
> +		freq_np = of_parse_phandle(cpu_np, "qcom,freq-domain", 0);
> +		if (!freq_np)
> +			continue;
> +		if (freq_np == np)
> +			cpumask_set_cpu(cpu, m);

missing 'of_node_put(cpu_np)'. You might want to do it at the end of
the loop and use a 'goto' above instead of 'continue'.

> +static int qcom_cpu_resources_init(struct platform_device *pdev,
> +				   struct device_node *np, unsigned int cpu)
> +{
> +	struct cpufreq_qcom *c;
> +	struct resource res;
> +	struct device *dev = &pdev->dev;
> +	void __iomem *en_base;
> +	int index, ret;
> +
> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
> +	if (!c)
> +		return -ENOMEM;
> +
> +	index = of_property_match_string(np, "reg-names", "enable");
> +	if (index < 0)
> +		return index;
> +
> +	if (of_address_to_resource(np, index, &res))
> +		return -ENOMEM;
> +
> +	en_base = devm_ioremap(dev, res.start, resource_size(&res));
> +	if (!en_base) {
> +		dev_err(dev, "Unable to map %s enable-base\n", np->name);
> +		return -ENOMEM;
> +	}
> +
> +	/* FW should be in enabled state to proceed */
> +	if (!(readl_relaxed(en_base) & 0x1)) {
> +		dev_err(dev, "%s firmware not enabled\n", np->name);
> +		return -ENODEV;
> +	}
> +	devm_iounmap(&pdev->dev, en_base);
> +
> +	index = of_property_match_string(np, "reg-names", "perf");
> +	if (index < 0)
> +		return index;
> +
> +	if (of_address_to_resource(np, index, &res))
> +		return -ENOMEM;
> +
> +	c->perf_base = devm_ioremap(dev, res.start, resource_size(&res));
> +	if (!c->perf_base) {
> +		dev_err(dev, "Unable to map %s perf-base\n", np->name);
> +		return -ENOMEM;
> +	}
> +
> +	index = of_property_match_string(np, "reg-names", "lut");
> +	if (index < 0)
> +		return index;
> +
> +	if (of_address_to_resource(np, index, &res))
> +		return -ENOMEM;
> +
> +	c->lut_base = devm_ioremap(dev, res.start, resource_size(&res));
> +	if (!c->lut_base) {
> +		dev_err(dev, "Unable to map %s lut-base\n", np->name);
> +		return -ENOMEM;
> +	}

The of_property_match_string() - of_address_to_resource() -
devm_ioremap() pattern is repeated 3x. In case the binding doesn't
change (there is discussion on the DT patch) you might want to move
this to a helper.

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

Cheers

Matthias
