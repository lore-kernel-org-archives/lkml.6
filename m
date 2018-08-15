Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F49C46471
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918E6216E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918E6216E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbeHONCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 09:02:23 -0400
Received: from foss.arm.com ([217.140.101.70]:53488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbeHONCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 09:02:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DFDF18A;
        Wed, 15 Aug 2018 03:10:50 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B73C3F5BD;
        Wed, 15 Aug 2018 03:10:50 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 7619F6801CC; Wed, 15 Aug 2018 11:10:48 +0100 (BST)
Date:   Wed, 15 Aug 2018 11:10:48 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Lowry Li <lowry.li@arm.com>
Cc:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        daniel.vetter@intel.com, seanpaul@chromium.org, airlied@linux.ie,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, brian.starkey@arm.com,
        malidp@foss.arm.com, emil.l.velikov@gmail.com, nd@arm.com
Subject: Re: [PATCH v4 1/2] drm: Add per-plane pixel blend mode property
Message-ID: <20180815101048.GI907@e110455-lin.cambridge.arm.com>
References: <1534314933-23182-1-git-send-email-lowry.li@arm.com>
 <1534314933-23182-2-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1534314933-23182-2-git-send-email-lowry.li@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 02:35:32PM +0800, Lowry Li wrote:
> Pixel blend modes represent the alpha blending equation
> selection, describing how the pixels from the current
> plane are composited with the background.
> 
> Adds a pixel_blend_mode to drm_plane_state and a
> blend_mode_property to drm_plane, and related support
> functions.
> 
> Defines three blend modes in drm_blend.h.
> 
> Changes since v1:
>  - Moves the blending equation into the DOC comment
>  - Refines the comments of drm_plane_create_blend_mode_property to not
>    enumerate the #defines, but instead the string values
>  - Uses fg.* instead of pixel.* and plane_alpha instead of plane.alpha
> Changes since v2:
>  - Refines the comments of drm_plane_create_blend_mode_property:
>       1) Puts the descriptions (after the ":") on a new line
>       2) Adds explaining why @supported_modes need PREMUL as default
> Changes since v3:
>  - Refines drm_plane_create_blend_mode_property(). drm_property_add_enum()
>    can calculate the index itself just fine, so no point in having the
>    caller pass it in.
>  - Since the current DRM assumption is that alpha is premultiplied
>    as default, define DRM_MODE_BLEND_PREMULTI as 0 will be better.
>  - Refines some comments.
> 
> Signed-off-by: Lowry Li <lowry.li@arm.com>

Looks good to me!

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks,
Liviu

> ---
>  drivers/gpu/drm/drm_atomic.c        |   4 ++
>  drivers/gpu/drm/drm_atomic_helper.c |   1 +
>  drivers/gpu/drm/drm_blend.c         | 126 ++++++++++++++++++++++++++++++++++++
>  include/drm/drm_blend.h             |   6 ++
>  include/drm/drm_plane.h             |   2 +
>  5 files changed, 139 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 3eb061e..d0478ab 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -895,6 +895,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
>  		state->src_h = val;
>  	} else if (property == plane->alpha_property) {
>  		state->alpha = val;
> +	} else if (property == plane->blend_mode_property) {
> +		state->pixel_blend_mode = val;
>  	} else if (property == plane->rotation_property) {
>  		if (!is_power_of_2(val & DRM_MODE_ROTATE_MASK)) {
>  			DRM_DEBUG_ATOMIC("[PLANE:%d:%s] bad rotation bitmask: 0x%llx\n",
> @@ -968,6 +970,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
>  		*val = state->src_h;
>  	} else if (property == plane->alpha_property) {
>  		*val = state->alpha;
> +	} else if (property == plane->blend_mode_property) {
> +		*val = state->pixel_blend_mode;
>  	} else if (property == plane->rotation_property) {
>  		*val = state->rotation;
>  	} else if (property == plane->zpos_property) {
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 6dd5036..563af09 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3569,6 +3569,7 @@ void __drm_atomic_helper_plane_reset(struct drm_plane *plane,
>  	/* Reset the alpha value to fully opaque if it matters */
>  	if (plane->alpha_property)
>  		state->alpha = plane->alpha_property->values[1];
> +	plane->state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
>  
>  	plane->state = state;
>  }
> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> index a16a74d..24016c9 100644
> --- a/drivers/gpu/drm/drm_blend.c
> +++ b/drivers/gpu/drm/drm_blend.c
> @@ -107,6 +107,52 @@
>   *	planes. Without this property the primary plane is always below the cursor
>   *	plane, and ordering between all other planes is undefined.
>   *
> + * pixel blend mode:
> + *	Pixel blend mode is set up with drm_plane_create_blend_mode_property().
> + *	It adds a blend mode for alpha blending equation selection, describing
> + *	how the pixels from the current plane are composited with the
> + *	background.
> + *
> + *	 Three alpha blending equations are defined:
> + *
> + *	 "None":
> + *		 Blend formula that ignores the pixel alpha::
> + *
> + *			 out.rgb = plane_alpha * fg.rgb +
> + *				 (1 - plane_alpha) * bg.rgb
> + *
> + *	 "Pre-multiplied":
> + *		 Blend formula that assumes the pixel color values
> + *		 have been already pre-multiplied with the alpha
> + *		 channel values::
> + *
> + *			 out.rgb = plane_alpha * fg.rgb +
> + *				 (1 - (plane_alpha * fg.alpha)) * bg.rgb
> + *
> + *	 "Coverage":
> + *		 Blend formula that assumes the pixel color values have not
> + *		 been pre-multiplied and will do so when blending them to the
> + *		 background color values::
> + *
> + *			 out.rgb = plane_alpha * fg.alpha * fg.rgb +
> + *				 (1 - (plane_alpha * fg.alpha)) * bg.rgb
> + *
> + *	 Using the following symbols:
> + *
> + *	 "fg.rgb":
> + *		 Each of the RGB component values from the plane's pixel
> + *	 "fg.alpha":
> + *		 Alpha component value from the plane's pixel. If the plane's
> + *		 pixel format has no alpha component, then this is assumed to be
> + *		 1.0. In these cases, this property has no effect, as all three
> + *		 equations become equivalent.
> + *	 "bg.rgb":
> + *		 Each of the RGB component values from the background
> + *	 "plane_alpha":
> + *		 Plane alpha value set by the plane "alpha" property. If the
> + *		 plane does not expose the "alpha" property, then this is
> + *		 assumed to be 1.0
> + *
>   * Note that all the property extensions described here apply either to the
>   * plane or the CRTC (e.g. for the background color, which currently is not
>   * exposed and assumed to be black).
> @@ -448,3 +494,83 @@ int drm_atomic_normalize_zpos(struct drm_device *dev,
>  	return 0;
>  }
>  EXPORT_SYMBOL(drm_atomic_normalize_zpos);
> +
> +/**
> + * drm_plane_create_blend_mode_property - create a new blend mode property
> + * @plane: drm plane
> + * @supported_modes: bitmask of supported modes, must include
> + *		     BIT(DRM_MODE_BLEND_PREMULTI). Current DRM assumption is
> + *		     that alpha is premultiplied, and old userspace can break if
> + *		     the property defaults to anything else.
> + *
> + * This creates a new property describing the blend mode.
> + *
> + * The property exposed to userspace is an enumeration property (see
> + * drm_property_create_enum()) called "pixel blend mode" and has the
> + * following enumeration values:
> + *
> + * "None":
> + *	Blend formula that ignores the pixel alpha.
> + *
> + * "Pre-multiplied":
> + *	Blend formula that assumes the pixel color values have been already
> + *	pre-multiplied with the alpha channel values.
> + *
> + * "Coverage":
> + *	Blend formula that assumes the pixel color values have not been
> + *	pre-multiplied and will do so when blending them to the background color
> + *	values.
> + *
> + * RETURNS:
> + * Zero for success or -errno
> + */
> +int drm_plane_create_blend_mode_property(struct drm_plane *plane,
> +					 unsigned int supported_modes)
> +{
> +	struct drm_device *dev = plane->dev;
> +	struct drm_property *prop;
> +	static const struct drm_prop_enum_list props[] = {
> +		{ DRM_MODE_BLEND_PIXEL_NONE, "None" },
> +		{ DRM_MODE_BLEND_PREMULTI, "Pre-multiplied" },
> +		{ DRM_MODE_BLEND_COVERAGE, "Coverage" },
> +	};
> +	unsigned int valid_mode_mask = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
> +				       BIT(DRM_MODE_BLEND_PREMULTI)   |
> +				       BIT(DRM_MODE_BLEND_COVERAGE);
> +	int i;
> +
> +	if (WARN_ON((supported_modes & ~valid_mode_mask) ||
> +		    ((supported_modes & BIT(DRM_MODE_BLEND_PREMULTI)) == 0)))
> +		return -EINVAL;
> +
> +	prop = drm_property_create(dev, DRM_MODE_PROP_ENUM,
> +				   "pixel blend mode",
> +				   hweight32(supported_modes));
> +	if (!prop)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < ARRAY_SIZE(props); i++) {
> +		int ret;
> +
> +		if (!(BIT(props[i].type) & supported_modes))
> +			continue;
> +
> +		ret = drm_property_add_enum(prop, props[i].type,
> +					    props[i].name);
> +
> +		if (ret) {
> +			drm_property_destroy(dev, prop);
> +
> +			return ret;
> +		}
> +	}
> +
> +	drm_object_attach_property(&plane->base, prop, DRM_MODE_BLEND_PREMULTI);
> +	plane->blend_mode_property = prop;
> +
> +	if (plane->state)
> +		plane->state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_plane_create_blend_mode_property);
> diff --git a/include/drm/drm_blend.h b/include/drm/drm_blend.h
> index 330c561..88bdfec 100644
> --- a/include/drm/drm_blend.h
> +++ b/include/drm/drm_blend.h
> @@ -27,6 +27,10 @@
>  #include <linux/ctype.h>
>  #include <drm/drm_mode.h>
>  
> +#define DRM_MODE_BLEND_PREMULTI		0
> +#define DRM_MODE_BLEND_COVERAGE		1
> +#define DRM_MODE_BLEND_PIXEL_NONE	2
> +
>  struct drm_device;
>  struct drm_atomic_state;
>  struct drm_plane;
> @@ -52,4 +56,6 @@ int drm_plane_create_zpos_immutable_property(struct drm_plane *plane,
>  					     unsigned int zpos);
>  int drm_atomic_normalize_zpos(struct drm_device *dev,
>  			      struct drm_atomic_state *state);
> +int drm_plane_create_blend_mode_property(struct drm_plane *plane,
> +					 unsigned int supported_modes);
>  #endif
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index 8a152dc..c52614a 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -117,6 +117,7 @@ struct drm_plane_state {
>  	 * details.
>  	 */
>  	u16 alpha;
> +	uint16_t pixel_blend_mode;
>  
>  	/**
>  	 * @rotation:
> @@ -659,6 +660,7 @@ struct drm_plane {
>  	 * drm_plane_create_rotation_property().
>  	 */
>  	struct drm_property *rotation_property;
> +	struct drm_property *blend_mode_property;
>  
>  	/**
>  	 * @color_encoding_property:
> -- 
> 1.9.1
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
