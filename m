Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754712AbeDZUnN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:43:13 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59638 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753393AbeDZUnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:43:12 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS FOR RENESAS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/17] drm: rcar-du: Add R8A77965 support
Date: Thu, 26 Apr 2018 23:43:25 +0300
Message-ID: <1954980.A0ABKULED7@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180426165346.494-8-kieran.bingham+renesas@ideasonboard.com>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com> <20180426165346.494-8-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Thursday, 26 April 2018 19:53:36 EEST Kieran Bingham wrote:
> The R8A77965 (M3-N) SoC provides VGA, HDMI and LVDS output.
> 
> This platform is unusual in that the VGA is connected to DU3 leaving DU2
> unpopulated. This is reflected by the channel_mask accordingly.

I'd write s/VGA/DPAD/g (or s/VGA/RGB/g) as the DPAD output can be used for 
other purposes than VGA.

> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 29 +++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> b/drivers/gpu/drm/rcar-du/rcar_du_drv.c index d6ebc628fc22..4d195ff8c569
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> @@ -246,6 +246,34 @@ static const struct rcar_du_device_info
> rcar_du_r8a7796_info = { .dpll_ch =  BIT(1),
>  };
> 
> +static const struct rcar_du_device_info rcar_du_r8a77965_info = {
> +	.gen = 3,
> +	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
> +		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
> +		  | RCAR_DU_FEATURE_VSP1_SOURCE,
> +	.channel_mask = BIT(0) | BIT(1) | BIT(3),

Depending on what you think of my suggestions for patch 05/17, you might want 
to reverse the bit order here.

> +	.routes = {
> +		/*
> +		 * R8A77965 has one RGB output, one LVDS output and one HDMI
> +		 * output.
> +		 */
> +		[RCAR_DU_OUTPUT_DPAD0] = {
> +			.possible_crtcs = BIT(2),
> +			.port = 0,
> +		},
> +		[RCAR_DU_OUTPUT_HDMI0] = {
> +			.possible_crtcs = BIT(1),
> +			.port = 1,
> +		},
> +		[RCAR_DU_OUTPUT_LVDS0] = {
> +			.possible_crtcs = BIT(0),

I wonder whether it wouldn't be easier to read if we replaced possible_crtcs 
with possible_channels, as this structure describes the hardware and had its 
num_crtcs field replaced with a channel_mask. This would require converting 
the possible_channels field to a possible_crtcs field in 
rcar_du_modeset_init(), and I think that no change would be needed in 
rcar_du_group_setup_defr8() (but please double check). On the other hand, no 
code would be simplified, and rcar_du_modeset_init() would gain some 
additional complexity, so it might not be worth it.

Either way this patch looks good to me.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +			.port = 2,
> +		},
> +	},
> +	.num_lvds = 1,
> +	.dpll_ch =  BIT(1),
> +};
> +
>  static const struct rcar_du_device_info rcar_du_r8a77970_info = {
>  	.gen = 3,
>  	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
> @@ -277,6 +305,7 @@ static const struct of_device_id rcar_du_of_table[] = {
>  	{ .compatible = "renesas,du-r8a7794", .data = &rcar_du_r8a7794_info },
>  	{ .compatible = "renesas,du-r8a7795", .data = &rcar_du_r8a7795_info },
>  	{ .compatible = "renesas,du-r8a7796", .data = &rcar_du_r8a7796_info },
> +	{ .compatible = "renesas,du-r8a77965", .data = &rcar_du_r8a77965_info },
>  	{ .compatible = "renesas,du-r8a77970", .data = &rcar_du_r8a77970_info },
>  	{ }
>  };

-- 
Regards,

Laurent Pinchart
