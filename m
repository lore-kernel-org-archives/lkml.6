Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1D3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3A3205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cFsCEzBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3A3205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeKTPjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 10:39:13 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55262 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeKTPjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 10:39:13 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAK5Baw2126452;
        Mon, 19 Nov 2018 23:11:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542690696;
        bh=RVl8CNSakOdt1/99jXfuK7qSnRFeG6v8nCKptMZJhHI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cFsCEzBuymhL4alw1RjY+0by9mQHIy7WkgSJIgAXs9Kv5WbeDVdDP3MwNZMHJ/odj
         M5Lgv1HEzNYW72eGIfpGPI1t3Pmt/paBXrqppKLt4pTbThGnVmFm6TyD8K308Z1XA6
         bQZgkK+674p8bnOSptUVI3PoVOMxI06lafy5GMkk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAK5Bal9027313
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 23:11:36 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Nov 2018 23:11:36 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 19 Nov 2018 23:11:36 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAK5BX9R022147;
        Mon, 19 Nov 2018 23:11:33 -0600
Subject: Re: [PATCH v4 08/10] phy: allwinner: add phy driver for USB3 PHY on
 Allwinner H6 SoC
To:     Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
CC:     <devicetree@vger.kernel.org>, <linux-sunxi@googlegroups.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20181004122855.22981-1-icenowy@aosc.io>
 <20181004122855.22981-9-icenowy@aosc.io>
 <03265185c6a2b9bd95d8cf5c3183eb06c73d9b12.camel@aosc.io>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <86b842fc-6331-5e4d-04de-dc9f037f4fa5@ti.com>
Date:   Tue, 20 Nov 2018 10:41:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <03265185c6a2b9bd95d8cf5c3183eb06c73d9b12.camel@aosc.io>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/11/18 10:27 AM, Icenowy Zheng wrote:
> 在 2018-10-04四的 20:28 +0800，Icenowy Zheng写道：
>> Allwinner H6 SoC contains a USB3 PHY (with USB2 DP/DM lines also
>> controlled).
>>
>> Add a driver for it.
>>
>> The register operations in this driver is mainly extracted from the
>> BSP
>> USB3 driver.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> 
> Kishon, I see this patch is picked to linux-next, however this patch is
> not in the stage that can be picked, because for the Vbus of USB3 PHY
> Rob Herring still have some problems.
> 
> Could you remove PATCH 7 and 8 in this patchset now?

I've updated my tree now.

Thanks
Kishon
> 
> Thanks!
> 
>> ---
>> Changes in v4:
>> - Added support for vbus-supply property.
>>
>> Changes in v3:
>> - Dropped USB_SUPPORT dependency.
>> - Added Chen-Yu's Review tag.
>>
>> No changes in v2, v1.
>>
>>   drivers/phy/allwinner/Kconfig           |  12 ++
>>   drivers/phy/allwinner/Makefile          |   1 +
>>   drivers/phy/allwinner/phy-sun50i-usb3.c | 239
>> ++++++++++++++++++++++++
>>   3 files changed, 252 insertions(+)
>>   create mode 100644 drivers/phy/allwinner/phy-sun50i-usb3.c
>>
>> diff --git a/drivers/phy/allwinner/Kconfig
>> b/drivers/phy/allwinner/Kconfig
>> index cdc1e745ba47..064096e6a4e5 100644
>> --- a/drivers/phy/allwinner/Kconfig
>> +++ b/drivers/phy/allwinner/Kconfig
>> @@ -29,3 +29,15 @@ config PHY_SUN9I_USB
>>   	  sun9i SoCs.
>>   
>>   	  This driver controls each individual USB 2 host PHY.
>> +
>> +config PHY_SUN50I_USB3
>> +	tristate "Allwinner sun50i SoC USB3 PHY driver"
>> +	depends on ARCH_SUNXI && HAS_IOMEM && OF
>> +	depends on RESET_CONTROLLER
>> +	select USB_COMMON
>> +	select GENERIC_PHY
>> +	help
>> +	  Enable this to support the USB3.0-capable transceiver that is
>> +	  part of some Allwinner sun50i SoCs.
>> +
>> +	  This driver controls each individual USB 2+3 host PHY combo.
>> diff --git a/drivers/phy/allwinner/Makefile
>> b/drivers/phy/allwinner/Makefile
>> index 8605529c01a1..a8d01e9073c2 100644
>> --- a/drivers/phy/allwinner/Makefile
>> +++ b/drivers/phy/allwinner/Makefile
>> @@ -1,2 +1,3 @@
>>   obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
>>   obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
>> +obj-$(CONFIG_PHY_SUN50I_USB3)		+= phy-sun50i-usb3.o
>> diff --git a/drivers/phy/allwinner/phy-sun50i-usb3.c
>> b/drivers/phy/allwinner/phy-sun50i-usb3.c
>> new file mode 100644
>> index 000000000000..70c299c01c3e
>> --- /dev/null
>> +++ b/drivers/phy/allwinner/phy-sun50i-usb3.c
>> @@ -0,0 +1,239 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Allwinner sun50i(H6) USB 3.0 phy driver
>> + *
>> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
>> + *
>> + * Based on phy-sun9i-usb.c, which is:
>> + *
>> + * Copyright (C) 2014-2015 Chen-Yu Tsai <wens@csie.org>
>> + *
>> + * Based on code from Allwinner BSP, which is:
>> + *
>> + * Copyright (c) 2010-2015 Allwinner Technology Co., Ltd.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/usb/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/reset.h>
>> +
>> +/* Interface Status and Control Registers */
>> +#define SUNXI_ISCR			0x00
>> +#define SUNXI_PIPE_CLOCK_CONTROL	0x14
>> +#define SUNXI_PHY_TUNE_LOW		0x18
>> +#define SUNXI_PHY_TUNE_HIGH		0x1c
>> +#define SUNXI_PHY_EXTERNAL_CONTROL	0x20
>> +
>> +/* USB2.0 Interface Status and Control Register */
>> +#define SUNXI_ISCR_FORCE_VBUS		(3 << 12)
>> +
>> +/* PIPE Clock Control Register */
>> +#define SUNXI_PCC_PIPE_CLK_OPEN		(1 << 6)
>> +
>> +/* PHY External Control Register */
>> +#define SUNXI_PEC_EXTERN_VBUS		(3 << 1)
>> +#define SUNXI_PEC_SSC_EN		(1 << 24)
>> +#define SUNXI_PEC_REF_SSP_EN		(1 << 26)
>> +
>> +/* PHY Tune High Register */
>> +#define SUNXI_TX_DEEMPH_3P5DB(n)	((n) << 19)
>> +#define SUNXI_TX_DEEMPH_3P5DB_MASK	GENMASK(24, 19)
>> +#define SUNXI_TX_DEEMPH_6DB(n)		((n) << 13)
>> +#define SUNXI_TX_DEEMPH_6GB_MASK	GENMASK(18, 13)
>> +#define SUNXI_TX_SWING_FULL(n)		((n) << 6)
>> +#define SUNXI_TX_SWING_FULL_MASK	GENMASK(12, 6)
>> +#define SUNXI_LOS_BIAS(n)		((n) << 3)
>> +#define SUNXI_LOS_BIAS_MASK		GENMASK(5, 3)
>> +#define SUNXI_TXVBOOSTLVL(n)		((n) << 0)
>> +#define SUNXI_TXVBOOSTLVL_MASK		GENMASK(0, 2)
>> +
>> +struct sun50i_usb3_phy {
>> +	struct phy *phy;
>> +	void __iomem *regs;
>> +	struct reset_control *reset;
>> +	struct clk *clk;
>> +	bool regulator_on;
>> +	struct regulator *vbus;
>> +};
>> +
>> +static void sun50i_usb3_phy_open(struct sun50i_usb3_phy *phy)
>> +{
>> +	u32 val;
>> +
>> +	val = readl(phy->regs + SUNXI_PHY_EXTERNAL_CONTROL);
>> +	val |= SUNXI_PEC_EXTERN_VBUS;
>> +	val |= SUNXI_PEC_SSC_EN | SUNXI_PEC_REF_SSP_EN;
>> +	writel(val, phy->regs + SUNXI_PHY_EXTERNAL_CONTROL);
>> +
>> +	val = readl(phy->regs + SUNXI_PIPE_CLOCK_CONTROL);
>> +	val |= SUNXI_PCC_PIPE_CLK_OPEN;
>> +	writel(val, phy->regs + SUNXI_PIPE_CLOCK_CONTROL);
>> +
>> +	val = readl(phy->regs + SUNXI_ISCR);
>> +	val |= SUNXI_ISCR_FORCE_VBUS;
>> +	writel(val, phy->regs + SUNXI_ISCR);
>> +
>> +	/*
>> +	 * All the magic numbers written to the PHY_TUNE_{LOW_HIGH}
>> +	 * registers are directly taken from the BSP USB3 driver from
>> +	 * Allwiner.
>> +	 */
>> +	writel(0x0047fc87, phy->regs + SUNXI_PHY_TUNE_LOW);
>> +
>> +	val = readl(phy->regs + SUNXI_PHY_TUNE_HIGH);
>> +	val &= ~(SUNXI_TXVBOOSTLVL_MASK | SUNXI_LOS_BIAS_MASK |
>> +		 SUNXI_TX_SWING_FULL_MASK | SUNXI_TX_DEEMPH_6GB_MASK |
>> +		 SUNXI_TX_DEEMPH_3P5DB_MASK);
>> +	val |= SUNXI_TXVBOOSTLVL(0x7);
>> +	val |= SUNXI_LOS_BIAS(0x7);
>> +	val |= SUNXI_TX_SWING_FULL(0x55);
>> +	val |= SUNXI_TX_DEEMPH_6DB(0x20);
>> +	val |= SUNXI_TX_DEEMPH_3P5DB(0x15);
>> +	writel(val, phy->regs + SUNXI_PHY_TUNE_HIGH);
>> +}
>> +
>> +static int sun50i_usb3_phy_init(struct phy *_phy)
>> +{
>> +	struct sun50i_usb3_phy *phy = phy_get_drvdata(_phy);
>> +	int ret;
>> +
>> +	ret = clk_prepare_enable(phy->clk);
>> +	if (ret)
>> +		goto err_clk;
>> +
>> +	ret = reset_control_deassert(phy->reset);
>> +	if (ret)
>> +		goto err_reset;
>> +
>> +	sun50i_usb3_phy_open(phy);
>> +	return 0;
>> +
>> +err_reset:
>> +	clk_disable_unprepare(phy->clk);
>> +
>> +err_clk:
>> +	return ret;
>> +}
>> +
>> +static int sun50i_usb3_phy_exit(struct phy *_phy)
>> +{
>> +	struct sun50i_usb3_phy *phy = phy_get_drvdata(_phy);
>> +
>> +	reset_control_assert(phy->reset);
>> +	clk_disable_unprepare(phy->clk);
>> +
>> +	return 0;
>> +}
>> +
>> +static int sun50i_usb3_phy_power_on(struct phy *_phy)
>> +{
>> +	struct sun50i_usb3_phy *phy = phy_get_drvdata(_phy);
>> +	int ret;
>> +
>> +	if (!phy->vbus || phy->regulator_on)
>> +		return 0;
>> +
>> +	ret = regulator_enable(phy->vbus);
>> +	if (ret)
>> +		return ret;
>> +
>> +	phy->regulator_on = true;
>> +
>> +	return 0;
>> +}
>> +
>> +static int sun50i_usb3_phy_power_off(struct phy *_phy)
>> +{
>> +	struct sun50i_usb3_phy *phy = phy_get_drvdata(_phy);
>> +
>> +	if (!phy->vbus || !phy->regulator_on)
>> +		return 0;
>> +
>> +	regulator_disable(phy->vbus);
>> +	phy->regulator_on = false;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct phy_ops sun50i_usb3_phy_ops = {
>> +	.init		= sun50i_usb3_phy_init,
>> +	.exit		= sun50i_usb3_phy_exit,
>> +	.power_on	= sun50i_usb3_phy_power_on,
>> +	.power_off	= sun50i_usb3_phy_power_off,
>> +	.owner		= THIS_MODULE,
>> +};
>> +
>> +static int sun50i_usb3_phy_probe(struct platform_device *pdev)
>> +{
>> +	struct sun50i_usb3_phy *phy;
>> +	struct device *dev = &pdev->dev;
>> +	struct phy_provider *phy_provider;
>> +	struct resource *res;
>> +
>> +	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
>> +	if (!phy)
>> +		return -ENOMEM;
>> +
>> +	phy->clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(phy->clk)) {
>> +		dev_err(dev, "failed to get phy clock\n");
>> +		return PTR_ERR(phy->clk);
>> +	}
>> +
>> +	phy->reset = devm_reset_control_get(dev, NULL);
>> +	if (IS_ERR(phy->reset)) {
>> +		dev_err(dev, "failed to get reset control\n");
>> +		return PTR_ERR(phy->reset);
>> +	}
>> +
>> +	phy->vbus = devm_regulator_get_optional(dev, "vbus");
>> +	if (IS_ERR(phy->vbus)) {
>> +		if (PTR_ERR(phy->vbus) == -EPROBE_DEFER) {
>> +			dev_err(dev, "Couldn't get vbus regulator...
>> Deferring probe\n");
>> +			return -EPROBE_DEFER;
>> +		}
>> +
>> +		phy->vbus = NULL;
>> +	}
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	phy->regs = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(phy->regs))
>> +		return PTR_ERR(phy->regs);
>> +
>> +	phy->phy = devm_phy_create(dev, NULL, &sun50i_usb3_phy_ops);
>> +	if (IS_ERR(phy->phy)) {
>> +		dev_err(dev, "failed to create PHY\n");
>> +		return PTR_ERR(phy->phy);
>> +	}
>> +
>> +	phy_set_drvdata(phy->phy, phy);
>> +	phy_provider = devm_of_phy_provider_register(dev,
>> of_phy_simple_xlate);
>> +
>> +	return PTR_ERR_OR_ZERO(phy_provider);
>> +}
>> +
>> +static const struct of_device_id sun50i_usb3_phy_of_match[] = {
>> +	{ .compatible = "allwinner,sun50i-h6-usb3-phy" },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, sun50i_usb3_phy_of_match);
>> +
>> +static struct platform_driver sun50i_usb3_phy_driver = {
>> +	.probe	= sun50i_usb3_phy_probe,
>> +	.driver = {
>> +		.of_match_table	= sun50i_usb3_phy_of_match,
>> +		.name  = "sun50i-usb3-phy",
>> +	}
>> +};
>> +module_platform_driver(sun50i_usb3_phy_driver);
>> +
>> +MODULE_DESCRIPTION("Allwinner sun50i USB 3.0 phy driver");
>> +MODULE_AUTHOR("Icenowy Zheng <icenowy@aosc.io>");
>> +MODULE_LICENSE("GPL");
> 
