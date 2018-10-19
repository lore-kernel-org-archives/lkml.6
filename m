Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB32ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5024F20838
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5024F20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbeJTATt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:19:49 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:6494 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbeJTATt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:19:49 -0400
Received: from [192.168.0.111] (223.166.104.93) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Sat, 20 Oct
 2018 00:12:53 +0800
Subject: Re: [PATCH v5 3/3] clk: meson: add sub MMC clock controller driver
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
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-4-git-send-email-jianxin.pan@amlogic.com>
 <153988282130.5275.17528969137837015544@swboyd.mtv.corp.google.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <01d07c83-b17e-70b5-6e9b-8150ee3aedf2@amlogic.com>
Date:   Sat, 20 Oct 2018 00:12:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <153988282130.5275.17528969137837015544@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [223.166.104.93]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/19 1:13, Stephen Boyd wrote:
> Quoting Jianxin Pan (2018-10-17 22:07:25)
>> diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
>> index 305ee30..f96314d 100644
>> --- a/drivers/clk/meson/clk-regmap.c
>> +++ b/drivers/clk/meson/clk-regmap.c
>> @@ -113,8 +113,25 @@ static int clk_regmap_div_set_rate(struct clk_hw *hw, unsigned long rate,
>>                                   clk_div_mask(div->width) << div->shift, val);
>>  };
>>  
>> -/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */
>> +static void clk_regmap_div_init(struct clk_hw *hw)
>> +{
>> +       struct clk_regmap *clk = to_clk_regmap(hw);
>> +       struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
>> +       unsigned int val;
>> +       int ret;
>> +
>> +       ret = regmap_read(clk->map, div->offset, &val);
>> +       if (ret)
>> +               return;
>>  
>> +       val &= (clk_div_mask(div->width) << div->shift);
>> +       if (!val)
>> +               regmap_update_bits(clk->map, div->offset,
>> +                                  clk_div_mask(div->width) << div->shift,
>> +                                  clk_div_mask(div->width));
>> +}
>> +
>> +/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */
> 
> We should add a patch to rename the symbol for qcom, i.e.
> qcom_clk_regmap_div_ro_ops, and then any symbols in this directory
> should be meson_clk_regmap_div_ro_ops.
"/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */"
This comment is not introduced in this patch.
I followed the naming style in this file and add clk_regmap_divider_with_init_ops.

@Jerome， What's your suggestion about this？
> 
> Or we should just give up and squash the regmap implementations together
> into a new clk_regmap set of ops.
> 
>>  const struct clk_ops clk_regmap_divider_ops = {
>>         .recalc_rate = clk_regmap_div_recalc_rate,
>>         .round_rate = clk_regmap_div_round_rate,
>> diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
>> new file mode 100644
>> index 0000000..5555e3f
>> --- /dev/null
>> +++ b/drivers/clk/meson/mmc-clkc.c
>> @@ -0,0 +1,296 @@
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
> clk-provider.h instead of clk.h?
OK.
> 
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include <linux/of_device.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/platform_device.h>
>> +#include <dt-bindings/clock/amlogic,mmc-clkc.h>
>> +
>> +
> [...]
>> +
>> +static struct clk_regmap *
>> +mmc_clkc_register_clk_with_parent(struct device *dev, struct regmap *map,
>> +                                 char *suffix, const char *parent,
>> +                                 unsigned long flags,
>> +                                 const struct clk_ops *ops, void *data)
>> +{
>> +       struct clk_init_data init;
>> +       struct clk_regmap *clk;
>> +
>> +       init.ops = ops;
>> +       init.flags = flags;
>> +       init.parent_names = (const char* const []){ parent, };
> 
> Can't we just assign &parent here?
OK. I will fix it in the next version.
> 
>> +       init.num_parents = 1;
>> +
>> +       clk = mmc_clkc_register_clk(dev, map, &init, suffix, data);
>> +       if (IS_ERR(clk))
>> +               dev_err(dev, "Core %s clock registration failed\n", suffix);
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
>> +       struct clk_regmap *mux, *div, *core, *rx, *tx;
>> +
>> +       data = (struct mmc_clkc_data *)of_device_get_match_data(dev);
> 
> Nitpick: Drop the cast.
OK. I will drop it.
Thanks for the review.

> 
>> +       if (!data)
>> +               return -ENODEV;
>> +
>> +       map = syscon_node_to_regmap(dev->of_node);
> 
> .
> 

