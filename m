Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8DBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB787206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kvtXwK0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB787206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395248AbeKXBJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:09:45 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:42940 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731438AbeKXBJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:09:45 -0500
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DCF6F58E;
        Fri, 23 Nov 2018 15:25:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1542983119;
        bh=UXVTUkI454QC/ysI2tQefGcSCQobC9tZ7XBTh0uodQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kvtXwK0LIyu67hisFzaTq6r0g9H67nqJxrDruXA8kgpgAUXFZBfitWwAm2MhfGiHI
         ZnrDSCNJrSF7pwRncAfTtc+NUzz7pQcRIKhwc63o6uBLToDPdzTr6cdF+dtC7uPDNz
         56kzHMV0m6m2qvIj+PDZl1GzwyPNC+zJ5nYZnTLw=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     architt@codeaurora.org, a.hajda@samsung.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Huicong Xu <xhc@rock-chips.com>
Subject: Re: [PATCH RFC 1/8] drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support
Date:   Fri, 23 Nov 2018 16:25:39 +0200
Message-ID: <1880382.AeP59NOuia@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181123140221.15700-2-narmstrong@baylibre.com>
References: <20181123140221.15700-1-narmstrong@baylibre.com> <20181123140221.15700-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

Thank you for the patch.

On Friday, 23 November 2018 16:02:14 EET Neil Armstrong wrote:
> Add support for SCDC Setup for TMDS Clock > 3.4GHz and enable TMDS
> Scrambling when supported or mandatory.
> 
> This patch also adds an helper to setup the control bit to support
> the hight TMDS Bit Period/TMDS Clock-Period Ratio as required with

s/hight/high/ ?

> TMDS Clock > 3.4GHz for HDMI2.0 3840x2160@60/50 modes.

Why do you need a helper for this, is there no way it could be handled 
internally ?

> These changes were based on work done by Huicong Xu <xhc@rock-chips.com>
> and Nickey Yang <nickey.yang@rock-chips.com> to support HDMI2.0 modes
> on the Rockchip 4.4 BSP kernel at [1]
> 
> [1] https://github.com/rockchip-linux/kernel/tree/release-4.4
> 
> Cc: Nickey Yang <nickey.yang@rock-chips.com>
> Cc: Huicong Xu <xhc@rock-chips.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 45 +++++++++++++++++++++--
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |  1 +
>  include/drm/bridge/dw_hdmi.h              |  1 +
>  3 files changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> 5971976284bf..523508af70b0 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -28,6 +28,7 @@
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_encoder_slave.h>
> +#include <drm/drm_scdc_helper.h>
>  #include <drm/bridge/dw_hdmi.h>
> 
>  #include <uapi/linux/media-bus-format.h>
> @@ -1015,6 +1016,20 @@ void dw_hdmi_phy_i2c_write(struct dw_hdmi *hdmi,
> unsigned short data, }
>  EXPORT_SYMBOL_GPL(dw_hdmi_phy_i2c_write);
> 
> +void dw_hdmi_set_high_tmds_clock_ratio(struct dw_hdmi *hdmi)
> +{
> +	unsigned long mtmdsclock = hdmi->hdmi_data.video_mode.mpixelclock;
> +
> +	/* Control for TMDS Bit Period/TMDS Clock-Period Ratio */
> +	if (hdmi->connector.display_info.hdmi.scdc.supported) {
> +		if (mtmdsclock > 340000000)

You use the 3.4GHz frequency in a few places, how about creating a macro ?

> +			drm_scdc_set_high_tmds_clock_ratio(hdmi->ddc, 1);
> +		else
> +			drm_scdc_set_high_tmds_clock_ratio(hdmi->ddc, 0);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(dw_hdmi_set_high_tmds_clock_ratio);
> +
>  static void dw_hdmi_phy_enable_powerdown(struct dw_hdmi *hdmi, bool enable)
> {
>  	hdmi_mask_writeb(hdmi, !enable, HDMI_PHY_CONF0,
> @@ -1340,11 +1355,12 @@ static void hdmi_tx_hdcp_config(struct dw_hdmi
> *hdmi)
> 
>  static void hdmi_config_AVI(struct dw_hdmi *hdmi, struct drm_display_mode
> *mode) {
> +	bool is_hdmi2_sink = hdmi->connector.display_info.hdmi.scdc.supported;
>  	struct hdmi_avi_infoframe frame;
>  	u8 val;
> 
>  	/* Initialise info frame from DRM mode */
> -	drm_hdmi_avi_infoframe_from_display_mode(&frame, mode, false);
> +	drm_hdmi_avi_infoframe_from_display_mode(&frame, mode, is_hdmi2_sink);
> 
>  	if (hdmi_bus_fmt_is_yuv444(hdmi->hdmi_data.enc_out_bus_format))
>  		frame.colorspace = HDMI_COLORSPACE_YUV444;
> @@ -1503,7 +1519,8 @@ static void
> hdmi_config_vendor_specific_infoframe(struct dw_hdmi *hdmi, static void
> hdmi_av_composer(struct dw_hdmi *hdmi,
>  			     const struct drm_display_mode *mode)
>  {
> -	u8 inv_val;
> +	u8 inv_val, bytes;
> +	struct drm_hdmi_info *hdmi_info = &hdmi->connector.display_info.hdmi;
>  	struct hdmi_vmode *vmode = &hdmi->hdmi_data.video_mode;
>  	int hblank, vblank, h_de_hs, v_de_vs, hsync_len, vsync_len;
>  	unsigned int vdisplay;
> @@ -1513,7 +1530,9 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>  	dev_dbg(hdmi->dev, "final pixclk = %d\n", vmode->mpixelclock);
> 
>  	/* Set up HDMI_FC_INVIDCONF */
> -	inv_val = (hdmi->hdmi_data.hdcp_enable ?
> +	inv_val = (hdmi->hdmi_data.hdcp_enable ||
> +		   vmode->mpixelclock > 340000000 ||
> +		   hdmi_info->scdc.scrambling.low_rates ?
>  		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_ACTIVE :
>  		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_INACTIVE);
> 
> @@ -1562,6 +1581,26 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>  		vsync_len /= 2;
>  	}
> 
> +	/* Scrambling Control */
> +	if (hdmi_info->scdc.supported) {
> +		if (vmode->mpixelclock > 340000000 ||
> +		    hdmi_info->scdc.scrambling.low_rates) {
> +			drm_scdc_readb(&hdmi->i2c->adap, SCDC_SINK_VERSION,
> +				       &bytes);
> +			drm_scdc_writeb(&hdmi->i2c->adap, SCDC_SOURCE_VERSION,
> +					bytes);

Shouldn't the source version be min(sink version, highest supported source 
version) ?

> +			drm_scdc_set_scrambling(&hdmi->i2c->adap, 1);
> +			hdmi_writeb(hdmi, (u8)~HDMI_MC_SWRSTZ_TMDSSWRST_REQ,
> +				    HDMI_MC_SWRSTZ);
> +			hdmi_writeb(hdmi, 1, HDMI_FC_SCRAMBLER_CTRL);
> +		} else {
> +			hdmi_writeb(hdmi, 0, HDMI_FC_SCRAMBLER_CTRL);
> +			hdmi_writeb(hdmi, (u8)~HDMI_MC_SWRSTZ_TMDSSWRST_REQ,
> +				    HDMI_MC_SWRSTZ);
> +			drm_scdc_set_scrambling(&hdmi->i2c->adap, 0);
> +		}
> +	}
> +
>  	/* Set up horizontal active pixel width */
>  	hdmi_writeb(hdmi, mode->hdisplay >> 8, HDMI_FC_INHACTV1);
>  	hdmi_writeb(hdmi, mode->hdisplay, HDMI_FC_INHACTV0);
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h index
> 9d90eb9c46e5..3f3c616eba97 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> @@ -255,6 +255,7 @@
>  #define HDMI_FC_MASK2                           0x10DA
>  #define HDMI_FC_POL2                            0x10DB
>  #define HDMI_FC_PRCONF                          0x10E0
> +#define HDMI_FC_SCRAMBLER_CTRL                  0x10E1
> 
>  #define HDMI_FC_GMD_STAT                        0x1100
>  #define HDMI_FC_GMD_EN                          0x1101
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index ccb5aa8468e0..d7cc5d094270 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -156,6 +156,7 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool
> hpd, bool rx_sense); void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi,
> unsigned int rate); void dw_hdmi_audio_enable(struct dw_hdmi *hdmi);
>  void dw_hdmi_audio_disable(struct dw_hdmi *hdmi);
> +void dw_hdmi_set_high_tmds_clock_ratio(struct dw_hdmi *hdmi);
> 
>  /* PHY configuration */
>  void dw_hdmi_phy_i2c_set_addr(struct dw_hdmi *hdmi, u8 address);


-- 
Regards,

Laurent Pinchart



