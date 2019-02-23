Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AC4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 19:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E15020675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 19:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfBWTiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 14:38:11 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:40371 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfBWTiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 14:38:11 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 3F11A8032A;
        Sat, 23 Feb 2019 20:38:07 +0100 (CET)
Date:   Sat, 23 Feb 2019 20:38:05 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        tomi.valkeinen@ti.com
Subject: Re: [PATCH v2 4/4] drm/panel: Add OSD101T2587-53TS driver
Message-ID: <20190223193805.GA21790@ravnborg.org>
References: <20190222131618.20520-1-peter.ujfalusi@ti.com>
 <20190222131618.20520-5-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222131618.20520-5-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=sozttTNsAAAA:8
        a=Wcm_UQoWY5c6ZXSZm6oA:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=aeg5Gbbo78KNqacMgKqU:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter.

Driver looks to be in good shape now.
With the few comments below addressed you can add my:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

	Sam

On Fri, Feb 22, 2019 at 03:16:18PM +0200, Peter Ujfalusi wrote:
> The panel is similar to OSD101T2045-53TS (which is handled by panel-simple)
> with one big difference: osd101t2587-53ts needs MIPI_DSI_TURN_ON_PERIPHERAL
> message to be sent from the host to be operational and thus can not be
> handled by panel-simple.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |   6 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../drm/panel/panel-osd-osd101t2587-53ts.c    | 254 ++++++++++++++++++
>  3 files changed, 261 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 3e070153ef21..351661920838 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -122,6 +122,12 @@ config DRM_PANEL_ORISETECH_OTM8009A
>  	  Say Y here if you want to enable support for Orise Technology
>  	  otm8009a 480x800 dsi 2dl panel.
>  
> +config DRM_PANEL_OSD_OSD101T2587_53TS
> +	tristate "OSD OSD101T2587-53TS DSI 1920x1200 video mode panel"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
Please add a help-text

> +
> +static int osd101t2587_panel_unprepare(struct drm_panel *panel)
> +{
> +	struct osd101t2587_panel *osd101t2587 = to_osd101t2587_panel(panel);
> +
> +	if (!osd101t2587->prepared)
> +		return 0;
> +
> +	regulator_disable(osd101t2587->supply);
> +	osd101t2587->prepared = false;
> +
> +	return 0;
> +}
> +
> +static int osd101t2587_panel_prepare(struct drm_panel *panel)
> +{
> +	struct osd101t2587_panel *osd101t2587 = to_osd101t2587_panel(panel);
> +	int ret;
> +
> +	if (osd101t2587->prepared)
> +		return 0;
> +
> +	ret = regulator_enable(osd101t2587->supply);
> +	if (!ret)
> +		osd101t2587->prepared = true;

Logic is wrong here. regulator_enable() will return a negative value on error
and 0 in the good case.
So osd101t2587->prepared is set to true only in the error case, not in the good case.


> +
> +	ret = mipi_dsi_attach(dsi);
> +	if (ret)
> +		drm_panel_remove(&osd101t2587->base);

I do not see panel-simple.c do a drm_panel_remove() if mipi_dsi_attach() fails.
Maybe the driver core will call remove() is probe fails?
Or maybe panel-simple() should call drm_panel_remove()

Keep the above as is - I just wanted to express that this looks different
from the panle-simple() driver.

> +static int osd101t2587_panel_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct osd101t2587_panel *osd101t2587 = mipi_dsi_get_drvdata(dsi);
> +	int ret;
> +
> +	ret = osd101t2587_panel_disable(&osd101t2587->base);
> +	if (ret < 0)
> +		dev_warn(&dsi->dev, "failed to disable panel\n");
This is already warned in lower layers and I think you could
drop the dev_warn().

> +
> +	osd101t2587_panel_unprepare(&osd101t2587->base);
> +
> +	drm_panel_remove(&osd101t2587->base);
> +
> +	ret = mipi_dsi_detach(dsi);
> +	if (ret < 0)
> +		dev_warn(&dsi->dev, "failed to detach from DSI host\n");
Add error code in logging.
