Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB396C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DF321850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="QEPFQzFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeLSHtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:49:51 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:55612 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeLSHtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:49:51 -0500
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 49A72549;
        Wed, 19 Dec 2018 08:49:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1545205788;
        bh=grnD64F2pIVb+OTdVEfqQsHwloRCBH3nUg7YKxbzC6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QEPFQzFnGt3TKWweOk1w28PJ1eMs2Klh3Oix5lDV6ZQDwGCh9tor7zZ/7qFjxPXZI
         /acM5Jv0SE5c0/hi3kUjtnaLXPag/yH5cyy5EACTts+7ZGu7x4eNX6jK9DjjL3GpLm
         47xEh3HCjMDs8rAVILRZcE/XfNL5AQjMdc1rAOlk=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, architt@codeaurora.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        maxime.ripard@bootlin.com, Zheng Yang <zhengyang@rock-chips.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 5/8] drm/bridge: dw-hdmi: support dynamically get input/out color info
Date:   Wed, 19 Dec 2018 09:50:41 +0200
Message-ID: <1690671.DkqnqcUgQk@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <3cd791c0-8a7b-a3d1-09fa-5ddf0ea9c380@samsung.com>
References: <20181130134301.17963-1-narmstrong@baylibre.com> <20181130134301.17963-6-narmstrong@baylibre.com> <3cd791c0-8a7b-a3d1-09fa-5ddf0ea9c380@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wednesday, 19 December 2018 09:26:08 EET Andrzej Hajda wrote:
> On 30.11.2018 14:42, Neil Armstrong wrote:
> > From: Zheng Yang <zhengyang@rock-chips.com>
> > 
> > To get input/output bus_format/enc_format dynamically, this patch
> > 
> > introduce following funstion in plat_data:
> > 	- get_input_bus_format
> > 	- get_output_bus_format
> > 	- get_enc_in_encoding
> > 	- get_enc_out_encoding
> 
> It seems fishy. On one side description says about dynamic resolution of
> formats and encodings.
> 
> On the other side these functions as only argument takes platform_data
> which should be rather static.
> 
> Where is this "dynamic" thing? The only usage of these callbacks I have
> found in next patches is also not dynamic, the functions just return
> some static value.
> 
> Moreover function takes void* argument, which is again something
> suspicious, why cannot you pass know structure?
> 
> And finally encoding usually should depend on display mode, it should
> not depend only static data.
> 
> 
> What kind of problems do you want to solve here?

I would add that this doesn't seem to be specific to dw-hdmi in any way. I'd 
prefer an API at the drm_bridge level to handle this.

> > Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > ---
> > 
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 28 +++++++++++++++++------
> >  include/drm/bridge/dw_hdmi.h              |  5 ++++
> >  2 files changed, 26 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> > 4a9a24e854db..bd564ffdf18b 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -1810,6 +1810,7 @@ static void hdmi_disable_overflow_interrupts(struct
> > dw_hdmi *hdmi)> 
> >  static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode
> >  *mode) {
> >  
> >  	int ret;
> > 
> > +	void *data = hdmi->plat_data->phy_data;
> > 
> >  	hdmi_disable_overflow_interrupts(hdmi);
> > 
> > @@ -1821,10 +1822,13 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi,
> > struct drm_display_mode *mode)> 
> >  		dev_dbg(hdmi->dev, "CEA mode used vic=%d\n", hdmi->vic);
> >  	
> >  	}
> > 
> > -	if ((hdmi->vic == 6) || (hdmi->vic == 7) ||
> > -	    (hdmi->vic == 21) || (hdmi->vic == 22) ||
> > -	    (hdmi->vic == 2) || (hdmi->vic == 3) ||
> > -	    (hdmi->vic == 17) || (hdmi->vic == 18))
> > +	if (hdmi->plat_data->get_enc_out_encoding)
> > +		hdmi->hdmi_data.enc_out_encoding =
> > +			hdmi->plat_data->get_enc_out_encoding(data);
> > +	else if ((hdmi->vic == 6) || (hdmi->vic == 7) ||
> > +		 (hdmi->vic == 21) || (hdmi->vic == 22) ||
> > +		 (hdmi->vic == 2) || (hdmi->vic == 3) ||
> > +		 (hdmi->vic == 17) || (hdmi->vic == 18))
> > 
> >  		hdmi->hdmi_data.enc_out_encoding = V4L2_YCBCR_ENC_601;
> >  	
> >  	else
> >  	
> >  		hdmi->hdmi_data.enc_out_encoding = V4L2_YCBCR_ENC_709;
> > 
> > @@ -1833,21 +1837,31 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi,
> > struct drm_display_mode *mode)> 
> >  	hdmi->hdmi_data.video_mode.mpixelrepetitioninput = 0;
> >  	
> >  	/* TOFIX: Get input format from plat data or fallback to RGB888 */
> > 
> > -	if (hdmi->plat_data->input_bus_format)
> > +	if (hdmi->plat_data->get_input_bus_format)
> > +		hdmi->hdmi_data.enc_in_bus_format =
> > +			hdmi->plat_data->get_input_bus_format(data);
> > +	else if (hdmi->plat_data->input_bus_format)
> > 
> >  		hdmi->hdmi_data.enc_in_bus_format =
> >  		
> >  			hdmi->plat_data->input_bus_format;
> >  	
> >  	else
> >  	
> >  		hdmi->hdmi_data.enc_in_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> >  	
> >  	/* TOFIX: Get input encoding from plat data or fallback to none */
> > 
> > -	if (hdmi->plat_data->input_bus_encoding)
> > +	if (hdmi->plat_data->get_enc_in_encoding)
> > +		hdmi->hdmi_data.enc_in_encoding =
> > +			hdmi->plat_data->get_enc_in_encoding(data);
> > +	else if (hdmi->plat_data->input_bus_encoding)
> > 
> >  		hdmi->hdmi_data.enc_in_encoding =
> >  		
> >  			hdmi->plat_data->input_bus_encoding;
> >  	
> >  	else
> >  	
> >  		hdmi->hdmi_data.enc_in_encoding = V4L2_YCBCR_ENC_DEFAULT;
> >  	
> >  	/* TOFIX: Default to RGB888 output format */
> > 
> > -	hdmi->hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> > +	if (hdmi->plat_data->get_output_bus_format)
> > +		hdmi->hdmi_data.enc_out_bus_format =
> > +			hdmi->plat_data->get_output_bus_format(data);
> > +	else
> > +		hdmi->hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> > 
> >  	hdmi->hdmi_data.pix_repet_factor = 0;
> >  	hdmi->hdmi_data.hdcp_enable = 0;
> > 
> > diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> > index 7a02744ce0bc..2e797f782c51 100644
> > --- a/include/drm/bridge/dw_hdmi.h
> > +++ b/include/drm/bridge/dw_hdmi.h
> > @@ -142,6 +142,11 @@ struct dw_hdmi_plat_data {
> > 
> >  	int (*configure_phy)(struct dw_hdmi *hdmi,
> >  	
> >  			     const struct dw_hdmi_plat_data *pdata,
> >  			     unsigned long mpixelclock);
> > 
> > +
> > +	unsigned long (*get_input_bus_format)(void *data);
> > +	unsigned long (*get_output_bus_format)(void *data);
> > +	unsigned long (*get_enc_in_encoding)(void *data);
> > +	unsigned long (*get_enc_out_encoding)(void *data);
> > 
> >  };
> >  
> >  struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,


-- 
Regards,

Laurent Pinchart



