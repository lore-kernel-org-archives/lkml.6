Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4466C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8689C206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfBXNZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 08:25:57 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:55403 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbfBXNZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 08:25:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 64ADDFB03;
        Sun, 24 Feb 2019 14:25:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yJyajUATgFw1; Sun, 24 Feb 2019 14:25:49 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 9532F43558; Sun, 24 Feb 2019 14:25:48 +0100 (CET)
Date:   Sun, 24 Feb 2019 14:25:48 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/3] drm/panel: Add Rocktech jh057n00900 panel driver
Message-ID: <20190224132548.GA6007@bogon.m.sigxcpu.org>
References: <cover.1550943220.git.agx@sigxcpu.org>
 <79858664af8ee2f725e53d902ce46b447ac8fcfc.1550943220.git.agx@sigxcpu.org>
 <20190223220304.GA20290@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190223220304.GA20290@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,
On Sat, Feb 23, 2019 at 11:03:04PM +0100, Sam Ravnborg wrote:
> Hi Guido.
> 
> Thanks for this patch.
> See below for some review feedback.

Thanks for having look! This is what I've folded in for v2:

Changes from v1
* As per review comments from Sam Ravnborg
  * Make SPDX-License-Identifier match MODULE_LICENSE
  * Sort include files alphabetically
  * Drop drmP.h and use individual includes
  * Drop superfuous 'x' in mode printout on error path
  * Allpixelson_set: Add proper space around '*'
  * Drop superfluous put_device(&ctx->backlight->dev);
  * Add /* Sentinel */ in jh057n_of_match
  * Drop jh057n->enabled
  * Drop drm_display_info_set_bus_formats
* Kconfig: Depend on BACKLIGHT_CLASS_DEVICE which somehow got lost
* Move jh057n_enable close to jh057n_disable

I'll hold off a v2 in case there are further comments.

> The driver includes the "allpixelson_set" debugfs feature.
> Is this a debug leftover, or is there a real need for this?
> If this is a debug feature that is no logner needed then no
> need to add it to the mainline driver.

That debugfs entry is a life saver when staring at a blank screen and
trying to figure out what is broken. If a

   echo 1 > /sys/kernel/debug/jh057n00900/allpixelson

lights up the screen then DSI LP mode communication is working. One can
then focus on the video mode (pixel clock, polarity, ...). So if at all
possible I'd leave that in since it might help to diagnose problems not
only in the driver but in upper DSI layers (phy, dsi host).

Cheers,
 -- Guido

> 
> 	Sam
> 
> On Sat, Feb 23, 2019 at 06:39:44PM +0100, Guido Günther wrote:
> > Support Rocktech jh057n00900 5.5" 720x1440 TFT LCD panel. It is a MIPI
> > DSI video mode panel.
> > 
> > The panel seems to use a Sitronix ST7703 look alike (most of the
> > commands look similar to the ST7703's data sheet but use a different
> > number of parameters). The initial version of the DSI init sequence
> > (including sleeps) were provided by the vendor. Sleeps were reduced
> > considerably though to speed up initialization.
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > ---
> > +++ b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> > @@ -0,0 +1,414 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Rockteck jh057n00900 5.5" MIPI-DSI panel driver
> > + *
> > + * Copyright (C) Purism SPC 2019
> > + */
> > +#include <drm/drmP.h>
> > +#include <drm/drm_mipi_dsi.h>
> > +#include <drm/drm_panel.h>
> > +#include <linux/backlight.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <video/mipi_display.h>
> > +#include <video/display_timing.h>
> > +#include <linux/debugfs.h>
> 1) Drop use of drmP.h - it is dreprecated and shall not be used for new drivers
> 2) Group the include files, and within each group sort them alphabetically
> 
> > +
> > +#define DRV_NAME "jh057n00900"
> > +
> > +/* Manufacturer specific Commands send via DSI */
> > +#define ST7703_CMD_ALL_PIXEL_OFF 0x22
> > +#define ST7703_CMD_ALL_PIXEL_ON	 0x23
> > +#define ST7703_CMD_SETDISP	 0xB2
> > +#define ST7703_CMD_SETRGBIF	 0xB3
> > +#define ST7703_CMD_SETCYC	 0xB4
> > +#define ST7703_CMD_SETBGP	 0xB5
> > +#define ST7703_CMD_SETVCOM	 0xB6
> > +#define ST7703_CMD_SETOTP	 0xB7
> > +#define ST7703_CMD_SETPOWER_EXT	 0xB8
> > +#define ST7703_CMD_SETEXTC	 0xB9
> > +#define ST7703_CMD_SETMIPI	 0xBA
> > +#define ST7703_CMD_SETVDC	 0xBC
> > +#define ST7703_CMD_SETSCR	 0xC0
> > +#define ST7703_CMD_SETPOWER	 0xC1
> > +#define ST7703_CMD_SETPANEL	 0xCC
> > +#define ST7703_CMD_SETGAMMA	 0xE0
> > +#define ST7703_CMD_SETEQ	 0xE3
> > +#define ST7703_CMD_SETGIP1	 0xE9
> > +#define ST7703_CMD_SETGIP2	 0xEA
> > +
> > +struct jh057n {
> > +	struct device *dev;
> > +	struct drm_panel panel;
> > +	struct gpio_desc *reset_gpio;
> > +	struct backlight_device *backlight;
> > +	bool prepared;
> > +	bool enabled;
> enabled is used only to protect from calling backlight_disable()
> again. There is nothing (as far as I can see) that should make
> calling backlight_disbale() bad if already disabled.
> So consider if this can be dropped.
> 
> 
> > +
> > +	struct dentry *debugfs;
> > +};
> > +
> > +static inline struct jh057n *panel_to_jh057n(struct drm_panel *panel)
> > +{
> > +	return container_of(panel, struct jh057n, panel);
> > +}
> > +
> > +#define dsi_generic_write_seq(dsi, seq...) do {				\
> > +		static const u8 d[] = { seq };				\
> > +		int ret;						\
> > +		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));	\
> > +		if (ret < 0)						\
> > +			return ret;					\
> > +	} while (0)
> > +
> > +static int jh057n_init_sequence(struct jh057n *ctx)
> > +{
> > +	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> > +	struct device *dev = ctx->dev;
> > +	int ret;
> > +
> > +	/*
> > +	 * Init sequence was supplied by the panel vendor. Most of the commands
> > +	 * resemble the ST7703 but the number of parameters often don't match
> > +	 * so it's likely a clone.
> > +	 */
> > +	dsi_generic_write_seq(dsi, ST7703_CMD_SETEXTC,
> > +			      0xF1, 0x12, 0x83);
> > +	dsi_generic_write_seq(dsi, ST7703_CMD_SETRGBIF,
> > +			      0x10, 0x10, 0x05, 0x05, 0x03, 0xFF, 0x00, 0x00,
> > +			      0x00, 0x00);
> > +	dsi_generic_write_seq(dsi, ST7703_CMD_SETSCR,
> > +			      0x73, 0x73, 0x50, 0x50, 0x00, 0x00, 0x08, 0x70,
> > +			      0x00);
> > +	dsi_generic_write_seq(dsi, ST7703_CMD_SETVDC, 0x4E);
> > +	dsi_generic_write_seq(dsi, ST7703_CMD_SETPANEL, 0x0B);
> > +	dsi_generic_write_seq(dsi, ST7703_CMD_SETCYC, 0x80);
> > +	dsi_generic_write_seq(dsi, ST7703_CMD_SETDISP, 0xF0, 0x12, 0x30);
> > +	dsi_generic_write_seq(dsi, ST7703_CMD_SETEQ,
> > +			      0x07, 0x07, 0x0B, 0x0B, 0x03, 0x0B, 0x00, 0x00,
> > +			      0x00, 0x00, 0xFF, 0x00, 0xC0, 0x10);
> > +	dsi_generic_write_seq(dsi, ST7703_CMD_SETBGP, 0x08, 0x08);
> > +	msleep(20);
> > +
> > +	dsi_generic_write_seq(dsi, ST7703_CMD_SETVCOM, 0x3F, 0x3F);
> > +	dsi_generic_write_seq(dsi, 0xBF, 0x02, 0x11, 0x00);
> > +	dsi_generic_write_seq(dsi, ST7703_CMD_SETGIP1,
> > +			      0x82, 0x10, 0x06, 0x05, 0x9E, 0x0A, 0xA5, 0x12,
> > +			      0x31, 0x23, 0x37, 0x83, 0x04, 0xBC, 0x27, 0x38,
> > +			      0x0C, 0x00, 0x03, 0x00, 0x00, 0x00, 0x0C, 0x00,
> > +			      0x03, 0x00, 0x00, 0x00, 0x75, 0x75, 0x31, 0x88,
> > +			      0x88, 0x88, 0x88, 0x88, 0x88, 0x13, 0x88, 0x64,
> > +			      0x64, 0x20, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
> > +			      0x02, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
> > +	dsi_generic_write_seq(dsi, ST7703_CMD_SETGIP2,
> > +			      0x02, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +			      0x00, 0x00, 0x00, 0x00, 0x02, 0x46, 0x02, 0x88,
> > +			      0x88, 0x88, 0x88, 0x88, 0x88, 0x64, 0x88, 0x13,
> > +			      0x57, 0x13, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
> > +			      0x75, 0x88, 0x23, 0x14, 0x00, 0x00, 0x02, 0x00,
> > +			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x0A,
> > +			      0xA5, 0x00, 0x00, 0x00, 0x00);
> > +	dsi_generic_write_seq(dsi, ST7703_CMD_SETGAMMA,
> > +			      0x00, 0x09, 0x0E, 0x29, 0x2D, 0x3C, 0x41, 0x37,
> > +			      0x07, 0x0B, 0x0D, 0x10, 0x11, 0x0F, 0x10, 0x11,
> > +			      0x18, 0x00, 0x09, 0x0E, 0x29, 0x2D, 0x3C, 0x41,
> > +			      0x37, 0x07, 0x0B, 0x0D, 0x10, 0x11, 0x0F, 0x10,
> > +			      0x11, 0x18);
> > +	msleep(20);
> > +
> > +	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> > +	if (ret < 0) {
> > +		DRM_DEV_ERROR(dev, "Failed to exit sleep mode");
> > +		return ret;
> > +	}
> > +	/* Panel is operational 120 msec after reset */
> > +	msleep(60);
> > +	ret = mipi_dsi_dcs_set_display_on(dsi);
> > +	if (ret)
> > +		return ret;
> > +
> > +	DRM_DEV_DEBUG_DRIVER(dev, "Panel init sequence done");
> > +	return 0;
> > +}
> > +
> > +static int jh057n_disable(struct drm_panel *panel)
> > +{
> > +	struct jh057n *ctx = panel_to_jh057n(panel);
> > +	int ret;
> > +
> > +	if (!ctx->enabled)
> > +		return 0;
> > +
> > +	ret = backlight_disable(ctx->backlight);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ctx->enabled = false;
> > +
> > +	return 0;
> > +}
> 
> If ctx->enable is dropped then this function becomes:
> 
> > +static int jh057n_disable(struct drm_panel *panel)
> > +{
> > +	struct jh057n *ctx = panel_to_jh057n(panel);
> > +
> > +	backlight_disable(ctx->backlight);
> > +
> > +	return 0;
> > +}
> 
> 
> 
> > +static const struct drm_display_mode default_mode = {
> > +	.hdisplay    = 720,
> > +	.hsync_start = 720 + 90,
> > +	.hsync_end   = 720 + 90 + 20,
> > +	.htotal	     = 720 + 90 + 20 + 20,
> > +	.vdisplay    = 1440,
> > +	.vsync_start = 1440 + 20,
> > +	.vsync_end   = 1440 + 20 + 4,
> > +	.vtotal	     = 1440 + 20 + 4 + 12,
> > +	.vrefresh    = 60,
> > +	.clock	     = 75276,
> > +	.flags	     = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> > +	.width_mm    = 65,
> > +	.height_mm   = 130,
> > +};
> > +
> > +static int jh057n_get_modes(struct drm_panel *panel)
> > +{
> > +	struct drm_display_mode *mode;
> > +	u32 bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> > +	int ret;
> > +
> > +	mode = drm_mode_duplicate(panel->drm, &default_mode);
> > +	if (!mode) {
> > +		DRM_ERROR("Failed to add mode %ux%ux@%u",
> Should this be?
> > +		DRM_ERROR("Failed to add mode %ux%u@%u",
> (Note the second 'x' was dropped.
> 
> 
> > +			  default_mode.hdisplay, default_mode.vdisplay,
> > +			  default_mode.vrefresh);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	drm_mode_set_name(mode);
> > +
> > +	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> > +	panel->connector->display_info.width_mm = mode->width_mm;
> > +	panel->connector->display_info.height_mm = mode->height_mm;
> > +	ret = drm_display_info_set_bus_formats(&panel->connector->display_info,
> > +					       &bus_format, 1);
> It is my understanding that for spi controlled displays there is no need to set
> the bus_format.
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	drm_mode_probed_add(panel->connector, mode);
> > +
> > +	return 1;
> > +}
> > +
> 
> > +static int allpixelson_set(void *data, u64 val)
> > +{
> > +	struct jh057n *ctx = data;
> > +	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> > +
> > +	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Setting all pixels on");
> > +	dsi_generic_write_seq(dsi, ST7703_CMD_ALL_PIXEL_ON);
> > +	msleep(val*1000);
> If this is kept, then add spaces around operator '*'
> > +	/* Reset the panel to get video back */
> > +	drm_panel_disable(&ctx->panel);
> > +	drm_panel_unprepare(&ctx->panel);
> > +	drm_panel_prepare(&ctx->panel);
> > +	drm_panel_enable(&ctx->panel);
> > +
> > +	return 0;
> > +}
> > +
> > +DEFINE_SIMPLE_ATTRIBUTE(allpixelson_fops, NULL,
> > +			allpixelson_set, "%llu\n");
> > +
> > +static int jh057n_debugfs_init(struct jh057n *ctx)
> > +{
> > +	struct dentry *f;
> > +
> > +	ctx->debugfs = debugfs_create_dir(DRV_NAME, NULL);
> > +	if (!ctx->debugfs)
> > +		return -ENOMEM;
> > +
> > +	f = debugfs_create_file("allpixelson", 0600,
> > +				ctx->debugfs, ctx, &allpixelson_fops);
> > +	if (!f)
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
> > +
> > +static void jh057n_debugfs_remove(struct jh057n *ctx)
> > +{
> > +	debugfs_remove_recursive(ctx->debugfs);
> > +	ctx->debugfs = NULL;
> > +}
> > +
> > +static int jh057n_probe(struct mipi_dsi_device *dsi)
> > +{
> > +	struct device *dev = &dsi->dev;
> > +	struct jh057n *ctx;
> > +	int ret;
> > +
> > +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > +	if (!ctx)
> > +		return -ENOMEM;
> > +
> > +	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> > +	if (IS_ERR(ctx->reset_gpio)) {
> > +		DRM_DEV_ERROR(dev, "cannot get reset gpio");
> > +		return PTR_ERR(ctx->reset_gpio);
> > +	}
> > +
> > +	mipi_dsi_set_drvdata(dsi, ctx);
> > +
> > +	ctx->dev = dev;
> > +
> > +	dsi->lanes = 4;
> > +	dsi->format = MIPI_DSI_FMT_RGB888;
> > +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
> > +		MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
> > +
> > +	ctx->backlight = devm_of_find_backlight(dev);
> > +	if (IS_ERR(ctx->backlight))
> > +		return PTR_ERR(ctx->backlight);
> > +
> > +	drm_panel_init(&ctx->panel);
> > +	ctx->panel.dev = dev;
> > +	ctx->panel.funcs = &jh057n_drm_funcs;
> > +
> > +	drm_panel_add(&ctx->panel);
> > +
> > +	ret = mipi_dsi_attach(dsi);
> > +	if (ret < 0) {
> > +		DRM_DEV_ERROR(dev, "mipi_dsi_attach failed. Is host ready?");
> > +		drm_panel_remove(&ctx->panel);
> > +		goto err;
> > +	}
> > +
> > +	DRM_INFO(DRV_NAME "_panel %ux%u@%u %ubpp dsi %udl - ready",
> > +		 default_mode.hdisplay, default_mode.vdisplay,
> > +		 default_mode.vrefresh,
> > +		 mipi_dsi_pixel_format_to_bpp(dsi->format), dsi->lanes);
> > +
> > +	jh057n_debugfs_init(ctx);
> > +	return 0;
> > +
> > +err:
> > +	if (ctx->backlight)
> > +		put_device(&ctx->backlight->dev);
> No need for this check, it is handled by the devm_ infrastructure
> 
> > +	return ret;
> > +
> > +}
> > +
> > +static void jh057n_shutdown(struct mipi_dsi_device *dsi)
> > +{
> > +	struct jh057n *ctx = mipi_dsi_get_drvdata(dsi);
> > +	int ret;
> > +
> > +	ret = jh057n_unprepare(&ctx->panel);
> > +	if (ret < 0)
> > +		DRM_DEV_ERROR(&dsi->dev, "Failed to unprepare panel: %d\n",
> > +			      ret);
> > +
> > +	ret = jh057n_disable(&ctx->panel);
> > +	if (ret < 0)
> > +		DRM_DEV_ERROR(&dsi->dev, "Failed to disable panel: %d\n",
> > +			      ret);
> > +}
> > +
> > +static int jh057n_remove(struct mipi_dsi_device *dsi)
> > +{
> > +	struct jh057n *ctx = mipi_dsi_get_drvdata(dsi);
> > +	int ret;
> > +
> > +	jh057n_shutdown(dsi);
> > +
> > +	ret = mipi_dsi_detach(dsi);
> > +	if (ret < 0)
> > +		DRM_DEV_ERROR(&dsi->dev, "Failed to detach from DSI host: %d\n",
> > +			      ret);
> > +
> > +	drm_panel_remove(&ctx->panel);
> > +
> > +	if (ctx->backlight)
> > +		put_device(&ctx->backlight->dev);
> No need for this check, it is handled by the devm_ infrastructure
> 
> > +
> > +	jh057n_debugfs_remove(ctx);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id jh057n_of_match[] = {
> > +	{ .compatible = "rocktech,jh057n00900" },
> > +	{ }
> Consider replacing { } with
> 	{ /* Sentinel */ }
> This is how it looks in many other drivers.
> 
> > +};
> > +MODULE_DEVICE_TABLE(of, jh057n_of_match);
> > +
> > +static struct mipi_dsi_driver jh057n_driver = {
> > +	.probe	= jh057n_probe,
> > +	.remove = jh057n_remove,
> > +	.shutdown = jh057n_shutdown,
> > +	.driver = {
> > +		.name = DRV_NAME "_panel",
> > +		.of_match_table = jh057n_of_match,
> > +	},
> > +};
> > +module_mipi_dsi_driver(jh057n_driver);
> > +
> > +MODULE_AUTHOR("Guido Günther <agx@sigxcpu.org>");
> > +MODULE_DESCRIPTION("DRM driver for Rocktech JH057N00900 MIPI DSI panel");
> > +MODULE_LICENSE("GPL v2");
> SPDX says this:
> > +// SPDX-License-Identifier: GPL-2.0+
> 
> As far as I can tell this is not the same license.
> 
