Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48C0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5542086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfBUKsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:48:41 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:55537 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfBUKsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:48:40 -0500
X-Originating-IP: 90.88.23.190
Received: from aptenodytes (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id DC1E9E0019;
        Thu, 21 Feb 2019 10:48:37 +0000 (UTC)
Message-ID: <9e2e22ea7c7a8974764d45f2f84c4f599f5aee61.camel@bootlin.com>
Subject: Re: [PATCH v3] usb: chipidea: Grab the (legacy) USB PHY by phandle
 first
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Peter Chen <peter.chen@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Thu, 21 Feb 2019 11:48:37 +0100
In-Reply-To: <VI1PR04MB5327CA438A1EAA5BB99E91188B7E0@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20190215162225.19284-1-paul.kocialkowski@bootlin.com>
         <VI1PR04MB53274C03CD18C3D3ADB767408B630@VI1PR04MB5327.eurprd04.prod.outlook.com>
         <c80ee02db4a22d15a24281384ae561462593684f.camel@bootlin.com>
         <VI1PR04MB53278AE9AB6C14DA2AB96F6A8B7E0@VI1PR04MB5327.eurprd04.prod.outlook.com>
         <3ed330798d31d01fdfbd40571d016a108c9c5040.camel@bootlin.com>
         <VI1PR04MB5327C5FCF2BCF404B78A2C6A8B7E0@VI1PR04MB5327.eurprd04.prod.outlook.com>
         <8fa473aee266f6fdd90c6b90661977982488cb77.camel@bootlin.com>
         <VI1PR04MB5327CA438A1EAA5BB99E91188B7E0@VI1PR04MB5327.eurprd04.prod.outlook.com>
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

On Thu, 2019-02-21 at 09:30 +0000, Peter Chen wrote:
>  
> > > Current code w/o your patch, it is possible both ci->phy and
> > > ci->usb_phy are valid if the USB PHY is not at the device tree, but generic PHY is
> > at the device tree.
> > > If you don't want to fix this issue with this patch, it is ok too. We could fix it later.
> > 
> > I'm not sure I understand the issue. With my patch, if there is a generic PHY
> > described in device-tree, then devm_usb_get_phy_by_phandle for legacy PHY will
> > fail and the code will fallback to devm_usb_get_phy, which is the same behavior as
> > before.
> > 
> 
> You are right, but this behavior is incorrect since each controller has only one physical
> USB PHY.
> 
> > Is it a problem that we can end up with both a generic and legacy PHY?
> > I thought this was expected behavior at probe, and the rest of the code will just use
> > the generic one in priority.
> > 
> > Do you want to make it so that only one (generic or legacy) PHY remains after
> > probe?
> > 
>  
> Yes, I just want only one valid, either ci->phy or ci->usb_phy, it makes sense.

Sounds good to me. I'll send out v4 with this patch and an extra one to
refactor the PHY selection path and only attempt to get a single PHY.

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

