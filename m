Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C702C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FDE2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FDE2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeJQAm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:42:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46219 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbeJQAm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:42:56 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gCSZE-000706-0m; Tue, 16 Oct 2018 18:51:36 +0200
Message-ID: <1539708694.3688.16.camel@pengutronix.de>
Subject: Re: [PATCH] Revert "drm/imx: don't destroy mode objects manually on
 driver unbind"
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Stefan Agner <stefan@agner.ch>, p.zabel@pengutronix.de
Cc:     airlied@linux.ie, rmk+kernel@armlinux.org.uk,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Tue, 16 Oct 2018 18:51:34 +0200
In-Reply-To: <20181016160923.2042-1-stefan@agner.ch>
References: <20181016160923.2042-1-stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 16.10.2018, 18:09 +0200 schrieb Stefan Agner:
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

I agree with this patch in general, but I think I remember why I
changed this in the first place: dw_hdmi_imx_unbind does not destroy
the encoder that has been registered in dw_hdmi_imx_bind.

8e3b16e21174 was an (apparently wrong) attempt to fix such issues once
and for all. By reverting this commit we go back to leaking the HDMI
encoder, so I think this patch should include a fix to destroy the
encoder on unbind.

Regards,
Lucas

> Link: https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg233327.html
> > Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/gpu/drm/imx/imx-drm-core.c     | 4 ++--
>  drivers/gpu/drm/imx/imx-ldb.c          | 6 ++++++
>  drivers/gpu/drm/imx/imx-tve.c          | 3 +++
>  drivers/gpu/drm/imx/parallel-display.c | 3 +++
>  4 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
> index 5ea0c82f9957..caa6061a98ba 100644
> --- a/drivers/gpu/drm/imx/imx-drm-core.c
> +++ b/drivers/gpu/drm/imx/imx-drm-core.c
> @@ -305,11 +305,11 @@ static void imx_drm_unbind(struct device *dev)
>  
> >  	drm_fb_cma_fbdev_fini(drm);
>  
> > -	drm_mode_config_cleanup(drm);
> -
> >  	component_unbind_all(drm->dev, drm);
> >  	dev_set_drvdata(dev, NULL);
>  
> > +	drm_mode_config_cleanup(drm);
> +
> >  	drm_dev_put(drm);
>  }
>  
> diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
> index 3bd0f8a18e74..592aabc4a262 100644
> --- a/drivers/gpu/drm/imx/imx-ldb.c
> +++ b/drivers/gpu/drm/imx/imx-ldb.c
> @@ -723,6 +723,12 @@ static void imx_ldb_unbind(struct device *dev, struct device *master,
> >  		if (channel->panel)
> >  			drm_panel_detach(channel->panel);
>  
> > +		if (!channel->connector.funcs)
> > +			continue;
> +
> > +		channel->connector.funcs->destroy(&channel->connector);
> > +		channel->encoder.funcs->destroy(&channel->encoder);
> +
> >  		kfree(channel->edid);
> >  		i2c_put_adapter(channel->ddc);
> >  	}
> diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tve.c
> index cffd3310240e..8d6e89ce1edb 100644
> --- a/drivers/gpu/drm/imx/imx-tve.c
> +++ b/drivers/gpu/drm/imx/imx-tve.c
> @@ -673,6 +673,9 @@ static void imx_tve_unbind(struct device *dev, struct device *master,
>  {
> >  	struct imx_tve *tve = dev_get_drvdata(dev);
>  
> > +	tve->connector.funcs->destroy(&tve->connector);
> > +	tve->encoder.funcs->destroy(&tve->encoder);
> +
> >  	if (!IS_ERR(tve->dac_reg))
> >  		regulator_disable(tve->dac_reg);
>  }
> diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
> index aefd04e18f93..6f11bffcde37 100644
> --- a/drivers/gpu/drm/imx/parallel-display.c
> +++ b/drivers/gpu/drm/imx/parallel-display.c
> @@ -258,6 +258,9 @@ static void imx_pd_unbind(struct device *dev, struct device *master,
> >  	if (imxpd->panel)
> >  		drm_panel_detach(imxpd->panel);
>  
> > +	imxpd->encoder.funcs->destroy(&imxpd->encoder);
> > +	imxpd->connector.funcs->destroy(&imxpd->connector);
> +
> >  	kfree(imxpd->edid);
>  }
>  
