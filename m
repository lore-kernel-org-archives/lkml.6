Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5CEC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935212087E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfA1OkZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:40:25 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:40624 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1OkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:40:25 -0500
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 735FD3A98E7;
        Mon, 28 Jan 2019 15:25:01 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id A2602200011;
        Mon, 28 Jan 2019 14:24:57 +0000 (UTC)
Date:   Mon, 28 Jan 2019 15:24:56 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: mv88e6xxx: Save switch rules
Message-ID: <20190128152456.212ae5ac@xps13>
In-Reply-To: <c1421a5d-5f92-bb86-b5cc-9fa19a1c8d9f@gmail.com>
References: <20190125095507.29334-1-miquel.raynal@bootlin.com>
 <20190125095507.29334-2-miquel.raynal@bootlin.com>
 <c1421a5d-5f92-bb86-b5cc-9fa19a1c8d9f@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Florian Fainelli <f.fainelli@gmail.com> wrote on Fri, 25 Jan 2019
10:37:38 -0800:

> Hi Miquel,
> 
> On 1/25/19 1:55 AM, Miquel Raynal wrote:
> > The user might apply a specific switch configuration, with specific
> > forwarding rules, VLAN, bridges, etc.
> > 
> > During suspend to RAM the switch power will be turned off and the
> > switch will lost its configuration. In an attempt to bring S2RAM
> > support to the mv88e6xxx DSA, let's first save these rules in a
> > per-chip list thanks to the mv88e6xxx_add/del_xxx_rule()
> > helpers. These helpers are then called from various callbacks:
> > * mv88e6xxx_port_fdb_add/del()
> > * mv88e6xxx_port_mdb_add/del()
> > * mv88e6xxx_port_vlan_add/del()
> > * mv88e6xxx_port_bridge_join/leave()
> > * mv88e6xxx_crosschip_bridge_join/leave()
> > 
> > To avoid recursion problems when replaying the rules, the content of
> > the above *_add()/*_join() callbacks has been moved in separate
> > helpers with a '_' prefix. Hence, each callback just calls the
> > corresponding helper and the corresponding *_add_xxx_rule().  
> 
> None of this should be done in the driver IMHO, because this is
> presumably applicable to all switch devices that lose their state during
> suspend/resume, so at best, this should be moved to the core DSA layer,
> but doing this means that we should also have a well established
> contract between the DSA layer and individual switch drivers as far as
> quiescing/saving/restoring state goes.
> 
> By moving things to the core we can also more tightly control what data
> structures get used to represent e.g.: VLANs, FDBs, MDBs etc and
> possibly push/utilize caching into the original subsystem. For instance
> VLAN/bridge already do maintain caches of VLANs, so if we could somehow
> expose those, we would not bloat the kernel's memory footprint by having
> an additional layer to maintain with identical information.

So you suggest to move the intelligence of FDBs/MDBs in net/dsa/port.c,
is this right?

I don't see where VLAN and bridge information are cached, can you point
me to the relevant locations?

What about cross-chip bridges? There is nothing about them in
net/dsa/port.c. The implementation I see in the mv88e6xxx driver
only touches the PVT but I don't get whether we should handle this
calls like regular bridge-join/leave events or not (maybe they are
cached with regular bridge events?).


Thanks,
Miquèl
