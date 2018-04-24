Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbeDXSCE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:02:04 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:39114 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbeDXSCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:02:00 -0400
Date: Tue, 24 Apr 2018 20:01:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: allow scanning busses with missing phys
Message-ID: <20180424180153.GD2360@lunn.ch>
References: <20180424160904.32457-1-alexandre.belloni@bootlin.com>
 <2833f30a-cf95-e5c7-e44f-218929e61024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2833f30a-cf95-e5c7-e44f-218929e61024@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 09:37:09AM -0700, Florian Fainelli wrote:
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

Hi Florian

Seems a bit odd have the driver do this, when the core could.

> My only concern with your change is that we are having a special
> treatment for EIO and ENODEV, so we must make sure MDIO bus drivers are
> all conforming to that.
 
I don't see how it could be a problem. It used to be any error was a
real error, and would stop the bus from loading. It now means there is
nothing there. The only possible side effect is an mdio bus driver
might remain loaded without any devices if all reads return
ENODEV/EIO, were as before it would probably never load. 

	    Andrew
