Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31852C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDE920857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="j6xyAvIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDE920857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbeG3XvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:51:10 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48840 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeG3XvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:51:10 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6022A1AC2;
        Tue, 31 Jul 2018 00:14:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1532988844;
        bh=a5zb4wa/BK8ViY8+Rp4HZqM3cUrFuLyRNY8CerWsZh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j6xyAvITeZQFU2I3RfS+HlWfBYPLB3tYmzFx8HGdOKqxGiRHs5dHD6xwKn/6m5o+j
         K3NK/TMm6624tYK2xvO2PCqnRU8P8/HQKozGM44D+p7PxSWrvWVq5MJsYjQ0+k+Zj/
         zIxzKBe5/h7JjZd/2RNhacxFNtoHjo4qFpkMLSCY=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     liviu.dudau@arm.com, brian.starkey@arm.com, malidp@foss.arm.com,
        airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        ajitn.linux@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] drm: Convert drm_atomic_helper_suspend/resume()
Date:   Tue, 31 Jul 2018 01:14:43 +0300
Message-ID: <3328858.Mu96AcVENO@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180730190137.GA25420@jordon-HP-15-Notebook-PC>
References: <20180730190137.GA25420@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Souptick,

Thank you for the patch.

On Monday, 30 July 2018 22:01:37 EEST Souptick Joarder wrote:
> convert drm_atomic_helper_suspend/resume() to use
> drm_mode_config_helper_suspend/resume().
> 
> With this conversion, drm_fbdev_cma_set_suspend_unlocked()
> will left with no consumer. So this function can be removed.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> ---
>  drivers/gpu/drm/arm/hdlcd_drv.c       | 26 ++------------------------
>  drivers/gpu/drm/drm_fb_cma_helper.c   | 18 ------------------
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 21 ++-------------------
>  include/drm/drm_fb_cma_helper.h       |  2 --
>  4 files changed, 4 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c
> b/drivers/gpu/drm/arm/hdlcd_drv.c index feaa8bc..4e617e0 100644
> --- a/drivers/gpu/drm/arm/hdlcd_drv.c
> +++ b/drivers/gpu/drm/arm/hdlcd_drv.c
> @@ -427,37 +427,15 @@ static int hdlcd_remove(struct platform_device *pdev)
>  static int __maybe_unused hdlcd_pm_suspend(struct device *dev)
>  {
>  	struct drm_device *drm = dev_get_drvdata(dev);
> -	struct hdlcd_drm_private *hdlcd = drm ? drm->dev_private : NULL;
> 
> -	if (!hdlcd)
> -		return 0;
> -
> -	drm_kms_helper_poll_disable(drm);
> -	drm_fbdev_cma_set_suspend_unlocked(hdlcd->fbdev, 1);
> -
> -	hdlcd->state = drm_atomic_helper_suspend(drm);
> -	if (IS_ERR(hdlcd->state)) {
> -		drm_fbdev_cma_set_suspend_unlocked(hdlcd->fbdev, 0);
> -		drm_kms_helper_poll_enable(drm);
> -		return PTR_ERR(hdlcd->state);
> -	}
> -
> -	return 0;
> +	return drm_mode_config_helper_suspend(drm);
>  }
> 
>  static int __maybe_unused hdlcd_pm_resume(struct device *dev)
>  {
>  	struct drm_device *drm = dev_get_drvdata(dev);
> -	struct hdlcd_drm_private *hdlcd = drm ? drm->dev_private : NULL;
> -
> -	if (!hdlcd)
> -		return 0;
> 
> -	drm_atomic_helper_resume(drm, hdlcd->state);
> -	drm_fbdev_cma_set_suspend_unlocked(hdlcd->fbdev, 0);
> -	drm_kms_helper_poll_enable(drm);
> -
> -	return 0;
> +	return drm_mode_config_helper_resume(drm);
>  }
> 
>  static SIMPLE_DEV_PM_OPS(hdlcd_pm_ops, hdlcd_pm_suspend, hdlcd_pm_resume);
> diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c
> b/drivers/gpu/drm/drm_fb_cma_helper.c index 186d00a..f604a84 100644
> --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> @@ -529,21 +529,3 @@ void drm_fbdev_cma_set_suspend(struct drm_fbdev_cma
> *fbdev_cma, bool state) drm_fb_helper_set_suspend(&fbdev_cma->fb_helper,
> state);
>  }
>  EXPORT_SYMBOL(drm_fbdev_cma_set_suspend);
> -
> -/**
> - * drm_fbdev_cma_set_suspend_unlocked - wrapper around
> - *                                      drm_fb_helper_set_suspend_unlocked
> - * @fbdev_cma: The drm_fbdev_cma struct, may be NULL
> - * @state: desired state, zero to resume, non-zero to suspend
> - *
> - * Calls drm_fb_helper_set_suspend, which is a wrapper around
> - * fb_set_suspend implemented by fbdev core.
> - */
> -void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma *fbdev_cma,
> -					bool state)
> -{
> -	if (fbdev_cma)
> -		drm_fb_helper_set_suspend_unlocked(&fbdev_cma->fb_helper,
> -						   state);
> -}
> -EXPORT_SYMBOL(drm_fbdev_cma_set_suspend_unlocked);
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> b/drivers/gpu/drm/rcar-du/rcar_du_drv.c index 02aee6c..288220f 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> @@ -357,32 +357,15 @@ static void rcar_du_lastclose(struct drm_device *dev)
>  static int rcar_du_pm_suspend(struct device *dev)
>  {
>  	struct rcar_du_device *rcdu = dev_get_drvdata(dev);
> -	struct drm_atomic_state *state;
> 
> -	drm_kms_helper_poll_disable(rcdu->ddev);
> -	drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, true);
> -
> -	state = drm_atomic_helper_suspend(rcdu->ddev);
> -	if (IS_ERR(state)) {
> -		drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
> -		drm_kms_helper_poll_enable(rcdu->ddev);
> -		return PTR_ERR(state);
> -	}
> -
> -	rcdu->suspend_state = state;

If you further remove the suspend_state field from the rcar_du_device 
structure, you'll get my

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> -
> -	return 0;
> +	return drm_mode_config_helper_suspend(rcdu->ddev);
>  }
> 
>  static int rcar_du_pm_resume(struct device *dev)
>  {
>  	struct rcar_du_device *rcdu = dev_get_drvdata(dev);
> 
> -	drm_atomic_helper_resume(rcdu->ddev, rcdu->suspend_state);
> -	drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
> -	drm_kms_helper_poll_enable(rcdu->ddev);
> -
> -	return 0;
> +	return drm_mode_config_helper_resume(rcdu->ddev);
>  }
>  #endif
> 
> diff --git a/include/drm/drm_fb_cma_helper.h
> b/include/drm/drm_fb_cma_helper.h index d532f88a..15c4569 100644
> --- a/include/drm/drm_fb_cma_helper.h
> +++ b/include/drm/drm_fb_cma_helper.h
> @@ -33,8 +33,6 @@ struct drm_fbdev_cma *drm_fbdev_cma_init(struct drm_device
> *dev, void drm_fbdev_cma_restore_mode(struct drm_fbdev_cma *fbdev_cma);
> void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma *fbdev_cma); void
> drm_fbdev_cma_set_suspend(struct drm_fbdev_cma *fbdev_cma, bool state);
> -void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma *fbdev_cma,
> -					bool state);
> 
>  struct drm_gem_cma_object *drm_fb_cma_get_gem_obj(struct drm_framebuffer
> *fb, unsigned int plane);

-- 
Regards,

Laurent Pinchart



