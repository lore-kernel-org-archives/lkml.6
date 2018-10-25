Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAC7ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50002054F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SygGN/r/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50002054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbeJYQQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:16:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45439 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbeJYQQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:16:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id n5-v6so4397521wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 00:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/pk9QJYQJPzS/CLgZ5LyfHgDm6JIlan4FocA4X86OXA=;
        b=SygGN/r/4ZVjSt3/5o0h6IhfpSgbG7BjyUP8tKXwz7P/3U6vWurnphHLvM9kOcgIPu
         ILvnYRcwtn/Xqy86FA/T5hTQS3tdrQloWYTnm2tgLLoYnANREv5N5LRmfFoEYGhOgqiv
         qCbzZIoS6zn2nREk4edDJigxFulr1m47iAMdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/pk9QJYQJPzS/CLgZ5LyfHgDm6JIlan4FocA4X86OXA=;
        b=h+av6zN9IXyjHH8P/N8UaMiaKWx5w3iD8I47L4Z72s1Eot0U3deWXLOy5NSE3m1PvW
         XwDI9yIHPVgwmsiM0zdtveukNY+OppXcjBnhRGjuiUROlp1SX7xMRG4z2hHSrUaoqk2m
         hQDtRdQaPsszAgOpFQLFk87ihRTZS/3kzT8OQ/Tvyp5go6T+XOFwYlOHMrQsWO0Wqfgg
         wiu4RnmUUWBcZuL4Iv7TUQ0o3/p3+B4H3O0yV6A3GoH16ZkEWwp/ZMxGvIDDq3NrYMx2
         HxnVckCtEjwBq2pIo0wbbKAN9ILwrqFTtKAjcrCKsT/Hzsgq694gmn3phFe8o3wDDEay
         mbFQ==
X-Gm-Message-State: AGRZ1gLCDsTzSDdtvmM9hCtl1Vu6VAQsh7wGSEMyoZt4kbO+tw3sPLqp
        v1BvYipmGTN+YwU86f0aGqI6FQ==
X-Google-Smtp-Source: AJdET5eJfcv4zjTo4FssR0NjjKkuH2+UaBrL5P5ZbNloNyDhw6l03ZDQkPurtLj1JkkYUc3G9AAd0g==
X-Received: by 2002:adf:9102:: with SMTP id j2-v6mr653211wrj.3.1540453502273;
        Thu, 25 Oct 2018 00:45:02 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id r2-v6sm3960963wrq.1.2018.10.25.00.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 00:45:01 -0700 (PDT)
Date:   Thu, 25 Oct 2018 08:44:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, broonie@kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mfd: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20181025074459.GF4939@dell>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181008132542.19775-2-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Oct 2018, Charles Keepax wrote:

> From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> 
> Lochnagar is an evaluation and development board for Cirrus
> Logic Smart CODEC and Amp devices. It allows the connection of
> most Cirrus Logic devices on mini-cards, as well as allowing
> connection of various application processor systems to provide a
> full evaluation platform. This driver supports the board
> controller chip on the Lochnagar board. Audio system topology,
> clocking and power can all be controlled through the Lochnagar
> controller chip, allowing the device under test to be used in
> a variety of possible use cases.
> 
> As the Lochnagar is a fairly complex device this MFD driver
> allows the drivers for the various features to be bound
> in. Initially clocking, regulator and pinctrl will be added as
> these are necessary to configure the system. But in time at least
> audio and voltage/current monitoring will also be added.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
> 
> Changes since v1:
>  - Update Kconfig to correctly specify dependencies
>  - Update commit message a little
> 
> Thanks,
> Charles
> 
>  MAINTAINERS                         |  13 +
>  drivers/mfd/Kconfig                 |   8 +
>  drivers/mfd/Makefile                |   2 +
>  drivers/mfd/lochnagar-i2c.c         | 732 ++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/lochnagar.h       |  48 +++
>  include/linux/mfd/lochnagar1_regs.h | 157 ++++++++
>  include/linux/mfd/lochnagar2_regs.h | 253 +++++++++++++
>  7 files changed, 1213 insertions(+)
>  create mode 100644 drivers/mfd/lochnagar-i2c.c
>  create mode 100644 include/linux/mfd/lochnagar.h
>  create mode 100644 include/linux/mfd/lochnagar1_regs.h
>  create mode 100644 include/linux/mfd/lochnagar2_regs.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d9e6d86488df4..f1f3494ac5cd8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3557,6 +3557,19 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/cirrus/ep93xx_eth.c
>  
> +CIRRUS LOGIC LOCHNAGAR DRIVER
> +M:	Charles Keepax <ckeepax@opensource.cirrus.com>
> +M:	Richard Fitzgerald <rf@opensource.cirrus.com>
> +L:	patches@opensource.cirrus.com
> +S:	Supported
> +F:	drivers/clk/clk-lochnagar.c
> +F:	drivers/mfd/lochnagar-i2c.c
> +F:	drivers/pinctrl/cirrus/pinctrl-lochnagar.c
> +F:	drivers/regulator/lochnagar-regulator.c
> +F:	include/dt-bindings/clk/lochnagar.h
> +F:	include/dt-bindings/pinctrl/lochnagar.h
> +F:	include/linux/mfd/lochnagar*
> +
>  CISCO FCOE HBA DRIVER
>  M:	Satish Kharat <satishkh@cisco.com>
>  M:	Sesidhar Baddela <sebaddel@cisco.com>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index f3a5f8d027906..dc64151373714 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1676,6 +1676,14 @@ config MFD_VX855
>  	  VIA VX855/VX875 south bridge. You will need to enable the vx855_spi
>  	  and/or vx855_gpio drivers for this to do anything useful.
>  
> +config MFD_LOCHNAGAR
> +	bool "Cirrus Logic Lochnagar Audio Development Board"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	depends on I2C=y && OF
> +	help
> +	  Support for Cirrus Logic Lochnagar audio development board.
> +
>  config MFD_ARIZONA
>  	select REGMAP
>  	select REGMAP_IRQ
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 5856a9489cbd8..f16773cb887ff 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -37,6 +37,8 @@ obj-$(CONFIG_MFD_T7L66XB)	+= t7l66xb.o tmio_core.o
>  obj-$(CONFIG_MFD_TC6387XB)	+= tc6387xb.o tmio_core.o
>  obj-$(CONFIG_MFD_TC6393XB)	+= tc6393xb.o tmio_core.o
>  
> +obj-$(CONFIG_MFD_LOCHNAGAR)	+= lochnagar-i2c.o
> +
>  obj-$(CONFIG_MFD_ARIZONA)	+= arizona-core.o
>  obj-$(CONFIG_MFD_ARIZONA)	+= arizona-irq.o
>  obj-$(CONFIG_MFD_ARIZONA_I2C)	+= arizona-i2c.o
> diff --git a/drivers/mfd/lochnagar-i2c.c b/drivers/mfd/lochnagar-i2c.c
> new file mode 100644
> index 0000000000000..7ac7af9e3130b
> --- /dev/null
> +++ b/drivers/mfd/lochnagar-i2c.c
> @@ -0,0 +1,732 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Lochnagar I2C bus interface
> + *
> + * Copyright (c) 2012-2018 Cirrus Logic, Inc. and
> + *                         Cirrus Logic International Semiconductor Ltd.
> + *
> + * Author: Charles Keepax <ckeepax@opensource.cirrus.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/mfd/lochnagar.h>
> +
> +#define LOCHNAGAR_BOOT_RETRIES		10
> +#define LOCHNAGAR_BOOT_DELAY_MS		350
> +
> +#define LOCHNAGAR_CONFIG_POLL_US	10000
> +
> +static bool lochnagar1_readable_register(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case LOCHNAGAR_SOFTWARE_RESET:
> +	case LOCHNAGAR_FIRMWARE_ID1:
> +	case LOCHNAGAR_FIRMWARE_ID2:
> +	case LOCHNAGAR1_CDC_AIF1_SEL:
> +	case LOCHNAGAR1_CDC_AIF2_SEL:
> +	case LOCHNAGAR1_CDC_AIF3_SEL:
> +	case LOCHNAGAR1_CDC_MCLK1_SEL:
> +	case LOCHNAGAR1_CDC_MCLK2_SEL:
> +	case LOCHNAGAR1_CDC_AIF_CTRL1:
> +	case LOCHNAGAR1_CDC_AIF_CTRL2:
> +	case LOCHNAGAR1_EXT_AIF_CTRL:
> +	case LOCHNAGAR1_DSP_AIF1_SEL:
> +	case LOCHNAGAR1_DSP_AIF2_SEL:
> +	case LOCHNAGAR1_DSP_CLKIN_SEL:
> +	case LOCHNAGAR1_DSP_AIF:
> +	case LOCHNAGAR1_GF_AIF1:
> +	case LOCHNAGAR1_GF_AIF2:
> +	case LOCHNAGAR1_PSIA_AIF:
> +	case LOCHNAGAR1_PSIA1_SEL:
> +	case LOCHNAGAR1_PSIA2_SEL:
> +	case LOCHNAGAR1_SPDIF_AIF_SEL:
> +	case LOCHNAGAR1_GF_AIF3_SEL:
> +	case LOCHNAGAR1_GF_AIF4_SEL:
> +	case LOCHNAGAR1_GF_CLKOUT1_SEL:
> +	case LOCHNAGAR1_GF_AIF1_SEL:
> +	case LOCHNAGAR1_GF_AIF2_SEL:
> +	case LOCHNAGAR1_GF_GPIO2:
> +	case LOCHNAGAR1_GF_GPIO3:
> +	case LOCHNAGAR1_GF_GPIO7:
> +	case LOCHNAGAR1_RST:
> +	case LOCHNAGAR1_LED1:
> +	case LOCHNAGAR1_LED2:
> +	case LOCHNAGAR1_I2C_CTRL:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct reg_default lochnagar1_reg_defaults[] = {
> +	{ LOCHNAGAR1_CDC_AIF1_SEL,    0x00 },
> +	{ LOCHNAGAR1_CDC_AIF2_SEL,    0x00 },
> +	{ LOCHNAGAR1_CDC_AIF3_SEL,    0x00 },
> +	{ LOCHNAGAR1_CDC_MCLK1_SEL,   0x00 },
> +	{ LOCHNAGAR1_CDC_MCLK2_SEL,   0x00 },
> +	{ LOCHNAGAR1_CDC_AIF_CTRL1,   0x00 },
> +	{ LOCHNAGAR1_CDC_AIF_CTRL2,   0x00 },
> +	{ LOCHNAGAR1_EXT_AIF_CTRL,    0x00 },
> +	{ LOCHNAGAR1_DSP_AIF1_SEL,    0x00 },
> +	{ LOCHNAGAR1_DSP_AIF2_SEL,    0x00 },
> +	{ LOCHNAGAR1_DSP_CLKIN_SEL,   0x01 },
> +	{ LOCHNAGAR1_DSP_AIF,         0x08 },
> +	{ LOCHNAGAR1_GF_AIF1,         0x00 },
> +	{ LOCHNAGAR1_GF_AIF2,         0x00 },
> +	{ LOCHNAGAR1_PSIA_AIF,        0x00 },
> +	{ LOCHNAGAR1_PSIA1_SEL,       0x00 },
> +	{ LOCHNAGAR1_PSIA2_SEL,       0x00 },
> +	{ LOCHNAGAR1_SPDIF_AIF_SEL,   0x00 },
> +	{ LOCHNAGAR1_GF_AIF3_SEL,     0x00 },
> +	{ LOCHNAGAR1_GF_AIF4_SEL,     0x00 },
> +	{ LOCHNAGAR1_GF_CLKOUT1_SEL,  0x00 },
> +	{ LOCHNAGAR1_GF_AIF1_SEL,     0x00 },
> +	{ LOCHNAGAR1_GF_AIF2_SEL,     0x00 },
> +	{ LOCHNAGAR1_GF_GPIO2,        0x00 },
> +	{ LOCHNAGAR1_GF_GPIO3,        0x00 },
> +	{ LOCHNAGAR1_GF_GPIO7,        0x00 },
> +	{ LOCHNAGAR1_RST,             0x00 },
> +	{ LOCHNAGAR1_LED1,            0x00 },
> +	{ LOCHNAGAR1_LED2,            0x00 },
> +	{ LOCHNAGAR1_I2C_CTRL,        0x01 },
> +};

Why do you need to specify each register value?

> +static const struct regmap_config lochnagar1_i2c_regmap = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.reg_format_endian = REGMAP_ENDIAN_BIG,
> +	.val_format_endian = REGMAP_ENDIAN_BIG,
> +
> +	.max_register = 0x50,
> +	.readable_reg = lochnagar1_readable_register,
> +
> +	.use_single_rw = true,
> +
> +	.cache_type = REGCACHE_RBTREE,
> +
> +	.reg_defaults = lochnagar1_reg_defaults,
> +	.num_reg_defaults = ARRAY_SIZE(lochnagar1_reg_defaults),
> +};
> +
> +static const struct reg_sequence lochnagar1_patch[] = {
> +	{ 0x40, 0x0083 },
> +	{ 0x46, 0x0001 },
> +	{ 0x47, 0x0018 },
> +	{ 0x50, 0x0000 },
> +};

I'm really not a fan of these so call 'patches'.

Can't you set the registers up proper way?

> +static struct mfd_cell lochnagar1_devs[] = {
> +	{
> +		.name = "lochnagar-pinctrl"
> +	},
> +	{
> +		.name = "lochnagar-clk"
> +	},

This should each be on a single line.

> +};
> +
> +static bool lochnagar2_readable_register(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case LOCHNAGAR_SOFTWARE_RESET:
> +	case LOCHNAGAR_FIRMWARE_ID1:
> +	case LOCHNAGAR_FIRMWARE_ID2:
> +	case LOCHNAGAR2_CDC_AIF1_CTRL:
> +	case LOCHNAGAR2_CDC_AIF2_CTRL:
> +	case LOCHNAGAR2_CDC_AIF3_CTRL:
> +	case LOCHNAGAR2_DSP_AIF1_CTRL:
> +	case LOCHNAGAR2_DSP_AIF2_CTRL:
> +	case LOCHNAGAR2_PSIA1_CTRL:
> +	case LOCHNAGAR2_PSIA2_CTRL:
> +	case LOCHNAGAR2_GF_AIF3_CTRL:
> +	case LOCHNAGAR2_GF_AIF4_CTRL:
> +	case LOCHNAGAR2_GF_AIF1_CTRL:
> +	case LOCHNAGAR2_GF_AIF2_CTRL:
> +	case LOCHNAGAR2_SPDIF_AIF_CTRL:
> +	case LOCHNAGAR2_USB_AIF1_CTRL:
> +	case LOCHNAGAR2_USB_AIF2_CTRL:
> +	case LOCHNAGAR2_ADAT_AIF_CTRL:
> +	case LOCHNAGAR2_CDC_MCLK1_CTRL:
> +	case LOCHNAGAR2_CDC_MCLK2_CTRL:
> +	case LOCHNAGAR2_DSP_CLKIN_CTRL:
> +	case LOCHNAGAR2_PSIA1_MCLK_CTRL:
> +	case LOCHNAGAR2_PSIA2_MCLK_CTRL:
> +	case LOCHNAGAR2_SPDIF_MCLK_CTRL:
> +	case LOCHNAGAR2_GF_CLKOUT1_CTRL:
> +	case LOCHNAGAR2_GF_CLKOUT2_CTRL:
> +	case LOCHNAGAR2_ADAT_MCLK_CTRL:
> +	case LOCHNAGAR2_SOUNDCARD_MCLK_CTRL:
> +	case LOCHNAGAR2_GPIO_FPGA_GPIO1:
> +	case LOCHNAGAR2_GPIO_FPGA_GPIO2:
> +	case LOCHNAGAR2_GPIO_FPGA_GPIO3:
> +	case LOCHNAGAR2_GPIO_FPGA_GPIO4:
> +	case LOCHNAGAR2_GPIO_FPGA_GPIO5:
> +	case LOCHNAGAR2_GPIO_FPGA_GPIO6:
> +	case LOCHNAGAR2_GPIO_CDC_GPIO1:
> +	case LOCHNAGAR2_GPIO_CDC_GPIO2:
> +	case LOCHNAGAR2_GPIO_CDC_GPIO3:
> +	case LOCHNAGAR2_GPIO_CDC_GPIO4:
> +	case LOCHNAGAR2_GPIO_CDC_GPIO5:
> +	case LOCHNAGAR2_GPIO_CDC_GPIO6:
> +	case LOCHNAGAR2_GPIO_CDC_GPIO7:
> +	case LOCHNAGAR2_GPIO_CDC_GPIO8:
> +	case LOCHNAGAR2_GPIO_DSP_GPIO1:
> +	case LOCHNAGAR2_GPIO_DSP_GPIO2:
> +	case LOCHNAGAR2_GPIO_DSP_GPIO3:
> +	case LOCHNAGAR2_GPIO_DSP_GPIO4:
> +	case LOCHNAGAR2_GPIO_DSP_GPIO5:
> +	case LOCHNAGAR2_GPIO_DSP_GPIO6:
> +	case LOCHNAGAR2_GPIO_GF_GPIO2:
> +	case LOCHNAGAR2_GPIO_GF_GPIO3:
> +	case LOCHNAGAR2_GPIO_GF_GPIO7:
> +	case LOCHNAGAR2_GPIO_CDC_AIF1_BCLK:
> +	case LOCHNAGAR2_GPIO_CDC_AIF1_RXDAT:
> +	case LOCHNAGAR2_GPIO_CDC_AIF1_LRCLK:
> +	case LOCHNAGAR2_GPIO_CDC_AIF1_TXDAT:
> +	case LOCHNAGAR2_GPIO_CDC_AIF2_BCLK:
> +	case LOCHNAGAR2_GPIO_CDC_AIF2_RXDAT:
> +	case LOCHNAGAR2_GPIO_CDC_AIF2_LRCLK:
> +	case LOCHNAGAR2_GPIO_CDC_AIF2_TXDAT:
> +	case LOCHNAGAR2_GPIO_CDC_AIF3_BCLK:
> +	case LOCHNAGAR2_GPIO_CDC_AIF3_RXDAT:
> +	case LOCHNAGAR2_GPIO_CDC_AIF3_LRCLK:
> +	case LOCHNAGAR2_GPIO_CDC_AIF3_TXDAT:
> +	case LOCHNAGAR2_GPIO_DSP_AIF1_BCLK:
> +	case LOCHNAGAR2_GPIO_DSP_AIF1_RXDAT:
> +	case LOCHNAGAR2_GPIO_DSP_AIF1_LRCLK:
> +	case LOCHNAGAR2_GPIO_DSP_AIF1_TXDAT:
> +	case LOCHNAGAR2_GPIO_DSP_AIF2_BCLK:
> +	case LOCHNAGAR2_GPIO_DSP_AIF2_RXDAT:
> +	case LOCHNAGAR2_GPIO_DSP_AIF2_LRCLK:
> +	case LOCHNAGAR2_GPIO_DSP_AIF2_TXDAT:
> +	case LOCHNAGAR2_GPIO_PSIA1_BCLK:
> +	case LOCHNAGAR2_GPIO_PSIA1_RXDAT:
> +	case LOCHNAGAR2_GPIO_PSIA1_LRCLK:
> +	case LOCHNAGAR2_GPIO_PSIA1_TXDAT:
> +	case LOCHNAGAR2_GPIO_PSIA2_BCLK:
> +	case LOCHNAGAR2_GPIO_PSIA2_RXDAT:
> +	case LOCHNAGAR2_GPIO_PSIA2_LRCLK:
> +	case LOCHNAGAR2_GPIO_PSIA2_TXDAT:
> +	case LOCHNAGAR2_GPIO_GF_AIF3_BCLK:
> +	case LOCHNAGAR2_GPIO_GF_AIF3_RXDAT:
> +	case LOCHNAGAR2_GPIO_GF_AIF3_LRCLK:
> +	case LOCHNAGAR2_GPIO_GF_AIF3_TXDAT:
> +	case LOCHNAGAR2_GPIO_GF_AIF4_BCLK:
> +	case LOCHNAGAR2_GPIO_GF_AIF4_RXDAT:
> +	case LOCHNAGAR2_GPIO_GF_AIF4_LRCLK:
> +	case LOCHNAGAR2_GPIO_GF_AIF4_TXDAT:
> +	case LOCHNAGAR2_GPIO_GF_AIF1_BCLK:
> +	case LOCHNAGAR2_GPIO_GF_AIF1_RXDAT:
> +	case LOCHNAGAR2_GPIO_GF_AIF1_LRCLK:
> +	case LOCHNAGAR2_GPIO_GF_AIF1_TXDAT:
> +	case LOCHNAGAR2_GPIO_GF_AIF2_BCLK:
> +	case LOCHNAGAR2_GPIO_GF_AIF2_RXDAT:
> +	case LOCHNAGAR2_GPIO_GF_AIF2_LRCLK:
> +	case LOCHNAGAR2_GPIO_GF_AIF2_TXDAT:
> +	case LOCHNAGAR2_GPIO_DSP_UART1_RX:
> +	case LOCHNAGAR2_GPIO_DSP_UART1_TX:
> +	case LOCHNAGAR2_GPIO_DSP_UART2_RX:
> +	case LOCHNAGAR2_GPIO_DSP_UART2_TX:
> +	case LOCHNAGAR2_GPIO_GF_UART2_RX:
> +	case LOCHNAGAR2_GPIO_GF_UART2_TX:
> +	case LOCHNAGAR2_GPIO_USB_UART_RX:
> +	case LOCHNAGAR2_GPIO_CDC_PDMCLK1:
> +	case LOCHNAGAR2_GPIO_CDC_PDMDAT1:
> +	case LOCHNAGAR2_GPIO_CDC_PDMCLK2:
> +	case LOCHNAGAR2_GPIO_CDC_PDMDAT2:
> +	case LOCHNAGAR2_GPIO_CDC_DMICCLK1:
> +	case LOCHNAGAR2_GPIO_CDC_DMICDAT1:
> +	case LOCHNAGAR2_GPIO_CDC_DMICCLK2:
> +	case LOCHNAGAR2_GPIO_CDC_DMICDAT2:
> +	case LOCHNAGAR2_GPIO_CDC_DMICCLK3:
> +	case LOCHNAGAR2_GPIO_CDC_DMICDAT3:
> +	case LOCHNAGAR2_GPIO_CDC_DMICCLK4:
> +	case LOCHNAGAR2_GPIO_CDC_DMICDAT4:
> +	case LOCHNAGAR2_GPIO_DSP_DMICCLK1:
> +	case LOCHNAGAR2_GPIO_DSP_DMICDAT1:
> +	case LOCHNAGAR2_GPIO_DSP_DMICCLK2:
> +	case LOCHNAGAR2_GPIO_DSP_DMICDAT2:
> +	case LOCHNAGAR2_GPIO_I2C2_SCL:
> +	case LOCHNAGAR2_GPIO_I2C2_SDA:
> +	case LOCHNAGAR2_GPIO_I2C3_SCL:
> +	case LOCHNAGAR2_GPIO_I2C3_SDA:
> +	case LOCHNAGAR2_GPIO_I2C4_SCL:
> +	case LOCHNAGAR2_GPIO_I2C4_SDA:
> +	case LOCHNAGAR2_GPIO_DSP_STANDBY:
> +	case LOCHNAGAR2_GPIO_CDC_MCLK1:
> +	case LOCHNAGAR2_GPIO_CDC_MCLK2:
> +	case LOCHNAGAR2_GPIO_DSP_CLKIN:
> +	case LOCHNAGAR2_GPIO_PSIA1_MCLK:
> +	case LOCHNAGAR2_GPIO_PSIA2_MCLK:
> +	case LOCHNAGAR2_GPIO_GF_GPIO1:
> +	case LOCHNAGAR2_GPIO_GF_GPIO5:
> +	case LOCHNAGAR2_GPIO_DSP_GPIO20:
> +	case LOCHNAGAR2_GPIO_CHANNEL1:
> +	case LOCHNAGAR2_GPIO_CHANNEL2:
> +	case LOCHNAGAR2_GPIO_CHANNEL3:
> +	case LOCHNAGAR2_GPIO_CHANNEL4:
> +	case LOCHNAGAR2_GPIO_CHANNEL5:
> +	case LOCHNAGAR2_GPIO_CHANNEL6:
> +	case LOCHNAGAR2_GPIO_CHANNEL7:
> +	case LOCHNAGAR2_GPIO_CHANNEL8:
> +	case LOCHNAGAR2_GPIO_CHANNEL9:
> +	case LOCHNAGAR2_GPIO_CHANNEL10:
> +	case LOCHNAGAR2_GPIO_CHANNEL11:
> +	case LOCHNAGAR2_GPIO_CHANNEL12:
> +	case LOCHNAGAR2_GPIO_CHANNEL13:
> +	case LOCHNAGAR2_GPIO_CHANNEL14:
> +	case LOCHNAGAR2_GPIO_CHANNEL15:
> +	case LOCHNAGAR2_GPIO_CHANNEL16:
> +	case LOCHNAGAR2_MINICARD_RESETS:
> +	case LOCHNAGAR2_ANALOGUE_PATH_CTRL1:
> +	case LOCHNAGAR2_ANALOGUE_PATH_CTRL2:
> +	case LOCHNAGAR2_COMMS_CTRL4:
> +	case LOCHNAGAR2_SPDIF_CTRL:
> +	case LOCHNAGAR2_POWER_CTRL:
> +	case LOCHNAGAR2_MICVDD_CTRL1:
> +	case LOCHNAGAR2_MICVDD_CTRL2:
> +	case LOCHNAGAR2_VDDCORE_CDC_CTRL1:
> +	case LOCHNAGAR2_VDDCORE_CDC_CTRL2:
> +	case LOCHNAGAR2_SOUNDCARD_AIF_CTRL:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool lochnagar2_volatile_register(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case LOCHNAGAR2_GPIO_CHANNEL1:
> +	case LOCHNAGAR2_GPIO_CHANNEL2:
> +	case LOCHNAGAR2_GPIO_CHANNEL3:
> +	case LOCHNAGAR2_GPIO_CHANNEL4:
> +	case LOCHNAGAR2_GPIO_CHANNEL5:
> +	case LOCHNAGAR2_GPIO_CHANNEL6:
> +	case LOCHNAGAR2_GPIO_CHANNEL7:
> +	case LOCHNAGAR2_GPIO_CHANNEL8:
> +	case LOCHNAGAR2_GPIO_CHANNEL9:
> +	case LOCHNAGAR2_GPIO_CHANNEL10:
> +	case LOCHNAGAR2_GPIO_CHANNEL11:
> +	case LOCHNAGAR2_GPIO_CHANNEL12:
> +	case LOCHNAGAR2_GPIO_CHANNEL13:
> +	case LOCHNAGAR2_GPIO_CHANNEL14:
> +	case LOCHNAGAR2_GPIO_CHANNEL15:
> +	case LOCHNAGAR2_GPIO_CHANNEL16:
> +	case LOCHNAGAR2_ANALOGUE_PATH_CTRL1:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

This is getting silly now.  Can't you use ranges?

> +static const struct reg_default lochnagar2_reg_defaults[] = {
> +	{ LOCHNAGAR2_CDC_AIF1_CTRL,         0x0000 },
> +	{ LOCHNAGAR2_CDC_AIF2_CTRL,         0x0000 },
> +	{ LOCHNAGAR2_CDC_AIF3_CTRL,         0x0000 },
> +	{ LOCHNAGAR2_DSP_AIF1_CTRL,         0x0000 },
> +	{ LOCHNAGAR2_DSP_AIF2_CTRL,         0x0000 },
> +	{ LOCHNAGAR2_PSIA1_CTRL,            0x0000 },
> +	{ LOCHNAGAR2_PSIA2_CTRL,            0x0000 },
> +	{ LOCHNAGAR2_GF_AIF3_CTRL,          0x0000 },
> +	{ LOCHNAGAR2_GF_AIF4_CTRL,          0x0000 },
> +	{ LOCHNAGAR2_GF_AIF1_CTRL,          0x0000 },
> +	{ LOCHNAGAR2_GF_AIF2_CTRL,          0x0000 },
> +	{ LOCHNAGAR2_SPDIF_AIF_CTRL,        0x0000 },
> +	{ LOCHNAGAR2_USB_AIF1_CTRL,         0x0000 },
> +	{ LOCHNAGAR2_USB_AIF2_CTRL,         0x0000 },
> +	{ LOCHNAGAR2_ADAT_AIF_CTRL,         0x0000 },
> +	{ LOCHNAGAR2_CDC_MCLK1_CTRL,        0x0000 },
> +	{ LOCHNAGAR2_CDC_MCLK2_CTRL,        0x0000 },
> +	{ LOCHNAGAR2_DSP_CLKIN_CTRL,        0x0000 },
> +	{ LOCHNAGAR2_PSIA1_MCLK_CTRL,       0x0000 },
> +	{ LOCHNAGAR2_PSIA2_MCLK_CTRL,       0x0000 },
> +	{ LOCHNAGAR2_SPDIF_MCLK_CTRL,       0x0000 },
> +	{ LOCHNAGAR2_GF_CLKOUT1_CTRL,       0x0000 },
> +	{ LOCHNAGAR2_GF_CLKOUT2_CTRL,       0x0000 },
> +	{ LOCHNAGAR2_ADAT_MCLK_CTRL,        0x0000 },
> +	{ LOCHNAGAR2_SOUNDCARD_MCLK_CTRL,   0x0000 },
> +	{ LOCHNAGAR2_GPIO_FPGA_GPIO1,       0x0000 },
> +	{ LOCHNAGAR2_GPIO_FPGA_GPIO2,       0x0000 },
> +	{ LOCHNAGAR2_GPIO_FPGA_GPIO3,       0x0000 },
> +	{ LOCHNAGAR2_GPIO_FPGA_GPIO4,       0x0000 },
> +	{ LOCHNAGAR2_GPIO_FPGA_GPIO5,       0x0000 },
> +	{ LOCHNAGAR2_GPIO_FPGA_GPIO6,       0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_GPIO1,        0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_GPIO2,        0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_GPIO3,        0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_GPIO4,        0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_GPIO5,        0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_GPIO6,        0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_GPIO7,        0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_GPIO8,        0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_GPIO1,        0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_GPIO2,        0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_GPIO3,        0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_GPIO4,        0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_GPIO5,        0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_GPIO6,        0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_GPIO2,         0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_GPIO3,         0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_GPIO7,         0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_AIF1_BCLK,    0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_AIF1_RXDAT,   0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_AIF1_LRCLK,   0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_AIF1_TXDAT,   0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_AIF2_BCLK,    0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_AIF2_RXDAT,   0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_AIF2_LRCLK,   0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_AIF2_TXDAT,   0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_AIF3_BCLK,    0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_AIF3_RXDAT,   0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_AIF3_LRCLK,   0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_AIF3_TXDAT,   0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_AIF1_BCLK,    0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_AIF1_RXDAT,   0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_AIF1_LRCLK,   0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_AIF1_TXDAT,   0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_AIF2_BCLK,    0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_AIF2_RXDAT,   0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_AIF2_LRCLK,   0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_AIF2_TXDAT,   0x0000 },
> +	{ LOCHNAGAR2_GPIO_PSIA1_BCLK,       0x0000 },
> +	{ LOCHNAGAR2_GPIO_PSIA1_RXDAT,      0x0000 },
> +	{ LOCHNAGAR2_GPIO_PSIA1_LRCLK,      0x0000 },
> +	{ LOCHNAGAR2_GPIO_PSIA1_TXDAT,      0x0000 },
> +	{ LOCHNAGAR2_GPIO_PSIA2_BCLK,       0x0000 },
> +	{ LOCHNAGAR2_GPIO_PSIA2_RXDAT,      0x0000 },
> +	{ LOCHNAGAR2_GPIO_PSIA2_LRCLK,      0x0000 },
> +	{ LOCHNAGAR2_GPIO_PSIA2_TXDAT,      0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_AIF3_BCLK,     0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_AIF3_RXDAT,    0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_AIF3_LRCLK,    0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_AIF3_TXDAT,    0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_AIF4_BCLK,     0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_AIF4_RXDAT,    0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_AIF4_LRCLK,    0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_AIF4_TXDAT,    0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_AIF1_BCLK,     0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_AIF1_RXDAT,    0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_AIF1_LRCLK,    0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_AIF1_TXDAT,    0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_AIF2_BCLK,     0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_AIF2_RXDAT,    0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_AIF2_LRCLK,    0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_AIF2_TXDAT,    0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_UART1_RX,     0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_UART1_TX,     0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_UART2_RX,     0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_UART2_TX,     0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_UART2_RX,      0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_UART2_TX,      0x0000 },
> +	{ LOCHNAGAR2_GPIO_USB_UART_RX,      0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_PDMCLK1,      0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_PDMDAT1,      0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_PDMCLK2,      0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_PDMDAT2,      0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_DMICCLK1,     0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_DMICDAT1,     0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_DMICCLK2,     0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_DMICDAT2,     0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_DMICCLK3,     0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_DMICDAT3,     0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_DMICCLK4,     0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_DMICDAT4,     0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_DMICCLK1,     0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_DMICDAT1,     0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_DMICCLK2,     0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_DMICDAT2,     0x0000 },
> +	{ LOCHNAGAR2_GPIO_I2C2_SCL,         0x0000 },
> +	{ LOCHNAGAR2_GPIO_I2C2_SDA,         0x0000 },
> +	{ LOCHNAGAR2_GPIO_I2C3_SCL,         0x0000 },
> +	{ LOCHNAGAR2_GPIO_I2C3_SDA,         0x0000 },
> +	{ LOCHNAGAR2_GPIO_I2C4_SCL,         0x0000 },
> +	{ LOCHNAGAR2_GPIO_I2C4_SDA,         0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_STANDBY,      0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_MCLK1,        0x0000 },
> +	{ LOCHNAGAR2_GPIO_CDC_MCLK2,        0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_CLKIN,        0x0000 },
> +	{ LOCHNAGAR2_GPIO_PSIA1_MCLK,       0x0000 },
> +	{ LOCHNAGAR2_GPIO_PSIA2_MCLK,       0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_GPIO1,         0x0000 },
> +	{ LOCHNAGAR2_GPIO_GF_GPIO5,         0x0000 },
> +	{ LOCHNAGAR2_GPIO_DSP_GPIO20,       0x0000 },
> +	{ LOCHNAGAR2_MINICARD_RESETS,       0x0000 },
> +	{ LOCHNAGAR2_ANALOGUE_PATH_CTRL2,   0x0000 },
> +	{ LOCHNAGAR2_COMMS_CTRL4,           0x0001 },
> +	{ LOCHNAGAR2_SPDIF_CTRL,            0x0008 },
> +	{ LOCHNAGAR2_POWER_CTRL,            0x0001 },
> +	{ LOCHNAGAR2_SOUNDCARD_AIF_CTRL,    0x0000 },
> +};

OMG!  Vile, vile vile!

> +static const struct regmap_config lochnagar2_i2c_regmap = {
> +	.reg_bits = 16,
> +	.val_bits = 16,
> +	.reg_format_endian = REGMAP_ENDIAN_BIG,
> +	.val_format_endian = REGMAP_ENDIAN_BIG,
> +
> +	.max_register = 0x1F1F,
> +	.readable_reg = lochnagar2_readable_register,
> +	.volatile_reg = lochnagar2_volatile_register,
> +
> +	.cache_type = REGCACHE_RBTREE,
> +
> +	.reg_defaults = lochnagar2_reg_defaults,
> +	.num_reg_defaults = ARRAY_SIZE(lochnagar2_reg_defaults),
> +};
> +
> +static const struct reg_sequence lochnagar2_patch[] = {
> +	{ 0x00EE, 0x0000 },
> +	{ 0x00F0, 0x0001 },
> +};
> +
> +static struct mfd_cell lochnagar2_devs[] = {
> +	{
> +		.name = "lochnagar-pinctrl"
> +	},
> +	{
> +		.name = "lochnagar-clk"
> +	},
> +	{
> +		.name = "lochnagar-regulator"
> +	},
> +	{
> +		.name = "lochnagar2-sound-card",
> +	},
> +};

All the same as above.

> +static struct lochnagar_config {
> +	int id;
> +	const char * const name;
> +	enum lochnagar_type type;
> +	const struct regmap_config *regmap;
> +	struct mfd_cell *devs;
> +	int ndevs;
> +	const struct reg_sequence *patch;
> +	int npatch;
> +} lochnagar_configs[] = {

Not a fan of this syntax.

Please separate the struct declaration and its use.

> +	{
> +		.id = 0x50,
> +		.name = "lochnagar1",
> +		.type = LOCHNAGAR1,
> +		.regmap = &lochnagar1_i2c_regmap,
> +		.devs = lochnagar1_devs,
> +		.ndevs = ARRAY_SIZE(lochnagar1_devs),
> +		.patch = lochnagar1_patch,
> +		.npatch = ARRAY_SIZE(lochnagar1_patch),
> +	},
> +	{
> +		.id = 0xCB58,
> +		.name = "lochnagar2",
> +		.type = LOCHNAGAR2,
> +		.regmap = &lochnagar2_i2c_regmap,
> +		.devs = lochnagar2_devs,
> +		.ndevs = ARRAY_SIZE(lochnagar2_devs),
> +		.patch = lochnagar2_patch,
> +		.npatch = ARRAY_SIZE(lochnagar2_patch),
> +	},
> +};
> +
> +static const struct of_device_id lochnagar_of_match[] = {
> +	{ .compatible = "cirrus,lochnagar1", .data = &lochnagar_configs[0] },
> +	{ .compatible = "cirrus,lochnagar2", .data = &lochnagar_configs[1] },
> +	{},
> +};
> +
> +static int lochnagar_wait_for_boot(struct regmap *regmap, unsigned int *id)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < LOCHNAGAR_BOOT_RETRIES; ++i) {
> +		msleep(LOCHNAGAR_BOOT_DELAY_MS);
> +
> +		ret = regmap_read(regmap, LOCHNAGAR_SOFTWARE_RESET, id);
> +		if (!ret)
> +			return ret;
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +int lochnagar_update_config(struct lochnagar *lochnagar)
> +{
> +	struct regmap *regmap = lochnagar->regmap;
> +	unsigned int done = LOCHNAGAR2_ANALOGUE_PATH_UPDATE_STS_MASK;
> +	int timeout_ms = LOCHNAGAR_BOOT_DELAY_MS * LOCHNAGAR_BOOT_RETRIES;
> +	unsigned int val = 0;
> +	int ret;
> +
> +	switch (lochnagar->type) {
> +	case LOCHNAGAR1:
> +		return 0;
> +	case LOCHNAGAR2:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

This can be done with a simple if () statement:

if (lochnagar->type != LOCHNAGAR2)
   return 0;

> +	ret = regmap_write(regmap, LOCHNAGAR2_ANALOGUE_PATH_CTRL1, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_write(regmap, LOCHNAGAR2_ANALOGUE_PATH_CTRL1,
> +			   LOCHNAGAR2_ANALOGUE_PATH_UPDATE_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_read_poll_timeout(regmap,
> +				       LOCHNAGAR2_ANALOGUE_PATH_CTRL1, val,
> +				       (val & done), LOCHNAGAR_CONFIG_POLL_US,
> +				       timeout_ms * 1000);
> +	if (ret < 0)
> +		return ret;

What does all this do then?  You need a comment.

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(lochnagar_update_config);
> +
> +static int lochnagar_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	const struct lochnagar_config *config = NULL;
> +	const struct of_device_id *of_id;
> +	struct lochnagar *lochnagar;
> +	unsigned int val;
> +	struct gpio_desc *reset, *present;

Put this up higher in the list to keep the simple 'int's together.

> +	unsigned int firmwareid;
> +	int devid, rev;

Why do these need to be signed?

> +	int ret;
> +
> +	lochnagar = devm_kzalloc(dev, sizeof(*lochnagar), GFP_KERNEL);
> +	if (!lochnagar)
> +		return -ENOMEM;
> +
> +	of_id = of_match_device(lochnagar_of_match, dev);
> +	if (!of_id)
> +		return -EINVAL;
> +
> +	config = of_id->data;
> +
> +	lochnagar->dev = dev;
> +	mutex_init(&lochnagar->analogue_config_lock);
> +
> +	dev_set_drvdata(dev, lochnagar);
> +
> +	reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(reset)) {
> +		ret = PTR_ERR(reset);
> +		dev_err(dev, "Failed to get reset GPIO: %d\n", ret);
> +		return ret;
> +	}
> +
> +	present = devm_gpiod_get_optional(dev, "present", GPIOD_OUT_HIGH);
> +	if (IS_ERR(present)) {
> +		ret = PTR_ERR(present);
> +		dev_err(dev, "Failed to get present GPIO: %d\n", ret);
> +		return ret;
> +	}
> +
> +	msleep(20);

What's this for?

> +	/* Bring Lochnagar out of reset */
> +	gpiod_set_value_cansleep(reset, 1);
> +
> +	/* Identify Lochnagar */
> +	lochnagar->type = config->type;

'\n'

> +	lochnagar->regmap = devm_regmap_init_i2c(i2c, config->regmap);
> +	if (IS_ERR(lochnagar->regmap)) {
> +		ret = PTR_ERR(lochnagar->regmap);
> +		dev_err(dev, "Failed to allocate register map: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Wait for Lochnagar to boot */
> +	ret = lochnagar_wait_for_boot(lochnagar->regmap, &val);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to read device ID: %d\n", ret);

Eh?

So you read the LOCHNAGAR_SOFTWARE_RESET register and out pops the
device/revision IDs?  That's just random!

> +		return ret;
> +	}
> +
> +	devid = val & LOCHNAGAR_DEVICE_ID_MASK;
> +	rev = val & LOCHNAGAR_REV_ID_MASK;
> +
> +	if (devid != config->id) {
> +		dev_err(dev,
> +			"ID does not match %s (expected 0x%x got 0x%x)\n",
> +			config->name, config->id, devid);
> +		return -ENODEV;
> +	}
> +
> +	/* Identify firmware */
> +	ret = regmap_read(lochnagar->regmap, LOCHNAGAR_FIRMWARE_ID1, &val);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to read firmware id 1: %d\n", ret);
> +		return ret;
> +	}
> +
> +	firmwareid = val;
> +
> +	ret = regmap_read(lochnagar->regmap, LOCHNAGAR_FIRMWARE_ID2, &val);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to read firmware id 2: %d\n", ret);
> +		return ret;
> +	}
> +
> +	firmwareid |= (val << config->regmap->val_bits);
> +
> +	dev_info(dev, "Found %s (0x%x) revision %d firmware 0x%.6x\n",
> +		 config->name, devid, rev + 1, firmwareid);
> +
> +	ret = regmap_register_patch(lochnagar->regmap, config->patch,
> +				    config->npatch);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to register patch: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, config->devs,
> +				   config->ndevs, NULL, 0, NULL);
> +	if (ret != 0) {

if (ret)

> +		dev_err(dev, "Failed to add subdevices: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_of_platform_populate(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to populate child nodes: %d\n", ret);
> +		return ret;
> +	}

Please do not mix OF and MFD device registration strategies.

Pick one and register all devices through your chosen method.

> +	return ret;
> +}
> +
> +static struct i2c_driver lochnagar_i2c_driver = {
> +	.driver = {
> +		.name = "lochnagar",
> +		.of_match_table = of_match_ptr(lochnagar_of_match),
> +		.suppress_bind_attrs = true,
> +	},
> +

No need for '\n'.

> +	.probe_new = lochnagar_i2c_probe,

Hasn't this been replaced yet?

> +};
> +
> +static int __init lochnagar_i2c_init(void)
> +{
> +	int ret;
> +
> +	ret = i2c_add_driver(&lochnagar_i2c_driver);
> +	if (ret != 0)

if (ret)

> +		pr_err("Failed to register Lochnagar driver: %d\n", ret);
> +
> +	return ret;
> +}
> +subsys_initcall(lochnagar_i2c_init);
> diff --git a/include/linux/mfd/lochnagar.h b/include/linux/mfd/lochnagar.h
> new file mode 100644
> index 0000000000000..be485d6714f7c
> --- /dev/null
> +++ b/include/linux/mfd/lochnagar.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Lochnagar internals
> + *
> + * Copyright (c) 2013-2018 Cirrus Logic, Inc. and
> + *                         Cirrus Logic International Semiconductor Ltd.
> + *
> + * Author: Charles Keepax <ckeepax@opensource.cirrus.com>
> + */
> +
> +#ifndef CIRRUS_LOCHNAGAR_H
> +#define CIRRUS_LOCHNAGAR_H
> +
> +#include "lochnagar1_regs.h"
> +#include "lochnagar2_regs.h"

Why are you including these here?

> +struct device;
> +struct regmap;
> +struct mutex;

Just add the include files.

> +enum lochnagar_type {
> +	LOCHNAGAR1,
> +	LOCHNAGAR2,
> +};
> +
> +struct lochnagar {
> +	enum lochnagar_type type;
> +	struct device *dev;
> +	struct regmap *regmap;
> +
> +	/* Lock to protect updates to the analogue configuration */
> +	struct mutex analogue_config_lock;
> +};

Kerneldoc header please.

> +/* Register Addresses */
> +#define LOCHNAGAR_SOFTWARE_RESET                             0x00
> +#define LOCHNAGAR_FIRMWARE_ID1                               0x01
> +#define LOCHNAGAR_FIRMWARE_ID2                               0x02
> +
> +/* (0x0000)  Software Reset */
> +#define LOCHNAGAR_DEVICE_ID_MASK                           0xFFFC
> +#define LOCHNAGAR_DEVICE_ID_SHIFT                               2
> +#define LOCHNAGAR_REV_ID_MASK                              0x0003
> +#define LOCHNAGAR_REV_ID_SHIFT                                  0
> +
> +int lochnagar_update_config(struct lochnagar *lochnagar);
> +
> +#endif

> diff --git a/include/linux/mfd/lochnagar1_regs.h b/include/linux/mfd/lochnagar1_regs.h
> diff --git a/include/linux/mfd/lochnagar2_regs.h b/include/linux/mfd/lochnagar2_regs.h

So Lochnagar 1 and 2 are completely different devices?

What do they do?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
