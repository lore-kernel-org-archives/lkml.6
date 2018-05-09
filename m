Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935024AbeEINnV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 09:43:21 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:53361 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934724AbeEINnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 09:43:18 -0400
Date: Wed, 9 May 2018 15:43:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dan Murphy <dmurphy@ti.com>
Cc: f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: DP83TC811: Introduce support for the DP83TC811
 phy
Message-ID: <20180509134315.GE14276@lunn.ch>
References: <20180509120559.12725-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509120559.12725-1-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int dp83811_config_aneg(struct phy_device *phydev)
> +{
> +	int err;
> +	int value;
> +
> +	value = phy_read(phydev, MII_DP83811_SGMII_CTRL);
> +	if (phydev->autoneg == AUTONEG_ENABLE) {
> +		err = phy_write(phydev, MII_DP83811_SGMII_CTRL,
> +				(DP83811_SGMII_AUTO_NEG_EN | value));
> +		if (err < 0)
> +			return err;
> +	} else {
> +		err = phy_write(phydev, MII_DP83811_SGMII_CTRL,
> +				(~DP83811_SGMII_AUTO_NEG_EN & value));
> +		if (err < 0)
> +			return err;
> +	}
> +

Hi Dan

You say SGMII is unreliable on one of these devices. Should you check
phydev->interface before enabling SGMII autoneg?

> +	return genphy_config_aneg(phydev);
> +}
> +
> +static int dp83811_config_init(struct phy_device *phydev)
> +{
> +	int err;
> +	int value;
> +
> +	err = genphy_config_init(phydev);
> +	if (err < 0)
> +		return err;
> +
> +	if (phydev->interface == PHY_INTERFACE_MODE_SGMII) {
> +		value = phy_read(phydev, MII_DP83811_SGMII_CTRL);
> +		if (!(value & DP83811_SGMII_EN)) {
> +			err = phy_write(phydev, MII_DP83811_SGMII_CTRL,
> +					(DP83811_SGMII_EN | value));
> +			if (err < 0)
> +				return err;
> +		} else {
> +			err = phy_write(phydev, MII_DP83811_SGMII_CTRL,
> +				(~DP83811_SGMII_EN & value));
> +			if (err < 0)
> +				return err;
> +		}

This looks to be a duplicate of dp83811_config_aneg()?

> +	}
> +
> +	value = DP83811_WOL_MAGIC_EN | DP83811_WOL_SECURE_ON | DP83811_WOL_EN;
> +
> +	return phy_write_mmd(phydev, DP83811_DEVADDR, MII_DP83811_WOL_CFG,
> +	      value);
> +}
> +
> +static int dp83811_phy_reset(struct phy_device *phydev)
> +{
> +	int err;
> +
> +	err = phy_write(phydev, MII_DP83811_RESET_CTRL, DP83811_HW_RESET);
> +	if (err < 0)
> +		return err;
> +
> +	dp83811_config_init(phydev);

I don't think you need to initialize it here. phylib should call that
soon after the reset.

> +
> +	return 0;
> +}
> +

> +static struct phy_driver dp83811_driver[] = {
> +	{
> +		.phy_id = DP83TC811_PHY_ID,
> +		.phy_id_mask = 0xfffffff0,
> +		.name = "TI DP83TC811",
> +		.features = PHY_BASIC_FEATURES,
> +		.flags = PHY_HAS_INTERRUPT,
> +		.config_init = genphy_config_init,

????

	Andrew
