Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9038DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4977D20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="BHYc5dXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4977D20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbeKSWDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:03:01 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:57164 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbeKSWDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:03:01 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 90B1E5C25E1;
        Mon, 19 Nov 2018 12:39:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1542627576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VWtmOpqxnuAWB7Wwid9QdGIgDWW8a+NHksUwyWNcAWQ=;
        b=BHYc5dXj0rr7ph3gLHoQjTkxNaXVOwh//n+nHuAERYS4ywhpr9VxenV+oqGVxrKqqJEs97
        AmhfeVhOnwcKBbuZQNxLdgCsmsSy1vmifTIqiS5jzXysPBfVovPBD6aol9Xq+HUCC0u3K3
        kZtTjmdrAtTfXm6v/9dTBKD+VETB8TU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 19 Nov 2018 12:39:36 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Fernando Ramos <greenfoo@gluegarage.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Jonathan Corbet <corbet@lwn.net>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        etnaviv@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: Re: [PATCH 3/9] drm: replace "drm_dev_unref" function with
 "drm_dev_put"
In-Reply-To: <20181115221634.22715-4-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <20181115221634.22715-4-greenfoo@gluegarage.com>
Message-ID: <767d6ca7f54331876cbbbe0cca4b14bd@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.11.2018 23:16, Fernando Ramos wrote:
> This patch unifies the naming of DRM functions for reference counting as
> requested on Documentation/gpu/todo.rst
> 
> Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>
> ---
>  drivers/gpu/drm/arc/arcpgu_drv.c             | 4 ++--
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 4 ++--
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c        | 4 ++--
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c            | 4 ++--

For mxsfb:

Acked-by: Stefan Agner <stefan@agner.ch>

--
Stefan

>  drivers/gpu/drm/rcar-du/rcar_du_drv.c        | 2 +-
>  drivers/gpu/drm/shmobile/shmob_drm_drv.c     | 4 ++--
>  drivers/gpu/drm/tve200/tve200_drv.c          | 4 ++--
>  drivers/gpu/drm/zte/zx_drm_drv.c             | 4 ++--
>  8 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arc/arcpgu_drv.c b/drivers/gpu/drm/arc/arcpgu_drv.c
> index f067de4e1e82..dcb06d4e9135 100644
> --- a/drivers/gpu/drm/arc/arcpgu_drv.c
> +++ b/drivers/gpu/drm/arc/arcpgu_drv.c
> @@ -216,7 +216,7 @@ static int arcpgu_probe(struct platform_device *pdev)
>  	arcpgu_unload(drm);
>  
>  err_unref:
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  
>  	return ret;
>  }
> @@ -227,7 +227,7 @@ static int arcpgu_remove(struct platform_device *pdev)
>  
>  	drm_dev_unregister(drm);
>  	arcpgu_unload(drm);
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> index 843cac222e60..f8da51a63e2f 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> @@ -775,7 +775,7 @@ static int atmel_hlcdc_dc_drm_probe(struct
> platform_device *pdev)
>  	atmel_hlcdc_dc_unload(ddev);
>  
>  err_unref:
> -	drm_dev_unref(ddev);
> +	drm_dev_put(ddev);
>  
>  	return ret;
>  }
> @@ -786,7 +786,7 @@ static int atmel_hlcdc_dc_drm_remove(struct
> platform_device *pdev)
>  
>  	drm_dev_unregister(ddev);
>  	atmel_hlcdc_dc_unload(ddev);
> -	drm_dev_unref(ddev);
> +	drm_dev_put(ddev);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 83c1f46670bf..52802e6049e0 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -550,7 +550,7 @@ static int etnaviv_bind(struct device *dev)
>  out_bind:
>  	kfree(priv);
>  out_unref:
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  
>  	return ret;
>  }
> @@ -567,7 +567,7 @@ static void etnaviv_unbind(struct device *dev)
>  	drm->dev_private = NULL;
>  	kfree(priv);
>  
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  }
>  
>  static const struct component_master_ops etnaviv_master_ops = {
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 2393e6d16ffd..88ba003979e6 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -417,7 +417,7 @@ static int mxsfb_probe(struct platform_device *pdev)
>  err_unload:
>  	mxsfb_unload(drm);
>  err_free:
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  
>  	return ret;
>  }
> @@ -428,7 +428,7 @@ static int mxsfb_remove(struct platform_device *pdev)
>  
>  	drm_dev_unregister(drm);
>  	mxsfb_unload(drm);
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> index 084f58df4a8c..c7fe2433ab9e 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> @@ -454,7 +454,7 @@ static int rcar_du_remove(struct platform_device *pdev)
>  	drm_kms_helper_poll_fini(ddev);
>  	drm_mode_config_cleanup(ddev);
>  
> -	drm_dev_unref(ddev);
> +	drm_dev_put(ddev);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> index 6ececad6f845..8554102a6ead 100644
> --- a/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> +++ b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> @@ -194,7 +194,7 @@ static int shmob_drm_remove(struct platform_device *pdev)
>  	drm_kms_helper_poll_fini(ddev);
>  	drm_mode_config_cleanup(ddev);
>  	drm_irq_uninstall(ddev);
> -	drm_dev_unref(ddev);
> +	drm_dev_put(ddev);
>  
>  	return 0;
>  }
> @@ -290,7 +290,7 @@ static int shmob_drm_probe(struct platform_device *pdev)
>  	drm_kms_helper_poll_fini(ddev);
>  	drm_mode_config_cleanup(ddev);
>  err_free_drm_dev:
> -	drm_dev_unref(ddev);
> +	drm_dev_put(ddev);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/tve200/tve200_drv.c
> b/drivers/gpu/drm/tve200/tve200_drv.c
> index 72efcecb44f7..28e2d03c0ccf 100644
> --- a/drivers/gpu/drm/tve200/tve200_drv.c
> +++ b/drivers/gpu/drm/tve200/tve200_drv.c
> @@ -249,7 +249,7 @@ static int tve200_probe(struct platform_device *pdev)
>  clk_disable:
>  	clk_disable_unprepare(priv->pclk);
>  dev_unref:
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  	return ret;
>  }
>  
> @@ -263,7 +263,7 @@ static int tve200_remove(struct platform_device *pdev)
>  		drm_panel_bridge_remove(priv->bridge);
>  	drm_mode_config_cleanup(drm);
>  	clk_disable_unprepare(priv->pclk);
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/zte/zx_drm_drv.c b/drivers/gpu/drm/zte/zx_drm_drv.c
> index 11ef17c2d1c1..5b6f1eda52e0 100644
> --- a/drivers/gpu/drm/zte/zx_drm_drv.c
> +++ b/drivers/gpu/drm/zte/zx_drm_drv.c
> @@ -114,7 +114,7 @@ static int zx_drm_bind(struct device *dev)
>  	component_unbind_all(dev, drm);
>  out_unregister:
>  	dev_set_drvdata(dev, NULL);
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  	return ret;
>  }
>  
> @@ -127,7 +127,7 @@ static void zx_drm_unbind(struct device *dev)
>  	drm_mode_config_cleanup(drm);
>  	component_unbind_all(dev, drm);
>  	dev_set_drvdata(dev, NULL);
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  }
>  
>  static const struct component_master_ops zx_drm_master_ops = {
