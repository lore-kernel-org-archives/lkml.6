Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeEOIY4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:24:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48665 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbeEOIYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:24:53 -0400
Message-ID: <1526372688.3494.13.camel@pengutronix.de>
Subject: Re: [PATCH] cpufreq: add imx8mq-cpufreq driver
From: Lucas Stach <l.stach@pengutronix.de>
To: Anson Huang <Anson.Huang@nxp.com>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org
Cc: Linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Date: Tue, 15 May 2018 10:24:48 +0200
In-Reply-To: <1526363470-19707-1-git-send-email-Anson.Huang@nxp.com>
References: <1526363470-19707-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 15.05.2018, 13:51 +0800 schrieb Anson Huang:
> Add imx8mq-cpufreq driver for NXP i.MX8MQ SoC to support the
> hardware specific frequency and voltage scaling requirements.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Sorry, but NACK.

This just implements a specific reclocking sequence as a cpufreq
driver.

Please use the way chosen for MX5 and MX7 where we have a virtual clock
for the CPU frequency that abstracts all this clock handling away and
allows to use the generic cpufreq-dt driver.

Regards,
Lucas

> ---
>  drivers/cpufreq/Kconfig.arm      |   8 ++
>  drivers/cpufreq/Makefile         |   1 +
>  drivers/cpufreq/imx8mq-cpufreq.c | 234
> +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 243 insertions(+)
>  create mode 100644 drivers/cpufreq/imx8mq-cpufreq.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm
> b/drivers/cpufreq/Kconfig.arm
> index 96b35b8..ea8e2b6 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -105,6 +105,14 @@ config ARM_IMX6Q_CPUFREQ
>  
>  	  If in doubt, say N.
>  
> +config ARM_IMX8MQ_CPUFREQ
> +	tristate "NXP i.MX8MQ cpufreq support"
> +	select PM_OPP
> +	help
> +	  This adds cpufreq driver support for NXP i.MX8MQ SoC.
> +
> +	  If in doubt, say N.
> +
>  config ARM_KIRKWOOD_CPUFREQ
>  	def_bool MACH_KIRKWOOD
>  	help
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 8d24ade..a3bc61c 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_ARCH_DAVINCI)		+=
> davinci-cpufreq.o
>  obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
>  obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
>  obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
> +obj-$(CONFIG_ARM_IMX8MQ_CPUFREQ)	+= imx8mq-cpufreq.o
>  obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
>  obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ)	+= mediatek-cpufreq.o
>  obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
> diff --git a/drivers/cpufreq/imx8mq-cpufreq.c
> b/drivers/cpufreq/imx8mq-cpufreq.c
> new file mode 100644
> index 0000000..2aee6049
> --- /dev/null
> +++ b/drivers/cpufreq/imx8mq-cpufreq.c
> @@ -0,0 +1,234 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018 NXP
> + *
> + * This program is free software; you can redistribute it and/or
> modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/cpu.h>
> +#include <linux/cpufreq.h>
> +#include <linux/cpu_cooling.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pm_opp.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/suspend.h>
> +
> +static struct device *cpu_dev;
> +static bool free_opp;
> +static struct cpufreq_frequency_table *freq_table;
> +static unsigned int transition_latency;
> +static struct thermal_cooling_device *cdev;
> +static struct regulator *arm_reg;
> +static unsigned int max_freq;
> +
> +#define IMX8MQ_CPUFREQ_CLK_NUM		5
> +
> +enum IMX8MQ_CPUFREQ_CLKS {
> +	A53,
> +	A53_SRC,
> +	ARM_PLL,
> +	ARM_PLL_OUT,
> +	SYS1_PLL_800M,
> +};
> +
> +static struct clk_bulk_data clks[] = {
> +	{ .id = "a53" },
> +	{ .id = "a53_src" },
> +	{ .id = "arm_pll" },
> +	{ .id = "arm_pll_out" },
> +	{ .id = "sys1_pll_800m" },
> +};
> +
> +static int imx8mq_set_target(struct cpufreq_policy *policy, unsigned
> int index)
> +{
> +	struct dev_pm_opp *opp;
> +	unsigned long freq_hz, volt;
> +	unsigned int old_freq, new_freq;
> +	int ret;
> +
> +	new_freq = freq_table[index].frequency;
> +	freq_hz = new_freq * 1000;
> +	old_freq = policy->cur;
> +
> +	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_hz);
> +	if (IS_ERR(opp)) {
> +		dev_err(cpu_dev, "failed to find OPP for %ld\n",
> freq_hz);
> +		return PTR_ERR(opp);
> +	}
> +	volt = dev_pm_opp_get_voltage(opp);
> +	dev_pm_opp_put(opp);
> +
> +	dev_dbg(cpu_dev, "%u MHz --> %u MHz\n",
> +		old_freq / 1000, new_freq / 1000);
> +
> +	if (new_freq > old_freq) {
> +		ret = regulator_set_voltage_tol(arm_reg, volt, 0);
> +		if (ret) {
> +			dev_err(cpu_dev, "failed to scale arm_reg
> up: %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	clk_set_parent(clks[A53_SRC].clk, clks[SYS1_PLL_800M].clk);
> +	clk_set_rate(clks[ARM_PLL].clk, new_freq * 1000);
> +	clk_set_parent(clks[A53_SRC].clk, clks[ARM_PLL_OUT].clk);
> +
> +	/* Ensure the arm clock divider is what we expect */
> +	ret = clk_set_rate(clks[A53].clk, new_freq * 1000);
> +	if (ret)
> +		dev_err(cpu_dev, "failed to set clock rate: %d\n",
> ret);
> +
> +	if (new_freq < old_freq) {
> +		ret = regulator_set_voltage_tol(arm_reg, volt, 0);
> +		if (ret) {
> +			dev_err(cpu_dev, "failed to scale arm_reg
> down: %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void imx8mq_cpufreq_ready(struct cpufreq_policy *policy)
> +{
> +	cdev = of_cpufreq_cooling_register(policy);
> +}
> +
> +static int imx8mq_cpufreq_init(struct cpufreq_policy *policy)
> +{
> +	int ret;
> +
> +	policy->clk = clks[A53].clk;
> +	ret = cpufreq_generic_init(policy, freq_table,
> transition_latency);
> +	policy->suspend_freq = max_freq;
> +
> +	return ret;
> +}
> +
> +static struct cpufreq_driver imx8mq_cpufreq_driver = {
> +	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK,
> +	.verify = cpufreq_generic_frequency_table_verify,
> +	.target_index = imx8mq_set_target,
> +	.get = cpufreq_generic_get,
> +	.init = imx8mq_cpufreq_init,
> +	.name = "imx8mq-cpufreq",
> +	.ready = imx8mq_cpufreq_ready,
> +	.attr = cpufreq_generic_attr,
> +	.suspend = cpufreq_generic_suspend,
> +};
> +
> +static int imx8mq_cpufreq_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np;
> +	int ret, num;
> +
> +	cpu_dev = get_cpu_device(0);
> +	if (!cpu_dev) {
> +		pr_err("failed to get cpu0 device\n");
> +		return -ENODEV;
> +	}
> +
> +	np = of_node_get(cpu_dev->of_node);
> +	if (!np) {
> +		dev_err(cpu_dev, "failed to find cpu0 node\n");
> +		return -ENOENT;
> +	}
> +
> +	ret = clk_bulk_get(cpu_dev, IMX8MQ_CPUFREQ_CLK_NUM, clks);
> +	if (ret)
> +		goto put_node;
> +
> +	arm_reg = regulator_get(cpu_dev, "arm");
> +	if (PTR_ERR(arm_reg) == -EPROBE_DEFER) {
> +		ret = -EPROBE_DEFER;
> +		dev_dbg(cpu_dev, "regulator not ready, defer\n");
> +		goto put_reg;
> +	}
> +	if (IS_ERR(arm_reg)) {
> +		dev_err(cpu_dev, "failed to get regulator\n");
> +		ret = -ENOENT;
> +		goto put_reg;
> +	}
> +
> +	/*
> +	 * We expect an OPP table supplied by platform.
> +	 * Just, in case the platform did not supply the OPP
> +	 * table, it will try to get it.
> +	 */
> +	num = dev_pm_opp_get_opp_count(cpu_dev);
> +	if (num < 0) {
> +		ret = dev_pm_opp_of_add_table(cpu_dev);
> +		if (ret < 0) {
> +			dev_err(cpu_dev, "failed to init OPP table:
> %d\n", ret);
> +			goto put_clk;
> +		}
> +	}
> +	free_opp = true;
> +
> +	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
> +	if (ret) {
> +		dev_err(cpu_dev, "failed to init cpufreq table:
> %d\n", ret);
> +		goto out_free_opp;
> +	}
> +	max_freq = freq_table[--num].frequency;
> +
> +	if (of_property_read_u32(np, "clock-latency",
> &transition_latency))
> +		transition_latency = CPUFREQ_ETERNAL;
> +
> +	ret = cpufreq_register_driver(&imx8mq_cpufreq_driver);
> +	if (ret) {
> +		dev_err(cpu_dev, "failed register driver: %d\n",
> ret);
> +		goto free_freq_table;
> +	}
> +
> +	of_node_put(np);
> +	return 0;
> +
> +free_freq_table:
> +	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
> +out_free_opp:
> +	dev_pm_opp_of_remove_table(cpu_dev);
> +put_clk:
> +	clk_bulk_put(IMX8MQ_CPUFREQ_CLK_NUM, clks);
> +put_reg:
> +	if (!IS_ERR(arm_reg))
> +		regulator_put(arm_reg);
> +put_node:
> +	of_node_put(np);
> +	return ret;
> +}
> +
> +static int imx8mq_cpufreq_remove(struct platform_device *pdev)
> +{
> +	cpufreq_cooling_unregister(cdev);
> +	cpufreq_unregister_driver(&imx8mq_cpufreq_driver);
> +	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
> +	if (free_opp)
> +		dev_pm_opp_of_remove_table(cpu_dev);
> +	regulator_put(arm_reg);
> +	clk_bulk_put(IMX8MQ_CPUFREQ_CLK_NUM, clks);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver imx8mq_cpufreq_platdrv = {
> +	.driver = {
> +		.name	= "imx8mq-cpufreq",
> +	},
> +	.probe		= imx8mq_cpufreq_probe,
> +	.remove		= imx8mq_cpufreq_remove,
> +};
> +module_platform_driver(imx8mq_cpufreq_platdrv);
> +
> +MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
> +MODULE_DESCRIPTION("Freescale i.MX8MQ cpufreq driver");
> +MODULE_LICENSE("GPL");
