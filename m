Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B27AC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2E9214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2E9214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeLDRuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:50:40 -0500
Received: from foss.arm.com ([217.140.101.70]:38054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbeLDRuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:50:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75552A78;
        Tue,  4 Dec 2018 09:50:39 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 216F13F59C;
        Tue,  4 Dec 2018 09:50:39 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 7E6A86801C3; Tue,  4 Dec 2018 17:50:37 +0000 (GMT)
Date:   Tue, 4 Dec 2018 17:50:37 +0000
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [RFC AFBC 08/12] drm/arm/malidp: Specified the rotation memory
 requirements for AFBC YUV formats
Message-ID: <20181204175037.GP988@e110455-lin.cambridge.arm.com>
References: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
 <1543836703-8491-9-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543836703-8491-9-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:32:02AM +0000, Ayan Halder wrote:
> The newly supported AFBC YUV formats have the following rotation memory
> constraints (in DP550/DP650).
> 1. DRM_FORMAT_VUY888/DRM_FORMAT_VUY101010 :- It can rotate upto 8
> horizontal lines in the AFBC output buffer.
> 2. DRM_FORMAT_YUV420_8BIT :- It can rotate upto 16 horizontal lines
> in the AFBC output buffer.
> 
> Also some of the pixel formats are specified in bits per pixel (rather
> than bytes per pixel), so the calculation needs to take note of this.
> 
> Besides there are some difference between DP550 and DP650 and these are
> as follows:-
> 1. DRM_FORMAT_X0L2 (in uncompressed format) does not support rotation in DP550.
> For DP650, it can rotate upto 16 horizontal lines in the AFBC output buffer,
> whereas in DP550 (with AFBC), it can rotate upto 8 horizontal lines.
> 2. DRM_FORMAT_YUV420_10BIT :- It can rotate upto 8 horizontal lines in
> dp550 and 16 horizontal lines in DP650.
> 
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/malidp_hw.c     | 101 ++++++++++++++++++++++++++++++++----
>  drivers/gpu/drm/arm/malidp_hw.h     |   5 +-
>  drivers/gpu/drm/arm/malidp_planes.c |   3 +-
>  3 files changed, 98 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> index 4a774be..d9866a8 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.c
> +++ b/drivers/gpu/drm/arm/malidp_hw.c
> @@ -375,14 +375,39 @@ static void malidp500_modeset(struct malidp_hw_device *hwdev, struct videomode *
>  		malidp_hw_clearbits(hwdev, MALIDP_DISP_FUNC_ILACED, MALIDP_DE_DISPLAY_FUNC);
>  }
>  
> -static int malidp500_rotmem_required(struct malidp_hw_device *hwdev, u16 w, u16 h, u32 fmt)
> +int malidp_format_get_bpp(u32 fmt)
> +{
> +	int bpp = drm_format_plane_cpp(fmt, 0) * 8;
> +
> +	if (bpp == 0) {
> +		switch (fmt) {
> +		case DRM_FORMAT_VUY101010:
> +			bpp = 30;
> +		case DRM_FORMAT_YUV420_10BIT:
> +			bpp = 15;
> +			break;
> +		case DRM_FORMAT_YUV420_8BIT:
> +			bpp = 12;
> +			break;
> +		default:
> +			bpp = 0;
> +		}
> +	}
> +
> +	return bpp;
> +}
> +
> +static int malidp500_rotmem_required(struct malidp_hw_device *hwdev, u16 w,
> +				     u16 h, u32 fmt, bool has_modifier)
>  {
>  	/*
>  	 * Each layer needs enough rotation memory to fit 8 lines
>  	 * worth of pixel data. Required size is then:
>  	 *    size = rotated_width * (bpp / 8) * 8;
>  	 */
> -	return w * drm_format_plane_cpp(fmt, 0) * 8;
> +	int bpp = malidp_format_get_bpp(fmt);
> +
> +	return w * bpp;
>  }
>  
>  static void malidp500_se_write_pp_coefftab(struct malidp_hw_device *hwdev,
> @@ -660,9 +685,9 @@ static void malidp550_modeset(struct malidp_hw_device *hwdev, struct videomode *
>  		malidp_hw_clearbits(hwdev, MALIDP_DISP_FUNC_ILACED, MALIDP_DE_DISPLAY_FUNC);
>  }
>  
> -static int malidp550_rotmem_required(struct malidp_hw_device *hwdev, u16 w, u16 h, u32 fmt)
> +static int malidpx50_get_bytes_per_column(u32 fmt)
>  {
> -	u32 bytes_per_col;
> +	u32 bytes_per_column;
>  
>  	switch (fmt) {
>  	/* 8 lines at 4 bytes per pixel */
> @@ -688,19 +713,77 @@ static int malidp550_rotmem_required(struct malidp_hw_device *hwdev, u16 w, u16
>  	case DRM_FORMAT_UYVY:
>  	case DRM_FORMAT_YUYV:
>  	case DRM_FORMAT_X0L0:
> -	case DRM_FORMAT_X0L2:
> -		bytes_per_col = 32;
> +		bytes_per_column = 32;
>  		break;
>  	/* 16 lines at 1.5 bytes per pixel */
>  	case DRM_FORMAT_NV12:
>  	case DRM_FORMAT_YUV420:
> -		bytes_per_col = 24;
> +	/* 8 lines at 3 bytes per pixel */
> +	case DRM_FORMAT_VUY888:
> +	/* 16 lines at 12 bits per pixel */
> +	case DRM_FORMAT_YUV420_8BIT:
> +	/* 8 lines at 3 bytes per pixel */
> +	case DRM_FORMAT_P010:
> +		bytes_per_column = 24;
> +		break;
> +	/* 8 lines at 30 bits per pixel */
> +	case DRM_FORMAT_VUY101010:
> +	/* 16 lines at 15 bits per pixel */
> +	case DRM_FORMAT_YUV420_10BIT:
> +		bytes_per_column = 30;
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> -	return w * bytes_per_col;
> +	return bytes_per_column;
> +}
> +
> +static int malidp550_rotmem_required(struct malidp_hw_device *hwdev, u16 w,
> +				     u16 h, u32 fmt, bool has_modifier)
> +{
> +	int bytes_per_column = 0;
> +
> +	switch (fmt) {
> +	/* 8 lines at 15 bits per pixel */
> +	case DRM_FORMAT_YUV420_10BIT:
> +		bytes_per_column = 15;
> +		break;
> +	/* Uncompressed YUV 420 10 bit single plane cannot be rotated */
> +	case DRM_FORMAT_X0L2:
> +		if (has_modifier)
> +			bytes_per_column = 8;
> +		else
> +			return -EINVAL;
> +		break;
> +	default:
> +		bytes_per_column = malidpx50_get_bytes_per_column(fmt);
> +	}
> +
> +	if (bytes_per_column == -EINVAL)
> +		return bytes_per_column;
> +
> +	return w * bytes_per_column;
> +}
> +
> +static int malidp650_rotmem_required(struct malidp_hw_device *hwdev, u16 w,
> +				     u16 h, u32 fmt, bool has_modifier)
> +{
> +	int bytes_per_column = 0;
> +
> +	switch (fmt) {
> +	/* 16 lines at 2 bytes per pixel */
> +	case DRM_FORMAT_X0L2:
> +		bytes_per_column = 32;
> +		break;
> +	default:
> +		bytes_per_column = malidpx50_get_bytes_per_column(fmt);
> +	}
> +
> +	if (bytes_per_column == -EINVAL)
> +		return bytes_per_column;
> +
> +	return w * bytes_per_column;
>  }
>  
>  static int malidp550_se_set_scaling_coeffs(struct malidp_hw_device *hwdev,
> @@ -979,7 +1062,7 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICES] = {
>  		.in_config_mode = malidp550_in_config_mode,
>  		.set_config_valid = malidp550_set_config_valid,
>  		.modeset = malidp550_modeset,
> -		.rotmem_required = malidp550_rotmem_required,
> +		.rotmem_required = malidp650_rotmem_required,
>  		.se_set_scaling_coeffs = malidp550_se_set_scaling_coeffs,
>  		.se_calc_mclk = malidp550_se_calc_mclk,
>  		.enable_memwrite = malidp550_enable_memwrite,
> diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
> index 52188f0..e89a06a 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.h
> +++ b/drivers/gpu/drm/arm/malidp_hw.h
> @@ -184,7 +184,8 @@ struct malidp_hw {
>  	 * Calculate the required rotation memory given the active area
>  	 * and the buffer format.
>  	 */
> -	int (*rotmem_required)(struct malidp_hw_device *hwdev, u16 w, u16 h, u32 fmt);
> +	int (*rotmem_required)(struct malidp_hw_device *hwdev, u16 w, u16 h,
> +			       u32 fmt, bool has_modifier);
>  
>  	int (*se_set_scaling_coeffs)(struct malidp_hw_device *hwdev,
>  				     struct malidp_se_config *se_config,
> @@ -326,6 +327,8 @@ void malidp_se_irq_fini(struct malidp_hw_device *hwdev);
>  u8 malidp_hw_get_format_id(const struct malidp_hw_regmap *map,
>  			   u8 layer_id, u32 format, bool has_modifier);
>  
> +int malidp_format_get_bpp(u32 fmt);
> +
>  static inline u8 malidp_hw_get_pitch_align(struct malidp_hw_device *hwdev, bool rotated)
>  {
>  	/*
> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> index 0765cee..d0a00ee 100644
> --- a/drivers/gpu/drm/arm/malidp_planes.c
> +++ b/drivers/gpu/drm/arm/malidp_planes.c
> @@ -595,7 +595,8 @@ static int malidp_de_plane_check(struct drm_plane *plane,
>  
>  		val = mp->hwdev->hw->rotmem_required(mp->hwdev, state->crtc_w,
>  						     state->crtc_h,
> -						     fb->format->format);
> +						     fb->format->format,
> +						     !!(fb->modifier));
>  		if (val < 0)
>  			return val;
>  
> -- 
> 2.7.4
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
