Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pwk0dB1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 996436070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeFFGB0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:01:26 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41280 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeFFGBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:01:23 -0400
X-Google-Smtp-Source: ADUXVKImygnP9D9LvFHCkaZdmzJJ/kvXVGLlbcTIh9BjD6MfOlas5lgx6wn7w/zpzsNQ1hnSbyvIGg==
Date: Wed, 6 Jun 2018 11:31:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Taniya Das <tdas@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, robh@kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, skannan@codeaurora.org
Subject: Re: [PATCH 2/2] cpufreq: qcom-fw: Add support for QCOM cpufreq FW
 driver
Message-ID: <20180606060119.yzl24vhqff6btvrk@vireshk-i7>
References: <1528109194-16864-1-git-send-email-tdas@codeaurora.org>
 <1528109194-16864-3-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528109194-16864-3-git-send-email-tdas@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-06-18, 16:16, Taniya Das wrote:
> The CPUfreq FW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this firmware.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm       |   9 ++
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/qcom-cpufreq-fw.c | 316 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 326 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-fw.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index c7ce928..82c391e 100644
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
> index 0000000..2135a08
> --- /dev/null
> +++ b/drivers/cpufreq/qcom-cpufreq-fw.c
> @@ -0,0 +1,316 @@
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
> +};
> +
> +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
> +
> +static int
> +qcom_cpufreq_fw_target_index(struct cpufreq_policy *policy,
> +			     unsigned int index)
> +{
> +	struct cpufreq_qcom *c = policy->driver_data;
> +
> +	writel_relaxed(index, c->perf_base);
> +
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
> +		return 0;
> +
> +	index = readl_relaxed(c->perf_base);
> +	index = min(index, LUT_MAX_ENTRIES - 1);
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
> +
> +	policy->freq_table = c->table;
> +	policy->driver_data = c;

What about fast cpufreq switching ? I think you can enable that option as well
here..

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

What about CPU hotplug ? We can still do that, right ? So what will happen if
all CPUs of a freq-domain are removed (hence cpufreq policy is removed) and then
someone calls qcom_cpufreq_fw_get() ? You should really work on cpufreq_policy
there to get 'c'.

> +	.name		= "qcom-cpufreq-fw",
> +	.attr		= qcom_cpufreq_fw_attr,
> +	.boost_enabled	= true,
> +};
> +
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

Looks like there are many problems here.
- You are assigning prev_freq with cur_freq (which may be uninitialized local
  variable here).
- In this version, you never write CPUFREQ_ENTRY_INVALID to table[i].frequency,
  which looks wrong as well.

> +
> +static int qcom_get_related_cpus(struct device_node *np, struct cpumask *m)
> +{
> +	struct device_node  *cpu_dev;

s/cpu_dev/cpu_np/

> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_dev = of_cpu_device_node_get(cpu);
> +		if (!cpu_dev)
> +			continue;
> +		cpu_dev = of_parse_phandle(cpu_dev, "qcom,freq-domain", 0);

What's returned here is a pointer to the qcom,freq-domain node, and you assign
that to a variable named cpu_dev. Either use two variables for different node
types, or rename it to temp_np or something similar.

> +		if (!cpu_dev)
> +			continue;
> +		if (cpu_dev == np)
> +			cpumask_set_cpu(cpu, m);
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
> +
> +	ret = qcom_get_related_cpus(np, &c->related_cpus);
> +	if (ret) {
> +		dev_err(dev, "%s failed to get core phandles\n", np->name);

Maybe write a more relevant error message here ?

> +		return ret;
> +	}
> +
> +	c->max_cores = cpumask_weight(&c->related_cpus);

Maybe remove the error checking conditional from qcom_get_related_cpus() and
check !c->max_cores here for the same.

> +
> +	ret = qcom_read_lut(pdev, c);
> +	if (ret) {
> +		dev_err(dev, "%s failed to read LUT\n", np->name);
> +		return ret;
> +	}

Enter a blank line here.

> +	for_each_cpu(cpu, &c->related_cpus)
> +		qcom_freq_domain_map[cpu] = c;

This whole setup looks a bit confusing to me. This is what you are doing
essentially:

qcom_resources_init()
{
        for_each_possible_cpu() {
                qcom_cpu_resources_init()
                {
                        populate c->related_cpus;

                        for_each_related_cpu() {
                                qcom_freq_domain_map[cpu] = c;
                        }
                }
        }
}

So if there are 4 CPUs that share a freq domain, then you are allocating 'c' 4
times and (over)writing qcom_freq_domain_map[] for all these CPUs 4 times and
finally keeping value of 'c' only once.

You must be running most of the work done in qcom_resources_init() only once per
freq-domain.

> +
> +	return 0;
> +}
> +
> +static int qcom_resources_init(struct platform_device *pdev)
> +{
> +	struct device_node *np, *cpu_dev;

cpu_dev is normally used in kernel for struct device *, maybe use cpu_np ?

> +	unsigned int cpu;
> +	int ret;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_dev = of_cpu_device_node_get(cpu);
> +		if (!cpu_dev) {
> +			dev_err(&pdev->dev, "Failed to get cpu %d device\n",
> +				cpu);
> +			continue;
> +		}
> +
> +		np = of_parse_phandle(cpu_dev, "qcom,freq-domain", 0);
> +		if (!np) {
> +			dev_err(&pdev->dev, "Failed to get freq-domain device\n");
> +			continue;

I am not sure if we should continue or error out here. Why would you want only a
group of CPUs to have this property set ? Or if you really have a case for that
currently ?

> +		}
> +
> +		of_node_put(cpu_dev);
> +
> +		ret = qcom_cpu_resources_init(pdev, np);
> +		if (ret)
> +			return ret;
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

s/inited/initialized/ ?

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
