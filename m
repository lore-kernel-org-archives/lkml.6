Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8AAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412E9205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391266AbfAPOWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:22:42 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34804 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730649AbfAPOWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:22:42 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8C8492078F; Wed, 16 Jan 2019 15:22:40 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5B1FD20763;
        Wed, 16 Jan 2019 15:22:40 +0100 (CET)
Message-ID: <b42e37ab06ae3efa244a35df801e2126fd692bb7.camel@bootlin.com>
Subject: Re: [PATCH] usb: chipidea: Grab the (legacy) USB PHY by phandle
 first
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed, 16 Jan 2019 15:22:40 +0100
In-Reply-To: <20190116144429.7df1d0c5@windsurf>
References: <20190116101051.21202-1-paul.kocialkowski@bootlin.com>
         <20190116115350.3daa9b4f@windsurf>
         <554a5b4f463df6551846cfdc3b043d3f1d99381f.camel@bootlin.com>
         <20190116144429.7df1d0c5@windsurf>
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

On Wed, 2019-01-16 at 14:44 +0100, Thomas Petazzoni wrote:
> Well prior to your code, there was already a possibility for both
> ci->phy and ci->usb_phy to be valid. I don't think it's really useful
> to avoid the fallback when a generic PHY has already been found, it's
> confusing. If really you want to clarify that, it should be:
> 
> 	/* Let's first try to find a generic PHY */
> 	ci->phy = devm_phy_get(dev->parent, "usb-phy");
> 	if (IS_ERR(ci->phy)) {
> 		/* Fall back to legacy USB PHY */
> 		ci->usb_phy = devm_usb_get_phy_by_phandle(dev->parent, "phys", 0);
> 		if (IS_ERR(ci->usb_phy))
> 			ci->usb_phy = devm_usb_get_phy(dev->parent, USB_PHY_TYPE_USB2);
> 	}
> 
> With that, you would only have either ci->phy or ci->usb_phy be valid,
> and never both. With  your change, you can have ci->phy and ci->usb_phy
> both be valid if the legacy USB PHY was found using
> devm_usb_get_phy_by_phandle(), but not if we fell back to
> devm_usb_get_phy().

Okay that makes sense, your suggestion is indeed more consistent with
the existing behavior. I'll go with that in the next revision!

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

