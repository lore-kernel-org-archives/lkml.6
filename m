Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755573AbeDZUgh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:36:37 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59594 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754119AbeDZUgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:36:35 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS FOR RENESAS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/17] drm: rcar-du: Allow DU groups to work with hardware indexing
Date: Thu, 26 Apr 2018 23:36:48 +0300
Message-ID: <10312647.9oa0HbEkDa@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180426165346.494-7-kieran.bingham+renesas@ideasonboard.com>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com> <20180426165346.494-7-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Thursday, 26 April 2018 19:53:35 EEST Kieran Bingham wrote:
> The group objects assume linear indexing, and more so always assume that
> channel 0 of any active group is used.
> 
> Now that the CRTC objects support non-linear indexing, adapt the groups
> to remove assumptions that channel 0 is utilised in each group by using
> the channel mask provided in the device structures.
> 
> Finally ensure that the RGB routing is determined from the index of the
> CRTC object (which represents the hardware DU channel index).
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_group.c | 14 +++++++++-----
>  drivers/gpu/drm/rcar-du/rcar_du_group.h |  2 ++
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c   |  5 ++++-
>  3 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.c
> b/drivers/gpu/drm/rcar-du/rcar_du_group.c index eead202c95c7..c52091fe02ba
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_group.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_group.c
> @@ -46,9 +46,12 @@ void rcar_du_group_write(struct rcar_du_group *rgrp, u32
> reg, u32 data)
> 
>  static void rcar_du_group_setup_pins(struct rcar_du_group *rgrp)
>  {
> -	u32 defr6 = DEFR6_CODE | DEFR6_ODPM02_DISP;
> +	u32 defr6 = DEFR6_CODE;
> 
> -	if (rgrp->num_crtcs > 1)
> +	if (rgrp->channel_mask & BIT(0))
> +		defr6 |= DEFR6_ODPM02_DISP;
> +
> +	if (rgrp->channel_mask & BIT(1))
>  		defr6 |= DEFR6_ODPM12_DISP;

So much cleaner with the channels mask, I like this.

>  	rcar_du_group_write(rgrp, DEFR6, defr6);
> @@ -80,10 +83,11 @@ static void rcar_du_group_setup_defr8(struct
> rcar_du_group *rgrp) * On Gen3 VSPD routing can't be configured, but DPAD
> routing
>  		 * needs to be set despite having a single option available.
>  		 */
> -		u32 crtc = ffs(possible_crtcs) - 1;
> +		unsigned int rgb_crtc = ffs(possible_crtcs) - 1;
> +		struct rcar_du_crtc *crtc = &rcdu->crtcs[rgb_crtc];
> 
> -		if (crtc / 2 == rgrp->index)
> -			defr8 |= DEFR8_DRGBS_DU(crtc);
> +		if (crtc->index / 2 == rgrp->index)
> +			defr8 |= DEFR8_DRGBS_DU(crtc->index);
>  	}
> 
>  	rcar_du_group_write(rgrp, DEFR8, defr8);
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.h
> b/drivers/gpu/drm/rcar-du/rcar_du_group.h index 5e3adc6b31b5..d29a68e006a7
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_group.h
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_group.h
> @@ -25,6 +25,7 @@ struct rcar_du_device;
>   * @dev: the DU device
>   * @mmio_offset: registers offset in the device memory map
>   * @index: group index
> + * @channel_mask: bitmask of populated DU channels in this group
>   * @num_crtcs: number of CRTCs in this group (1 or 2)
>   * @use_count: number of users of the group (rcar_du_group_(get|put))
>   * @used_crtcs: number of CRTCs currently in use
> @@ -39,6 +40,7 @@ struct rcar_du_group {
>  	unsigned int mmio_offset;
>  	unsigned int index;
> 
> +	unsigned int channel_mask;

Depending on how you like my suggestion in patch 05/17, this might be better 
called channels_mask.

>  	unsigned int num_crtcs;
>  	unsigned int use_count;
>  	unsigned int used_crtcs;
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> b/drivers/gpu/drm/rcar-du/rcar_du_kms.c index 19a445fbc879..45fb554fd3c7
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> @@ -597,7 +597,10 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
>  		rgrp->dev = rcdu;
>  		rgrp->mmio_offset = mmio_offsets[i];
>  		rgrp->index = i;
> -		rgrp->num_crtcs = min(rcdu->num_crtcs - 2 * i, 2U);
> +		/* Extract the channel mask for this group only */

s/only/only./

> +		rgrp->channel_mask = (rcdu->info->channel_mask >> (2 * i))
> +				   & GENMASK(1, 0);
> +		rgrp->num_crtcs = hweight8(rgrp->channel_mask);

You could optimize this by computing it as

	rgrp->num_crtcs = (rgrp->channel_mask >> 1)
			| (rgrp->channel_mask & 1);

as you know that only two bits at most can be set. Up to you.

>  		/*
>  		 * If we have more than one CRTCs in this group pre-associate

With those small issues fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
