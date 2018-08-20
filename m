Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E341FC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E5921473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ur2Piroa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E5921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeHTQWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:22:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58012 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeHTQWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:22:52 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7KD7Dqs047180;
        Mon, 20 Aug 2018 08:07:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1534770433;
        bh=br37jgQDbTa2TJdX9eH7STGIn0sjUYEmW1lP6MWhfhk=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=Ur2PiroakGckU4WIsOV5BoJkkbkPAIKzz8j758BDzHydvnpOnfyI8vFUJI+eYyUAX
         uU3+VwjXco5YQp2O9nJS559iWuVr5z8yFtjvosJbY+1uK5WdppZSKatmIE4lRROJv+
         z3QlpFqh+fdVJ5m5tiAzQCEWFA1pRFPGOS4x+cqE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7KD7D15007888;
        Mon, 20 Aug 2018 08:07:13 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 20
 Aug 2018 08:07:13 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 20 Aug 2018 08:07:13 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7KD7BEP027768;
        Mon, 20 Aug 2018 08:07:12 -0500
Subject: Re: [RFC PATCH 2/2] phy: cadence: Add driver for Sierra PHY
To:     Alan Douglas <adouglas@cadence.com>, <linux-kernel@vger.kernel.org>
References: <1534509115-13577-1-git-send-email-adouglas@cadence.com>
CC:     <stelford@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <64d382c6-900e-f66e-77be-c6ac43866554@ti.com>
Date:   Mon, 20 Aug 2018 18:37:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1534509115-13577-1-git-send-email-adouglas@cadence.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 17 August 2018 06:01 PM, Alan Douglas wrote:
> Add a Sierra PHY driver with PCIe and USB support.
> There are two resets to the PHY, one to enable
> the APB interface for programming registers, and
> another to enable the PHY itself.
> 
> The sequence of operation on startup is to enable
> the APB bus, write the PHY registers and then
> enable the PHY.
> 
> On power-down we simply put the PHY and APB bus in
> reset.
> 
> Signed-off-by: Alan Douglas <adouglas@cadence.com>
> ---
>  drivers/phy/Kconfig               |   1 +
>  drivers/phy/Makefile              |   1 +
>  drivers/phy/cadence/Kconfig       |   9 ++
>  drivers/phy/cadence/Makefile      |   3 +
>  drivers/phy/cadence/cdns-sierra.c | 326 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 340 insertions(+)
>  create mode 100644 drivers/phy/cadence/Kconfig
>  create mode 100644 drivers/phy/cadence/Makefile
>  create mode 100644 drivers/phy/cadence/cdns-sierra.c
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 5c8d452..cc47f85 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -43,6 +43,7 @@ config PHY_XGENE
>  source "drivers/phy/allwinner/Kconfig"
>  source "drivers/phy/amlogic/Kconfig"
>  source "drivers/phy/broadcom/Kconfig"
> +source "drivers/phy/cadence/Kconfig"
>  source "drivers/phy/hisilicon/Kconfig"
>  source "drivers/phy/lantiq/Kconfig"
>  source "drivers/phy/marvell/Kconfig"
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 84e3bd9..ba48acd 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
>  obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
>  obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
>  obj-y					+= broadcom/	\
> +					   cadence/	\
>  					   hisilicon/	\
>  					   marvell/	\
>  					   motorola/	\
> diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
> new file mode 100644
> index 0000000..6bbe5a2
> --- /dev/null
> +++ b/drivers/phy/cadence/Kconfig
> @@ -0,0 +1,9 @@
> +#
> +# Phy drivers for cadence devices
> +#
> +config CDNS_SIERRA_PHY
> +	tristate "CDNS Sierra PHY Driver"
> +	depends on OF && HAS_IOMEM

depends on RESET_CONTROLLER?
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the Cadence Sierra PHY driver
> diff --git a/drivers/phy/cadence/Makefile b/drivers/phy/cadence/Makefile
> new file mode 100644
> index 0000000..b384cb3
> --- /dev/null
> +++ b/drivers/phy/cadence/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_CDNS_SIERRA_PHY)		+= cdns-sierra.o
> +
> diff --git a/drivers/phy/cadence/cdns-sierra.c b/drivers/phy/cadence/cdns-sierra.c
> new file mode 100644
> index 0000000..0581516
> --- /dev/null
> +++ b/drivers/phy/cadence/cdns-sierra.c
> @@ -0,0 +1,326 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence Sierra PHY Driver
> + *
> + * Copyright (c) 2018 Cadence Design Systems
> + * Author: Alan Douglas <adouglas@cadence.com>
> + *
> + */
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <dt-bindings/phy/phy.h>
> +
> +#define CDNS_PHY_PLL_CFG		(0xc00e << 2)
> +#define CDNS_DET_STANDEC_A		(0x4000 << 2)
> +#define CDNS_DET_STANDEC_B		(0x4001 << 2)
> +#define CDNS_DET_STANDEC_C		(0x4002 << 2)
> +#define CDNS_DET_STANDEC_D		(0x4003 << 2)
> +#define CDNS_DET_STANDEC_E		(0x4004 << 2)
> +#define CDNS_PSM_LANECAL		(0x4008 << 2)
> +#define CDNS_PSM_DIAG			(0x4015 << 2)
> +#define CDNS_PSC_TX_A0			(0x4028 << 2)
> +#define CDNS_PSC_TX_A1			(0x4029 << 2)
> +#define CDNS_PSC_TX_A2			(0x402A << 2)
> +#define CDNS_PSC_TX_A3			(0x402B << 2)
> +#define CDNS_PSC_RX_A0			(0x4030 << 2)
> +#define CDNS_PSC_RX_A1			(0x4031 << 2)
> +#define CDNS_PSC_RX_A2			(0x4032 << 2)
> +#define CDNS_PSC_RX_A3			(0x4033 << 2)
> +#define CDNS_PLLCTRL_SUBRATE		(0x403A << 2)
> +#define CDNS_PLLCTRL_GEN_D		(0x403E << 2)
> +#define CDNS_DRVCTRL_ATTEN		(0x406A << 2)
> +#define CDNS_CLKPATHCTRL_TMR		(0x4081 << 2)
> +#define CDNS_RX_CREQ_FLTR_A_MODE1	(0x4087 << 2)
> +#define CDNS_RX_CREQ_FLTR_A_MODE0	(0x4088 << 2)
> +#define CDNS_CREQ_CCLKDET_MODE01	(0x408E << 2)
> +#define CDNS_RX_CTLE_MAINTENANCE	(0x4091 << 2)
> +#define CDNS_CREQ_FSMCLK_SEL		(0x4092 << 2)
> +#define CDNS_CTLELUT_CTRL		(0x4098 << 2)
> +#define CDNS_DFE_ECMP_RATESEL		(0x40C0 << 2)
> +#define CDNS_DFE_SMP_RATESEL		(0x40C1 << 2)
> +#define CDNS_DEQ_VGATUNE_CTRL		(0x40E1 << 2)
> +#define CDNS_TMRVAL_MODE3		(0x416E << 2)
> +#define CDNS_TMRVAL_MODE2		(0x416F << 2)
> +#define CDNS_TMRVAL_MODE1		(0x4170 << 2)
> +#define CDNS_TMRVAL_MODE0		(0x4171 << 2)
> +#define CDNS_PICNT_MODE1		(0x4174 << 2)
> +#define CDNS_CPI_OUTBUF_RATESEL		(0x417C << 2)
> +#define CDNS_LFPSFILT_NS		(0x418A << 2)
> +#define CDNS_LFPSFILT_RD		(0x418B << 2)
> +#define CDNS_LFPSFILT_MP		(0x418C << 2)
> +#define CDNS_SDFILT_H2L_A		(0x4191 << 2)
> +
> +#define SIERRA_PHYS_NUM 2
> +
> +struct cdns_phy_instance {
> +	struct phy *phy;
> +	u32 phy_type;
> +	u32 nlanes;
> +	void __iomem *base;
> +};
> +
> +struct cdns_sierra_phy {
> +	struct device *dev;
> +	void __iomem *base;
> +	u32 *init_data;
> +	struct cdns_phy_instance phys[SIERRA_PHYS_NUM];
> +	struct reset_control *reset;
> +	struct reset_control *apb_reset;
> +	struct clk *clk;
> +	struct phy *pcie_phy;
> +};
> +
> +static void cdns_sierra_pcie_on(struct cdns_phy_instance *ins)
> +{
> +	int i;
> +
> +	for (i = 0; i < (ins->nlanes << 11); i += (1 << 11)) {
> +		writel(0x891f, ins->base + CDNS_DET_STANDEC_D + i);
> +		writel(0x0053, ins->base + CDNS_DET_STANDEC_E + i);
> +		writel(0x0400, ins->base + CDNS_TMRVAL_MODE2 + i);
> +		writel(0x0200, ins->base + CDNS_TMRVAL_MODE3 + i);
> +	}
> +}
> +
> +static void cdns_sierra_usb_on(struct cdns_phy_instance *ins)
> +{
> +	int i;
> +
> +	writel(0x0000, ins->base + CDNS_PHY_PLL_CFG);
> +	for (i = 0; i < (ins->nlanes << 11); i += (1 << 11)) {
> +		writel(0xFE0A, ins->base + CDNS_DET_STANDEC_A + i);
> +		writel(0x000F, ins->base + CDNS_DET_STANDEC_B + i);
> +		writel(0x55A5, ins->base + CDNS_DET_STANDEC_C + i);
> +		writel(0x69AD, ins->base + CDNS_DET_STANDEC_D + i);
> +		writel(0x0241, ins->base + CDNS_DET_STANDEC_E + i);
> +		writel(0x0110, ins->base + CDNS_PSM_LANECAL + i);
> +		writel(0xCF00, ins->base + CDNS_PSM_DIAG + i);
> +		writel(0x001F, ins->base + CDNS_PSC_TX_A0 + i);
> +		writel(0x0007, ins->base + CDNS_PSC_TX_A1 + i);
> +		writel(0x0003, ins->base + CDNS_PSC_TX_A2 + i);
> +		writel(0x0003, ins->base + CDNS_PSC_TX_A3 + i);
> +		writel(0x0FFF, ins->base + CDNS_PSC_RX_A0 + i);
> +		writel(0x0003, ins->base + CDNS_PSC_RX_A1 + i);
> +		writel(0x0003, ins->base + CDNS_PSC_RX_A2 + i);
> +		writel(0x0001, ins->base + CDNS_PSC_RX_A3 + i);
> +		writel(0x0001, ins->base + CDNS_PLLCTRL_SUBRATE + i);
> +		writel(0x0406, ins->base + CDNS_PLLCTRL_GEN_D + i);
> +		writel(0x0000, ins->base + CDNS_DRVCTRL_ATTEN + i);
> +		writel(0x823E, ins->base + CDNS_CLKPATHCTRL_TMR + i);
> +		writel(0x078F, ins->base + CDNS_RX_CREQ_FLTR_A_MODE1 + i);
> +		writel(0x078F, ins->base + CDNS_RX_CREQ_FLTR_A_MODE0 + i);
> +		writel(0x7B3C, ins->base + CDNS_CREQ_CCLKDET_MODE01 + i);
> +		writel(0x023C, ins->base + CDNS_RX_CTLE_MAINTENANCE + i);
> +		writel(0x3232, ins->base + CDNS_CREQ_FSMCLK_SEL + i);
> +		writel(0x8452, ins->base + CDNS_CTLELUT_CTRL + i);
> +		writel(0x4121, ins->base + CDNS_DFE_ECMP_RATESEL + i);
> +		writel(0x4121, ins->base + CDNS_DFE_SMP_RATESEL + i);
> +		writel(0x9999, ins->base + CDNS_DEQ_VGATUNE_CTRL + i);
> +		writel(0x0330, ins->base + CDNS_TMRVAL_MODE0 + i);
> +		writel(0x01FF, ins->base + CDNS_PICNT_MODE1 + i);
> +		writel(0x0009, ins->base + CDNS_CPI_OUTBUF_RATESEL + i);
> +		writel(0x000F, ins->base + CDNS_LFPSFILT_NS + i);
> +		writel(0x0009, ins->base + CDNS_LFPSFILT_RD + i);
> +		writel(0x0001, ins->base + CDNS_LFPSFILT_MP + i);
> +		writel(0x8013, ins->base + CDNS_SDFILT_H2L_A + i);
> +		writel(0x0400, ins->base + CDNS_TMRVAL_MODE1 + i);

Are these tuning parameters? Don't they change for different platforms/vendors?
> +	}
> +}
> +
> +static int cdns_sierra_phy_on(struct phy *x)
> +{
> +	struct cdns_phy_instance *ins = phy_get_drvdata(x);
> +	struct cdns_sierra_phy *phy = dev_get_drvdata(x->dev.parent);
> +	int ret;
> +
> +	ret = clk_prepare_enable(phy->clk);
> +	if (ret)
> +		return ret;
> +
> +	/* Ensure the PHY is in reset */
> +	reset_control_assert(phy->reset);
> +
> +	/* Enable APB */
> +	reset_control_deassert(phy->apb_reset);
> +
> +	/* Program the PHY registers*/
> +	if (ins->phy_type == PHY_TYPE_PCIE)
> +		cdns_sierra_pcie_on(ins);
> +	else
> +		cdns_sierra_usb_on(ins);
> +
> +	/* Take the PHY out of reset */
> +	ret = reset_control_assert(phy->reset);
> +
> +	if (ret) {
> +		clk_disable_unprepare(phy->clk);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int cdns_sierra_phy_off(struct phy *x)
> +{
> +	struct cdns_sierra_phy *phy = dev_get_drvdata(x->dev.parent);
> +	int ret = 0;
> +
> +	reset_control_assert(phy->reset);
> +	reset_control_assert(phy->apb_reset);
> +	clk_disable_unprepare(phy->clk);
> +	dev_info(phy->dev, "sierra PHY OFF\n");

dev_vdbg?
> +
> +	return ret;
> +}
> +
> +static const struct phy_ops ops = {
> +	.power_on	= cdns_sierra_phy_on,
> +	.power_off	= cdns_sierra_phy_off,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static const struct of_device_id cdns_sierra_id_table[];
> +static struct phy *cdns_sierra_xlate(struct device *dev,
> +				     struct of_phandle_args *args)
> +{
> +	struct cdns_sierra_phy *sphy = dev_get_drvdata(dev);
> +	struct cdns_phy_instance *ins = NULL;
> +	int i;
> +
> +	if (args->args_count != 2) {
> +		dev_err(dev, "invalid number of cells in 'phy' property\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (WARN_ON(args->args[1] == 0 || args->args[1] > 4))
> +		return ERR_PTR(-ENODEV);
> +
> +	for (i = 0; i < SIERRA_PHYS_NUM; i++) {
> +		if (sphy->phys[i].phy_type == args->args[0])
> +			ins = &sphy->phys[i];
> +	}
> +
> +	if (!ins) {
> +		dev_err(dev, "failed to find appropriate phy\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	ins->nlanes = args->args[1];
> +
> +	return ins->phy;
> +}
> +
> +static int cdns_sierra_phy_probe(struct platform_device *pdev)
> +{
> +	struct cdns_sierra_phy *sphy;
> +	struct phy_provider *phy_provider;
> +	struct device *dev = &pdev->dev;
> +	const struct of_device_id *match;
> +	struct resource *res;
> +	int i;
> +
> +	sphy = devm_kzalloc(dev, sizeof(*sphy), GFP_KERNEL);
> +	if (!sphy)
> +		return -ENOMEM;
> +
> +	sphy->dev = dev;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
> +	sphy->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(sphy->base)) {
> +		dev_err(dev, "missing \"reg\"\n");
> +		return PTR_ERR(sphy->base);
> +	}
> +
> +	/* Get init data for this PHY */
> +	match = of_match_device(cdns_sierra_id_table, dev);
> +	if (!match)
> +		return -EINVAL;
> +	sphy->init_data = (u32 *)match->data;
> +
> +	/* Check that PHY is present */
> +	if  (sphy->init_data[0] != readl(sphy->base))
> +		return -EINVAL;
> +
> +	platform_set_drvdata(pdev, sphy);
> +
> +	sphy->clk = devm_clk_get(dev, "phy_clk");
> +	if (IS_ERR(sphy->clk)) {
> +		dev_err(dev, "failed to get clock phy_clk\n");
> +		return PTR_ERR(sphy->clk);
> +	}
> +
> +	sphy->reset = devm_reset_control_get(dev, "sierra_reset");
> +	if (IS_ERR(sphy->reset)) {
> +		dev_err(dev, "failed to get reset\n");
> +		return PTR_ERR(sphy->reset);
> +	}
> +
> +	sphy->apb_reset = devm_reset_control_get(dev, "sierra_apb");
> +	if (IS_ERR(sphy->apb_reset)) {
> +		dev_err(dev, "failed to get apb reset\n");
> +		return PTR_ERR(sphy->apb_reset);
> +	}
> +
> +	sphy->phys[0].phy_type = PHY_TYPE_PCIE;
> +	sphy->phys[1].phy_type = PHY_TYPE_USB3;

We can have two subnodes, one for PCIe PHY and one for USB3 PHY. That way we
don't create two PHY's if a vendor hasn't exposed one type of PHY. We also
don't need a custom xlate then.

Thanks
Kishon
