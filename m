Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E6BC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5330207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5330207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeJZT5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:57:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41151 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727291AbeJZT5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:57:00 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C8A91208BE; Fri, 26 Oct 2018 13:20:15 +0200 (CEST)
Received: from localhost (unknown [31.221.87.75])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8DE6F20731;
        Fri, 26 Oct 2018 13:20:15 +0200 (CEST)
Date:   Fri, 26 Oct 2018 12:20:15 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-sunxi@googlegroups.com,
        Mark Van den Borre <mark@fosdem.org>,
        Gerry Demaret <gerry@fosdem.org>,
        Luc Verhaegen <libv@skynet.be>
Subject: Re: [PATCH 1/4] drm/sun4i: tcon: Support an active-low DE signal
 with RGB interface
Message-ID: <20181026112015.55wa4f6b7odpuusw@flea>
References: <20181010114134.8211-1-contact@paulk.fr>
 <20181010145736.l6zpohvvd4b5qngr@flea>
 <224ec158bf627b4d2f577b1dadf10bd87891e2a7.camel@paulk.fr>
 <20181024164758.iqnlie4witckzauy@flea>
 <265be8b3daab5b9fedcf7646c68c4319a2564b3c.camel@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <265be8b3daab5b9fedcf7646c68c4319a2564b3c.camel@paulk.fr>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 07:24:32PM +0200, Paul Kocialkowski wrote:
> Hi,
> 
> Le mercredi 24 octobre 2018 à 17:47 +0100, Maxime Ripard a écrit :
> > On Tue, Oct 23, 2018 at 11:33:10AM +0200, Paul Kocialkowski wrote:
> > > Hi,
> > > 
> > > Le mercredi 10 octobre 2018 à 16:57 +0200, Maxime Ripard a écrit :
> > > > On Wed, Oct 10, 2018 at 01:41:31PM +0200, Paul Kocialkowski wrote:
> > > > > Some panels need an active-low data enable (DE) signal for the RGB
> > > > > interface. This requires flipping a bit in the TCON0 polarity register
> > > > > when setting up the mode for the RGB interface.
> > > > > 
> > > > > Add a new helper function to match specific bus flags and use it to set
> > > > > the polarity inversion bit for the DE signal when required.
> > > > > 
> > > > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > > > ---
> > > > >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 28 ++++++++++++++++++++++++++--
> > > > >  drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
> > > > >  2 files changed, 27 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > > index 3fb084f802e2..d249a462ec09 100644
> > > > > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > > @@ -78,6 +78,24 @@ static int sun4i_tcon_get_pixel_depth(const struct drm_encoder *encoder)
> > > > >  	return -EINVAL;
> > > > >  }
> > > > >  
> > > > > +static bool sun4i_tcon_match_bus_flags(const struct drm_encoder *encoder,
> > > > > +				       u32 bus_flags)
> > > > > +{
> > > > > +	struct drm_connector *connector;
> > > > > +	struct drm_display_info *info;
> > > > > +
> > > > > +	connector = sun4i_tcon_get_connector(encoder);
> > > > > +	if (!connector)
> > > > > +		return false;
> > > > > +
> > > > > +	info = &connector->display_info;
> > > > > +
> > > > > +	if ((info->bus_flags & bus_flags) == bus_flags)
> > > > > +		return true;
> > > > > +
> > > > > +	return false;
> > > > > +}
> > > > > +
> > > > >  static void sun4i_tcon_channel_set_status(struct sun4i_tcon *tcon, int channel,
> > > > >  					  bool enabled)
> > > > >  {
> > > > > @@ -415,6 +433,7 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
> > > > >  }
> > > > >  
> > > > >  static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
> > > > > +				     const struct drm_encoder *encoder,
> > > > >  				     const struct drm_display_mode *mode)
> > > > >  {
> > > > >  	unsigned int bp, hsync, vsync;
> > > > > @@ -474,8 +493,13 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
> > > > >  	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> > > > >  		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
> > > > >  
> > > > > +	if (sun4i_tcon_match_bus_flags(encoder, DRM_BUS_FLAG_DE_LOW))
> > > > > +		val |= SUN4I_TCON0_IO_POL_DE_NEGATIVE;
> > > > > +
> > > > 
> > > > There's other flags in use in that function, you should also migrate
> > > > them (ideally by splitting that new function into a separate patch).
> > > 
> > > Actually, these other flags are not DRM bus flags but DRM mode flags,
> > > which can be accessed directly from the mode pointer passed as
> > > argument. Thus, they don't require a helper.
> > 
> > I was talking about DRM_BUS_FLAG_PIXDATA_POSEDGE and
> > DRM_BUS_FLAG_PIXDATA_NEGEDGE, which are in the current tree.
> 
> Thanks, I guess I need to rebase these patches atop the current tree!
> 
> Looking at how these flags are used in the current tree, I see that the
> connector's display_info structure (that contains the bus flags) is
> retreived from tcon->panel.
> 
> Would it make sense to change this and retreive it from the encoder,
> passed as argument to that function (as I've done in this patch)
> instead? This way, this wouldn't only apply to panels, but also to
> external bridges. It would also somewhat streamline the logic.
> 
> What do you think?

That looks like a good idea :)

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
