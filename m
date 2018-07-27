Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456C3C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FC0208AC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FC0208AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388563AbeG0QOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:14:41 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:19397 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730771AbeG0QOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:14:41 -0400
Received: from [192.168.90.67] (61.170.236.39) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 27 Jul
 2018 22:52:31 +0800
Subject: Re: [PATCH v3 2/2] clk: meson: add sub MMC clock controller driver
To:     Stephen Boyd <sboyd@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
References: <20180712211244.11428-1-yixun.lan@amlogic.com>
 <20180712211244.11428-3-yixun.lan@amlogic.com>
 <153261840298.48062.2497103873681297587@swboyd.mtv.corp.google.com>
CC:     <yixun.lan@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, <linux-clk@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <f52d2511-bab7-2c39-cea7-8702e27d2ef8@amlogic.com>
Date:   Fri, 27 Jul 2018 22:52:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <153261840298.48062.2497103873681297587@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [61.170.236.39]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Stephen:

On 07/26/2018 11:20 PM, Stephen Boyd wrote:
> Quoting Yixun Lan (2018-07-12 14:12:44)
>> diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
>> new file mode 100644
>> index 000000000000..36c4c7cd69a6
>> --- /dev/null
>> +++ b/drivers/clk/meson/mmc-clkc.c
>> @@ -0,0 +1,367 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Amlogic Meson MMC Sub Clock Controller Driver
>> + *
>> + * Copyright (c) 2017 Baylibre SAS.
>> + * Author: Jerome Brunet <jbrunet@baylibre.com>
>> + *
>> + * Copyright (c) 2018 Amlogic, inc.
>> + * Author: Yixun Lan <yixun.lan@amlogic.com>
>> + */
>> +
>> +#include <linux/clk.h>
> 
> Is this include used?
> 
this is needed by clk_get_rate()
see drivers/clk/meson/mmc-clkc.c:204

>> +#include <linux/clk-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include <linux/of_device.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/platform_device.h>
>> +#include <dt-bindings/clock/amlogic,meson-mmc-clkc.h>
>> +
>> +#include "clkc.h"
>> +
>> +
>> +static struct clk_regmap *
>> +mmc_clkc_register_other_clk(struct device *dev, struct regmap *map,
>> +                           char *suffix, char *parent_suffix,
>> +                           unsigned long flags,
>> +                           const struct clk_ops *ops, void *data)
>> +{
>> +       struct clk_init_data init;
>> +       struct clk_regmap *clk;
>> +       char *parent;
>> +
>> +       parent = kasprintf(GFP_KERNEL, "%s#%s", dev_name(dev), parent_suffix);
>> +       if (!parent)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       init.ops = ops;
>> +       init.flags = flags;
>> +       init.parent_names = (const char* const []){ parent, };
> 
> Can't this just be &parent?
sure, I can fix this

> 
>> +       init.num_parents = 1;
>> +
>> +       clk = mmc_clkc_register_clk(dev, map, &init, suffix, data);
>> +       if (IS_ERR(clk))
>> +               dev_err(dev, "Core %s clock registration failed\n", suffix);
>> +
>> +       kfree(parent);
>> +       return clk;
>> +}
>> +
>> +static int mmc_clkc_probe(struct platform_device *pdev)
>> +{
>> +       struct clk_hw_onecell_data *onecell_data;
>> +       struct device *dev = &pdev->dev;
>> +       struct mmc_clkc_data *data;
>> +       struct regmap *map;
>> +       struct clk_regmap *mux, *div, *core, *rx, *tx;
>> +
>> +       data = (struct mmc_clkc_data *)of_device_get_match_data(dev);
> 
> This cast is unnecessary. Pleas remove.
> 
Ok, I will try to fix in next version


this was trying to silence the ’const‘ cast warning [1]
I could make a 'const struct mmc_clkc_data *data' declare, but need to
fix further cast warning issue..


[1] drivers/clk/meson/mmc-clkc.c: In function ‘mmc_clkc_probe’:
drivers/clk/meson/mmc-clkc.c:302:7: warning: assignment discards ‘const’
qualifier from pointer target type [-Wdiscarded-qualifiers]
  data = of_device_get_match_data(dev);
       ^



