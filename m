Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbeCWJzl convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:55:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40182 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751597AbeCWJzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:55:40 -0400
Date: Fri, 23 Mar 2018 10:55:29 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH 02/10] drm/sun4i: Disable YUV channel when using the
 frontend and set interlace
Message-ID: <20180323095529.5nptn5achjt3esog@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-3-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180321152904.22411-3-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 04:28:56PM +0100, Paul Kocialkowski wrote:
> The YUV channel was only disabled in sun4i_backend_update_layer_formats,
> which is not called when the frontend is selected.
> 
> Thus, creating a layer with a YUV format handled by the backend and then
> switching to a format that requires the frontend would keep the YUV
> channel enabled for the layer.
> 
> This explicitly disables the YUV channel for the layer when using the
> frontend as well. It also sets the relevant interlace bit, which was
> missing in the frontend path as well.

This should be part of a separate patch. Usually, if you write "it
also does..." at the end of your commit log, it's a pretty good
indication that it should be another patch :)

> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_backend.c | 17 ++++++++++++++++-
>  drivers/gpu/drm/sun4i/sun4i_backend.h |  3 ++-
>  drivers/gpu/drm/sun4i/sun4i_layer.c   |  2 +-
>  3 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index e07a33adc51d..b98dafda52f8 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -294,8 +294,10 @@ int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
>  }
>  
>  int sun4i_backend_update_layer_frontend(struct sun4i_backend *backend,
> -					int layer, uint32_t fmt)
> +					int layer, struct drm_plane *plane,
> +					uint32_t fmt)
>  {
> +	bool interlaced = false;

There's no need to pass the full drm_plane pointer, you can just pass
a boolean to tell if it is interlaced or not.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
