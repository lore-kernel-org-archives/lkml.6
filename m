Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D829C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DB0206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390123AbfBOSem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:34:42 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:44321 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388116AbfBOSef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:34:35 -0500
X-Originating-IP: 77.128.107.220
Received: from aptenodytes (220.107.128.77.rev.sfr.net [77.128.107.220])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id AB420C0006;
        Fri, 15 Feb 2019 18:34:28 +0000 (UTC)
Message-ID: <38f6708476e9beca4583ccc2a62e238a4981b735.camel@bootlin.com>
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
Date:   Fri, 15 Feb 2019 19:34:28 +0100
In-Reply-To: <387ed483-b205-beda-319d-6f2b8ea55601@gmail.com>
References: <20190215163220.20041-1-paul.kocialkowski@bootlin.com>
         <387ed483-b205-beda-319d-6f2b8ea55601@gmail.com>
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

On Fri, 2019-02-15 at 09:38 -0800, Florian Fainelli wrote:
> On 2/15/19 8:32 AM, Paul Kocialkowski wrote:
> > Some PHY drivers like the generic one do not provide a read_status
> > callback on their own but rely on genphy_read_status being called
> > directly.
> > 
> > With the current code, this results in a NULL function pointer call.
> > Call genphy_read_status instead when there is no specific callback.
> > 
> > Fixes: f411a6160bd4 ("net: phy: Add gmiitorgmii converter support")
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> > Added Fixes tag and net label for resend.
> 
> You would want to use phy_read_status() which encapsulates that check as
> well as checks that the phy_drv pointer is not NULL.

Well, this driver is a bit different and our priv->phy_drv != phydev-
>drv, so we can't use the helper directly. I should probably have
mentionned it in the commit message, sorry!

As I was mentionning to Andrew in the initial submission of this patch,
this driver is a bit unusual since it represents a GMII to RGMII
bridge, so it's not actually a PHY driver on its own -- it just sticks
itself in between the actual PHY and the MAC.

Cheers and thanks for the review,

Paul

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
> > +	if (priv->phy_drv->read_status)
> > +		err = priv->phy_drv->read_status(phydev);
> > +	else
> > +		err = genphy_read_status(phydev);
> >  	if (err < 0)
> >  		return err;
> >  
> > 
> 
> 
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

