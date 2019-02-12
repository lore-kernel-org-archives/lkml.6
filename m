Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FEEC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2915F214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfBLMgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:36:51 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34621 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfBLMgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:36:51 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gtXIl-0005fd-MR; Tue, 12 Feb 2019 13:36:39 +0100
Message-ID: <1549974999.2546.28.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] cpufreq: Add i.mx8mq support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>, Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 12 Feb 2019 13:36:39 +0100
In-Reply-To: <1549974071-8284-1-git-send-email-abel.vesa@nxp.com>
References: <1549974071-8284-1-git-send-email-abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

we really don't want another platform specific cpufreq driver in
mainline. The CPU clock change dance should be abstracted in the
imx8mq-clk driver, just like we do on i.MX5 and i.MX7. This would allow
us to reuse the cpufreq-dt driver, like we do on those platforms.

Regards,
Lucas

Am Dienstag, den 12.02.2019, 12:21 +0000 schrieb Abel Vesa:
> > From: Anson Huang <Anson.Huang@nxp.com>
> 
> Add i.MX8MQ cpufreq support, current version of
> EVK board does NOT support voltage scale, but next
> version will add this support, so this driver only
> supports cpu frequency scale, voltage scale will
> be added later once new board available.
> 
> A53 CPU clock normally is from ARM_PLL, but during
> ARM_PLL relock window, it will be switched to
> SYS1_PLL_800M to avoid clock missing, and after
> arm pll relock done, it will be switched back.
> 
> > Signed-off-by: Anson Huang <anson.huang@nxp.com>
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/cpufreq/Kconfig.arm      |   8 ++
>  drivers/cpufreq/Makefile         |   1 +
>  drivers/cpufreq/imx8mq-cpufreq.c | 223 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 232 insertions(+)
>  create mode 100644 drivers/cpufreq/imx8mq-cpufreq.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 179a1d3..9d8001c 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -92,6 +92,14 @@ config ARM_IMX6Q_CPUFREQ
>  
> >  	  If in doubt, say N.
>  
> +config ARM_IMX8MQ_CPUFREQ
> > +	tristate "NXP i.MX8MQ cpufreq support"
> > +	select PM_OPP
> > +	help
> > +	  This adds cpufreq driver support for NXP i.MX8MQ series SoCs.
> +
> > +	  If in doubt, say N.
> +
>  config ARM_KIRKWOOD_CPUFREQ
> >  	def_bool MACH_KIRKWOOD
> >  	help
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 689b26c..fe5416c 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> > @@ -56,6 +56,7 @@ obj-$(CONFIG_ACPI_CPPC_CPUFREQ)		+= cppc_cpufreq.o
> >  obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
> >  obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
> >  obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
> > +obj-$(CONFIG_ARM_IMX8MQ_CPUFREQ)	+= imx8mq-cpufreq.o
> >  obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
> >  obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ)	+= mediatek-cpufreq.o
> >  obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
> diff --git a/drivers/cpufreq/imx8mq-cpufreq.c b/drivers/cpufreq/imx8mq-cpufreq.c
> new file mode 100644
> index 0000000..ee24fab
> --- /dev/null
> +++ b/drivers/cpufreq/imx8mq-cpufreq.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 NXP
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/cpu.h>
> +#include <linux/cpufreq.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/pm_opp.h>
> +#include <linux/platform_device.h>
> +#include <linux/suspend.h>
> +
> +static struct device *cpu_dev;
> +static bool free_opp;
> +static struct cpufreq_frequency_table *freq_table;
> +static struct mutex set_cpufreq_lock;
> +static unsigned int transition_latency;
> +static unsigned int suspend_freq;
> +static struct clk *a53_clk;
> +static struct clk *arm_a53_src_clk;
> +static struct clk *arm_pll_clk;
> +static struct clk *arm_pll_out_clk;
> +static struct clk *sys1_pll_800m_clk;
> +
> +static int imx8mq_set_target(struct cpufreq_policy *policy, unsigned int index)
> +{
> > +	struct dev_pm_opp *opp;
> > +	unsigned long freq_hz;
> > +	unsigned int old_freq, new_freq;
> > +	int ret;
> +
> > +	mutex_lock(&set_cpufreq_lock);
> +
> > +	new_freq = freq_table[index].frequency;
> > +	freq_hz = new_freq * 1000;
> > +	old_freq = policy->cur;
> +
> > +	rcu_read_lock();
> > +	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_hz);
> > +	if (IS_ERR(opp)) {
> > +		rcu_read_unlock();
> > +		dev_err(cpu_dev, "failed to find OPP for %ld\n", freq_hz);
> > +		mutex_unlock(&set_cpufreq_lock);
> > +		return PTR_ERR(opp);
> > +	}
> > +	rcu_read_unlock();
> +
> > +	dev_dbg(cpu_dev, "%u MHz --> %u MHz\n",
> > +		old_freq / 1000, new_freq / 1000);
> +
> > +	clk_set_parent(arm_a53_src_clk, sys1_pll_800m_clk);
> > +	clk_set_rate(arm_pll_clk, new_freq * 1000);
> > +	clk_set_parent(arm_a53_src_clk, arm_pll_out_clk);
> +
> > +	/* Ensure the arm clock divider is what we expect */
> > +	ret = clk_set_rate(a53_clk, new_freq * 1000);
> > +	if (ret)
> > +		dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
> +
> > +	mutex_unlock(&set_cpufreq_lock);
> > +	return ret;
> +}
> +
> +static int imx8mq_cpufreq_init(struct cpufreq_policy *policy)
> +{
> > +	int ret;
> +
> > +	policy->clk = a53_clk;
> > +	policy->cur = clk_get_rate(a53_clk) / 1000;
> > +	policy->suspend_freq = suspend_freq;
> +
> > +	ret = cpufreq_generic_init(policy, freq_table, transition_latency);
> > +	if (ret) {
> > +		dev_err(cpu_dev, "imx8mq cpufreq init failed!\n");
> > +		return ret;
> > +	}
> +
> > +	return 0;
> +}
> +
> +static struct cpufreq_driver imx8mq_cpufreq_driver = {
> > +	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK,
> > +	.verify = cpufreq_generic_frequency_table_verify,
> > +	.target_index = imx8mq_set_target,
> > +	.get = cpufreq_generic_get,
> > +	.init = imx8mq_cpufreq_init,
> > +	.name = "imx8mq-cpufreq",
> > +	.attr = cpufreq_generic_attr,
> +#ifdef CONFIG_PM
> > +	.suspend = cpufreq_generic_suspend,
> +#endif
> +};
> +
> +static int imx8mq_cpufreq_probe(struct platform_device *pdev)
> +{
> > +	struct device_node *np;
> > +	int num, ret;
> +
> > +	cpu_dev = get_cpu_device(0);
> > +	if (!cpu_dev) {
> > +		pr_err("failed to get cpu0 device\n");
> > +		return -ENODEV;
> > +	}
> +
> > +	np = of_node_get(cpu_dev->of_node);
> > +	if (!np) {
> > +		dev_err(cpu_dev, "failed to find cpu0 node\n");
> > +		return -ENOENT;
> > +	}
> +
> > +	a53_clk = clk_get(cpu_dev, "a53");
> > +	arm_a53_src_clk = clk_get(cpu_dev, "arm_a53_src");
> > +	arm_pll_clk = clk_get(cpu_dev, "arm_pll");
> > +	arm_pll_out_clk = clk_get(cpu_dev, "arm_pll_out");
> > +	sys1_pll_800m_clk = clk_get(cpu_dev, "sys1_pll_800m");
> > +	if (IS_ERR(a53_clk) || IS_ERR(arm_a53_src_clk)
> > +		|| IS_ERR(arm_pll_out_clk) || IS_ERR(arm_pll_clk)
> > +		|| IS_ERR(sys1_pll_800m_clk)) {
> > +		dev_err(cpu_dev, "failed to get clocks\n");
> > +		ret = -ENOENT;
> > +		goto put_clk;
> > +	}
> +
> > +	/*
> > +	 * We expect an OPP table supplied by platform.
> > +	 * Just, incase the platform did not supply the OPP
> > +	 * table, it will try to get it.
> > +	 */
> > +	num = dev_pm_opp_get_opp_count(cpu_dev);
> > +	if (num < 0) {
> > +		ret = dev_pm_opp_of_add_table(cpu_dev);
> > +		if (ret < 0) {
> > +			dev_err(cpu_dev, "failed to init OPP table: %d\n", ret);
> > +			goto put_clk;
> > +		}
> +
> > +		/* Because we have added the OPPs here, we must free them */
> > +		free_opp = true;
> +
> > +		num = dev_pm_opp_get_opp_count(cpu_dev);
> > +		if (num < 0) {
> > +			ret = num;
> > +			dev_err(cpu_dev, "no OPP table is found: %d\n", ret);
> > +			goto out_free_opp;
> > +		}
> > +	}
> +
> > +	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
> > +	if (ret) {
> > +		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
> > +		goto out_free_opp;
> > +	}
> +
> > +	/* use MAX freq to suspend */
> > +	suspend_freq = freq_table[num - 1].frequency;
> +
> > +	if (of_property_read_u32(np, "clock-latency", &transition_latency))
> > +		transition_latency = CPUFREQ_ETERNAL;
> +
> > +	mutex_init(&set_cpufreq_lock);
> +
> > +	ret = cpufreq_register_driver(&imx8mq_cpufreq_driver);
> > +	if (ret) {
> > +		dev_err(cpu_dev, "failed register driver: %d\n", ret);
> > +		goto free_freq_table;
> > +	}
> +
> > +	of_node_put(np);
> > +	dev_info(cpu_dev, "registered imx8mq-cpufreq\n");
> +
> > +	return 0;
> +
> +free_freq_table:
> > +	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
> +out_free_opp:
> > +	if (free_opp)
> > +		dev_pm_opp_of_remove_table(cpu_dev);
> +put_clk:
> > +	if (!IS_ERR(a53_clk))
> > +		clk_put(a53_clk);
> > +	if (!IS_ERR(arm_a53_src_clk))
> > +		clk_put(arm_a53_src_clk);
> > +	if (!IS_ERR(arm_pll_clk))
> > +		clk_put(arm_pll_clk);
> > +	if (!IS_ERR(arm_pll_out_clk))
> > +		clk_put(arm_pll_out_clk);
> > +	if (!IS_ERR(sys1_pll_800m_clk))
> > +		clk_put(sys1_pll_800m_clk);
> > +	of_node_put(np);
> > +	return ret;
> +}
> +
> +static int imx8mq_cpufreq_remove(struct platform_device *pdev)
> +{
> > +	cpufreq_unregister_driver(&imx8mq_cpufreq_driver);
> > +	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
> > +	if (free_opp)
> > +		dev_pm_opp_of_remove_table(cpu_dev);
> > +	clk_put(a53_clk);
> > +	clk_put(arm_a53_src_clk);
> > +	clk_put(arm_pll_clk);
> > +	clk_put(arm_pll_out_clk);
> > +	clk_put(sys1_pll_800m_clk);
> +
> > +	return 0;
> +}
> +
> +static struct platform_driver imx8mq_cpufreq_platdrv = {
> > +	.driver = {
> > > +		.name	= "imx8mq-cpufreq",
> > +	},
> > > +	.probe		= imx8mq_cpufreq_probe,
> > > +	.remove		= imx8mq_cpufreq_remove,
> +};
> +module_platform_driver(imx8mq_cpufreq_platdrv);
> +
> > +MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
> +MODULE_DESCRIPTION("Freescale i.MX8MQ cpufreq driver");
> +MODULE_LICENSE("GPL");
