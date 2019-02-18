Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4FCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914A12184E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbfBRIca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:32:30 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:43249 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbfBRIc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:32:29 -0500
X-Originating-IP: 90.88.30.68
Received: from aptenodytes (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 1DE9340005;
        Mon, 18 Feb 2019 08:32:23 +0000 (UTC)
Message-ID: <c80ee02db4a22d15a24281384ae561462593684f.camel@bootlin.com>
Subject: Re: [PATCH v3] usb: chipidea: Grab the (legacy) USB PHY by phandle
 first
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Peter Chen <peter.chen@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Mon, 18 Feb 2019 09:32:23 +0100
In-Reply-To: <VI1PR04MB53274C03CD18C3D3ADB767408B630@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20190215162225.19284-1-paul.kocialkowski@bootlin.com>
         <VI1PR04MB53274C03CD18C3D3ADB767408B630@VI1PR04MB5327.eurprd04.prod.outlook.com>
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

On Mon, 2019-02-18 at 03:04 +0000, Peter Chen wrote:
> > According to the chipidea driver bindings, the USB PHY is specified via the "phys"
> > phandle node. However, this only takes effect for USB PHYs that use the common
> > PHY framework. For legacy USB PHYs, a simple lookup based on the USB PHY
> > type is done instead.
> > 
> > This does not play out well when more than one USB PHY is registered, since the
> > first registered PHY matching the type will always be returned regardless of what
> > the driver was bound to.
> > 
> > Fix this by looking up the PHY based on the "phys" phandle node.
> > Although generic PHYs are rather matched by their "phys-name" and not the "phys"
> > phandle directly, there is no helper for similar lookup on legacy PHYs and it's
> > probably not worth the effort to add it.
> > 
> > When no legacy USB PHY is found by phandle, fallback to grabbing any registered
> > USB2 PHY. This ensures backward compatibility if some users were actually relying
> > on this mechanism.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> > Changes since v2:
> > * Fixed typos in commit message.
> > 
> > Changes since v1:
> > * Only consider legacy USB PHY error for fallback as suggested;
> > * Checked against EPROBE_DEFER before entering fallback.
> > 
> >  drivers/usb/chipidea/core.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c index
> > 7bfcbb23c2a4..016e4004fe9d 100644
> > --- a/drivers/usb/chipidea/core.c
> > +++ b/drivers/usb/chipidea/core.c
> > @@ -954,8 +954,15 @@ static int ci_hdrc_probe(struct platform_device *pdev)
> >  	} else if (ci->platdata->usb_phy) {
> >  		ci->usb_phy = ci->platdata->usb_phy;
> >  	} else {
> > +		ci->usb_phy = devm_usb_get_phy_by_phandle(dev->parent, "phys",
> > +							  0);
> >  		ci->phy = devm_phy_get(dev->parent, "usb-phy");
> > -		ci->usb_phy = devm_usb_get_phy(dev->parent,
> > USB_PHY_TYPE_USB2);
> > +
> > +		/* Fallback to grabbing any registered USB2 PHY */
> > +		if (IS_ERR(ci->usb_phy) &&
> > +		    PTR_ERR(ci->usb_phy) != -EPROBE_DEFER)
> > +			ci->usb_phy = devm_usb_get_phy(dev->parent,
> > +						       USB_PHY_TYPE_USB2);
> > 
> 
> I think you may need to do above if ci->phy is error, and not the error is -EPROBE_DEFER.

As Thomas pointed out during the review of v1, the initial flow is to
try and get both ci->usb_phy and ci->phy and let the code use ci->phy
in priority later.

This change attempts to keep this flow intact. The EPROBE_DEFER check
is in case the initial ci->usb_phy is valid but deferred: we don't want
to overwrite it by calling devm_usb_get_phy which might return an
actual error and result in losing the EPROBE_DEFER information.

Does that make sense to you?

Cheers,

Paul

> Peter
> 
> >  		/* if both generic PHY and USB PHY layers aren't enabled */
> >  		if (PTR_ERR(ci->phy) == -ENOSYS &&
> > --
> > 2.20.1
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

