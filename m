Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D9BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB03208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB03208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732131AbeGaNfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:35:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56389 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731962AbeGaNfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:35:03 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1fkTEv-0000Gf-Qi; Tue, 31 Jul 2018 13:54:57 +0200
Message-ID: <1533038097.3444.13.camel@pengutronix.de>
Subject: Re: [PATCH v2] drm/mxsfb: Fix runtime PM for unpowering lcdif block
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Robert Chiras <robert.chiras@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Date:   Tue, 31 Jul 2018 13:54:57 +0200
In-Reply-To: <f873c5592e9907beba905ce68358d5ae2f63a4d7.1531824173.git.leonard.crestez@nxp.com>
References: <f873c5592e9907beba905ce68358d5ae2f63a4d7.1531824173.git.leonard.crestez@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 13:48 +0300, Leonard Crestez wrote:
> Adding lcdif nodes to a power domain currently does work, it results in
> black/corrupted screens or hangs. While the driver does enable runtime
> pm it does not deal correctly with the block being unpowered.
> 
> Ensure power is on when required by adding pm_runtime_get/put_sync to
> mxsfb_pipe_enable/disable.
> 
> Since power is lost on suspend implement PM_SLEEP_OPS using
> drm_mode_config_helper_suspend/resume.
> 
> The mxsfb_plane_atomic_update function can get called before
> mxsfb_pipe_enable while the block is not yet powered. When this happens
> the write to LCDIF_NEXT_BUF is lost causing corrupt display on unblank
> until a refresh.

Why does this happen?

> Fix this by not writing gem->paddr if the block is not enabled and
> instead delaying the write until the next mxsfb_crtc_mode_set_nofb call.
> At that point also update cur_buf to avoid an initial corrupt frame
> after resume.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Tested-by: Philipp Zabel <p.zabel@pengutronix.de>

on imx6ull-evk, this fixes the initial corrupt frame.

regards
Philipp

> 
> ---
> 
> The purpose of this patch is to prepare for enabling power gating on
> DISPLAY power domains.
> 
> Changes since v1:
> * Drop mxsfb_runtime_suspend/mxsfb_runtime_resume, calling
> pm_runtime_get/put in pipe enable/disable is enough.
> * Use drm_mode_config_helper_suspend/resume instead of attempting to
> track state manually.
> * Don't touch NEXT_BUF if atomic_update called with crtc disabled
> * Also update CUR_BUF on enable, this avoids initial corrupt frames.
> 
> Previous discussion: https://lkml.org/lkml/2018/7/17/329
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 51 +++++++++++++++++++++++-------
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c  | 25 +++++++++++++++
>  drivers/gpu/drm/mxsfb/mxsfb_drv.h  |  2 ++
>  3 files changed, 67 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> index 0abe77675b76..10153da77c40 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> @@ -194,15 +194,31 @@ static int mxsfb_reset_block(void __iomem *reset_addr)
>  		return ret;
>  
>  	return clear_poll_bit(reset_addr, MODULE_CLKGATE);
>  }
>  
> +static dma_addr_t mxsfb_get_fb_paddr(struct mxsfb_drm_private *mxsfb)
> +{
> +	struct drm_framebuffer *fb = mxsfb->pipe.plane.state->fb;
> +	struct drm_gem_cma_object *gem;
> +
> +	if (!fb)
> +		return 0;
> +
> +	gem = drm_fb_cma_get_gem_obj(fb, 0);
> +	if (!gem)
> +		return 0;
> +
> +	return gem->paddr;
> +}
> +
>  static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
>  {
>  	struct drm_display_mode *m = &mxsfb->pipe.crtc.state->adjusted_mode;
>  	const u32 bus_flags = mxsfb->connector.display_info.bus_flags;
>  	u32 vdctrl0, vsync_pulse_len, hsync_pulse_len;
> +	dma_addr_t paddr;
>  	int err;
>  
>  	/*
>  	 * It seems, you can't re-program the controller if it is still
>  	 * running. This may lead to shifted pictures (FIFO issue?), so
> @@ -268,35 +284,47 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
>  	       mxsfb->base + LCDC_VDCTRL3);
>  
>  	writel(SET_DOTCLK_H_VALID_DATA_CNT(m->hdisplay),
>  	       mxsfb->base + LCDC_VDCTRL4);
>  
> +	/* Update cur_buf as well to avoid an initial corrupt frame */
> +	paddr = mxsfb_get_fb_paddr(mxsfb);
> +	if (paddr) {
> +		writel(paddr, mxsfb->base + mxsfb->devdata->cur_buf);
> +		writel(paddr, mxsfb->base + mxsfb->devdata->next_buf);
> +	}
>  	mxsfb_disable_axi_clk(mxsfb);
>  }
>  
>  void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
>  {
> +	if (mxsfb->enabled)
> +		return;
> +
>  	mxsfb_crtc_mode_set_nofb(mxsfb);
>  	mxsfb_enable_controller(mxsfb);
> +
> +	mxsfb->enabled = true;
>  }
>  
>  void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
>  {
> +	if (!mxsfb->enabled)
> +		return;
> +
>  	mxsfb_disable_controller(mxsfb);
> +
> +	mxsfb->enabled = false;
>  }
>  
>  void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
>  			       struct drm_plane_state *state)
>  {
>  	struct drm_simple_display_pipe *pipe = &mxsfb->pipe;
>  	struct drm_crtc *crtc = &pipe->crtc;
> -	struct drm_framebuffer *fb = pipe->plane.state->fb;
>  	struct drm_pending_vblank_event *event;
> -	struct drm_gem_cma_object *gem;
> -
> -	if (!crtc)
> -		return;
> +	dma_addr_t paddr;
>  
>  	spin_lock_irq(&crtc->dev->event_lock);
>  	event = crtc->state->event;
>  	if (event) {
>  		crtc->state->event = NULL;
> @@ -307,14 +335,15 @@ void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
>  			drm_crtc_send_vblank_event(crtc, event);
>  		}
>  	}
>  	spin_unlock_irq(&crtc->dev->event_lock);
>  
> -	if (!fb)
> +	if (!mxsfb->enabled)
>  		return;
>  
> -	gem = drm_fb_cma_get_gem_obj(fb, 0);
> -
> -	mxsfb_enable_axi_clk(mxsfb);
> -	writel(gem->paddr, mxsfb->base + mxsfb->devdata->next_buf);
> -	mxsfb_disable_axi_clk(mxsfb);
> +	paddr = mxsfb_get_fb_paddr(mxsfb);
> +	if (paddr) {
> +		mxsfb_enable_axi_clk(mxsfb);
> +		writel(paddr, mxsfb->base + mxsfb->devdata->next_buf);
> +		mxsfb_disable_axi_clk(mxsfb);
> +	}
>  }
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index dd1dd58e4956..a5269fccbed9 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -101,23 +101,27 @@ static const struct drm_mode_config_funcs mxsfb_mode_config_funcs = {
>  static void mxsfb_pipe_enable(struct drm_simple_display_pipe *pipe,
>  			      struct drm_crtc_state *crtc_state,
>  			      struct drm_plane_state *plane_state)
>  {
>  	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
> +	struct drm_device *drm = pipe->plane.dev;
>  
> +	pm_runtime_get_sync(drm->dev);
>  	drm_panel_prepare(mxsfb->panel);
>  	mxsfb_crtc_enable(mxsfb);
>  	drm_panel_enable(mxsfb->panel);
>  }
>  
>  static void mxsfb_pipe_disable(struct drm_simple_display_pipe *pipe)
>  {
>  	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
> +	struct drm_device *drm = pipe->plane.dev;
>  
>  	drm_panel_disable(mxsfb->panel);
>  	mxsfb_crtc_disable(mxsfb);
>  	drm_panel_unprepare(mxsfb->panel);
> +	pm_runtime_put_sync(drm->dev);
>  }
>  
>  static void mxsfb_pipe_update(struct drm_simple_display_pipe *pipe,
>  			      struct drm_plane_state *plane_state)
>  {
> @@ -412,17 +416,38 @@ static int mxsfb_remove(struct platform_device *pdev)
>  	drm_dev_unref(drm);
>  
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM
> +static int mxsfb_suspend(struct device *dev)
> +{
> +       struct drm_device *drm = dev_get_drvdata(dev);
> +
> +       return drm_mode_config_helper_suspend(drm);
> +}
> +
> +static int mxsfb_resume(struct device *dev)
> +{
> +       struct drm_device *drm = dev_get_drvdata(dev);
> +
> +       return drm_mode_config_helper_resume(drm);
> +}
> +#endif
> +
> +static const struct dev_pm_ops mxsfb_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(mxsfb_suspend, mxsfb_resume)
> +};
> +
>  static struct platform_driver mxsfb_platform_driver = {
>  	.probe		= mxsfb_probe,
>  	.remove		= mxsfb_remove,
>  	.id_table	= mxsfb_devtype,
>  	.driver	= {
>  		.name		= "mxsfb-drm",
>  		.of_match_table	= mxsfb_dt_ids,
> +		.pm		= &mxsfb_pm_ops,
>  	},
>  };
>  
>  module_platform_driver(mxsfb_platform_driver);
>  
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> index 5d0883fc805b..e539d4b05c48 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> @@ -36,10 +36,12 @@ struct mxsfb_drm_private {
>  
>  	struct drm_simple_display_pipe	pipe;
>  	struct drm_connector		connector;
>  	struct drm_panel		*panel;
>  	struct drm_fbdev_cma		*fbdev;
> +
> +	bool enabled;
>  };
>  
>  int mxsfb_setup_crtc(struct drm_device *dev);
>  int mxsfb_create_output(struct drm_device *dev);
>  
