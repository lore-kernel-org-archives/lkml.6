Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083D3C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6AD20851
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6AD20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbeLBTfQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 14:35:16 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38209 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbeLBTfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 14:35:16 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9B05820787; Sun,  2 Dec 2018 20:35:11 +0100 (CET)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id A1C902071D;
        Sun,  2 Dec 2018 20:35:10 +0100 (CET)
Date:   Sun, 2 Dec 2018 20:35:09 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        linux-kernel@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/8] phy: mvebu-cp110-comphy: fix port check in
 ->xlate()
Message-ID: <20181202203509.21b067c4@xps13>
In-Reply-To: <20181130190031.GH30658@n2100.armlinux.org.uk>
References: <20181130144743.675-1-miquel.raynal@bootlin.com>
        <20181130144743.675-3-miquel.raynal@bootlin.com>
        <20181130190031.GH30658@n2100.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

Russell King - ARM Linux <linux@armlinux.org.uk> wrote on Fri, 30 Nov
2018 19:00:31 +0000:

> On Fri, Nov 30, 2018 at 03:47:37PM +0100, Miquel Raynal wrote:
> > So far the PHY ->xlate() callback was checking if the port was
> > "invalid" before continuing, meaning that the port has not been used
> > yet. This check is not correct as there is no opposite call to  
> > ->xlate() once the PHY is released by the user and the port will  
> > remain "valid" after the first phy_get()/phy_put() calls. Hence, if
> > this driver is built as a module, inserted, removed and inserted
> > again, the PHY will appear busy and the second probe will fail.
> > 
> > To fix this, just drop the faulty check and instead verify that the
> > port number is valid (ie. in the possible range).
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> > index 31b9a1c18345..a40b876ff214 100644
> > --- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> > +++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> > @@ -567,9 +567,9 @@ static struct phy *mvebu_comphy_xlate(struct device *dev,
> >  		return phy;
> >  
> >  	lane = phy_get_drvdata(phy);
> > -	if (lane->port >= 0)
> > -		return ERR_PTR(-EBUSY);
> >  	lane->port = args->args[0];
> > +	if (lane->port >= MVEBU_COMPHY_PORTS)
> > +		return ERR_PTR(-EINVAL);  
> 
> Shouldn't we validate args->args[0] before doing anything?
> 

I don't understand your point, there is a check on args->args[0] as
we check its value (through lane->port) right after. What do you
have in mind?


Thanks,
Miquèl
