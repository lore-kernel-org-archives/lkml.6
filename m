Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DFEC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A812184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfA2QJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:09:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54579 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfA2QJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:09:58 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1goVxP-0007zQ-SO; Tue, 29 Jan 2019 17:09:51 +0100
Message-ID: <1548778191.6869.7.camel@pengutronix.de>
Subject: Re: [PATCH] soc: imx: Add psci gpc support for i.MX8MQ
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Rob Herring <robh@kernel.org>, Jacky Bai <ping.bai@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>
Date:   Tue, 29 Jan 2019 17:09:51 +0100
In-Reply-To: <1548768630-2416-1-git-send-email-abel.vesa@nxp.com>
References: <1548768630-2416-1-git-send-email-abel.vesa@nxp.com>
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

Am Dienstag, den 29.01.2019, 13:30 +0000 schrieb Abel Vesa:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Add i.MX8MQ PSCI GPC virtual driver support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

NACK, we already have a working driver for the power domains on
i.MX8MQ, reusing the existing GPCv2 driver. This has been done in
coordination with Anson Huang. There is no need to involve PSCI in any
of this.

Regards,
Lucas

> ---
>  drivers/soc/imx/Makefile   |   1 +
>  drivers/soc/imx/gpc-psci.c | 423
> +++++++++++++++++++++++++++++++++++++++++++++
>  include/soc/imx/fsl_sip.h  |  31 ++++
>  3 files changed, 455 insertions(+)
>  create mode 100644 drivers/soc/imx/gpc-psci.c
>  create mode 100644 include/soc/imx/fsl_sip.h
> 
> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> index 506a6f3..83a38ac 100644
> --- a/drivers/soc/imx/Makefile
> +++ b/drivers/soc/imx/Makefile
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
>  obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
> +obj-$(CONFIG_ARCH_MXC) += gpc-psci.o
> diff --git a/drivers/soc/imx/gpc-psci.c b/drivers/soc/imx/gpc-psci.c
> new file mode 100644
> index 0000000..4f8fee9
> --- /dev/null
> +++ b/drivers/soc/imx/gpc-psci.c
> @@ -0,0 +1,423 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019 NXP.
> + *
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/clk.h>
> +#include <linux/cpumask.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/arm-gic.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/pm_domain.h>
> +#include <soc/imx/fsl_sip.h>
> +
> +#define GPC_MAX_IRQS		(4 * 32)
> +
> +struct imx_gpc_pm_domain {
> +	const char name[30];
> +	struct device *dev;
> +	struct generic_pm_domain pd;
> +	u32 gpc_domain_id;
> +	struct clk **clks;
> +	unsigned int num_clks;
> +	struct regulator *reg;
> +};
> +
> +enum imx_gpc_pm_domain_state {
> +	GPC_PD_STATE_OFF,
> +	GPC_PD_STATE_ON,
> +};
> +
> +#define to_imx_gpc_pm_domain(_genpd) \
> +	container_of(_genpd, struct imx_gpc_pm_domain, pd)
> +
> +static DEFINE_SPINLOCK(gpc_psci_lock);
> +static DEFINE_MUTEX(gpc_pd_mutex);
> +
> +static void imx_gpc_psci_irq_unmask(struct irq_data *d)
> +{
> +	struct arm_smccc_res res;
> +
> +	spin_lock(&gpc_psci_lock);
> +	arm_smccc_smc(FSL_SIP_GPC, FSL_SIP_CONFIG_GPC_UNMASK, d-
> >hwirq,
> +		      0, 0, 0, 0, 0, &res);
> +	spin_unlock(&gpc_psci_lock);
> +
> +	irq_chip_unmask_parent(d);
> +}
> +
> +static void imx_gpc_psci_irq_mask(struct irq_data *d)
> +{
> +	struct arm_smccc_res res;
> +
> +	spin_lock(&gpc_psci_lock);
> +	arm_smccc_smc(FSL_SIP_GPC, FSL_SIP_CONFIG_GPC_MASK, d-
> >hwirq,
> +		      0, 0, 0, 0, 0, &res);
> +	spin_unlock(&gpc_psci_lock);
> +
> +	irq_chip_mask_parent(d);
> +}
> +static int imx_gpc_psci_irq_set_wake(struct irq_data *d, unsigned
> int on)
> +{
> +	struct arm_smccc_res res;
> +
> +	spin_lock(&gpc_psci_lock);
> +	arm_smccc_smc(FSL_SIP_GPC, FSL_SIP_CONFIG_GPC_SET_WAKE, d-
> >hwirq,
> +			on, 0, 0, 0, 0, &res);
> +	spin_unlock(&gpc_psci_lock);
> +
> +	return 0;
> +}
> +
> +static int imx_gpc_psci_irq_set_affinity(struct irq_data *d,
> +					 const struct cpumask *dest,
> +					 bool force)
> +{
> +	/* parse the cpu of irq affinity */
> +	struct arm_smccc_res res;
> +	int cpu = cpumask_any_and(dest, cpu_online_mask);
> +
> +	irq_chip_set_affinity_parent(d, dest, force);
> +
> +	spin_lock(&gpc_psci_lock);
> +	arm_smccc_smc(FSL_SIP_GPC, 0x4, d->hwirq,
> +		      cpu, 0, 0, 0, 0, &res);
> +	spin_unlock(&gpc_psci_lock);
> +
> +	return 0;
> +}
> +
> +static struct irq_chip imx_gpc_psci_chip = {
> +	.name			= "GPC-PSCI",
> +	.irq_eoi		= irq_chip_eoi_parent,
> +	.irq_mask		= imx_gpc_psci_irq_mask,
> +	.irq_unmask		= imx_gpc_psci_irq_unmask,
> +	.irq_retrigger		=
> irq_chip_retrigger_hierarchy,
> +	.irq_set_wake		= imx_gpc_psci_irq_set_wake,
> +	.irq_set_affinity	= imx_gpc_psci_irq_set_affinity,
> +};
> +
> +static int imx_gpc_psci_domain_translate(struct irq_domain *d,
> +				    struct irq_fwspec *fwspec,
> +				    unsigned long *hwirq,
> +				    unsigned int *type)
> +{
> +	if (is_of_node(fwspec->fwnode)) {
> +		if (fwspec->param_count != 3)
> +			return -EINVAL;
> +
> +		/* No PPI should point to this domain */
> +		if (fwspec->param[0] != 0)
> +			return -EINVAL;
> +
> +		*hwirq = fwspec->param[1];
> +		*type = fwspec->param[2];
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int imx_gpc_psci_domain_alloc(struct irq_domain *domain,
> +				  unsigned int irq,
> +				  unsigned int nr_irqs, void *data)
> +{
> +	struct irq_fwspec *fwspec = data;
> +	struct irq_fwspec parent_fwspec;
> +	irq_hw_number_t hwirq;
> +	int i;
> +
> +	if (fwspec->param_count != 3)
> +		return -EINVAL;	/* Not GIC compliant */
> +	if (fwspec->param[0] != 0)
> +		return -EINVAL;	/* No PPI should point to
> this domain */
> +
> +	hwirq = fwspec->param[1];
> +	if (hwirq >= GPC_MAX_IRQS)
> +		return -EINVAL;	/* Can't deal with this */
> +
> +	for (i = 0; i < nr_irqs; i++)
> +		irq_domain_set_hwirq_and_chip(domain, irq + i, hwirq
> + i,
> +					      &imx_gpc_psci_chip,
> NULL);
> +
> +	parent_fwspec = *fwspec;
> +	parent_fwspec.fwnode = domain->parent->fwnode;
> +
> +	return irq_domain_alloc_irqs_parent(domain, irq, nr_irqs,
> +					    &parent_fwspec);
> +}
> +
> +static const struct irq_domain_ops imx_gpc_psci_domain_ops = {
> +	.translate = imx_gpc_psci_domain_translate,
> +	.alloc	= imx_gpc_psci_domain_alloc,
> +	.free	= irq_domain_free_irqs_common,
> +};
> +
> +static int __init imx_gpc_psci_init(struct device_node *node,
> +			       struct device_node *parent)
> +{
> +	struct irq_domain *parent_domain, *domain;
> +
> +	if (!parent) {
> +		pr_err("%s: no parent, giving up\n", node-
> >full_name);
> +		return -ENODEV;
> +	}
> +
> +	parent_domain = irq_find_host(parent);
> +	if (!parent_domain) {
> +		pr_err("%s: unable to obtain parent domain\n",
> +			node->full_name);
> +		return -ENXIO;
> +	}
> +
> +	domain = irq_domain_add_hierarchy(parent_domain, 0,
> GPC_MAX_IRQS,
> +					  node,
> &imx_gpc_psci_domain_ops,
> +					  NULL);
> +	if (!domain)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +IRQCHIP_DECLARE(imx_gpc_psci, "fsl,imx8mq-gpc", imx_gpc_psci_init);
> +
> +static int imx_gpc_pd_power_on(struct generic_pm_domain *domain)
> +{
> +	struct imx_gpc_pm_domain *pd = to_imx_gpc_pm_domain(domain);
> +	struct arm_smccc_res res;
> +	int index, ret = 0;
> +
> +	/* power on the external supply */
> +	if (pd->reg) {
> +		ret = regulator_enable(pd->reg);
> +		if (ret) {
> +			dev_warn(pd->dev, "failed to power up the
> reg%d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	/* enable the necessary clks needed by the power domain */
> +	if (pd->num_clks) {
> +		for (index = 0; index < pd->num_clks; index++)
> +			clk_prepare_enable(pd->clks[index]);
> +	}
> +
> +	mutex_lock(&gpc_pd_mutex);
> +	arm_smccc_smc(FSL_SIP_GPC, FSL_SIP_CONFIG_GPC_PM_DOMAIN,
> +			pd->gpc_domain_id,
> +			GPC_PD_STATE_ON, 0, 0, 0, 0, &res);
> +	mutex_unlock(&gpc_pd_mutex);
> +
> +	return 0;
> +}
> +
> +static int imx_gpc_pd_power_off(struct generic_pm_domain *domain)
> +{
> +	struct imx_gpc_pm_domain *pd = to_imx_gpc_pm_domain(domain);
> +	struct arm_smccc_res res;
> +	int index, ret = 0;
> +
> +	mutex_lock(&gpc_pd_mutex);
> +	arm_smccc_smc(FSL_SIP_GPC, FSL_SIP_CONFIG_GPC_PM_DOMAIN,
> +			pd->gpc_domain_id, GPC_PD_STATE_OFF,
> +			0, 0, 0, 0, &res);
> +	mutex_unlock(&gpc_pd_mutex);
> +
> +	/* power off the external supply */
> +	if (pd->reg) {
> +		ret = regulator_disable(pd->reg);
> +		if (ret) {
> +			dev_warn(pd->dev, "failed to power off the
> reg%d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	/* disable the necessary clks when power domain on finished
> */
> +	if (pd->num_clks) {
> +		for (index = 0; index < pd->num_clks; index++)
> +			clk_disable_unprepare(pd->clks[index]);
> +	}
> +
> +	return ret;
> +};
> +
> +static int imx8m_pd_clk_init(struct device_node *np,
> +			     struct imx_gpc_pm_domain *domain)
> +{
> +	struct property *pp;
> +	struct clk **clks;
> +	int index;
> +
> +	pp = of_find_property(np, "clocks", NULL);
> +	if (pp)
> +		domain->num_clks = pp->length / 8;
> +	else
> +		domain->num_clks = 0;
> +
> +	if (domain->num_clks) {
> +		clks = kcalloc(domain->num_clks, sizeof(*clks),
> GFP_KERNEL);
> +		if (!clks) {
> +			domain->num_clks = 0;
> +			domain->clks = NULL;
> +			return -ENOMEM;
> +		}
> +
> +		domain->clks = clks;
> +	}
> +
> +	for (index = 0; index < domain->num_clks; index++) {
> +		clks[index] = of_clk_get(np, index);
> +		if (IS_ERR(clks[index])) {
> +			for (index = 0; index < domain->num_clks;
> index++) {
> +				if (!IS_ERR(clks[index]))
> +					clk_put(clks[index]);
> +			}
> +
> +			domain->num_clks = 0;
> +			domain->clks = NULL;
> +			kfree(clks);
> +			pr_warn("imx8m domain clock init failed\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx8m_add_subdomain(struct device_node *parent,
> +			       struct generic_pm_domain *parent_pd)
> +{
> +	struct device_node *child_node;
> +	struct imx_gpc_pm_domain *child_domain;
> +	int ret = 0;
> +
> +	/* add each of the child domain of parent */
> +	for_each_child_of_node(parent, child_node) {
> +		if (!of_device_is_available(child_node))
> +			continue;
> +
> +		child_domain = kzalloc(sizeof(*child_domain),
> GFP_KERNEL);
> +		if (!child_domain)
> +			return -ENOMEM;
> +
> +		ret = of_property_read_string(child_node, "domain-
> name",
> +					      &child_domain-
> >pd.name);
> +		if (ret)
> +			goto exit;
> +
> +		ret = of_property_read_u32(child_node, "domain-id",
> +					   &child_domain-
> >gpc_domain_id);
> +		if (ret)
> +			goto exit;
> +
> +		child_domain->pd.power_off = imx_gpc_pd_power_off;
> +		child_domain->pd.power_on = imx_gpc_pd_power_on;
> +		/* no reg for subdomains */
> +		child_domain->reg = NULL;
> +
> +		imx8m_pd_clk_init(child_node, child_domain);
> +
> +		/* power domains as off at boot */
> +		pm_genpd_init(&child_domain->pd, NULL, true);
> +
> +		/* add subdomain of parent power domain */
> +		pm_genpd_add_subdomain(parent_pd, &child_domain-
> >pd);
> +
> +		ret = of_genpd_add_provider_simple(child_node,
> +						 &child_domain->pd);
> +		if (ret)
> +			pr_err("failed to add subdomain\n");
> +	}
> +
> +	return 0;
> +exit:
> +	kfree(child_domain);
> +	return ret;
> +};
> +
> +static int imx_gpc_pm_domain_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct imx_gpc_pm_domain *imx_pm_domain;
> +	int ret = 0;
> +
> +	if (!np) {
> +		dev_err(dev, "power domain device tree node not
> found\n");
> +		return -ENODEV;
> +	}
> +
> +	imx_pm_domain = devm_kzalloc(dev, sizeof(*imx_pm_domain),
> GFP_KERNEL);
> +	if (!imx_pm_domain)
> +		return -ENOMEM;
> +	imx_pm_domain->dev = dev;
> +
> +	ret = of_property_read_string(np, "domain-name",
> +					&imx_pm_domain->pd.name);
> +	if (ret) {
> +		dev_err(dev, "get domain name failed\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = of_property_read_u32(np, "domain-id",
> +					&imx_pm_domain-
> >gpc_domain_id);
> +	if (ret) {
> +		dev_err(dev, "get domain id failed\n");
> +		return -EINVAL;
> +	}
> +
> +	imx_pm_domain->reg = devm_regulator_get_optional(dev,
> "power");
> +	if (IS_ERR(imx_pm_domain->reg)) {
> +		if (PTR_ERR(imx_pm_domain->reg) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
> +		imx_pm_domain->reg = NULL;
> +	}
> +
> +	imx8m_pd_clk_init(np, imx_pm_domain);
> +
> +	imx_pm_domain->pd.power_off = imx_gpc_pd_power_off;
> +	imx_pm_domain->pd.power_on = imx_gpc_pd_power_on;
> +	/* all power domains as off at boot */
> +	pm_genpd_init(&imx_pm_domain->pd, NULL, true);
> +
> +	ret = of_genpd_add_provider_simple(np,
> +				 &imx_pm_domain->pd);
> +
> +	/* add subdomain */
> +	ret = imx8m_add_subdomain(np, &imx_pm_domain->pd);
> +	if (ret)
> +		dev_warn(dev, "please check the child power domain
> init\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id imx_gpc_pm_domain_ids[] = {
> +	{.compatible = "fsl,imx8mq-pm-domain"},
> +	{.compatible = "fsl,imx8mm-pm-domain"},
> +	{},
> +};
> +
> +static struct platform_driver imx_gpc_pm_domain_driver = {
> +	.driver = {
> +		.name	= "imx8m_gpc_pm_domain",
> +		.owner	= THIS_MODULE,
> +		.of_match_table = imx_gpc_pm_domain_ids,
> +	},
> +	.probe = imx_gpc_pm_domain_probe,
> +};
> +
> +module_platform_driver(imx_gpc_pm_domain_driver);
> +
> +MODULE_AUTHOR("NXP");
> +MODULE_DESCRIPTION("NXP i.MX8M GPC power domain driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/soc/imx/fsl_sip.h b/include/soc/imx/fsl_sip.h
> new file mode 100644
> index 0000000..c3867a2
> --- /dev/null
> +++ b/include/soc/imx/fsl_sip.h
> @@ -0,0 +1,31 @@
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Copyright 2017 NXP
> + *
> + * This program is free software; you can redistribute it and/or
> modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __SOC_FSL_SIP_H
> +#define __SOC_FSL_SIP_H
> +
> +#define FSL_SIP_GPC			0xC2000000
> +#define FSL_SIP_CONFIG_GPC_MASK		0x00
> +#define FSL_SIP_CONFIG_GPC_UNMASK	0x01
> +#define FSL_SIP_CONFIG_GPC_SET_WAKE	0x02
> +#define FSL_SIP_CONFIG_GPC_PM_DOMAIN	0x03
> +
> +#define IMX8MQ_PD_MIPI		0
> +#define IMX8MQ_PD_PCIE1		1
> +#define IMX8MQ_PD_OTG1		2
> +#define IMX8MQ_PD_OTG2		3
> +#define IMX8MQ_PD_GPU		4
> +#define IMX8MQ_PD_VPU		5
> +#define IMX8MQ_PD_HDMI		6
> +#define IMX8MQ_PD_DISP		7
> +#define IMX8MQ_PD_MIPI_CSI1	8
> +#define IMX8MQ_PD_MIPI_CSI2	9
> +#define IMX8MQ_PD_PCIE2		10
> +
> +#endif
