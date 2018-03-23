Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755294AbeCWL1Q convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 07:27:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40710 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932356AbeCWKHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 06:07:11 -0400
Date: Fri, 23 Mar 2018 11:06:59 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH 05/10] drm/sun4i: Explicitly list and check formats
 supported by the frontend
Message-ID: <20180323100659.vojpyt7eazioevdj@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-6-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180321152904.22411-6-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 04:28:59PM +0100, Paul Kocialkowski wrote:
> In order to check whether the frontend supports a specific format, an
> explicit list and a related helper are introduced.
> 
> They are then used to determine whether the frontend can actually support
> the requested format when it was selected to be used.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_backend.c  |  5 ++++
>  drivers/gpu/drm/sun4i/sun4i_frontend.c | 44 ++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun4i_frontend.h |  1 +
>  3 files changed, 50 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index 7703ba989743..1fad0714c70e 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -532,6 +532,11 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
>  		struct drm_format_name_buf format_name;
>  
>  		if (sun4i_backend_plane_uses_frontend(plane_state)) {
> +			if (!sun4i_frontend_format_is_supported(fb->format->format)) {
> +				DRM_DEBUG_DRIVER("Frontend plane check failed\n");
> +				return -EINVAL;
> +			}
> +

So you're checking if the frontend doesn't support it and if the
backend doesn't support it. Who supports it then? :)

Like I was saying, this should be moved to the previous patch, within
sun4i_backend_plane_uses_frontend.

> +static const uint32_t sun4i_frontend_formats[] = {
> +	/* RGB */
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_BGRX8888,
> +	/* YUV444 */
> +	DRM_FORMAT_YUV444,
> +	DRM_FORMAT_YVU444,
> +	/* YUV422 */
> +	DRM_FORMAT_YUYV,
> +	DRM_FORMAT_YVYU,
> +	DRM_FORMAT_UYVY,
> +	DRM_FORMAT_VYUY,
> +	DRM_FORMAT_NV16,
> +	DRM_FORMAT_NV61,
> +	DRM_FORMAT_YUV422,
> +	DRM_FORMAT_YVU422,
> +	/* YUV420 */
> +	DRM_FORMAT_NV12,
> +	DRM_FORMAT_NV21,
> +	DRM_FORMAT_YUV420,
> +	DRM_FORMAT_YVU420,
> +	/* YUV411 */
> +	DRM_FORMAT_YUV411,
> +	DRM_FORMAT_YVU411,
> +};

I think this list should reflect what the driver currently supports,
not what the hardware supports.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
