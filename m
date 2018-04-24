Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeDXSJi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:09:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34816 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752504AbeDXSJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:09:35 -0400
Date: Tue, 24 Apr 2018 20:09:23 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: allow scanning busses with missing phys
Message-ID: <20180424180923.GE19011@piout.net>
References: <20180424160904.32457-1-alexandre.belloni@bootlin.com>
 <2833f30a-cf95-e5c7-e44f-218929e61024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2833f30a-cf95-e5c7-e44f-218929e61024@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2018 09:37:09-0700, Florian Fainelli wrote:
> 
> 
> On 04/24/2018 09:09 AM, Alexandre Belloni wrote:
> > Some MDIO busses will error out when trying to read a phy address with no
> > phy present at that address. In that case, probing the bus will fail
> > because __mdiobus_register() is scanning the bus for all possible phys
> > addresses.
> > 
> > In case MII_PHYSID1 returns -EIO or -ENODEV, consider there is no phy at
> > this address and set the phy ID to 0xffffffff which is then properly
> > handled in get_phy_device().
> 
> Humm, why not have your MDIO bus implementation do the scanning itself
> in a reset() callback, which happens before probing the bus, and based
> on the results, set phy_mask accordingly such that only PHYs present are
> populated?
> 
> My only concern with your change is that we are having a special
> treatment for EIO and ENODEV, so we must make sure MDIO bus drivers are
> all conforming to that.
> 

That was what I was doing in [1] but it seems that Andrew preferred this way.

The third solution I was seeing was to return phy_reg instead of -EIO so
the MDIO driver can return -ENODEV and that would be passed to
get_phy_device(). __mdiobus_register() seems to handle -ENODEV properly.

My coccinelle-fu is not great but the following drivers can return
-ENODEV from their read callback:

drivers/net/ethernet/marvell/mvmdio.c
drivers/net/ethernet/hisilicon/hix5hd2_gmac.c (seeing the error message,
this has probably been copy pasted)

[1] https://marc.info/?l=linux-netdev&m=152183609927933&w=2

> > 
> > Suggested-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  drivers/net/phy/phy_device.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> > index ac23322a32e1..9e4ba8e80a18 100644
> > --- a/drivers/net/phy/phy_device.c
> > +++ b/drivers/net/phy/phy_device.c
> > @@ -535,8 +535,17 @@ static int get_phy_id(struct mii_bus *bus, int addr, u32 *phy_id,
> >  
> >  	/* Grab the bits from PHYIR1, and put them in the upper half */
> >  	phy_reg = mdiobus_read(bus, addr, MII_PHYSID1);
> > -	if (phy_reg < 0)
> > +	if (phy_reg < 0) {
> > +		/* if there is no device, return without an error so scanning
> > +		 * the bus works properly
> > +		 */
> > +		if (phy_reg == -EIO || phy_reg == -ENODEV) {
> > +			*phy_id = 0xffffffff;
> > +			return 0;
> > +		}
> > +
> >  		return -EIO;
> > +	}
> >  
> >  	*phy_id = (phy_reg & 0xffff) << 16;
> >  
> > 
> 
> -- 
> Florian

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
