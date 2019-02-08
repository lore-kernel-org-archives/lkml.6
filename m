Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF70C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5752085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bY3XtSn4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBHBFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:05:47 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:59400 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfBHBFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 20:05:47 -0500
Received: from pendragon.ideasonboard.com (d51A4137F.access.telenet.be [81.164.19.127])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 22BC9F9;
        Fri,  8 Feb 2019 02:05:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1549587944;
        bh=5JLL1EQhCbhHySResQLZEpdIpvqN8rEEV8+UbUUTqto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bY3XtSn4nK6sI/qVzh42jLsquDB/27uZq9LIkhfxRPgcyKPXyBatZbymR/MUN+gAy
         4m3z8pAbngGco+NTb2IxnCDMzeYjx4GL4SEK6/uTmfiyDjhTmyPKd7xxnq85NRzef/
         0d9rGd6dlM1w/Ho8X3KfxIeB3XmrUCkbtonfYEN0=
Date:   Fri, 8 Feb 2019 03:05:42 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     tomi.valkeinen@ti.com, airlied@linux.ie, daniel@ffwll.ch,
        sre@kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH v2 1/2] drm/omap: panel-tpo-td028ttec1: add backlight
 support
Message-ID: <20190208010542.GI10386@pendragon.ideasonboard.com>
References: <20190205063813.14873-1-andreas@kemnade.info>
 <20190205063813.14873-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190205063813.14873-2-andreas@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

Thank you for the patch.

On Tue, Feb 05, 2019 at 07:38:12AM +0100, Andreas Kemnade wrote:
> This panel has a backlight, so fetch it from devicetree using the
> corresponding property as documented in panel-common.txt. It is
> implemented the same way as in panel-dpi.c
> This ensures the backlight is also disabled when the display is
> turned off like when doing xset dpms force off.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Changes in v2: 
>  - do not reorder initialisation
>  - fix commit message
> 
>  drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
> index 7ddc8c574a61..1db8740f3c21 100644
> --- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
> +++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
> @@ -35,6 +35,8 @@ struct panel_drv_data {
>  
>  	struct videomode vm;
>  
> +	struct backlight_device *backlight;
> +
>  	struct spi_device *spi_dev;
>  };
>  
> @@ -268,6 +270,8 @@ static int td028ttec1_panel_enable(struct omap_dss_device *dssdev)
>  
>  	r |= jbt_ret_write_0(ddata, JBT_REG_DISPLAY_ON);
>  
> +	backlight_enable(ddata->backlight);
> +
>  	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
>  
>  transfer_err:
> @@ -283,6 +287,8 @@ static void td028ttec1_panel_disable(struct omap_dss_device *dssdev)
>  	if (!omapdss_device_is_enabled(dssdev))
>  		return;
>  
> +	backlight_disable(ddata->backlight);
> +
>  	dev_dbg(dssdev->dev, "td028ttec1_panel_disable()\n");
>  
>  	jbt_ret_write_0(ddata, JBT_REG_DISPLAY_OFF);
> @@ -334,6 +340,10 @@ static int td028ttec1_panel_probe(struct spi_device *spi)
>  	if (ddata == NULL)
>  		return -ENOMEM;
>  
> +	ddata->backlight = devm_of_find_backlight(&spi->dev);
> +	if (IS_ERR(ddata->backlight))
> +		return PTR_ERR(ddata->backlight);
> +
>  	dev_set_drvdata(&spi->dev, ddata);
>  
>  	ddata->spi_dev = spi;

-- 
Regards,

Laurent Pinchart
