Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D074ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0FB20871
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="UQZOwp/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0FB20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbeGMLLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:11:53 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:41690 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbeGMLLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:11:53 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id B0A8A5C168B;
        Fri, 13 Jul 2018 12:57:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1531479462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+XQUQ/ub+vIr4cH9vOu5JRUyoZDo7g/oHHe5ziiKbSg=;
        b=UQZOwp/fCapStHAx1L7mEGY6pK29Vc8ewOk24biu9uwZmxvv9DeCgaSKYQi29dSybRqdmA
        gXZxmMUt5w5ljjRFmjkdrSkDIKNwcv4mYYRRAJihJo7gZnbhdbhqtnVKrN41M43607T90U
        mDB0OVYwiGn/MNKaqfhbKkrqmFCjCfY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Jul 2018 12:57:42 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Marek Vasut <marex@denx.de>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Robert Chiras <robert.chiras@nxp.com>,
        dri-devel@lists.freedesktop.org,
        Marco Franchi <marco.franchi@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/mxsfb: Fix runtime PM for unpowering lcdif block
In-Reply-To: <cd4ddc544a27915cab58a218223723eb18525c21.1528218001.git.leonard.crestez@nxp.com>
References: <cd4ddc544a27915cab58a218223723eb18525c21.1528218001.git.leonard.crestez@nxp.com>
Message-ID: <2024fd1b31818e5f62c779a33c6011e4@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[15];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.06.2018 19:11, Leonard Crestez wrote:
> Adding imx6sl/sx lcdif nodes in a power domain currently does work, it
> results in black/corrupted screens or hangs. While the driver does
> enable runtime pm it does not deal correctly with the block being
> unpowered.
> 
> Fix by adding pm_runtime_get/put_sync to mxsfb_pipe_enable/disable.
> 
> The mxsfb_plane_atomic_update function can get called before
> mxsfb_pipe_enable while the block is not powered. When this happens the
> write to LCDIF_NEXT_BUF is lost causing random corrupted pixels on
> unblank.
> 
> Fix this by splitting the writing of gem->paddr to nextbuf into a
> mxsfb_update_hw_next_buf functiona and also calling it from
> mxsfb_crtc_mode_set_nofb.
> 
> Also add fields to mxsfb_drv to keep track of enabled/suspended states.
> 
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

That patch seems to go in the right direction.

One comment below.

> 
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 38 +++++++++++-----
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c  | 72 +++++++++++++++++++++++++++++-
>  drivers/gpu/drm/mxsfb/mxsfb_drv.h  |  3 ++
>  3 files changed, 100 insertions(+), 13 deletions(-)
> 
> This was initially written by Robert for imx8m but I tested it also
> works on imx6sx/imx6sl to DISPMIX power domain.
> 
> Tested on imx6sl-evk and imx6sx-sdb with SEIKO 43WVF1G panel by
> blanking and unblanking via sysfs and suspend/resume
> 
> Testing requires a modified config (to enable MXFSB_DRM):
> CONFIG_DRM_MXSFB=y
> CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
> CONFIG_FB_MXS=n
> 
> It also requires dts changes to enable the DISPMIX power domain.  The
> dts changes might break drivers so this patch attempts to fix the lcdif
> driver first.
> 
> Patch 2 is a RFC of imx6sl changes, imx6sx is a bit more complicated
> and it also interacts with PCI.
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> index 0abe77675b76..cce2ec1c80ae 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> @@ -194,10 +194,25 @@ static int mxsfb_reset_block(void __iomem *reset_addr)
>  		return ret;
>  
>  	return clear_poll_bit(reset_addr, MODULE_CLKGATE);
>  }
>  
> +static void mxsfb_update_hw_next_buf(struct mxsfb_drm_private *mxsfb)
> +{
> +	struct drm_framebuffer *fb = mxsfb->pipe.plane.state->fb;
> +	struct drm_gem_cma_object *gem;
> +
> +	if (!fb)
> +		return;
> +
> +	gem = drm_fb_cma_get_gem_obj(fb, 0);
> +	if (!gem)
> +		return;
> +
> +	writel(gem->paddr, mxsfb->base + mxsfb->devdata->next_buf);
> +}
> +
>  static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
>  {
>  	struct drm_display_mode *m = &mxsfb->pipe.crtc.state->adjusted_mode;
>  	const u32 bus_flags = mxsfb->connector.display_info.bus_flags;
>  	u32 vdctrl0, vsync_pulse_len, hsync_pulse_len;
> @@ -268,35 +283,41 @@ static void mxsfb_crtc_mode_set_nofb(struct
> mxsfb_drm_private *mxsfb)
>  	       mxsfb->base + LCDC_VDCTRL3);
>  
>  	writel(SET_DOTCLK_H_VALID_DATA_CNT(m->hdisplay),
>  	       mxsfb->base + LCDC_VDCTRL4);
>  
> +	mxsfb_update_hw_next_buf(mxsfb);
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

Is this state keeping really necessary?

--
Stefan

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
>  
>  	spin_lock_irq(&crtc->dev->event_lock);
>  	event = crtc->state->event;
>  	if (event) {
>  		crtc->state->event = NULL;
> @@ -307,14 +328,9 @@ void mxsfb_plane_atomic_update(struct
> mxsfb_drm_private *mxsfb,
>  			drm_crtc_send_vblank_event(crtc, event);
>  		}
>  	}
>  	spin_unlock_irq(&crtc->dev->event_lock);
>  
> -	if (!fb)
> -		return;
> -
> -	gem = drm_fb_cma_get_gem_obj(fb, 0);
> -
>  	mxsfb_enable_axi_clk(mxsfb);
> -	writel(gem->paddr, mxsfb->base + mxsfb->devdata->next_buf);
> +	mxsfb_update_hw_next_buf(mxsfb);
>  	mxsfb_disable_axi_clk(mxsfb);
>  }
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 5cae8db9dcd4..c889cac2e275 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -100,23 +100,27 @@ static const struct drm_mode_config_funcs
> mxsfb_mode_config_funcs = {
>  
>  static void mxsfb_pipe_enable(struct drm_simple_display_pipe *pipe,
>  			      struct drm_crtc_state *crtc_state)
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
> @@ -175,10 +179,11 @@ static int mxsfb_load(struct drm_device *drm,
> unsigned long flags)
>  	if (!mxsfb)
>  		return -ENOMEM;
>  
>  	drm->dev_private = mxsfb;
>  	mxsfb->devdata = &mxsfb_devdata[pdev->id_entry->driver_data];
> +	platform_set_drvdata(pdev, drm);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	mxsfb->base = devm_ioremap_resource(drm->dev, res);
>  	if (IS_ERR(mxsfb->base))
>  		return PTR_ERR(mxsfb->base);
> @@ -256,12 +261,10 @@ static int mxsfb_load(struct drm_device *drm,
> unsigned long flags)
>  		mxsfb->fbdev = NULL;
>  		dev_err(drm->dev, "Failed to init FB CMA area\n");
>  		goto err_cma;
>  	}
>  
> -	platform_set_drvdata(pdev, drm);
> -
>  	drm_helper_hpd_irq_event(drm);
>  
>  	return 0;
>  
>  err_cma:
> @@ -417,17 +420,82 @@ static int mxsfb_remove(struct platform_device *pdev)
>  	drm_dev_unref(drm);
>  
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM
> +static int mxsfb_runtime_suspend(struct device *dev)
> +{
> +	struct drm_device *drm = dev_get_drvdata(dev);
> +	struct mxsfb_drm_private *mxsfb = drm->dev_private;
> +
> +	if (!drm->registered)
> +		return 0;
> +
> +	if (mxsfb->enabled) {
> +		mxsfb_crtc_disable(mxsfb);
> +		mxsfb->suspended = true;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mxsfb_runtime_resume(struct device *dev)
> +{
> +	struct drm_device *drm = dev_get_drvdata(dev);
> +	struct mxsfb_drm_private *mxsfb = drm->dev_private;
> +
> +	if (!drm->registered || !mxsfb->suspended)
> +		return 0;
> +
> +	mxsfb_crtc_enable(mxsfb);
> +	mxsfb->suspended = false;
> +
> +	return 0;
> +}
> +
> +static int mxsfb_suspend(struct device *dev)
> +{
> +	struct drm_device *drm = dev_get_drvdata(dev);
> +	struct mxsfb_drm_private *mxsfb = drm->dev_private;
> +
> +	if (mxsfb->enabled) {
> +		mxsfb_crtc_disable(mxsfb);
> +		mxsfb->suspended = true;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mxsfb_resume(struct device *dev)
> +{
> +	struct drm_device *drm = dev_get_drvdata(dev);
> +	struct mxsfb_drm_private *mxsfb = drm->dev_private;
> +
> +	if (!mxsfb->suspended)
> +		return 0;
> +
> +	mxsfb_crtc_enable(mxsfb);
> +	mxsfb->suspended = false;
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops mxsfb_pm_ops = {
> +	SET_RUNTIME_PM_OPS(mxsfb_runtime_suspend, mxsfb_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(mxsfb_suspend, mxsfb_resume)
> +};
> +
>  static struct platform_driver mxsfb_platform_driver = {
>  	.probe		= mxsfb_probe,
>  	.remove		= mxsfb_remove,
>  	.id_table	= mxsfb_devtype,
>  	.driver	= {
>  		.name		= "mxsfb",
>  		.of_match_table	= mxsfb_dt_ids,
> +		.pm = &mxsfb_pm_ops,
>  	},
>  };
>  
>  module_platform_driver(mxsfb_platform_driver);
>  
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> index 5d0883fc805b..d8ef4a053f0e 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> @@ -36,10 +36,13 @@ struct mxsfb_drm_private {
>  
>  	struct drm_simple_display_pipe	pipe;
>  	struct drm_connector		connector;
>  	struct drm_panel		*panel;
>  	struct drm_fbdev_cma		*fbdev;
> +
> +	bool                            enabled;
> +	bool                            suspended;
>  };
>  
>  int mxsfb_setup_crtc(struct drm_device *dev);
>  int mxsfb_create_output(struct drm_device *dev);
