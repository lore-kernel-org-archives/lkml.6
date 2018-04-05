Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbeDEOoJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:44:09 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:51749 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751195AbeDEOoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:44:06 -0400
Date: Thu, 5 Apr 2018 16:43:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bhadram Varka <vbhadram@nvidia.com>
Cc: Esben Haabendal <esben.haabendal@gmail.com>,
        Esben Haabendal <eha@deif.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: phy: marvell: Enable interrupt function on LED2 pin
Message-ID: <20180405144355.GB32663@lunn.ch>
References: <20180405133504.12257-1-esben.haabendal@gmail.com>
 <4d9e0665abf7408988fc4ce20c26a08f@bgmail102.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d9e0665abf7408988fc4ce20c26a08f@bgmail102.nvidia.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c index 0e0978d8a0eb..f03a510f1247 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -457,6 +457,21 @@ static int marvell_of_reg_init(struct phy_device *phydev)  }  #endif /* CONFIG_OF_MDIO */
>  
> +static int m88e1318_config_intr(struct phy_device *phydev) {
> +	int err;
> +
> +	err = marvell_config_intr(phydev);
> +	if (err)
> +		return err;
> +
> +	/* Setup LED[2] as interrupt pin (active low) */
> +	return phy_modify(phydev, MII_88E1318S_PHY_LED_TCR,
> +			  MII_88E1318S_PHY_LED_TCR_FORCE_INT,
> +			  MII_88E1318S_PHY_LED_TCR_INTn_ENABLE |
> +			  MII_88E1318S_PHY_LED_TCR_INT_ACTIVE_LOW);
> 
> Can we move this part of the code to m88e1121_config_init() ?
> 
> Every time whether we disable or enable the interrupts this part of code will execute.

Yes, doing this once would be better. But please allow the LED pin to
be used as an LED when not using interrupts. phy_interrupt_is_valid()
should be involved somehow.

       Andrew
