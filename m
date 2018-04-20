Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753900AbeDTG6i (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 02:58:38 -0400
Received: from imail.nibe.se ([193.218.206.193]:6823 "EHLO imail.nibe.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752725AbeDTG6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 02:58:36 -0400
X-IronPort-AV: E=Sophos;i="5.49,300,1520895600";
   d="scan'208";a="19034840"
Date: Fri, 20 Apr 2018 08:58:32 +0200
From: =?iso-8859-1?Q?M=E5ns?= Andersson <mans.andersson@nibe.se>
To: Andrew Lunn <andrew@lunn.ch>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: phy: TLK10X initial driver submission
Message-ID: <20180420065832.GA110571@ninb0909vm2.ninb0909.nibe.se>
References: <20180419082816.109338-1-mans.andersson@nibe.se>
 <20180419120902.GB17888@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419120902.GB17888@lunn.ch>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-C2ProcessedOrg: 0e72f327-13a8-401d-baac-ca43efdc4f0c
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 02:09:02PM +0200, Andrew Lunn wrote:
> On Thu, Apr 19, 2018 at 10:28:16AM +0200, Måns Andersson wrote:
> > From: Mans Andersson <mans.andersson@nibe.se>
> > 
> > Add suport for the TI TLK105 and TLK106 10/100Mbit ethernet phys.
> > 
> > In addition the TLK10X needs to be removed from DP83848 driver as the
> > power back off support is added here for this device.
> > 
> > Datasheet:
> > http://www.ti.com/lit/gpn/tlk106
> > ---
> >  .../devicetree/bindings/net/ti,tlk10x.txt          |  27 +++
> >  drivers/net/phy/Kconfig                            |   5 +
> >  drivers/net/phy/Makefile                           |   1 +
> >  drivers/net/phy/dp83848.c                          |   3 -
> >  drivers/net/phy/tlk10x.c                           | 209 +++++++++++++++++++++
> >  5 files changed, 242 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/net/ti,tlk10x.txt
> >  create mode 100644 drivers/net/phy/tlk10x.c
> > 
> > diff --git a/Documentation/devicetree/bindings/net/ti,tlk10x.txt b/Documentation/devicetree/bindings/net/ti,tlk10x.txt
> > new file mode 100644
> > index 0000000..371d0d7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/ti,tlk10x.txt
> > @@ -0,0 +1,27 @@
> > +* Texas Instruments - TLK105 / TLK106 ethernet PHYs
> > +
> > +Required properties:
> > +	- reg - The ID number for the phy, usually a small integer
> > +
> > +Optional properties:
> > +	- ti,power-back-off - Power Back Off Level
> > +		Please refer to data sheet chapter 8.6 and TI Application
> > +		Note SLLA3228
> > +		0 - Normal Operation
> > +		1 - Level 1 (up to 140m cable between TLK link partners)
> > +		2 - Level 2 (up to 100m cable between TLK link partners)
> > +		3 - Level 3 (up to 80m cable between TLK link partners)
> 
> Hi Måns
> 
> Device tree is all about board properties. In most cases, power back
> off is not a board properties, since it depends on the cable length
> and the peer board. If however, your board has two PHYs back to back,
> say to connect to an Ethernet switch, that would be a valid board
> property.
> 
> How are you using this?
> 
> I know of others who would like such a configuration. Marvell PHYs can
> do something similar. I've always suggested adding a PHY tunable. Pass
> the cable length in meters and let the PHY driver pick the nearest it
> can do, rounding up. The Marvell PHYs also support measuring the cable
> length as part of the cable diagnostics. So it would be good to
> reserve a configuration value to mean 'auto' - measure the cable and
> then pick the best power back off. Quickly scanning the data sheet, i
> see that this PHY also has the ability to measure the cable length.
>

Hi Andrew,

Thanks for your comments, highly appreciated!

I'm using this to lock down the PHY to the IEEE 802.3 100m standard cable
length, as opposed to the extended 150m which the PHY supports in its
default operation (see pg. 2 of the data sheet). The reason why I need this
is that the board has too high EMC emissions when running with the default
operation. For me the setting is therefore used as a board property, i.e.
it's not something that will be changed during operation.
 
> > +static int tlk10x_read(struct phy_device *phydev, int reg)
> > +{
> > +	if (reg & ~0x1f) {
> > +		/* Extended register */
> > +		phy_write(phydev, TLK10X_REGCR, 0x001F);
> > +		phy_write(phydev, TLK10X_ADDAR, reg);
> > +		phy_write(phydev, TLK10X_REGCR, 0x401F);
> > +		reg = TLK10X_ADDAR;
> > +	}
> > +
> > +	return phy_read(phydev, reg);
> > +}
> > +
> > +static int tlk10x_write(struct phy_device *phydev, int reg, int val)
> > +{
> > +	if (reg & ~0x1f) {
> > +		/* Extended register */
> > +		phy_write(phydev, TLK10X_REGCR, 0x001F);
> > +		phy_write(phydev, TLK10X_ADDAR, reg);
> > +		phy_write(phydev, TLK10X_REGCR, 0x401F);
> > +		reg = TLK10X_ADDAR;
> > +	}
> > +
> > +	return phy_write(phydev, reg, val);
> > +}
> 
> This looks to be phy_read_mmd() and phy_write_mmd(). If so, please use
> them, they get the locking correct.
>

Yes, that's correct, will fix that.

> 
> > +#ifdef CONFIG_OF_MDIO
> > +static int tlk10x_of_init(struct phy_device *phydev)
> > +{
> > +	struct tlk10x_private *tlk10x = phydev->priv;
> > +	struct device *dev = &phydev->mdio.dev;
> > +	struct device_node *of_node = dev->of_node;
> > +	int ret;
> > +
> > +	if (!of_node)
> > +		return 0;
> > +
> > +	ret = of_property_read_u32(of_node, "ti,power-back-off",
> > +				   &tlk10x->pwrbo_level);
> > +	if (ret) {
> > +		dev_err(dev, "missing ti,power-back-off property");
> > +		tlk10x->pwrbo_level = 0;
> > +	}
> 
> If we decide to accept this, you should do range checking, and return
> -EINVAL if the value is out of range.

Ok, will fix that.

> 
> > +static int tlk10x_config_init(struct phy_device *phydev)
> > +{
> > +	int ret, reg;
> > +	struct tlk10x_private *tlk10x;
> > +
> > +	ret = genphy_config_init(phydev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (!phydev->priv) {
> > +		tlk10x = devm_kzalloc(&phydev->mdio.dev, sizeof(*tlk10x),
> > +				      GFP_KERNEL);
> > +		if (!tlk10x)
> > +			return -ENOMEM;
> > +
> > +		phydev->priv = tlk10x;
> > +		ret = tlk10x_of_init(phydev);
> > +		if (ret)
> > +			return ret;
> > +	} else {
> > +		tlk10x = (struct tlk10x_private *)phydev->priv;
> > +	}
> 
> This allocation should be done in .probe

Ok, will fix that.

> 
> > +
> > +	// Power back off
> > +	if (tlk10x->pwrbo_level < 0 || tlk10x->pwrbo_level > 3)
> > +		tlk10x->pwrbo_level = 0;
> > +	reg = tlk10x_read(phydev, TLK10X_PWRBOCR);
> > +	reg = ((reg & ~TLK10X_PWRBOCR_MASK)
> > +		| (tlk10x->pwrbo_level << 6));
> > +	ret = tlk10x_write(phydev, TLK10X_PWRBOCR, reg);
> > +	if (ret < 0) {
> > +		dev_err(&phydev->mdio.dev,
> > +			"unable to set power back-off (err=%d)\n", ret);
> > +		return ret;
> > +	}
> > +	dev_info(&phydev->mdio.dev, "power back-off set to level %d\n",
> > +		 tlk10x->pwrbo_level);
> > +
> > +	return 0;
> > +}
> 
>   Andrew

// Måns
