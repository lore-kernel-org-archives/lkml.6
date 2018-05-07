Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752986AbeEGUqw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:46:52 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:34616 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752709AbeEGUqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:46:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Mon, 07 May 2018 22:46:49 +0200
From: Stefan Agner <stefan@agner.ch>
To: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: Alison Wang <alison.wang@freescale.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Madhur Verma <madhur.verma@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: Re: [PATCH 04/13] drm/kms/mode/fsl-dcu: using helper func
 drm_display_mode_to_videomode for calculating timing parameters
In-Reply-To: <c6c9496f9824b73322646d360ed9250ce89bde7d.1525087679.git.satendra.t@samsung.com>
References: <cover.1525087679.git.satendra.t@samsung.com>
 <CGME20180503084441epcas5p371997e3772a2fe2bfb4dc26447dafe65@epcas5p3.samsung.com>
 <c6c9496f9824b73322646d360ed9250ce89bde7d.1525087679.git.satendra.t@samsung.com>
Message-ID: <ac53f43cece86178076bc78c94cf06d4@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         MID_RHS_MATCH_FROM(0.00)[];
         ARC_NA(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         DKIM_SIGNED(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         RCVD_COUNT_ZERO(0.00)[0];
         RCPT_COUNT_SEVEN(0.00)[7];
         FROM_EQ_ENVFROM(0.00)[];
         TO_DN_SOME(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.05.2018 10:44, Satendra Singh Thakur wrote:
> To avoid duplicate logic for the same

How about:

Use drm_display_mode_to_videomode to avoid duplicate logic.


> 
> Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
> Cc: Madhur Verma <madhur.verma@samsung.com>
> Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
> ---
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
> b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
> index 0e37524..3c651f8 100644
> --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
> @@ -17,6 +17,7 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_crtc_helper.h>
> +#include <video/videomode.h>

I don't think this is needed here.

But probably drm/drm_modes.h is, since that is where
drm_display_mode_to_videomode is declared...

>  
>  #include "fsl_dcu_drm_crtc.h"
>  #include "fsl_dcu_drm_drv.h"
> @@ -85,19 +86,13 @@ static void fsl_dcu_drm_crtc_mode_set_nofb(struct
> drm_crtc *crtc)
>  	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
>  	struct drm_connector *con = &fsl_dev->connector.base;
>  	struct drm_display_mode *mode = &crtc->state->mode;
> -	unsigned int hbp, hfp, hsw, vbp, vfp, vsw, index, pol = 0;
> +	unsigned int  index, pol = 0;

Remove space between int and index.

> +	struct videomode vm;
>  
>  	index = drm_crtc_index(crtc);
> -	clk_set_rate(fsl_dev->pix_clk, mode->clock * 1000);
> -
> -	/* Configure timings: */
> -	hbp = mode->htotal - mode->hsync_end;
> -	hfp = mode->hsync_start - mode->hdisplay;
> -	hsw = mode->hsync_end - mode->hsync_start;
> -	vbp = mode->vtotal - mode->vsync_end;
> -	vfp = mode->vsync_start - mode->vdisplay;
> -	vsw = mode->vsync_end - mode->vsync_start;
> -
> +	/* Configure timings:*/

Drop that comment, it is not really helpful.

> +	drm_display_mode_to_videomode(mode, &vm);
> +	clk_set_rate(fsl_dev->pix_clk, vm.pixelclock);

Add newline here.


I like the patch! Thanks!

--
Stefan

>  	/* INV_PXCK as default (most display sample data on rising edge) */
>  	if (!(con->display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE))
>  		pol |= DCU_SYN_POL_INV_PXCK;
> @@ -109,13 +104,13 @@ static void
> fsl_dcu_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
>  		pol |= DCU_SYN_POL_INV_VS_LOW;
>  
>  	regmap_write(fsl_dev->regmap, DCU_HSYN_PARA,
> -		     DCU_HSYN_PARA_BP(hbp) |
> -		     DCU_HSYN_PARA_PW(hsw) |
> -		     DCU_HSYN_PARA_FP(hfp));
> +		     DCU_HSYN_PARA_BP(vm.hback_porch) |
> +		     DCU_HSYN_PARA_PW(vm.hsync_len) |
> +		     DCU_HSYN_PARA_FP(vm.hfront_porch));
>  	regmap_write(fsl_dev->regmap, DCU_VSYN_PARA,
> -		     DCU_VSYN_PARA_BP(vbp) |
> -		     DCU_VSYN_PARA_PW(vsw) |
> -		     DCU_VSYN_PARA_FP(vfp));
> +		     DCU_VSYN_PARA_BP(vm.vback_porch) |
> +		     DCU_VSYN_PARA_PW(vm.vsync_len) |
> +		     DCU_VSYN_PARA_FP(vm.vfront_porch));
>  	regmap_write(fsl_dev->regmap, DCU_DISP_SIZE,
>  		     DCU_DISP_SIZE_DELTA_Y(mode->vdisplay) |
>  		     DCU_DISP_SIZE_DELTA_X(mode->hdisplay));
