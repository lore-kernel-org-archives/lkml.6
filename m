Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756679AbeDZPHS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 11:07:18 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:44173 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755871AbeDZPHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 11:07:16 -0400
X-Google-Smtp-Source: AB8JxZqfk4ptSmAFr7MIK33uqavP9VF+psN+f7BtUirwKpQksA9LDJreSmT9v7ofTYBcLJKbeWuwsA==
Date: Thu, 26 Apr 2018 17:07:12 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, dri-devel@lists.freedesktop.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 6/8] drm/panel: Add Ilitek ILI9881c panel driver
Message-ID: <20180426150712.GF31888@ulmo>
References: <cover.a3617c4362eac8783f412525e52cf5552d19095d.1522835818.git-series.maxime.ripard@bootlin.com>
 <a99bb44577ae18e77e60dba904618db23ee5dca7.1522835818.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CXFpZVxO6m2Ol4tQ"
Content-Disposition: inline
In-Reply-To: <a99bb44577ae18e77e60dba904618db23ee5dca7.1522835818.git-series.maxime.ripard@bootlin.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CXFpZVxO6m2Ol4tQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 04, 2018 at 11:57:14AM +0200, Maxime Ripard wrote:
> The LHR050H41 panel is the panel shipped with the BananaPi M2-Magic, and =
is
> based on the Ilitek ILI9881c Controller. Add a driver for it, modelled
> after the other Ilitek controller drivers.
>=20
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |   9 +-
>  drivers/gpu/drm/panel/Makefile                |   1 +-
>  drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 489 +++++++++++++++++++-
>  3 files changed, 499 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
>=20
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 25682ff3449a..6020c30a33b3 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -46,6 +46,15 @@ config DRM_PANEL_ILITEK_IL9322
>  	  Say Y here if you want to enable support for Ilitek IL9322
>  	  QVGA (320x240) RGB, YUV and ITU-T BT.656 panels.
> =20
> +config DRM_PANEL_ILITEK_ILI9881C
> +	tristate "Ilitek ILI9881C-based panels"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Say Y if you want to enable support for panels based on the
> +	  Ilitek ILI9881c controller.
> +
>  config DRM_PANEL_INNOLUX_P079ZCA
>  	tristate "Innolux P079ZCA panel"
>  	depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makef=
ile
> index f26efc11d746..5ccaaa9d13af 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_DRM_PANEL_ARM_VERSATILE) +=3D panel-arm-vers=
atile.o
>  obj-$(CONFIG_DRM_PANEL_LVDS) +=3D panel-lvds.o
>  obj-$(CONFIG_DRM_PANEL_SIMPLE) +=3D panel-simple.o
>  obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) +=3D panel-ilitek-ili9322.o
> +obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) +=3D panel-ilitek-ili9881c.o
>  obj-$(CONFIG_DRM_PANEL_INNOLUX_P079ZCA) +=3D panel-innolux-p079zca.o
>  obj-$(CONFIG_DRM_PANEL_JDI_LT070ME05000) +=3D panel-jdi-lt070me05000.o
>  obj-$(CONFIG_DRM_PANEL_LG_LG4573) +=3D panel-lg-lg4573.o
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/=
drm/panel/panel-ilitek-ili9881c.c
> new file mode 100644
> index 000000000000..8992a6431c30
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> @@ -0,0 +1,489 @@
> +// SPDX-License-Identifier: GPL-2.0+

This isn't a valid SPDX license specifier. The module license is GPL v2,
so the corresponding specifier would be: GPL-2.0-only.

> +/*
> + * Copyright (C) 2017, Free Electrons

-2018?

> + * Author: Maxime Ripard <maxime.ripard@free-electrons.com>

No need for this, it's already in MODULE_AUTHOR.

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
> +
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +
> +#include <video/mipi_display.h>
> +
> +struct ili9881c {
> +	struct drm_panel	panel;
> +	struct mipi_dsi_device	*dsi;
> +
> +	struct backlight_device *backlight;
> +	struct gpio_desc	*power;
> +	struct gpio_desc	*reset;
> +};
> +
> +enum ili9881c_op {
> +	ILI9881C_SWITCH_PAGE,
> +	ILI9881C_COMMAND,
> +};
> +
> +struct ili9881c_instr {
> +	enum ili9881c_op	op;
> +
> +	union arg {
> +		struct cmd {
> +			u8	cmd;
> +			u8	data;
> +		} cmd;
> +		u8	page;
> +	} arg;
> +};
> +
> +#define ILI9881C_SWITCH_PAGE_INSTR(_page)	\
> +	{					\
> +		.op =3D ILI9881C_SWITCH_PAGE,	\
> +		.arg =3D {			\
> +			.page =3D (_page),	\
> +		},				\
> +	}
> +
> +#define ILI9881C_COMMAND_INSTR(_cmd, _data)		\
> +	{						\
> +		.op =3D ILI9881C_COMMAND,		\
> +		.arg =3D {				\
> +			.cmd =3D {			\
> +				.cmd =3D (_cmd),		\
> +				.data =3D (_data),	\
> +			},				\
> +		},					\
> +	}
> +
> +static struct ili9881c_instr ili9881c_init[] =3D {

These are never modified, so they could be const, right?

> +	ILI9881C_SWITCH_PAGE_INSTR(3),
> +	ILI9881C_COMMAND_INSTR(0x01, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x02, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x03, 0x73),
> +	ILI9881C_COMMAND_INSTR(0x04, 0x03),
> +	ILI9881C_COMMAND_INSTR(0x05, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x06, 0x06),
> +	ILI9881C_COMMAND_INSTR(0x07, 0x06),
> +	ILI9881C_COMMAND_INSTR(0x08, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x09, 0x18),
> +	ILI9881C_COMMAND_INSTR(0x0a, 0x04),
> +	ILI9881C_COMMAND_INSTR(0x0b, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x0c, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x0d, 0x03),
> +	ILI9881C_COMMAND_INSTR(0x0e, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x0f, 0x25),
> +	ILI9881C_COMMAND_INSTR(0x10, 0x25),
> +	ILI9881C_COMMAND_INSTR(0x11, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x12, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x13, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x14, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x15, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x16, 0x0C),
> +	ILI9881C_COMMAND_INSTR(0x17, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x18, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x19, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x1a, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x1b, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x1c, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x1d, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x1e, 0xC0),
> +	ILI9881C_COMMAND_INSTR(0x1f, 0x80),
> +	ILI9881C_COMMAND_INSTR(0x20, 0x04),
> +	ILI9881C_COMMAND_INSTR(0x21, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x22, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x23, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x24, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x25, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x26, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x27, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x28, 0x33),
> +	ILI9881C_COMMAND_INSTR(0x29, 0x03),
> +	ILI9881C_COMMAND_INSTR(0x2a, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x2b, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x2c, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x2d, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x2e, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x2f, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x30, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x31, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x32, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x33, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x34, 0x04),
> +	ILI9881C_COMMAND_INSTR(0x35, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x36, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x37, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x38, 0x3C),
> +	ILI9881C_COMMAND_INSTR(0x39, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x3a, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x3b, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x3c, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x3d, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x3e, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x3f, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x40, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x41, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x42, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x43, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x44, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x50, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x51, 0x23),
> +	ILI9881C_COMMAND_INSTR(0x52, 0x45),
> +	ILI9881C_COMMAND_INSTR(0x53, 0x67),
> +	ILI9881C_COMMAND_INSTR(0x54, 0x89),
> +	ILI9881C_COMMAND_INSTR(0x55, 0xab),
> +	ILI9881C_COMMAND_INSTR(0x56, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x57, 0x23),
> +	ILI9881C_COMMAND_INSTR(0x58, 0x45),
> +	ILI9881C_COMMAND_INSTR(0x59, 0x67),
> +	ILI9881C_COMMAND_INSTR(0x5a, 0x89),
> +	ILI9881C_COMMAND_INSTR(0x5b, 0xab),
> +	ILI9881C_COMMAND_INSTR(0x5c, 0xcd),
> +	ILI9881C_COMMAND_INSTR(0x5d, 0xef),
> +	ILI9881C_COMMAND_INSTR(0x5e, 0x11),
> +	ILI9881C_COMMAND_INSTR(0x5f, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x60, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x61, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x62, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x63, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x64, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x65, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x66, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x67, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x68, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x69, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x6a, 0x0C),
> +	ILI9881C_COMMAND_INSTR(0x6b, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x6c, 0x0F),
> +	ILI9881C_COMMAND_INSTR(0x6d, 0x0E),
> +	ILI9881C_COMMAND_INSTR(0x6e, 0x0D),
> +	ILI9881C_COMMAND_INSTR(0x6f, 0x06),
> +	ILI9881C_COMMAND_INSTR(0x70, 0x07),
> +	ILI9881C_COMMAND_INSTR(0x71, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x72, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x73, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x74, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x75, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x76, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x77, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x78, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x79, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x7a, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x7b, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x7c, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x7d, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x7e, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x7f, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x80, 0x0C),
> +	ILI9881C_COMMAND_INSTR(0x81, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x82, 0x0F),
> +	ILI9881C_COMMAND_INSTR(0x83, 0x0E),
> +	ILI9881C_COMMAND_INSTR(0x84, 0x0D),
> +	ILI9881C_COMMAND_INSTR(0x85, 0x06),
> +	ILI9881C_COMMAND_INSTR(0x86, 0x07),
> +	ILI9881C_COMMAND_INSTR(0x87, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x88, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x89, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x8A, 0x02),
> +	ILI9881C_SWITCH_PAGE_INSTR(4),
> +	ILI9881C_COMMAND_INSTR(0x6C, 0x15),
> +	ILI9881C_COMMAND_INSTR(0x6E, 0x22),
> +	ILI9881C_COMMAND_INSTR(0x6F, 0x33),
> +	ILI9881C_COMMAND_INSTR(0x3A, 0xA4),
> +	ILI9881C_COMMAND_INSTR(0x8D, 0x0D),
> +	ILI9881C_COMMAND_INSTR(0x87, 0xBA),
> +	ILI9881C_COMMAND_INSTR(0x26, 0x76),
> +	ILI9881C_COMMAND_INSTR(0xB2, 0xD1),
> +	ILI9881C_SWITCH_PAGE_INSTR(1),
> +	ILI9881C_COMMAND_INSTR(0x22, 0x0A),
> +	ILI9881C_COMMAND_INSTR(0x53, 0xDC),
> +	ILI9881C_COMMAND_INSTR(0x55, 0xA7),
> +	ILI9881C_COMMAND_INSTR(0x50, 0x78),
> +	ILI9881C_COMMAND_INSTR(0x51, 0x78),
> +	ILI9881C_COMMAND_INSTR(0x31, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x60, 0x14),
> +	ILI9881C_COMMAND_INSTR(0xA0, 0x2A),
> +	ILI9881C_COMMAND_INSTR(0xA1, 0x39),
> +	ILI9881C_COMMAND_INSTR(0xA2, 0x46),
> +	ILI9881C_COMMAND_INSTR(0xA3, 0x0e),
> +	ILI9881C_COMMAND_INSTR(0xA4, 0x12),
> +	ILI9881C_COMMAND_INSTR(0xA5, 0x25),
> +	ILI9881C_COMMAND_INSTR(0xA6, 0x19),
> +	ILI9881C_COMMAND_INSTR(0xA7, 0x1d),
> +	ILI9881C_COMMAND_INSTR(0xA8, 0xa6),
> +	ILI9881C_COMMAND_INSTR(0xA9, 0x1C),
> +	ILI9881C_COMMAND_INSTR(0xAA, 0x29),
> +	ILI9881C_COMMAND_INSTR(0xAB, 0x85),
> +	ILI9881C_COMMAND_INSTR(0xAC, 0x1C),
> +	ILI9881C_COMMAND_INSTR(0xAD, 0x1B),
> +	ILI9881C_COMMAND_INSTR(0xAE, 0x51),
> +	ILI9881C_COMMAND_INSTR(0xAF, 0x22),
> +	ILI9881C_COMMAND_INSTR(0xB0, 0x2d),
> +	ILI9881C_COMMAND_INSTR(0xB1, 0x4f),
> +	ILI9881C_COMMAND_INSTR(0xB2, 0x59),
> +	ILI9881C_COMMAND_INSTR(0xB3, 0x3F),
> +	ILI9881C_COMMAND_INSTR(0xC0, 0x2A),
> +	ILI9881C_COMMAND_INSTR(0xC1, 0x3a),
> +	ILI9881C_COMMAND_INSTR(0xC2, 0x45),
> +	ILI9881C_COMMAND_INSTR(0xC3, 0x0e),
> +	ILI9881C_COMMAND_INSTR(0xC4, 0x11),
> +	ILI9881C_COMMAND_INSTR(0xC5, 0x24),
> +	ILI9881C_COMMAND_INSTR(0xC6, 0x1a),
> +	ILI9881C_COMMAND_INSTR(0xC7, 0x1c),
> +	ILI9881C_COMMAND_INSTR(0xC8, 0xaa),
> +	ILI9881C_COMMAND_INSTR(0xC9, 0x1C),
> +	ILI9881C_COMMAND_INSTR(0xCA, 0x29),
> +	ILI9881C_COMMAND_INSTR(0xCB, 0x96),
> +	ILI9881C_COMMAND_INSTR(0xCC, 0x1C),
> +	ILI9881C_COMMAND_INSTR(0xCD, 0x1B),
> +	ILI9881C_COMMAND_INSTR(0xCE, 0x51),
> +	ILI9881C_COMMAND_INSTR(0xCF, 0x22),
> +	ILI9881C_COMMAND_INSTR(0xD0, 0x2b),
> +	ILI9881C_COMMAND_INSTR(0xD1, 0x4b),
> +	ILI9881C_COMMAND_INSTR(0xD2, 0x59),
> +	ILI9881C_COMMAND_INSTR(0xD3, 0x3F),
> +};
> +
> +static inline struct ili9881c *panel_to_ili9881c(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct ili9881c, panel);
> +}
> +
> +static int ili9881c_switch_page(struct ili9881c *ctx, u8 page)
> +{
> +	u8 buf[4] =3D { 0xff, 0x98, 0x81, page };
> +	int ret;
> +
> +	ret =3D mipi_dsi_dcs_write_buffer(ctx->dsi, buf, sizeof(buf));
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int ili9881c_send_cmd_data(struct ili9881c *ctx, u8 cmd, u8 data)
> +{
> +	u8 buf[2] =3D { cmd, data };
> +	int ret;
> +
> +	ret =3D mipi_dsi_dcs_write_buffer(ctx->dsi, buf, sizeof(buf));
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}

According to this you're sending DCS commands, but none of the above
look like valid DCS commands. Do you know what's going on here? Also,
can you include a reference to a datasheet where these instructions
come from?

Thierry

> +
> +static int ili9881c_prepare(struct drm_panel *panel)
> +{
> +	struct ili9881c *ctx =3D panel_to_ili9881c(panel);
> +	unsigned int i;
> +	int ret;
> +
> +	/* Power the panel */
> +	gpiod_set_value(ctx->power, 1);
> +	msleep(5);
> +
> +	/* And reset it */
> +	gpiod_set_value(ctx->reset, 1);
> +	msleep(20);
> +
> +	gpiod_set_value(ctx->reset, 0);
> +	msleep(20);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ili9881c_init); i++) {
> +		struct ili9881c_instr *instr =3D &ili9881c_init[i];
> +
> +		if (instr->op =3D=3D ILI9881C_SWITCH_PAGE)
> +			ret =3D ili9881c_switch_page(ctx, instr->arg.page);
> +		else if (instr->op =3D=3D ILI9881C_COMMAND)
> +			ret =3D ili9881c_send_cmd_data(ctx, instr->arg.cmd.cmd,
> +						      instr->arg.cmd.data);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D ili9881c_switch_page(ctx, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mipi_dsi_dcs_set_tear_on(ctx->dsi, MIPI_DSI_DCS_TEAR_MODE_VBLAN=
K);
> +	if (ret)
> +		return ret;
> +
> +	mipi_dsi_dcs_exit_sleep_mode(ctx->dsi);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int ili9881c_enable(struct drm_panel *panel)
> +{
> +	struct ili9881c *ctx =3D panel_to_ili9881c(panel);
> +
> +	msleep(120);
> +
> +	mipi_dsi_dcs_set_display_on(ctx->dsi);
> +	backlight_enable(ctx->backlight);
> +
> +	return 0;
> +}
> +
> +static int ili9881c_disable(struct drm_panel *panel)
> +{
> +	struct ili9881c *ctx =3D panel_to_ili9881c(panel);
> +
> +	backlight_disable(ctx->backlight);
> +	return mipi_dsi_dcs_set_display_off(ctx->dsi);
> +}
> +
> +static int ili9881c_unprepare(struct drm_panel *panel)
> +{
> +	struct ili9881c *ctx =3D panel_to_ili9881c(panel);
> +
> +	mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
> +	gpiod_set_value(ctx->power, 0);
> +	gpiod_set_value(ctx->reset, 1);
> +
> +	return 0;
> +}
> +
> +static const struct drm_display_mode default_mode =3D {
> +	.clock		=3D 62000,
> +	.vrefresh	=3D 60,
> +
> +	.hdisplay	=3D 720,
> +	.hsync_start	=3D 720 + 10,
> +	.hsync_end	=3D 720 + 10 + 20,
> +	.htotal		=3D 720 + 10 + 20 + 30,
> +
> +	.vdisplay	=3D 1280,
> +	.vsync_start	=3D 1280 + 10,
> +	.vsync_end	=3D 1280 + 10 + 10,
> +	.vtotal		=3D 1280 + 10 + 10 + 20,
> +};
> +
> +static int ili9881c_get_modes(struct drm_panel *panel)
> +{
> +	struct drm_connector *connector =3D panel->connector;
> +	struct ili9881c *ctx =3D panel_to_ili9881c(panel);
> +	struct drm_display_mode *mode;
> +
> +	mode =3D drm_mode_duplicate(panel->drm, &default_mode);
> +	if (!mode) {
> +		dev_err(&ctx->dsi->dev, "failed to add mode %ux%ux@%u\n",
> +			default_mode.hdisplay, default_mode.vdisplay,
> +			default_mode.vrefresh);
> +		return -ENOMEM;
> +	}
> +
> +	drm_mode_set_name(mode);
> +
> +	mode->type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +	drm_mode_probed_add(connector, mode);
> +
> +	panel->connector->display_info.width_mm =3D 62;
> +	panel->connector->display_info.height_mm =3D 110;
> +
> +	return 1;
> +}
> +
> +static const struct drm_panel_funcs ili9881c_funcs =3D {
> +	.prepare	=3D ili9881c_prepare,
> +	.unprepare	=3D ili9881c_unprepare,
> +	.enable		=3D ili9881c_enable,
> +	.disable	=3D ili9881c_disable,
> +	.get_modes	=3D ili9881c_get_modes,
> +};
> +
> +static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device_node *np;
> +	struct ili9881c *ctx;
> +	int ret;
> +
> +	ctx =3D devm_kzalloc(&dsi->dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +	mipi_dsi_set_drvdata(dsi, ctx);
> +	ctx->dsi =3D dsi;
> +
> +	drm_panel_init(&ctx->panel);
> +	ctx->panel.dev =3D &dsi->dev;
> +	ctx->panel.funcs =3D &ili9881c_funcs;
> +
> +	ctx->power =3D devm_gpiod_get(&dsi->dev, "power", GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->power)) {
> +		dev_err(&dsi->dev, "Couldn't get our power GPIO\n");
> +		return PTR_ERR(ctx->power);
> +	}
> +
> +	ctx->reset =3D devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->reset)) {
> +		dev_err(&dsi->dev, "Couldn't get our reset GPIO\n");
> +		return PTR_ERR(ctx->reset);
> +	}
> +
> +	np =3D of_parse_phandle(dsi->dev.of_node, "backlight", 0);
> +	if (np) {
> +		ctx->backlight =3D of_find_backlight_by_node(np);
> +		of_node_put(np);
> +
> +		if (!ctx->backlight)
> +			return -EPROBE_DEFER;
> +	}
> +
> +	ret =3D drm_panel_add(&ctx->panel);
> +	if (ret < 0)
> +		return ret;
> +
> +	dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
> +	dsi->format =3D MIPI_DSI_FMT_RGB888;
> +	dsi->lanes =3D 4;
> +
> +	return mipi_dsi_attach(dsi);
> +}
> +
> +static int ili9881c_dsi_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct ili9881c *ctx =3D mipi_dsi_get_drvdata(dsi);
> +
> +	mipi_dsi_detach(dsi);
> +	drm_panel_remove(&ctx->panel);
> +
> +	if (ctx->backlight)
> +		put_device(&ctx->backlight->dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ili9881c_of_match[] =3D {
> +	{ .compatible =3D "bananapi,lhr050h41" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ili9881c_of_match);
> +
> +static struct mipi_dsi_driver ili9881c_dsi_driver =3D {
> +	.probe		=3D ili9881c_dsi_probe,
> +	.remove		=3D ili9881c_dsi_remove,
> +	.driver =3D {
> +		.name		=3D "ili9881c-dsi",
> +		.of_match_table	=3D ili9881c_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(ili9881c_dsi_driver);
> +
> +MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
> +MODULE_DESCRIPTION("Ilitek ILI9881C Controller Driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> git-series 0.9.1

--CXFpZVxO6m2Ol4tQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrh6x4ACgkQ3SOs138+
s6FrBBAAkqICvkGPUUHPvv5EU/vidwSa7SPkxyHQWAZqtXr4lJqeDXxV6iHFJSsr
0EwYUJ4SHRxOWI8pl4o4R2KNCfk7iu8Nqdg5fie0Qp9zDGJNpcC6jm9wjNNT0Dat
4/v9mRnblKHbx3l5lTEet7wY++GBiD+n4EOG2GWDprHl0b9CiPF4sTbjb5AWa41z
yhe5nGdqwTp8zOhR1pLXsDT0R66Dd7UE4lwR6Aqa4xDUwefWjhM8EykawGFd1mF0
SSz3ZgGMA6Op6GZWA0ons70BwsmyHMpdijLob5jOwXr5SaarTLGbXsOALvW1eJ/v
7sovygfBcqJl16AArpZQFEH0HQw1YvcpYXfXTq6l8eQCACu0FOPI/24kbJipinT2
UooBjUUOMQ/4I+GTXju3iJwv9wKUhjMMSstJaTE+EDPH8qFWgn8aH4worGYv2dQ4
4Ig9z8OsqM2mqHhIz84VlmSz8H0cUcpm0az9egtmxxZOxtZuNpLUbbx5eUuFw6a2
6ZtN9NvJiiOh1BBI5zG7zk8iTTsQhdplroOI/Y+b+vxDAkcDO6U7bJMYptFzNvK3
5t+TvEQxHRkYb9Oh0gej5oazP6XU+NDwD2qsivXa8gMEF+T86Ij0S7kYl9SZL/nF
rS/7JAuD33scLkWQfvzKYhld8JPLcE03Slc+UE253zI3V+nX1kM=
=Pk5A
-----END PGP SIGNATURE-----

--CXFpZVxO6m2Ol4tQ--
