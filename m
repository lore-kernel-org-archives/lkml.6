Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753397AbeFDNte (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:49:34 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42738 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753063AbeFDNt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:49:28 -0400
X-Google-Smtp-Source: ADUXVKK4Bjemf5Q8Pldm7w5UNGFlTUHmxIn8bCPjiPvK1KLeEtlUYVlY7IkKWjru4ZKxQ1DLpW4asWPTs1NLmX9DRkM=
MIME-Version: 1.0
In-Reply-To: <1527856871-3007-2-git-send-email-lowry.li@arm.com>
References: <1527856871-3007-1-git-send-email-lowry.li@arm.com> <1527856871-3007-2-git-send-email-lowry.li@arm.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Mon, 4 Jun 2018 14:49:26 +0100
Message-ID: <CACvgo53z9_DLXDXVgsvX6eVRr+-OXuJYu8_q2kANFTgyWCeacQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm: Add per-plane pixel blend mode property
To: Lowry Li <lowry.li@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Mali DP Maintainers <malidp@foss.arm.com>, nd@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 June 2018 at 13:41, Lowry Li <lowry.li@arm.com> wrote:
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
>  drivers/gpu/drm/drm_atomic.c        |   4 ++
>  drivers/gpu/drm/drm_atomic_helper.c |   1 +
>  drivers/gpu/drm/drm_blend.c         | 126 ++++++++++++++++++++++++++++++++++++
>  include/drm/drm_blend.h             |   6 ++
>  include/drm/drm_plane.h             |   5 ++
>  5 files changed, 142 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 07fef42..1d18389 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -785,6 +785,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
>                 state->src_h = val;
>         } else if (property == plane->alpha_property) {
>                 state->alpha = val;
> +       } else if (property == plane->blend_mode_property) {
> +               state->pixel_blend_mode = val;
>         } else if (property == plane->rotation_property) {
>                 if (!is_power_of_2(val & DRM_MODE_ROTATE_MASK))
>                         return -EINVAL;
> @@ -852,6 +854,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
>                 *val = state->src_h;
>         } else if (property == plane->alpha_property) {
>                 *val = state->alpha;
> +       } else if (property == plane->blend_mode_property) {
> +               *val = state->pixel_blend_mode;
>         } else if (property == plane->rotation_property) {
>                 *val = state->rotation;
>         } else if (property == plane->zpos_property) {
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 130da51..7f5d463 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3515,6 +3515,7 @@ void drm_atomic_helper_plane_reset(struct drm_plane *plane)
>                 /* Reset the alpha value to fully opaque if it matters */
>                 if (plane->alpha_property)
>                         plane->state->alpha = plane->alpha_property->values[1];
> +               plane->state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
>         }
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_plane_reset);
> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> index a16a74d..ac6f19c 100644
> --- a/drivers/gpu/drm/drm_blend.c
> +++ b/drivers/gpu/drm/drm_blend.c
> @@ -107,6 +107,52 @@
>   *     planes. Without this property the primary plane is always below the cursor
>   *     plane, and ordering between all other planes is undefined.
>   *
> + * pixel blend mode:
> + *     Pixel blend mode is set up with drm_plane_create_blend_mode_property().
> + *     It adds a blend mode for alpha blending equation selection, describing
> + *     how the pixels from the current plane are composited with the
> + *     background.
> + *
> + *      Three alpha blending equations are defined:
> + *
> + *      "None":
> + *              Blend formula that ignores the pixel alpha::
> + *
> + *                      out.rgb = plane_alpha * fg.rgb +
> + *                              (1 - plane_alpha) * bg.rgb
> + *
> + *      "Pre-multiplied":
> + *              Blend formula that assumes the pixel color values
> + *              have been already pre-multiplied with the alpha
> + *              channel values::
> + *
> + *                      out.rgb = plane_alpha * fg.rgb +
> + *                              (1 - (plane_alpha * fg.alpha)) * bg.rgb
> + *
> + *      "Coverage":
> + *              Blend formula that assumes the pixel color values have not
> + *              been pre-multiplied and will do so when blending them to the
> + *              background color values::
> + *
> + *                      out.rgb = plane_alpha * fg.alpha * fg.rgb +
> + *                              (1 - (plane_alpha * fg.alpha)) * bg.rgb
> + *
> + *      Using the following symbols:
> + *
> + *      ``fg.rgb``:
> + *              Each of the RGB component values from the plane's pixel
> + *      ``fg.alpha``:
> + *              Alpha component value from the plane's pixel. If the plane's
> + *              pixel format has no alpha component, then this is assumed to be
> + *              1.0. In these cases, this property has no effect, as all three
> + *              equations become equivalent.
> + *      ``bg.rgb``:
> + *              Each of the RGB component values from the background
> + *      ``plane_alpha``:
> + *              Plane alpha value set by the plane "alpha" property. If the
> + *              plane does not expose the "alpha" property, then this is
> + *              assumed to be 1.0
> + *
>   * Note that all the property extensions described here apply either to the
>   * plane or the CRTC (e.g. for the background color, which currently is not
>   * exposed and assumed to be black).
> @@ -448,3 +494,83 @@ int drm_atomic_normalize_zpos(struct drm_device *dev,
>         return 0;
>  }
>  EXPORT_SYMBOL(drm_atomic_normalize_zpos);
> +
> +/**
> + * drm_plane_create_blend_mode_property - create a new blend mode property
> + * @plane: drm plane
> + * @supported_modes: bitmask of supported modes, must include
> + *                  BIT(DRM_MODE_BLEND_PREMULTI). Current DRM assumption is
> + *                  that alpha is premultiplied, and old userspace can break if
> + *                  the property defaults to coverage.
> + *

Thanks for the explanation Lowry.
Sigh, old userspace :-\

One pedantic suggestion s/defaults to coverage/defaults to anything else/
Since defaulting to "none" or any future blend mode is also a no-go.

I wouldn't bother resending solely for ^^. Perhaps squash locally
before merging?

With that, the patch is
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

-Emil
