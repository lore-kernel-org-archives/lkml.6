Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934674AbeEIKsN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 06:48:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:44954 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934479AbeEIKsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 06:48:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="54435130"
Date: Wed, 9 May 2018 13:48:06 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Lowry Li <lowry.li@arm.com>
Cc: liviu.dudau@arm.com, airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com, nd@arm.com
Subject: Re: [RFC PATCH] drm: Add per-plane pixel blend mode property
Message-ID: <20180509104806.GL23723@intel.com>
References: <1525775676-32158-1-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1525775676-32158-1-git-send-email-lowry.li@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 06:34:36PM +0800, Lowry Li wrote:
> Pixel blend modes represent the alpha blending equation
> selection, describing how the pixels from the current
> plane are composited with the background.
> 
> Add a pixel_blend_mode to drm_plane_state and a
> blend_mode_property to drm_plane, and related support
> functions.
> 
> Defines three blend modes in drm_blend.h.
> 
> Signed-off-by: Lowry Li <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/drm_atomic.c        |  4 ++
>  drivers/gpu/drm/drm_atomic_helper.c |  1 +
>  drivers/gpu/drm/drm_blend.c         | 95 +++++++++++++++++++++++++++++++++++++
>  include/drm/drm_blend.h             |  6 +++
>  include/drm/drm_plane.h             |  7 +++
>  5 files changed, 113 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index a567310..0bb6de1 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -764,6 +764,8 @@ int drm_atomic_plane_set_property(struct drm_plane *plane,
>  		state->src_w = val;
>  	} else if (property == config->prop_src_h) {
>  		state->src_h = val;
> +	} else if (property == plane->blend_mode_property) {
> +		state->pixel_blend_mode = val;
>  	} else if (property == plane->rotation_property) {
>  		if (!is_power_of_2(val & DRM_ROTATE_MASK))
>  			return -EINVAL;
> @@ -826,6 +828,8 @@ int drm_atomic_plane_set_property(struct drm_plane *plane,
>  		*val = state->src_w;
>  	} else if (property == config->prop_src_h) {
>  		*val = state->src_h;
> +	} else if (property == plane->blend_mode_property) {
> +		*val = state->pixel_blend_mode;
>  	} else if (property == plane->rotation_property) {
>  		*val = state->rotation;
>  	} else if (property == plane->zpos_property) {
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 01d936b..e4377fd 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3133,6 +3133,7 @@ void drm_atomic_helper_plane_reset(struct drm_plane *plane)
>  	if (plane->state) {
>  		plane->state->plane = plane;
>  		plane->state->rotation = DRM_ROTATE_0;
> +		plane->state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
>  	}
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_plane_reset);
> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> index 665aafc..bb938de 100644
> --- a/drivers/gpu/drm/drm_blend.c
> +++ b/drivers/gpu/drm/drm_blend.c
> @@ -98,6 +98,12 @@
>   *   planes. Without this property the primary plane is always below the cursor
>   *   plane, and ordering between all other planes is undefined.
>   *
> + * pixel blend mode:
> + *	Pixel blend mode is set up with drm_plane_create_blend_mode_property().
> + *	It adds a blend mode for alpha blending equation selection, describing
> + *	how the pixels from the current plane are composited with the
> + *	background.
> + *
>   * Note that all the property extensions described here apply either to the
>   * plane or the CRTC (e.g. for the background color, which currently is not
>   * exposed and assumed to be black).
> @@ -405,3 +411,92 @@ int drm_atomic_normalize_zpos(struct drm_device *dev,
>  	return 0;
>  }
>  EXPORT_SYMBOL(drm_atomic_normalize_zpos);
> +
> +/**
> + * drm_plane_create_blend_mode_property - create a new blend mode property
> + * @plane: drm plane
> + * @supported_modes: bitmask of supported modes, must include
> + *		     BIT(DRM_MODE_BLEND_PREMULTI)
> + *
> + * This creates a new property describing the blend mode.
> + *
> + * The property exposed to userspace is an enumeration property (see
> + * drm_property_create_enum()) called "pixel blend mode" and has the
> + * following enumeration values:
> + *
> + * DRM_MODE_BLEND_PIXEL_NONE: Blend formula that ignores the pixel alpha.
> + *	"None"
> + *	out.rgb = plane.alpha * pixel.rgb + (1 - plane.alpha) * bg.rgb
> + *
> + * DRM_MODE_BLEND_PREMULTI: Blend formula that assumes the pixel color values
> + *			    have been already pre-multiplied with the alpha
> + *			    channel values.
> + *	"Pre-multiplied"
> + *	out.rgb = plane.alpha * pixel.rgb +
> + *	      (1 - (plane.alpha * pixel.alpha)) * bg.rgb
> + *
> + * DRM_MODE_BLEND_COVERAGE: Blend formula that assumes the pixel color values
> + *			    have not been pre-multiplied and will do so when
> + *			    blending them to the background color values.
> + *	"Coverage"
> + *	out.rgb = plane.alpha * pixel.alpha * pixel.rgb +
> + *	      (1 - (plane.alpha * pixel.alpha)) * bg.rgb

I'm not a huge fan of these enum value names. "coverage" makes me think
of "alpha to coverage".

Years ago there was quite a bit of dicscussion on this and the concensus
at the at time was to try and model this after the GL blend func. If we
could do that then it would be much easier to see what's going to happen
just by reading the string. 

But actually I'm not sure we can fit any sensible GL blend func like
names in the limited length of the enum value strings. Would be nice
to try at least.

> + *
> + * This property has no effect on formats with no pixel alpha, as pixel.alpha
> + * is assumed to be 1.0. If the plane does not expose the "alpha" property, then
> + * plane.alpha is assumed to be 1.0, otherwise, it is the value of the "alpha"
> + * property.
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
> +	int i, j = 0;
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
> +		ret = drm_property_add_enum(prop, j++, props[i].type,
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
> index 13221cf..6bf95a4 100644
> --- a/include/drm/drm_blend.h
> +++ b/include/drm/drm_blend.h
> @@ -26,6 +26,10 @@
>  #include <linux/list.h>
>  #include <linux/ctype.h>
>  
> +#define DRM_MODE_BLEND_PIXEL_NONE	0
> +#define DRM_MODE_BLEND_PREMULTI		1
> +#define DRM_MODE_BLEND_COVERAGE		2
> +
>  struct drm_device;
>  struct drm_atomic_state;
>  
> @@ -65,4 +69,6 @@ int drm_plane_create_zpos_immutable_property(struct drm_plane *plane,
>  					     unsigned int zpos);
>  int drm_atomic_normalize_zpos(struct drm_device *dev,
>  			      struct drm_atomic_state *state);
> +int drm_plane_create_blend_mode_property(struct drm_plane *plane,
> +					 unsigned int supported_modes);
>  #endif
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index 20867b4..f9cbfee 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -41,6 +41,8 @@
>   *	plane (in 16.16)
>   * @src_w: width of visible portion of plane (in 16.16)
>   * @src_h: height of visible portion of plane (in 16.16)
> + * @pixel_blend_mode: how the plane's framebuffer alpha channel is used when
> + *	blending with the background colour.
>   * @rotation: rotation of the plane
>   * @zpos: priority of the given plane on crtc (optional)
>   *	Note that multiple active planes on the same crtc can have an identical
> @@ -104,6 +106,9 @@ struct drm_plane_state {
>  	uint32_t src_x, src_y;
>  	uint32_t src_h, src_w;
>  
> +	/* Plane pixel blend mode */
> +	uint16_t pixel_blend_mode;
> +
>  	/* Plane rotation */
>  	unsigned int rotation;
>  
> @@ -459,6 +464,7 @@ enum drm_plane_type {
>   * @state: current atomic state for this plane
>   * @zpos_property: zpos property for this plane
>   * @rotation_property: rotation property for this plane
> + * @blend_mode_property: blend mode property for this plane
>   * @helper_private: mid-layer private data
>   */
>  struct drm_plane {
> @@ -506,6 +512,7 @@ struct drm_plane {
>  
>  	struct drm_property *zpos_property;
>  	struct drm_property *rotation_property;
> +	struct drm_property *blend_mode_property;
>  };
>  
>  #define obj_to_plane(x) container_of(x, struct drm_plane, base)
> -- 
> 1.9.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
