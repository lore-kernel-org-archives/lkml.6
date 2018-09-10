Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5E6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E608D20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wjwhs6iL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E608D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbeIKAZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:25:55 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37961 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbeIKAZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:25:54 -0400
Received: by mail-ua1-f66.google.com with SMTP id o11-v6so18420935uak.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 12:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3qAgghxsUxy35dA7x81KoYn2yPTZ/zcubHf3SKeIk0w=;
        b=Wjwhs6iLbouBSmEK/zuU+ZZYY+MhLDTt4gYlptVTAIX8noJ1c2/u7FRWBYmhequS8P
         ng3riKaRAjyx/3ccE7PWMPT3nb6kvERPfKP/wGFjN2bS/xXht++8TQzLO1hVauaGrH2e
         Ele6Mi1G3hF9POZjjcmU4ISA+X11eFO3qxKJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3qAgghxsUxy35dA7x81KoYn2yPTZ/zcubHf3SKeIk0w=;
        b=UGpM14FYSjADRPbMjaUKyRTJ1yIlYsNIxwYQPOyBApm1ouuhOW1Y8RFbaB2eNr5mPb
         FPjXt7wx48/Vn2q4Vvb68WjnMzSdAq9qivRaT6I9S1SknxJQc4JiOqSZmpt5zgo3V/yS
         S2SX76FzQuE4zqdxUkXmC9sZ7mtehu6aqFbsXRg7coPS244XjqyvJ31e8TrxkZXDzzp0
         7xrwbr068tfWiwVbhpsL7+uI4PZ6m9uWaJ0vY0hk4BCtQTZMmYQAJNSZ65JvlqRlNGNd
         JAM3ZQ/IQoUm42crdvomH0HEUnYDhpGAHssvcx+J4oSPTs7HWyoInz9lHmdrp0vnRRmO
         ma4Q==
X-Gm-Message-State: APzg51BSfbR8hqWmnd99DF0b4dILF4TgNyKBLf9bVN3iG3WSbx3UgOUB
        S3+2EFR3vIvIqkOXQLN0GcCsOw==
X-Google-Smtp-Source: ANB0VdY1Biotpa8hczemR/UiOn1T8ozefAgw7ksiML7iWlRBqM+Cd9Ugsadrivzjvq+UClEHaq7kUw==
X-Received: by 2002:ab0:644f:: with SMTP id j15-v6mr7694532uap.70.1536607818468;
        Mon, 10 Sep 2018 12:30:18 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id e185-v6sm7255416vkd.15.2018.09.10.12.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 12:30:17 -0700 (PDT)
Date:   Mon, 10 Sep 2018 12:30:16 -0700
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
Message-ID: <20180910193016.GG22824@google.com>
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-3-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1532428970-18122-3-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 04:12:50PM +0530, Taniya Das wrote:
> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this hardware engine.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm       |  11 ++
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/qcom-cpufreq-hw.c | 348 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 360 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 0cd8eb7..93a9d72 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -298,3 +298,14 @@ config ARM_PXA2xx_CPUFREQ
>  	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
> 
>  	  If in doubt, say N.
> +
> +config ARM_QCOM_CPUFREQ_HW
> +	bool "QCOM CPUFreq HW driver"
> +	depends on ARCH_QCOM
> +	help
> +	 Support for the CPUFreq HW driver.
> +	 Some QCOM chipsets have a HW engine to offload the steps
> +	 necessary for changing the frequency of the CPUs. Firmware loaded
> +	 in this engine exposes a programming interface to the OS.
> +	 The driver implements the cpufreq interface for this HW engine.
> +	 Say Y if you want to support CPUFreq HW.
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index c1ffeab..ca48a1d 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -85,6 +85,7 @@ obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
>  obj-$(CONFIG_ARM_TI_CPUFREQ)		+= ti-cpufreq.o
>  obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
> +obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)	+= qcom-cpufreq-hw.o
> 
> 
>  ##################################################################################
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> new file mode 100644
> index 0000000..ea8f7d1
> --- /dev/null
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -0,0 +1,348 @@
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
> +	void __iomem *reg_bases[REG_ARRAY_SIZE];
> +	cpumask_t related_cpus;
> +	unsigned int max_cores;
> +	unsigned long xo_rate;
> +};
> +
> +static const u16 cpufreq_qcom_std_offsets[REG_ARRAY_SIZE] = {
> +	[REG_ENABLE]		= 0x0,
> +	[REG_LUT_TABLE]		= 0x110,
> +	[REG_PERF_STATE]	= 0x920,
> +};
> +
> +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
> +
> +static int
> +qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> +			     unsigned int index)
> +{
> +	struct cpufreq_qcom *c = policy->driver_data;
> +
> +	writel_relaxed(index, c->reg_bases[REG_PERF_STATE]);
> +
> +	return 0;
> +}
> +
> +static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
> +{
> +	struct cpufreq_qcom *c;
> +	struct cpufreq_policy *policy;
> +	unsigned int index;
> +
> +	policy = cpufreq_cpu_get_raw(cpu);
> +	if (!policy)
> +		return 0;
> +
> +	c = policy->driver_data;
> +
> +	index = readl_relaxed(c->reg_bases[REG_PERF_STATE]);
> +	index = min(index, LUT_MAX_ENTRIES - 1);
> +
> +	return policy->freq_table[index].frequency;
> +}
> +
> +static unsigned int
> +qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
> +			    unsigned int target_freq)
> +{
> +	struct cpufreq_qcom *c = policy->driver_data;
> +	int index;
> +
> +	index = policy->cached_resolved_idx;
> +	if (index < 0)
> +		return 0;
> +
> +	writel_relaxed(index, c->reg_bases[REG_PERF_STATE]);
> +
> +	return policy->freq_table[index].frequency;
> +}
> +
> +static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> +{
> +	struct cpufreq_qcom *c;
> +
> +	c = qcom_freq_domain_map[policy->cpu];
> +	if (!c) {
> +		pr_err("No scaling support for CPU%d\n", policy->cpu);
> +		return -ENODEV;
> +	}
> +
> +	cpumask_copy(policy->cpus, &c->related_cpus);
> +
> +	policy->fast_switch_possible = true;
> +	policy->freq_table = c->table;
> +	policy->driver_data = c;
> +
> +	return 0;
> +}
> +
> +static struct freq_attr *qcom_cpufreq_hw_attr[] = {
> +	&cpufreq_freq_attr_scaling_available_freqs,
> +	&cpufreq_freq_attr_scaling_boost_freqs,
> +	NULL
> +};
> +
> +static struct cpufreq_driver cpufreq_qcom_hw_driver = {
> +	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> +			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
> +	.verify		= cpufreq_generic_frequency_table_verify,
> +	.target_index	= qcom_cpufreq_hw_target_index,
> +	.get		= qcom_cpufreq_hw_get,
> +	.init		= qcom_cpufreq_hw_cpu_init,
> +	.fast_switch    = qcom_cpufreq_hw_fast_switch,
> +	.name		= "qcom-cpufreq-hw",
> +	.attr		= qcom_cpufreq_hw_attr,
> +	.boost_enabled	= true,
> +};
> +
> +static int qcom_cpufreq_hw_read_lut(struct platform_device *pdev,
> +				    struct cpufreq_qcom *c)
> +{
> +	struct device *dev = &pdev->dev;
> +	void __iomem *base;
> +	u32 data, src, lval, i, core_count, prev_cc, prev_freq, cur_freq;
> +
> +	c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
> +				sizeof(*c->table), GFP_KERNEL);
> +	if (!c->table)
> +		return -ENOMEM;
> +
> +	base = c->reg_bases[REG_LUT_TABLE];
> +
> +	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> +		data = readl_relaxed(base + i * LUT_ROW_SIZE);
> +		src = (data & GENMASK(31, 30)) >> 30;
> +		lval = data & GENMASK(7, 0);
> +		core_count = CORE_COUNT_VAL(data);
> +
> +		if (src)
> +			c->table[i].frequency = c->xo_rate * lval / 1000;
> +		else
> +			c->table[i].frequency = INIT_RATE / 1000;
> +
> +		cur_freq = c->table[i].frequency;
> +
> +		dev_dbg(dev, "index=%d freq=%d, core_count %d\n",
> +			i, c->table[i].frequency, core_count);
> +
> +		if (core_count != c->max_cores)
> +			cur_freq = CPUFREQ_ENTRY_INVALID;
> +

I noticed that the 'power_allocator' thermal governor currently can't
be used with this driver since there is no OPP table with frequency and
voltage information. Does the LUT contain information about the
voltage or is there another mechanism to retrieve it?
