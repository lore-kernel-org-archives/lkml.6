Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbeEQPCN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:02:13 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60334 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeEQPCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:02:11 -0400
Date: Thu, 17 May 2018 16:01:55 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 1/2] net: phy: sfp: make the i2c-bus property
 really optional
Message-ID: <20180517150155.GB17671@n2100.armlinux.org.uk>
References: <20180517082907.14420-1-antoine.tenart@bootlin.com>
 <20180517082907.14420-2-antoine.tenart@bootlin.com>
 <20180517124127.GG8547@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517124127.GG8547@lunn.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 02:41:28PM +0200, Andrew Lunn wrote:
> On Thu, May 17, 2018 at 10:29:06AM +0200, Antoine Tenart wrote:
> > The SFF,SFP documentation is clear about making all the DT properties,
> > with the exception of the compatible, optional. In practice this is not
> > the case and without an i2c-bus property provided the SFP code will
> > throw NULL pointer exceptions.
> > 
> > This patch is an attempt to fix this.
> 
> Hi Antoine, Russell
> 
> How usable is an SFF/SFP module without access to the i2c EEPROM? I
> guess this comes down to link speed. Can it be manually configured?

While we can support forcing the speed/duplex through ethtool, there
is no obvious facility via ethtool to set the protocol currently (eg,
SGMII vs 1000base-X).  There is, however, the possibility to use the
advertise mask to determine which mode we should be using, but that's
awkward to deal with via ethtool as ethtool wants a hex mask, which
really isn't user friendly.

The protocol matters - for example, a copper SFP module will typically
want to use SGMII, and if it encounters 1000base-X on the other side,
the PHY won't pass data because it will believe that the link to the
MAC is down.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
