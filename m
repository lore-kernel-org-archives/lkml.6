Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbeC2OyG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:54:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43453 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751096AbeC2OyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:54:04 -0400
Date: Thu, 29 Mar 2018 16:53:52 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH net-next 3/8] net: mscc: Add MDIO driver
Message-ID: <20180329145352.GD12066@piout.net>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-4-alexandre.belloni@bootlin.com>
 <20180323204939.GS24361@lunn.ch>
 <20180329140544.GB12066@piout.net>
 <20180329144041.GA25752@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329144041.GA25752@lunn.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2018 at 16:40:41 +0200, Andrew Lunn wrote:
> > > > +	for (i = 0; i < PHY_MAX_ADDR; i++) {
> > > > +		if (mscc_miim_read(bus, i, MII_PHYSID1) < 0)
> > > > +			bus->phy_mask |= BIT(i);
> > > > +	}
> > > 
> > > Why do this? Especially so for the external bus, where the PHYs might
> > > have a GPIO reset line, and won't respond until the gpio is
> > > released. The core code does that just before it scans the bus, or
> > > just before it scans the particular address on the bus, depending on
> > > the scope of the GPIO.
> > > 
> > 
> > IIRC, this was needed when probing the bus without DT, in that case, the
> > mdiobus_scan loop of __mdiobus_register() will fail when doing the
> > get_phy_id for phys 0 to 31 because get_phy_id() transforms any error in
> > -EIO and so it is impossible to register the bus. Other drivers have a
> > similar code to handle that case.
> 
> Hi Alexandre
> 
> Do you mean mscc_miim_read() will return -EIO if there is no device on
> the bus at the address trying to be read? Most devices just return
> 0xffff because there is a pull up on the data line, nothing is driving
> it, so all 1's are read.
> 

It will return -EIO but I tried to be clever and return -ENODEV but this
gets changed to -EIO by get_phy_id.

> It sounds like the correct fix is for get_phy_id() to look at the
> error code for mdiobus_read(bus, addr, MII_PHYSID1). If it is EIO and
> maybe ENODEV, set *phy_id to 0xffffffff and return. The scan code
> should then do the correct thing.
> 

That could work indeed. Do you want me to test and send a patch?


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
