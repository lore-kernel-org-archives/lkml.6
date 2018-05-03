Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751141AbeECH7k (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 03:59:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:54551 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751078AbeECH7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 03:59:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,357,1520924400";
   d="scan'208";a="52024718"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Satendra Singh Thakur <satendra.t@samsung.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        David Airlie <airlied@linux.ie>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>,
        Satendra Singh Thakur <satendra.t@samsung.com>,
        Madhur Verma <madhur.verma@samsung.com>
Subject: Re: [PATCH] drm/kms/mode: added a new helper for calculating videomode from crtc's display mode
In-Reply-To: <1525327118-26078-1-git-send-email-satendra.t@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CGME20180503055902epcas5p2eea7b9f58dc630e60fb28c8fc2ffad7b@epcas5p2.samsung.com> <1525327118-26078-1-git-send-email-satendra.t@samsung.com>
Date: Thu, 03 May 2018 11:02:13 +0300
Message-ID: <87lgd188vu.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 May 2018, Satendra Singh Thakur <satendra.t@samsung.com> wrote:
> 1.
> -Added a new helper drm_display_mode_crtc_to_videomode
> -This helper calculates mode parameters like
>   horizontal front_porch, back_porch, sync length
>   vertical front_porch, back_porch, sync length
>   using crtc_* fields of struct drm_display_mode
> -It uses following fields of crtc mode
>  horizontal sync start/end, active and total length
>  vertical sync start/end, active and total length
> 2.
> -Most of the driver use user-supplied mode for calculating videomode
> -However, few drivers use HW (crtc) mode for calculating videomode
> -This helper will be useful for such drivers
> 3.
> -Currently following drivers will be using this new helper
> -arm hdlcd
> -atmel hlcdc
> -exynos 5433 decon
> -exynos7 decon
> -exynos fimd
> 4.
> -This patch removes related duplicate code from above mentioned drivers
>
> Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
> Cc: Madhur Verma <madhur.verma@samsung.com>
> Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
> ---
>  drivers/gpu/drm/arm/hdlcd_crtc.c               |  8 +-------
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c |  7 +------
>  drivers/gpu/drm/drm_modes.c                    | 20 ++++++++++++++++++++
>  drivers/gpu/drm/exynos/exynos5433_drm_decon.c  | 22 ++++++++++------------
>  drivers/gpu/drm/exynos/exynos7_drm_decon.c     | 23 ++++++++++-------------
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c       | 22 +++++++++-------------
>  include/drm/drm_modes.h                        |  2 ++
>  7 files changed, 53 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> index cf5cbd6..d20e471 100644
> --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> @@ -130,13 +130,7 @@ static void hdlcd_crtc_mode_set_nofb(struct drm_crtc *crtc)
>  	struct videomode vm;
>  	unsigned int polarities, err;
>  
> -	vm.vfront_porch = m->crtc_vsync_start - m->crtc_vdisplay;
> -	vm.vback_porch = m->crtc_vtotal - m->crtc_vsync_end;
> -	vm.vsync_len = m->crtc_vsync_end - m->crtc_vsync_start;
> -	vm.hfront_porch = m->crtc_hsync_start - m->crtc_hdisplay;
> -	vm.hback_porch = m->crtc_htotal - m->crtc_hsync_end;
> -	vm.hsync_len = m->crtc_hsync_end - m->crtc_hsync_start;
> -
> +	drm_display_mode_crtc_to_videomode(m, &vm);
>  	polarities = HDLCD_POLARITY_DATAEN | HDLCD_POLARITY_DATA;
>  
>  	if (m->flags & DRM_MODE_FLAG_PHSYNC)
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index d732810..bafcef6 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -81,12 +81,7 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
>  	unsigned int cfg;
>  	int div;
>  
> -	vm.vfront_porch = adj->crtc_vsync_start - adj->crtc_vdisplay;
> -	vm.vback_porch = adj->crtc_vtotal - adj->crtc_vsync_end;
> -	vm.vsync_len = adj->crtc_vsync_end - adj->crtc_vsync_start;
> -	vm.hfront_porch = adj->crtc_hsync_start - adj->crtc_hdisplay;
> -	vm.hback_porch = adj->crtc_htotal - adj->crtc_hsync_end;
> -	vm.hsync_len = adj->crtc_hsync_end - adj->crtc_hsync_start;
> +	drm_display_mode_crtc_to_videomode(adj, &vm);
>  
>  	regmap_write(regmap, ATMEL_HLCDC_CFG(1),
>  		     (vm.hsync_len - 1) | ((vm.vsync_len - 1) << 16));
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index e82b61e..a406749 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -654,6 +654,26 @@ void drm_display_mode_to_videomode(const struct drm_display_mode *dmode,
>  		vm->flags |= DISPLAY_FLAGS_DOUBLECLK;
>  }
>  EXPORT_SYMBOL_GPL(drm_display_mode_to_videomode);
> +/**
> + * drm_display_mode_crtc_to_videomode - fill in @vm using crtc fields of@dmode,

"of@dmode" needs a space, superfluous comma at the end.

> + * @dmode: drm_display_mode structure to use as source
> + * @vm: videomode structure to use as destination
> + *
> + * Fills out @vm using the crtc display mode specified in @dmode.
> + */
> +void drm_display_mode_crtc_to_videomode(const struct drm_display_mode *dmode,
> +				   struct videomode *vm)
> +{
> +	vm->hfront_porch = dmode->crtc_hsync_start - dmode->crtc_hdisplay;
> +	vm->hsync_len = dmode->crtc_hsync_end - dmode->crtc_hsync_start;
> +	vm->hback_porch = dmode->crtc_htotal - dmode->crtc_hsync_end;
> +
> +	vm->vfront_porch = dmode->crtc_vsync_start - dmode->crtc_vdisplay;
> +	vm->vsync_len = dmode->crtc_vsync_end - dmode->crtc_vsync_start;
> +	vm->vback_porch = dmode->crtc_vtotal - dmode->crtc_vsync_end;

IMO this should fill in or at least clear all fields of videomode, in
many call sites they'll contain stack garbage.

> +

Superfluous newline.

> +}
> +EXPORT_SYMBOL_GPL(drm_display_mode_crtc_to_videomode);
>  
>  /**
>   * drm_bus_flags_from_videomode - extract information about pixelclk and
> diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
> index 1c330f2..1ba73a8 100644
> --- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
> +++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
> @@ -20,6 +20,7 @@
>  #include <linux/of_gpio.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> +#include <video/videomode.h>
>  
>  #include "exynos_drm_drv.h"
>  #include "exynos_drm_crtc.h"
> @@ -225,26 +226,23 @@ static void decon_commit(struct exynos_drm_crtc *crtc)
>  	writel(val, ctx->addr + DECON_VIDTCON2);
>  
>  	if (!crtc->i80_mode) {
> -		int vbp = m->crtc_vtotal - m->crtc_vsync_end;
> -		int vfp = m->crtc_vsync_start - m->crtc_vdisplay;
> +		struct videomode vm;
>  
> +		drm_display_mode_crtc_to_videomode(m, &vm);
>  		if (interlaced)
> -			vbp = vbp / 2 - 1;
> -		val = VIDTCON00_VBPD_F(vbp - 1) | VIDTCON00_VFPD_F(vfp - 1);
> +			vm.vback_porch = (vm.vback_porch >> 1) - 1;
> +		val = VIDTCON00_VBPD_F(vm.vback_porch - 1) |
> +			VIDTCON00_VFPD_F(vm.vfront_porch - 1);
>  		writel(val, ctx->addr + DECON_VIDTCON00);
>  
> -		val = VIDTCON01_VSPW_F(
> -				m->crtc_vsync_end - m->crtc_vsync_start - 1);
> +		val = VIDTCON01_VSPW_F(vm.vsync_len - 1);
>  		writel(val, ctx->addr + DECON_VIDTCON01);
>  
> -		val = VIDTCON10_HBPD_F(
> -				m->crtc_htotal - m->crtc_hsync_end - 1) |
> -			VIDTCON10_HFPD_F(
> -				m->crtc_hsync_start - m->crtc_hdisplay - 1);
> +		val = VIDTCON10_HBPD_F(vm.hback_porch - 1) |
> +			VIDTCON10_HFPD_F(vm.hfront_porch - 1);
>  		writel(val, ctx->addr + DECON_VIDTCON10);
>  
> -		val = VIDTCON11_HSPW_F(
> -				m->crtc_hsync_end - m->crtc_hsync_start - 1);
> +		val = VIDTCON11_HSPW_F(vm.hsync_len - 1);
>  		writel(val, ctx->addr + DECON_VIDTCON11);
>  	}
>  
> diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
> index 3931d5e..148daae 100644
> --- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
> +++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
> @@ -25,6 +25,7 @@
>  
>  #include <video/of_display_timing.h>
>  #include <video/of_videomode.h>
> +#include <video/videomode.h>
>  
>  #include "exynos_drm_crtc.h"
>  #include "exynos_drm_plane.h"
> @@ -168,28 +169,24 @@ static void decon_commit(struct exynos_drm_crtc *crtc)
>  		return;
>  
>  	if (!ctx->i80_if) {
> -		int vsync_len, vbpd, vfpd, hsync_len, hbpd, hfpd;
> +		struct videomode vm;
> +
> +		drm_display_mode_crtc_to_videomode(mode, &vm);
>  	      /* setup vertical timing values. */
> -		vsync_len = mode->crtc_vsync_end - mode->crtc_vsync_start;
> -		vbpd = mode->crtc_vtotal - mode->crtc_vsync_end;
> -		vfpd = mode->crtc_vsync_start - mode->crtc_vdisplay;
>  
> -		val = VIDTCON0_VBPD(vbpd - 1) | VIDTCON0_VFPD(vfpd - 1);
> +		val = VIDTCON0_VBPD(vm.vback_porch - 1) |
> +			VIDTCON0_VFPD(vm.vfront_porch - 1);
>  		writel(val, ctx->regs + VIDTCON0);
>  
> -		val = VIDTCON1_VSPW(vsync_len - 1);
> +		val = VIDTCON1_VSPW(vm.vsync_len - 1);
>  		writel(val, ctx->regs + VIDTCON1);
>  
>  		/* setup horizontal timing values.  */
> -		hsync_len = mode->crtc_hsync_end - mode->crtc_hsync_start;
> -		hbpd = mode->crtc_htotal - mode->crtc_hsync_end;
> -		hfpd = mode->crtc_hsync_start - mode->crtc_hdisplay;
> -
> -		/* setup horizontal timing values.  */
> -		val = VIDTCON2_HBPD(hbpd - 1) | VIDTCON2_HFPD(hfpd - 1);
> +		val = VIDTCON2_HBPD(vm.hback_porch - 1) |
> +			VIDTCON2_HFPD(vm.hfront_porch - 1);
>  		writel(val, ctx->regs + VIDTCON2);
>  
> -		val = VIDTCON3_HSPW(hsync_len - 1);
> +		val = VIDTCON3_HSPW(vm.hsync_len - 1);
>  		writel(val, ctx->regs + VIDTCON3);
>  	}
>  
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> index d42ae2b..b3ab89d 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> @@ -25,6 +25,7 @@
>  
>  #include <video/of_display_timing.h>
>  #include <video/of_videomode.h>
> +#include <video/videomode.h>
>  #include <video/samsung_fimd.h>
>  #include <drm/exynos_drm.h>
>  
> @@ -463,7 +464,7 @@ static void fimd_commit(struct exynos_drm_crtc *crtc)
>  			return;
>  		}
>  	} else {
> -		int vsync_len, vbpd, vfpd, hsync_len, hbpd, hfpd;
> +		struct videomode vm;
>  		u32 vidcon1;
>  
>  		/* setup polarity values */
> @@ -474,24 +475,19 @@ static void fimd_commit(struct exynos_drm_crtc *crtc)
>  			vidcon1 |= VIDCON1_INV_HSYNC;
>  		writel(vidcon1, ctx->regs + driver_data->timing_base + VIDCON1);
>  
> +		drm_display_mode_crtc_to_videomode(mode, &vm);
>  		/* setup vertical timing values. */
> -		vsync_len = mode->crtc_vsync_end - mode->crtc_vsync_start;
> -		vbpd = mode->crtc_vtotal - mode->crtc_vsync_end;
> -		vfpd = mode->crtc_vsync_start - mode->crtc_vdisplay;
>  
> -		val = VIDTCON0_VBPD(vbpd - 1) |
> -			VIDTCON0_VFPD(vfpd - 1) |
> -			VIDTCON0_VSPW(vsync_len - 1);
> +		val = VIDTCON0_VBPD(vm.vback_porch - 1) |
> +			VIDTCON0_VFPD(vm.vfront_porch - 1) |
> +			VIDTCON0_VSPW(vm.vsync_len - 1);
>  		writel(val, ctx->regs + driver_data->timing_base + VIDTCON0);
>  
>  		/* setup horizontal timing values.  */
> -		hsync_len = mode->crtc_hsync_end - mode->crtc_hsync_start;
> -		hbpd = mode->crtc_htotal - mode->crtc_hsync_end;
> -		hfpd = mode->crtc_hsync_start - mode->crtc_hdisplay;
>  
> -		val = VIDTCON1_HBPD(hbpd - 1) |
> -			VIDTCON1_HFPD(hfpd - 1) |
> -			VIDTCON1_HSPW(hsync_len - 1);
> +		val = VIDTCON1_HBPD(vm.hback_porch - 1) |
> +			VIDTCON1_HFPD(vm.hfront_porch - 1) |
> +			VIDTCON1_HSPW(vm.hsync_len - 1);
>  		writel(val, ctx->regs + driver_data->timing_base + VIDTCON1);
>  	}
>  
> diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
> index 0d310be..9ac764b 100644
> --- a/include/drm/drm_modes.h
> +++ b/include/drm/drm_modes.h
> @@ -473,6 +473,8 @@ void drm_display_mode_from_videomode(const struct videomode *vm,
>  				     struct drm_display_mode *dmode);
>  void drm_display_mode_to_videomode(const struct drm_display_mode *dmode,
>  				   struct videomode *vm);
> +void drm_display_mode_crtc_to_videomode(const struct drm_display_mode *dmode,
> +				   struct videomode *vm);
>  void drm_bus_flags_from_videomode(const struct videomode *vm, u32 *bus_flags);
>  int of_get_drm_display_mode(struct device_node *np,
>  			    struct drm_display_mode *dmode, u32 *bus_flags,

-- 
Jani Nikula, Intel Open Source Technology Center
