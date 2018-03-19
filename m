Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933230AbeCSLMb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 07:12:31 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39156 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932487AbeCSLM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 07:12:29 -0400
Date: Mon, 19 Mar 2018 11:12:05 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Antoine Tenart <antoine.tenart@bootlin.com>
Cc: davem@davemloft.net, kishon@ti.com, gregory.clement@bootlin.com,
        andrew@lunn.ch, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR interface
 to use in-band negotiation
Message-ID: <20180319111205.GB2743@n2100.armlinux.org.uk>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
 <20180316155307.GQ9418@n2100.armlinux.org.uk>
 <20180319085252.GF4519@kwain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319085252.GF4519@kwain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 09:52:52AM +0100, Antoine Tenart wrote:
> Hi Russell,
> 
> On Fri, Mar 16, 2018 at 03:53:07PM +0000, Russell King - ARM Linux wrote:
> > On Fri, Mar 16, 2018 at 11:33:43AM +0100, Antoine Tenart wrote:
> > > The PHY mode 10GKR can use in-band negotiation. This patches allows this
> > > mode to be used with MLO_AN_INBAND in phylink.
> > > 
> > > Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> > > ---
> > >  drivers/net/phy/phylink.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > > index 51a011a349fe..7224b005f0dd 100644
> > > --- a/drivers/net/phy/phylink.c
> > > +++ b/drivers/net/phy/phylink.c
> > > @@ -768,7 +768,8 @@ int phylink_of_phy_connect(struct phylink *pl, struct device_node *dn,
> > >  	/* Fixed links and 802.3z are handled without needing a PHY */
> > >  	if (pl->link_an_mode == MLO_AN_FIXED ||
> > >  	    (pl->link_an_mode == MLO_AN_INBAND &&
> > > -	     phy_interface_mode_is_8023z(pl->link_interface)))
> > > +	     (phy_interface_mode_is_8023z(pl->link_interface) ||
> > > +	      pl->link_interface == PHY_INTERFACE_MODE_10GKR)))
> > 
> > There is no inband negotiation like there is with 802.3z or SGMII,
> > so this makes no sense.
> 
> Oh, that's what I feared. I read some docs but probably will need more
> :)
> 
> Anyway, the reason to use in-band negotiation was also to avoid using
> fixed-link. It would work but always report the link is up, which for
> the user isn't a great experience as we have a way to detect this.
> 
> What would you suggest to achieve this in a reasonable way?

The intention of this test in phylink_of_phy_connect() is to avoid
failing when there is no requirement for a PHY to be present (such as
a fixed link, or an 802.3z link.)  However, with 10G PHYs such as the
3310, we need the PHY so we can read the speed from it, and so know
whether to downgrade the MAC to SGMII mode, or having downgraded the
MAC, upgrade it back to 10G mode when the PHY switches to 10G.

I'm guessing that you're wanting this for the DB boards, but I don't
see why.  Do they not have PHYs?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
