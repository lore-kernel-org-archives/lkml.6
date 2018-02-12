Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933270AbeBLJgc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 04:36:32 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:48313 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932621AbeBLJgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 04:36:31 -0500
X-Auth-Info: gh6EHaphQWrzS9PBQIKrZoaqyMsl7qEoYv8CfOIbROg=
Subject: Re: [PATCH 2/4] drm/mxsfb: Do not use deprecated
 drm_driver.{enable|disable)_vblank
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: daniel.vetter@intel.com, gustavo@padovan.org, airlied@linux.ie,
        seanpaul@chromium.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1518425574-32671-1-git-send-email-andr2000@gmail.com>
 <1518425574-32671-3-git-send-email-andr2000@gmail.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <a634b80e-1549-86a1-4cda-274743eec554@denx.de>
Date: Mon, 12 Feb 2018 10:26:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518425574-32671-3-git-send-email-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 09:52 AM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> Do not use deprecated drm_driver.{enable|disable)_vblank callbacks,
> but use drm_simple_kms_helpe's pipe callbacks instead.
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Cc: Marek Vasut <marex@denx.de>

Reviewed-by: Marek Vasut <marex@denx.de>

> ---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 54 ++++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 1207ffe36250..5cae8db9dcd4 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -131,11 +131,37 @@ static int mxsfb_pipe_prepare_fb(struct drm_simple_display_pipe *pipe,
>  	return drm_gem_fb_prepare_fb(&pipe->plane, plane_state);
>  }
>  
> +static int mxsfb_pipe_enable_vblank(struct drm_simple_display_pipe *pipe)
> +{
> +	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
> +
> +	/* Clear and enable VBLANK IRQ */
> +	mxsfb_enable_axi_clk(mxsfb);
> +	writel(CTRL1_CUR_FRAME_DONE_IRQ, mxsfb->base + LCDC_CTRL1 + REG_CLR);
> +	writel(CTRL1_CUR_FRAME_DONE_IRQ_EN, mxsfb->base + LCDC_CTRL1 + REG_SET);
> +	mxsfb_disable_axi_clk(mxsfb);
> +
> +	return 0;
> +}
> +
> +static void mxsfb_pipe_disable_vblank(struct drm_simple_display_pipe *pipe)
> +{
> +	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
> +
> +	/* Disable and clear VBLANK IRQ */
> +	mxsfb_enable_axi_clk(mxsfb);
> +	writel(CTRL1_CUR_FRAME_DONE_IRQ_EN, mxsfb->base + LCDC_CTRL1 + REG_CLR);
> +	writel(CTRL1_CUR_FRAME_DONE_IRQ, mxsfb->base + LCDC_CTRL1 + REG_CLR);
> +	mxsfb_disable_axi_clk(mxsfb);
> +}
> +
>  static struct drm_simple_display_pipe_funcs mxsfb_funcs = {
>  	.enable		= mxsfb_pipe_enable,
>  	.disable	= mxsfb_pipe_disable,
>  	.update		= mxsfb_pipe_update,
>  	.prepare_fb	= mxsfb_pipe_prepare_fb,
> +	.enable_vblank	= mxsfb_pipe_enable_vblank,
> +	.disable_vblank	= mxsfb_pipe_disable_vblank,
>  };
>  
>  static int mxsfb_load(struct drm_device *drm, unsigned long flags)
> @@ -274,33 +300,11 @@ static void mxsfb_lastclose(struct drm_device *drm)
>  	drm_fbdev_cma_restore_mode(mxsfb->fbdev);
>  }
>  
> -static int mxsfb_enable_vblank(struct drm_device *drm, unsigned int crtc)
> -{
> -	struct mxsfb_drm_private *mxsfb = drm->dev_private;
> -
> -	/* Clear and enable VBLANK IRQ */
> -	mxsfb_enable_axi_clk(mxsfb);
> -	writel(CTRL1_CUR_FRAME_DONE_IRQ, mxsfb->base + LCDC_CTRL1 + REG_CLR);
> -	writel(CTRL1_CUR_FRAME_DONE_IRQ_EN, mxsfb->base + LCDC_CTRL1 + REG_SET);
> -	mxsfb_disable_axi_clk(mxsfb);
> -
> -	return 0;
> -}
> -
> -static void mxsfb_disable_vblank(struct drm_device *drm, unsigned int crtc)
> +static void mxsfb_irq_preinstall(struct drm_device *drm)
>  {
>  	struct mxsfb_drm_private *mxsfb = drm->dev_private;
>  
> -	/* Disable and clear VBLANK IRQ */
> -	mxsfb_enable_axi_clk(mxsfb);
> -	writel(CTRL1_CUR_FRAME_DONE_IRQ_EN, mxsfb->base + LCDC_CTRL1 + REG_CLR);
> -	writel(CTRL1_CUR_FRAME_DONE_IRQ, mxsfb->base + LCDC_CTRL1 + REG_CLR);
> -	mxsfb_disable_axi_clk(mxsfb);
> -}
> -
> -static void mxsfb_irq_preinstall(struct drm_device *drm)
> -{
> -	mxsfb_disable_vblank(drm, 0);
> +	mxsfb_pipe_disable_vblank(&mxsfb->pipe);
>  }
>  
>  static irqreturn_t mxsfb_irq_handler(int irq, void *data)
> @@ -333,8 +337,6 @@ static struct drm_driver mxsfb_driver = {
>  	.irq_handler		= mxsfb_irq_handler,
>  	.irq_preinstall		= mxsfb_irq_preinstall,
>  	.irq_uninstall		= mxsfb_irq_preinstall,
> -	.enable_vblank		= mxsfb_enable_vblank,
> -	.disable_vblank		= mxsfb_disable_vblank,
>  	.gem_free_object_unlocked = drm_gem_cma_free_object,
>  	.gem_vm_ops		= &drm_gem_cma_vm_ops,
>  	.dumb_create		= drm_gem_cma_dumb_create,
> 


-- 
Best regards,
Marek Vasut
