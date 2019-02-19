Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F6EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD952146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfBSJ4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:56:22 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:32971 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfBSJ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:56:22 -0500
X-Originating-IP: 90.88.30.68
Received: from aptenodytes (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 34E9EC001D;
        Tue, 19 Feb 2019 09:56:11 +0000 (UTC)
Message-ID: <b0f700f85cd35bf26a97280f3bef7c4e87102d63.camel@bootlin.com>
Subject: Re: [PATCH RESEND net] net: phy: xgmiitorgmii: Support generic PHY
 status read
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Tue, 19 Feb 2019 10:56:10 +0100
In-Reply-To: <958bb823-3dc8-607f-3c38-3d902acb85a8@gmail.com>
References: <20190215163220.20041-1-paul.kocialkowski@bootlin.com>
         <387ed483-b205-beda-319d-6f2b8ea55601@gmail.com>
         <38f6708476e9beca4583ccc2a62e238a4981b735.camel@bootlin.com>
         <958bb823-3dc8-607f-3c38-3d902acb85a8@gmail.com>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2019-02-15 at 10:53 -0800, Florian Fainelli wrote:
> On 2/15/19 10:34 AM, Paul Kocialkowski wrote:
> > As I was mentionning to Andrew in the initial submission of this patch,
> > this driver is a bit unusual since it represents a GMII to RGMII
> > bridge, so it's not actually a PHY driver on its own -- it just sticks
> > itself in between the actual PHY and the MAC.
> 
> Yes, my bad, you should still consider checking priv->phy_drv though, if
> someone unbinds the PHY driver on either side, you are toast.

Thanks for the suggestion! So I had a closer look at that driver to try
and see what could go wrong and it looks like I found a few things
there.

First, we have:
> priv->phy_dev->priv = priv;

Which basically overwrites that target PHY driver's priv with the
gmii2rgmii driver's. It looks like most PHY drivers don't use their
priv data so much so it kind of works in practice. But that's still a
receipe for disaster. I don't really see an immediate easy fix for that
one.

It might help to do things the other way round and bind the gmii2rgmii
PHY to the MAC, which itself would bind the actual PHY. That way we can
just have the gmii2rgmii redirect all ops to the actual PHY, except for
read_status. Maybe there was a reason I'm not seeing for doing things
the way they are done now though?

Then, it looks like there is no way for the gmii2rgmii driver to know
whether the PHY driver is still alive. It gets a pointer to the initial
priv->phy_dev->drv and then overwrites it. So when the target driver is
removed, the pointer will still be alive. Perhaps the memory backing it
will have been freed too.

How realistic does this scneario sound? I guess there are not many
cases where the PHY driver will be unregistered once it was picked up
by the gmii2rgmii driver, but I'm pretty new to the subsystem.

Cheers,

Paul

> > > >  drivers/net/phy/xilinx_gmii2rgmii.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
> > > > index 74a8782313cf..bd6084e315de 100644
> > > > --- a/drivers/net/phy/xilinx_gmii2rgmii.c
> > > > +++ b/drivers/net/phy/xilinx_gmii2rgmii.c
> > > > @@ -44,7 +44,10 @@ static int xgmiitorgmii_read_status(struct phy_device *phydev)
> > > >  	u16 val = 0;
> > > >  	int err;
> > > >  
> > > > -	err = priv->phy_drv->read_status(phydev);
> > > > +	if (priv->phy_drv->read_status)
> > > > +		err = priv->phy_drv->read_status(phydev);
> > > > +	else
> > > > +		err = genphy_read_status(phydev);
> > > >  	if (err < 0)
> > > >  		return err;
> > > >  
> > > > 
> 
> 
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

