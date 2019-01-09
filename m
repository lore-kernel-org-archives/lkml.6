Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC735C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8B120685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="ONP5rfI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfAIRJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:09:57 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:52492 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfAIRJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:09:56 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 504125C125C;
        Wed,  9 Jan 2019 18:09:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1547053793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CjRzAZghHk79A1shu2HqK0ha4Nak12CDGKiEv7f1VFE=;
        b=ONP5rfI8aMblcX+7UjgcnagZczJ8FnkH8BRCQq4lbsm3tF0fzGosrpoQDCekDSb5YC1VIJ
        tcXSgLeMCz1eIY9RZqPADmdr/XVALhaaD1Gq8J9CFNNppQMVhRJpU2cQn4/DmTL85Mx2g5
        E0PXSvPHODy9muO/UsEWdY++pzIYUf4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 09 Jan 2019 18:09:53 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Anson Huang <anson.huang@nxp.com>,
        dri-devel@lists.freedesktop.org, dl-linux-imx <linux-imx@nxp.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] drm/mxsfb: Improve the axi clock usage
In-Reply-To: <1547043209-8283-10-git-send-email-robert.chiras@nxp.com>
References: <1547043209-8283-1-git-send-email-robert.chiras@nxp.com>
 <1547043209-8283-10-git-send-email-robert.chiras@nxp.com>
Message-ID: <6265abab29249f3a7a6758870c9b31ff@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.01.2019 15:13, Robert Chiras wrote:
> Currently, the enable of the axi clock return status is ignored, causing
> issues when the enable fails then we try to disable it. Therefore, it is
> better to check the return status and disable it only when enable
> succeeded.
> Also, remove the helper functions around clk_axi, since we can directly
> use the clk API function for enable/disable the clock. Those functions
> are already checking for NULL clk and returning 0 if that's the case.

Can we maybe even use the runtime PM system for that (adding two
callbacks for SET_RUNTIME_PM_OPS)?

I suggested it a while ago, but did not looked deeper into it:
https://lkml.org/lkml/2018/8/1/300

Since we basically enable on mxsfb_crtc_enable and disable on
mxsfb_crtc_disable, I think it would be pretty much the same thing.

--
Stefan


> 
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> Acked-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_crtc.c |  8 ++++----
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c  | 32 +++++++++++++-------------------
>  drivers/gpu/drm/mxsfb/mxsfb_drv.h  |  3 ---
>  3 files changed, 17 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> index 8d1b6a6..b9437c7 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> @@ -411,7 +411,7 @@ void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
>  {
>  	dma_addr_t paddr;
>  
> -	mxsfb_enable_axi_clk(mxsfb);
> +	clk_prepare_enable(mxsfb->clk_axi);
>  	writel(0, mxsfb->base + LCDC_CTRL);
>  	mxsfb_crtc_mode_set_nofb(mxsfb);
>  
> @@ -428,7 +428,7 @@ void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
>  void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
>  {
>  	mxsfb_disable_controller(mxsfb);
> -	mxsfb_disable_axi_clk(mxsfb);
> +	clk_disable_unprepare(mxsfb->clk_axi);
>  }
>  
>  void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
> @@ -456,9 +456,9 @@ void mxsfb_plane_atomic_update(struct
> mxsfb_drm_private *mxsfb,
>  
>  	paddr = mxsfb_get_fb_paddr(mxsfb);
>  	if (paddr) {
> -		mxsfb_enable_axi_clk(mxsfb);
> +		clk_prepare_enable(mxsfb->clk_axi);
>  		writel(paddr, mxsfb->base + mxsfb->devdata->next_buf);
> -		mxsfb_disable_axi_clk(mxsfb);
> +		clk_disable_unprepare(mxsfb->clk_axi);
>  	}
>  
>  	if (!fb || !old_fb)
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 135b8e1..5e18353 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -103,18 +103,6 @@ drm_pipe_to_mxsfb_drm_private(struct
> drm_simple_display_pipe *pipe)
>  	return container_of(pipe, struct mxsfb_drm_private, pipe);
>  }
>  
> -void mxsfb_enable_axi_clk(struct mxsfb_drm_private *mxsfb)
> -{
> -	if (mxsfb->clk_axi)
> -		clk_prepare_enable(mxsfb->clk_axi);
> -}
> -
> -void mxsfb_disable_axi_clk(struct mxsfb_drm_private *mxsfb)
> -{
> -	if (mxsfb->clk_axi)
> -		clk_disable_unprepare(mxsfb->clk_axi);
> -}
> -
>  /**
>   * mxsfb_atomic_helper_check - validate state object
>   * @dev: DRM device
> @@ -237,25 +225,31 @@ static void mxsfb_pipe_update(struct
> drm_simple_display_pipe *pipe,
>  static int mxsfb_pipe_enable_vblank(struct drm_simple_display_pipe *pipe)
>  {
>  	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
> +	int ret = 0;
> +
> +	ret = clk_prepare_enable(mxsfb->clk_axi);
> +	if (ret)
> +		return ret;
>  
>  	/* Clear and enable VBLANK IRQ */
> -	mxsfb_enable_axi_clk(mxsfb);
>  	writel(CTRL1_CUR_FRAME_DONE_IRQ, mxsfb->base + LCDC_CTRL1 + REG_CLR);
>  	writel(CTRL1_CUR_FRAME_DONE_IRQ_EN, mxsfb->base + LCDC_CTRL1 + REG_SET);
> -	mxsfb_disable_axi_clk(mxsfb);
> +	clk_disable_unprepare(mxsfb->clk_axi);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static void mxsfb_pipe_disable_vblank(struct drm_simple_display_pipe *pipe)
>  {
>  	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
>  
> +	if (clk_prepare_enable(mxsfb->clk_axi))
> +		return;
> +
>  	/* Disable and clear VBLANK IRQ */
> -	mxsfb_enable_axi_clk(mxsfb);
>  	writel(CTRL1_CUR_FRAME_DONE_IRQ_EN, mxsfb->base + LCDC_CTRL1 + REG_CLR);
>  	writel(CTRL1_CUR_FRAME_DONE_IRQ, mxsfb->base + LCDC_CTRL1 + REG_CLR);
> -	mxsfb_disable_axi_clk(mxsfb);
> +	clk_disable_unprepare(mxsfb->clk_axi);
>  }
>  
>  static struct drm_simple_display_pipe_funcs mxsfb_funcs = {
> @@ -440,7 +434,7 @@ static irqreturn_t mxsfb_irq_handler(int irq, void *data)
>  	struct mxsfb_drm_private *mxsfb = drm->dev_private;
>  	u32 reg;
>  
> -	mxsfb_enable_axi_clk(mxsfb);
> +	clk_prepare_enable(mxsfb->clk_axi);
>  
>  	reg = readl(mxsfb->base + LCDC_CTRL1);
>  
> @@ -449,7 +443,7 @@ static irqreturn_t mxsfb_irq_handler(int irq, void *data)
>  
>  	writel(CTRL1_CUR_FRAME_DONE_IRQ, mxsfb->base + LCDC_CTRL1 + REG_CLR);
>  
> -	mxsfb_disable_axi_clk(mxsfb);
> +	clk_disable_unprepare(mxsfb->clk_axi);
>  
>  	return IRQ_HANDLED;
>  }
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> index c15b4f9..ce98411 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> @@ -47,9 +47,6 @@ struct mxsfb_drm_private {
>  int mxsfb_setup_crtc(struct drm_device *dev);
>  int mxsfb_create_output(struct drm_device *dev);
>  
> -void mxsfb_enable_axi_clk(struct mxsfb_drm_private *mxsfb);
> -void mxsfb_disable_axi_clk(struct mxsfb_drm_private *mxsfb);
> -
>  void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb);
>  void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb);
>  void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
