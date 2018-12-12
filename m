Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B571AC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B3620839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B3620839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeLLJav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:30:51 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55158 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbeLLJav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:30:51 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9536F2082C; Wed, 12 Dec 2018 10:30:48 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5EC9520731;
        Wed, 12 Dec 2018 10:30:38 +0100 (CET)
Date:   Wed, 12 Dec 2018 10:30:33 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net] net: mvpp2: 10G modes aren't supported on all ports
Message-ID: <20181212093033.GA3219@kwain>
References: <20181211163228.26130-1-antoine.tenart@bootlin.com>
 <20181211163635.GG30658@n2100.armlinux.org.uk>
 <877egg6jbt.fsf@tkos.co.il>
 <20181211185156.GH30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181211185156.GH30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell, Baruch,

On Tue, Dec 11, 2018 at 06:51:56PM +0000, Russell King - ARM Linux wrote:
> On Tue, Dec 11, 2018 at 07:53:42PM +0200, Baruch Siach wrote:
> > That is, something like this, right?
> > 
> > diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > index 125ea99418df..04cb0241ca2b 100644
> > --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > @@ -4404,13 +4404,18 @@ static void mvpp2_phylink_validate(struct net_device *dev,
> >  	switch (state->interface) {
> >  	case PHY_INTERFACE_MODE_10GKR:
> >  	case PHY_INTERFACE_MODE_XAUI:
> > +		if (port->gop_id != 0)
> > +			goto empty_set;
> > +		/* Fall-through */
> >  	case PHY_INTERFACE_MODE_NA:
> > -		phylink_set(mask, 10000baseCR_Full);
> > -		phylink_set(mask, 10000baseSR_Full);
> > -		phylink_set(mask, 10000baseLR_Full);
> > -		phylink_set(mask, 10000baseLRM_Full);
> > -		phylink_set(mask, 10000baseER_Full);
> > -		phylink_set(mask, 10000baseKR_Full);
> > +		if (port->gop_id == 0) {
> > +			phylink_set(mask, 10000baseCR_Full);
> > +			phylink_set(mask, 10000baseSR_Full);
> > +			phylink_set(mask, 10000baseLR_Full);
> > +			phylink_set(mask, 10000baseLRM_Full);
> > +			phylink_set(mask, 10000baseER_Full);
> > +			phylink_set(mask, 10000baseKR_Full);
> > +		}
> >  		/* Fall-through */
> >  	case PHY_INTERFACE_MODE_RGMII:
> >  	case PHY_INTERFACE_MODE_RGMII_ID:
> > 
> 
> Yep, looks fine to me, thanks.

This looks good, thanks! I'll send a v2.

Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
