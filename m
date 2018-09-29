Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32ADC64E93
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 13:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B97C20895
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 13:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B97C20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeI2UVh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 16:21:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54564 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbeI2UVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 16:21:37 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EB59120787; Sat, 29 Sep 2018 15:53:01 +0200 (CEST)
Received: from localhost (unknown [212.145.226.70])
        by mail.bootlin.com (Postfix) with ESMTPSA id ACC0820734;
        Sat, 29 Sep 2018 15:53:01 +0200 (CEST)
Date:   Sat, 29 Sep 2018 15:53:02 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH 06/12] drm/sun4i: sun6i_mipi_dsi: Fix VBP size calculation
Message-ID: <20180929135302.ymdzapz5npvapti2@flea>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-7-jagan@amarulasolutions.com>
 <20180927152126.vovnvwmqdfpuxgdm@flea>
 <CAMty3ZABx9Fod5W_T7JciZEsn7jGvuM-LsBFATdA=hQ2CVwELw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAMty3ZABx9Fod5W_T7JciZEsn7jGvuM-LsBFATdA=hQ2CVwELw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 09:50:34PM +0530, Jagan Teki wrote:
> On Thu, Sep 27, 2018 at 8:51 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Thu, Sep 27, 2018 at 05:18:44PM +0530, Jagan Teki wrote:
> > > According to horizontal and vertical timings are defined
> > > per the diagram from include/drm/drm_modes.h
> > >
> > > Back porch = [hv]total - [hv]sync_end
> > >
> > > So, update SUN6I_DSI_BASIC_SIZE0_VBP calculation as
> > > mode->vtotal - mode->vsync_end
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > index 1c7e42015645..599284971ab6 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > @@ -526,8 +526,8 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
> > >       regmap_write(dsi->regs, SUN6I_DSI_BASIC_SIZE0_REG,
> > >                    SUN6I_DSI_BASIC_SIZE0_VSA(mode->vsync_end -
> > >                                              mode->vsync_start) |
> > > -                  SUN6I_DSI_BASIC_SIZE0_VBP(mode->vsync_start -
> > > -                                            mode->vdisplay));
> > > +                  SUN6I_DSI_BASIC_SIZE0_VBP(mode->vtotal -
> > > +                                            mode->vsync_end));
> >
> > Is it purely theoretical, or did you find some source that back that?
> 
> VSA is done as per that, sync_end - sync start would give sync time.

That's a different register though.

> VBP also done in BPI-M64-bsp[1] which results back porch existing code
> results fron porch.
> 
> [1] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c#L955

That code does back porch - sync length. Such a calculation doesn't
make much sense as is, but you're saying that it results in the front
porch. Again, what makes you say that?

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
