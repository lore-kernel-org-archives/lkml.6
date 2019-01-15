Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE87FC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8625920657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbfAOQ3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:29:16 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:52524 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731531AbfAOQ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:29:13 -0500
Received: from [192.168.0.111] (223.166.104.240) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1591.10; Wed, 16 Jan
 2019 00:29:52 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Subject: Re: [PATCH v8 4/4] clk: meson: add sub MMC clock controller driver
To:     Stephen Boyd <sboyd@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1545063850-21504-1-git-send-email-jianxin.pan@amlogic.com>
 <1545063850-21504-5-git-send-email-jianxin.pan@amlogic.com>
 <154706693724.15366.10802936604309826132@swboyd.mtv.corp.google.com>
Message-ID: <5d25f6a4-7a5f-b2c7-f8b3-c59fa36fe989@amlogic.com>
Date:   Wed, 16 Jan 2019 00:29:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <154706693724.15366.10802936604309826132@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [223.166.104.240]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh.amlogic.com
 (10.18.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thank you for your time.
Please see my comments below.

On 2019/1/10 4:48, Stephen Boyd wrote:
> Quoting Jianxin Pan (2018-12-17 08:24:10)
>> diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
>> new file mode 100644
>> index 0000000..2582a98
>> --- /dev/null
>> +++ b/drivers/clk/meson/mmc-clkc.c
>> @@ -0,0 +1,304 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Amlogic Meson MMC Sub Clock Controller Driver
>> + *
>> + * Copyright (c) 2017 Baylibre SAS.
>> + * Author: Jerome Brunet <jbrunet@baylibre.com>
>> + *
>> + * Copyright (c) 2018 Amlogic, inc.
>> + * Author: Yixun Lan <yixun.lan@amlogic.com>
>> + * Author: Jianxin Pan <jianxin.pan@amlogic.com>
>> + */
>> +
>> +#include <linux/clk.h>
> 
> Do you need this include?
> 
Yes, It's also a clock-consumer. 
devm_clk_get() gets clock from dts as the parent of mux.
Thank you for your review.
>> +#include <linux/clk-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include <linux/of_device.h>
>> +#include <linux/mfd/syscon.h>
> 
> Is this used?
Yes, syscon_node_to_regmap() is used in mmc_clkc_probe().
> 
>> +#include <linux/platform_device.h>
> [...]
>> +       init.num_parents = 1;
>> +
>> +       clk = mmc_clkc_register_clk(dev, map, &init, suffix, data);
>> +       if (IS_ERR(clk))
>> +               dev_err(dev, "%s clock registration failed\n", suffix);
>> +
>> +       return clk;
>> +}
>> +
>> +static int mmc_clkc_probe(struct platform_device *pdev)
>> +{
>> +       struct clk_hw_onecell_data *onecell_data;
>> +       struct device *dev = &pdev->dev;
>> +       struct mmc_clkc_data *data;
>> +       struct regmap *map;
>> +       struct clk_regmap *clk, *core;
>> +       struct meson_sclk_div_data *div_data;
>> +
>> +       /*cast to drop the const in match->data*/
>> +       data = (struct mmc_clkc_data *)of_device_get_match_data(dev);
> 
> Is that necessary? Maybe the users of this should take a const argument
> and copy things?
OK, I can alloc two extra memory for PHASE_RX and PHASE_TX data, and then copy from const data to them.
> 
>> +       if (!data)
>> +               return -ENODEV;
>> +
>> +       map = syscon_node_to_regmap(dev->of_node);
>> +       if (IS_ERR(map)) {
>> +               dev_err(dev, "could not find mmc clock controller\n");
>> +               return PTR_ERR(map);
>> +       }
>> +
>> +       onecell_data = devm_kzalloc(dev, sizeof(*onecell_data) +
>> +                                   sizeof(*onecell_data->hws) * MMC_MAX_CLKS,
> 
> struct_size()?
> 
OK, I will change it in the next version.
Thank you for your review.
> .
> 

