Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE44C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA03620851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfAQQiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:38:22 -0500
Received: from mail.bootlin.com ([62.4.15.54]:43756 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbfAQQiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:38:22 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A3C09209EF; Thu, 17 Jan 2019 17:38:19 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6F1C120994;
        Thu, 17 Jan 2019 17:38:09 +0100 (CET)
Message-ID: <1f8dcb9848a2da0eb87a0227913033d299d4e4a9.camel@bootlin.com>
Subject: Re: [PATCH] usb: chipidea: Grab the (legacy) USB PHY by phandle
 first
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Peter Chen <peter.chen@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Thu, 17 Jan 2019 17:38:09 +0100
In-Reply-To: <VI1PR04MB5327030D855A1FEBC9BC9E638B830@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20190116101051.21202-1-paul.kocialkowski@bootlin.com>
         <20190116115350.3daa9b4f@windsurf>
         <554a5b4f463df6551846cfdc3b043d3f1d99381f.camel@bootlin.com>
         <20190116144429.7df1d0c5@windsurf>
         <b42e37ab06ae3efa244a35df801e2126fd692bb7.camel@bootlin.com>
         <VI1PR04MB5327030D855A1FEBC9BC9E638B830@VI1PR04MB5327.eurprd04.prod.outlook.com>
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

On Thu, 2019-01-17 at 06:44 +0000, Peter Chen wrote:
>  
> > On Wed, 2019-01-16 at 14:44 +0100, Thomas Petazzoni wrote:
> > > Well prior to your code, there was already a possibility for both
> > > ci->phy and ci->usb_phy to be valid. I don't think it's really useful
> > > to avoid the fallback when a generic PHY has already been found, it's
> > > confusing. If really you want to clarify that, it should be:
> > > 
> > > 	/* Let's first try to find a generic PHY */
> > > 	ci->phy = devm_phy_get(dev->parent, "usb-phy");
> > > 	if (IS_ERR(ci->phy)) {
> 
> Please consider -EPROBE_DEFER case
> 
> > > 		/* Fall back to legacy USB PHY */
> > > 		ci->usb_phy = devm_usb_get_phy_by_phandle(dev->parent, "phys",
> > 0);
> 
> Please consider -EPROBE_DEFER case
> 
> > > 		if (IS_ERR(ci->usb_phy))
> > > 			ci->usb_phy = devm_usb_get_phy(dev->parent,
> > USB_PHY_TYPE_USB2);
> > > 	}
> > > 
> 
> Below code 
>                 if (IS_ERR(ci->phy) && IS_ERR(ci->usb_phy)) {
>                         ret = -EPROBE_DEFER;
>                         goto ulpi_exit;
>                 }    
> 
> needs to change as:
> 
>                 if (PTR_ERR(ci->phy) ==-EPROBE_DEFER  ||  PTR_ERR(ci->usb_phy) == -EPROBE_DEFER) {
>                         ret = -EPROBE_DEFER;
>                         goto ulpi_exit;
>                 }    

Well I think this was more of a general outline than proper code to be
included in the driver anyway :)

I'm rather considering implementing what Thomas suggested at first,
which is going for the fallback even if a generic PHY was found, as to
stick more closely to the existing behavior.

Cheers,

Paul

> Peter
> 
> > > With that, you would only have either ci->phy or ci->usb_phy be valid,
> > > and never both. With  your change, you can have ci->phy and
> > > ci->usb_phy both be valid if the legacy USB PHY was found using
> > > devm_usb_get_phy_by_phandle(), but not if we fell back to
> > > devm_usb_get_phy().
> > 
> > Okay that makes sense, your suggestion is indeed more consistent with the existing
> > behavior. I'll go with that in the next revision!
> > 
> 
> 
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

