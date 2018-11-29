Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAFBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031FC2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031FC2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbeK3DSk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:18:40 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50645 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbeK3DSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:18:40 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C2E99207AD; Thu, 29 Nov 2018 17:12:45 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4034B207AB;
        Thu, 29 Nov 2018 17:12:45 +0100 (CET)
Date:   Thu, 29 Nov 2018 17:12:45 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Evan Wang <xswang@marvell.com>,
        "Nadav Haklai (Marvell)" <nadavh@marvell.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/6] phy: add A3700 COMPHY support
Message-ID: <20181129171245.4f683045@xps13>
In-Reply-To: <20181122210420.14861-3-miquel.raynal@bootlin.com>
References: <20181122210420.14861-1-miquel.raynal@bootlin.com>
        <20181122210420.14861-3-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Miquel Raynal <miquel.raynal@bootlin.com> wrote on Thu, 22 Nov 2018
22:04:16 +0100:

> Add a driver to support COMPHY, a hardware block providing shared
> serdes PHYs on Marvell Armada 3700. This driver uses SMC calls and
> rely on having an up-to-date firmware.
> 
> SATA, PCie and USB3 host mode have been tested successfully with an
> ESPRESSObin. SGMII mode cannot be tested with this platform.
> 
> Co-Developed-by: Evan Wang <xswang@marvell.com>
> Signed-off-by: Evan Wang <xswang@marvell.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---

[...]

> +static struct phy *mvebu_a3700_comphy_xlate(struct device *dev,
> +					    struct of_phandle_args *args)
> +{
> +	struct mvebu_a3700_comphy_lane *lane;
> +	struct phy *phy;
> +
> +	if (WARN_ON(args->args[0] >= MVEBU_A3700_COMPHY_PORTS))
> +		return ERR_PTR(-EINVAL);
> +
> +	phy = of_phy_simple_xlate(dev, args);
> +	if (IS_ERR(phy))
> +		return phy;
> +
> +	lane = phy_get_drvdata(phy);
> +	if (lane->port >= 0)
> +		return ERR_PTR(-EBUSY);

This is not valid. It works only the first time the consumer gets
a PHY for this lane. If the consumer put the PHY (module is unloaded)
and then gets the PHY again (module is re-loaded a second time), the
port is already set to != -1 and this will exit with an error and
prevent the module to probe.

> +
> +	lane->port = args->args[0];

I will remove the above check and transform it into a valid "port"
value right here.

Note: the same applies to the cp110 comphy driver on which the driver
structure is based.

> +
> +	return phy;
> +}
> +
> +static int mvebu_a3700_comphy_probe(struct platform_device *pdev)
> +{
> +	struct phy_provider *provider;
> +	struct device_node *child;
> +
> +	for_each_available_child_of_node(pdev->dev.of_node, child) {
> +		struct mvebu_a3700_comphy_lane *lane;
> +		struct phy *phy;
> +		int ret;
> +		u32 lane_id;
> +
> +		ret = of_property_read_u32(child, "reg", &lane_id);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "missing 'reg' property (%d)\n",
> +				ret);
> +			continue;
> +		}
> +
> +		if (lane_id >= MVEBU_A3700_COMPHY_LANES) {
> +			dev_err(&pdev->dev, "invalid 'reg' property\n");
> +			continue;
> +		}
> +
> +		lane = devm_kzalloc(&pdev->dev, sizeof(*lane), GFP_KERNEL);
> +		if (!lane)
> +			return -ENOMEM;
> +
> +		phy = devm_phy_create(&pdev->dev, child,
> +				      &mvebu_a3700_comphy_ops);
> +		if (IS_ERR(phy))
> +			return PTR_ERR(phy);
> +
> +		lane->dev = &pdev->dev;
> +		lane->mode = PHY_MODE_INVALID;
> +		lane->id = lane_id;
> +		lane->port = -1;
> +		phy_set_drvdata(phy, lane);
> +	}
> +
> +	provider = devm_of_phy_provider_register(&pdev->dev,
> +						 mvebu_a3700_comphy_xlate);
> +	return PTR_ERR_OR_ZERO(provider);
> +}
> +
> +static const struct of_device_id mvebu_a3700_comphy_of_match_table[] = {
> +	{ .compatible = "marvell,comphy-a3700" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, mvebu_a3700_comphy_of_match_table);
> +
> +static struct platform_driver mvebu_a3700_comphy_driver = {
> +	.probe	= mvebu_a3700_comphy_probe,
> +	.driver	= {
> +		.name = "mvebu-a3700-comphy",
> +		.of_match_table = mvebu_a3700_comphy_of_match_table,
> +	},
> +};
> +module_platform_driver(mvebu_a3700_comphy_driver);
> +
> +MODULE_AUTHOR("Miquèl Raynal <miquel.raynal@bootlin.com>");
> +MODULE_DESCRIPTION("Common PHY driver for A3700");
> +MODULE_LICENSE("GPL v2");


Thanks,
Miquèl
