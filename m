Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922E0C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B2720878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNEfI+2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B2720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJHPuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:50:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33767 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeJHPuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:50:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id z21-v6so17070423ljz.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 01:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QkqRkz4nsabBejsa4srRb4CDrK14eeiHPgx+b7fqxBE=;
        b=dNEfI+2G7fySVI0ZNzLbWyRc/e5jI2I6owrWpvqdd3b0WiIsMmriBt0oMKf82PJkWI
         x10AeG115me4EOuw3LdeC65APrgkTIA5I09gNMJB/cW/5nSjy04IscUj5uQdDdZYDvQ+
         987ZZ3nxVKF+XNZJh94TYXY9lyRKwjxG5SPxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QkqRkz4nsabBejsa4srRb4CDrK14eeiHPgx+b7fqxBE=;
        b=qQldHr4FeRBDchYQ2+lsbiRhF9MDkJe8iSzp99Eq/7xfreC58sYKw4OJessNB7uvnv
         zDTy5dwL+9IGb394lr2bscHe0ulTHS4Wcls5tkzgEzD1FV63g66nIX/OxH9JhkGCDYEa
         nGnNjojLZ5XnHl2HIR5+AdMEppjpGfJ6wMKfWG7olxmeXVdiLK00YMEfgm8SE25RsU3i
         IxB/YBeztV88hgPIoQXU0A3A1jQrruRgPLF1VRjiGd4FlfOf01ryRICbEJTv3qbpCqg9
         V9GapfrEyldfoQa6kASsrrzpqPrK6aULUSEuljCo04fpnq86kLh0RdyXHT2kgb+LsOmJ
         15IA==
X-Gm-Message-State: ABuFfoizUc+86XUZ0Pd57cnFnFFt4cXDSZ1GrYWFuZ4cvna/GH7onlxC
        KbeZZAJz/J1LDMPbQgaaFehQSw==
X-Google-Smtp-Source: ACcGV62XmCwevkDWcm5URa0DMtx3XoycWLlwiPNVjvI+lccOyKQegVT/Ho6Kr8IH+kkelhP17kG0xg==
X-Received: by 2002:a2e:810e:: with SMTP id d14-v6mr13904775ljg.170.1538988015153;
        Mon, 08 Oct 2018 01:40:15 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id c24-v6sm3855535ljf.21.2018.10.08.01.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 01:40:14 -0700 (PDT)
Date:   Mon, 8 Oct 2018 10:40:12 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com
Subject: Re: [PATCH v8 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Message-ID: <20181008084012.GA23693@centauri.lan>
References: <1537698793-15285-1-git-send-email-tdas@codeaurora.org>
 <1537698793-15285-3-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537698793-15285-3-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 04:03:13PM +0530, Taniya Das wrote:
> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this hardware engine.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm       |  11 ++
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/qcom-cpufreq-hw.c | 354 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 366 insertions(+)
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
> index 0000000..43107ab
> --- /dev/null
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -0,0 +1,354 @@
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
> +#define LUT_MAX_ENTRIES			40U
> +#define CORE_COUNT_VAL(val)		(((val) & (GENMASK(18, 16))) >> 16)
> +#define LUT_ROW_SIZE			32
> +#define CLK_HW_DIV			2
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
> +	void __iomem *reg_bases[REG_ARRAY_SIZE];
> +	cpumask_t related_cpus;
> +	unsigned int max_cores;
> +	unsigned long xo_rate;
> +	unsigned long cpu_hw_rate;
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
> +			c->table[i].frequency = c->cpu_hw_rate / 1000;
> +
> +		cur_freq = c->table[i].frequency;
> +
> +		dev_dbg(dev, "index=%d freq=%d, core_count %d\n",
> +			i, c->table[i].frequency, core_count);
> +
> +		if (core_count != c->max_cores)
> +			cur_freq = CPUFREQ_ENTRY_INVALID;
> +
> +		/*
> +		 * Two of the same frequencies with the same core counts means
> +		 * end of table.
> +		 */
> +		if (i > 0 && c->table[i - 1].frequency ==
> +		   c->table[i].frequency && prev_cc == core_count) {
> +			struct cpufreq_frequency_table *prev = &c->table[i - 1];
> +
> +			if (prev_freq == CPUFREQ_ENTRY_INVALID)
> +				prev->flags = CPUFREQ_BOOST_FREQ;
> +			break;
> +		}
> +		prev_cc = core_count;
> +		prev_freq = cur_freq;
> +	}
> +
> +	c->table[i].frequency = CPUFREQ_TABLE_END;
> +
> +	return 0;
> +}
> +
> +static int qcom_get_related_cpus(int index, struct cpumask *m)
> +{
> +	struct device_node *cpu_np;
> +	struct of_phandle_args args;
> +	int cpu, ret;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_np = of_cpu_device_node_get(cpu);
> +		if (!cpu_np)
> +			continue;
> +		of_node_put(cpu_np);
> +
> +		ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
> +				"#freq-domain-cells", 0, &args);

Hello Taniya,

in your DT binding, you use

#freq-domains-cells = <1>

Yet here you parse for "#freq-domain-cells".

Kind regards,
Niklas

> +		if (ret < 0)
> +			continue;
> +
> +		if (index == args.args[0])
> +			cpumask_set_cpu(cpu, m);
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_cpu_resources_init(struct platform_device *pdev,
> +				   unsigned int cpu, int index,
> +				   unsigned long xo_rate,
> +				   unsigned long cpu_hw_rate)
> +{
> +	struct cpufreq_qcom *c;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	const u16 *offsets;
> +	int ret, i, cpu_r;
> +	void __iomem *base;
> +
> +	if (qcom_freq_domain_map[cpu])
> +		return 0;
> +
> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
> +	if (!c)
> +		return -ENOMEM;
> +
> +	offsets = of_device_get_match_data(&pdev->dev);
> +	if (!offsets)
> +		return -EINVAL;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	for (i = REG_ENABLE; i < REG_ARRAY_SIZE; i++)
> +		c->reg_bases[i] = base + offsets[i];
> +
> +	/* HW should be in enabled state to proceed */
> +	if (!(readl_relaxed(c->reg_bases[REG_ENABLE]) & 0x1)) {
> +		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
> +		return -ENODEV;
> +	}
> +
> +	ret = qcom_get_related_cpus(index, &c->related_cpus);
> +	if (ret) {
> +		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
> +		return ret;
> +	}
> +
> +	c->max_cores = cpumask_weight(&c->related_cpus);
> +	if (!c->max_cores)
> +		return -ENOENT;
> +
> +	c->xo_rate = xo_rate;
> +	c->cpu_hw_rate = cpu_hw_rate;
> +
> +	ret = qcom_cpufreq_hw_read_lut(pdev, c);
> +	if (ret) {
> +		dev_err(dev, "Domain-%d failed to read LUT\n", index);
> +		return ret;
> +	}
> +
> +	for_each_cpu(cpu_r, &c->related_cpus)
> +		qcom_freq_domain_map[cpu_r] = c;
> +
> +	return 0;
> +}
> +
> +static int qcom_resources_init(struct platform_device *pdev)
> +{
> +	struct device_node *cpu_np;
> +	struct of_phandle_args args;
> +	struct clk *clk;
> +	unsigned int cpu;
> +	unsigned long xo_rate, cpu_hw_rate;
> +	int ret;
> +
> +	clk = devm_clk_get(&pdev->dev, "xo");
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	xo_rate = clk_get_rate(clk);
> +
> +	devm_clk_put(&pdev->dev, clk);
> +
> +	clk = devm_clk_get(&pdev->dev, "cpu_clk");
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	cpu_hw_rate = clk_get_rate(clk) / CLK_HW_DIV;
> +
> +	devm_clk_put(&pdev->dev, clk);
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_np = of_cpu_device_node_get(cpu);
> +		if (!cpu_np) {
> +			dev_dbg(&pdev->dev, "Failed to get cpu %d device\n",
> +				cpu);
> +			continue;
> +		}
> +
> +		ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
> +				"#freq-domain-cells", 0, &args);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = qcom_cpu_resources_init(pdev, cpu, args.args[0],
> +					      xo_rate, cpu_hw_rate);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
> +{
> +	int rc;
> +
> +	/* Get the bases of cpufreq for domains */
> +	rc = qcom_resources_init(pdev);
> +	if (rc) {
> +		dev_err(&pdev->dev, "CPUFreq resource init failed\n");
> +		return rc;
> +	}
> +
> +	rc = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
> +	if (rc) {
> +		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
> +		return rc;
> +	}
> +
> +	dev_dbg(&pdev->dev, "QCOM CPUFreq HW driver initialized\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id qcom_cpufreq_hw_match[] = {
> +	{ .compatible = "qcom,cpufreq-hw", .data = &cpufreq_qcom_std_offsets },
> +	{}
> +};
> +
> +static struct platform_driver qcom_cpufreq_hw_driver = {
> +	.probe = qcom_cpufreq_hw_driver_probe,
> +	.driver = {
> +		.name = "qcom-cpufreq-hw",
> +		.of_match_table = qcom_cpufreq_hw_match,
> +	},
> +};
> +
> +static int __init qcom_cpufreq_hw_init(void)
> +{
> +	return platform_driver_register(&qcom_cpufreq_hw_driver);
> +}
> +subsys_initcall(qcom_cpufreq_hw_init);
> +
> +MODULE_DESCRIPTION("QCOM firmware-based CPU Frequency driver");
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.
> 
