Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA0AC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DCA24325
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RuDIJmyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00DCA24325
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeGDQpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:45:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38961 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbeGDQpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:45:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so6755893wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 09:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aactvCows1AkreTbU3Qqayn5q1dnLn2WB2lU1KaiGbY=;
        b=RuDIJmyQBIVBlNltSsVglJO/Aq09ZTEcQvXcYDycxGPR9vc3CKfG5H/NJEwmuby1un
         A8gau2CUsVISGGPoX2z1fThxg1dqd9Sogn5AtVXqEnkKNN0+36bEV19+p1Jx7lxIKmfV
         nKoAppoAMpkpQXiApb0DTSzmfQlM/OH2r6lgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aactvCows1AkreTbU3Qqayn5q1dnLn2WB2lU1KaiGbY=;
        b=Z+Ol5mvXOH9qbOcfTB7sO48+EiQjYrQHtFUHWPlkSZzu0q5JU3WI9IDSuDkk15Lrqi
         KlNk7Da8fOxFo2yjDJspCqTMx42fGuP0wecZVEOmZYp8FAhXmZVQpC3Er+O9zrpOIo2G
         QW1GYCyo+X2mmdgEoAZTDOSH4NfMdOYuvgFWgVoMm1dp+u7+QMv63Qq+iiu31oPd9GJT
         9F/TcGlcicEuEQC+3axelF6BQWX50v59wfifrpL3CwJvgU06emQ8ri996oh30Of92bPs
         tlelu1N+gw0f711lce48TNxb7N0zNnDskCrvun6NPWDi/j/qTBrtwU1mf/e4oW+5+7iM
         Eq5Q==
X-Gm-Message-State: APt69E3NK9VImt/RkFLr9tDdTidqsbZvc0YZxn8KoF8zmjsNxBVB9ciR
        56BJYSturnT490KIdi49fqYA1Q==
X-Google-Smtp-Source: AAOMgpc4PyRm881sgzUjmBLZiuT0+/xjPG6i7o1c9JWjc6DzrGoGaixG5LFyUHJHn/FHjhIHpeKioQ==
X-Received: by 2002:adf:fb43:: with SMTP id c3-v6mr2278060wrs.32.1530722743363;
        Wed, 04 Jul 2018 09:45:43 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id o4-v6sm9201299wra.3.2018.07.04.09.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 09:45:42 -0700 (PDT)
Date:   Wed, 4 Jul 2018 17:45:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Brugger <mbrugger@suse.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, matthias.bgg@kernel.org,
        ulrich.hecht+renesas@gmail.com, laurent.pinchart@ideasonboard.com,
        ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, mchehab@kernel.org,
        rdunlap@infradead.org, sean.wang@mediatek.com,
        linux-clk@vger.kernel.org, linux@armlinux.org.uk,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [v3 03/10] mfd: mtk-mmsys: Add mmsys driver
Message-ID: <20180704164540.GH496@dell>
References: <cover.1524820923.git.mbrugger@suse.com>
 <e0894c97775e46ce6d9a441dc05e2e2479a4b612.1524820923.git.mbrugger@suse.com>
 <20180430101826.GC5147@dell>
 <5269ccfd-0274-3c12-7eeb-5de923197d92@gmail.com>
 <20180703071103.GE20176@dell>
 <b6301691-a9f6-64fe-dd8a-ffe51fad6799@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6301691-a9f6-64fe-dd8a-ffe51fad6799@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jul 2018, Matthias Brugger wrote:

> 
> 
> On 03/07/18 09:11, Lee Jones wrote:
> > On Mon, 25 Jun 2018, Matthias Brugger wrote:
> >> On 30/04/18 12:18, Lee Jones wrote:
> >>> On Fri, 27 Apr 2018, matthias.bgg@kernel.org wrote:
> >>>
> >>>> From: Matthias Brugger <mbrugger@suse.com>
> >>>>
> >>>> The MMSYS subsystem includes clocks and drm components.
> >>>> This patch adds a MFD device to probe both drivers from the same
> >>>> device tree compatible.
> >>>>
> >>>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> >>>> ---
> >>>>  drivers/mfd/Kconfig     |  9 ++++++
> >>>>  drivers/mfd/Makefile    |  2 ++
> >>>>  drivers/mfd/mtk-mmsys.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
> >>>>  3 files changed, 90 insertions(+)
> >>>>  create mode 100644 drivers/mfd/mtk-mmsys.c
> >>>>
> >>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> >>>> index b860eb5aa194..d23a3b9a2c58 100644
> >>>> --- a/drivers/mfd/Kconfig
> >>>> +++ b/drivers/mfd/Kconfig
> >>>> @@ -378,6 +378,15 @@ config MFD_MC13XXX_I2C
> >>>>  	help
> >>>>  	  Select this if your MC13xxx is connected via an I2C bus.
> >>>>  
> >>>> +config MFD_MEDIATEK_MMSYS
> >>>> +	tristate "Mediatek MMSYS interface"
> >>>> +	select MFD_CORE
> >>>> +	select REGMAP_MMIO
> >>>> +	help
> >>>> +	  Select this if you have a MMSYS subsystem in your SoC. The
> >>>> +	  MMSYS subsystem has at least a clock driver part and some
> >>>> +	  DRM components.
> >>>> +
> >>>>  config MFD_MXS_LRADC
> >>>>  	tristate "Freescale i.MX23/i.MX28 LRADC"
> >>>>  	depends on ARCH_MXS || COMPILE_TEST
> >>>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> >>>> index d9d2cf0d32ef..b96118bd68d9 100644
> >>>> --- a/drivers/mfd/Makefile
> >>>> +++ b/drivers/mfd/Makefile
> >>>> @@ -98,6 +98,8 @@ obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
> >>>>  obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
> >>>>  obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
> >>>>  
> >>>> +obj-$(CONFIG_MFD_MEDIATEK_MMSYS) += mtk-mmsys.o
> >>>> +
> >>>>  obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
> >>>>  
> >>>>  obj-$(CONFIG_EZX_PCAP)		+= ezx-pcap.o
> >>>> diff --git a/drivers/mfd/mtk-mmsys.c b/drivers/mfd/mtk-mmsys.c
> >>>> new file mode 100644
> >>>> index 000000000000..c802343fb1c6
> >>>> --- /dev/null
> >>>> +++ b/drivers/mfd/mtk-mmsys.c
> >>>> @@ -0,0 +1,79 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0+
> >>>> +
> >>>> +/*
> >>>> + * mtk-mmsys.c -- Mediatek MMSYS multi-function driver
> >>>> + *
> >>>> + * Copyright (c) 2018 Matthias Brugger <matthias.bgg@gmail.com>
> >>>> + *
> >>>> + * Author: Matthias Brugger <matthias.bgg@gmail.com>
> >>>> + */
> >>>> +
> >>>> +#include <linux/module.h>
> >>>> +#include <linux/init.h>
> >>>> +#include <linux/mfd/core.h>
> >>>> +#include <linux/of.h>
> >>>> +#include <linux/of_address.h>
> >>>> +#include <linux/of_device.h>
> >>>> +#include <linux/platform_device.h>
> >>>> +#include <linux/regmap.h>
> >>>> +
> >>>> +enum {
> >>>> +	MMSYS_MT2701 = 1,
> >>>> +};
> >>>> +
> >>>> +static const struct mfd_cell mmsys_mt2701_devs[] = {
> >>>> +	{ .name = "clk-mt2701-mm", },
> >>>> +	{ .name = "drm-mt2701-mm", },
> >>>> +};
> >>>> +
> >>>> +static int mmsys_probe(struct platform_device *pdev)
> >>>> +{
> >>>> +	const struct mfd_cell *mmsys_cells;
> >>>> +	int nr_cells;
> >>>> +	long id;
> >>>> +	int ret;
> >>>> +
> >>>> +	id = (long) of_device_get_match_data(&pdev->dev);
> >>>> +	if (!id) {
> >>>> +		dev_err(&pdev->dev, "of_device_get match_data() failed\n");
> >>>> +		return -EINVAL;
> >>>> +	}
> >>>> +
> >>>> +	switch (id) {
> >>>> +	case MMSYS_MT2701:
> >>>> +		mmsys_cells = mmsys_mt2701_devs;
> >>>> +		nr_cells = ARRAY_SIZE(mmsys_mt2701_devs);
> >>>> +		break;
> >>>> +	default:
> >>>> +		return -ENODEV;
> >>>> +	}
> >>>> +
> >>>> +	ret = devm_mfd_add_devices(&pdev->dev, 0, mmsys_cells, nr_cells,
> >>>> +					NULL, 0, NULL);
> >>>> +	if (ret) {
> >>>> +		dev_err(&pdev->dev, "failed to add MFD devices %d\n", ret);
> >>>> +		return ret;
> >>>> +	}
> >>>> +
> >>>> +	return 0;
> >>>> +};
> >>>
> >>> This driver is pretty pointless.  It doesn't actually do anything.
> >>>
> >>> I think you just want to use "simple-mfd" instead.
> >>>
> >>
> >> I think the problem is, that right now we have two drivers which use the same
> >> devicetree binding, which are clk and drm driver. With a simple-mfd we would
> >> need two compatibles, and this would break backwards compatibility.
> > 
> > So what functionality does this driver provide you with that you do
> > not have currently?
> > 
> 
> I'm not sure if I get your question. Point is, that the MMSYS implementation for
> mt8173 is broken, as it assumes that we can probe two drivers with the
> mediatek,mt8173-mmsys compatible. Somehow it used to work, but from what I
> understand it was a bug. So older devicetrees use just on mt8173-mmsys
> compatible in ther DTB.

Okay, that is what I was getting at.  Thanks for the explanation.

Do you have a datasheet I can look at?

> I would like to keep backwards compatibility for the device tree, that's why I
> was searching for a solution where we can probe two drivers and came up with
> this mfd solution.
>
> So no new functionality, the clk driver provides the clock the drm components need.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
