Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964980AbeBMNmd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:42:33 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:54393 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964792AbeBMNmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:42:31 -0500
Date: Tue, 13 Feb 2018 14:42:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, f.fainelli@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: phy: dp83867: Add binding for the CLK_OUT pin
 muxing option
Message-ID: <20180213134226.GA31407@lunn.ch>
References: <1518514952-22392-1-git-send-email-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518514952-22392-1-git-send-email-d.schultz@phytec.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 10:42:31AM +0100, Daniel Schultz wrote:
> From: Wadim Egorov <w.egorov@phytec.de>
> 
> The DP83867 has a muxing option for the CLK_OUT pin. It is possible
> to set CLK_OUT for different channels.
> Create a binding to select a specific clock for CLK_OUT pin.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
>  drivers/net/phy/dp83867.c            | 14 ++++++++++++++
>  include/dt-bindings/net/ti-dp83867.h | 14 ++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
> index c1ab976..ffb97c2 100644
> --- a/drivers/net/phy/dp83867.c
> +++ b/drivers/net/phy/dp83867.c
> @@ -75,6 +75,8 @@
>  
>  #define DP83867_IO_MUX_CFG_IO_IMPEDANCE_MAX	0x0
>  #define DP83867_IO_MUX_CFG_IO_IMPEDANCE_MIN	0x1f
> +#define DP83867_IO_MUX_CFG_CLK_O_SEL_MASK	(0x1f << 8)
> +#define DP83867_IO_MUX_CFG_CLK_O_SEL_SHIFT	8
>  
>  /* CFG4 bits */
>  #define DP83867_CFG4_PORT_MIRROR_EN              BIT(0)
> @@ -92,6 +94,7 @@ struct dp83867_private {
>  	int io_impedance;
>  	int port_mirroring;
>  	bool rxctrl_strap_quirk;
> +	int clk_output_sel;
>  };
>  
>  static int dp83867_ack_interrupt(struct phy_device *phydev)
> @@ -160,6 +163,11 @@ static int dp83867_of_init(struct phy_device *phydev)
>  	dp83867->io_impedance = -EINVAL;
>  
>  	/* Optional configuration */
> +	if (of_property_read_u32(of_node, "ti,clk-output-sel",
> +				 &dp83867->clk_output_sel))
> +		/* Keep the default value if ti,clk-output-sel is not set */
> +		dp83867->clk_output_sel = DP83867_CLK_O_SEL_REF_CLK;
> +

Hi Daniel

Normally you don't put registers values into device tree. But in this
case, i don't see a better alternative.

Please add a range check. Values > 01101 are reserved.

>  	if (of_property_read_bool(of_node, "ti,max-output-impedance"))
>  		dp83867->io_impedance = DP83867_IO_MUX_CFG_IO_IMPEDANCE_MAX;
>  	else if (of_property_read_bool(of_node, "ti,min-output-impedance"))
> @@ -295,6 +303,12 @@ static int dp83867_config_init(struct phy_device *phydev)
>  	if (dp83867->port_mirroring != DP83867_PORT_MIRROING_KEEP)
>  		dp83867_config_port_mirroring(phydev);
>  
> +	/* Clock output selection */
> +	val = phy_read_mmd(phydev, DP83867_DEVADDR, DP83867_IO_MUX_CFG);
> +	val &= ~DP83867_IO_MUX_CFG_CLK_O_SEL_MASK;

This could be a problem. If i'm reading the datasheet correctly,
clearing this bit will override the strapping. A hardware engineer
might of included a resistor to disable the clock output, saving some
power. And here you unconditionally turn it back on again. Since
ti,clk-output-sel is optional, i would prefer that you don't touch
this register if the property is not present.

     Andrew
