Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeEUJBV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:01:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46208 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbeEUJBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:01:18 -0400
X-Google-Smtp-Source: AB8JxZpUhzV4jt6RbMmc29E5f0eWbLhzH9KSd5hlrLpldQPwI6FQZPhUuBYZpQbNLUOmgQxfRy51hA==
Date: Mon, 21 May 2018 14:31:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Taniya Das <tdas@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        robh@kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org,
        skannan@codeaurora.org, amit.kucheria@linaro.org
Subject: Re: [PATCH v2 2/2] cpufreq: qcom-fw: Add support for QCOM cpufreq FW
 driver
Message-ID: <20180521090113.qo2lrafjrh2xi6va@vireshk-i7>
References: <1526751291-17873-1-git-send-email-tdas@codeaurora.org>
 <1526751291-17873-3-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526751291-17873-3-git-send-email-tdas@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-05-18, 23:04, Taniya Das wrote:
> The CPUfreq FW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this firmware.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm       |   9 ++
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/qcom-cpufreq-fw.c | 317 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 327 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-fw.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 96b35b8..571f6b4 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -301,3 +301,12 @@ config ARM_PXA2xx_CPUFREQ
>  	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
> 
>  	  If in doubt, say N.
> +
> +config ARM_QCOM_CPUFREQ_FW
> +	bool "QCOM CPUFreq FW driver"

During last review I didn't say that this driver shouldn't be a
module, but that you need to fix things to make it a module. I am fine
though if you don't want this to be a module ever.

> +	help
> +	 Support for the CPUFreq FW driver.
> +	 The CPUfreq FW preset in some QCOM chipsets offloads the steps
> +	 necessary for changing the frequency of CPUs. The driver
> +	 implements the cpufreq driver interface for this firmware.
> +	 Say Y if you want to support CPUFreq FW.
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 8d24ade..a3edbce 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -85,6 +85,7 @@ obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
>  obj-$(CONFIG_ARM_TI_CPUFREQ)		+= ti-cpufreq.o
>  obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
> +obj-$(CONFIG_ARM_QCOM_CPUFREQ_FW)	+= qcom-cpufreq-fw.o
> 
> 
>  ##################################################################################
> diff --git a/drivers/cpufreq/qcom-cpufreq-fw.c b/drivers/cpufreq/qcom-cpufreq-fw.c
> new file mode 100644
> index 0000000..0e66de0
> --- /dev/null
> +++ b/drivers/cpufreq/qcom-cpufreq-fw.c
> @@ -0,0 +1,317 @@
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
> +#define CORE_COUNT_VAL(val)		((val & GENMASK(18, 16)) >> 16)
> +#define LUT_ROW_SIZE			32
> +
> +struct cpufreq_qcom {
> +	struct cpufreq_frequency_table *table;
> +	struct device *dev;
> +	void __iomem *perf_base;
> +	void __iomem *lut_base;
> +	cpumask_t related_cpus;
> +	unsigned int max_cores;
> +};
> +
> +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
> +
> +static int
> +qcom_cpufreq_fw_target_index(struct cpufreq_policy *policy, unsigned int index)
> +{
> +	struct cpufreq_qcom *c = policy->driver_data;
> +
> +	if (index >= LUT_MAX_ENTRIES) {
> +		dev_err(c->dev,
> +			"Passing an index (%u) that's greater than max (%d)\n",
> +					index, LUT_MAX_ENTRIES - 1);
> +		return -EINVAL;
> +	}

This is never going to happen unless there is a bug in cpufreq core.
You are allocating only 40 entries for the cpufreq table and this will
always be 0-39. None of the other drivers is checking this I believe
and neither should you. This is the only routine which will get call
very frequently and we better not add unnecessary stuff here.

> +	writel_relaxed(index, c->perf_base);
> +
> +	/* Make sure the write goes through before proceeding */
> +	mb();

Btw what happens right after this is done ? Are we guaranteed that the
frequency is updated in the hardware after this ? What about enabling
fast-switch for your platform ? Look at drivers/cpufreq/scmi-cpufreq.c
to see how that is done.

> +	return 0;
> +}
> +
> +static unsigned int qcom_cpufreq_fw_get(unsigned int cpu)
> +{
> +	struct cpufreq_qcom *c;
> +	unsigned int index;
> +
> +	c = qcom_freq_domain_map[cpu];
> +	if (!c)
> +		return -ENODEV;

Return 0 on error here.

> +
> +	index = readl_relaxed(c->perf_base);
> +	index = min(index, LUT_MAX_ENTRIES - 1);

Will the hardware ever read a value over 39 here ?

> +
> +	return c->table[index].frequency;
> +}
> +
> +static int qcom_cpufreq_fw_cpu_init(struct cpufreq_policy *policy)
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
> +	policy->freq_table = c->table;
> +	policy->driver_data = c;
> +
> +	return 0;
> +}
> +
> +static struct freq_attr *qcom_cpufreq_fw_attr[] = {
> +	&cpufreq_freq_attr_scaling_available_freqs,
> +	&cpufreq_freq_attr_scaling_boost_freqs,
> +	NULL
> +};
> +
> +static struct cpufreq_driver cpufreq_qcom_fw_driver = {
> +	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> +			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
> +	.verify		= cpufreq_generic_frequency_table_verify,
> +	.target_index	= qcom_cpufreq_fw_target_index,
> +	.get		= qcom_cpufreq_fw_get,
> +	.init		= qcom_cpufreq_fw_cpu_init,
> +	.name		= "qcom-cpufreq-fw",
> +	.attr		= qcom_cpufreq_fw_attr,
> +	.boost_enabled	= true,
> +};
> +
> +static int qcom_read_lut(struct platform_device *pdev,
> +			 struct cpufreq_qcom *c)
> +{
> +	struct device *dev = &pdev->dev;
> +	u32 data, src, lval, i, core_count, prev_cc;
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
> +
> +		c->table[i].driver_data = c->table[i].frequency;

Why do you need to use driver_data here? Why can't you simple use
frequency field in the below conditional expressions ?

> +
> +		dev_dbg(dev, "index=%d freq=%d, core_count %d\n",
> +			i, c->table[i].frequency, core_count);
> +
> +		if (core_count != c->max_cores)
> +			c->table[i].frequency = CPUFREQ_ENTRY_INVALID;
> +
> +		/*
> +		 * Two of the same frequencies with the same core counts means
> +		 * end of table.
> +		 */
> +		if (i > 0 && c->table[i - 1].driver_data ==
> +			c->table[i].driver_data && prev_cc == core_count) {
> +			struct cpufreq_frequency_table *prev = &c->table[i - 1];
> +
> +			if (prev->frequency == CPUFREQ_ENTRY_INVALID) {

There can only be a single boost frequency at max ?

> +				prev->flags = CPUFREQ_BOOST_FREQ;
> +				prev->frequency = prev->driver_data;

Okay you are using driver_data as a local variable to keep this value
safe which you might have overwritten. Maybe use a simple variable
prev_freq for this. It would be much more readable in that case and
you wouldn't end up abusing the driver_data field.

> +			}
> +
> +			break;
> +		}
> +		prev_cc = core_count;
> +	}
> +	c->table[i].frequency = CPUFREQ_TABLE_END;

Wouldn't you end up writing on c->table[40].frequency here if there
are 40 frequency value present ?

> +
> +	return 0;
> +}
> +
> +static int qcom_get_related_cpus(struct device_node *np, struct cpumask *m)
> +{
> +	struct device_node *dev_phandle;
> +	struct device *cpu_dev;
> +	int cpu, i = 0;
> +
> +	dev_phandle = of_parse_phandle(np, "qcom,cpulist", i++);
> +	while (dev_phandle) {
> +		for_each_possible_cpu(cpu) {
> +			cpu_dev = get_cpu_device(cpu);
> +			if (cpu_dev && cpu_dev->of_node == dev_phandle) {

You can use of_cpu_device_node_get() here.

> +				cpumask_set_cpu(cpu, m);
> +				break;
> +			}
> +		}
> +		dev_phandle = of_parse_phandle(np, "qcom,cpulist", i++);
> +	}
> +
> +	if (cpumask_empty(m))
> +		return -ENOENT;
> +
> +	return 0;
> +}
> +
> +static int qcom_cpu_resources_init(struct platform_device *pdev,
> +				   struct device_node *np)
> +{
> +	struct cpufreq_qcom *c;
> +	struct resource res;
> +	struct device *dev = &pdev->dev;
> +	void __iomem *en_base;
> +	int cpu, index, ret;
> +
> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
> +	if (!c)
> +		return -ENOMEM;
> +
> +	index = of_property_match_string(np, "reg-names", "en_base");
> +	if (index < 0)
> +		return index;
> +
> +	if (of_address_to_resource(np, index, &res))
> +		return -ENOMEM;
> +
> +	en_base = devm_ioremap(dev, res.start, resource_size(&res));
> +	if (!en_base) {
> +		dev_err(dev, "Unable to map %s en-base\n", np->name);
> +		return -ENOMEM;
> +	}
> +
> +	/* FW should be in enabled state to proceed */
> +	if (!(readl_relaxed(en_base) & 0x1)) {
> +		dev_err(dev, "%s firmware not enabled\n", np->name);
> +		return -ENODEV;
> +	}
> +
> +	devm_iounmap(&pdev->dev, en_base);
> +
> +	index = of_property_match_string(np, "reg-names", "perf_base");
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
> +	index = of_property_match_string(np, "reg-names", "lut_base");
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
> +
> +	ret = qcom_get_related_cpus(np, &c->related_cpus);
> +	if (ret) {
> +		dev_err(dev, "%s failed to get core phandles\n", np->name);
> +		return ret;
> +	}
> +
> +	c->max_cores = cpumask_weight(&c->related_cpus);
> +
> +	ret = qcom_read_lut(pdev, c);
> +	if (ret) {
> +		dev_err(dev, "%s failed to read LUT\n", np->name);
> +		return ret;
> +	}
> +
> +	for_each_cpu(cpu, &c->related_cpus)
> +		qcom_freq_domain_map[cpu] = c;
> +
> +	return 0;
> +}
> +
> +static int qcom_resources_init(struct platform_device *pdev)
> +{
> +	struct device_node *np;
> +	int ret;
> +
> +	if (!of_get_available_child_count(pdev->dev.of_node))
> +		return -ENODEV;
> +
> +	for_each_available_child_of_node(pdev->dev.of_node, np) {
> +		if (of_device_is_compatible(np, "cpufreq")) {
> +			ret = qcom_cpu_resources_init(pdev, np);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_cpufreq_fw_driver_probe(struct platform_device *pdev)
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
> +	rc = cpufreq_register_driver(&cpufreq_qcom_fw_driver);
> +	if (rc) {
> +		dev_err(&pdev->dev, "CPUFreq FW driver failed to register\n");
> +		return rc;
> +	}
> +
> +	dev_info(&pdev->dev, "QCOM CPUFreq FW driver inited\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id match_table[] = {
> +	{ .compatible = "qcom,cpufreq-fw" },
> +	{}
> +};
> +
> +static struct platform_driver qcom_cpufreq_fw_driver = {
> +	.probe = qcom_cpufreq_fw_driver_probe,
> +	.driver = {
> +		.name = "qcom-cpufreq-fw",
> +		.of_match_table = match_table,
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> +static int __init qcom_cpufreq_fw_init(void)
> +{
> +	return platform_driver_register(&qcom_cpufreq_fw_driver);
> +}
> +subsys_initcall(qcom_cpufreq_fw_init);
> +
> +MODULE_DESCRIPTION("QCOM CPU Frequency FW");
> +MODULE_LICENSE("GPL v2");
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.

-- 
viresh
