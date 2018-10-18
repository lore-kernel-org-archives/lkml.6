Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA21C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D752145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="N5CsdxVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D752145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbeJRV6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:58:16 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:37304 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbeJRV6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:58:15 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A7C301277;
        Thu, 18 Oct 2018 15:57:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539871025;
        bh=nnbw9qMDkR1XWxVnDfJPUAqqsNWys8mPKYrdph7FBAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N5CsdxVcPKDItg+1ARtDnlKQueOfvvWPj76+iw6YX5waz5BlyjmSQnjWxVKRndbxj
         9Ii61Z5a+C71rgZosNJU5Y3LYuqXyhNmu4krE+P3aX1myAeK6yGppja6TsKRIZXyBg
         8xEuW0PN1NZlXT1ivUmfCX8FEihnTet2fqkTr7tw=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, Dave Airlie <airlied@linux.ie>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 9/9] [DO NOT MERGE] drm/sun4i: rgb: Add 5% tolerance to dot clock frequency check
Date:   Thu, 18 Oct 2018 16:57:03 +0300
Message-ID: <18807799.FbuUgLpiEM@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181018121819.gmup3jd7ukj52rvx@flea>
References: <20181018073327.64942-1-icenowy@aosc.io> <1585874.9P5eR8PMbl@avalon> <20181018121819.gmup3jd7ukj52rvx@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Thursday, 18 October 2018 15:18:19 EEST Maxime Ripard wrote:
> On Thu, Oct 18, 2018 at 02:31:01PM +0300, Laurent Pinchart wrote:
> > On Thursday, 18 October 2018 12:42:58 EEST Maxime Ripard wrote:
> >> On Thu, Oct 18, 2018 at 11:18:06AM +0200, Daniel Vetter wrote:
> >>> On Thu, Oct 18, 2018 at 10:55 AM Laurent Pinchart wrote:
> >>>> On Thursday, 18 October 2018 10:33:27 EEST Icenowy Zheng wrote:
> >>>>> From: Chen-Yu Tsai <wens@csie.org>
> >>>>> 
> >>>>> The panels shipped with Allwinner devices are very "generic", i.e.
> >>>>> they do not have model numbers or reliable sources of information
> >>>>> for the timings (that we know of) other than the fex files shipped
> >>>>> on them. The dot clock frequency provided in the fex files have all
> >>>>> been rounded to the nearest MHz, as that is the unit used in them.
> >>>>> 
> >>>>> We were using the simple panel "urt,umsh-8596md-t" as a substitute
> >>>>> for the A13 Q8 tablets in the absence of a specific model for what
> >>>>> may be many different but otherwise timing compatible panels. This
> >>>>> was usable without any visual artifacts or side effects, until the
> >>>>> dot clock rate check was added in commit bb43d40d7c83 ("drm/sun4i:
> >>>>> rgb: Validate the clock rate").
> >>>>> 
> >>>>> The reason this check fails is because the dotclock frequency for
> >>>>> this model is 33.26 MHz, which is not achievable with our dot clock
> >>>>> hardware, and the rate returned by clk_round_rate deviates slightly,
> >>>>> causing the driver to reject the display mode.
> >>>>> 
> >>>>> The LCD panels have some tolerance on the dot clock frequency, even
> >>>>> if it's not specified in their datasheets.
> >>>>> 
> >>>>> This patch adds a 5% tolerence to the dot clock check.
> >>>> 
> >>>> Why do you think this shouldn't be merged ?
> >>> 
> >>> It pisses of a lot of people who really insist upon accurate timing.
> >> 
> >> It's not just about accurate timings. That 5% is a made-up limit, that
> >> never have really been confirmed by looking at the typical tolerancies
> >> of panels.
> >> 
> >> And while being to relaxed might make some panels work that are not
> >> working currently, it might also break some panels that currently work
> >> and won't now, and ideally, we should really be able to let those
> >> panels work if they can, and filter out resolutions if they can't.
> >> 
> >>> I think a better fix would be to have a dotclock range in drm_panel,
> >>> and some magic to figure out which one of these we can actually
> >>> do. Then tell userspace that this is the mode is should
> >>> request. That way userspace knows what the actual dotclock/refresh
> >>> rate is, and the panel still works.
> >> 
> >> It's not just about panels, but also bridges with EDID where the
> >> tolerancy is not exposed.
> > 
> > Given that the tolerance is a property of the panel or bridge, I agree
> > with Daniel that it should be implemented there, or at least in
> > cooperation with drm_panel and drm_bridge.
> 
> How are we supposed to deal with panels without any documentation then?

We can only guess, but if the guess comes from the panel driver, it will at 
least not affect all panels and bridges, like this patch does.

> > Semi-related information, I think the CEA and VESA standards allow a 0.5%
> > clock tolerance. What is the maximum clock frequency deviation required
> > for this platform ?
> 
> Looks like it does indeed. That's definetely good to know.

-- 
Regards,

Laurent Pinchart



