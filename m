Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6C9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFEF20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404340AbfAPNam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:30:42 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59760 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404316AbfAPNal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:30:41 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BC394207AC; Wed, 16 Jan 2019 14:30:38 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8269320728;
        Wed, 16 Jan 2019 14:30:28 +0100 (CET)
Message-ID: <554a5b4f463df6551846cfdc3b043d3f1d99381f.camel@bootlin.com>
Subject: Re: [PATCH] usb: chipidea: Grab the (legacy) USB PHY by phandle
 first
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed, 16 Jan 2019 14:30:28 +0100
In-Reply-To: <20190116115350.3daa9b4f@windsurf>
References: <20190116101051.21202-1-paul.kocialkowski@bootlin.com>
         <20190116115350.3daa9b4f@windsurf>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2019-01-16 at 11:53 +0100, Thomas Petazzoni wrote:
> Hello,
> 
> Thanks for the patch!

And thanks for the review!

> On Wed, 16 Jan 2019 11:10:51 +0100, Paul Kocialkowski wrote:
> > According to the chipidea driver bindings, the USB PHY is specified via
> > the "phys" phandle node. However, this only takes effect for USB PHYs
> > that use the common PHY framework. For legacy USB PHYs, a simple lookup
> > based on the USB PHY type is done instead.
> > 
> > This does not play out well when more than USB PHY is registered, since
> 
> "more than *one*"
> 
> > the first registered PHY matching the type will always be returned
> > regardless of what the driver was bound to.
> > 
> > Fix this by looking up the PHY based on the "phys" phandle node.
> > Although generic PHYS and rather matched by their "phys-name"
> 
> I'm confused by "Although generic PHYS and rather matched". Perhaps
> s/and/are/ ?
> 
> Also PHYS -> PHYs

Good catches, will be fixed in v2.

> > and not
> > the "phys" phandle directly, there is no helper for similar lookup on
> > legacy PHYs and it's probably not worth the effort to add it.
> > 
> > When no legacy USB PHY is found by phandle, fallback to grabbing any
> > registered USB2 PHY. This ensures backward compatibility if some users
> > were actually relying on this mechanism.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/usb/chipidea/core.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> > index 7bfcbb23c2a4..11d3ee1e3fe5 100644
> > --- a/drivers/usb/chipidea/core.c
> > +++ b/drivers/usb/chipidea/core.c
> > @@ -954,8 +954,14 @@ static int ci_hdrc_probe(struct platform_device *pdev)
> >  	} else if (ci->platdata->usb_phy) {
> >  		ci->usb_phy = ci->platdata->usb_phy;
> >  	} else {
> > +		ci->usb_phy = devm_usb_get_phy_by_phandle(dev->parent, "phys",
> > +							  0);
> >  		ci->phy = devm_phy_get(dev->parent, "usb-phy");
> > -		ci->usb_phy = devm_usb_get_phy(dev->parent, USB_PHY_TYPE_USB2);
> 
> I'm not sure why you change the order of legacy PHY lookup vs. generic
> PHY lookup.

You're right, there is no particular reason to do that.

> > +
> > +		/* Fallback to grabbing any registered USB2 PHY */
> > +		if (IS_ERR(ci->phy) && IS_ERR(ci->usb_phy))
> > +			ci->usb_phy = devm_usb_get_phy(dev->parent,
> > +						       USB_PHY_TYPE_USB2);
> 
> Why is this conditional on the generic PHY lookup failing?
> 
> Don't we simply want:
> 
> 	ci->phy = devm_phy_get(dev->parent, "usb-phy");
> 	ci->usb_phy = devm_usb_get_phy_by_phandle(dev->parent, "phys", 0);
> 	if (IS_ERR(ci->usb_phy))
> 		ci->usb_phy = devm_usb_get_phy(dev->parent, USB_PHY_TYPE_USB2);
> 
>  ?

Well, the code dealing with the PHY later on will use ci->phy over ci-
>usb_phy (so generic PHY API first). As a result, if the
devm_usb_get_phy_by_phandle lookup fails but we got a generic PHY, the
latter will be used and there is no need for a fallback. That's why I
put both conditions there. Maybe that's too much of an assumption?

> Does this needs a "Fixes:" tag ? It's not fixing a regression because
> nobody complained until now, but it's really fixing a behavior that
> wasn't correct.

Yes I it this makes sense to consider that this was incorrect behavior
starting from the moment the dt bindings were formalized for the
driver, which would be commit d7d30c911dd957e274c3da6910d4286862ab1d78.

Do you think that would nake sense?

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

