Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbeEQPIp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:08:45 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60426 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbeEQPIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:08:44 -0400
Date: Thu, 17 May 2018 16:08:32 +0100
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
Message-ID: <20180517150832.GC17671@n2100.armlinux.org.uk>
References: <20180517082907.14420-1-antoine.tenart@bootlin.com>
 <20180517082907.14420-2-antoine.tenart@bootlin.com>
 <20180517124127.GG8547@lunn.ch>
 <20180517125648.GM32746@kwain>
 <20180517130406.GH8547@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517130406.GH8547@lunn.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 03:04:06PM +0200, Andrew Lunn wrote:
> On Thu, May 17, 2018 at 02:56:48PM +0200, Antoine Tenart wrote:
> > Hi Andrew,
> > 
> > On Thu, May 17, 2018 at 02:41:28PM +0200, Andrew Lunn wrote:
> > > On Thu, May 17, 2018 at 10:29:06AM +0200, Antoine Tenart wrote:
> > > > The SFF,SFP documentation is clear about making all the DT properties,
> > > > with the exception of the compatible, optional. In practice this is not
> > > > the case and without an i2c-bus property provided the SFP code will
> > > > throw NULL pointer exceptions.
> > > > 
> > > > This patch is an attempt to fix this.
> > > 
> > > How usable is an SFF/SFP module without access to the i2c EEPROM? I
> > > guess this comes down to link speed. Can it be manually configured?
> > >
> > > I'm just wondering if we want to make this mandatory? Fail the probe
> > > if it is not listed?
> > 
> > Yes, the other option would be to fail when probing a cage missing the
> > i2c description. I'd say a passive module can work without the i2c
> > EEPROM accessible as it does not need to be configured. I don't know
> > what would happen with active ones.
> 
> Hi Antoine
> 
> I was thinking about how it reads the bit rate from the EEPROM. From
> that it determines what mode the MAC could use, 1000-Base-X,
> 2500-Base-X, etc. Can you still configure this correctly via ethtool,
> if you don't have the bitrate information?

Determining the protocol is kind of guess work even with the EEPROM
available - see comments above sfp_parse_interface().

Without knowing the contents of the EEPROM, you can't even guess what
protocol should be used for a particular module.

For example, there are 10/100/1000 modules from one vendor that use an
88e1111, which are configured for SGMII on the MAC side.  There is
another variant of that module which has the same hardware, but the
88e1111 is programmed for 1G only mode, and uses 1000base-X on the MAC
side.  For both modules, the 88e1111 is accessible, the host side
protocol can be reconfigured and the manufacturer includes the 88e1111
register access instructions for doing so.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
