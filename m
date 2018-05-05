Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeEERsy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 13:48:54 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50246 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751206AbeEERsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 13:48:52 -0400
Date: Sat, 5 May 2018 19:48:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net,
        kishon@ti.com, linux@armlinux.org.uk, gregory.clement@bootlin.com,
        jason@lakedaemon.net, sebastian.hesselbarth@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 02/13] net: phy: sfp: handle non-wired SFP
 connectors
Message-ID: <20180505174839.GB30439@lunn.ch>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
 <20180504135643.23466-3-antoine.tenart@bootlin.com>
 <e338472c-1f26-e49b-9a2d-7942e6ed4288@gmail.com>
 <20180504172337.GC13899@kwain>
 <20180505173945.0754d0df@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505173945.0754d0df@windsurf>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 05:39:45PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Fri, 4 May 2018 19:23:37 +0200, Antoine Tenart wrote:
> 
> > On Fri, May 04, 2018 at 10:04:48AM -0700, Florian Fainelli wrote:
> > > On 05/04/2018 06:56 AM, Antoine Tenart wrote:  
> > > > SFP connectors can be solder on a board without having any of their pins
> > > > (LOS, i2c...) wired. In such cases the SFP link state cannot be guessed,
> > > > and the overall link status reporting is left to other layers.
> > > > 
> > > > In order to achieve this, a new SFP_DEV status is added, named UNKNOWN.
> > > > This mode is set when it is not possible for the SFP code to get the
> > > > link status and as a result the link status is reported to be always UP
> > > > from the SFP point of view.  
> > > 
> > > Why represent the SFP in Device Tree then? Why not just declare this is
> > > a fixed link which would avoid having to introduce this "unknown" state.  
> > 
> > The other solution would have been to represent this as a fixed-link.
> > But such a representation would report the link as being up all the
> > time, which is something we wanted to avoid as the GoP in PPv2 can
> > report some link status. This is achieved using SFP+phylink+PPv2.
> > 
> > And representing the SFP cage in the device tree, although it's a
> > "dummy" one, helps describing the hardware.
> 
> Just to add to this: the board physically has a SFP cage, and a cable
> can be connected to it, or not. So it is absolutely not a fixed link
> (cable can be connected or not) and it really is a SFP cage.

Hi Thomas

What i have heard on the rumour mill is that the hardware design is
FUBAR. The i2c-mux and i2c-gpio expanders are using the same
addresses. Or something like that. So the data plane from the MAC to
the SFP works. But the control plane is broken.

I don't really have a problem listing an SFP in device tree. As you
say, it physically exists on the boards. But because of the FUBAR
hardware, it cannot be controlled. phylink is all about the control
plane, and there is no control plane for this hardware. So connecting
this sfp to phylink seems very wrong. When we have no control plain,
we use a fixed-link.

Isn't this hardware a reference design? It is not a real product.  If
it is an RDK, i'm sure Marvell are telling people it is FUBAR, don't
copy it. There will be a new RDK sometime which has the problems
fixed. So how much effort should we put into supporting a broken RDK,
which nobody will copy into a real product? To me, KISS is the right
approach and document it in the device tree what the issue is.

If a real product comes to market which is equally FUBAR, we can then
consider how to get the best out of the hardware. We can extend
phylink to support a fixed link PHY, but still ask the MAC about its
link status.

	 Andrew
