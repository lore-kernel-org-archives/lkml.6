Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeCWVZZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 17:25:25 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40658 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751471AbeCWVZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 17:25:23 -0400
Date: Fri, 23 Mar 2018 22:25:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH net-next 5/8] net: mscc: Add initial Ocelot switch support
Message-ID: <20180323212516.GU24361@lunn.ch>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-6-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323201117.8416-6-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre

> +static int ocelot_port_bridge_join(struct ocelot_port *ocelot_port,
> +				   struct net_device *bridge)
> +{
> +	struct ocelot *ocelot = ocelot_port->ocelot;
> +
> +	if (!ocelot->bridge_mask) {
> +		ocelot->hw_bridge_dev = bridge;
> +	} else {
> +		if (ocelot->hw_bridge_dev != bridge)
> +			return -ENODEV; //TODO: do something clever here
> +	}
> +
> +	ocelot->bridge_mask |= BIT(ocelot_port->chip_port);
> +
> +	return 0;
> +}

I could be missing something here, but this looks way too simple.

By default, you have individual ports. They can just forward frames
between the host CPU and the port. There is no port-to-port traffic
allowed.

You then create a bridge, and add ports to the bridge. When you add a
port, you need to program the hardware that it can now forward frames
from this port to other parts in the same bridge. You also need to
tell other parts in the same bridge it can forward frames to it.  You
might also need to tell the port which forwarding database it should
use, since each bridge might have its own.

     Andrew
