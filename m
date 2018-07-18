Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FA3ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395E72084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395E72084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeGRKzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:55:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:25358 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbeGRKzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:55:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2018 03:17:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,369,1526367600"; 
   d="scan'208";a="57800717"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga008.jf.intel.com with SMTP; 18 Jul 2018 03:17:42 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 18 Jul 2018 13:17:41 +0300
Date:   Wed, 18 Jul 2018 13:17:41 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Ayan Kumar Halder <ayan.halder@arm.com>
Cc:     liviu.dudau@arm.com, brian.starkey@arm.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        intel-gfx@lists.freedesktop.org, hjc@rock-chips.com,
        heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com,
        sre@kernel.org, bparrot@ti.com, peter.ujfalusi@ti.com, afd@ti.com,
        dri-devel@lists.freedesktop.org, maxime.ripard@bootlin.com,
        wens@csie.org, malidp@foss.arm.com, nd@arm.com
Subject: Re: [Intel-gfx] [PATCH 4/5] drm/omapdrm: Substitute format_is_yuv()
 with format->is_yuv
Message-ID: <20180718101741.GU5565@intel.com>
References: <1531847626-22248-1-git-send-email-ayan.halder@arm.com>
 <1531847626-22248-4-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531847626-22248-4-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 06:13:45PM +0100, Ayan Kumar Halder wrote:
> drm_format_info table has a field 'is_yuv' to denote if the format
> is yuv or not. The driver is expected to use this instead of
> having a function for the same purpose.
> 
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> ---
>  drivers/gpu/drm/omapdrm/dss/dispc.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
> index 84f274c..8d2d7a4 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dispc.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
> @@ -1140,18 +1140,6 @@ static void dispc_ovl_set_color_mode(struct dispc_device *dispc,
>  	REG_FLD_MOD(dispc, DISPC_OVL_ATTRIBUTES(plane), m, 4, 1);
>  }
>  
> -static bool format_is_yuv(u32 fourcc)
> -{
> -	switch (fourcc) {
> -	case DRM_FORMAT_YUYV:
> -	case DRM_FORMAT_UYVY:
> -	case DRM_FORMAT_NV12:
> -		return true;
> -	default:
> -		return false;
> -	}
> -}
> -
>  static void dispc_ovl_configure_burst_type(struct dispc_device *dispc,
>  					   enum omap_plane_id plane,
>  					   enum omap_dss_rotation_type rotation)
> @@ -1910,11 +1898,14 @@ static void dispc_ovl_set_scaling_uv(struct dispc_device *dispc,
>  	int scale_x = out_width != orig_width;
>  	int scale_y = out_height != orig_height;
>  	bool chroma_upscale = plane != OMAP_DSS_WB;
> +	const struct drm_format_info *info;
> +
> +	info = drm_format_info(fourcc);

Not sure Tomi wants drm usage (apart from the fourccs) inside the
dss code.

>  
>  	if (!dispc_has_feature(dispc, FEAT_HANDLE_UV_SEPARATE))
>  		return;
>  
> -	if (!format_is_yuv(fourcc)) {
> +	if (!info->is_yuv) {
>  		/* reset chroma resampling for RGB formats  */
>  		if (plane != OMAP_DSS_WB)
>  			REG_FLD_MOD(dispc, DISPC_OVL_ATTRIBUTES2(plane),
> @@ -2632,6 +2623,9 @@ static int dispc_ovl_setup_common(struct dispc_device *dispc,
>  	bool ilace = !!(vm->flags & DISPLAY_FLAGS_INTERLACED);
>  	unsigned long pclk = dispc_plane_pclk_rate(dispc, plane);
>  	unsigned long lclk = dispc_plane_lclk_rate(dispc, plane);
> +	const struct drm_format_info *info;
> +
> +	info = drm_format_info(fourcc);
>  
>  	/* when setting up WB, dispc_plane_pclk_rate() returns 0 */
>  	if (plane == OMAP_DSS_WB)
> @@ -2640,7 +2634,7 @@ static int dispc_ovl_setup_common(struct dispc_device *dispc,
>  	if (paddr == 0 && rotation_type != OMAP_DSS_ROT_TILER)
>  		return -EINVAL;
>  
> -	if (format_is_yuv(fourcc) && (in_width & 1)) {
> +	if (info->is_yuv && (in_width & 1)) {
>  		DSSERR("input width %d is not even for YUV format\n", in_width);
>  		return -EINVAL;
>  	}
> @@ -2680,7 +2674,7 @@ static int dispc_ovl_setup_common(struct dispc_device *dispc,
>  		DSSDBG("predecimation %d x %x, new input size %d x %d\n",
>  			x_predecim, y_predecim, in_width, in_height);
>  
> -	if (format_is_yuv(fourcc) && (in_width & 1)) {
> +	if (info->is_yuv && (in_width & 1)) {
>  		DSSDBG("predecimated input width is not even for YUV format\n");
>  		DSSDBG("adjusting input width %d -> %d\n",
>  			in_width, in_width & ~1);
> @@ -2688,7 +2682,7 @@ static int dispc_ovl_setup_common(struct dispc_device *dispc,
>  		in_width &= ~1;
>  	}
>  
> -	if (format_is_yuv(fourcc))
> +	if (info->is_yuv)
>  		cconv = 1;
>  
>  	if (ilace && !fieldmode) {
> -- 
> 2.7.4
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Ville Syrjälä
Intel
