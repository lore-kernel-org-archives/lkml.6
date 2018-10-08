Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8014C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F3C2075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F3C2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeJHWV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:21:58 -0400
Received: from mailoutvs50.siol.net ([185.57.226.241]:42009 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726078AbeJHWV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:21:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 69F3052101C;
        Mon,  8 Oct 2018 17:09:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9BEfd-RCm4tW; Mon,  8 Oct 2018 17:09:43 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id CA0385205FB;
        Mon,  8 Oct 2018 17:09:43 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPA id BDDD6520CBD;
        Mon,  8 Oct 2018 17:09:42 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     wens@csie.org, robh+dt@kernel.org, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 18/29] drm/sun4i: dw-hdmi: Add quirk for setting TMDS clock
Date:   Mon, 08 Oct 2018 17:09:42 +0200
Message-ID: <8016466.hta3A6eauk@jernej-laptop>
In-Reply-To: <20181008091406.yjs2u22fmj72e4rj@flea>
References: <20181007093905.11253-1-jernej.skrabec@siol.net> <20181007093905.11253-19-jernej.skrabec@siol.net> <20181008091406.yjs2u22fmj72e4rj@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 08. oktober 2018 ob 11:14:06 CEST je Maxime Ripard napisal(a):
> Hi,
> 
> On Sun, Oct 07, 2018 at 11:38:54AM +0200, Jernej Skrabec wrote:
> > It turns out that H6 HDMI BSP kernel driver doesn't change TMDS rate at
> > all. At this point it is not clear whether it is just not necessary or
> > it would cause some kind of issues.
> > 
> > Add a quirk for it.
> > 
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 5 ++++-
> >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h | 1 +
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c index ec122136ee9d..e9e93f174b35
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > @@ -165,7 +165,9 @@ static int sun8i_dw_hdmi_bind(struct device *dev,
> > struct device *master,> 
> >  		goto err_disable_clk_tmds;
> >  	
> >  	}
> > 
> > -	drm_encoder_helper_add(encoder, &sun8i_dw_hdmi_encoder_helper_funcs);
> > +	if (hdmi->quirks->set_rate)
> > +		drm_encoder_helper_add(encoder,
> > +				       &sun8i_dw_hdmi_encoder_helper_funcs);
> 
> That seems a bit backward, it only works because we only have mode_set
> at the moment, and the only thing it does is changing the clock
> rate. As soon as we change one of these two assumptions, the code will
> break.
> 
> Why not just return in mode_set if that boolean is true?

My original intention was to optimize execution time a bit. If there is no 
helpers registered, there is no need to call callback which does nothing. But 
your way is probably more reasonable approach.

However, I'm pretty sure that even older HDMI controller doesn't need this 
rate changing code. All tests shown that changing HDMI controller divider 
doesn't have an effect on video or audio output. It's only there because BSP 
kernel driver set rate and AW engineer said it's necessary.

> 
> >  	drm_encoder_init(drm, encoder, &sun8i_dw_hdmi_encoder_funcs,
> >  	
> >  			 DRM_MODE_ENCODER_TMDS, NULL);
> > 
> > @@ -235,6 +237,7 @@ static int sun8i_dw_hdmi_remove(struct platform_device
> > *pdev)> 
> >  static const struct sun8i_dw_hdmi_quirks sun8i_a83t_quirks = {
> >  
> >  	.mode_valid = sun8i_dw_hdmi_mode_valid_a83t,
> > 
> > +	.set_rate = true,
> > 
> >  };
> >  
> >  static const struct of_device_id sun8i_dw_hdmi_dt_ids[] = {
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h index a645b8bc9f58..f9eb663865a4
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > @@ -173,6 +173,7 @@ struct sun8i_hdmi_phy {
> > 
> >  struct sun8i_dw_hdmi_quirks {
> >  
> >  	enum drm_mode_status (*mode_valid)(struct drm_connector *connector,
> >  	
> >  					   const struct drm_display_mode *mode);
> > 
> > +	bool set_rate;
> 
> This triggers a check in checkpatch. You should address them (and
> there's several in your series).

Till now we used bools in driver internal structures in spite of this 
warnings. So should we start using unsigned int? Or maybe bitfield with 
unsigned int as a base according to https://lkml.org/lkml/2017/11/21/384

As far as other issues reported by strict checkpatch go, most of them are DT 
lines over 80 charachters. This was tolerated till now. Last type of issues is 
that macro parameters weren't enclosed with braces. These issues won't be 
reported anymore in new series because sun8i_csc.h won't be touched if I drop 
patch which renames DE2 register macros (but original issue will remain).

Best regards,
Jernej

> 
> With both addressed,
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Thanks!




