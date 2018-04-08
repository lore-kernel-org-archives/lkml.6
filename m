Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeDHDBi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 23:01:38 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:49750 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752458AbeDHDBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 23:01:37 -0400
Subject: Re: [PATCH v3 1/6] clk: meson: aoclk: refactor common code into
 dedicated file
To: Stephen Boyd <sboyd@kernel.org>, Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
References: <20180328025050.221585-1-yixun.lan@amlogic.com>
 <20180328025050.221585-2-yixun.lan@amlogic.com>
 <152303996277.94378.9360089743935547432@swboyd.mtv.corp.google.com>
CC: <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <9b56df24-7906-f539-51ec-b9f8b785e020@amlogic.com>
Date: Sun, 8 Apr 2018 11:00:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <152303996277.94378.9360089743935547432@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Stephen
 thanks for the review

On 04/07/18 02:39, Stephen Boyd wrote:
> Quoting Yixun Lan (2018-03-27 19:50:45)
>> diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
>> index 9ec23ae9a219..5a922639a264 100644
>> --- a/drivers/clk/meson/gxbb-aoclk.c
>> +++ b/drivers/clk/meson/gxbb-aoclk.c
>> @@ -165,38 +135,39 @@ static int gxbb_aoclkc_probe(struct platform_device *pdev)
>>                 return -ENODEV;
>>         }
>>  
>> -       /* Reset Controller */
>> -       rstc->regmap = regmap;
>> -       rstc->data = gxbb_aoclk_reset;
>> -       rstc->reset.ops = &gxbb_aoclk_reset_ops;
>> -       rstc->reset.nr_resets = ARRAY_SIZE(gxbb_aoclk_reset);
>> -       rstc->reset.of_node = dev->of_node;
>> -       ret = devm_reset_controller_register(dev, &rstc->reset);
>> -
>> -       /*
>> -        * Populate regmap and register all clks
>> -        */
>> -       for (clkid = 0; clkid < ARRAY_SIZE(gxbb_aoclk_gate); clkid++) {
>> -               gxbb_aoclk_gate[clkid]->map = regmap;
>> -
>> -               ret = devm_clk_hw_register(dev,
>> -                                          gxbb_aoclk_onecell_data.hws[clkid]);
>> -               if (ret)
>> -                       return ret;
>> -       }
>> -
>>         /* Specific clocks */
>>         cec_32k_ao.regmap = regmap;
>>         ret = devm_clk_hw_register(dev, &cec_32k_ao.hw);
>> -       if (ret)
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "clk cec_32k_ao register failed.\n");
>>                 return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static struct meson_aoclk_data gxbb_aoclkc_data = {
> 
> Can this be const?
> 
sure, I'll update at v4
>> +       .reset_reg      = AO_RTI_GEN_CNTL_REG0,
>> +       .num_reset      = ARRAY_SIZE(gxbb_aoclk_reset),
>> +       .reset          = gxbb_aoclk_reset,
>> +       .num_clks       = ARRAY_SIZE(gxbb_aoclk_gate),
>> +       .clks           = gxbb_aoclk_gate,
>> +       .hw_data        = &gxbb_aoclk_onecell_data,
>> +};
>> +
>> diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
>> new file mode 100644
>> index 000000000000..36067c801f7b
>> --- /dev/null
>> +++ b/drivers/clk/meson/meson-aoclk.c
>> @@ -0,0 +1,79 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Amlogic Meson-AXG Clock Controller Driver
>> + *
>> + * Copyright (c) 2016 BayLibre, SAS.
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + *
>> + * Copyright (c) 2018 Amlogic, inc.
>> + * Author: Qiufang Dai <qiufang.dai@amlogic.com>
>> + * Author: Yixun Lan <yixun.lan@amlogic.com>
>> + */
>> +
>> +#include <linux/platform_device.h>
>> +#include <linux/reset-controller.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/init.h>
>> +#include <linux/of_device.h>
>> +#include "clk-regmap.h"
>> +#include "meson-aoclk.h"
>> +
>> +static int meson_aoclk_do_reset(struct reset_controller_dev *rcdev,
>> +                              unsigned long id)
>> +{
>> +       struct meson_aoclk_reset_controller *rstc =
>> +               container_of(rcdev, struct meson_aoclk_reset_controller, reset);
>> +
>> +       return regmap_write(rstc->regmap, rstc->data->reset_reg,
>> +                           BIT(rstc->data->reset[id]));
>> +}
>> +
>> +static const struct reset_control_ops meson_aoclk_reset_ops = {
>> +       .reset = meson_aoclk_do_reset,
>> +};
>> +
>> +int meson_aoclkc_probe(struct platform_device *pdev)
>> +{
>> +       struct meson_aoclk_reset_controller *rstc;
>> +       struct meson_aoclk_data *data;
>> +       struct device *dev = &pdev->dev;
>> +       struct regmap *regmap;
>> +       int ret, clkid;
>> +
>> +       data = (struct meson_aoclk_data *)
>> +               of_device_get_match_data(dev);
>> +       if (!data)
>> +               return -ENODEV;
>> +
>> +       rstc = devm_kzalloc(dev, sizeof(*rstc), GFP_KERNEL);
>> +       if (!rstc)
>> +               return -ENOMEM;
>> +
>> +       regmap = syscon_node_to_regmap(of_get_parent(dev->of_node));
>> +       if (IS_ERR(regmap)) {
>> +               dev_err(dev, "failed to get regmap\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       /* Reset Controller */
>> +       rstc->data = data;
>> +       rstc->regmap = regmap;
>> +       rstc->reset.ops = &meson_aoclk_reset_ops;
>> +       rstc->reset.nr_resets = data->num_reset,
>> +       rstc->reset.of_node = dev->of_node;
>> +       ret = devm_reset_controller_register(dev, &rstc->reset);
> 
> Please check the return value here.
> 
will do, thanks for pointing out this

>> +
>> +       /*
>> +        * Populate regmap and register all clks
>> +        */
>> +       for (clkid = 0; clkid < data->num_clks; clkid++) {
>> +               data->clks[clkid]->map = regmap;
>> +
>> +               ret = devm_clk_hw_register(dev, data->hw_data->hws[clkid]);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
>> +               data->hw_data);
> 
> Use devm_ variant?
> 
sure
> I suppose because code is moving in this patch that it would be better
> to make improvements in another patch so that this patch is a pure code
> movement change instead of a movement + improvement change.
> 
I think it's a good idea to fix this in another independent patch

also I will address the comments you raised in another mail thread

Yixun
