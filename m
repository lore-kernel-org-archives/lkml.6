Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DACC67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058DC2145D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iRAt+kNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058DC2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeJIHyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:54:06 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:57737 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeJIHyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=1Vs6MF31yun0Dr49s1i51QdnYDbf33uYA+XQGcXQuL0=;
        b=iRAt+kNWN7ICkXDJoPuBUsA/nCZpp29cfl2Nuh7w0KS14SNMsy9FWQS0h8YVygbg1OZF8SEnbktuYrPBvPKwURVSnl1OXzr3m8y4i13fG11P3ro/Hb+fHHCsOC2TCyrROdx2yBYDExRlxCeL6z0RLzoJxgtEGPwyp0+iUuZ2zFI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g9g3j-0006sQ-2w; Tue, 09 Oct 2018 02:39:35 +0200
Date:   Tue, 9 Oct 2018 02:39:35 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 03/11] phy: ti: introduce phy-gmii-sel driver
Message-ID: <20181009003935.GA23588@lunn.ch>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
 <20181008234949.15416-4-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008234949.15416-4-grygorii.strashko@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 06:49:41PM -0500, Grygorii Strashko wrote:
> +static int phy_gmii_sel_mode(struct phy *phy, phy_interface_t intf_mode)
> +{
> +	struct phy_gmii_sel_phy_priv *if_phy = phy_get_drvdata(phy);
> +	const struct phy_gmii_sel_soc_data *soc_data = if_phy->priv->soc_data;
> +	struct device *dev = if_phy->priv->dev;
> +	struct regmap_field *regfield;
> +	int ret, rgmii_id = 0;
> +	u32 mode = 0;
> +
> +	if_phy->phy_if_mode = intf_mode;
> +
> +	switch (if_phy->phy_if_mode) {
> +	case PHY_INTERFACE_MODE_RMII:
> +		mode = AM33XX_GMII_SEL_MODE_RMII;
> +		break;
> +
> +	case PHY_INTERFACE_MODE_RGMII:
> +		mode = AM33XX_GMII_SEL_MODE_RGMII;
> +		break;
> +
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		mode = AM33XX_GMII_SEL_MODE_RGMII;
> +		rgmii_id = 1;
> +		break;

Hi Grygorii

It looks like the MAC can do AM33XX_GMII_SEL_MODE_RGMII and
AM33XX_GMII_SEL_MODE_RGMII_ID. I don't think it can do
AM33XX_GMII_SEL_MODE_RGMII_RXID or AM33XX_GMII_SEL_MODE_RGMII_TXID?  I
would prefer it return -EINVAL when asked to do something it cannot
do.

> +
> +	default:
> +		dev_warn(dev,
> +			 "port%u: unsupported mode: \"%s\". Defaulting to MII.\n",
> +			 if_phy->id, phy_modes(rgmii_id));
> +		/* fall through */

Returning -EINVAL would be better. Otherwise the DT might never get
fixed.

> +	case PHY_INTERFACE_MODE_MII:
> +		mode = AM33XX_GMII_SEL_MODE_MII;
> +		break;
> +	};
> +
> +	dev_dbg(dev, "%s id:%u mode:%u rgmii_id:%d rmii_clk_ext:%d\n",
> +		__func__, if_phy->id, mode, rgmii_id,
> +		if_phy->rmii_clock_external);
> +
> +	regfield = if_phy->fields[PHY_GMII_SEL_PORT_MODE];
> +	ret = regmap_field_write(regfield, mode);
> +
> +	if (soc_data->features & BIT(PHY_GMII_SEL_RGMII_ID_MODE) &&
> +	    if_phy->fields[PHY_GMII_SEL_RGMII_ID_MODE]) {
> +		regfield = if_phy->fields[PHY_GMII_SEL_RGMII_ID_MODE];
> +		ret |= regmap_field_write(regfield, rgmii_id);
> +	}
> +
> +	if (soc_data->features & BIT(PHY_GMII_SEL_RMII_IO_CLK_EN) &&
> +	    if_phy->fields[PHY_GMII_SEL_RMII_IO_CLK_EN]) {
> +		regfield = if_phy->fields[PHY_GMII_SEL_RMII_IO_CLK_EN];
> +		ret |= regmap_field_write(regfield,
> +					  if_phy->rmii_clock_external);
> +	}
> +
> +	if (ret) {
> +		dev_err(dev, "port%u: set mode fail %d", if_phy->id, ret);
> +		return -EIO;
> +	}

I would prefer each write had its own error check. The fact you don't
return ret means you know ret could be -EINVAL|-EOIO, making
-EMORECOFFEE.

	Andrew
