Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7625ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975A42150C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975A42150C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeJQXaE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:30:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57963 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727214AbeJQXaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:30:03 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 40F0620791; Wed, 17 Oct 2018 17:33:47 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-7-245.w90-88.abo.wanadoo.fr [90.88.129.245])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2D229208CB;
        Wed, 17 Oct 2018 17:33:22 +0200 (CEST)
Date:   Wed, 17 Oct 2018 17:33:23 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH 04/10] drm/sun4i: Explicitly list and check formats
 supported by the backend
Message-ID: <20181017153323.x6g2ms7jncmh4qmz@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-5-paul.kocialkowski@bootlin.com>
 <20180323100330.2sijtsp5bdyyel5a@flea>
 <1522138128.1110.11.camel@bootlin.com>
 <20180329075621.it3xltsqw4tbgeyu@flea>
 <9f96548a1b79f841130f3bf31b6eae8966fe0baf.camel@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <9f96548a1b79f841130f3bf31b6eae8966fe0baf.camel@paulk.fr>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 03:55:40PM +0200, Paul Kocialkowski wrote:
> Hi,
> 
> Le jeudi 29 mars 2018 à 09:56 +0200, Maxime Ripard a écrit :
> > On Tue, Mar 27, 2018 at 10:08:48AM +0200, Paul Kocialkowski wrote:
> > > On Fri, 2018-03-23 at 11:03 +0100, Maxime Ripard wrote:
> > > > On Wed, Mar 21, 2018 at 04:28:58PM +0100, Paul Kocialkowski wrote:
> > > > > In order to check whether the backend supports a specific format, an
> > > > > explicit list and a related helper are introduced.
> > > > > 
> > > > > They are then used to determine whether the frontend should be used
> > > > > for
> > > > > a layer, when the format is not supported by the backend.
> > > > > 
> > > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > ---
> > > > >  drivers/gpu/drm/sun4i/sun4i_backend.c | 48
> > > > > ++++++++++++++++++++++++++++++++++-
> > > > >  drivers/gpu/drm/sun4i/sun4i_backend.h |  1 +
> > > > >  2 files changed, 48 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > > > b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > > > index 274a1db6fa8e..7703ba989743 100644
> > > > > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > > > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > > > @@ -172,6 +172,39 @@ static int
> > > > > sun4i_backend_drm_format_to_layer(u32 format, u32 *mode)
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > +static const uint32_t sun4i_backend_formats[] = {
> > > > > +	/* RGB */
> > > > > +	DRM_FORMAT_ARGB4444,
> > > > > +	DRM_FORMAT_RGBA4444,
> > > > > +	DRM_FORMAT_ARGB1555,
> > > > > +	DRM_FORMAT_RGBA5551,
> > > > > +	DRM_FORMAT_RGB565,
> > > > > +	DRM_FORMAT_RGB888,
> > > > > +	DRM_FORMAT_XRGB8888,
> > > > > +	DRM_FORMAT_BGRX8888,
> > > > > +	DRM_FORMAT_ARGB8888,
> > > > > +	/* YUV422 */
> > > > > +	DRM_FORMAT_YUYV,
> > > > > +	DRM_FORMAT_YVYU,
> > > > > +	DRM_FORMAT_UYVY,
> > > > > +	DRM_FORMAT_VYUY,
> > > > 
> > > > Ordering them by alphabetical order would be better.
> > > 
> > > Frankly I find it a lot harder to read when the formats are not grouped
> > > by "family". This is the drm_fourcc enumeration order, which has some
> > > kind of logic behind it. What is the advantage of alphabetical ordering
> > > here?
> > 
> > It's self-sufficient and self-explanatory. The sorting here, while it
> > would make sense lack both: you need to refer to the drm_fourcc.h file
> > to get the sorting right (which makes it harder to edit and review,
> > and thus more error prone), and it assumes that the editor knows about
> > that sorting in the first place.
> > 
> > And it's an assumption we can't really make, since some people will
> > edit that structure in the first place without any background at all
> > with DRM, or even graphics in general.
> > 
> > While the assumption you have to make for the alphabetical order is
> > that one knows the latin alphabet, which is a pretty obvious one when
> > you're doing C programming.
> > 
> > > > > +	 */
> > > > > +	if (!sun4i_backend_format_is_supported(fb->format->format))
> > > > > +		return true;
> > > > 
> > > > Even though there's a comment, this is not really natural. We are
> > > > checking whether the frontend supports the current plane_state, so it
> > > > just makes more sense to check whether the frontend supports the
> > > > format, rather than if the backend doesn't support them.
> > > 
> > > The rationale behind this logic is that we should try to use the backend
> > > first and only use the frontend as a last resort. Some formats are
> > > supported by both and checking that the backend supports a format first
> > > ensures that we don't bring up the frontend without need.
> > 
> > You can achieve pretty much the same thing by doing:
> > 
> > if (!sun4i_frontend_format_is_supported())
> > 	return false;
> > 
> > if (!using_scaling)
> > 	return false;
> > 
> > if (using_2x_or_4x_scaling)
> > 	return false;
> > 
> > return true;
> > 
> > This is really about whitelisting vs blacklisting, so I'm not sure
> > what that would really change in the case you described above.
> 
> These sequential tests for blacklisting don't fit the bill here. For
> instance, it would always return false when not using scaling for a
> format supported only by the frontend, while we'd need to use the
> frontend for it.
> 
> We still need to know whether the format is supported or not for both
> the frontend or the backend, because one is not sufficient to describe
> the other and both are involved in the decision to use the frontend.
> 
> That is, the set of formats supported by the frontend is not the 
> complementary of the sets of formats supported by the backend (some
> formats are supported by both), so we can't exchange one with the
> negation of the other in the initial statement.
> 
> I agree with the inital comment though, that it seems more natural to
> check that the frontend supports a format first.
> 
> I think the following combination would be the most comprehensive:
> 
> if (!sun4i_frontend_format_is_supported())
> 	return false;
> 
> if (!sun4i_backend_format_is_supported())
> 	return true;
> 
> if (using_2x_or_4x_scaling)
> 	return false;
> 
> if (using_scaling)
> 	return true;
> 
> return false;
> 
> What do you think?

That works for me

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
