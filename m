Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D03CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D7E2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Q2Sm5zwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388613AbfAaQpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:45:45 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:49108 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbfAaQpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:45:42 -0500
Received: from pendragon.ideasonboard.com (85-76-34-136-nat.elisa-mobile.fi [85.76.34.136])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ED13A41;
        Thu, 31 Jan 2019 17:45:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1548953139;
        bh=NrVecNyXK51VGu7P/mbRdvOqLoQktnXAnKwQ0R2KQmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q2Sm5zwzUL5QyrHV+RAj+SOnqnXHvhLeq6tWHjzvFVRFcnEpcEC+Bdv6wWHnuxYA4
         x/+rDGLRwo8Nf1tpAdxAW25o5as9aKUlDiue8UEPVdml1lyN5g0r0OL2BrSHP2+Wna
         doRPNoI9hIeYa093bYIY4p3HsmNWoBBjNw2C0gA4=
Date:   Thu, 31 Jan 2019 18:45:36 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     a.hajda@samsung.com, Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        maxime.ripard@bootlin.com, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] drm/meson: Add support for HDMI2.0 4k60
Message-ID: <20190131164536.GA4674@pendragon.ideasonboard.com>
References: <20190115123315.11069-1-narmstrong@baylibre.com>
 <a3de23a8-3fa4-f8c5-5b2a-33109c09a863@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3de23a8-3fa4-f8c5-5b2a-33109c09a863@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Thu, Jan 31, 2019 at 02:25:30PM +0100, Neil Armstrong wrote:
> On 15/01/2019 13:33, Neil Armstrong wrote:
> > This patchset aims to add support for the following HDMI2.0 4k60 modes:
> > - 594Mhz TMDS frequency needing TMDS Scramling and 1/40 rate for RGB/YUV4:4:4
> > - 297MHz TMDS frequency with YUV4:2:0 encoding
> > 
> > The first mode uses the SCDC helpers introduced by intel to :
> > - discover where the monitor support SCDC
> > - setup the SCDC parameters
> > This is implemented in the dw-hdmi bridge driver by handling scrambling
> > support during the bridge setup and by exporting an helper for the PHY
> > setup to setup the SCDC configuration for the 1/40 TMDS rate.
> > This code will only be active if the encoder support a TMDS rate > 340MHz.
> > 
> > This patch could eventually break support on different SoC when connected
> > on a 4k60 monitor with SCDC :
> > - i.MX correctly discards pixel clocks > 216MHz
> > - R-CAR discards discards pixel clocks > 297MHz since [1]
> > - Rockchip discards invalid pixel clocks not in the rockchip_mpll_cfg table
> > - sun8i correctly discards pixel clocks > 297MHz on a83t
> > - sun8i discards discards pixel clocks > 594Mhz on h6, which is already broken
> > 
> > First patch should fix support for Allwinner H6.
> > 
> > The second mode is implemented by added the missing 4:2:0 bypass handling
> > in the dw-hdmi bridge driver and adding a "mtmdsclock" separating the
> > pixel clock from the tmds clock in the mode setup phase.
> > We also enable support for these modes in the connector only if the platform
> > glue code explicits the support.
> 
> Do you think patches 1-4 could be applied ?

I would have liked it if there could be a way to avoid exporting
dw_hdmi_set_high_tmds_clock_ratio() in patch 1/8, but if that's not
possible, so be it (I haven't researched that myself). No issue with
patches 2/8 to 4/8.

> Then we could focus on how we manage the bus format between the encoder
> and the bridge ?
> 
> Especially patch 5 linked to patch 7.
> 
> Will one of you be at FOSDEM 2019 ? we could chat about this.

I will be there on Sunday, likely from around 11:00.

> Following subjects on the table will be :
> - HDR metadata transmission aligned with the last patchset sent by intel-gfx
> - Colorspace connector property aligned with the last patchset sent by intel-gfx
> - HDCP 1.4 and 2.2 handling
> 
> > Only the meson DRM dw_hdmi glue allows ycbcr420 modes, so no breakage
> > is expected here.
> > 
> > The remaining patches adds support for :
> > - 1/40 TMDS rate aka DIV40 in the dw-hdmi meson PHY setup
> > - 4:2:0 output and clock setup
> > 
> > The dw-hdmi support re-uses the support done by Rockchip engineers on the
> > Linux 4.4 BSP kernel.
> > 
> > These modes has been validated using a MuxLab HDMI Signal Analyser in
> > addition to different UHD TVs supporting full 4k60 or the 4:2:0 variant.
> > 
> > Changes since RFC v2 at [3]:
> > - Collected tested-by and reviewed-by tags
> > - Changed if condition in "add HDMI div40 TMDS mode"
> > - Updated "Add YUV420 output support" with the same if condition
> > 
> > Changes since RFC v1 at [2]:
> > - Fix all comments from Laurent :
> > - Add define for HDMI 1.4 max tmds clock and SCDC supported version
> > - Call dw_hdmi_set_high_tmds_clock_ratio() in dw_hdmi_phy_enable_powerdown()
> > to unbreak Allwinner H6
> > - Pass in_t(u8, bytes, SCDC_MIN_SOURCE_VERSION) as SCDC version
> > - Finally add comments for SCDC and Scrambling process
> > 
> > [1] https://patchwork.freedesktop.org/patch/263616/
> > [2] https://patchwork.freedesktop.org/series/52950/#rev1
> > [3] https://patchwork.freedesktop.org/series/52950/#rev2
> > 
> > Neil Armstrong (7):
> >   drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support
> >   drm/meson: add HDMI div40 TMDS mode
> >   drm/meson: add support for HDMI2.0 2160p modes
> >   drm/bridge: dw-hdmi: add support for YUV420 output
> >   drm/bridge: dw-hdmi: allow ycbcr420 modes for >= 0x200a
> >   drm/meson: Add YUV420 output support
> >   drm/meson: Output in YUV444 if sink supports it
> > 
> > Zheng Yang (1):
> >   drm/bridge: dw-hdmi: support dynamically get input/out color info
> > 
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 182 +++++++++++++++++++---
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |   1 +
> >  drivers/gpu/drm/meson/meson_dw_hdmi.c     | 128 ++++++++++++---
> >  drivers/gpu/drm/meson/meson_vclk.c        |  93 ++++++++---
> >  drivers/gpu/drm/meson/meson_vclk.h        |   7 +-
> >  drivers/gpu/drm/meson/meson_venc.c        |   8 +-
> >  drivers/gpu/drm/meson/meson_venc.h        |  11 ++
> >  drivers/gpu/drm/meson/meson_venc_cvbs.c   |   3 +-
> >  include/drm/bridge/dw_hdmi.h              |   7 +
> >  9 files changed, 374 insertions(+), 66 deletions(-)

-- 
Regards,

Laurent Pinchart
