Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755521AbeCSNGX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:06:23 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40484 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755506AbeCSNGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:06:15 -0400
Date: Mon, 19 Mar 2018 13:05:57 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Yan Markman <ymarkman@marvell.com>
Cc: Stefan Chulski <stefanc@marvell.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kishon@ti.com" <kishon@ti.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, "mw@semihalf.com" <mw@semihalf.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR
 interface to use in-band negotiation
Message-ID: <20180319130556.GC2743@n2100.armlinux.org.uk>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
 <20180316155307.GQ9418@n2100.armlinux.org.uk>
 <20180319085252.GF4519@kwain>
 <20180319111205.GB2743@n2100.armlinux.org.uk>
 <4e11135ba2644f76beb41a307c9d990a@IL-EXCH01.marvell.com>
 <2ff0a81f55a84069a4652d02a4212b70@IL-EXCH01.marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ff0a81f55a84069a4652d02a4212b70@IL-EXCH01.marvell.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 01:01:07PM +0000, Yan Markman wrote:
> The DTS-patch for this board (in "old" format) is attached
> 
> 
> Yan Markman
> Tel. 05-44732819
> 
> 
> -----Original Message-----
> From: Stefan Chulski 
> Sent: Monday, March 19, 2018 2:58 PM
> To: Russell King - ARM Linux <linux@armlinux.org.uk>; Antoine Tenart <antoine.tenart@bootlin.com>
> Cc: davem@davemloft.net; kishon@ti.com; gregory.clement@bootlin.com; andrew@lunn.ch; jason@lakedaemon.net; sebastian.hesselbarth@gmail.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; thomas.petazzoni@bootlin.com; maxime.chevallier@bootlin.com; miquel.raynal@bootlin.com; Nadav Haklai <nadavh@marvell.com>; Yan Markman <ymarkman@marvell.com>; mw@semihalf.com; linux-arm-kernel@lists.infradead.org
> Subject: RE: [EXT] Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR interface to use in-band negotiation
> 
> > > > There is no inband negotiation like there is with 802.3z or SGMII, 
> > > > so this makes no sense.
> > >
> > > Oh, that's what I feared. I read some docs but probably will need 
> > > more
> > > :)
> > >
> > > Anyway, the reason to use in-band negotiation was also to avoid 
> > > using fixed-link. It would work but always report the link is up, 
> > > which for the user isn't a great experience as we have a way to detect this.
> > >
> > > What would you suggest to achieve this in a reasonable way?
> > 
> > The intention of this test in phylink_of_phy_connect() is to avoid 
> > failing when there is no requirement for a PHY to be present (such as 
> > a fixed link, or an 802.3z link.)  However, with 10G PHYs such as the 
> > 3310, we need the PHY so we can read the speed from it, and so know 
> > whether to downgrade the MAC to SGMII mode, or having downgraded the 
> > MAC, upgrade it back to 10G mode when the PHY switches to 10G.
> > 
> > I'm guessing that you're wanting this for the DB boards, but I don't see why.
> > Do they not have PHYs?
> 
> New Solid Run board MACCHIATObin Single Shot doesn't has  3310 PHY either, like DB boards.
> https://www.cnx-software.com/2017/12/20/solidrun-macchiatobin-single-shot-networking-board-launched-for-269-and-up/

Correct, but this DTS is wrong.  It connects to a SFP cage, and as SFP
cages are supported in mainline now, there's no need to mess around
with fixed links or similar.

I haven't tested phylink in that configuration yet as SolidRun haven't
sent me a SingleShot board yet - and I need any board I do get to have
the pull-up resistors on the I2C lines of the correct value, because
I'm not risking corruption of the EEPROMs in my SFP* modules.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
