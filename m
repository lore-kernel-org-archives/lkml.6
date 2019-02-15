Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B30C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD683222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfBOQ3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:29:33 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:51643 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfBOQ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:29:33 -0500
Received: from aptenodytes (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 8C269200009;
        Fri, 15 Feb 2019 16:29:29 +0000 (UTC)
Message-ID: <e8928afbb43cc8fffbb9b9034b2a94907fef596d.camel@bootlin.com>
Subject: Re: [PATCH] net: phy: xgmiitorgmii: Support generic PHY status read
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Fri, 15 Feb 2019 17:29:29 +0100
In-Reply-To: <20190215162344.GQ708@lunn.ch>
References: <20190215161708.18645-1-paul.kocialkowski@bootlin.com>
         <20190215162344.GQ708@lunn.ch>
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

On Fri, 2019-02-15 at 17:23 +0100, Andrew Lunn wrote:
> On Fri, Feb 15, 2019 at 05:17:08PM +0100, Paul Kocialkowski wrote:
> > Some PHY drivers like the generic one do not provide a read_status
> > callback on their own but rely on genphy_read_status being called
> > directly.
> > 
> > With the current code, this results in a NULL function pointer call.
> > Call genphy_read_status instead when there is no specific callback.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/net/phy/xilinx_gmii2rgmii.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
> > index 74a8782313cf..bd6084e315de 100644
> > --- a/drivers/net/phy/xilinx_gmii2rgmii.c
> > +++ b/drivers/net/phy/xilinx_gmii2rgmii.c
> > @@ -44,7 +44,10 @@ static int xgmiitorgmii_read_status(struct phy_device *phydev)
> >  	u16 val = 0;
> >  	int err;
> >  
> > -	err = priv->phy_drv->read_status(phydev);
> 
> Hi Paul
> 
> How about using phy_read_status()?

Thanks fo rthe suggestion! Though I don't that would work here since
our priv->phy_drv != phydev->drv, so it looks like we need to be
breaking it down in the driver.

I suppose this driver is a bit unusual since it represents a GMII to
RGMII bridge, so it's not actually a PHY driver on its own -- it just
sticks itself in between the actual PHY and the MAC.

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

