Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50205C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A81221783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbfAKVTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:19:40 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:52966 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfAKVTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:19:39 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 7AA4820020;
        Fri, 11 Jan 2019 22:19:33 +0100 (CET)
Date:   Fri, 11 Jan 2019 22:19:31 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH V7 2/2] drm/panel: Add Sitronix ST7701 panel driver
Message-ID: <20190111211931.GA29735@ravnborg.org>
References: <20190111124714.19566-1-jagan@amarulasolutions.com>
 <20190111124714.19566-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111124714.19566-2-jagan@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=k1dyMpTxz__Fw_ammmUA:9 a=J2CCd2KcDSp0Zr6i:21
        a=KSCQr6G_N1XjhTh8:21 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan.

Gave this another more detailed read - triggered some additional comments.
Depite the comments it looks good, and this is all more or
less cosmetic improvements.

	Sam

> +struct st7701_panel_desc {
> +	const struct drm_display_mode *mode;
> +	unsigned int lanes;
> +	unsigned long flags;
> +	enum mipi_dsi_pixel_format format;
> +	const char *const *supply_names;
> +	unsigned int num_supplies;
> +	unsigned int panel_sleep_delay;
> +};
> +
> +struct st7701 {
> +	struct drm_panel panel;
> +	struct mipi_dsi_device *dsi;
> +	const struct st7701_panel_desc *desc;
> +
> +	struct backlight_device *backlight;
> +	struct regulator_bulk_data *supplies;
> +	unsigned int num_supplies;
I cannot see that num_supplies in this struct are used?


> +	struct gpio_desc *reset;
> +	unsigned int sleep_delay;
> +};
> +
> +static inline struct st7701 *panel_to_st7701(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct st7701, panel);
> +}
> +
> +static inline int st7701_dsi_write(struct st7701 *st7701, const void *seq,
> +				   size_t len)
> +{
> +	return mipi_dsi_dcs_write_buffer(st7701->dsi, seq, len);
> +}
> +


> +static int st7701_prepare(struct drm_panel *panel)
> +{
> +	struct st7701 *st7701 = panel_to_st7701(panel);
> +	int ret;
> +
> +	gpiod_set_value(st7701->reset, 0);
> +	msleep(20);
> +
> +	ret = regulator_bulk_enable(st7701->desc->num_supplies,
> +				    st7701->supplies);
> +	if (ret < 0)
> +		return ret;
> +	msleep(20);
> +
> +	gpiod_set_value(st7701->reset, 1);
> +	msleep(20);
> +
> +	gpiod_set_value(st7701->reset, 0);
> +	msleep(30);
> +
> +	gpiod_set_value(st7701->reset, 1);
> +	msleep(150);
> +
> +	st7701_init_sequence(st7701);
> +
> +	return 0;
> +}
> +

> +static int st7701_unprepare(struct drm_panel *panel)
> +{
> +	struct st7701 *st7701 = panel_to_st7701(panel);
> +
> +	ST7701_DSI(st7701, MIPI_DCS_EXIT_SLEEP_MODE, 0x00);
> +
> +	msleep(st7701->sleep_delay);
> +
> +	gpiod_set_value(st7701->reset, 0);
> +
> +	gpiod_set_value(st7701->reset, 1);
> +
> +	gpiod_set_value(st7701->reset, 0);
No timing constrains here? In prepare there are sleeps intermixed.

> +
> +	regulator_bulk_disable(st7701->desc->num_supplies, st7701->supplies);
> +
> +	return 0;
> +}
> +
> +static int st7701_get_modes(struct drm_panel *panel)
> +{
> +	struct st7701 *st7701 = panel_to_st7701(panel);
> +	const struct drm_display_mode *desc_mode = st7701->desc->mode;
> +	struct drm_display_mode *mode;
> +
> +	mode = drm_mode_duplicate(panel->drm, desc_mode);
> +	if (!mode) {
> +		dev_err(&st7701->dsi->dev, "failed to add mode %ux%ux@%u\n",
> +			desc_mode->hdisplay, desc_mode->vdisplay,
> +			desc_mode->vrefresh);
Use something like:
		DRM_DEV_ERROR(st7701->dev, "failed to add mode" DRM_MODE_FMT ",
			      DRM_MODE_ARG(desc_mode));

> +		return -ENOMEM;
> +	}
> +
> +	drm_mode_set_name(mode);
> +	drm_mode_probed_add(panel->connector, mode);
> +
> +	panel->connector->display_info.width_mm = desc_mode->width_mm;
> +	panel->connector->display_info.height_mm = desc_mode->height_mm;
> +
> +	return 1;
> +}
> +

> +static const struct st7701_panel_desc ts8550b_desc = {
> +	.mode = &ts8550b_mode,
> +	.lanes = 2,
> +	.flags = MIPI_DSI_MODE_VIDEO,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.supply_names = ts8550b_supply_names,
> +	.num_supplies = ARRAY_SIZE(ts8550b_supply_names),
> +	.panel_sleep_delay = 80, /* panel need extra 80ms for sleep out cmd */
In the only place this is used there is added 120 ms too.
Looks inconsistent - do we have the same delay twice?


> +
> +static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
> +{
> +	const struct st7701_panel_desc *desc;
> +	struct device_node *np;
> +	struct st7701 *st7701;
> +	int ret, i;
> +
> +	st7701 = devm_kzalloc(&dsi->dev, sizeof(*st7701), GFP_KERNEL);
> +	if (!st7701)
> +		return -ENOMEM;
> +
> +	desc = of_device_get_match_data(&dsi->dev);
> +	dsi->mode_flags = desc->flags;
> +	dsi->format = desc->format;
> +	dsi->lanes = desc->lanes;
> +
> +	st7701->supplies = devm_kcalloc(&dsi->dev, desc->num_supplies,
> +					sizeof(*st7701->supplies),
> +					GFP_KERNEL);
> +	if (!st7701->supplies)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < desc->num_supplies; i++)
> +		st7701->supplies[i].supply = desc->supply_names[i];
> +
> +	ret = devm_regulator_bulk_get(&dsi->dev, desc->num_supplies,
> +				      st7701->supplies);
> +	if (ret < 0)
> +		return ret;
> +
> +	st7701->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(st7701->reset)) {
> +		dev_err(&dsi->dev, "Couldn't get our reset GPIO\n");
> +		return PTR_ERR(st7701->reset);
> +	}
> +
> +	np = of_parse_phandle(dsi->dev.of_node, "backlight", 0);
> +	if (np) {
> +		st7701->backlight = of_find_backlight_by_node(np);
> +		of_node_put(np);
> +
> +		if (!st7701->backlight)
> +			return -EPROBE_DEFER;
> +	}
This is a simpler variant of the above:
	st7701->backlight = devm_of_find_backlight(dsi->dev);
	if (IS_ERR(st7701->backlight))
		return PTR_ERR(st7701->backlight);

Suggested by Noralf in another thread for a similar driver.


> +
> +	drm_panel_init(&st7701->panel);
> +
> +	/* We need to wait 120ms after a sleep out command */
> +	st7701->sleep_delay = 120 + desc->panel_sleep_delay;
This is the other place where we add 120 to the previous 80 - in total 200 ms.

> +	st7701->panel.funcs = &st7701_funcs;
> +	st7701->panel.dev = &dsi->dev;
> +
> +	ret = drm_panel_add(&st7701->panel);
> +	if (ret < 0)
> +		return ret;
> +
> +	mipi_dsi_set_drvdata(dsi, st7701);
> +	st7701->dsi = dsi;

> +	st7701->desc = desc;
This assignment could come earlier, so we do not have it unassigned when calling
other functions. As it is now it works so you can safely ignore this comment.

> +
> +	return mipi_dsi_attach(dsi);
> +}
> +
> +static int st7701_dsi_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct st7701 *st7701 = mipi_dsi_get_drvdata(dsi);
> +
> +	mipi_dsi_detach(dsi);
> +	drm_panel_remove(&st7701->panel);
> +
> +	if (st7701->backlight)
> +		put_device(&st7701->backlight->dev);

Use:
	backlight_put(st7701->backlight);


