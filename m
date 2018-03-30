Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbeC3Mpw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 08:45:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38166 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751252AbeC3Mpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 08:45:50 -0400
Date: Fri, 30 Mar 2018 14:45:37 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH net-next 5/8] net: mscc: Add initial Ocelot switch support
Message-ID: <20180330124537.GC14180@piout.net>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-6-alexandre.belloni@bootlin.com>
 <1df0a932-f7c1-f1b5-9a35-3c16d0c551e5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1df0a932-f7c1-f1b5-9a35-3c16d0c551e5@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2018 at 14:41:25 -0700, Florian Fainelli wrote:
> On 03/23/2018 01:11 PM, Alexandre Belloni wrote:
> > Add a driver for Microsemi Ocelot Ethernet switch support.
> > 
> > This makes two modules:
> > mscc_ocelot_common handles all the common features that doesn't depend on
> > how the switch is integrated in the SoC. Currently, it handles offloading
> > bridging to the hardware. ocelot_io.c handles register accesses. This is
> > unfortunately needed because the register layout is packed and then depends
> > on the number of ports available on the switch. The register definition
> > files are automatically generated.
> > 
> > ocelot_board handles the switch integration on the SoC and on the board.
> > 
> > Frame injection and extraction to/from the CPU port is currently done using
> > register accesses which is quite slow. DMA is possible but the port is not
> > able to absorb the whole switch bandwidth.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Random drive by comments because this is quite a number of lines to review!
> 
> Overall, looks quite good for a first version. Out of curiosity, is
> there a particular switch test you ran this driver against? LNST?
> 

We have a really small custom test suite.

> > +	/* Add dummy CRC */
> > +	ocelot_write_rix(ocelot, 0, QS_INJ_WR, grp);
> > +	skb_tx_timestamp(skb);
> > +
> > +	dev->stats.tx_packets++;
> > +	dev->stats.tx_bytes += skb->len;
> > +	dev_kfree_skb_any(skb);
> 
> No interrupt to indicate transmit completion?
> 

No, unfortunately, the TX interrupts only indicates there is room to
start injecting frames, not that they have been transmitted.

> 
> > +static int ocelot_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
> > +			  struct net_device *dev, const unsigned char *addr,
> > +			  u16 vid, u16 flags)
> > +{
> > +	struct ocelot_port *port = netdev_priv(dev);
> > +	struct ocelot *ocelot = port->ocelot;
> > +
> > +	if (!vid) {
> > +		if (!port->vlan_aware)
> > +			/* If the bridge is not VLAN aware and no VID was
> > +			 * provided, set it to 1 as bridges have a default VID
> > +			 * of 1. Otherwise the MAC entry wouldn't match incoming
> > +			 * packets as the VID would differ (0 != 1).
> > +			 */
> > +			vid = 1;
> > +		else
> > +			/* If the bridge is VLAN aware a VID must be provided as
> > +			 * otherwise the learnt entry wouldn't match any frame.
> > +			 */
> > +			return -EINVAL;
> > +	}
> 
> So if we are targeting vid = 0 we end-up with vid = 1 possibly?
> 

I've removed that part that is not needed for now and will rework when
sending VLAN support.

> > +	ocelot_write_gix(ocelot, port_cfg, ANA_PORT_PORT_CFG,
> > +			 ocelot_port->chip_port);
> > +
> > +	/* Apply FWD mask. The loop is needed to add/remove the current port as
> > +	 * a source for the other ports.
> > +	 */
> > +	for (port = 0; port < ocelot->num_phys_ports; port++) {
> > +		if (ocelot->bridge_fwd_mask & BIT(port)) {
> > +			unsigned long mask = ocelot->bridge_fwd_mask & ~BIT(port);
> > +
> > +			for (i = 0; i < ocelot->num_phys_ports; i++) {
> > +				unsigned long bond_mask = ocelot->lags[i];
> > +
> > +				if (!bond_mask)
> > +					continue;
> > +
> > +				if (bond_mask & BIT(port)) {
> > +					mask &= ~bond_mask;
> > +					break;
> > +				}
> > +			}
> > +
> > +			ocelot_write_rix(ocelot,
> > +					 BIT(ocelot->num_phys_ports) | mask,
> > +					 ANA_PGID_PGID, PGID_SRC + port);
> > +		} else {
> > +			/* Only the CPU port, this is compatible with link
> > +			 * aggregation.
> > +			 */
> > +			ocelot_write_rix(ocelot,
> > +					 BIT(ocelot->num_phys_ports),
> > +					 ANA_PGID_PGID, PGID_SRC + port);
> > +		}
> 
> All of this sounds like it should be moved into the br_join/leave, this
> does not appear to be the right place to do that.
> 

No, I've triple checked because this is a comment that both Andrew and
you had. Once a port is added to the PGID MASK, it will start forwarding
frames so we really want that to happen only when the port is in
BR_STATE_FORWARDING state. Else, we may forward frames between the
addition of the port to the bridge and setting the port to the
BR_STATE_BLOCKING state.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
