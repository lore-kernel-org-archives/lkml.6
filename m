Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9F3C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 20:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB29A2082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 20:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB29A2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbeKEGAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 01:00:25 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:33198 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbeKEGAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 01:00:25 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 7BF1B8044E;
        Sun,  4 Nov 2018 21:43:55 +0100 (CET)
Date:   Sun, 4 Nov 2018 21:43:54 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 09/10] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI
 LCD panel
Message-ID: <20181104204354.GA12651@ravnborg.org>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
 <20181103100900.30313-10-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181103100900.30313-10-jagan@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=iP-xVBlJAAAA:8 a=NEAV23lmAAAA:8
        a=BM_GTZ77mMiBW7iypcsA:9 a=CjuIK1q_8ugA:10 a=lHLH-nfn2y1bM_0xSXwp:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan.

Reading through the driver triggered a few comments.
Read and decide what is usefull.

	Sam

> Add panel driver for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Note: init sequence is referenced from 
> https://github.com/longsleep/linux-pine64/blob/pine64-hacks-1.2/drivers/video/sunxi/disp2/disp/lcd/mb709_mipi.c

This note should perferably be part of the commit message or maybe included
in the code so it is easie to track back.


> +++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> +/*
> + * Copyright (C) 2018 Amarula Solutions
> + * Author: Jagan Teki <jagan@amarulasolutions.com>
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/fb.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +



> +#include <video/mipi_display.h>

I cannot see this include is used anywhere in this .c file.
The few MIPI_ constants originates from <drm/drm_mipi_dsi.h>
and I think the include can be dropped.

> +struct fy07024di26a30d {
> +	struct drm_panel	panel;
> +	struct mipi_dsi_device	*dsi;
> +
> +	struct backlight_device	*backlight;
> +	struct regulator	*dvdd;
> +	struct regulator	*avdd;
> +	struct gpio_desc	*reset;
> +
> +	bool			is_enabled;
> +	bool			is_prepared;
> +};
Maybe bikeshedding a little here.
But the use of names like fy07024di26a30d does not help readability.
Just name it feiyang like for example we see in panel-innolux-p079zca.c
where this drives is somehow inspired from. (Here the name is innolux).



> +
> +static inline struct fy07024di26a30d *panel_to_fy07024di26a30d(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct fy07024di26a30d, panel);
> +}
> +
> +struct fy07024di26a30d_init_cmd {
> +	size_t len;
> +	const char *data;
> +};
> +
> +#define FY07024DI26A30D(...) { \
> +	.len = sizeof((char[]){__VA_ARGS__}), \
> +	.data = (char[]){__VA_ARGS__} }
> +
> +static const struct fy07024di26a30d_init_cmd fy07024di26a30d_init_cmds[] = {
> +	FY07024DI26A30D(0x80, 0x58),
> +	FY07024DI26A30D(0x81, 0x47),
> +	FY07024DI26A30D(0x82, 0xD4),
> +	FY07024DI26A30D(0x83, 0x88),
> +	FY07024DI26A30D(0x84, 0xA9),
> +	FY07024DI26A30D(0x85, 0xC3),
> +	FY07024DI26A30D(0x86, 0x82),
> +};
> +
> +static int fy07024di26a30d_prepare(struct drm_panel *panel)
> +{
> +	struct fy07024di26a30d *ctx = panel_to_fy07024di26a30d(panel);
> +	struct mipi_dsi_device *dsi = ctx->dsi;
> +	unsigned int i;
> +	int ret;
> +
> +	if (ctx->is_prepared)
> +		return 0;
> +
> +	gpiod_set_value(ctx->reset, 1);
> +	msleep(50);
> +
> +	gpiod_set_value(ctx->reset, 0);
> +	msleep(20);
> +
> +	gpiod_set_value(ctx->reset, 1);
> +	msleep(200);
> +
> +	for (i = 0; i < ARRAY_SIZE(fy07024di26a30d_init_cmds); i++) {
> +		const struct fy07024di26a30d_init_cmd *cmd =
> +						&fy07024di26a30d_init_cmds[i];
> +
> +		ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data, cmd->len);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = mipi_dsi_dcs_set_display_on(dsi);
> +	if (ret < 0) {
> +		dev_err(panel->dev, "failed to set display on: %d\n", ret);
> +		return ret;
> +	}
General comment.
Consider using DRM_DEV_ERROR(...) to be consistent with
what is used in many other drm drivers.


> +static int fy07024di26a30d_enable(struct drm_panel *panel)
> +{
> +	struct fy07024di26a30d *ctx = panel_to_fy07024di26a30d(panel);
> +
> +	if (ctx->is_enabled)
> +		return 0;
> +
> +	msleep(120);
This msleep() looks unjustified, as no other statement preceed it.
If prepare() requires a delay then maybe the delay should be there?

> +
> +static int fy07024di26a30d_unprepare(struct drm_panel *panel)
> +{
> +	struct fy07024di26a30d *ctx = panel_to_fy07024di26a30d(panel);
> +	int ret;
> +
> +	if (!ctx->is_prepared)
> +		return 0;
> +
> +	ret = mipi_dsi_dcs_set_display_off(ctx->dsi);
> +	if (ret < 0)
> +		dev_err(panel->dev, "failed to set display off: %d\n", ret);
> +
> +	ret = mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
> +	if (ret < 0)
> +		dev_err(panel->dev, "failed to enter sleep mode: %d\n", ret);
> +
> +	msleep(100);
> +
> +	regulator_disable(ctx->avdd);
> +
> +	regulator_disable(ctx->dvdd);
> +
> +	gpiod_set_value(ctx->reset, 0);
> +
> +	gpiod_set_value(ctx->reset, 1);
> +
> +	gpiod_set_value(ctx->reset, 0);

In prepare() there are dealys around asserting reset and releasing again.
Consider using a small helper function and be consistent with the
delays.

> +
> +	ctx->is_prepared = false;
> +
> +	return 0;
> +}
> +
> +static const struct drm_display_mode fy07024di26a30d_default_mode = {
> +	.clock = 55000,
> +	.vrefresh = 60,
> +
> +	.hdisplay = 1024,
> +	.hsync_start = 1024 + 396,
> +	.hsync_end = 1024 + 396 + 20,
> +	.htotal = 1024 + 396 + 20 + 100,
> +
> +	.vdisplay = 600,
> +	.vsync_start = 600 + 12,
> +	.vsync_end = 600 + 12 + 2,
> +	.vtotal = 600 + 12 + 2 + 21,
> +};
Consider to assign .flags - if for nothign else then to document
the default values.
Many panels have started to do so in panel-simple.c for instance.

This is also a proper place to specify the width_mm and height_mm,
so the physical size is available.
Assuming this is known.

> +
> +static int fy07024di26a30d_get_modes(struct drm_panel *panel)
> +{
> +	struct drm_connector *connector = panel->connector;
> +	struct fy07024di26a30d *ctx = panel_to_fy07024di26a30d(panel);
> +	struct drm_display_mode *mode;
> +
> +	mode = drm_mode_duplicate(panel->drm, &fy07024di26a30d_default_mode);
> +	if (!mode) {
> +		dev_err(&ctx->dsi->dev, "failed to add mode %ux%ux@%u\n",
> +			fy07024di26a30d_default_mode.hdisplay,
> +			fy07024di26a30d_default_mode.vdisplay,
> +			fy07024di26a30d_default_mode.vrefresh);
> +		return -ENOMEM;
> +	}
> +
> +	drm_mode_set_name(mode);
> +
> +	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +	drm_mode_probed_add(connector, mode);
> +
> +	return 1;
> +}
> +
> +static const struct drm_panel_funcs fy07024di26a30d_funcs = {
> +	.disable = fy07024di26a30d_disable,
> +	.unprepare = fy07024di26a30d_unprepare,
> +	.prepare = fy07024di26a30d_prepare,
> +	.enable = fy07024di26a30d_enable,
> +	.get_modes = fy07024di26a30d_get_modes,
> +};
> +
> +static int fy07024di26a30d_dsi_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device_node *np;
> +	struct fy07024di26a30d *ctx;
> +	int ret;
> +
> +	ctx = devm_kzalloc(&dsi->dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +	mipi_dsi_set_drvdata(dsi, ctx);
> +	ctx->dsi = dsi;
> +
> +	drm_panel_init(&ctx->panel);
> +	ctx->panel.dev = &dsi->dev;
> +	ctx->panel.funcs = &fy07024di26a30d_funcs;
> +
> +	ctx->dvdd = devm_regulator_get(&dsi->dev, "dvdd");
> +	if (IS_ERR(ctx->dvdd)) {
> +		dev_err(&dsi->dev, "Couldn't get dvdd regulator\n");
> +		return PTR_ERR(ctx->dvdd);
> +	}
> +
> +	ctx->avdd = devm_regulator_get(&dsi->dev, "avdd");
> +	if (IS_ERR(ctx->avdd)) {
> +		dev_err(&dsi->dev, "Couldn't get avdd regulator\n");
> +		return PTR_ERR(ctx->avdd);
> +	}
> +
> +	ret = regulator_enable(ctx->dvdd);
> +	if (ret)
> +		return ret;
> +
> +	msleep(100);
> +
> +	ret = regulator_enable(ctx->avdd);
> +	if (ret)
> +		return ret;
> +
> +	msleep(5);
The regulators are only enabled in the probe function.
But disabled in the unprepare() function.

Looking at other drivers is seems that the common way is
to enable these in prepare() and disable these in unprepare().
Any particular reason the regulators are enabled in probe()?
Maybe something to do with backlight?
If so, then please put a comment.
Also consider if there is somethign missing, as the panel cannot
be used anymore after an unpreare()


> +
> +	ctx->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->reset)) {
> +		dev_err(&dsi->dev, "Couldn't get our reset GPIO\n");
> +		return PTR_ERR(ctx->reset);
> +	}
> +
> +	np = of_parse_phandle(dsi->dev.of_node, "backlight", 0);
> +	if (np) {
> +		ctx->backlight = of_find_backlight_by_node(np);
> +		of_node_put(np);
> +
> +		if (!ctx->backlight)
> +			return -EPROBE_DEFER;
> +	}
> +
> +	ret = drm_panel_add(&ctx->panel);
> +	if (ret < 0)
> +		return ret;
> +
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_BURST;
> +	dsi->format = MIPI_DSI_FMT_RGB888;
> +	dsi->lanes = 4;
> +
> +	return mipi_dsi_attach(dsi);
Several drivers undo the drm_panel_add() if mipi_dsi_attach() fails.
I dunno if this is correct and when it may fail.


> +MODULE_DESCRIPTION("Feiyang FY07024DI26A30-D MIPI-DSI LCD panel");

> +MODULE_LICENSE("GPL v2");
The SPDX tag mentioned MIT - so the above may not be correct.

