Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755705AbeD3XU4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 19:20:56 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45348 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755618AbeD3XUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 19:20:54 -0400
Date: Tue, 1 May 2018 01:20:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, Russell King <rmk@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>, davem@davemloft.net,
        cphealy@gmail.com, nikita.yoush@cogentembedded.com,
        vivien.didelot@savoirfairelinux.com, Nisar.Sayed@microchip.com,
        UNGLinuxDriver@microchip.com
Subject: Re: [RFC net-next 4/5] net: phy: Add support for IEEE standard test
 modes
Message-ID: <20180430232049.GA25602@lunn.ch>
References: <20180428003237.1536-1-f.fainelli@gmail.com>
 <20180428003237.1536-5-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180428003237.1536-5-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* genphy_set_test - Make a PHY enter one of the standard IEEE defined
> + * test modes
> + * @phydev: the PHY device instance
> + * @test: the desired test mode
> + * @data: test specific data (none)
> + *
> + * This function makes the designated @phydev enter the desired standard
> + * 100BaseT2 or 1000BaseT test mode as defined in IEEE 802.3-2012 section TWO
> + * and THREE under 32.6.1.2.1 and 40.6.1.1.2 respectively
> + */
> +int genphy_set_test(struct phy_device *phydev,
> +		    struct ethtool_phy_test *test, const u8 *data)
> +{
> +	u16 shift, base, bmcr = 0;
> +	int ret;
> +
> +	/* Exit test mode */
> +	if (test->mode == PHY_STD_TEST_MODE_NORMAL) {
> +		ret = phy_read(phydev, MII_CTRL1000);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret &= ~GENMASK(15, 13);
> +
> +		return phy_write(phydev, MII_CTRL1000, ret);
> +	}

Hi Florain

I looked at the Marvell SDK for PHYs. It performs a soft reset after
swapping back to normal mode. I assume the broadcom PHY does not need
this? But maybe we can add it anyway?

> +
> +	switch (test->mode) {
> +	case PHY_STD_TEST_MODE_100BASET2_1:
> +	case PHY_STD_TEST_MODE_100BASET2_2:
> +	case PHY_STD_TEST_MODE_100BASET2_3:
> +		if (!(phydev->supported & PHY_100BT_FEATURES))
> +			return -EOPNOTSUPP;
> +
> +		shift = 14;
> +		base = test->mode - PHY_STD_TEST_MODE_NORMAL;
> +		bmcr = BMCR_SPEED100;
> +		break;
> +
> +	case PHY_STD_TEST_MODE_1000BASET_1:
> +	case PHY_STD_TEST_MODE_1000BASET_2:
> +	case PHY_STD_TEST_MODE_1000BASET_3:
> +	case PHY_STD_TEST_MODE_1000BASET_4:
> +		if (!(phydev->supported & PHY_1000BT_FEATURES))
> +			return -EOPNOTSUPP;
> +
> +		shift = 13;
> +		base = test->mode - PHY_STD_TEST_MODE_100BASET2_MAX;
> +		bmcr = BMCR_SPEED1000;
> +		break;
> +
> +	default:
> +		/* Let an upper driver deal with additional modes it may
> +		 * support
> +		 */
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* Force speed and duplex */
> +	ret = phy_write(phydev, MII_BMCR, bmcr | BMCR_FULLDPLX);
> +	if (ret < 0)
> +		return ret;

Should there be something to undo this when returning to normal mode?

       Andrew
