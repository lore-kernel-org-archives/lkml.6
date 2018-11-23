Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80D6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AC120663
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7AC120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502282AbeKWTOK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:14:10 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48125 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393613AbeKWTOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:14:10 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D004A20726; Fri, 23 Nov 2018 09:30:54 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 65EE920DC4;
        Fri, 23 Nov 2018 09:30:38 +0100 (CET)
Date:   Fri, 23 Nov 2018 09:30:38 +0100
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 2/6] phy: add A3700 COMPHY support
Message-ID: <20181123093038.20278133@xps13>
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

+ Adding people concerned by this driver that I forgot when initially
  sending the driver, will update the Cc: list if there is a v2.

One question below.

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
>  drivers/phy/marvell/Kconfig                  |  10 +
>  drivers/phy/marvell/Makefile                 |   1 +
>  drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 276 +++++++++++++++++++
>  3 files changed, 287 insertions(+)
>  create mode 100644 drivers/phy/marvell/phy-mvebu-a3700-comphy.c

[...]

> +
> +static int mvebu_a3700_comphy_power_on(struct phy *phy)
> +{
> +	struct mvebu_a3700_comphy_lane *lane = phy_get_drvdata(phy);
> +	u32 fw_param;
> +	int fw_mode;
> +
> +	fw_mode = mvebu_a3700_comphy_get_fw_mode(lane->id, lane->port,
> +						 lane->mode);
> +	if (fw_mode < 0) {
> +		dev_err(lane->dev, "invalid COMPHY mode\n");
> +		return fw_mode;
> +	}
> +
> +	switch (lane->mode) {
> +	case PHY_MODE_USB_HOST_SS:
> +		dev_dbg(lane->dev, "set lane %d to USB3 host mode\n", lane->id);
> +		fw_param = COMPHY_FW_MODE(fw_mode);
> +		break;
> +	case PHY_MODE_SATA:
> +		dev_dbg(lane->dev, "set lane %d to SATA mode\n", lane->id);
> +		fw_param = COMPHY_FW_MODE(fw_mode);
> +		break;
> +	case PHY_MODE_SGMII:
> +		dev_dbg(lane->dev, "set lane %d to SGMII mode\n", lane->id);
> +		fw_param = COMPHY_FW_NET(fw_mode, lane->port,
> +					 COMPHY_FW_SPEED_1_25G);
> +		break;
> +	case PHY_MODE_PCIE:
> +		dev_dbg(lane->dev, "set lane %d to PCIe mode\n", lane->id);
> +		fw_param = COMPHY_FW_PCIE(fw_mode, lane->port,
> +					  COMPHY_FW_SPEED_5G,
> +					  phy->attrs.bus_width);
> +		break;
> +	default:
> +		dev_err(lane->dev, "unsupported PHY mode (%d)\n", lane->mode);
> +		return -ENOTSUPP;
> +	}
> +
> +	return mvebu_a3700_comphy_smc(COMPHY_SIP_POWER_ON, lane->id, fw_param);

This call might fail because the firmware is not up-to-date. In this
case, I wonder what is the appropriate behavior. Here I just return the
error; this means drivers may fail to probe when enabling their PHY.

Shall I ignore a "not supported by the firmware" code and return 0 to
the caller (with a printed warning) so it will continue probing? Doing
so is lying as the PHY might not be configured as expected and S2RAM
will always fail in this case. 

Thanks,
Miquèl
