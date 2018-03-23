Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754549AbeCWKDu convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 06:03:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40428 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754507AbeCWKDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 06:03:42 -0400
Date: Fri, 23 Mar 2018 11:03:30 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH 04/10] drm/sun4i: Explicitly list and check formats
 supported by the backend
Message-ID: <20180323100330.2sijtsp5bdyyel5a@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-5-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180321152904.22411-5-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 04:28:58PM +0100, Paul Kocialkowski wrote:
> In order to check whether the backend supports a specific format, an
> explicit list and a related helper are introduced.
> 
> They are then used to determine whether the frontend should be used for
> a layer, when the format is not supported by the backend.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_backend.c | 48 ++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/sun4i/sun4i_backend.h |  1 +
>  2 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index 274a1db6fa8e..7703ba989743 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -172,6 +172,39 @@ static int sun4i_backend_drm_format_to_layer(u32 format, u32 *mode)
>  	return 0;
>  }
>  
> +static const uint32_t sun4i_backend_formats[] = {
> +	/* RGB */
> +	DRM_FORMAT_ARGB4444,
> +	DRM_FORMAT_RGBA4444,
> +	DRM_FORMAT_ARGB1555,
> +	DRM_FORMAT_RGBA5551,
> +	DRM_FORMAT_RGB565,
> +	DRM_FORMAT_RGB888,
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_BGRX8888,
> +	DRM_FORMAT_ARGB8888,
> +	/* YUV422 */
> +	DRM_FORMAT_YUYV,
> +	DRM_FORMAT_YVYU,
> +	DRM_FORMAT_UYVY,
> +	DRM_FORMAT_VYUY,

Ordering them by alphabetical order would be better.

> +};
> +
> +bool sun4i_backend_format_is_supported(uint32_t fmt)
> +{
> +	bool found = false;
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(sun4i_backend_formats); i++) {
> +		if (sun4i_backend_formats[i] == fmt) {
> +			found = true;
> +			break;

return true?

> +		}
> +	}
> +
> +	return found;
> +}
> +
>  int sun4i_backend_update_layer_coord(struct sun4i_backend *backend,
>  				     int layer, struct drm_plane *plane)
>  {
> @@ -436,15 +469,28 @@ static bool sun4i_backend_plane_uses_frontend(struct drm_plane_state *state)
>  {
>  	struct sun4i_layer *layer = plane_to_sun4i_layer(state->plane);
>  	struct sun4i_backend *backend = layer->backend;
> +	struct drm_framebuffer *fb = state->fb;
>  
>  	if (IS_ERR(backend->frontend))
>  		return false;
>  
> +	/*
> +	 * Let's pretend that every format is either supported by the backend or
> +	 * the frontend. This is not true in practice, as some tiling modes are
> +	 * not supported by either. There is still room to check this later in
> +	 * the atomic check process.

Then I guess there these tiling modes will not be exposed and we won't
ever get that far, wouldn't we?

> +	 */
> +	if (!sun4i_backend_format_is_supported(fb->format->format))
> +		return true;

Even though there's a comment, this is not really natural. We are
checking whether the frontend supports the current plane_state, so it
just makes more sense to check whether the frontend supports the
format, rather than if the backend doesn't support them.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
