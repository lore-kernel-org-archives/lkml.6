Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080AFC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B966120644
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B966120644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeJRUvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:51:23 -0400
Received: from hermes.aosc.io ([199.195.250.187]:56630 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbeJRUvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:51:23 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 3A6B015D3E0;
        Thu, 18 Oct 2018 12:50:22 +0000 (UTC)
Message-ID: <0c8e2417ec79b44d88a3054d0526bfc5abb364d6.camel@aosc.io>
Subject: Re: [PATCH 9/9] [DO NOT MERGE] drm/sun4i: rgb: Add 5% tolerance to
 dot clock frequency check
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     devicetree@vger.kernel.org, Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 18 Oct 2018 20:50:15 +0800
In-Reply-To: <20181018121819.gmup3jd7ukj52rvx@flea>
References: <20181018073327.64942-1-icenowy@aosc.io>
         <CAKMK7uFp2c=wqzPi096MTRB6Cdfacerkp6dM=fEqCAr99PQG9w@mail.gmail.com>
         <20181018094258.oahlopafvm2udvoe@flea> <1585874.9P5eR8PMbl@avalon>
         <20181018121819.gmup3jd7ukj52rvx@flea>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-10-18四的 14:18 +0200，Maxime Ripard写道：
> On Thu, Oct 18, 2018 at 02:31:01PM +0300, Laurent Pinchart wrote:
> > Hello,
> > 
> > On Thursday, 18 October 2018 12:42:58 EEST Maxime Ripard wrote:
> > > On Thu, Oct 18, 2018 at 11:18:06AM +0200, Daniel Vetter wrote:
> > > > On Thu, Oct 18, 2018 at 10:55 AM Laurent Pinchart wrote:
> > > > > On Thursday, 18 October 2018 10:33:27 EEST Icenowy Zheng
> > > > > wrote:
> > > > > > From: Chen-Yu Tsai <wens@csie.org>
> > > > > > 
> > > > > > The panels shipped with Allwinner devices are very
> > > > > > "generic", i.e.
> > > > > > they do not have model numbers or reliable sources of
> > > > > > information
> > > > > > for the timings (that we know of) other than the fex files
> > > > > > shipped
> > > > > > on them. The dot clock frequency provided in the fex files
> > > > > > have all
> > > > > > been rounded to the nearest MHz, as that is the unit used
> > > > > > in them.
> > > > > > 
> > > > > > We were using the simple panel "urt,umsh-8596md-t" as a
> > > > > > substitute
> > > > > > for the A13 Q8 tablets in the absence of a specific model
> > > > > > for what
> > > > > > may be many different but otherwise timing compatible
> > > > > > panels. This
> > > > > > was usable without any visual artifacts or side effects,
> > > > > > until the
> > > > > > dot clock rate check was added in commit bb43d40d7c83
> > > > > > ("drm/sun4i:
> > > > > > rgb: Validate the clock rate").
> > > > > > 
> > > > > > The reason this check fails is because the dotclock
> > > > > > frequency for
> > > > > > this model is 33.26 MHz, which is not achievable with our
> > > > > > dot clock
> > > > > > hardware, and the rate returned by clk_round_rate deviates
> > > > > > slightly,
> > > > > > causing the driver to reject the display mode.
> > > > > > 
> > > > > > The LCD panels have some tolerance on the dot clock
> > > > > > frequency, even
> > > > > > if it's not specified in their datasheets.
> > > > > > 
> > > > > > This patch adds a 5% tolerence to the dot clock check.
> > > > > 
> > > > > Why do you think this shouldn't be merged ?
> > > > 
> > > > It pisses of a lot of people who really insist upon accurate
> > > > timing.
> > > 
> > > It's not just about accurate timings. That 5% is a made-up limit,
> > > that
> > > never have really been confirmed by looking at the typical
> > > tolerancies
> > > of panels.
> > > 
> > > And while being to relaxed might make some panels work that are
> > > not
> > > working currently, it might also break some panels that currently
> > > work
> > > and won't now, and ideally, we should really be able to let those
> > > panels work if they can, and filter out resolutions if they
> > > can't.
> > > 
> > > > I think a better fix would be to have a dotclock range in
> > > > drm_panel,
> > > > and some magic to figure out which one of these we can actually
> > > > do. Then tell userspace that this is the mode is should
> > > > request. That way userspace knows what the actual
> > > > dotclock/refresh
> > > > rate is, and the panel still works.
> > > 
> > > It's not just about panels, but also bridges with EDID where the
> > > tolerancy is not exposed.
> > 
> > Given that the tolerance is a property of the panel or bridge, I
> > agree with 
> > Daniel that it should be implemented there, or at least in
> > cooperation with 
> > drm_panel and drm_bridge.
> 
> How are we supposed to deal with panels without any documentation
> then?
> 
> > Semi-related information, I think the CEA and VESA standards allow
> > a 0.5% 
> > clock tolerance. What is the maximum clock frequency deviation
> > required for 
> > this platform ?
> 
> Looks like it does indeed. That's definetely good to know.

Then maybe we can choose to allow 0.5% error when a bridge is attached?

> 
> Thanks!
> Maxime
> 

