Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FA8C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBE5208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBE5208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbeGaKJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:09:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40717 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeGaKJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:09:01 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1fkQ2M-0003w6-RZ; Tue, 31 Jul 2018 10:29:46 +0200
Message-ID: <1533025785.3444.2.camel@pengutronix.de>
Subject: Re: [PATCH] drm/imx: Convert drm_atomic_helper_suspend/resume()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Souptick Joarder <jrdr.linux@gmail.com>, airlied@linux.ie,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ajitn.linux@gmail.com, daniel@ffwll.ch
Date:   Tue, 31 Jul 2018 10:29:45 +0200
In-Reply-To: <20180728130521.GA6336@jordon-HP-15-Notebook-PC>
References: <20180728130521.GA6336@jordon-HP-15-Notebook-PC>
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

Hi Souptick,

On Sat, 2018-07-28 at 18:35 +0530, Souptick Joarder wrote:
> convert drm_atomic_helper_suspend/resume() to use
> drm_mode_config_helper_suspend/resume().
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>

Leonard pointed out earlier [1] that this makes the struct
imx_drm_device superfluous, since imxdrm->state is the only remaining
field and here you are removing its use. Could you remove struct
imx_drm_device as well?

[1] https://patchwork.kernel.org/patch/10531473/

regards
Philipp

> ---
>  drivers/gpu/drm/imx/imx-drm-core.c | 26 ++------------------------
>  1 file changed, 2 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
> index 1d053bb..cdd83ea 100644
> --- a/drivers/gpu/drm/imx/imx-drm-core.c
> +++ b/drivers/gpu/drm/imx/imx-drm-core.c
> @@ -355,37 +355,15 @@ static int imx_drm_platform_remove(struct platform_device *pdev)
>  static int imx_drm_suspend(struct device *dev)
>  {
>  	struct drm_device *drm_dev = dev_get_drvdata(dev);
> -	struct imx_drm_device *imxdrm;
> -
> -	/* The drm_dev is NULL before .load hook is called */
> -	if (drm_dev == NULL)
> -		return 0;
> -
> -	drm_kms_helper_poll_disable(drm_dev);
> -
> -	imxdrm = drm_dev->dev_private;
> -	imxdrm->state = drm_atomic_helper_suspend(drm_dev);
> -	if (IS_ERR(imxdrm->state)) {
> -		drm_kms_helper_poll_enable(drm_dev);
> -		return PTR_ERR(imxdrm->state);
> -	}
>  
> -	return 0;
> +	return drm_mode_config_helper_suspend(drm_dev);
>  }
>  
>  static int imx_drm_resume(struct device *dev)
>  {
>  	struct drm_device *drm_dev = dev_get_drvdata(dev);
> -	struct imx_drm_device *imx_drm;
> -
> -	if (drm_dev == NULL)
> -		return 0;
>  
> -	imx_drm = drm_dev->dev_private;
> -	drm_atomic_helper_resume(drm_dev, imx_drm->state);
> -	drm_kms_helper_poll_enable(drm_dev);
> -
> -	return 0;
> +	return drm_mode_config_helper_resume(drm_dev);
>  }
>  #endif
>  
