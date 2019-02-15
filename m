Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062F9C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4954222BE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388100AbfBOSII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:08:08 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:45857 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387991AbfBOSIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:08:07 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id BA73A8036E;
        Fri, 15 Feb 2019 19:08:00 +0100 (CET)
Date:   Fri, 15 Feb 2019 19:07:59 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        devicetree@vger.kernel.org, tomi.valkeinen@ti.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 4/4] drm/panel: Add OSD101T2587-53TS driver
Message-ID: <20190215180759.GA26944@ravnborg.org>
References: <20190215140315.18046-1-peter.ujfalusi@ti.com>
 <20190215140315.18046-5-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215140315.18046-5-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=sozttTNsAAAA:8 a=e5mUnYsNAAAA:8
        a=WBYF2_TpmoQI-sFB3eIA:9 a=CjuIK1q_8ugA:10 a=aeg5Gbbo78KNqacMgKqU:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter.

Good with more panel drivers.
Some comments in the following, please do not blindly follow them but
check that this is OK.

	Sam

On Fri, Feb 15, 2019 at 04:03:15PM +0200, Peter Ujfalusi via dri-devel wrote:
> The panel is similar to OSD101T2045-53TS (which is handled by panel-simple)
> with one big difference: osd101t2587-53ts needs MIPI_DSI_TURN_ON_PERIPHERAL
> message to be sent from the host to be operational and thus can not be
> handled by panel-simple.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> +++ b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
> @@ -0,0 +1,284 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com
> + *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/drmP.h>
Please do not use drmP.h in new drivers - we try to get rid of this file.

> +#include <drm/drm_crtc.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_panel.h>
> +
> +#include <video/mipi_display.h>
> +
> +struct osd101t2587_panel {
> +	struct drm_panel base;
> +	struct mipi_dsi_device *dsi;
> +
> +	struct backlight_device *backlight;
> +	struct regulator *supply;
> +
> +	bool prepared;
> +	bool enabled;
> +
> +	ktime_t earliest_wake;
earliest_wake is not used, and can be deleted.

> +
> +	const struct drm_display_mode *default_mode;
> +	const struct drm_display_mode *mode;
Assigned but never used. Drop the assignment and the variable?

> +};
> +
> +static inline struct osd101t2587_panel *to_osd101t2587_panel(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct osd101t2587_panel, base);
> +}
> +
> +static int osd101t2587_panel_disable(struct drm_panel *panel)
> +{
> +	struct osd101t2587_panel *osd101t2587 = to_osd101t2587_panel(panel);
> +	int ret;
> +
> +	if (!osd101t2587->enabled)
> +		return 0;
> +
> +	if (osd101t2587->backlight) {
> +		osd101t2587->backlight->props.power = FB_BLANK_POWERDOWN;
> +		osd101t2587->backlight->props.state |= BL_CORE_FBBLANK;
> +		backlight_update_status(osd101t2587->backlight);
> +	}
backlight_disable(osd101t2587->backlight);


> +
> +	ret = mipi_dsi_shutdown_peripheral(osd101t2587->dsi);
> +
> +	osd101t2587->enabled = false;
> +
> +	return ret;
> +}
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
> +
> +	return ret;
> +}
> +
> +static int osd101t2587_panel_enable(struct drm_panel *panel)
> +{
> +	struct osd101t2587_panel *osd101t2587 = to_osd101t2587_panel(panel);
> +	int ret;
> +
> +	if (osd101t2587->enabled)
> +		return 0;
> +
> +	ret = mipi_dsi_turn_on_peripheral(osd101t2587->dsi);
> +	if (ret)
> +		return ret;
> +
> +	if (osd101t2587->backlight) {
> +		osd101t2587->backlight->props.power = FB_BLANK_UNBLANK;
> +		osd101t2587->backlight->props.state &= ~BL_CORE_FBBLANK;
> +		backlight_update_status(osd101t2587->backlight);
> +	}
backlight_enable(osd101t2587->backlight);
can be used here.

> +
> +	osd101t2587->enabled = true;
> +
> +	return ret;
> +}
> +
> +static const struct drm_display_mode default_mode_osd101t2587 = {
> +	.clock = 164400,
> +	.hdisplay = 1920,
> +	.hsync_start = 1920 + 152,
> +	.hsync_end = 1920 + 152 + 52,
> +	.htotal = 1920 + 152 + 52 + 20,
> +	.vdisplay = 1200,
> +	.vsync_start = 1200 + 24,
> +	.vsync_end = 1200 + 24 + 6,
> +	.vtotal = 1200 + 24 + 6 + 48,
> +	.vrefresh = 60,
> +	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> +};
> +
> +static int osd101t2587_panel_get_modes(struct drm_panel *panel)
> +{
> +	struct osd101t2587_panel *osd101t2587 = to_osd101t2587_panel(panel);
> +	struct drm_display_mode *mode;
> +
> +	mode = drm_mode_duplicate(panel->drm, osd101t2587->default_mode);
> +	if (!mode) {
> +		dev_err(panel->drm->dev, "failed to add mode %ux%ux@%u\n",
> +			osd101t2587->default_mode->hdisplay,
> +			osd101t2587->default_mode->vdisplay,
> +			osd101t2587->default_mode->vrefresh);
> +		return -ENOMEM;
> +	}
> +
> +	drm_mode_set_name(mode);
> +
> +	drm_mode_probed_add(panel->connector, mode);
> +
> +	panel->connector->display_info.width_mm = 217;
> +	panel->connector->display_info.height_mm = 136;
> +
> +	return 1;
> +}
> +
> +static const struct drm_panel_funcs osd101t2587_panel_funcs = {
> +	.disable = osd101t2587_panel_disable,
> +	.unprepare = osd101t2587_panel_unprepare,
> +	.prepare = osd101t2587_panel_prepare,
> +	.enable = osd101t2587_panel_enable,
> +	.get_modes = osd101t2587_panel_get_modes,
> +};
> +
> +static const struct of_device_id osd101t2587_of_match[] = {
> +	{
> +		.compatible = "osd,osd101t2587-53ts",
> +		.data = &default_mode_osd101t2587,
> +	}, { }
Move { } to a separate line and use { /* sentinel */ } to make it look like other drivers.
 

> +};
> +MODULE_DEVICE_TABLE(of, osd101t2587_of_match);
> +
> +static int osd101t2587_panel_add(struct osd101t2587_panel *osd101t2587)
> +{
> +	struct device *dev = &osd101t2587->dsi->dev;
> +	struct device_node *np;
> +	int ret;
> +
> +	osd101t2587->mode = osd101t2587->default_mode;
> +
> +	osd101t2587->supply = devm_regulator_get(dev, "power");
> +	if (IS_ERR(osd101t2587->supply))
> +		return PTR_ERR(osd101t2587->supply);
> +
> +	np = of_parse_phandle(dev->of_node, "backlight", 0);
> +	if (np) {
> +		osd101t2587->backlight = of_find_backlight_by_node(np);
> +		of_node_put(np);
> +
> +		if (!osd101t2587->backlight)
> +			return -EPROBE_DEFER;
> +	}
Use devm_of_find_backlight() - this results in simpler code.

> +
> +	drm_panel_init(&osd101t2587->base);
> +	osd101t2587->base.funcs = &osd101t2587_panel_funcs;
> +	osd101t2587->base.dev = &osd101t2587->dsi->dev;
> +
> +	ret = drm_panel_add(&osd101t2587->base);
> +	if (ret < 0)
> +		goto put_backlight;
> +
> +	return 0;
> +
> +put_backlight:
> +	if (osd101t2587->backlight)
> +		put_device(&osd101t2587->backlight->dev);
When using devm_of_find_backlight() this is not needed.

> +
> +	return ret;
> +}
> +
> +static void osd101t2587_panel_del(struct osd101t2587_panel *osd101t2587)
> +{
> +	if (osd101t2587->base.dev)
> +		drm_panel_remove(&osd101t2587->base);
> +
> +	if (osd101t2587->backlight)
> +		put_device(&osd101t2587->backlight->dev);
When you use devm_of_find_backlight() then this is done for you, so the above can be deleted.

> +}
> +
> +static int osd101t2587_panel_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct osd101t2587_panel *osd101t2587;
> +	const struct of_device_id *id;
> +	int ret;
> +
> +	id = of_match_node(osd101t2587_of_match, dsi->dev.of_node);
> +	if (!id)
> +		return -ENODEV;
> +
> +	dsi->lanes = 4;
> +	dsi->format = MIPI_DSI_FMT_RGB888;
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
> +			  MIPI_DSI_MODE_VIDEO_BURST |
> +			  MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> +			  MIPI_DSI_MODE_EOT_PACKET;
> +
> +	osd101t2587 = devm_kzalloc(&dsi->dev, sizeof(*osd101t2587), GFP_KERNEL);
> +	if (!osd101t2587)
> +		return -ENOMEM;
> +
> +	mipi_dsi_set_drvdata(dsi, osd101t2587);
> +
> +	osd101t2587->dsi = dsi;
> +	osd101t2587->default_mode = id->data;
> +
> +	ret = osd101t2587_panel_add(osd101t2587);
> +	if (ret < 0)
> +		return ret;
> +
> +	return mipi_dsi_attach(dsi);
> +}
> +
> +static int osd101t2587_panel_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct osd101t2587_panel *osd101t2587 = mipi_dsi_get_drvdata(dsi);
> +	int ret;
> +
> +	ret = osd101t2587_panel_disable(&osd101t2587->base);
> +	if (ret < 0)
> +		dev_err(&dsi->dev, "failed to disable panel: %d\n", ret);
> +
To trun off power supply call osd101t2587_panel_unprepare() here?

> +	ret = mipi_dsi_detach(dsi);
> +	if (ret < 0)
> +		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
> +
> +	osd101t2587_panel_del(osd101t2587);
Replace this with
	drm_panel_remove(osd101t2587->base);
This should be fine and no need to disable backlight, this is done in osd101t2587_panel_disable()

> +
> +	return 0;
> +}
> +
> +static void osd101t2587_panel_shutdown(struct mipi_dsi_device *dsi)
> +{
> +	struct osd101t2587_panel *osd101t2587 = mipi_dsi_get_drvdata(dsi);
> +
Maybe call osd101t2587_panel_unprepare() here to turn off power supply?

> +	osd101t2587_panel_disable(&osd101t2587->base);
> +}
> +
> +static struct mipi_dsi_driver osd101t2587_panel_driver = {
> +	.driver = {
> +		.name = "panel-osd-osd101t2587-53ts",
> +		.of_match_table = osd101t2587_of_match,
> +	},
> +	.probe = osd101t2587_panel_probe,
> +	.remove = osd101t2587_panel_remove,
> +	.shutdown = osd101t2587_panel_shutdown,
> +};
> +module_mipi_dsi_driver(osd101t2587_panel_driver);
> +
> +MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
> +MODULE_DESCRIPTION("OSD101T2587-53TS DSI panel");
> +MODULE_LICENSE("GPL v2");
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
