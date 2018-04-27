Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759283AbeD0VUx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:20:53 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:37394 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757592AbeD0VUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:20:52 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/11] drm: rcar-du: Split CRTC handling to support hardware indexing
Date: Sat, 28 Apr 2018 00:21:05 +0300
Message-ID: <1598672.HiR2zdP9T4@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180427165722.19445-4-kieran.bingham+renesas@ideasonboard.com>
References: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com> <20180427165722.19445-4-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Friday, 27 April 2018 19:57:14 EEST Kieran Bingham wrote:
> The DU CRTC driver does not support distinguishing between a hardware
> index, and a software (CRTC) index in the event that a DU channel might
> not be populated by the hardware.
> 
> Support this by adapting the rcar_du_device_info structure to store a
> bitmask of available channels rather than a count of CRTCs. The count
> can then be obtained by determining the hamming weight of the bitmask.
> 
> This allows the rcar_du_crtc_create() function to distinguish between
> both index types, and non-populated DU channels will be skipped without
> leaving a gap in the software CRTC indexes.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> ---
> v2:
>  - devm_clk_get error message adapted to display Du channel
>  - rgrp->planes for gen2 now uses swindex instead of hwindex
>  - channel_mask -> channels_mask
>  - channel_mask set in LE bit order.
>  - (.dpll_ch corrected to LE bit order)
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 26 ++++++++++++++------------
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.h |  3 ++-
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c  | 22 +++++++++++-----------
>  drivers/gpu/drm/rcar-du/rcar_du_drv.h  |  4 ++--
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c  | 18 +++++++++++++-----
>  5 files changed, 42 insertions(+), 31 deletions(-)

[snip]

> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> b/drivers/gpu/drm/rcar-du/rcar_du_drv.h index 5c7ec15818c7..f455548d77b4
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> @@ -52,7 +52,7 @@ struct rcar_du_output_routing {
>   * @gen: device generation (2 or 3)
>   * @features: device features (RCAR_DU_FEATURE_*)
>   * @quirks: device quirks (RCAR_DU_QUIRK_*)
> - * @num_crtcs: total number of CRTCs
> + * @channels_mask: bit mask of supported DU channels

Nitpicking, I'd say "bit mask of available DU channels".

Other than that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

If you're fine with the change there's no need to resubmit, I'll change this 
when applying.

>   * @routes: array of CRTC to output routes, indexed by output
> (RCAR_DU_OUTPUT_*) * @num_lvds: number of internal LVDS encoders
>   */
> @@ -60,7 +60,7 @@ struct rcar_du_device_info {
>  	unsigned int gen;
>  	unsigned int features;
>  	unsigned int quirks;
> -	unsigned int num_crtcs;
> +	unsigned int channels_mask;
>  	struct rcar_du_output_routing routes[RCAR_DU_OUTPUT_MAX];
>  	unsigned int num_lvds;
>  	unsigned int dpll_ch;

-- 
Regards,

Laurent Pinchart
