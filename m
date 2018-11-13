Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FC0C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DE02245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I2Y8y48o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DE02245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbeKMS2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:28:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36626 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731378AbeKMS2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 13:28:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id s11so1162297wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 00:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=k/5spv9Cow1i2dfioRqgW2G8AUF3QCGLOMDToSivGQE=;
        b=I2Y8y48ojZ1CDqYlFdJr7GN/qrGsQq1TaZ7lCEn5sBQquS04mrCtxnM2LOJKs6dbwO
         YWTuMYoPb8LRwhcJm1IS6udl/3D2dRCO1izxjku3v3WIGFEikPIIm+dRd77qqtZS37xY
         1/FKVAyMnbEu8WGACab0ObiX96UjqON6nUYtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=k/5spv9Cow1i2dfioRqgW2G8AUF3QCGLOMDToSivGQE=;
        b=tCIvZw3cu5Yj5XAtqKPY12nOmxjaDbY75KxoVwH6XN0sr//WAIs3uE8iLWOQgMCJsd
         0yy40fMG/lAfHH+OXgWdhonoBMqFq5pq/YALebRpH3rqoYqS951qSwvqmDa8JchptKCe
         jE6UWWqT4NQSxMJkS2LcbhRj4lzSOOmXuIwZb0HLbOe0KS2AoIwN5J++QHxxQbF9F5ll
         2k+o+Nk/2dNxRzb7hP3l2eNLlSvO2HcgBbkMYV3B4KUa8H6B+0wKst6EMSHzHKtitS66
         hmIY1iM+NguOwcVMw45Xb9XazaKx8q/0cWwI0Os+ovIgJh9URKdaheDAVA6aTYRLxmVO
         Q9Zw==
X-Gm-Message-State: AGRZ1gLEKBonMeY41NiimhRBd8XU1wGHhR740d5d+pONA0t7waqpttw2
        Z7mWh2vT5dft4GfzlQ8DeaBcxw==
X-Google-Smtp-Source: AJdET5fXES+3Y+/G29esnhinahr85mSpogF2zHJRoCwwmcDTPETRYuoVHDE582+fl2gXQ0oPpgs/Xw==
X-Received: by 2002:a1c:e108:: with SMTP id y8-v6mr2197043wmg.2.1542097868273;
        Tue, 13 Nov 2018 00:31:08 -0800 (PST)
Received: from dell ([2.31.167.205])
        by smtp.gmail.com with ESMTPSA id l8-v6sm9780772wrm.88.2018.11.13.00.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 00:31:07 -0800 (PST)
Date:   Tue, 13 Nov 2018 08:31:05 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, broonie@kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 4/6] mfd: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20181113083105.GC3513@dell>
References: <20181108101405.14062-1-ckeepax@opensource.cirrus.com>
 <20181108101405.14062-5-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181108101405.14062-5-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Nov 2018, Charles Keepax wrote:

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
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Changes since v3:
>  - Bind in child drivers through device tree rather than using mfd_add_devices
>  - Remove defaults arrays for regmap
>  - Use a lot of ... in the regmap readable/volatile callbacks
>  - Explicitly include register headers, rather than relying on lochnagar.h
>  - Add some kernel doc
>  - Some minor cosmetic fixups
>  - Add a lockdep_assert in lochnagar_update_config
> 
> Thanks,
> Charles
> 
>  MAINTAINERS                         |  17 ++
>  drivers/mfd/Kconfig                 |   8 +
>  drivers/mfd/Makefile                |   2 +
>  drivers/mfd/lochnagar-i2c.c         | 394 ++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/lochnagar.h       |  55 +++++
>  include/linux/mfd/lochnagar1_regs.h | 157 ++++++++++++++
>  include/linux/mfd/lochnagar2_regs.h | 253 +++++++++++++++++++++++
>  7 files changed, 886 insertions(+)
>  create mode 100644 drivers/mfd/lochnagar-i2c.c
>  create mode 100644 include/linux/mfd/lochnagar.h
>  create mode 100644 include/linux/mfd/lochnagar1_regs.h
>  create mode 100644 include/linux/mfd/lochnagar2_regs.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f4855974f3250..0398c8752e610 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3567,6 +3567,23 @@ L:	netdev@vger.kernel.org
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
> +F:	drivers/pinctrl/cirrus/pinctrl-lochnagar*
> +F:	drivers/regulator/lochnagar-regulator.c
> +F:	include/dt-bindings/clk/lochnagar.h
> +F:	include/dt-bindings/pinctrl/lochnagar.h
> +F:	include/linux/mfd/lochnagar*
> +F:	Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt
> +F:	Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt
> +F:	Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt
> +F:	Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt
> +
>  CISCO FCOE HBA DRIVER
>  M:	Satish Kharat <satishkh@cisco.com>
>  M:	Sesidhar Baddela <sebaddel@cisco.com>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8c5dfdce4326c..51de2db3f6537 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1685,6 +1685,14 @@ config MFD_VX855
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
> index 12980a4ad4608..93284316d5307 100644
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
> index 0000000000000..133159d7646ed
> --- /dev/null
> +++ b/drivers/mfd/lochnagar-i2c.c
> @@ -0,0 +1,394 @@
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
> +#include <linux/lockdep.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/mfd/lochnagar.h>
> +#include <linux/mfd/lochnagar1_regs.h>
> +#include <linux/mfd/lochnagar2_regs.h>
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
> +	case LOCHNAGAR_FIRMWARE_ID1...LOCHNAGAR_FIRMWARE_ID2:
> +	case LOCHNAGAR1_CDC_AIF1_SEL...LOCHNAGAR1_CDC_AIF3_SEL:
> +	case LOCHNAGAR1_CDC_MCLK1_SEL...LOCHNAGAR1_CDC_MCLK2_SEL:
> +	case LOCHNAGAR1_CDC_AIF_CTRL1...LOCHNAGAR1_CDC_AIF_CTRL2:
> +	case LOCHNAGAR1_EXT_AIF_CTRL:
> +	case LOCHNAGAR1_DSP_AIF1_SEL...LOCHNAGAR1_DSP_AIF2_SEL:
> +	case LOCHNAGAR1_DSP_CLKIN_SEL:
> +	case LOCHNAGAR1_DSP_AIF:
> +	case LOCHNAGAR1_GF_AIF1...LOCHNAGAR1_GF_AIF2:
> +	case LOCHNAGAR1_PSIA_AIF:
> +	case LOCHNAGAR1_PSIA1_SEL...LOCHNAGAR1_PSIA2_SEL:
> +	case LOCHNAGAR1_SPDIF_AIF_SEL:
> +	case LOCHNAGAR1_GF_AIF3_SEL...LOCHNAGAR1_GF_AIF4_SEL:
> +	case LOCHNAGAR1_GF_CLKOUT1_SEL:
> +	case LOCHNAGAR1_GF_AIF1_SEL...LOCHNAGAR1_GF_AIF2_SEL:
> +	case LOCHNAGAR1_GF_GPIO2...LOCHNAGAR1_GF_GPIO7:
> +	case LOCHNAGAR1_RST:
> +	case LOCHNAGAR1_LED1...LOCHNAGAR1_LED2:
> +	case LOCHNAGAR1_I2C_CTRL:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

Niiiiiice!

Driver is much better for me to swallow like this.

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
