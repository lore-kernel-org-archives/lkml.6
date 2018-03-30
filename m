Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbeC3Nyh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 09:54:37 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47308 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750794AbeC3Nyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 09:54:35 -0400
Date: Fri, 30 Mar 2018 15:54:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next 5/8] net: mscc: Add initial Ocelot switch support
Message-ID: <20180330135422.GA28244@lunn.ch>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-6-alexandre.belloni@bootlin.com>
 <1df0a932-f7c1-f1b5-9a35-3c16d0c551e5@gmail.com>
 <20180330124537.GC14180@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330124537.GC14180@piout.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > All of this sounds like it should be moved into the br_join/leave, this
> > does not appear to be the right place to do that.
> > 
> 
> No, I've triple checked because this is a comment that both Andrew and
> you had. Once a port is added to the PGID MASK, it will start forwarding
> frames so we really want that to happen only when the port is in
> BR_STATE_FORWARDING state. Else, we may forward frames between the
> addition of the port to the bridge and setting the port to the
> BR_STATE_BLOCKING state.

Hi Alexandre

Interesting observation. I took a look at some of the other join
implementations. mv88e6xxx does the join immediately. mt7539 does it
immediately, if the port is enabled. lan9303 does it immediately.
qca8k does it immediately. b53 does it immediately.

Either they all get it wrong, or we make the assumption the bridge
sets the STP state first, then has the port join the bridge.

Looking at the code, br_add_if() it calls
netdev_master_upper_dev_link() and then later

        if (netif_running(dev) && netif_oper_up(dev) &&
            (br->dev->flags & IFF_UP))
                br_stp_enable_port(p);

So it does look like there is a window of time between the port
joining and the STP state being set.

I know in the past, we have run into the opposite problem. A port
leaves the bridge, while in blocked state. The port should then
becomes an individual port, so the STP state needs setting to
forwarding. I don't remember where we fix this.

I don't like that this new driver is different, but it also looks like
we have a real problem here. More digging needed.

   Andrew
