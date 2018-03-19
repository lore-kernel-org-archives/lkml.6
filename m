Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933435AbeCSNme (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:42:34 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40994 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932989AbeCSNma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:42:30 -0400
Date: Mon, 19 Mar 2018 13:42:10 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Stefan Chulski <stefanc@marvell.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kishon@ti.com" <kishon@ti.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, Yan Markman <ymarkman@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR
 interface to use in-band negotiation
Message-ID: <20180319134210.GA26979@n2100.armlinux.org.uk>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
 <20180316155307.GQ9418@n2100.armlinux.org.uk>
 <20180319085252.GF4519@kwain>
 <20180319111205.GB2743@n2100.armlinux.org.uk>
 <20180319125227.GI4519@kwain>
 <20180319125953.GD19795@lunn.ch>
 <54e290a192734831b5db22191f056a81@IL-EXCH01.marvell.com>
 <20180319130823.GA22306@lunn.ch>
 <02614799e30f4823a97fca0e9f29b14b@IL-EXCH01.marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02614799e30f4823a97fca0e9f29b14b@IL-EXCH01.marvell.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 01:19:24PM +0000, Stefan Chulski wrote:
> 
> 
> > -----Original Message-----
> > From: Andrew Lunn [mailto:andrew@lunn.ch]
> > Sent: Monday, March 19, 2018 3:08 PM
> > To: Stefan Chulski <stefanc@marvell.com>
> > Cc: Antoine Tenart <antoine.tenart@bootlin.com>; Russell King - ARM Linux
> > <linux@armlinux.org.uk>; davem@davemloft.net; kishon@ti.com;
> > gregory.clement@bootlin.com; jason@lakedaemon.net;
> > sebastian.hesselbarth@gmail.com; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org; thomas.petazzoni@bootlin.com;
> > maxime.chevallier@bootlin.com; miquel.raynal@bootlin.com; Nadav Haklai
> > <nadavh@marvell.com>; Yan Markman <ymarkman@marvell.com>;
> > mw@semihalf.com; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [EXT] Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR
> > interface to use in-band negotiation
> > 
> > > > If they don't have PHYs, how are the connected to the outside world?
> > > >
> > > >    Andrew
> > >
> > > By external SFP or direct attached cable.
> > 
> > Maybe i'm missing something, but don't you just need to add an SFP device
> > in the device tree. The SFP code and PHYLINK will work together, query what
> > the SFP module is, use the GPIOs to determine link up/down and module
> > present, and tell the MAC how to configure the MAC-SFP link?
> > 
> >      Andrew
> 
> phylink pool SFP loss signal to determine link up/down?

No.  Phylink was merged along with SFP cage support, which includes a DT
description for SFP cages, including the various signals for the cage.

The SFP layer will take care of monitoring the cage and conveying state
information to Phylink.

Phylink's job is to work out how any SFP module, PHY and MAC should be
configured and to determine the link state based on information supplied
by or requested from each depending on the configured state.

Please do not try and support SFP cages as fixed links.  They aren't,
and such an approach will always have sub-standard link state monitoring.

In an optical setup, the SFP LOS signal just indicates whether there is
sufficient optical power present at the receiver.  It doesn't indicate
whether there is a valid signal there, or whether the chip at the other
end of the serdes link can decode the signal.  That has to come from the
upstream chip, whether it be a PHY or a MAC.

SFP optical modules do not perform protocol validation - they merely
convert the serdes electrical signal into a light signal and back again,
with varying amounts of monitoring on board.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
