Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756061AbeCWKtC convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 06:49:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43321 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752130AbeCWKs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 06:48:59 -0400
Date: Fri, 23 Mar 2018 11:48:57 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH 09/10] drm/sun4i: Add a dedicated ioctl call for
 allocating tiled buffers
Message-ID: <20180323104856.qo7w376xr3gcznmm@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-10-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180321152904.22411-10-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 21, 2018 at 04:29:03PM +0100, Paul Kocialkowski wrote:
> This introduces a dedicated ioctl for allocating tiled buffers in the
> Allwinner MB32 format, that comes with a handful of specific
> constraints. In particular, the stride of the buffers is expected to be
> aligned to 32 bytes.

You should have more details here. What are those constraints, what is
the expected user? Can you use it only for the scanout, like the dumb
buffers, or also for the other devices in the system?

> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_drv.c | 96 +++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun4i_drv.h |  2 +
>  include/uapi/drm/sun4i_drm.h      | 42 +++++++++++++++++
>  3 files changed, 140 insertions(+)
>  create mode 100644 include/uapi/drm/sun4i_drm.h
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> index d374bb61c565..e9cb03d34b44 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -21,11 +21,18 @@
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_fb_helper.h>
>  #include <drm/drm_of.h>
> +#include <drm/sun4i_drm.h>
>  
>  #include "sun4i_drv.h"
>  #include "sun4i_frontend.h"
>  #include "sun4i_framebuffer.h"
>  #include "sun4i_tcon.h"
> +#include "sun4i_format.h"
> +
> +static const struct drm_ioctl_desc sun4i_drv_ioctls[] = {
> +	DRM_IOCTL_DEF_DRV(SUN4I_GEM_CREATE_TILED, drm_sun4i_gem_create_tiled,
> +			  DRM_AUTH | DRM_RENDER_ALLOW),

Why do you need DRM_RENDER_ALLOW? as far as I know, this is only
useful for render-nodes.

> +};
>  
>  DEFINE_DRM_GEM_CMA_FOPS(sun4i_drv_fops);
>  
> @@ -34,6 +41,8 @@ static struct drm_driver sun4i_drv_driver = {
>  
>  	/* Generic Operations */
>  	.lastclose		= drm_fb_helper_lastclose,
> +	.ioctls			= sun4i_drv_ioctls,
> +	.num_ioctls		= ARRAY_SIZE(sun4i_drv_ioctls),
>  	.fops			= &sun4i_drv_fops,
>  	.name			= "sun4i-drm",
>  	.desc			= "Allwinner sun4i Display Engine",
> @@ -69,6 +78,93 @@ int drm_sun4i_gem_dumb_create(struct drm_file *file_priv,
>  	return drm_gem_cma_dumb_create_internal(file_priv, drm, args);
>  }
>  
> +int drm_sun4i_gem_create_tiled(struct drm_device *drm, void *data,
> +			       struct drm_file *file_priv)
> +{
> +	struct drm_sun4i_gem_create_tiled *args = data;
> +	struct drm_gem_cma_object *cma_obj;
> +	struct drm_gem_object *gem_obj;
> +	uint32_t luma_stride, chroma_stride;
> +	uint32_t luma_height, chroma_height;
> +	int ret;
> +
> +	if (!sun4i_format_supports_tiling(args->format))
> +		return -EINVAL;
> +
> +	memset(args->pitches, 0, sizeof(args->pitches));
> +	memset(args->offsets, 0, sizeof(args->offsets));
> +
> +	/* Stride and height are aligned to 32 bytes for MB32 tiled format. */
> +	luma_stride = ALIGN(args->width, 32);
> +	luma_height = ALIGN(args->height, 32);
> +
> +	if (sun4i_format_is_semiplanar(args->format)) {
> +		chroma_stride = luma_stride;
> +
> +		if (sun4i_format_is_yuv420(args->format))
> +			chroma_height = ALIGN(DIV_ROUND_UP(args->height, 2), 32);
> +		else if (sun4i_format_is_yuv422(args->format))
> +			chroma_height = luma_height;
> +		else
> +			return -EINVAL;
> +
> +		args->pitches[0] = luma_stride;
> +		args->pitches[1] = chroma_stride;
> +
> +		args->offsets[0] = 0;
> +		args->offsets[1] = luma_stride * luma_height;
> +
> +		args->size = luma_stride * luma_height +
> +			     chroma_stride * chroma_height;
> +	} else if (sun4i_format_is_planar(args->format)) {
> +		if (sun4i_format_is_yuv411(args->format)) {
> +			chroma_stride = ALIGN(DIV_ROUND_UP(args->width, 4), 32);
> +			chroma_height = luma_height;
> +		} if (sun4i_format_is_yuv420(args->format)) {
> +			chroma_stride = ALIGN(DIV_ROUND_UP(args->width, 2), 32);
> +			chroma_height = ALIGN(DIV_ROUND_UP(args->height, 2), 32);
> +		} else if (sun4i_format_is_yuv422(args->format)) {
> +			chroma_stride = ALIGN(DIV_ROUND_UP(args->width, 2), 32);
> +			chroma_height = luma_height;
> +		} else {
> +			return -EINVAL;
> +		}
> +
> +		args->pitches[0] = luma_stride;
> +		args->pitches[1] = chroma_stride;
> +		args->pitches[2] = chroma_stride;
> +
> +		args->offsets[0] = 0;
> +		args->offsets[1] = luma_stride * luma_height;
> +		args->offsets[2] = luma_stride * luma_height +
> +				   chroma_stride * chroma_height;
> +
> +		args->size = luma_stride * luma_height +
> +			     chroma_stride * chroma_height * 2;
> +	} else {
> +		/* No support for packed formats in tiled mode. */
> +		return -EINVAL;
> +	}
> +
> +	cma_obj = drm_gem_cma_create(drm, args->size);
> +	if (IS_ERR(cma_obj))
> +		return PTR_ERR(cma_obj);
> +
> +	gem_obj = &cma_obj->base;
> +
> +	/*
> +	 * allocate a id of idr table where the obj is registered
> +	 * and handle has the id what user can see.
> +	 */
> +	ret = drm_gem_handle_create(file_priv, gem_obj, &args->handle);
> +	/* drop reference from allocate - handle holds it now. */
> +	drm_gem_object_put_unlocked(gem_obj);
> +	if (ret)
> +		return ret;
> +
> +	return PTR_ERR_OR_ZERO(cma_obj);
> +}
> +
>  static void sun4i_remove_framebuffers(void)
>  {
>  	struct apertures_struct *ap;
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.h b/drivers/gpu/drm/sun4i/sun4i_drv.h
> index 47969711a889..308ff4bfcdd5 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.h
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.h
> @@ -26,5 +26,7 @@ struct sun4i_drv {
>  int drm_sun4i_gem_dumb_create(struct drm_file *file_priv,
>  			      struct drm_device *drm,
>  			      struct drm_mode_create_dumb *args);
> +int drm_sun4i_gem_create_tiled(struct drm_device *dev, void *data,
> +			       struct drm_file *file_priv);

Do you need it to be non-static, and part of the header as well?

I'll let the DRM-misc maintainers comment on the validity of the new
ioctl.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
