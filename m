Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755417AbeEHP5H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 11:57:07 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:63209 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754750AbeEHP5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 11:57:05 -0400
Subject: Re: [PATCH] net: phy: DP83811: Add support for the phy
To: <andrew@lunn.ch>, <f.fainelli@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180508141105.23867-1-dmurphy@ti.com>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <1b6877db-61cf-101a-054e-9c1fbe95a813@ti.com>
Date: Tue, 8 May 2018 10:56:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508141105.23867-1-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All

On 05/08/2018 09:11 AM, Dan Murphy wrote:
> Add support for the DP83811 phy by extending
> the DP83822 driver to recognize the PHY IDs.
> 
> The DP83811 supports both rgmii and sgmii interfaces.
> There are 2 part numbers for this the DP83811R does not
> reliably support the SGMII interface but the DP83811S will.
> 
> There is not a way to differentiate these parts from the
> hardware or register set.  So this is controlled via the DT
> to indicate which phy mode is required.  Or the part can be
> strapped to a certain interface.
> 
> Data sheet can be found here:
> http://www.ti.com/product/DP83TC811S-Q1/description
> http://www.ti.com/product/DP83TC811R-Q1/description
> 

I am withdrawing this patch for comment.
Some of the future features have varying register definitions between the DP83811
and DP83822

> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/net/phy/dp83822.c | 42 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
> index 6e8a2a4f3a6e..5c379ff25dac 100644
> --- a/drivers/net/phy/dp83822.c
> +++ b/drivers/net/phy/dp83822.c
> @@ -23,8 +23,10 @@
>  #include <linux/netdevice.h>
>  
>  #define DP83822_PHY_ID	        0x2000a240
> +#define DP83811_PHY_ID		0x2000a253
>  #define DP83822_DEVADDR		0x1f
>  
> +#define MII_DP83811_SGMII_CTRL	0x09
>  #define MII_DP83822_PHYSCR	0x11
>  #define MII_DP83822_MISR1	0x12
>  #define MII_DP83822_MISR2	0x13
> @@ -79,6 +81,13 @@
>  #define DP83822_WOL_INDICATION_SEL BIT(8)
>  #define DP83822_WOL_CLR_INDICATION BIT(11)
>  
> +/* DP83811 SGMII CTRL bits */
> +#define DP83811_TDR_AUTO		BIT(8)
> +#define DP83811_SGMII_EN		BIT(12)
> +#define DP83811_SGMII_AUTO_NEG_EN	BIT(13)
> +#define DP83811_SGMII_TX_ERR_DIS	BIT(14)
> +#define DP83811_SGMII_SOFT_RESET	BIT(15)
> +
>  static int dp83822_ack_interrupt(struct phy_device *phydev)
>  {
>  	int err;
> @@ -267,6 +276,17 @@ static int dp83822_config_init(struct phy_device *phydev)
>  	if (err < 0)
>  		return err;
>  
> +	if ((phydev->interface == PHY_INTERFACE_MODE_SGMII &&
> +	     phydev->phy_id == DP83811_PHY_ID)) {
> +		value = phy_read(phydev, MII_DP83811_SGMII_CTRL);
> +		if (!(value & DP83811_SGMII_EN)) {
> +			err = phy_write(phydev, MII_DP83811_SGMII_CTRL,
> +					(DP83811_SGMII_EN | value));
> +			if (err < 0)
> +				return err;
> +		}
> +	}
> +
>  	value = DP83822_WOL_MAGIC_EN | DP83822_WOL_SECURE_ON | DP83822_WOL_EN;
>  
>  	return phy_write_mmd(phydev, DP83822_DEVADDR, MII_DP83822_WOL_CFG,
> @@ -328,15 +348,31 @@ static struct phy_driver dp83822_driver[] = {
>  		.suspend = dp83822_suspend,
>  		.resume = dp83822_resume,
>  	 },
> +	{
> +		.phy_id = DP83811_PHY_ID,
> +		.phy_id_mask = 0xfffffff0,
> +		.name = "TI DP83811",
> +		.features = PHY_BASIC_FEATURES,
> +		.flags = PHY_HAS_INTERRUPT,
> +		.config_init = genphy_config_init,
> +		.soft_reset = dp83822_phy_reset,
> +		.get_wol = dp83822_get_wol,
> +		.set_wol = dp83822_set_wol,
> +		.ack_interrupt = dp83822_ack_interrupt,
> +		.config_intr = dp83822_config_intr,
> +		.suspend = dp83822_suspend,
> +		.resume = dp83822_resume,
> +	 },
>  };
>  module_phy_driver(dp83822_driver);
>  
>  static struct mdio_device_id __maybe_unused dp83822_tbl[] = {
> -	{ DP83822_PHY_ID, 0xfffffff0 },
> -	{ },
> +	{DP83822_PHY_ID, 0xfffffff0},
> +	{DP83811_PHY_ID, 0xfffffff0},
> +	{}
>  };
>  MODULE_DEVICE_TABLE(mdio, dp83822_tbl);
>  
> -MODULE_DESCRIPTION("Texas Instruments DP83822 PHY driver");
> +MODULE_DESCRIPTION("Texas Instruments DP83811/22 PHY driver");
>  MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com");
>  MODULE_LICENSE("GPL");
> 


-- 
------------------
Dan Murphy
