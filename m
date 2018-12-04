Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D58C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABD020878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CABD020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbeLDNbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:31:12 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59358 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbeLDNbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 08:31:12 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E277420711; Tue,  4 Dec 2018 14:31:09 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9ACEC207AD;
        Tue,  4 Dec 2018 14:30:59 +0100 (CET)
Message-ID: <673fa8ed8e43943c29f050fd21954e77789134c3.camel@bootlin.com>
Subject: Re: [PATCH v2 34/43] drm/sun4i: Add buffer stride and offset
 configuration for tiling mode
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 04 Dec 2018 14:30:59 +0100
In-Reply-To: <20181127092428.z7p4mxnf3jxuqcv7@flea>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
         <20181123092515.2511-35-paul.kocialkowski@bootlin.com>
         <20181127092428.z7p4mxnf3jxuqcv7@flea>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2018-11-27 at 10:24 +0100, Maxime Ripard wrote:
> On Fri, Nov 23, 2018 at 10:25:06AM +0100, Paul Kocialkowski wrote:
> > This introduces stride and offset configuration for the VPU tiling mode.
> > Stride is calculated differently than it is for linear formats and an
> > offset is calculated, for which new register definitions are introduced.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_frontend.c | 54 ++++++++++++++++++++++++--
> >  drivers/gpu/drm/sun4i/sun4i_frontend.h |  7 ++++
> >  2 files changed, 58 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> > index efa1ff0802bd..3f76a5572449 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> > @@ -125,21 +125,69 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
> >  {
> >  	struct drm_plane_state *state = plane->state;
> >  	struct drm_framebuffer *fb = state->fb;
> > +	unsigned int strides[3] = {};
> > +
> >  	dma_addr_t paddr;
> >  	bool swap;
> >  
> > +	if (fb->modifier == DRM_FORMAT_MOD_ALLWINNER_TILED) {
> > +		unsigned int width = state->src_w >> 16;
> > +		unsigned int offset;
> > +
> > +		/*
> > +		 * In MB32 tiled mode, the stride is defined as the distance
> > +		 * between the start of the end line of the current tile and
> > +		 * the start of the first line in the next vertical tile.
> > +		 *
> > +		 * Tiles are represented in row-major order, thus the end line
> > +		 * of current tile starts at: 31 * 32 (31 lines of 32 cols),
> > +		 * the next vertical tile starts at: 32-bit-aligned-width * 32
> > +		 * and the distance is: 32 * (32-bit-aligned-width - 31).
> > +		 */
> > +
> > +		strides[0] = (fb->pitches[0] - 31) * 32;
> > +
> > +		/* Offset of the bottom-right point in the end tile. */
> > +		offset = (width + (32 - 1)) & (32 - 1);
> 
> Those computations are a bit obscure. I guess adding a bunch of
> defines, and using the round_up / _down and ALIGN macros would help

Fair enough, I will add a more explicit comment and a macro in v3.

> > +		regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF0_REG,
> > +			     SUN4I_FRONTEND_TB_OFF_X1(offset));
> > +
> > +		if (fb->format->num_planes > 1) {
> > +			strides[1] = (fb->pitches[1] - 31) * 32;
> > +
> > +			regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF1_REG,
> > +				     SUN4I_FRONTEND_TB_OFF_X1(offset));
> > +		}
> > +
> > +		if (fb->format->num_planes > 2) {
> > +			strides[2] = (fb->pitches[2] - 31) * 32;
> > +
> > +			regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF2_REG,
> > +				     SUN4I_FRONTEND_TB_OFF_X1(offset));
> > +		}
> 
> I guess we could fall in a situation where this is not cleared when
> moving from a format with 3 planes to one with 2 for example. Would
> that break anything?

I have tested this case and nothing breaks so we're good!

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com

