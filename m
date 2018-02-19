Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbeBSPTH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:19:07 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38769 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753102AbeBSPTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:19:04 -0500
X-Google-Smtp-Source: AH8x227WVvwc64ZRr4G/YpXhNpZ/kcRJGNqji2igoIPP/2Xe0sMLC5IAbRBdzyg43kavv4Jd62yg9Q==
Date: Mon, 19 Feb 2018 16:19:00 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Michal Lazo <michal.lazo@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/meson: fix vsync buffer update
Message-ID: <20180219151900.GP22199@phenom.ffwll.local>
Mail-Followup-To: Neil Armstrong <narmstrong@baylibre.com>,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Michal Lazo <michal.lazo@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1518689976-23292-1-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518689976-23292-1-git-send-email-narmstrong@baylibre.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 11:19:36AM +0100, Neil Armstrong wrote:
> The plane buffer address/stride/height was incorrectly updated in the
> plane_atomic_update operation instead of the vsync irq.
> This patch delays this operation in the vsync irq along with the
> other plane delayed setup.
> 
> This issue was masked using legacy framebuffer and X11 modesetting, but
> is clearly visible using gbm rendering when buffer is submitted late after
> vblank, like using software decoding and OpenGL rendering in Kodi.
> With this patch, tearing and other artifacts disappears completely.

You mean the frontbuffer rendering nature of X11 with all it's tearing
made the issue not noticeable? I'm also not clear what you mean with
legacy framebuffer ...

Either way looks reasonable:
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> Cc: Michal Lazo <michal.lazo@gmail.com>
> Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_crtc.c  | 6 ++++++
>  drivers/gpu/drm/meson/meson_drv.h   | 3 +++
>  drivers/gpu/drm/meson/meson_plane.c | 7 +++----
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
> index 5155f01..0552020 100644
> --- a/drivers/gpu/drm/meson/meson_crtc.c
> +++ b/drivers/gpu/drm/meson/meson_crtc.c
> @@ -36,6 +36,7 @@
>  #include "meson_venc.h"
>  #include "meson_vpp.h"
>  #include "meson_viu.h"
> +#include "meson_canvas.h"
>  #include "meson_registers.h"
>  
>  /* CRTC definition */
> @@ -192,6 +193,11 @@ void meson_crtc_irq(struct meson_drm *priv)
>  		} else
>  			meson_vpp_disable_interlace_vscaler_osd1(priv);
>  
> +		meson_canvas_setup(priv, MESON_CANVAS_ID_OSD1,
> +			   priv->viu.osd1_addr, priv->viu.osd1_stride,
> +			   priv->viu.osd1_height, MESON_CANVAS_WRAP_NONE,
> +			   MESON_CANVAS_BLKMODE_LINEAR);
> +
>  		/* Enable OSD1 */
>  		writel_bits_relaxed(VPP_OSD1_POSTBLEND, VPP_OSD1_POSTBLEND,
>  				    priv->io_base + _REG(VPP_MISC));
> diff --git a/drivers/gpu/drm/meson/meson_drv.h b/drivers/gpu/drm/meson/meson_drv.h
> index 5e8b392..8450d6ac 100644
> --- a/drivers/gpu/drm/meson/meson_drv.h
> +++ b/drivers/gpu/drm/meson/meson_drv.h
> @@ -43,6 +43,9 @@ struct meson_drm {
>  		bool osd1_commit;
>  		uint32_t osd1_ctrl_stat;
>  		uint32_t osd1_blk0_cfg[5];
> +		uint32_t osd1_addr;
> +		uint32_t osd1_stride;
> +		uint32_t osd1_height;
>  	} viu;
>  
>  	struct {
> diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
> index d0a6ac8..27bd350 100644
> --- a/drivers/gpu/drm/meson/meson_plane.c
> +++ b/drivers/gpu/drm/meson/meson_plane.c
> @@ -164,10 +164,9 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
>  	/* Update Canvas with buffer address */
>  	gem = drm_fb_cma_get_gem_obj(fb, 0);
>  
> -	meson_canvas_setup(priv, MESON_CANVAS_ID_OSD1,
> -			   gem->paddr, fb->pitches[0],
> -			   fb->height, MESON_CANVAS_WRAP_NONE,
> -			   MESON_CANVAS_BLKMODE_LINEAR);
> +	priv->viu.osd1_addr = gem->paddr;
> +	priv->viu.osd1_stride = fb->pitches[0];
> +	priv->viu.osd1_height = fb->height;
>  
>  	spin_unlock_irqrestore(&priv->drm->event_lock, flags);
>  }
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
