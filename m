Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753480AbeE3N2H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:28:07 -0400
Received: from foss.arm.com ([217.140.101.70]:56192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751547AbeE3N2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:28:04 -0400
Date: Wed, 30 May 2018 14:27:55 +0100
From: Brian Starkey <brian.starkey@arm.com>
To: Lowry Li <lowry.li@arm.com>
Cc: liviu.dudau@arm.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, daniel.vetter@intel.com,
        jani.nikula@linux.intel.com, seanpaul@chromium.org, airlied@linux.ie,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, malidp@foss.arm.com, nd@arm.com
Subject: Re: [PATCH v2 1/2] drm/blend: Add per-plane pixel blend mode property
Message-ID: <20180530132755.GA27705@e107564-lin.cambridge.arm.com>
References: <1527679434-13228-1-git-send-email-lowry.li@arm.com>
 <1527679434-13228-2-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1527679434-13228-2-git-send-email-lowry.li@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lowry,

On Wed, May 30, 2018 at 07:23:53PM +0800, Lowry Li wrote:
>Pixel blend modes represent the alpha blending equation
>selection, describing how the pixels from the current
>plane are composited with the background.
>
>Add a pixel_blend_mode to drm_plane_state and a
>blend_mode_property to drm_plane, and related support
>functions.
>
>Defines three blend modes in drm_blend.h.
>
>Signed-off-by: Lowry Li <lowry.li@arm.com>

With or without the kerneldoc tweaks I've suggested below, this patch
is:

Reviewed-by: Brian Starkey <brian.starkey@arm.com>

>---
> drivers/gpu/drm/drm_atomic.c        |   4 ++
> drivers/gpu/drm/drm_atomic_helper.c |   1 +
> drivers/gpu/drm/drm_blend.c         | 110 ++++++++++++++++++++++++++++++++++++
> include/drm/drm_blend.h             |   6 ++
> include/drm/drm_plane.h             |   6 ++
> 5 files changed, 127 insertions(+)
>
>diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
>index 7d25c42..467f8de 100644
>--- a/drivers/gpu/drm/drm_atomic.c
>+++ b/drivers/gpu/drm/drm_atomic.c
>@@ -783,6 +783,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
> 		state->src_w = val;
> 	} else if (property == config->prop_src_h) {
> 		state->src_h = val;
>+	} else if (property == plane->blend_mode_property) {
>+		state->pixel_blend_mode = val;
> 	} else if (property == plane->rotation_property) {
> 		if (!is_power_of_2(val & DRM_MODE_ROTATE_MASK))
> 			return -EINVAL;
>@@ -848,6 +850,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
> 		*val = state->src_w;
> 	} else if (property == config->prop_src_h) {
> 		*val = state->src_h;
>+	} else if (property == plane->blend_mode_property) {
>+		*val = state->pixel_blend_mode;
> 	} else if (property == plane->rotation_property) {
> 		*val = state->rotation;
> 	} else if (property == plane->zpos_property) {
>diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
>index c356545..ddbd0d2 100644
>--- a/drivers/gpu/drm/drm_atomic_helper.c
>+++ b/drivers/gpu/drm/drm_atomic_helper.c
>@@ -3484,6 +3484,7 @@ void drm_atomic_helper_plane_reset(struct drm_plane *plane)
> 	if (plane->state) {
> 		plane->state->plane = plane;
> 		plane->state->rotation = DRM_MODE_ROTATE_0;
>+		plane->state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
> 	}
> }
> EXPORT_SYMBOL(drm_atomic_helper_plane_reset);
>diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
>index 5a81e1b..4ac45da 100644
>--- a/drivers/gpu/drm/drm_blend.c
>+++ b/drivers/gpu/drm/drm_blend.c
>@@ -100,6 +100,41 @@
>  *	planes. Without this property the primary plane is always below the cursor
>  *	plane, and ordering between all other planes is undefined.
>  *
>+ * pixel blend mode:
>+ *	Pixel blend mode is set up with drm_plane_create_blend_mode_property().
>+ *	It adds a blend mode for alpha blending equation selection, describing
>+ *	how the pixels from the current plane are composited with the
>+ *	background.
>+ *
>+ *	Three alpha blending equations(note that the fg.rgb or bg.rgb notation
>+ *	means each of the R, G or B channels for the foreground and background
>+ *	colors, respectively):
>+ *
>+ *	"None": Blend formula that ignores the pixel alpha.
>+ *	out.rgb = plane_alpha * fg.rgb + (1 - plane_alpha) * bg.rgb
>+ *
>+ *	"Pre-multiplied": Blend formula that assumes the pixel color values
>+ *	have been already pre-multiplied with the alpha
>+ *	channel values.
>+ *	out.rgb = plane_alpha * fg.rgb + (1 - (plane_alpha * fg.alpha)) * bg.rgb
>+ *
>+ *	"Coverage": Blend formula that assumes the pixel color values have not
>+ *	been pre-multiplied and will do so when blending them to the background
>+ *	color values.
>+ *	out.rgb = plane_alpha * fg.alpha * fg.rgb +
>+ *		  (1 - (plane_alpha * fg.alpha)) * bg.rgb
>+ *
>+ *	fg.rgb: Each of the RGB component values from the plane's pixel
>+ *	fg.alpha: Alpha component value from the plane's pixel
>+ *	bg.rgb: Each of the RGB component values from the background
>+ *	plane_alpha: Plane alpha value set by the plane alpha property (if
>+ *		     applicable).
>+ *
>+ *	This property has no effect on formats with no pixel alpha, as fg.alpha
>+ *	is assumed to be 1.0. If the plane does not expose the "alpha" property,
>+ *	then plane_alpha is assumed to be 1.0, otherwise, it is the value of the
>+ *	"alpha" property.
>+ *

I did a little fiddling to make this render nicely in the
documentation output. If you like it, you can apply the hunk below:

-- >8 --

diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
index 714b0602127d..7b5c3307d4c1 100644
--- a/drivers/gpu/drm/drm_blend.c
+++ b/drivers/gpu/drm/drm_blend.c
@@ -113,34 +113,45 @@
   *	how the pixels from the current plane are composited with the
   *	background.
   *
- *	Three alpha blending equations(note that the fg.rgb or bg.rgb notation
- *	means each of the R, G or B channels for the foreground and background
- *	colors, respectively):
- *
- *	"None": Blend formula that ignores the pixel alpha.
- *	out.rgb = plane_alpha * fg.rgb + (1 - plane_alpha) * bg.rgb
- *
- *	"Pre-multiplied": Blend formula that assumes the pixel color values
- *	have been already pre-multiplied with the alpha
- *	channel values.
- *	out.rgb = plane_alpha * fg.rgb + (1 - (plane_alpha * fg.alpha)) * bg.rgb
- *
- *	"Coverage": Blend formula that assumes the pixel color values have not
- *	been pre-multiplied and will do so when blending them to the background
- *	color values.
- *	out.rgb = plane_alpha * fg.alpha * fg.rgb +
- *		  (1 - (plane_alpha * fg.alpha)) * bg.rgb
- *
- *	fg.rgb: Each of the RGB component values from the plane's pixel
- *	fg.alpha: Alpha component value from the plane's pixel
- *	bg.rgb: Each of the RGB component values from the background
- *	plane_alpha: Plane alpha value set by the plane alpha property (if
- *		     applicable).
- *
- *	This property has no effect on formats with no pixel alpha, as fg.alpha
- *	is assumed to be 1.0. If the plane does not expose the "alpha" property,
- *	then plane_alpha is assumed to be 1.0, otherwise, it is the value of the
- *	"alpha" property.
+ *	Three alpha blending equations are defined:
+ *
+ *	"None":
+ *		Blend formula that ignores the pixel alpha::
+ *
+ *			out.rgb = plane_alpha * fg.rgb +
+ *				(1 - plane_alpha) * bg.rgb
+ *
+ *	"Pre-multiplied":
+ *		Blend formula that assumes the pixel color values
+ *		have been already pre-multiplied with the alpha
+ *		channel values::
+ *
+ *			out.rgb = plane_alpha * fg.rgb +
+ *				(1 - (plane_alpha * fg.alpha)) * bg.rgb
+ *
+ *	"Coverage":
+ *		Blend formula that assumes the pixel color values have not
+ *		been pre-multiplied and will do so when blending them to the
+ *		background color values::
+ *
+ *			out.rgb = plane_alpha * fg.alpha * fg.rgb +
+ *				(1 - (plane_alpha * fg.alpha)) * bg.rgb
+ *
+ *	Using the following symbols:
+ *
+ *	``fg.rgb``:
+ *		Each of the RGB component values from the plane's pixel
+ *	``fg.alpha``:
+ *		Alpha component value from the plane's pixel. If the plane's
+ *		pixel format has no alpha component, then this is assumed to be
+ *		1.0. In these cases, this property has no effect, as all three
+ *		equations become equivalent.
+ *	``bg.rgb``:
+ *		Each of the RGB component values from the background
+ *	``plane_alpha``:
+ *		Plane alpha value set by the plane "alpha" property. If the
+ *		plane does not expose the "alpha" property, then this is
+ *		assumed to be 1.0
   *
   * Note that all the property extensions described here apply either to the
   * plane or the CRTC (e.g. for the background color, which currently is not

-- >8 --

>  * Note that all the property extensions described here apply either to the
>  * plane or the CRTC (e.g. for the background color, which currently is not
>  * exposed and assumed to be black).
>@@ -409,3 +444,78 @@ int drm_atomic_normalize_zpos(struct drm_device *dev,
> 	return 0;
> }
> EXPORT_SYMBOL(drm_atomic_normalize_zpos);
>+
>+/**
>+ * drm_plane_create_blend_mode_property - create a new blend mode property
>+ * @plane: drm plane
>+ * @supported_modes: bitmask of supported modes, must include
>+ *		     BIT(DRM_MODE_BLEND_PREMULTI)
>+ *
>+ * This creates a new property describing the blend mode.
>+ *
>+ * The property exposed to userspace is an enumeration property (see
>+ * drm_property_create_enum()) called "pixel blend mode" and has the
>+ * following enumeration values:
>+ *
>+ * "None": Blend formula that ignores the pixel alpha.
>+ *
>+ * "Pre-multiplied": Blend formula that assumes the pixel color values have
>+ *		     been already pre-multiplied with the alpha channel values.
>+ *
>+ * "Coverage": Blend formula that assumes the pixel color values have not been
>+ *	       pre-multiplied and will do so when blending them to the
>+ *	       background color values.

Similar thing here - if you put the descriptions (after the ":") on a
new line, and indent them one more level, then it renders much more
nicely:

 * "None":
 *	Blend formula that ignores the pixel alpha.

Thanks,
-Brian

>+ *
>+ * RETURNS:
>+ * Zero for success or -errno
>+ */
>+int drm_plane_create_blend_mode_property(struct drm_plane *plane,
>+					 unsigned int supported_modes)
>+{
>+	struct drm_device *dev = plane->dev;
>+	struct drm_property *prop;
>+	static const struct drm_prop_enum_list props[] = {
>+		{ DRM_MODE_BLEND_PIXEL_NONE, "None" },
>+		{ DRM_MODE_BLEND_PREMULTI, "Pre-multiplied" },
>+		{ DRM_MODE_BLEND_COVERAGE, "Coverage" },
>+	};
>+	unsigned int valid_mode_mask = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>+				       BIT(DRM_MODE_BLEND_PREMULTI)   |
>+				       BIT(DRM_MODE_BLEND_COVERAGE);
>+	int i, j = 0;
>+
>+	if (WARN_ON((supported_modes & ~valid_mode_mask) ||
>+		    ((supported_modes & BIT(DRM_MODE_BLEND_PREMULTI)) == 0)))
>+		return -EINVAL;
>+
>+	prop = drm_property_create(dev, DRM_MODE_PROP_ENUM,
>+				   "pixel blend mode",
>+				   hweight32(supported_modes));
>+	if (!prop)
>+		return -ENOMEM;
>+
>+	for (i = 0; i < ARRAY_SIZE(props); i++) {
>+		int ret;
>+
>+		if (!(BIT(props[i].type) & supported_modes))
>+			continue;
>+
>+		ret = drm_property_add_enum(prop, j++, props[i].type,
>+					    props[i].name);
>+
>+		if (ret) {
>+			drm_property_destroy(dev, prop);
>+
>+			return ret;
>+		}
>+	}
>+
>+	drm_object_attach_property(&plane->base, prop, DRM_MODE_BLEND_PREMULTI);
>+	plane->blend_mode_property = prop;
>+
>+	if (plane->state)
>+		plane->state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
>+
>+	return 0;
>+}
>+EXPORT_SYMBOL(drm_plane_create_blend_mode_property);
>diff --git a/include/drm/drm_blend.h b/include/drm/drm_blend.h
>index 1760602..2966c0d 100644
>--- a/include/drm/drm_blend.h
>+++ b/include/drm/drm_blend.h
>@@ -27,6 +27,10 @@
> #include <linux/ctype.h>
> #include <drm/drm_mode.h>
>
>+#define DRM_MODE_BLEND_PIXEL_NONE	0
>+#define DRM_MODE_BLEND_PREMULTI		1
>+#define DRM_MODE_BLEND_COVERAGE		2
>+
> struct drm_device;
> struct drm_atomic_state;
> struct drm_plane;
>@@ -49,4 +53,6 @@ int drm_plane_create_zpos_immutable_property(struct drm_plane *plane,
> 					     unsigned int zpos);
> int drm_atomic_normalize_zpos(struct drm_device *dev,
> 			      struct drm_atomic_state *state);
>+int drm_plane_create_blend_mode_property(struct drm_plane *plane,
>+					 unsigned int supported_modes);
> #endif
>diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
>index f7bf4a4..447ebe7 100644
>--- a/include/drm/drm_plane.h
>+++ b/include/drm/drm_plane.h
>@@ -43,6 +43,8 @@
>  *	plane (in 16.16)
>  * @src_w: width of visible portion of plane (in 16.16)
>  * @src_h: height of visible portion of plane (in 16.16)
>+ * @pixel_blend_mode: how the plane's framebuffer alpha channel is used when
>+ *	blending with the background colour.
>  * @rotation: rotation of the plane
>  * @zpos: priority of the given plane on crtc (optional)
>  *	Note that multiple active planes on the same crtc can have an identical
>@@ -106,6 +108,8 @@ struct drm_plane_state {
> 	uint32_t src_x, src_y;
> 	uint32_t src_h, src_w;
>
>+	uint16_t pixel_blend_mode;
>+
> 	/* Plane rotation */
> 	unsigned int rotation;
>
>@@ -498,6 +502,7 @@ enum drm_plane_type {
>  * @type: type of plane (overlay, primary, cursor)
>  * @zpos_property: zpos property for this plane
>  * @rotation_property: rotation property for this plane
>+ * @blend_mode_property: blend mode property for this plane
>  * @helper_private: mid-layer private data
>  */
> struct drm_plane {
>@@ -573,6 +578,7 @@ struct drm_plane {
>
> 	struct drm_property *zpos_property;
> 	struct drm_property *rotation_property;
>+	struct drm_property *blend_mode_property;
>
> 	/**
> 	 * @color_encoding_property:
>-- 
>1.9.1
>
