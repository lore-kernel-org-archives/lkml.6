Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5BFC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9760D2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9760D2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeLDRtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:49:15 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38012 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbeLDRtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:49:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29657A78;
        Tue,  4 Dec 2018 09:49:14 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C97533F59C;
        Tue,  4 Dec 2018 09:49:13 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 28CD76801C3; Tue,  4 Dec 2018 17:49:12 +0000 (GMT)
Date:   Tue, 4 Dec 2018 17:49:12 +0000
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
Subject: Re: [RFC AFBC 07/12] drm/arm/malidp: Define the constraints on each
 supported drm_fourcc format for the AFBC modifiers.
Message-ID: <20181204174912.GO988@e110455-lin.cambridge.arm.com>
References: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
 <1543836703-8491-8-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543836703-8491-8-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:32:01AM +0000, Ayan Halder wrote:
> The constraints are as follows (for Mali-DP 500, 550, 650) :-
> 
> 1. AFBC is not supported for the formats defined in malidp_hw_format_is_linear_only()
> 
> 2. Some of the formats are supported only with AFBC modifiers. Thus we have
> introduced a new function 'malidp_hw_format_is_afbc_only()' which verifies the same.
> 
> 3. AFBC_FORMAT_MOD_YTR needs to be provided for any RGB format.
> 
> 4. Formats <= 16bpp cannot support AFBC_FORMAT_MOD_SPLIT.
> 
> 5. CBR should not be set for non-subsampled formats.
> 
> 6. SMART layer does not support framebuffer with AFBC modifiers.
> Return -EINVAL for such a scenario.
> 
> 7. AFBC_FORMAT_MOD_YTR is not supported for any YUV formats.
> 
> 8. Formats which are subsampled cannot support AFBC_FORMAT_MOD_SPLIT. However in
> DP550, YUV_420_10BIT is supported with AFBC_FORMAT_MOD_SPLIT. This feature has
> been identified with MALIDP_DEVICE_AFBC_YUV_420_10_SUPPORT_SPLIT.
> 
> 9. In DP550 and DP650, for YUYV, the hardware supports different format-ids to
> be used with and without AFBC modifier. We have used the feature
> 'MALIDP_DEVICE_AFBC_YUYV_USE_422_P2' to identify this characteristic.
> 
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> ---
>  drivers/gpu/drm/arm/malidp_drv.c    |  23 +------
>  drivers/gpu/drm/arm/malidp_drv.h    |   6 ++
>  drivers/gpu/drm/arm/malidp_hw.c     |  71 +++++++++++++++++++--
>  drivers/gpu/drm/arm/malidp_hw.h     |   5 +-
>  drivers/gpu/drm/arm/malidp_mw.c     |   2 +-
>  drivers/gpu/drm/arm/malidp_planes.c | 124 +++++++++++++++++++++++++++++++++++-
>  6 files changed, 199 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index b8db92f..2f0b553 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -264,29 +264,8 @@ static bool
>  malidp_verify_afbc_framebuffer_caps(struct drm_device *dev,
>  				    const struct drm_mode_fb_cmd2 *mode_cmd)
>  {
> -	const struct drm_format_info *info;
> -
> -	if ((mode_cmd->modifier[0] >> 56) != DRM_FORMAT_MOD_VENDOR_ARM) {
> -		DRM_DEBUG_KMS("Unknown modifier (not Arm)\n");
> +	if (malidp_format_mod_supported(dev, mode_cmd->pixel_format, mode_cmd->modifier[0]) == false)
>  		return false;
> -	}
> -
> -	if (mode_cmd->modifier[0] &
> -	    ~DRM_FORMAT_MOD_ARM_AFBC(AFBC_MOD_VALID_BITS)) {
> -		DRM_DEBUG_KMS("Unsupported modifiers\n");
> -		return false;
> -	}
> -
> -	info = drm_get_format_info(dev, mode_cmd);
> -	if (!info) {
> -		DRM_DEBUG_KMS("Unable to get the format information\n");
> -		return false;
> -	}
> -
> -	if (info->num_planes != 1) {
> -		DRM_DEBUG_KMS("AFBC buffers expect one plane\n");
> -		return false;
> -	}
>  
>  	if (mode_cmd->offsets[0] != 0) {
>  		DRM_DEBUG_KMS("AFBC buffers' plane offset should be 0\n");
> diff --git a/drivers/gpu/drm/arm/malidp_drv.h b/drivers/gpu/drm/arm/malidp_drv.h
> index b76c86f..019a682 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.h
> +++ b/drivers/gpu/drm/arm/malidp_drv.h
> @@ -90,6 +90,12 @@ struct malidp_crtc_state {
>  int malidp_de_planes_init(struct drm_device *drm);
>  int malidp_crtc_init(struct drm_device *drm);
>  
> +bool malidp_hw_format_is_linear_only(u32 format);
> +bool malidp_hw_format_is_afbc_only(u32 format);
> +
> +bool malidp_format_mod_supported(struct drm_device *drm,
> +				 u32 format, u64 modifier);
> +
>  #ifdef CONFIG_DEBUG_FS
>  void malidp_error(struct malidp_drm *malidp,
>  		  struct malidp_error_stats *error_stats, u32 status,
> diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> index 25ac5890..4a774be 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.c
> +++ b/drivers/gpu/drm/arm/malidp_hw.c
> @@ -60,6 +60,8 @@ static const struct malidp_format_id malidp500_de_formats[] = {
>  #define MALIDP_ID(__group, __format) \
>  	((((__group) & 0x7) << 3) | ((__format) & 0x7))
>  
> +#define AFBC_YUV_422_FORMAT_ID	MALIDP_ID(5, 1)
> +
>  #define MALIDP_COMMON_FORMATS \
>  	/*    fourcc,   layers supporting the format,      internal id   */ \
>  	{ DRM_FORMAT_ARGB2101010, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | SE_MEMWRITE, MALIDP_ID(0, 0) }, \
> @@ -887,7 +889,10 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICES] = {
>  			.se_base = MALIDP550_SE_BASE,
>  			.dc_base = MALIDP550_DC_BASE,
>  			.out_depth_base = MALIDP550_DE_OUTPUT_DEPTH,
> -			.features = MALIDP_REGMAP_HAS_CLEARIRQ | MALIDP_DEVICE_AFBC_SUPPORT_SPLIT | AFBC_SUPPORT_SPLIT_WITH_YUV_420_10,
> +			.features = MALIDP_REGMAP_HAS_CLEARIRQ |
> +				    MALIDP_DEVICE_AFBC_SUPPORT_SPLIT |
> +				    MALIDP_DEVICE_AFBC_YUV_420_10_SUPPORT_SPLIT |

Please roll some of these changes into patch 5/12.

> +				    MALIDP_DEVICE_AFBC_YUYV_USE_422_P2,
>  			.n_layers = ARRAY_SIZE(malidp550_layers),
>  			.layers = malidp550_layers,
>  			.de_irq_map = {
> @@ -933,7 +938,9 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICES] = {
>  			.se_base = MALIDP550_SE_BASE,
>  			.dc_base = MALIDP550_DC_BASE,
>  			.out_depth_base = MALIDP550_DE_OUTPUT_DEPTH,
> -			.features = MALIDP_REGMAP_HAS_CLEARIRQ | MALIDP_DEVICE_AFBC_SUPPORT_SPLIT,
> +			.features = MALIDP_REGMAP_HAS_CLEARIRQ |
> +				    MALIDP_DEVICE_AFBC_SUPPORT_SPLIT |
> +				    MALIDP_DEVICE_AFBC_YUYV_USE_422_P2,
>  			.n_layers = ARRAY_SIZE(malidp650_layers),
>  			.layers = malidp650_layers,
>  			.de_irq_map = {
> @@ -982,19 +989,73 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICES] = {
>  };
>  
>  u8 malidp_hw_get_format_id(const struct malidp_hw_regmap *map,
> -			   u8 layer_id, u32 format)
> +			   u8 layer_id, u32 format, bool has_modifier)
>  {
>  	unsigned int i;
>  
>  	for (i = 0; i < map->n_pixel_formats; i++) {
>  		if (((map->pixel_formats[i].layer & layer_id) == layer_id) &&
> -		    (map->pixel_formats[i].format == format))
> -			return map->pixel_formats[i].id;
> +		    (map->pixel_formats[i].format == format)) {
> +
> +			/*
> +			 * In some DP550 and DP650, DRM_FORMAT_YUYV + AFBC modifier
> +			 * is supported by a different h/w format id than
> +			 * DRM_FORMAT_YUYV (only).
> +			 */
> +			if (format == DRM_FORMAT_YUYV &&
> +			    (has_modifier) &&
> +			    (map->features & MALIDP_DEVICE_AFBC_YUYV_USE_422_P2))
> +				return AFBC_YUV_422_FORMAT_ID;
> +			else
> +				return map->pixel_formats[i].id;
> +		}
>  	}
>  
>  	return MALIDP_INVALID_FORMAT_ID;
>  }
>  
> +bool malidp_hw_format_is_linear_only(u32 format)
> +{
> +	switch (format) {
> +	case DRM_FORMAT_ARGB2101010:
> +	case DRM_FORMAT_RGBA1010102:
> +	case DRM_FORMAT_BGRA1010102:
> +	case DRM_FORMAT_ARGB8888:
> +	case DRM_FORMAT_RGBA8888:
> +	case DRM_FORMAT_BGRA8888:
> +	case DRM_FORMAT_XBGR8888:
> +	case DRM_FORMAT_XRGB8888:
> +	case DRM_FORMAT_RGBX8888:
> +	case DRM_FORMAT_BGRX8888:
> +	case DRM_FORMAT_RGB888:
> +	case DRM_FORMAT_RGB565:
> +	case DRM_FORMAT_ARGB1555:
> +	case DRM_FORMAT_RGBA5551:
> +	case DRM_FORMAT_BGRA5551:
> +	case DRM_FORMAT_UYVY:
> +	case DRM_FORMAT_XYUV8888:
> +	case DRM_FORMAT_XVYU2101010:
> +	case DRM_FORMAT_X0L2:
> +	case DRM_FORMAT_X0L0:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +bool malidp_hw_format_is_afbc_only(u32 format)
> +{
> +	switch (format) {
> +	case DRM_FORMAT_VUY888:
> +	case DRM_FORMAT_VUY101010:
> +	case DRM_FORMAT_YUV420_8BIT:
> +	case DRM_FORMAT_YUV420_10BIT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static void malidp_hw_clear_irq(struct malidp_hw_device *hwdev, u8 block, u32 irq)
>  {
>  	u32 base = malidp_get_block_base(hwdev, block);
> diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
> index 27b907f..52188f0 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.h
> +++ b/drivers/gpu/drm/arm/malidp_hw.h
> @@ -97,7 +97,8 @@ struct malidp_se_config {
>  /* regmap features */
>  #define MALIDP_REGMAP_HAS_CLEARIRQ				BIT(0)
>  #define MALIDP_DEVICE_AFBC_SUPPORT_SPLIT			BIT(1)
> -#define AFBC_SUPPORT_SPLIT_WITH_YUV_420_10			BIT(2)
> +#define MALIDP_DEVICE_AFBC_YUV_420_10_SUPPORT_SPLIT		BIT(2)
> +#define MALIDP_DEVICE_AFBC_YUYV_USE_422_P2			BIT(3)
>  
>  struct malidp_hw_regmap {
>  	/* address offset of the DE register bank */
> @@ -323,7 +324,7 @@ int malidp_se_irq_init(struct drm_device *drm, int irq);
>  void malidp_se_irq_fini(struct malidp_hw_device *hwdev);
>  
>  u8 malidp_hw_get_format_id(const struct malidp_hw_regmap *map,
> -			   u8 layer_id, u32 format);
> +			   u8 layer_id, u32 format, bool has_modifier);
>  
>  static inline u8 malidp_hw_get_pitch_align(struct malidp_hw_device *hwdev, bool rotated)
>  {
> diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
> index 91472e5..0484744 100644
> --- a/drivers/gpu/drm/arm/malidp_mw.c
> +++ b/drivers/gpu/drm/arm/malidp_mw.c
> @@ -143,7 +143,7 @@ malidp_mw_encoder_atomic_check(struct drm_encoder *encoder,
>  
>  	mw_state->format =
>  		malidp_hw_get_format_id(&malidp->dev->hw->map, SE_MEMWRITE,
> -					fb->format->format);
> +					fb->format->format, !!fb->modifier);
>  	if (mw_state->format == MALIDP_INVALID_FORMAT_ID) {
>  		struct drm_format_name_buf format_name;
>  
> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> index cd60f73..0765cee 100644
> --- a/drivers/gpu/drm/arm/malidp_planes.c
> +++ b/drivers/gpu/drm/arm/malidp_planes.c
> @@ -52,6 +52,8 @@
>  #define MALIDP550_LS_ENABLE		0x01c
>  #define MALIDP550_LS_R1_IN_SIZE		0x020
>  
> +#define MODIFIERS_COUNT_MAX		15
> +
>  /*
>   * This 4-entry look-up-table is used to determine the full 8-bit alpha value
>   * for formats with 1- or 2-bit alpha channels.
> @@ -145,6 +147,117 @@ static void malidp_plane_atomic_print_state(struct drm_printer *p,
>  	drm_printf(p, "\tmmu_prefetch_pgsize=%d\n", ms->mmu_prefetch_pgsize);
>  }
>  
> +bool malidp_format_mod_supported(struct drm_device *drm,
> +				 u32 format, u64 modifier)
> +{
> +	const struct drm_format_info *info;
> +	const u64 *modifiers;
> +	struct malidp_drm *malidp = drm->dev_private;
> +	const struct malidp_hw_regmap *map = &malidp->dev->hw->map;
> +
> +	if (WARN_ON(modifier == DRM_FORMAT_MOD_INVALID))
> +		return false;
> +
> +	/* Some pixel formats are supported without any modifier */
> +	if (modifier == DRM_FORMAT_MOD_LINEAR) {
> +		/* However these pixel formats need to be supported with

Nitpick: multi-line comment style is to start with a line that contains
only the marker for the start of the comment.

> +		 * modifiers only
> +		 */
> +		return !malidp_hw_format_is_afbc_only(format);
> +	}
> +
> +	if ((modifier >> 56) != DRM_FORMAT_MOD_VENDOR_ARM) {
> +		DRM_ERROR("Unknown modifier (not Arm)\n");
> +		return false;
> +	}
> +
> +	if (modifier &
> +	    ~DRM_FORMAT_MOD_ARM_AFBC(AFBC_MOD_VALID_BITS)) {
> +		DRM_DEBUG_KMS("Unsupported modifiers\n");
> +		return false;
> +	}
> +
> +	modifiers = malidp_format_modifiers;

Actually, looking again at patch 5/12 it looks to me like you could roll
it into this patch completely.

> +	while (*modifiers != DRM_FORMAT_MOD_INVALID) {
> +		if (*modifiers == modifier) {
> +			/* SPLIT buffers must use SPARSE layout */
> +			if (WARN_ON_ONCE((modifier & AFBC_SPLIT) && !(modifier & AFBC_SPARSE)))
> +				return false;
> +
> +			/* CBR only applies to YUV formats, where YTR should be always 0 */
> +			if (WARN_ON_ONCE((modifier & AFBC_CBR) && (modifier & AFBC_YTR)))
> +				return false;

You can take these checks outside the while() loop as they test if the
modifier passed as a parameter is valid, which you should check before
running through the array. If you do that, then the loop through the
malidp_format_modifiers is a simple "if found, break out of loop" and
then the next check will return false if you iterated over the entire
list.

> +
> +			break;
> +		}
> +
> +		modifiers++;
> +	}
> +
> +	/* return false, if the modifier was not found */
> +	if (*modifiers == DRM_FORMAT_MOD_INVALID) {
> +		DRM_DEBUG_KMS("Unsupported modifier\n");
> +		return false;
> +	}
> +
> +	info = drm_format_info(format);
> +
> +	if (info->num_planes != 1) {
> +		DRM_DEBUG_KMS("AFBC buffers expect one plane\n");
> +		return false;
> +	}
> +
> +	if (malidp_hw_format_is_linear_only(format) == true) {
> +		DRM_DEBUG_KMS("Given format (0x%x) is supported is linear mode only\n", format);
> +		return false;
> +	}
> +
> +	/*
> +	 * RGB formats need to provide YTR modifier and YUV formats should not
> +	 * provide YTR modifier.
> +	 */
> +	if (!(info->is_yuv) != !!(modifier & AFBC_FORMAT_MOD_YTR)) {
> +		DRM_DEBUG_KMS("AFBC_FORMAT_MOD_YTR is %s for %s formats\n",
> +			      info->is_yuv ? "disallowed" : "mandatory",
> +			      info->is_yuv ? "YUV" : "RGB");
> +		return false;
> +	}
> +
> +	if (modifier & AFBC_SPLIT) {
> +		if (!info->is_yuv) {
> +			if (drm_format_plane_cpp(format, 0) <= 2) {
> +				DRM_DEBUG_KMS("RGB formats <= 16bpp are not supported with SPLIT\n");
> +				return false;
> +			}
> +		}
> +
> +		if ((drm_format_horz_chroma_subsampling(format) != 1) ||
> +		    (drm_format_vert_chroma_subsampling(format) != 1)) {
> +			if (!(format == DRM_FORMAT_YUV420_10BIT &&
> +			     (map->features & MALIDP_DEVICE_AFBC_YUV_420_10_SUPPORT_SPLIT))) {
> +				DRM_DEBUG_KMS("Formats which are sub-sampled should never be split\n");
> +				return false;
> +			}
> +		}
> +	}
> +
> +	if (modifier & AFBC_CBR) {
> +		if ((drm_format_horz_chroma_subsampling(format) == 1) ||
> +		    (drm_format_vert_chroma_subsampling(format) == 1)) {
> +			DRM_DEBUG_KMS("Formats which are not sub-sampled should not have CBR set\n");
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +static bool malidp_format_mod_supported_per_plane(struct drm_plane *plane,
> +						  u32 format, u64 modifier)
> +{
> +	return malidp_format_mod_supported(plane->dev, format, modifier);
> +}
> +
>  static const struct drm_plane_funcs malidp_de_plane_funcs = {
>  	.update_plane = drm_atomic_helper_update_plane,
>  	.disable_plane = drm_atomic_helper_disable_plane,
> @@ -153,6 +266,7 @@ static const struct drm_plane_funcs malidp_de_plane_funcs = {
>  	.atomic_duplicate_state = malidp_duplicate_plane_state,
>  	.atomic_destroy_state = malidp_destroy_plane_state,
>  	.atomic_print_state = malidp_plane_atomic_print_state,
> +	.format_mod_supported = malidp_format_mod_supported_per_plane,
>  };
>  
>  static int malidp_se_check_scaling(struct malidp_plane *mp,
> @@ -406,8 +520,8 @@ static int malidp_de_plane_check(struct drm_plane *plane,
>  	fb = state->fb;
>  
>  	ms->format = malidp_hw_get_format_id(&mp->hwdev->hw->map,
> -					     mp->layer->id,
> -					     fb->format->format);
> +					     mp->layer->id, fb->format->format,
> +					     !!fb->modifier);
>  	if (ms->format == MALIDP_INVALID_FORMAT_ID)
>  		return -EINVAL;
>  
> @@ -469,6 +583,12 @@ static int malidp_de_plane_check(struct drm_plane *plane,
>  			return -EINVAL;
>  	}
>  
> +	/* SMART layer does not support AFBC */
> +	if (mp->layer->id == DE_SMART && fb->modifier) {
> +		DRM_ERROR("AFBC framebuffer not supported in SMART layer");
> +		return -EINVAL;
> +	}
> +
>  	ms->rotmem_size = 0;
>  	if (state->rotation & MALIDP_ROTATED_MASK) {
>  		int val;
> -- 
> 2.7.4
> 

Best regards,
Liviu


-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
