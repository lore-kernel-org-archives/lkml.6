Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82063C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DC2205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hXXjqv6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DC2205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeJQAgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:36:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40727 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeJQAgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:36:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id r1-v6so22020721edd.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 09:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ote3CaEJ6LuHeJUB867rC781HriwO22stBLo0Z09DMw=;
        b=hXXjqv6/a7V0h0dCr3ksmMm9b7d4aIyDcdFkMlaOc3aP9MEO5giy5f0OcsqQDiMVc6
         YCPeMgjcfL3M2dczHrfxRDkNv/oQv48HL8xdiqYnrq5gxMfIiGYIUmqzK5ASrXqwm+Cj
         5yRN8KHFY6MkOITojOwgnrbP5e/GeRZ3T5Jiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ote3CaEJ6LuHeJUB867rC781HriwO22stBLo0Z09DMw=;
        b=ZR5AiTLYsp0WN8usCHuyoCVwCPif9w+b6T6TU7T9m11TmL9muB1knJP6tG0TTGYL9n
         juGd3qbt6aleq0xZS6s5qTiBNPXA/9Y1dW+iV4JSH0J+g8o6Xe6x0kF1pPMTMUGyKCXB
         FP39/SJ7MlEeoUX6jqC5qc0e6W2nFbeh8BuShgMoOEohBxiccKc3MlKR6K8QneLHvINs
         ppkq9RwZ+xlGMssMM7zWwmDazDc1KLxPD8Q6zMwnbRSygt9gBHOYY7nC0j3oWkKqwIOb
         9B7xSuc8xywyNhQ7pW2WT3FlK/1Yu5eQ1N7jVQw31OqJPKnMNmTFaadcFwuadlh1nC2T
         5xQw==
X-Gm-Message-State: ABuFfohFqpNLvQ0Wg+gCeNhSWcmIz94t34nFDsdBSxfxP/tOgdxCEa0F
        UP/NQFBONQzNFjSXsROEPJbDB76NSlw=
X-Google-Smtp-Source: ACcGV600oqeqO95hpIjdffHpBR3umTlVZemz62gQXetA4a0O8iSYbaitGVMI1B31gP+9gjMLHghtgg==
X-Received: by 2002:a17:906:6983:: with SMTP id i3-v6mr24962078ejr.141.1539708331556;
        Tue, 16 Oct 2018 09:45:31 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b26-v6sm4799761edw.0.2018.10.16.09.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 09:45:30 -0700 (PDT)
Date:   Tue, 16 Oct 2018 18:45:28 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Stefan Agner <stefan@agner.ch>
Cc:     p.zabel@pengutronix.de, airlied@linux.ie,
        linux-kernel@vger.kernel.org, rmk+kernel@armlinux.org.uk,
        dri-devel@lists.freedesktop.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH] Revert "drm/imx: don't destroy mode objects manually on
 driver unbind"
Message-ID: <20181016164528.GD31561@phenom.ffwll.local>
Mail-Followup-To: Stefan Agner <stefan@agner.ch>, p.zabel@pengutronix.de,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        rmk+kernel@armlinux.org.uk, dri-devel@lists.freedesktop.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
References: <20181016160923.2042-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016160923.2042-1-stefan@agner.ch>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 06:09:23PM +0200, Stefan Agner wrote:
> This reverts commit 8e3b16e2117409625b89807de3912ff773aea354.
> 
> Using the component framework requires all components to undo in
> ->unbind what ->bind does. Unfortunately that particular commit
> broke this rule. In particular, this is an issue if a single
> component during probe fails. In that case, component_bind_all()
> calls unbind on already succussfully bound components, and then
> frees memory allocated using devm. If one of those components
> registered e.g. an encoder with the framework then this leads to
> use after free situations.
> 
> Revert the commit to ensure that all components properly undo
> what ->bind does.
> 
> Link: https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg233327.html
> Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Adding Benjamin, who just made the same mistake I think (and I reviewed it
... oh well).
-Daniel

> ---
>  drivers/gpu/drm/imx/imx-drm-core.c     | 4 ++--
>  drivers/gpu/drm/imx/imx-ldb.c          | 6 ++++++
>  drivers/gpu/drm/imx/imx-tve.c          | 3 +++
>  drivers/gpu/drm/imx/parallel-display.c | 3 +++
>  4 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
> index 5ea0c82f9957..caa6061a98ba 100644
> --- a/drivers/gpu/drm/imx/imx-drm-core.c
> +++ b/drivers/gpu/drm/imx/imx-drm-core.c
> @@ -305,11 +305,11 @@ static void imx_drm_unbind(struct device *dev)
>  
>  	drm_fb_cma_fbdev_fini(drm);
>  
> -	drm_mode_config_cleanup(drm);
> -
>  	component_unbind_all(drm->dev, drm);
>  	dev_set_drvdata(dev, NULL);
>  
> +	drm_mode_config_cleanup(drm);
> +
>  	drm_dev_put(drm);
>  }
>  
> diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
> index 3bd0f8a18e74..592aabc4a262 100644
> --- a/drivers/gpu/drm/imx/imx-ldb.c
> +++ b/drivers/gpu/drm/imx/imx-ldb.c
> @@ -723,6 +723,12 @@ static void imx_ldb_unbind(struct device *dev, struct device *master,
>  		if (channel->panel)
>  			drm_panel_detach(channel->panel);
>  
> +		if (!channel->connector.funcs)
> +			continue;
> +
> +		channel->connector.funcs->destroy(&channel->connector);
> +		channel->encoder.funcs->destroy(&channel->encoder);
> +
>  		kfree(channel->edid);
>  		i2c_put_adapter(channel->ddc);
>  	}
> diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tve.c
> index cffd3310240e..8d6e89ce1edb 100644
> --- a/drivers/gpu/drm/imx/imx-tve.c
> +++ b/drivers/gpu/drm/imx/imx-tve.c
> @@ -673,6 +673,9 @@ static void imx_tve_unbind(struct device *dev, struct device *master,
>  {
>  	struct imx_tve *tve = dev_get_drvdata(dev);
>  
> +	tve->connector.funcs->destroy(&tve->connector);
> +	tve->encoder.funcs->destroy(&tve->encoder);
> +
>  	if (!IS_ERR(tve->dac_reg))
>  		regulator_disable(tve->dac_reg);
>  }
> diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
> index aefd04e18f93..6f11bffcde37 100644
> --- a/drivers/gpu/drm/imx/parallel-display.c
> +++ b/drivers/gpu/drm/imx/parallel-display.c
> @@ -258,6 +258,9 @@ static void imx_pd_unbind(struct device *dev, struct device *master,
>  	if (imxpd->panel)
>  		drm_panel_detach(imxpd->panel);
>  
> +	imxpd->encoder.funcs->destroy(&imxpd->encoder);
> +	imxpd->connector.funcs->destroy(&imxpd->connector);
> +
>  	kfree(imxpd->edid);
>  }
>  
> -- 
> 2.19.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
