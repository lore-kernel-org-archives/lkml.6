Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeDLKR7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 06:17:59 -0400
Received: from foss.arm.com ([217.140.101.70]:58918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbeDLKR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 06:17:58 -0400
Date: Thu, 12 Apr 2018 11:17:56 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Ayan Kumar Halder <ayan.halder@arm.com>
Cc: brian.starkey@arm.com, malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH] drm/arm/malidp: Preserve LAYER_FORMAT contents when
 setting format
Message-ID: <20180412101756.GA14661@e110455-lin.cambridge.arm.com>
References: <1523384703-17621-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1523384703-17621-1-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 07:25:03PM +0100, Ayan Kumar Halder wrote:
> On some Mali-DP processors, the LAYER_FORMAT register contains fields
> other than the format. These bits were unconditionally cleared when
> setting the pixel format, whereas they should be preserved at their
> reset values.
> 
> Reported-by: Brian Starkey <brian.starkey@arm.com>
> Reported-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks for catching this in testing!

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/malidp_planes.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> index 7a44897..4af3c1f 100644
> --- a/drivers/gpu/drm/arm/malidp_planes.c
> +++ b/drivers/gpu/drm/arm/malidp_planes.c
> @@ -23,6 +23,7 @@
>  
>  /* Layer specific register offsets */
>  #define MALIDP_LAYER_FORMAT		0x000
> +#define   LAYER_FORMAT_MASK		0x3f
>  #define MALIDP_LAYER_CONTROL		0x004
>  #define   LAYER_ENABLE			(1 << 0)
>  #define   LAYER_FLOWCFG_MASK		7
> @@ -337,7 +338,9 @@ static void malidp_de_plane_update(struct drm_plane *plane,
>  	dest_w = plane->state->crtc_w;
>  	dest_h = plane->state->crtc_h;
>  
> -	malidp_hw_write(mp->hwdev, ms->format, mp->layer->base);
> +	val = malidp_hw_read(mp->hwdev, mp->layer->base);
> +	val = (val & ~LAYER_FORMAT_MASK) | ms->format;
> +	malidp_hw_write(mp->hwdev, val, mp->layer->base);
>  
>  	for (i = 0; i < ms->n_planes; i++) {
>  		/* calculate the offset for the layer's plane registers */
> -- 
> 2.7.4
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
