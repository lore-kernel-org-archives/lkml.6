Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933281AbeB1TQV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:16:21 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50205 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932367AbeB1TQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:16:17 -0500
X-Google-Smtp-Source: AG47ELu+OCFuyqkV6pdcINYxRKv48Lp8wpYXp086pzcVsrswo2owrDJ5QaBY/HMQOA9zcV1JGaHRYA==
Date: Wed, 28 Feb 2018 20:16:13 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Philippe Cornu <philippe.cornu@st.com>
Cc: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v1 2/2] drm/panel: Add support for Raydium rm68200 panel
 driver
Message-ID: <20180228191611.GC22932@mithrandir>
References: <20180208143026.23009-1-philippe.cornu@st.com>
 <20180208143026.23009-3-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline
In-Reply-To: <20180208143026.23009-3-philippe.cornu@st.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2018 at 03:30:26PM +0100, Philippe Cornu wrote:
> This patch adds Raydium Semiconductor Corporation rm68200
> 5.5" 720x1280 TFT LCD panel driver (MIPI-DSI video mode).
>=20
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |   8 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  drivers/gpu/drm/panel/panel-raydium-rm68200.c | 464 ++++++++++++++++++++=
++++++
>  3 files changed, 473 insertions(+)
>  create mode 100755 drivers/gpu/drm/panel/panel-raydium-rm68200.c
>=20
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 988048ebcc22..08d99dd46765 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -108,6 +108,14 @@ config DRM_PANEL_RASPBERRYPI_TOUCHSCREEN
>  	  Pi 7" Touchscreen.  To compile this driver as a module,
>  	  choose M here.
> =20
> +config DRM_PANEL_RAYDIUM_RM68200
> +	tristate "Raydium rm68200 720x1280 dsi 2dl video mode panel"

What's 2dl? Either this is something already implied by the RM68200
model or if there are multiple variants of the RM68200 you'll probably
want to ensure that's reflected in the compatible string.

> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	help
> +	  Say Y here if you want to enable support for Raydium rm68200
> +	  720x1280 dsi 2dl video mode panel
> +
>  config DRM_PANEL_SAMSUNG_S6E3HA2
>  	tristate "Samsung S6E3HA2 DSI video mode panel"
>  	depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makef=
ile
> index 3d2a88d0e965..f26efc11d746 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_DRM_PANEL_LG_LG4573) +=3D panel-lg-lg4573.o
>  obj-$(CONFIG_DRM_PANEL_ORISETECH_OTM8009A) +=3D panel-orisetech-otm8009a=
=2Eo
>  obj-$(CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00) +=3D panel-panasonic-vvx1=
0f034n00.o
>  obj-$(CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN) +=3D panel-raspberrypi-t=
ouchscreen.o
> +obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM68200) +=3D panel-raydium-rm68200.o
>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_LD9040) +=3D panel-samsung-ld9040.o
>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2) +=3D panel-samsung-s6e3ha2.o
>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03) +=3D panel-samsung-s6e63j0x03=
=2Eo
> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm68200.c b/drivers/gpu/=
drm/panel/panel-raydium-rm68200.c
> new file mode 100755
> index 000000000000..f3e15873d05a
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
> @@ -0,0 +1,464 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) STMicroelectronics SA 2017
> + *
> + * Authors: Philippe Cornu <philippe.cornu@st.com>
> + *          Yannick Fertre <yannick.fertre@st.com>
> + */
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_panel.h>
> +#include <linux/backlight.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +#include <video/mipi_display.h>
> +
> +#define DRV_NAME "raydium_rm68200"

Not needed, see below.

> +
> +/*** Manufacturer Command Set ***/
> +#define MCS_CMD_MODE_SW	0xFE /* CMD Mode Switch */
> +#define MCS_CMD1_UCS	0x00 /* User Command Set (UCS =3D CMD1) */
> +#define MCS_CMD2_P0	0x01 /* Manufacture Command Set Page0 (CMD2 P0) */
> +#define MCS_CMD2_P1	0x02 /* Manufacture Command Set Page1 (CMD2 P1) */
> +#define MCS_CMD2_P2	0x03 /* Manufacture Command Set Page2 (CMD2 P2) */
> +#define MCS_CMD2_P3	0x04 /* Manufacture Command Set Page3 (CMD2 P3) */
> +
> +/* CMD2 P0 commands (Display Options and Power) */
> +#define MCS_STBCTR	0x12 /* TE1 Output Setting Zig-Zag Connection */
> +#define MCS_SGOPCTR	0x16 /* Source Bias Current */
> +#define MCS_SDCTR	0x1A /* Source Output Delay Time */
> +#define MCS_INVCTR	0x1B /* Inversion Type */
> +#define MCS_EXT_PWR_IC	0x24 /* External PWR IC Control */
> +#define MCS_SETAVDD	0x27 /* PFM Control for AVDD Output */
> +#define MCS_SETAVEE	0x29 /* PFM Control for AVEE Output */
> +#define MCS_BT2CTR	0x2B /* DDVDL Charge Pump Control */
> +#define MCS_BT3CTR	0x2F /* VGH Charge Pump Control */
> +#define MCS_BT4CTR	0x34 /* VGL Charge Pump Control */
> +#define MCS_VCMCTR	0x46 /* VCOM Output Level Control */
> +#define MCS_SETVGN	0x52 /* VG M/S N Control */
> +#define MCS_SETVGP	0x54 /* VG M/S P Control */
> +#define MCS_SW_CTRL	0x5F /* Interface Control for PFM and MIPI */
> +
> +/* CMD2 P2 commands (GOA Timing Control) - no description in datasheet */
> +#define GOA_VSTV1	0x00
> +#define GOA_VSTV2	0x07
> +#define GOA_VCLK1	0x0E
> +#define GOA_VCLK2	0x17
> +#define GOA_VCLK_OPT1	0x20
> +#define GOA_BICLK1	0x2A
> +#define GOA_BICLK2	0x37
> +#define GOA_BICLK3	0x44
> +#define GOA_BICLK4	0x4F
> +#define GOA_BICLK_OPT1	0x5B
> +#define GOA_BICLK_OPT2	0x60
> +#define MCS_GOA_GPO1	0x6D
> +#define MCS_GOA_GPO2	0x71
> +#define MCS_GOA_EQ	0x74
> +#define MCS_GOA_CLK_GALLON 0x7C
> +#define MCS_GOA_FS_SEL0	0x7E
> +#define MCS_GOA_FS_SEL1	0x87
> +#define MCS_GOA_FS_SEL2	0x91
> +#define MCS_GOA_FS_SEL3	0x9B
> +#define MCS_GOA_BS_SEL0	0xAC
> +#define MCS_GOA_BS_SEL1	0xB5
> +#define MCS_GOA_BS_SEL2	0xBF
> +#define MCS_GOA_BS_SEL3	0xC9
> +#define MCS_GOA_BS_SEL4	0xD3
> +
> +/* CMD2 P3 commands (Gamma) */
> +#define MCS_GAMMA_VP	0x60 /* Gamma VP1~VP16 */
> +#define MCS_GAMMA_VN	0x70 /* Gamma VN1~VN16 */
> +
> +struct rm68200 {
> +	struct device *dev;
> +	struct drm_panel panel;
> +	struct gpio_desc *reset_gpio;
> +	struct regulator *supply;
> +	struct backlight_device *bl_dev;
> +	bool prepared;
> +	bool enabled;
> +};
> +
> +static const struct drm_display_mode default_mode =3D {
> +	.clock =3D 52582,
> +	.hdisplay =3D 720,
> +	.hsync_start =3D 720 + 38,
> +	.hsync_end =3D 720 + 38 + 8,
> +	.htotal =3D 720 + 38 + 8 + 38,
> +	.vdisplay =3D 1280,
> +	.vsync_start =3D 1280 + 12,
> +	.vsync_end =3D 1280 + 12 + 4,
> +	.vtotal =3D 1280 + 12 + 4 + 12,
> +	.vrefresh =3D 50,
> +	.flags =3D 0,
> +	.width_mm =3D 68,
> +	.height_mm =3D 122,
> +};
> +
> +static inline struct rm68200 *panel_to_rm68200(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct rm68200, panel);
> +}
> +
> +static void rm68200_dcs_write_buf(struct rm68200 *ctx, const void *data,
> +				  size_t len)
> +{
> +	struct mipi_dsi_device *dsi =3D to_mipi_dsi_device(ctx->dev);
> +
> +	if (mipi_dsi_dcs_write_buffer(dsi, data, len) < 0)
> +		DRM_WARN("mipi dsi dcs write buffer failed\n");
> +}
> +
> +static void rm68200_dcs_write_cmd(struct rm68200 *ctx, u8 cmd, u8 value)
> +{
> +	struct mipi_dsi_device *dsi =3D to_mipi_dsi_device(ctx->dev);
> +
> +	if (mipi_dsi_dcs_write(dsi, cmd, &value, 1) < 0)
> +		DRM_WARN("mipi dsi dcs write failed\n");
> +}

I question the usefulness of your error reporting here. You're not
giving the user any meaningful feedback. Also, you'll be warning about
every single failure. It's likely that if one of the writes fails, then
subsequent writes will also fail, which means that you'll give the user
a flood of DRM_WARN() with exactly the same text.

> +/*
> + * This panel is not able to auto-increment all cmd addresses so for som=
e of
> + * them, we need to send them one by one...
> + */
> +#define dcs_write_cmd_seq(ctx, cmd, seq...)			\
> +({								\
> +	static const u8 d[] =3D { seq };				\
> +	static int i;						\
> +	for (i =3D 0; i < ARRAY_SIZE(d) ; i++)			\
> +		rm68200_dcs_write_cmd(ctx, cmd + i, d[i]);	\
> +})
> +
> +static void rm68200_init_sequence(struct rm68200 *ctx)
> +{
> +	/* Enter CMD2 with page 0 */
> +	dcs_write_seq(ctx, MCS_CMD_MODE_SW, MCS_CMD2_P0);
> +	dcs_write_cmd_seq(ctx, MCS_EXT_PWR_IC, 0xC0, 0x53, 0x00);
> +	dcs_write_seq(ctx, MCS_BT2CTR, 0xE5);
> +	dcs_write_seq(ctx, MCS_SETAVDD, 0x0A);
> +	dcs_write_seq(ctx, MCS_SETAVEE, 0x0A);
> +	dcs_write_seq(ctx, MCS_SGOPCTR, 0x52);
> +	dcs_write_seq(ctx, MCS_BT3CTR, 0x53);
> +	dcs_write_seq(ctx, MCS_BT4CTR, 0x5A);
> +	dcs_write_seq(ctx, MCS_INVCTR, 0x00);
> +	dcs_write_seq(ctx, MCS_STBCTR, 0x0A);
> +	dcs_write_seq(ctx, MCS_SDCTR, 0x06);
> +	dcs_write_seq(ctx, MCS_VCMCTR, 0x56);
> +	dcs_write_seq(ctx, MCS_SETVGN, 0xA0, 0x00);
> +	dcs_write_seq(ctx, MCS_SETVGP, 0xA0, 0x00);
> +	dcs_write_seq(ctx, MCS_SW_CTRL, 0x11); /* 2 data lanes, see doc */
> +
> +	dcs_write_seq(ctx, MCS_CMD_MODE_SW, MCS_CMD2_P2);
> +	dcs_write_seq(ctx, GOA_VSTV1, 0x05);
> +	dcs_write_seq(ctx, 0x02, 0x0B);
> +	dcs_write_seq(ctx, 0x03, 0x0F);
> +	dcs_write_seq(ctx, 0x04, 0x7D, 0x00, 0x50);
> +	dcs_write_cmd_seq(ctx, GOA_VSTV2, 0x05, 0x16, 0x0D, 0x11, 0x7D, 0x00,
> +			  0x50);
> +	dcs_write_cmd_seq(ctx, GOA_VCLK1, 0x07, 0x08, 0x01, 0x02, 0x00, 0x7D,
> +			  0x00, 0x85, 0x08);
> +	dcs_write_cmd_seq(ctx, GOA_VCLK2, 0x03, 0x04, 0x05, 0x06, 0x00, 0x7D,
> +			  0x00, 0x85, 0x08);
> +	dcs_write_seq(ctx, GOA_VCLK_OPT1, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +		      0x00, 0x00, 0x00, 0x00);
> +	dcs_write_cmd_seq(ctx, GOA_BICLK1, 0x07, 0x08);
> +	dcs_write_seq(ctx, 0x2D, 0x01);
> +	dcs_write_seq(ctx, 0x2F, 0x02, 0x00, 0x40, 0x05, 0x08, 0x54, 0x7D,
> +		      0x00);
> +	dcs_write_cmd_seq(ctx, GOA_BICLK2, 0x03, 0x04, 0x05, 0x06, 0x00);
> +	dcs_write_seq(ctx, 0x3D, 0x40);
> +	dcs_write_seq(ctx, 0x3F, 0x05, 0x08, 0x54, 0x7D, 0x00);
> +	dcs_write_seq(ctx, GOA_BICLK3, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +		      0x00, 0x00, 0x00, 0x00, 0x00);
> +	dcs_write_seq(ctx, GOA_BICLK4, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +		      0x00, 0x00);
> +	dcs_write_seq(ctx, 0x58, 0x00, 0x00, 0x00);
> +	dcs_write_seq(ctx, GOA_BICLK_OPT1, 0x00, 0x00, 0x00, 0x00, 0x00);
> +	dcs_write_seq(ctx, GOA_BICLK_OPT2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +		      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
> +	dcs_write_seq(ctx, MCS_GOA_GPO1, 0x00, 0x00, 0x00, 0x00);
> +	dcs_write_seq(ctx, MCS_GOA_GPO2, 0x00, 0x20, 0x00);
> +	dcs_write_seq(ctx, MCS_GOA_EQ, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
> +		      0x00, 0x00);
> +	dcs_write_seq(ctx, MCS_GOA_CLK_GALLON, 0x00, 0x00);
> +	dcs_write_cmd_seq(ctx, MCS_GOA_FS_SEL0, 0xBF, 0x02, 0x06, 0x14, 0x10,
> +			  0x16, 0x12, 0x08, 0x3F);
> +	dcs_write_cmd_seq(ctx, MCS_GOA_FS_SEL1, 0x3F, 0x3F, 0x3F, 0x3F, 0x0C,
> +			  0x0A, 0x0E, 0x3F, 0x3F, 0x00);
> +	dcs_write_cmd_seq(ctx, MCS_GOA_FS_SEL2, 0x04, 0x3F, 0x3F, 0x3F, 0x3F,
> +			  0x05, 0x01, 0x3F, 0x3F, 0x0F);
> +	dcs_write_cmd_seq(ctx, MCS_GOA_FS_SEL3, 0x0B, 0x0D, 0x3F, 0x3F, 0x3F,
> +			  0x3F);
> +	dcs_write_cmd_seq(ctx, 0xA2, 0x3F, 0x09, 0x13, 0x17, 0x11, 0x15);
> +	dcs_write_cmd_seq(ctx, 0xA9, 0x07, 0x03, 0x3F);
> +	dcs_write_cmd_seq(ctx, MCS_GOA_BS_SEL0, 0x3F, 0x05, 0x01, 0x17, 0x13,
> +			  0x15, 0x11, 0x0F, 0x3F);
> +	dcs_write_cmd_seq(ctx, MCS_GOA_BS_SEL1, 0x3F, 0x3F, 0x3F, 0x3F, 0x0B,
> +			  0x0D, 0x09, 0x3F, 0x3F, 0x07);
> +	dcs_write_cmd_seq(ctx, MCS_GOA_BS_SEL2, 0x03, 0x3F, 0x3F, 0x3F, 0x3F,
> +			  0x02, 0x06, 0x3F, 0x3F, 0x08);
> +	dcs_write_cmd_seq(ctx, MCS_GOA_BS_SEL3, 0x0C, 0x0A, 0x3F, 0x3F, 0x3F,
> +			  0x3F, 0x3F, 0x0E, 0x10, 0x14);
> +	dcs_write_cmd_seq(ctx, MCS_GOA_BS_SEL4, 0x12, 0x16, 0x00, 0x04, 0x3F);
> +	dcs_write_seq(ctx, 0xDC, 0x02);
> +	dcs_write_seq(ctx, 0xDE, 0x12);
> +
> +	dcs_write_seq(ctx, MCS_CMD_MODE_SW, 0x0E); /* No documentation */
> +	dcs_write_seq(ctx, 0x01, 0x75);
> +
> +	dcs_write_seq(ctx, MCS_CMD_MODE_SW, MCS_CMD2_P3);
> +	dcs_write_cmd_seq(ctx, MCS_GAMMA_VP, 0x00, 0x0C, 0x12, 0x0E, 0x06,
> +			  0x12, 0x0E, 0x0B, 0x15, 0x0B, 0x10, 0x07, 0x0F,
> +			  0x12, 0x0C, 0x00);
> +	dcs_write_cmd_seq(ctx, MCS_GAMMA_VN, 0x00, 0x0C, 0x12, 0x0E, 0x06,
> +			  0x12, 0x0E, 0x0B, 0x15, 0x0B, 0x10, 0x07, 0x0F,
> +			  0x12, 0x0C, 0x00);
> +
> +	/* Exit CMD2 */
> +	dcs_write_seq(ctx, MCS_CMD_MODE_SW, MCS_CMD1_UCS);
> +}
> +
> +static int rm68200_disable(struct drm_panel *panel)
> +{
> +	struct rm68200 *ctx =3D panel_to_rm68200(panel);
> +
> +	if (!ctx->enabled)
> +		return 0;
> +
> +	if (ctx->bl_dev) {
> +		ctx->bl_dev->props.power =3D FB_BLANK_POWERDOWN;
> +		ctx->bl_dev->props.state |=3D BL_CORE_FBBLANK;
> +		backlight_update_status(ctx->bl_dev);
> +	}

This should use the new backlight_disable() function.

> +
> +	ctx->enabled =3D false;
> +
> +	return 0;
> +}
> +
> +static int rm68200_unprepare(struct drm_panel *panel)
> +{
> +	struct rm68200 *ctx =3D panel_to_rm68200(panel);
> +	struct mipi_dsi_device *dsi =3D to_mipi_dsi_device(ctx->dev);
> +	int ret;
> +
> +	if (!ctx->prepared)
> +		return 0;
> +
> +	ret =3D mipi_dsi_dcs_set_display_off(dsi);
> +	if (ret)
> +		DRM_WARN("failed to set display off: %d\n", ret);
> +
> +	ret =3D mipi_dsi_dcs_enter_sleep_mode(dsi);
> +	if (ret)
> +		DRM_WARN("failed to enter sleep mode: %d\n", ret);
> +
> +	msleep(120);
> +
> +	if (ctx->reset_gpio) {
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +		msleep(20);
> +	}
> +
> +	regulator_disable(ctx->supply);
> +
> +	ctx->prepared =3D false;
> +
> +	return 0;
> +}
> +
> +static int rm68200_prepare(struct drm_panel *panel)
> +{
> +	struct rm68200 *ctx =3D panel_to_rm68200(panel);
> +	struct mipi_dsi_device *dsi =3D to_mipi_dsi_device(ctx->dev);
> +	int ret;
> +
> +	if (ctx->prepared)
> +		return 0;
> +
> +	ret =3D regulator_enable(ctx->supply);
> +	if (ret < 0) {
> +		DRM_ERROR("failed to enable supply: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (ctx->reset_gpio) {
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 0);

Why do you need this? If the panel is already in reset, shouldn't the
below still work? Why take it out of reset only to reset it immediately
afterwards again?

> +		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +		msleep(20);
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +		msleep(100);
> +	}
> +
> +	rm68200_init_sequence(ctx);
> +
> +	ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> +	if (ret)
> +		return ret;
> +
> +	msleep(125);
> +
> +	ret =3D mipi_dsi_dcs_set_display_on(dsi);
> +	if (ret)
> +		return ret;
> +
> +	msleep(20);
> +
> +	ctx->prepared =3D true;
> +
> +	return 0;
> +}
> +
> +static int rm68200_enable(struct drm_panel *panel)
> +{
> +	struct rm68200 *ctx =3D panel_to_rm68200(panel);
> +
> +	if (ctx->enabled)
> +		return 0;
> +
> +	if (ctx->bl_dev) {
> +		ctx->bl_dev->props.state &=3D ~BL_CORE_FBBLANK;
> +		ctx->bl_dev->props.power =3D FB_BLANK_UNBLANK;
> +		backlight_update_status(ctx->bl_dev);
> +	}

backlight_enable(), please.

> +
> +	ctx->enabled =3D true;
> +
> +	return 0;
> +}
> +
> +static int rm68200_get_modes(struct drm_panel *panel)
> +{
> +	struct drm_display_mode *mode;
> +
> +	mode =3D drm_mode_duplicate(panel->drm, &default_mode);
> +	if (!mode) {
> +		DRM_ERROR("failed to add mode %ux%ux@%u\n",
> +			  default_mode.hdisplay, default_mode.vdisplay,
> +			  default_mode.vrefresh);
> +		return -ENOMEM;
> +	}
> +
> +	drm_mode_set_name(mode);
> +
> +	mode->type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +	drm_mode_probed_add(panel->connector, mode);
> +
> +	panel->connector->display_info.width_mm =3D mode->width_mm;
> +	panel->connector->display_info.height_mm =3D mode->height_mm;
> +
> +	return 1;
> +}
> +
> +static const struct drm_panel_funcs rm68200_drm_funcs =3D {
> +	.disable   =3D rm68200_disable,
> +	.unprepare =3D rm68200_unprepare,
> +	.prepare   =3D rm68200_prepare,
> +	.enable    =3D rm68200_enable,
> +	.get_modes =3D rm68200_get_modes,
> +};
> +
> +static int rm68200_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev =3D &dsi->dev;
> +	struct device_node *backlight;
> +	struct rm68200 *ctx;
> +	int ret;
> +
> +	ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW=
);
> +	if (IS_ERR(ctx->reset_gpio)) {
> +		dev_err(dev, "cannot get reset-gpio\n");
> +		return PTR_ERR(ctx->reset_gpio);
> +	}
> +
> +	ctx->supply =3D devm_regulator_get(dev, "power");
> +	if (IS_ERR(ctx->supply)) {
> +		dev_err(dev, "cannot get regulator\n");
> +		return PTR_ERR(ctx->supply);
> +	}
> +
> +	backlight =3D of_parse_phandle(dev->of_node, "backlight", 0);
> +	if (backlight) {
> +		ctx->bl_dev =3D of_find_backlight_by_node(backlight);
> +		of_node_put(backlight);
> +
> +		if (!ctx->bl_dev)
> +			return -EPROBE_DEFER;
> +	}

devm_of_find_backlight()

> +
> +	mipi_dsi_set_drvdata(dsi, ctx);
> +
> +	ctx->dev =3D dev;
> +
> +	dsi->lanes =3D 2;
> +	dsi->format =3D MIPI_DSI_FMT_RGB888;
> +	dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> +			  MIPI_DSI_MODE_LPM;
> +
> +	drm_panel_init(&ctx->panel);
> +	ctx->panel.dev =3D dev;
> +	ctx->panel.funcs =3D &rm68200_drm_funcs;
> +
> +	drm_panel_add(&ctx->panel);
> +
> +	ret =3D mipi_dsi_attach(dsi);
> +	if (ret < 0) {
> +		dev_err(dev, "mipi_dsi_attach failed. Is host ready?\n");
> +		drm_panel_remove(&ctx->panel);
> +		if (ctx->bl_dev)
> +			put_device(&ctx->bl_dev->dev);
> +		return ret;
> +	}
> +
> +	DRM_INFO(DRV_NAME "_panel %ux%u@%u %ubpp dsi %udl - ready\n",
> +		 default_mode.hdisplay, default_mode.vdisplay,
> +		 default_mode.vrefresh,
> +		 mipi_dsi_pixel_format_to_bpp(dsi->format), dsi->lanes);

No need to brag about this being successful. That's what it's supposed
to be. You should let the user know if things *don't* happen the way
they're supposed to.

> +
> +	return 0;
> +}
> +
> +static int rm68200_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct rm68200 *ctx =3D mipi_dsi_get_drvdata(dsi);
> +
> +	if (ctx->bl_dev)
> +		put_device(&ctx->bl_dev->dev);
> +
> +	mipi_dsi_detach(dsi);
> +	drm_panel_remove(&ctx->panel);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id raydium_rm68200_of_match[] =3D {
> +	{ .compatible =3D "raydium,rm68200" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, raydium_rm68200_of_match);
> +
> +static struct mipi_dsi_driver raydium_rm68200_driver =3D {
> +	.probe  =3D rm68200_probe,
> +	.remove =3D rm68200_remove,
> +	.driver =3D {
> +		.name =3D DRV_NAME "_panel",

This is the only occurrence so you can just drop DRV_NAME and put the
name here.

> +		.of_match_table =3D raydium_rm68200_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(raydium_rm68200_driver);
> +
> +MODULE_AUTHOR("Philippe Cornu <philippe.cornu@st.com>");
> +MODULE_AUTHOR("Yannick Fertre <yannick.fertre@st.com>");
> +MODULE_DESCRIPTION("DRM Driver for Raydium RM68200 MIPI DSI panel");

You use RM68200 here but in other places you use rm68200. Please be
consistent. It seems like RM68200 is the "official" spelling, so stick
to that in prose.

Thierry

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqW//UACgkQ3SOs138+
s6EdyBAAu/mIcrXzAUBjUY45LcCHYfqFF806OYDbRHHALvrKlCzEyLX/s0/llriz
dxeZVldmCnlZPXtMpnfpoSx25o0lirQz3jWkB/5WJ0qsrAFZSMuZrHDa86qXRGOW
CUoqFTp6+aGsUdakJ9EwEoGbZ4CN7Gu4FaW8q9JbMDLrkEWxhcjCZOqNRCzqOTUO
+bn7sMK2VPEttsjmlji7ZuPH0T7eqY08FRIJ8X8nE/+a/VleA4JQ6XG22teBwdht
myhTTMLNjv9PmKWZ1DoysXXHm+1BZfXJzJfP9lS+goV5DfW6Zq/N3XXRFOwpXSiX
zqWdwP1Il5YrwcLcy0IeEinH7+1CFVQ3rjOo/aHYt6z0Rere2chIe/v0X3AG46Cv
cK1h46+lAMbreoTT8ufJm+d2letM2OiSfzpkpATB/dlbh+Fw6SIbQJhP988DoEso
oOzjiwRJyAZFhtRu6xLTSYUQjyujdvPpJA6EObHyEQTI16aI7NxX/Vod3Jalw+Jo
yRlsgwTR2OfndXSSyeFREu7kzd9ptt1DaYKoP38Ay97xF9oBFwvnt83pTe+yLdtA
vqYesyBFB17gta8CFa+LqY4Xq/wIFa/y1EiPjPlE54U39F79nDIqTvVjGQSxqz0c
lABBBGsaGNVkhO8czyXsDYqeaS4wvNDGeWyQtxAkA2xrWfsskt0=
=AMMJ
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
