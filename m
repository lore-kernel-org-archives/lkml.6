Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89884C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62440206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393295AbfAPNom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:44:42 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60094 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733175AbfAPNol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:44:41 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7519720955; Wed, 16 Jan 2019 14:44:39 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2D3A820728;
        Wed, 16 Jan 2019 14:44:29 +0100 (CET)
Date:   Wed, 16 Jan 2019 14:44:29 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] usb: chipidea: Grab the (legacy) USB PHY by phandle
 first
Message-ID: <20190116144429.7df1d0c5@windsurf>
In-Reply-To: <554a5b4f463df6551846cfdc3b043d3f1d99381f.camel@bootlin.com>
References: <20190116101051.21202-1-paul.kocialkowski@bootlin.com>
        <20190116115350.3daa9b4f@windsurf>
        <554a5b4f463df6551846cfdc3b043d3f1d99381f.camel@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 16 Jan 2019 14:30:28 +0100, Paul Kocialkowski wrote:

> > Why is this conditional on the generic PHY lookup failing?
> > 
> > Don't we simply want:
> > 
> > 	ci->phy = devm_phy_get(dev->parent, "usb-phy");
> > 	ci->usb_phy = devm_usb_get_phy_by_phandle(dev->parent, "phys", 0);
> > 	if (IS_ERR(ci->usb_phy))
> > 		ci->usb_phy = devm_usb_get_phy(dev->parent, USB_PHY_TYPE_USB2);
> > 
> >  ?  
> 
> Well, the code dealing with the PHY later on will use ci->phy over ci-
> >usb_phy (so generic PHY API first). As a result, if the  
> devm_usb_get_phy_by_phandle lookup fails but we got a generic PHY, the
> latter will be used and there is no need for a fallback. That's why I
> put both conditions there. Maybe that's too much of an assumption?

Well prior to your code, there was already a possibility for both
ci->phy and ci->usb_phy to be valid. I don't think it's really useful
to avoid the fallback when a generic PHY has already been found, it's
confusing. If really you want to clarify that, it should be:

	/* Let's first try to find a generic PHY */
	ci->phy = devm_phy_get(dev->parent, "usb-phy");
	if (IS_ERR(ci->phy)) {
		/* Fall back to legacy USB PHY */
		ci->usb_phy = devm_usb_get_phy_by_phandle(dev->parent, "phys", 0);
		if (IS_ERR(ci->usb_phy))
			ci->usb_phy = devm_usb_get_phy(dev->parent, USB_PHY_TYPE_USB2);
	}

With that, you would only have either ci->phy or ci->usb_phy be valid,
and never both. With  your change, you can have ci->phy and ci->usb_phy
both be valid if the legacy USB PHY was found using
devm_usb_get_phy_by_phandle(), but not if we fell back to
devm_usb_get_phy().

> > Does this needs a "Fixes:" tag ? It's not fixing a regression because
> > nobody complained until now, but it's really fixing a behavior that
> > wasn't correct.  
> 
> Yes I it this makes sense to consider that this was incorrect behavior
> starting from the moment the dt bindings were formalized for the
> driver, which would be commit d7d30c911dd957e274c3da6910d4286862ab1d78.
> 
> Do you think that would nake sense?

Up to the maintainer I'd say. I don't have any preference here.

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
