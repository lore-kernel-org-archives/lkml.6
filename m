Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4101C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F56F218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfAZVmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 16:42:02 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:47044 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfAZVmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 16:42:02 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id EFBDB803BF;
        Sat, 26 Jan 2019 22:41:51 +0100 (CET)
Date:   Sat, 26 Jan 2019 22:41:49 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     thierry.reding@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com
Subject: Re: [PATCH 2/2] drm/panel: Add driver for Samsung S6E63M0 panel
Message-ID: <20190126214149.GB31182@ravnborg.org>
References: <20190125164645.19208-1-pawel.mikolaj.chmiel@gmail.com>
 <20190125164645.19208-2-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190125164645.19208-2-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=hD80L64hAAAA:8
        a=NejAcOUxEScyh1-lJzoA:9 a=QEXdDO2ut3YA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel.

Thanks for this nice patch too.

Comment follows and you need to judge what to follow.
The timing part will not be commented as this was covered in
feedback on the binding.

Using a sysfs file to select the gamma mode looks like a local hack.
Someone with more drm knowledge needs comment on that.


On Fri, Jan 25, 2019 at 05:46:45PM +0100, Paweł Chmiel wrote:
> This patch adds Samsung S6E63M0 AMOLED LCD panel driver, connected over
> spi. It's based on already removed, non dt s6e63m0 driver and
> panel-samsung-ld9040. There is possibility to choose one from 3
> different gamma tables.
> It can be found for example in some of Samsung Aries based phones.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |   7 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  drivers/gpu/drm/panel/panel-samsung-s6e63m0.c | 712 ++++++++++++++++++
>  3 files changed, 720 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> new file mode 100644
> index 000000000000..cb5c090621ad
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> @@ -0,0 +1,712 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * S6E63M0 AMOLED LCD drm_panel driver.
> + *
> + * Copyright (C) 2019 Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> + * Derived from drivers/gpu/drm/panel-samsung-ld9040.c
> + *
> + * Andrzej Hajda <a.hajda@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_panel.h>
For new drivers please do not use drmP.h, we are working
on gettting rid of it.
The list is sorted in alphabetical order - good.
> +
> +#include <linux/backlight.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#include <video/mipi_display.h>
> +#include <video/of_videomode.h>
> +#include <video/videomode.h>
> +
> +/* Manufacturer Command Set */
> +#define MCS_STAND_BY_OFF                0x11
> +#define MCS_DISPLAY_ON                  0x29
> +#define MCS_ELVSS_ON                0xb1
> +#define MCS_ACL_CTRL                0xc0
> +#define MCS_DISPLAY_CONDITION   0xf2
> +#define MCS_ETC_CONDITION           0xf6
> +#define MCS_PANEL_CONDITION         0xF8
> +#define MCS_GAMMA_CTRL              0xfa
> +
> +#define MAX_GAMMA_LEVEL             11
> +#define GAMMA_TABLE_COUNT           23
> +
> +#define MAX_BRIGHTNESS              (MAX_GAMMA_LEVEL - 1)
> +#define GAMMA_MODE_22               0
> +#define GAMMA_MODE_19               1
> +#define GAMMA_MODE_17               2
> +
> +/* array of gamma tables for gamma value 2.2 */
> +static u8 const s6e63m0_gamma_19[MAX_GAMMA_LEVEL][GAMMA_TABLE_COUNT] = {
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x84, 0x45, 0x4F, 0xCA,
> +	  0xCB, 0xBC, 0xC9, 0xCB, 0xBC, 0xDA, 0xDA,
> +	  0xD0, 0x00, 0x35, 0x00, 0x34, 0x00, 0x4E },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x74, 0x60, 0x4A, 0xC3,
> +	  0xC6, 0xB5, 0xBF, 0xC3, 0xB2, 0xD2, 0xD3,
> +	  0xC8, 0x00, 0x5B, 0x00, 0x5B, 0x00, 0x81 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x6F, 0x65, 0x46, 0xC2,
> +	  0xC4, 0xB3, 0xBF, 0xC2, 0xB2, 0xCF, 0xD1,
> +	  0xC6, 0x00, 0x64, 0x00, 0x64, 0x00, 0x8D },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x6E, 0x65, 0x45, 0xC0,
> +	  0xC3, 0xB2, 0xBA, 0xBE, 0xAE, 0xCD, 0xD0,
> +	  0xC4, 0x00, 0x70, 0x00, 0x70, 0x00, 0x9C },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x69, 0x64, 0x40, 0xBF,
> +	  0xC1, 0xB0, 0xB9, 0xBE, 0xAD, 0xCB, 0xCD,
> +	  0xC2, 0x00, 0x7A, 0x00, 0x7B, 0x00, 0xAA },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x68, 0x64, 0x3F, 0xBE,
> +	  0xC0, 0xB0, 0xB6, 0xBB, 0xAB, 0xC8, 0xCB,
> +	  0xBF, 0x00, 0x85, 0x00, 0x86, 0x00, 0xB8 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x68, 0x64, 0x40, 0xBC,
> +	  0xBF, 0xAF, 0xB4, 0xBA, 0xA9, 0xC8, 0xCA,
> +	  0xBE, 0x00, 0x8B, 0x00, 0x8C, 0x00, 0xC0 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x67, 0x64, 0x3F, 0xBB,
> +	  0xBE, 0xAD, 0xB3, 0xB9, 0xA7, 0xC8, 0xC9,
> +	  0xBE, 0x00, 0x90, 0x00, 0x92, 0x00, 0xC8 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x63, 0x61, 0x3B, 0xBA,
> +	  0xBE, 0xAC, 0xB3, 0xB8, 0xA7, 0xC6, 0xC8,
> +	  0xBD, 0x00, 0x96, 0x00, 0x98, 0x00, 0xCF },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x61, 0x60, 0x39, 0xBB,
> +	  0xBE, 0xAD, 0xB2, 0xB6, 0xA6, 0xC5, 0xC7,
> +	  0xBD, 0x00, 0x9B, 0x00, 0x9E, 0x00, 0xD5 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x61, 0x5F, 0x39, 0xBA,
> +	  0xBD, 0xAD, 0xB1, 0xB6, 0xA5, 0xC4, 0xC5,
> +	  0xBC, 0x00, 0xA0, 0x00, 0xA4, 0x00, 0xDB },
> +};
> +
> +/* array of gamma tables for gamma value 1.7 */
> +static u8 const s6e63m0_gamma_17[MAX_GAMMA_LEVEL][GAMMA_TABLE_COUNT] = {
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x8F, 0x73, 0x63, 0xD1,
> +	  0xD0, 0xC5, 0xCC, 0xD1, 0xC2, 0xDE, 0xE0,
> +	  0xD6, 0x00, 0x39, 0x00, 0x36, 0x00, 0x51 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x82, 0x7A, 0x5B, 0xC8,
> +	  0xCB, 0xBD, 0xC5, 0xCA, 0xBA, 0xD6, 0xD8,
> +	  0xCE, 0x00, 0x5D, 0x00, 0x5E, 0x00, 0x82 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x81, 0x7B, 0x5D, 0xC6,
> +	  0xCA, 0xBB, 0xC3, 0xC7, 0xB8, 0xD6, 0xD8,
> +	  0xCD, 0x00, 0x65, 0x00, 0x67, 0x00, 0x8D },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x7B, 0x77, 0x58, 0xC3,
> +	  0xC8, 0xB8, 0xC2, 0xC6, 0xB6, 0xD3, 0xD4,
> +	  0xCA, 0x00, 0x71, 0x00, 0x73, 0x00, 0x9E },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x75, 0x77, 0x54, 0xC3,
> +	  0xC7, 0xB7, 0xC0, 0xC3, 0xB4, 0xD1, 0xD3,
> +	  0xC9, 0x00, 0x7B, 0x00, 0x7E, 0x00, 0xAB },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x72, 0x75, 0x51, 0xC2,
> +	  0xC6, 0xB5, 0xBF, 0xC1, 0xB3, 0xCE, 0xD1,
> +	  0xC6, 0x00, 0x85, 0x00, 0x88, 0x00, 0xBA },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x71, 0x73, 0x4F, 0xC2,
> +	  0xC5, 0xB5, 0xBD, 0xC0, 0xB2, 0xCD, 0xD1,
> +	  0xC5, 0x00, 0x8B, 0x00, 0x8E, 0x00, 0xC2 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x71, 0x72, 0x4F, 0xC2,
> +	  0xC4, 0xB5, 0xBB, 0xBF, 0xB0, 0xCC, 0xCF,
> +	  0xC3, 0x00, 0x91, 0x00, 0x95, 0x00, 0xCA },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x72, 0x72, 0x50, 0xC0,
> +	  0xC3, 0xB4, 0xB9, 0xBE, 0xAE, 0xCC, 0xCF,
> +	  0xC4, 0x00, 0x97, 0x00, 0x9A, 0x00, 0xD1 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x71, 0x71, 0x50, 0xBF,
> +	  0xC2, 0xB2, 0xBA, 0xBE, 0xAE, 0xCB, 0xCD,
> +	  0xC3, 0x00, 0x9C, 0x00, 0x9F, 0x00, 0xD6 },
> +	{ MCS_GAMMA_CTRL, 0x00,
> +	  0x18, 0x08, 0x24, 0x70, 0x70, 0x4F, 0xBF,
> +	  0xC2, 0xB2, 0xB8, 0xBC, 0xAC, 0xCB, 0xCD,
> +	  0xC3, 0x00, 0xA0, 0x00, 0xA4, 0x00, 0xDB },
> +};
All the gama entries starts with:
MCS_GAMMA_CTRL, 0x00, 0x18, 0x08, 0x24,

That could be documented using a #define but taht may also
confuse.


> +
> +#define S6E63M0_STATE_BIT_ENABLED       0

Please use BIT(0) here as it is a bit that is pointed out.

> +
> +struct s6e63m0 {
> +	struct device *dev;
> +	struct drm_panel panel;
> +
> +	struct regulator_bulk_data supplies[2];
> +	struct gpio_desc *reset_gpio;
> +	u32 power_on_delay;
> +	u32 power_off_delay;
> +	u32 reset_delay;
> +	struct videomode vm;
> +	u32 width_mm;
> +	u32 height_mm;
> +
> +	unsigned long state;
> +	unsigned int gamma_mode;
> +	int brightness;
> +
> +	/* This field is tested by functions directly accessing bus before
> +	 * transfer, transfer is skipped if it is set. In case of transfer
> +	 * failure or unexpected response the field is set to error value.
> +	 * Such construct allows to eliminate many checks in higher level
> +	 * functions.
> +	 */
kernel style require that multi line comments starts with
	/*
	 * Here goes blah blah.

> +	int error;
> +};
> +
> +static inline struct s6e63m0 *panel_to_s6e63m0(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct s6e63m0, panel);
> +}
> +
> +static int s6e63m0_clear_error(struct s6e63m0 *ctx)
> +{
> +	int ret = ctx->error;
> +
> +	ctx->error = 0;
> +	return ret;
> +}
> +
> +static int s6e63m0_spi_write_word(struct s6e63m0 *ctx, u16 data)
> +{
> +	struct spi_device *spi = to_spi_device(ctx->dev);
> +	struct spi_transfer xfer = {
> +		.len	= 2,
> +		.tx_buf = &data,
> +	};
> +	struct spi_message msg;
> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfer, &msg);
> +
> +	return spi_sync(spi, &msg);
> +}
> +
> +static void s6e63m0_dcs_write(struct s6e63m0 *ctx, const u8 *data, size_t len)
> +{
> +	int ret = 0;
> +
> +	if (ctx->error < 0 || len == 0)
> +		return;
> +
> +	dev_dbg(ctx->dev, "writing dcs seq: %*ph\n", (int)len, data);
Use DRM_DEV_ERROR() to be consistent with the DRM subsystem.
General comment that goes for all uses of dev_xxx().

> +	ret = s6e63m0_spi_write_word(ctx, *data);
> +
> +	while (!ret && --len) {
> +		++data;
> +		ret = s6e63m0_spi_write_word(ctx, *data | 0x100);
Consider a constant for the today hardcoded 0x100

> +	}
> +
> +	if (ret) {
> +		dev_err(ctx->dev, "error %d writing dcs seq: %*ph\n", ret,
> +			(int)len, data);
> +		ctx->error = ret;
> +	}
> +
> +	usleep_range(300, 310);
> +}
> +
> +#define s6e63m0_dcs_write_seq_static(ctx, seq ...) \
> +	({ \
> +		static const u8 d[] = { seq }; \
> +		s6e63m0_dcs_write(ctx, d, ARRAY_SIZE(d)); \
> +	})
> +
> +static void s6e63m0_brightness_set(struct s6e63m0 *ctx)
> +{
> +	/* disable and set new gamma */
> +	switch (ctx->gamma_mode) {
> +	case GAMMA_MODE_22:
> +		s6e63m0_dcs_write(ctx,
> +				  s6e63m0_gamma_22[ctx->brightness],
> +				  ARRAY_SIZE(s6e63m0_gamma_22[ctx->brightness])
> +				  );
> +		break;
> +	case GAMMA_MODE_19:
> +		s6e63m0_dcs_write(ctx,
> +				  s6e63m0_gamma_19[ctx->brightness],
> +				  ARRAY_SIZE(s6e63m0_gamma_19[ctx->brightness])
> +				  );
> +		break;
> +	case GAMMA_MODE_17:
> +		s6e63m0_dcs_write(ctx,
> +				  s6e63m0_gamma_17[ctx->brightness],
> +				  ARRAY_SIZE(s6e63m0_gamma_17[ctx->brightness])
> +				  );
> +		break;
> +	default:
> +		dev_info(ctx->dev,
> +			 "gamma mode could be 0:2.2, 1:1.9 or 2:1.7.Assuming 2.2\n"
> +			 );
> +		s6e63m0_dcs_write(ctx,
> +				  s6e63m0_gamma_22[ctx->brightness],
> +				  ARRAY_SIZE(s6e63m0_gamma_22[ctx->brightness])
> +				  );
> +		break;
> +	}
Do something like:

	u8 *tbl;
	size_t len;

	case GAMMA_MODE_22:
		tbl = s6e63m0_gamma_22[ctx->brightness];
		len = ARRAY_SIZE(s6e63m0_gamma_22[ctx->brightness];
		break;
	case GAMMA_MODE_19:
		...
	}

	s6e63m0_dcs_write(ctx, tbl, len);


Improves readability, same function.

> +
> +	/* update gamma table. */
> +	s6e63m0_dcs_write_seq_static(ctx, MCS_GAMMA_CTRL, 0x01);
> +}
> +
> +static void s6e63m0_init(struct s6e63m0 *ctx)
> +{
> +	s6e63m0_dcs_write_seq_static(ctx, MCS_PANEL_CONDITION,
> +				     0x01, 0x27, 0x27, 0x07, 0x07, 0x54, 0x9f,
> +				     0x63, 0x86, 0x1a, 0x33, 0x0d, 0x00, 0x00);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, MCS_DISPLAY_CONDITION,
> +				     0x02, 0x03, 0x1c, 0x10, 0x10);
> +	s6e63m0_dcs_write_seq_static(ctx, 0xf7,
> +				     0x03, 0x00, 0x00);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, MCS_GAMMA_CTRL,
> +				     0x00, 0x18, 0x08, 0x24, 0x64, 0x56, 0x33,
> +				     0xb6, 0xba, 0xa8, 0xac, 0xb1, 0x9d, 0xc1,
> +				     0xc1, 0xb7, 0x00, 0x9c, 0x00, 0x9f, 0x00,
> +				     0xd6);
> +	s6e63m0_dcs_write_seq_static(ctx, MCS_GAMMA_CTRL,
> +				     0x01);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, MCS_ETC_CONDITION,
> +				     0x00, 0x8c, 0x07);
> +	s6e63m0_dcs_write_seq_static(ctx, 0xb3,
> +				     0xc);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, 0xb5,
> +				     0x2c, 0x12, 0x0c, 0x0a, 0x10, 0x0e, 0x17,
> +				     0x13, 0x1f, 0x1a, 0x2a, 0x24, 0x1f, 0x1b,
> +				     0x1a, 0x17, 0x2b, 0x26, 0x22, 0x20, 0x3a,
> +				     0x34, 0x30, 0x2c, 0x29, 0x26, 0x25, 0x23,
> +				     0x21, 0x20, 0x1e, 0x1e);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, 0xb6,
> +				     0x00, 0x00, 0x11, 0x22, 0x33, 0x44, 0x44,
> +				     0x44, 0x55, 0x55, 0x66, 0x66, 0x66, 0x66,
> +				     0x66, 0x66);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, 0xb7,
> +				     0x2c, 0x12, 0x0c, 0x0a, 0x10, 0x0e, 0x17,
> +				     0x13, 0x1f, 0x1a, 0x2a, 0x24, 0x1f, 0x1b,
> +				     0x1a, 0x17, 0x2b, 0x26, 0x22, 0x20, 0x3a,
> +				     0x34, 0x30, 0x2c, 0x29, 0x26, 0x25, 0x23,
> +				     0x21, 0x20, 0x1e, 0x1e, 0x00, 0x00, 0x11,
> +				     0x22, 0x33, 0x44, 0x44, 0x44, 0x55, 0x55,
> +				     0x66, 0x66, 0x66, 0x66, 0x66, 0x66);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, 0xb9,
> +				     0x2c, 0x12, 0x0c, 0x0a, 0x10, 0x0e, 0x17,
> +				     0x13, 0x1f, 0x1a, 0x2a, 0x24, 0x1f, 0x1b,
> +				     0x1a, 0x17, 0x2b, 0x26, 0x22, 0x20, 0x3a,
> +				     0x34, 0x30, 0x2c, 0x29, 0x26, 0x25, 0x23,
> +				     0x21, 0x20, 0x1e, 0x1e);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, 0xba,
> +				     0x00, 0x00, 0x11, 0x22, 0x33, 0x44, 0x44,
> +				     0x44, 0x55, 0x55, 0x66, 0x66, 0x66, 0x66,
> +				     0x66, 0x66);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, 0xc1,
> +				     0x4d, 0x96, 0x1d, 0x00, 0x00, 0x01, 0xdf,
> +				     0x00, 0x00, 0x03, 0x1f, 0x00, 0x00, 0x00,
> +				     0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x06,
> +				     0x09, 0x0d, 0x0f, 0x12, 0x15, 0x18);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, 0xb2,
> +				     0x10, 0x10, 0x0b, 0x05);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, MCS_ACL_CTRL,
> +				     0x01);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, MCS_ELVSS_ON,
> +				     0x0b);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, MCS_STAND_BY_OFF);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, MCS_DISPLAY_ON);
> +
> +	s6e63m0_brightness_set(ctx);
> +}
> +
> +static int s6e63m0_power_on(struct s6e63m0 *ctx)
> +{
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +	if (ret < 0)
> +		return ret;
> +
> +	msleep(ctx->power_on_delay);
> +
> +	gpiod_set_value(ctx->reset_gpio, 1);
> +	msleep(ctx->reset_delay);
It should really not be required to set reset to '1' here.
If it is required then move it before power is turned on, so we avoid
the panel is starting up, reset and then starting up.

> +	gpiod_set_value(ctx->reset_gpio, 0);
> +	msleep(ctx->reset_delay);
> +
> +	return 0;
> +}
> +
> +static int s6e63m0_power_off(struct s6e63m0 *ctx)
> +{
> +	msleep(ctx->power_off_delay);
> +
> +	return regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +}
We deassert reset at power_on, so it suprises we do not assert reset here?

> +
> +static int s6e63m0_disable(struct drm_panel *panel)
> +{
> +	return 0;
> +}
Should you not turn brightness down here?
And turn off the display or go to sleep mode?

> +
> +static int s6e63m0_unprepare(struct drm_panel *panel)
> +{
> +	struct s6e63m0 *ctx = panel_to_s6e63m0(panel);
> +
> +	clear_bit(S6E63M0_STATE_BIT_ENABLED, &ctx->state);
> +
> +	s6e63m0_dcs_write_seq_static(ctx, MIPI_DCS_ENTER_SLEEP_MODE);
> +
> +	s6e63m0_clear_error(ctx);
> +
> +	return s6e63m0_power_off(ctx);
> +}
> +
> +static int s6e63m0_prepare(struct drm_panel *panel)
> +{
> +	struct s6e63m0 *ctx = panel_to_s6e63m0(panel);
> +	int ret;
> +
> +	ret = s6e63m0_power_on(ctx);
> +	if (ret < 0)
> +		return ret;
> +
> +	s6e63m0_init(ctx);
> +
> +	ret = s6e63m0_clear_error(ctx);
> +
> +	if (ret < 0)
> +		s6e63m0_unprepare(panel);
> +	else
> +		set_bit(S6E63M0_STATE_BIT_ENABLED, &ctx->state);
> +
> +	return ret;
> +}
> +
> +static int s6e63m0_enable(struct drm_panel *panel)
> +{
> +	return 0;
> +}
This looks like the right spot to turn on brightness
And to tunr on the display.

> +
> +static int s6e63m0_get_modes(struct drm_panel *panel)
> +{
> +	struct drm_connector *connector = panel->connector;
> +	struct s6e63m0 *ctx = panel_to_s6e63m0(panel);
> +	struct drm_display_mode *mode;
> +
> +	mode = drm_mode_create(connector->dev);
> +	if (!mode) {
> +		DRM_ERROR("failed to create a new display mode\n");
> +		return 0;
> +	}
> +
> +	drm_display_mode_from_videomode(&ctx->vm, mode);
> +	mode->width_mm = ctx->width_mm;
> +	mode->height_mm = ctx->height_mm;
> +	connector->display_info.width_mm = mode->width_mm;
> +	connector->display_info.height_mm = mode->height_mm;
> +
> +	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +	mode->flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC;
> +	drm_mode_probed_add(connector, mode);
> +
> +	return 1;
> +}
> +
> +static const struct drm_panel_funcs s6e63m0_drm_funcs = {
> +	.disable	= s6e63m0_disable,
> +	.unprepare	= s6e63m0_unprepare,
> +	.prepare	= s6e63m0_prepare,
> +	.enable		= s6e63m0_enable,
> +	.get_modes	= s6e63m0_get_modes,
> +};
> +
> +static int s6e63m0_get_brightness(struct backlight_device *bd)
> +{
> +	return bd->props.brightness;
> +}
> +
> +static int s6e63m0_set_brightness(struct backlight_device *bd)
> +{
> +	struct s6e63m0 *ctx = bl_get_data(bd);
> +
> +	bd->props.power = FB_BLANK_UNBLANK;
> +	if (ctx->brightness != bd->props.brightness) {
> +		ctx->brightness = bd->props.brightness;
> +		if (test_bit(S6E63M0_STATE_BIT_ENABLED, &ctx->state))
> +			s6e63m0_brightness_set(ctx);
> +	}
> +
> +	return s6e63m0_clear_error(ctx);
> +}
> +
> +static const struct backlight_ops s6e63m0_backlight_ops = {
> +	.get_brightness = s6e63m0_get_brightness,
> +	.update_status	= s6e63m0_set_brightness,
> +};
> +
> +static void s6e63m0_backlight_register(struct s6e63m0 *ctx)
> +{
> +	struct backlight_properties props = {
> +		.type		= BACKLIGHT_RAW,
> +		.brightness	= ctx->brightness,
> +		.max_brightness = MAX_BRIGHTNESS
> +	};
> +	struct device *dev = ctx->dev;
> +	struct backlight_device *bd;
> +
> +	bd = devm_backlight_device_register(dev, "panel", dev, ctx,
> +					    &s6e63m0_backlight_ops, &props);
> +	if (IS_ERR(bd))
> +		dev_err(dev, "error registering backlight device (%ld)\n",
> +			PTR_ERR(bd));
> +}
> +
> +
> +static ssize_t s6e63m0_sysfs_gamma_mode_show(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	struct s6e63m0 *ctx = dev_get_drvdata(dev);
> +	char temp[10];
> +
> +	switch (ctx->gamma_mode) {
> +	case GAMMA_MODE_22:
> +		sprintf(temp, "2.2 mode\n");
> +		strcat(buf, temp);
> +		break;
> +	case GAMMA_MODE_19:
> +		sprintf(temp, "1.9 mode\n");
> +		strcat(buf, temp);
> +		break;
> +	case GAMMA_MODE_17:
> +		sprintf(temp, "1.7 mode\n");
> +		strcat(buf, temp);
> +		break;
> +	default:
> +		dev_info(dev, "gamma mode could be 0:2.2, 1:1.9 or 2:1.7)n");
> +		break;
> +	}
> +
> +	return strlen(buf);
> +}
> +
> +static ssize_t s6e63m0_sysfs_gamma_mode_store(struct device *dev,
> +					      struct device_attribute *attr,
> +					      const char *buf, size_t len)
> +{
> +	struct s6e63m0 *ctx = dev_get_drvdata(dev);
> +	int rc;
> +
> +	rc = kstrtouint(buf, 0, &ctx->gamma_mode);
> +	if (rc < 0)
> +		return rc;
> +
> +	s6e63m0_brightness_set(ctx);
> +	return len;
> +}
> +
> +static DEVICE_ATTR(gamma_mode, 0644,
> +		   s6e63m0_sysfs_gamma_mode_show,
> +		   s6e63m0_sysfs_gamma_mode_store);

It looks like a local hack to use a sysfs file to select between
the different gamma modes.
Someone with more drm knowledge needs to comment if this is an OK way to do it.

> +
> +static int s6e63m0_parse_dt(struct s6e63m0 *ctx)
> +{
> +	struct device *dev = ctx->dev;
> +	struct device_node *np = dev->of_node;
> +	int ret;
> +
> +	ret = of_get_videomode(np, &ctx->vm, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = of_property_read_u32(np, "power-on-delay", &ctx->power_on_delay);
> +	if (ret) {
> +		dev_info(ctx->dev, "using default power-on-delay of 25ms");
> +		ctx->power_on_delay = 25;
> +	}
> +
> +	ret = of_property_read_u32(np, "power-off-delay",
> +				   &ctx->power_off_delay);
> +	if (ret) {
> +		dev_info(ctx->dev, "using default power-of-delay of 200ms");
> +		ctx->power_off_delay = 200;
> +	}
> +
> +	ret = of_property_read_u32(np, "reset-delay", &ctx->reset_delay);
> +	if (ret) {
> +		dev_info(ctx->dev, "using default reset-delay of 120ms");
> +		ctx->reset_delay = 120;
> +	}
> +
> +	of_property_read_u32(np, "panel-width-mm", &ctx->width_mm);
> +	of_property_read_u32(np, "panel-height-mm", &ctx->height_mm);
> +
> +	return 0;
> +}
> +
> +static int s6e63m0_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct s6e63m0 *ctx;
> +	int ret;
> +
> +	ctx = devm_kzalloc(dev, sizeof(struct s6e63m0), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	spi_set_drvdata(spi, ctx);
> +
> +	ctx->dev = dev;
> +	ctx->brightness = MAX_BRIGHTNESS;
> +	ctx->gamma_mode = GAMMA_MODE_22;
> +
> +	ret = s6e63m0_parse_dt(ctx);
> +	if (ret < 0)
> +		return ret;
> +
> +	ctx->supplies[0].supply = "vdd3";
> +	ctx->supplies[1].supply = "vci";
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
> +				      ctx->supplies);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get regulators: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->reset_gpio)) {
> +		dev_err(dev, "cannot get reset-gpios %ld\n",
> +			PTR_ERR(ctx->reset_gpio));
> +		return PTR_ERR(ctx->reset_gpio);
> +	}
> +
> +	spi->bits_per_word = 9;
> +	spi->mode = SPI_MODE_3;
> +	ret = spi_setup(spi);
> +	if (ret < 0) {
> +		dev_err(dev, "spi setup failed.\n");
> +		return ret;
> +	}
> +
> +	ret = device_create_file(dev, &dev_attr_gamma_mode);
> +	if (ret < 0)
> +		dev_err(dev, "failed to add sysfs entries\n");
> +
> +	drm_panel_init(&ctx->panel);
> +	ctx->panel.dev = dev;
> +	ctx->panel.funcs = &s6e63m0_drm_funcs;
> +
> +	ret = drm_panel_add(&ctx->panel);
> +	if (ret < 0)
> +		goto err_remove_file;
> +
> +	s6e63m0_backlight_register(ctx);
> +
> +	return 0;
> +
> +err_remove_file:
> +	device_remove_file(dev, &dev_attr_gamma_mode);
> +
> +	return ret;
> +}
> +
> +static int s6e63m0_remove(struct spi_device *spi)
> +{
> +	struct s6e63m0 *ctx = spi_get_drvdata(spi);
> +
> +	s6e63m0_power_off(ctx);
> +	drm_panel_remove(&ctx->panel);
> +	device_remove_file(ctx->dev, &dev_attr_gamma_mode);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id s6e63m0_of_match[] = {
> +	{ .compatible = "samsung,s6e63m0" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, s6e63m0_of_match);
> +
> +static struct spi_driver s6e63m0_driver = {
> +	.probe			= s6e63m0_probe,
> +	.remove			= s6e63m0_remove,
> +	.driver			= {
> +		.name		= "panel-samsung-s6e63m0",
> +		.of_match_table = s6e63m0_of_match,
> +	},
> +};
> +module_spi_driver(s6e63m0_driver);
> +
> +MODULE_AUTHOR("Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>");
> +MODULE_DESCRIPTION("s6e63m0 LCD Driver");
> +MODULE_LICENSE("GPL v2");
This seems not to match the SPDX tag, please verify.

	Sam

