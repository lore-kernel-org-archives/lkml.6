Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbeC3OQs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 10:16:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39587 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751248AbeC3OQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 10:16:46 -0400
Date: Fri, 30 Mar 2018 16:16:34 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next 5/8] net: mscc: Add initial Ocelot switch support
Message-ID: <20180330141634.GD14180@piout.net>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-6-alexandre.belloni@bootlin.com>
 <1df0a932-f7c1-f1b5-9a35-3c16d0c551e5@gmail.com>
 <20180330124537.GC14180@piout.net>
 <20180330135422.GA28244@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330135422.GA28244@lunn.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2018 at 15:54:22 +0200, Andrew Lunn wrote:
> > > All of this sounds like it should be moved into the br_join/leave, this
> > > does not appear to be the right place to do that.
> > > 
> > 
> > No, I've triple checked because this is a comment that both Andrew and
> > you had. Once a port is added to the PGID MASK, it will start forwarding
> > frames so we really want that to happen only when the port is in
> > BR_STATE_FORWARDING state. Else, we may forward frames between the
> > addition of the port to the bridge and setting the port to the
> > BR_STATE_BLOCKING state.
> 
> Hi Alexandre
> 
> Interesting observation. I took a look at some of the other join
> implementations. mv88e6xxx does the join immediately. mt7539 does it
> immediately, if the port is enabled. lan9303 does it immediately.
> qca8k does it immediately. b53 does it immediately.
> 

I had a look at b53, my impression was that b53_br_join() adds the port
to the bridge but b53_br_set_stp_state() actually enables forwarding. So
as long as the default on the port is PORT_CTRL_DIS_STATE, the port will
not be forwarding frames. And this is the case because b53_enable_port()
does put 0 in B53_PORT_CTRL.

The fact is that ocelot doesn't have separate controls. The port is
either forwarding or not. If it is not forwarding, then there is nothing
to tell the HW to do.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
