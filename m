Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8AAC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360F42086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360F42086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeLLOhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:37:02 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:50329 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbeLLOhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:37:01 -0500
Received: from sapphire.tkos.co.il (unknown [10.0.4.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 702214400D0;
        Wed, 12 Dec 2018 16:36:58 +0200 (IST)
Date:   Wed, 12 Dec 2018 16:36:57 +0200
From:   Baruch Siach <baruch@tkos.co.il>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net] net: mvpp2: 10G modes aren't supported on all ports
Message-ID: <20181212143657.irf7tt27mpshfhpz@sapphire.tkos.co.il>
References: <20181211163228.26130-1-antoine.tenart@bootlin.com>
 <20181211163635.GG30658@n2100.armlinux.org.uk>
 <877egg6jbt.fsf@tkos.co.il>
 <20181211185156.GH30658@n2100.armlinux.org.uk>
 <20181212093033.GA3219@kwain>
 <20181212141451.GC3219@kwain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212141451.GC3219@kwain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Antoine,

On Wed, Dec 12, 2018 at 03:14:51PM +0100, Antoine Tenart wrote:
> On Wed, Dec 12, 2018 at 10:30:33AM +0100, Antoine Tenart wrote:
> > On Tue, Dec 11, 2018 at 06:51:56PM +0000, Russell King - ARM Linux wrote:
> > > On Tue, Dec 11, 2018 at 07:53:42PM +0200, Baruch Siach wrote:
> > > > That is, something like this, right?
> > > > 
> > > > diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > > index 125ea99418df..04cb0241ca2b 100644
> > > > --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > > +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > > @@ -4404,13 +4404,18 @@ static void mvpp2_phylink_validate(struct net_device *dev,
> > > >  	switch (state->interface) {
> > > >  	case PHY_INTERFACE_MODE_10GKR:
> > > >  	case PHY_INTERFACE_MODE_XAUI:
> > > > +		if (port->gop_id != 0)
> > > > +			goto empty_set;
> > > > +		/* Fall-through */
> > > >  	case PHY_INTERFACE_MODE_NA:
> > > > -		phylink_set(mask, 10000baseCR_Full);
> > > > -		phylink_set(mask, 10000baseSR_Full);
> > > > -		phylink_set(mask, 10000baseLR_Full);
> > > > -		phylink_set(mask, 10000baseLRM_Full);
> > > > -		phylink_set(mask, 10000baseER_Full);
> > > > -		phylink_set(mask, 10000baseKR_Full);
> > > > +		if (port->gop_id == 0) {
> > > > +			phylink_set(mask, 10000baseCR_Full);
> > > > +			phylink_set(mask, 10000baseSR_Full);
> > > > +			phylink_set(mask, 10000baseLR_Full);
> > > > +			phylink_set(mask, 10000baseLRM_Full);
> > > > +			phylink_set(mask, 10000baseER_Full);
> > > > +			phylink_set(mask, 10000baseKR_Full);
> > > > +		}
> > > >  		/* Fall-through */
> > > >  	case PHY_INTERFACE_MODE_RGMII:
> > > >  	case PHY_INTERFACE_MODE_RGMII_ID:
> > > > 
> > > 
> > > Yep, looks fine to me, thanks.
> > 
> > This looks good, thanks! I'll send a v2.
> 
> Well, I just got back to this, and looking at the beginning of the
> validate function invalid modes are already checked. So we do already
> have:
> 
>         case PHY_INTERFACE_MODE_10GKR:
>         case PHY_INTERFACE_MODE_XAUI:
>                 if (port->gop_id != 0)
>                         goto empty_set;
>                 break;
> 
> So it turns out the fix can be applied as-is.

Right. I should have known that. Thanks for the fix.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
