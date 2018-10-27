Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA66C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 16:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BB820843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 16:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BB820843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbeJ1Ayb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 20:54:31 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:46620 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbeJ1Ayb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 20:54:31 -0400
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:58866 helo=[192.168.10.175])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gGRCs-0008AI-Oh; Sat, 27 Oct 2018 18:12:58 +0200
Subject: Re: [PATCH 2/3] drm: Add an hx8367d tinydrm driver.
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20181024184313.2967-1-eric@anholt.net>
 <20181024184313.2967-3-eric@anholt.net>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <a3995168-3d9f-07b3-1e93-7ee5bd14e5a8@tronnes.org>
Date:   Sat, 27 Oct 2018 18:12:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181024184313.2967-3-eric@anholt.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 24.10.2018 20.43, skrev Eric Anholt:
> I want to sort out support for tinydrm in vc4, so I needed to get a
> tinydrm-appropriate panel working and this is what I had on hand.
> This is derived from a combination of ili9341.c from tinydrm and
> fb_hx8357d.c from staging's fbtft.  The register header is copied
> directly from staging's fbtft, on the assumption that we will delete
> that copy later.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>   MAINTAINERS                       |   7 +
>   drivers/gpu/drm/tinydrm/Kconfig   |  11 ++
>   drivers/gpu/drm/tinydrm/Makefile  |   1 +
>   drivers/gpu/drm/tinydrm/hx8357d.c | 261 ++++++++++++++++++++++++++++++
>   drivers/gpu/drm/tinydrm/hx8357d.h |  71 ++++++++
>   5 files changed, 351 insertions(+)
>   create mode 100644 drivers/gpu/drm/tinydrm/hx8357d.c
>   create mode 100644 drivers/gpu/drm/tinydrm/hx8357d.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 39c3f6682ace..e78971e20a11 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4623,6 +4623,13 @@ S:	Maintained
>   F:	drivers/gpu/drm/tinydrm/ili9225.c
>   F:	Documentation/devicetree/bindings/display/ilitek,ili9225.txt
>   
> +DRM DRIVER FOR HX8357D PANELS
> +M:	Eric Anholt <eric@anholt.net>
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +S:	Maintained
> +F:	drivers/gpu/drm/tinydrm/hx8357d.c
> +F:	Documentation/devicetree/bindings/display/himax,hx8357d.txt
> +
>   DRM DRIVER FOR INTEL I810 VIDEO CARDS
>   S:	Orphan / Obsolete
>   F:	drivers/gpu/drm/i810/
> diff --git a/drivers/gpu/drm/tinydrm/Kconfig b/drivers/gpu/drm/tinydrm/Kconfig
> index 16f4b5c91f1b..2c408ac1a900 100644
> --- a/drivers/gpu/drm/tinydrm/Kconfig
> +++ b/drivers/gpu/drm/tinydrm/Kconfig
> @@ -10,6 +10,17 @@ menuconfig DRM_TINYDRM
>   config TINYDRM_MIPI_DBI
>   	tristate
>   
> +config TINYDRM_HX8357D
> +	tristate "DRM support for HX8357D display panels"
> +	depends on DRM_TINYDRM && SPI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	select TINYDRM_MIPI_DBI
> +	help
> +	  DRM driver for the following HX8357D panels:
> +	  * YX350HV15-T 3.5" 340x350 TFT (Adafruit 3.5")
> +
> +	  If M is selected the module will be called hx8357d.
> +
>   config TINYDRM_ILI9225
>   	tristate "DRM support for ILI9225 display panels"
>   	depends on DRM_TINYDRM && SPI
> diff --git a/drivers/gpu/drm/tinydrm/Makefile b/drivers/gpu/drm/tinydrm/Makefile
> index 14d99080665a..f823066f7743 100644
> --- a/drivers/gpu/drm/tinydrm/Makefile
> +++ b/drivers/gpu/drm/tinydrm/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_DRM_TINYDRM)		+= core/
>   obj-$(CONFIG_TINYDRM_MIPI_DBI)		+= mipi-dbi.o
>   
>   # Displays
> +obj-$(CONFIG_TINYDRM_HX8357D)		+= hx8357d.o
>   obj-$(CONFIG_TINYDRM_ILI9225)		+= ili9225.o
>   obj-$(CONFIG_TINYDRM_ILI9341)		+= ili9341.o
>   obj-$(CONFIG_TINYDRM_MI0283QT)		+= mi0283qt.o
> diff --git a/drivers/gpu/drm/tinydrm/hx8357d.c b/drivers/gpu/drm/tinydrm/hx8357d.c
> new file mode 100644
> index 000000000000..51d4da624d57
> --- /dev/null
> +++ b/drivers/gpu/drm/tinydrm/hx8357d.c
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * DRM driver for the HX8357D LCD controller
> + *
> + * Copyright 2018 Broadcom
> + * Copyright 2018 David Lechner <david@lechnology.com>
> + * Copyright 2016 Noralf Trønnes
> + * Copyright (C) 2015 Adafruit Industries
> + * Copyright (C) 2013 Christian Vogelgsang
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/spi/spi.h>
> +
> +#include <drm/drm_fb_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_modeset_helper.h>
> +#include <drm/tinydrm/mipi-dbi.h>
> +#include <drm/tinydrm/tinydrm-helpers.h>
> +#include <video/mipi_display.h>
> +#include "hx8357d.h"

I prefer to have the defines in the driver instead of an extra header file.
The reason is that usually only a handful of defines are actually used,
in this case it's 9.

> +
> +#define HX8357D_MADCTL_MY  0x80
> +#define HX8357D_MADCTL_MX  0x40
> +#define HX8357D_MADCTL_MV  0x20
> +#define HX8357D_MADCTL_ML  0x10
> +#define HX8357D_MADCTL_RGB 0x00
> +#define HX8357D_MADCTL_BGR 0x08
> +#define HX8357D_MADCTL_MH  0x04
> +
> +static void yx240qv29_enable(struct drm_simple_display_pipe *pipe,
> +			     struct drm_crtc_state *crtc_state,
> +			     struct drm_plane_state *plane_state)
> +{
> +	struct tinydrm_device *tdev = pipe_to_tinydrm(pipe);
> +	struct mipi_dbi *mipi = mipi_dbi_from_tinydrm(tdev);
> +	u8 addr_mode;
> +	int ret;
> +
> +	DRM_DEBUG_KMS("\n");
> +
> +	ret = mipi_dbi_poweron_conditional_reset(mipi);
> +	if (ret < 0)
> +		return;
> +	if (ret == 1)
> +		goto out_enable;
> +
> +	/* setextc */
> +	mipi_dbi_command(mipi, HX8357D_SETC, 0xFF, 0x83, 0x57);
> +	msleep(150);
> +
> +	/* setRGB which also enables SDO */
> +	mipi_dbi_command(mipi, HX8357_SETRGB, 0x00, 0x00, 0x06, 0x06);
> +
> +	/* -1.52V */
> +	mipi_dbi_command(mipi, HX8357D_SETCOM, 0x25);
> +
> +	/* Normal mode 70Hz, Idle mode 55 Hz */
> +	mipi_dbi_command(mipi, HX8357_SETOSC, 0x68);
> +
> +	/* Set Panel - BGR, Gate direction swapped */
> +	mipi_dbi_command(mipi, HX8357_SETPANEL, 0x05);
> +
> +	mipi_dbi_command(mipi, HX8357_SETPWR1,
> +			 0x00,  /* Not deep standby */
> +			 0x15,  /* BT */
> +			 0x1C,  /* VSPR */
> +			 0x1C,  /* VSNR */
> +			 0x83,  /* AP */
> +			 0xAA);  /* FS */
> +
> +	mipi_dbi_command(mipi, HX8357D_SETSTBA,
> +			 0x50,  /* OPON normal */
> +			 0x50,  /* OPON idle */
> +			 0x01,  /* STBA */
> +			 0x3C,  /* STBA */
> +			 0x1E,  /* STBA */
> +			 0x08);  /* GEN */
> +
> +	mipi_dbi_command(mipi, HX8357D_SETCYC,
> +			 0x02,  /* NW 0x02 */
> +			 0x40,  /* RTN */
> +			 0x00,  /* DIV */
> +			 0x2A,  /* DUM */
> +			 0x2A,  /* DUM */
> +			 0x0D,  /* GDON */
> +			 0x78);  /* GDOFF */
> +
> +	mipi_dbi_command(mipi, HX8357D_SETGAMMA,
> +			 0x02,
> +			 0x0A,
> +			 0x11,
> +			 0x1d,
> +			 0x23,
> +			 0x35,
> +			 0x41,
> +			 0x4b,
> +			 0x4b,
> +			 0x42,
> +			 0x3A,
> +			 0x27,
> +			 0x1B,
> +			 0x08,
> +			 0x09,
> +			 0x03,
> +			 0x02,
> +			 0x0A,
> +			 0x11,
> +			 0x1d,
> +			 0x23,
> +			 0x35,
> +			 0x41,
> +			 0x4b,
> +			 0x4b,
> +			 0x42,
> +			 0x3A,
> +			 0x27,
> +			 0x1B,
> +			 0x08,
> +			 0x09,
> +			 0x03,
> +			 0x00,
> +			 0x01);
> +
> +	/* 16 bit */
> +	mipi_dbi_command(mipi, MIPI_DCS_SET_PIXEL_FORMAT,
> +			 MIPI_DCS_PIXEL_FMT_16BIT);
> +
> +	/* TE off */
> +	mipi_dbi_command(mipi, MIPI_DCS_SET_TEAR_ON, 0x00);
> +
> +	/* tear line */
> +	mipi_dbi_command(mipi, MIPI_DCS_SET_TEAR_SCANLINE, 0x00, 0x02);
> +
> +	/* Exit Sleep */
> +	mipi_dbi_command(mipi, MIPI_DCS_EXIT_SLEEP_MODE);
> +	msleep(150);
> +
> +	/* display on */
> +	mipi_dbi_command(mipi, MIPI_DCS_SET_DISPLAY_ON);
> +	usleep_range(5000, 7000);
> +
> +out_enable:
> +	switch (mipi->rotation) {
> +	default:
> +		addr_mode = HX8357D_MADCTL_MX | HX8357D_MADCTL_MY;
> +		break;
> +	case 90:
> +		addr_mode = HX8357D_MADCTL_MV | HX8357D_MADCTL_MY;
> +		break;
> +	case 180:
> +		addr_mode = 0;
> +		break;
> +	case 270:
> +		addr_mode = HX8357D_MADCTL_MV | HX8357D_MADCTL_MX;
> +		break;
> +	}
> +	mipi_dbi_command(mipi, MIPI_DCS_SET_ADDRESS_MODE, addr_mode);
> +	mipi_dbi_enable_flush(mipi, crtc_state, plane_state);
> +}
> +
> +static const struct drm_simple_display_pipe_funcs hx8357d_pipe_funcs = {
> +	.enable = yx240qv29_enable,
> +	.disable = mipi_dbi_pipe_disable,
> +	.update = tinydrm_display_pipe_update,
> +	.prepare_fb = drm_gem_fb_simple_display_pipe_prepare_fb,
> +};
> +
> +static const struct drm_display_mode yx350hv15_mode = {
> +	TINYDRM_MODE(320, 480, 60, 75),
> +};
> +
> +DEFINE_DRM_GEM_CMA_FOPS(hx8357d_fops);
> +
> +static struct drm_driver hx8357d_driver = {
> +	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME | DRIVER_ATOMIC,
> +	.fops			= &hx8357d_fops,
> +	TINYDRM_GEM_DRIVER_OPS,
> +	.debugfs_init		= mipi_dbi_debugfs_init,
> +	.name			= "hx8357d",
> +	.desc			= "HX8357D",
> +	.date			= "20181023",
> +	.major			= 1,
> +	.minor			= 0,
> +};
> +
> +static const struct of_device_id hx8357d_of_match[] = {
> +	{ .compatible = "adafruit,yx350hv15" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, hx8357d_of_match);
> +
> +static const struct spi_device_id hx8357d_id[] = {
> +	{ "hx8357d", 0 },

Last time I tried, module autoloading didn't work unless this contains
the last part of the compatible. In this case: "yx350hv15".
Have you checked that autoloading does work?

Otherwise this looks good:
Reviewed-by: Noralf Trønnes <noralf@tronnes.org>

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, hx8357d_id);
> +
> +static int hx8357d_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct mipi_dbi *mipi;
> +	struct gpio_desc *dc;
> +	u32 rotation = 0;
> +	int ret;
> +
> +	mipi = devm_kzalloc(dev, sizeof(*mipi), GFP_KERNEL);
> +	if (!mipi)
> +		return -ENOMEM;
> +
> +	dc = devm_gpiod_get(dev, "dc", GPIOD_OUT_LOW);
> +	if (IS_ERR(dc)) {
> +		DRM_DEV_ERROR(dev, "Failed to get gpio 'dc'\n");
> +		return PTR_ERR(dc);
> +	}
> +
> +	mipi->backlight = devm_of_find_backlight(dev);
> +	if (IS_ERR(mipi->backlight))
> +		return PTR_ERR(mipi->backlight);
> +
> +	device_property_read_u32(dev, "rotation", &rotation);
> +
> +	ret = mipi_dbi_spi_init(spi, mipi, dc);
> +	if (ret)
> +		return ret;
> +
> +	ret = mipi_dbi_init(&spi->dev, mipi, &hx8357d_pipe_funcs,
> +			    &hx8357d_driver, &yx350hv15_mode, rotation);
> +	if (ret)
> +		return ret;
> +
> +	spi_set_drvdata(spi, mipi);
> +
> +	return devm_tinydrm_register(&mipi->tinydrm);
> +}
> +
> +static void hx8357d_shutdown(struct spi_device *spi)
> +{
> +	struct mipi_dbi *mipi = spi_get_drvdata(spi);
> +
> +	tinydrm_shutdown(&mipi->tinydrm);
> +}
> +
> +static struct spi_driver hx8357d_spi_driver = {
> +	.driver = {
> +		.name = "hx8357d",
> +		.of_match_table = hx8357d_of_match,
> +	},
> +	.id_table = hx8357d_id,
> +	.probe = hx8357d_probe,
> +	.shutdown = hx8357d_shutdown,
> +};
> +module_spi_driver(hx8357d_spi_driver);
> +
> +MODULE_DESCRIPTION("HX8357D DRM driver");
> +MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/gpu/drm/tinydrm/hx8357d.h b/drivers/gpu/drm/tinydrm/hx8357d.h
> new file mode 100644
> index 000000000000..6180b093f94f
> --- /dev/null
> +++ b/drivers/gpu/drm/tinydrm/hx8357d.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * This is our library for the Adafruit  ILI9341 Breakout and Shield
> + * ----> http://www.adafruit.com/products/1651
> + *
> + * Check out the links above for our tutorials and wiring diagrams
> + * These displays use SPI to communicate, 4 or 5 pins are required to
> + * interface (RST is optional)
> + * Adafruit invests time and resources providing this open source code,
> + * please support Adafruit and open-source hardware by purchasing
> + * products from Adafruit!
> + *
> + * Written by Limor Fried/Ladyada for Adafruit Industries.
> + * MIT license, all text above must be included in any redistribution
> + */
> +
> +#ifndef __HX8357_H__
> +#define __HX8357_H__
> +
> +#define HX8357D 0xD
> +#define HX8357B 0xB
> +
> +#define HX8357_TFTWIDTH  320
> +#define HX8357_TFTHEIGHT 480
> +
> +#define HX8357_SETOSC 0xB0
> +#define HX8357_SETPWR1 0xB1
> +#define HX8357B_SETDISPLAY 0xB2
> +#define HX8357_SETRGB 0xB3
> +#define HX8357D_SETCOM  0xB6
> +
> +#define HX8357B_SETDISPMODE  0xB4
> +#define HX8357D_SETCYC  0xB4
> +#define HX8357B_SETOTP 0xB7
> +#define HX8357D_SETC 0xB9
> +
> +#define HX8357B_SET_PANEL_DRIVING 0xC0
> +#define HX8357D_SETSTBA 0xC0
> +#define HX8357B_SETDGC  0xC1
> +#define HX8357B_SETID  0xC3
> +#define HX8357B_SETDDB  0xC4
> +#define HX8357B_SETDISPLAYFRAME 0xC5
> +#define HX8357B_GAMMASET 0xC8
> +#define HX8357B_SETCABC  0xC9
> +#define HX8357_SETPANEL  0xCC
> +
> +#define HX8357B_SETPOWER 0xD0
> +#define HX8357B_SETVCOM 0xD1
> +#define HX8357B_SETPWRNORMAL 0xD2
> +
> +#define HX8357B_RDID1   0xDA
> +#define HX8357B_RDID2   0xDB
> +#define HX8357B_RDID3   0xDC
> +#define HX8357B_RDID4   0xDD
> +
> +#define HX8357D_SETGAMMA 0xE0
> +
> +#define HX8357B_SETGAMMA 0xC8
> +#define HX8357B_SETPANELRELATED  0xE9
> +
> +/* Color definitions */
> +#define	HX8357_BLACK   0x0000
> +#define	HX8357_BLUE    0x001F
> +#define	HX8357_RED     0xF800
> +#define	HX8357_GREEN   0x07E0
> +#define HX8357_CYAN    0x07FF
> +#define HX8357_MAGENTA 0xF81F
> +#define HX8357_YELLOW  0xFFE0
> +#define HX8357_WHITE   0xFFFF
> +
> +#endif /* __HX8357_H__ */

