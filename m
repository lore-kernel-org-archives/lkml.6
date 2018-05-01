Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756060AbeEAR3R convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 13:29:17 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:30688 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753282AbeEAR3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 13:29:15 -0400
X-IronPort-AV: E=Sophos;i="5.49,351,1520924400";
   d="scan'208";a="14385932"
From: <Woojung.Huh@microchip.com>
To: <f.fainelli@gmail.com>, <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <rmk@armlinux.org.uk>,
        <linux-kernel@vger.kernel.org>, <davem@davemloft.net>,
        <cphealy@gmail.com>, <nikita.yoush@cogentembedded.com>,
        <vivien.didelot@savoirfairelinux.com>, <Nisar.Sayed@microchip.com>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [RFC net-next 4/5] net: phy: Add support for IEEE standard test
 modes
Thread-Topic: [RFC net-next 4/5] net: phy: Add support for IEEE standard
 test modes
Thread-Index: AQHT3ohy2ggOrlDWfkGtc62i2Sy80aQbJc3g
Date: Tue, 1 May 2018 17:29:13 +0000
Message-ID: <9235D6609DB808459E95D78E17F2E43D40D553D5@CHN-SV-EXMX02.mchp-main.com>
References: <20180428003237.1536-1-f.fainelli@gmail.com>
 <20180428003237.1536-5-f.fainelli@gmail.com>
In-Reply-To: <20180428003237.1536-5-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.76.4]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

> diff --git a/drivers/net/phy/phy-tests.c b/drivers/net/phy/phy-tests.c
...
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
> +
> +	/* Set the desired test mode bit */
> +	return phy_write(phydev, MII_CTRL1000, (test->mode + base) << shift);
> +}
For now, these are for 100B-T2 & 1000B-TX.
But, other speeds such as 802.3bw/bq/cq have very similar format,
how about make  phy_write() to BMCR & CTRL1000 as another function call per speed?

Thanks.
Woojung
