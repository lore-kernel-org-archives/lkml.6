Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbeDZF6u (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 01:58:50 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55740 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753000AbeDZF6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 01:58:45 -0400
X-UUID: afcefeb9fd404850b9714e2a80f2cb44-20180426
Message-ID: <1524722313.6240.8.camel@mtksdaap41>
Subject: Re: [PATCH] [DRM][KMS][MODE][MEDIATEK] Using the function
 drm_display_mode_to_videomode
From: CK Hu <ck.hu@mediatek.com>
To: Satendra Singh Thakur <thakursatendra2003@yahoo.co.in>
CC: <linux-kernel@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date: Thu, 26 Apr 2018 13:58:33 +0800
In-Reply-To: <1522507712-22763-1-git-send-email-thakursatendra2003@yahoo.co.in>
References: <1522507712-22763-1-git-send-email-thakursatendra2003@yahoo.co.in>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Satendra:

I've applied this patch to my branch mediatek-drm-next-4.18,
and I've added below modification in this patch to prevent build error,

diff --git a/drivers/gpu/drm/mediatek/Kconfig
b/drivers/gpu/drm/mediatek/Kconfig
index 294de45..119ec0a 100644
--- a/drivers/gpu/drm/mediatek/Kconfig
+++ b/drivers/gpu/drm/mediatek/Kconfig
@@ -11,6 +11,7 @@ config DRM_MEDIATEK
        select DRM_PANEL
        select MEMORY
        select MTK_SMI
+       select VIDEOMODE_HELPERS
        help
          Choose this option if you have a Mediatek SoCs.
          The module will be called mediatek-drm

Regards,
CK

On Sat, 2018-03-31 at 20:17 +0530, Satendra Singh Thakur wrote:
> This patch uses existing method drm_display_mode_to_videomode for
> calculating front/back porches, sync lengths for mediatek dsi/dpi drivers; 
> instead of manually calculating them
> 
> Signed-off-by: Satendra Singh Thakur <thakursatendra2003@yahoo.co.in>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 60 +++++++++++++++++++-------------------
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 14 ++-------
>  2 files changed, 32 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index e80a603..6c0ea39 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -22,6 +22,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/types.h>
>  #include <linux/clk.h>
> +#include <video/videomode.h>
>  
>  #include "mtk_dpi_regs.h"
>  #include "mtk_drm_ddp_comp.h"
> @@ -429,34 +430,35 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
>  	struct mtk_dpi_sync_param vsync_leven = { 0 };
>  	struct mtk_dpi_sync_param vsync_rodd = { 0 };
>  	struct mtk_dpi_sync_param vsync_reven = { 0 };
> -	unsigned long pix_rate;
> +	struct videomode vm = { 0 };
>  	unsigned long pll_rate;
>  	unsigned int factor;
>  
>  	/* let pll_rate can fix the valid range of tvdpll (1G~2GHz) */
> -	pix_rate = 1000UL * mode->clock;
> +
>  	if (mode->clock <= 27000)
> -		factor = 16 * 3;
> +		factor = 3 << 4;
>  	else if (mode->clock <= 84000)
> -		factor = 8 * 3;
> +		factor = 3 << 3;
>  	else if (mode->clock <= 167000)
> -		factor = 4 * 3;
> +		factor = 3 << 2;
>  	else
> -		factor = 2 * 3;
> -	pll_rate = pix_rate * factor;
> +		factor = 3 << 1;
> +	drm_display_mode_to_videomode(mode, &vm);
> +	pll_rate = vm.pixelclock * factor;
>  
>  	dev_dbg(dpi->dev, "Want PLL %lu Hz, pixel clock %lu Hz\n",
> -		pll_rate, pix_rate);
> +		pll_rate, vm.pixelclock);
>  
>  	clk_set_rate(dpi->tvd_clk, pll_rate);
>  	pll_rate = clk_get_rate(dpi->tvd_clk);
>  
> -	pix_rate = pll_rate / factor;
> -	clk_set_rate(dpi->pixel_clk, pix_rate);
> -	pix_rate = clk_get_rate(dpi->pixel_clk);
> +	vm.pixelclock = pll_rate / factor;
> +	clk_set_rate(dpi->pixel_clk, vm.pixelclock);
> +	vm.pixelclock = clk_get_rate(dpi->pixel_clk);
>  
>  	dev_dbg(dpi->dev, "Got  PLL %lu Hz, pixel clock %lu Hz\n",
> -		pll_rate, pix_rate);
> +		pll_rate, vm.pixelclock);
>  
>  	limit.c_bottom = 0x0010;
>  	limit.c_top = 0x0FE0;
> @@ -465,33 +467,31 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
>  
>  	dpi_pol.ck_pol = MTK_DPI_POLARITY_FALLING;
>  	dpi_pol.de_pol = MTK_DPI_POLARITY_RISING;
> -	dpi_pol.hsync_pol = mode->flags & DRM_MODE_FLAG_PHSYNC ?
> +	dpi_pol.hsync_pol = vm.flags & DISPLAY_FLAGS_HSYNC_HIGH ?
>  			    MTK_DPI_POLARITY_FALLING : MTK_DPI_POLARITY_RISING;
> -	dpi_pol.vsync_pol = mode->flags & DRM_MODE_FLAG_PVSYNC ?
> +	dpi_pol.vsync_pol = vm.flags & DISPLAY_FLAGS_VSYNC_HIGH ?
>  			    MTK_DPI_POLARITY_FALLING : MTK_DPI_POLARITY_RISING;
> -
> -	hsync.sync_width = mode->hsync_end - mode->hsync_start;
> -	hsync.back_porch = mode->htotal - mode->hsync_end;
> -	hsync.front_porch = mode->hsync_start - mode->hdisplay;
> +	hsync.sync_width = vm.hsync_len;
> +	hsync.back_porch = vm.hback_porch;
> +	hsync.front_porch = vm.hfront_porch;
>  	hsync.shift_half_line = false;
> -
> -	vsync_lodd.sync_width = mode->vsync_end - mode->vsync_start;
> -	vsync_lodd.back_porch = mode->vtotal - mode->vsync_end;
> -	vsync_lodd.front_porch = mode->vsync_start - mode->vdisplay;
> +	vsync_lodd.sync_width = vm.vsync_len;
> +	vsync_lodd.back_porch = vm.vback_porch;
> +	vsync_lodd.front_porch = vm.vfront_porch;
>  	vsync_lodd.shift_half_line = false;
>  
> -	if (mode->flags & DRM_MODE_FLAG_INTERLACE &&
> +	if (vm.flags & DISPLAY_FLAGS_INTERLACED &&
>  	    mode->flags & DRM_MODE_FLAG_3D_MASK) {
>  		vsync_leven = vsync_lodd;
>  		vsync_rodd = vsync_lodd;
>  		vsync_reven = vsync_lodd;
>  		vsync_leven.shift_half_line = true;
>  		vsync_reven.shift_half_line = true;
> -	} else if (mode->flags & DRM_MODE_FLAG_INTERLACE &&
> +	} else if (vm.flags & DISPLAY_FLAGS_INTERLACED &&
>  		   !(mode->flags & DRM_MODE_FLAG_3D_MASK)) {
>  		vsync_leven = vsync_lodd;
>  		vsync_leven.shift_half_line = true;
> -	} else if (!(mode->flags & DRM_MODE_FLAG_INTERLACE) &&
> +	} else if (!(vm.flags & DISPLAY_FLAGS_INTERLACED) &&
>  		   mode->flags & DRM_MODE_FLAG_3D_MASK) {
>  		vsync_rodd = vsync_lodd;
>  	}
> @@ -505,12 +505,12 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
>  	mtk_dpi_config_vsync_reven(dpi, &vsync_reven);
>  
>  	mtk_dpi_config_3d(dpi, !!(mode->flags & DRM_MODE_FLAG_3D_MASK));
> -	mtk_dpi_config_interface(dpi, !!(mode->flags &
> -					 DRM_MODE_FLAG_INTERLACE));
> -	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> -		mtk_dpi_config_fb_size(dpi, mode->hdisplay, mode->vdisplay / 2);
> +	mtk_dpi_config_interface(dpi, !!(vm.flags &
> +					 DISPLAY_FLAGS_INTERLACED));
> +	if (vm.flags & DISPLAY_FLAGS_INTERLACED)
> +		mtk_dpi_config_fb_size(dpi, vm.hactive, vm.vactive >> 1);
>  	else
> -		mtk_dpi_config_fb_size(dpi, mode->hdisplay, mode->vdisplay);
> +		mtk_dpi_config_fb_size(dpi, vm.hactive, vm.vactive);
>  
>  	mtk_dpi_config_channel_limit(dpi, &limit);
>  	mtk_dpi_config_bit_num(dpi, dpi->bit_num);
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 7e5e24c..aa0943e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -551,13 +551,12 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>  	}
>  
>  	/**
> -	 * vm.pixelclock is in kHz, pixel_clock unit is Hz, so multiply by 1000
>  	 * htotal_time = htotal * byte_per_pixel / num_lanes
>  	 * overhead_time = lpx + hs_prepare + hs_zero + hs_trail + hs_exit
>  	 * mipi_ratio = (htotal_time + overhead_time) / htotal_time
>  	 * data_rate = pixel_clock * bit_per_pixel * mipi_ratio / num_lanes;
>  	 */
> -	pixel_clock = dsi->vm.pixelclock * 1000;
> +	pixel_clock = dsi->vm.pixelclock;
>  	htotal = dsi->vm.hactive + dsi->vm.hback_porch + dsi->vm.hfront_porch +
>  			dsi->vm.hsync_len;
>  	htotal_bits = htotal * bit_per_pixel;
> @@ -725,16 +724,7 @@ static void mtk_dsi_encoder_mode_set(struct drm_encoder *encoder,
>  {
>  	struct mtk_dsi *dsi = encoder_to_dsi(encoder);
>  
> -	dsi->vm.pixelclock = adjusted->clock;
> -	dsi->vm.hactive = adjusted->hdisplay;
> -	dsi->vm.hback_porch = adjusted->htotal - adjusted->hsync_end;
> -	dsi->vm.hfront_porch = adjusted->hsync_start - adjusted->hdisplay;
> -	dsi->vm.hsync_len = adjusted->hsync_end - adjusted->hsync_start;
> -
> -	dsi->vm.vactive = adjusted->vdisplay;
> -	dsi->vm.vback_porch = adjusted->vtotal - adjusted->vsync_end;
> -	dsi->vm.vfront_porch = adjusted->vsync_start - adjusted->vdisplay;
> -	dsi->vm.vsync_len = adjusted->vsync_end - adjusted->vsync_start;
> +	drm_display_mode_to_videomode(adjusted, &dsi->vm);
>  }
>  
>  static void mtk_dsi_encoder_disable(struct drm_encoder *encoder)
