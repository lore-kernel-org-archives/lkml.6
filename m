Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FC0C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272BF24DCC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YxyRX/bG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272BF24DCC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754119AbeGCHLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:11:10 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42389 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbeGCHLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:11:08 -0400
Received: by mail-wr0-f195.google.com with SMTP id p1-v6so762337wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2lmwL/opJZr8Gy5m25J6Pfe7MJ4t2TNMo0wf8RlNL+o=;
        b=YxyRX/bGK64FUw1YXgtqg/sxhB4jBG4lgII+4EVglt61JRav9WuEBfxSjDgykboFFP
         6pxemJXpdF3B+fvY3wj5fQf5wWO7KV6Wwl3hpwEdyddCzays6HG/RnMNCBeD9EC6kWFN
         YlnBntV8i38ToaRroeB3F/cBlxGWhYYzNU1J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2lmwL/opJZr8Gy5m25J6Pfe7MJ4t2TNMo0wf8RlNL+o=;
        b=j1sP8s9rsvQyMkbQE7kxJWoRKiCZb3PZUwM+KrlaxJI4eKS2hb4oZeJ1YBB+T4wact
         iCtiWEJVkau77izM1cHnVoKWKVSgrxCLqNngoZ4SSIpB+3WKTF8nJlLJvwA7f6KrBAPl
         LzJlgAo7tuzNy6J30LN5NLs1h9yp7mwrO976XajtkFBqbOzFg8qyErSkhumU3ZLiWEI+
         2DuFdMW0ly0SIE63KqHC9n7e1I2hZEIv1RviYl34H97A8EWUBuCeupLTN4J3J8HaCo0o
         gmPbGVoXQYyZb0pZZtVuWoNOcJhn9ABaL2qUm0KlHkVvZLHGP2CV/rRlYR/Hvn10RPhY
         8Urw==
X-Gm-Message-State: APt69E1keISuAO6d+2NjSMV3Vbne1iiYZg0kuWJjPRm5joNbFXKNaT5O
        OODPqo4wXXeK0zdnvCyOKN+v9Q==
X-Google-Smtp-Source: AAOMgpfzExHNGlT8VUlBi3WmL9ynvfJR7hf2/xoVO33TgUbSwoBMShGeUEHn1cZflFm6eMToleF5nA==
X-Received: by 2002:adf:a86a:: with SMTP id l97-v6mr17933287wrc.164.1530601866661;
        Tue, 03 Jul 2018 00:11:06 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id q8-v6sm1025489wmb.3.2018.07.03.00.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 00:11:05 -0700 (PDT)
Date:   Tue, 3 Jul 2018 08:11:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     matthias.bgg@kernel.org, ulrich.hecht+renesas@gmail.com,
        laurent.pinchart@ideasonboard.com, ck.hu@mediatek.com,
        p.zabel@pengutronix.de, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, mchehab@kernel.org,
        rdunlap@infradead.org, sean.wang@mediatek.com,
        linux-clk@vger.kernel.org, linux@armlinux.org.uk,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [v3 03/10] mfd: mtk-mmsys: Add mmsys driver
Message-ID: <20180703071103.GE20176@dell>
References: <cover.1524820923.git.mbrugger@suse.com>
 <e0894c97775e46ce6d9a441dc05e2e2479a4b612.1524820923.git.mbrugger@suse.com>
 <20180430101826.GC5147@dell>
 <5269ccfd-0274-3c12-7eeb-5de923197d92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5269ccfd-0274-3c12-7eeb-5de923197d92@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018, Matthias Brugger wrote:
> On 30/04/18 12:18, Lee Jones wrote:
> > On Fri, 27 Apr 2018, matthias.bgg@kernel.org wrote:
> > 
> >> From: Matthias Brugger <mbrugger@suse.com>
> >>
> >> The MMSYS subsystem includes clocks and drm components.
> >> This patch adds a MFD device to probe both drivers from the same
> >> device tree compatible.
> >>
> >> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> >> ---
> >>  drivers/mfd/Kconfig     |  9 ++++++
> >>  drivers/mfd/Makefile    |  2 ++
> >>  drivers/mfd/mtk-mmsys.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 90 insertions(+)
> >>  create mode 100644 drivers/mfd/mtk-mmsys.c
> >>
> >> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> >> index b860eb5aa194..d23a3b9a2c58 100644
> >> --- a/drivers/mfd/Kconfig
> >> +++ b/drivers/mfd/Kconfig
> >> @@ -378,6 +378,15 @@ config MFD_MC13XXX_I2C
> >>  	help
> >>  	  Select this if your MC13xxx is connected via an I2C bus.
> >>  
> >> +config MFD_MEDIATEK_MMSYS
> >> +	tristate "Mediatek MMSYS interface"
> >> +	select MFD_CORE
> >> +	select REGMAP_MMIO
> >> +	help
> >> +	  Select this if you have a MMSYS subsystem in your SoC. The
> >> +	  MMSYS subsystem has at least a clock driver part and some
> >> +	  DRM components.
> >> +
> >>  config MFD_MXS_LRADC
> >>  	tristate "Freescale i.MX23/i.MX28 LRADC"
> >>  	depends on ARCH_MXS || COMPILE_TEST
> >> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> >> index d9d2cf0d32ef..b96118bd68d9 100644
> >> --- a/drivers/mfd/Makefile
> >> +++ b/drivers/mfd/Makefile
> >> @@ -98,6 +98,8 @@ obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
> >>  obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
> >>  obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
> >>  
> >> +obj-$(CONFIG_MFD_MEDIATEK_MMSYS) += mtk-mmsys.o
> >> +
> >>  obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
> >>  
> >>  obj-$(CONFIG_EZX_PCAP)		+= ezx-pcap.o
> >> diff --git a/drivers/mfd/mtk-mmsys.c b/drivers/mfd/mtk-mmsys.c
> >> new file mode 100644
> >> index 000000000000..c802343fb1c6
> >> --- /dev/null
> >> +++ b/drivers/mfd/mtk-mmsys.c
> >> @@ -0,0 +1,79 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +
> >> +/*
> >> + * mtk-mmsys.c -- Mediatek MMSYS multi-function driver
> >> + *
> >> + * Copyright (c) 2018 Matthias Brugger <matthias.bgg@gmail.com>
> >> + *
> >> + * Author: Matthias Brugger <matthias.bgg@gmail.com>
> >> + */
> >> +
> >> +#include <linux/module.h>
> >> +#include <linux/init.h>
> >> +#include <linux/mfd/core.h>
> >> +#include <linux/of.h>
> >> +#include <linux/of_address.h>
> >> +#include <linux/of_device.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/regmap.h>
> >> +
> >> +enum {
> >> +	MMSYS_MT2701 = 1,
> >> +};
> >> +
> >> +static const struct mfd_cell mmsys_mt2701_devs[] = {
> >> +	{ .name = "clk-mt2701-mm", },
> >> +	{ .name = "drm-mt2701-mm", },
> >> +};
> >> +
> >> +static int mmsys_probe(struct platform_device *pdev)
> >> +{
> >> +	const struct mfd_cell *mmsys_cells;
> >> +	int nr_cells;
> >> +	long id;
> >> +	int ret;
> >> +
> >> +	id = (long) of_device_get_match_data(&pdev->dev);
> >> +	if (!id) {
> >> +		dev_err(&pdev->dev, "of_device_get match_data() failed\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	switch (id) {
> >> +	case MMSYS_MT2701:
> >> +		mmsys_cells = mmsys_mt2701_devs;
> >> +		nr_cells = ARRAY_SIZE(mmsys_mt2701_devs);
> >> +		break;
> >> +	default:
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +	ret = devm_mfd_add_devices(&pdev->dev, 0, mmsys_cells, nr_cells,
> >> +					NULL, 0, NULL);
> >> +	if (ret) {
> >> +		dev_err(&pdev->dev, "failed to add MFD devices %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	return 0;
> >> +};
> > 
> > This driver is pretty pointless.  It doesn't actually do anything.
> > 
> > I think you just want to use "simple-mfd" instead.
> > 
> 
> I think the problem is, that right now we have two drivers which use the same
> devicetree binding, which are clk and drm driver. With a simple-mfd we would
> need two compatibles, and this would break backwards compatibility.

So what functionality does this driver provide you with that you do
not have currently?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
