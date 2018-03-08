Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935776AbeCHRdB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:33:01 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:51785 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932091AbeCHRc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:32:59 -0500
Date: Thu, 8 Mar 2018 18:32:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Brad Mouring <brad.mouring@ni.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>, netdev@vger.kernel.org,
        Julia Cartwright <julia@ni.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [1/2] net: macb: Add phy-handle DT support
Message-ID: <20180308173247.GA22340@lunn.ch>
References: <20180307224257.1959-1-brad.mouring@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307224257.1959-1-brad.mouring@ni.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 04:42:56PM -0600, Brad Mouring wrote:
> This optional binding (as described in the ethernet DT bindings doc)
> directs the netdev to the phydev to use. This is useful for a phy
> chip that has >1 phy in it, and two netdevs are using the same phy
> chip (i.e. the second mac's phy lives on the first mac's MDIO bus)
> 
> The devicetree snippet would look something like this:
> 
> ethernet@feedf00d {
> 	...
> 	phy-handle = <&phy0> // the first netdev is physically wired to phy0
> 	...
> 	phy0: phy@0 {
> 		...
> 		reg = <0x0> // MDIO address 0
> 		...
> 	}
> 	phy1: phy@1 {
> 		...
> 		reg = <0x1> // MDIO address 1
> 		...
> 	}
> ...
> }
> 
> ethernet@deadbeef {
> 	...
> 	phy-handle = <&phy1> // tells the driver to use phy1 on the
> 						 // first mac's mdio bus (it's wired thusly)
> 	...
> }
> 
> The work done to add the phy_node in the first place (dacdbb4dfc1a1:
> "net: macb: add fixed-link node support") will consume the
> device_node (if found).
> 
> Signed-off-by: Brad Mouring <brad.mouring@ni.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index e84afcf1ecb5..cc5b9e6e3526 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -567,6 +567,9 @@ static int macb_mii_init(struct macb *bp)
>  
>  			err = mdiobus_register(bp->mii_bus);
>  		} else {
> +			/* attempt to find a phy-handle */
> +			bp->phy_node = of_parse_phandle(np, "phy-handle", 0);
> +
>  			/* try dt phy registration */
>  			err = of_mdiobus_register(bp->mii_bus, np);
>  

Hi Brad

I think it is more logical to do this in macb_mii_probe().

I would probably also move the fixed_link code from macb_mii_init() to
macb_mii_probe(). I would probably also move the fallback to standard
phy registration. Make macb_mii_init() about registering the MDIO bus,
and macb_mii_probe() about probing the MDIO bus to find the PHY to
use. At the moment, it is all rather mixed up.

     Andrew
