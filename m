Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7599C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13B324633
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13B324633
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933481AbeGDHSC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:18:02 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:10441 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752918AbeGDHSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:18:00 -0400
Received: from [192.168.90.200] (10.18.20.235) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 4 Jul 2018
 15:17:11 +0800
Subject: Re: [PATCH 3/3] clk: meson: add sub EMMC clock controller driver
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20180703145716.31860-1-yixun.lan@amlogic.com>
 <20180703145716.31860-4-yixun.lan@amlogic.com>
 <CAFBinCCFQr+_k7bkda0a3wVQdyG8DzEyim6v_OBikUifCxyVXg@mail.gmail.com>
CC:     <yixun.lan@amlogic.com>, <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        <khilman@baylibre.com>, <carlo@caione.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <miquel.raynal@bootlin.com>, <boris.brezillon@bootlin.com>,
        <liang.yang@amlogic.com>, <qiufang.dai@amlogic.com>,
        <jian.hu@amlogic.com>, <linux-clk@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <ad673997-927e-76f4-23a4-bcf28f269968@amlogic.com>
Date:   Wed, 4 Jul 2018 15:17:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCCFQr+_k7bkda0a3wVQdyG8DzEyim6v_OBikUifCxyVXg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin


On 07/04/18 02:58, Martin Blumenstingl wrote:
> Hi Yixun,
> 
> apart from what Jerome found this looks good to me.
> one small "issue" and a question are inline below
> 
> On Tue, Jul 3, 2018 at 9:00 AM Yixun Lan <yixun.lan@amlogic.com> wrote:
>>
>> This patch will add a EMMC clock controller driver support,
>> It provide a mux and divider clock.
>>
>> This clock driver can be protentially used by either EMMC and
>> NAND driver.
>>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  drivers/clk/meson/Kconfig     |   9 +++
>>  drivers/clk/meson/Makefile    |   1 +
>>  drivers/clk/meson/emmc-clkc.c | 136 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 146 insertions(+)
>>  create mode 100644 drivers/clk/meson/emmc-clkc.c
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index efaa70f682b4..2f27ff08e4eb 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -15,6 +15,15 @@ config COMMON_CLK_MESON_AO
>>         select COMMON_CLK_REGMAP_MESON
>>         select RESET_CONTROLLER
>>
>> +config COMMON_CLK_EMMC_MESON
>> +       tristate "Meson EMMC Sub Clock Controller Driver"
>> +       depends on COMMON_CLK_AMLOGIC
>> +       select MFD_SYSCON
>> +       select REGMAP
>> +       help
>> +         Support for the EMMC sub clock controller on AmLogic Meson Platform,
>> +         Say Y if you want this clock enabled.
>> +
>>  config COMMON_CLK_REGMAP_MESON
>>         bool
>>         select REGMAP
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index 72ec8c40d848..2f04f77ba4de 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -9,4 +9,5 @@ obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>>  obj-$(CONFIG_COMMON_CLK_GXBB)   += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
>>  obj-$(CONFIG_COMMON_CLK_AXG)    += axg.o axg-aoclk.o
>>  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)     += axg-audio.o
>> +obj-$(CONFIG_COMMON_CLK_EMMC_MESON)    += emmc-clkc.o
>>  obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)  += clk-regmap.o
>> diff --git a/drivers/clk/meson/emmc-clkc.c b/drivers/clk/meson/emmc-clkc.c
>> new file mode 100644
>> index 000000000000..cf5bb9f34327
>> --- /dev/null
>> +++ b/drivers/clk/meson/emmc-clkc.c
>> @@ -0,0 +1,136 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Amlogic Meson EMMC Sub Clock Controller Driver
>> + *
>> + * Copyright (c) 2018 Amlogic, inc.
>> + * Author: Yixun Lan <yixun.lan@amlogic.com>
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/init.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#include <dt-bindings/clock/emmc-clkc.h>
>> +
>> +#include "clkc.h"
>> +
>> +#define SD_EMMC_CLOCK          0
>> +#define MUX_CLK_NUM_PARENTS    2
>> +#define EMMC_MAX_CLKS          2
>> +#define CLK_NAME_LEN           48
>> +
>> +static struct clk_regmap_mux_data emmc_clkc_mux_data = {
>> +       .offset = SD_EMMC_CLOCK,
>> +       .mask = 0x3,
>> +       .shift = 6,
>> +};
>> +
>> +static struct clk_regmap_div_data emmc_clkc_div_data = {
>> +       .offset = SD_EMMC_CLOCK,
>> +       .shift = 0,
>> +       .width = 6,
>> +       .flags = CLK_DIVIDER_ROUND_CLOSEST | CLK_DIVIDER_ONE_BASED,
>> +};
>> +
>> +static const struct of_device_id clkc_match_table[] = {
>> +       { .compatible = "amlogic,emmc-clkc" },
> shouldn't this be "amlogic,meson-axg-emmc-clkc" (and optionally also
> "amlogic,meson-gx-emmc-clkc")?
> 
sounds good to me..
is it a convention to always make the compatible specific ?..

>> +       {}
>> +};
>> +
>> +static int emmc_clkc_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct clk_regmap *mux, *div;
>> +       struct regmap *map;
>> +       struct clk *clk;
>> +       int i, ret;
>> +       const char *parent_names[MUX_CLK_NUM_PARENTS];
>> +       struct clk_init_data init;
>> +       char mux_name[CLK_NAME_LEN], div_name[CLK_NAME_LEN];
>> +       struct clk_hw_onecell_data *onecell_data;
>> +
>> +       map = syscon_node_to_regmap(dev->of_node);
>> +
>> +       mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
>> +       div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
>> +
>> +       onecell_data = devm_kzalloc(dev, sizeof(*onecell_data) +
>> +                                   sizeof(*onecell_data->hws) * EMMC_MAX_CLKS,
>> +                                   GFP_KERNEL);
>> +
>> +       if (!mux || !div || !onecell_data)
>> +               return -ENOMEM;
>> +
>> +       for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
>> +               char name[8];
>> +
>> +               snprintf(name, sizeof(name), "clkin%d", i);
>> +               clk = devm_clk_get(dev, name);
>> +               if (IS_ERR(clk)) {
>> +                       if (clk != ERR_PTR(-EPROBE_DEFER))
>> +                               dev_err(dev, "Missing clock %s\n", name);
>> +                       return PTR_ERR(clk);
>> +               }
>> +
>> +               parent_names[i] = __clk_get_name(clk);
>> +       }
>> +
>> +       mux->map = map;
>> +       mux->data = &emmc_clkc_mux_data;
>> +
>> +       snprintf(mux_name, CLK_NAME_LEN, "%s#emmc_mux", dev_name(dev));
>> +
>> +       init.name = mux_name;
>> +       init.ops = &clk_regmap_mux_ops;
>> +       init.flags = CLK_SET_RATE_PARENT;
>> +       init.parent_names = parent_names;
>> +       init.num_parents = MUX_CLK_NUM_PARENTS;
>> +
>> +       mux->hw.init = &init;
>> +       ret = devm_clk_hw_register(dev, &mux->hw);
>> +       if (ret) {
>> +               dev_err(dev, "Mux clock registration failed\n");
>> +               return ret;
>> +       }
>> +
>> +       parent_names[0] = mux_name;
>> +       div->map = map;
>> +       div->data = &emmc_clkc_div_data;
>> +
>> +       snprintf(div_name, CLK_NAME_LEN, "%s#emmc_div", dev_name(dev));
>> +
>> +       init.name = div_name;
>> +       init.ops = &clk_regmap_divider_ops;
>> +       init.flags = CLK_SET_RATE_PARENT;
>> +       init.parent_names = parent_names;
>> +       init.num_parents = 1;
>> +
>> +       div->hw.init = &init;
>> +       ret = devm_clk_hw_register(dev, &div->hw);
>> +       if (ret) {
>> +               dev_err(dev, "Div clock registration failed\n");
>> +               return ret;
>> +       }
>> +
>> +       onecell_data->hws[CLKID_EMMC_C_MUX] = &mux->hw,
>> +       onecell_data->hws[CLKID_EMMC_C_DIV] = &div->hw,
>> +       onecell_data->num = EMMC_MAX_CLKS;
> you are describing the mux and the divider here
> however, meson-gx-mmc.c has a few more clock related bits:
> - CLK_CORE_PHASE_MASK
> - CLK_TX_PHASE_MASK
> - CLK_RX_PHASE_MASK
> - CLK_V2_TX_DELAY_MASK / CLK_V3_TX_DELAY_MASK
> - CLK_V2_RX_DELAY_MASK / CLK_V3_RX_DELAY_MASK
> - CLK_V2_ALWAYS_ON / CLK_V3_ALWAYS_ON
> 
> are these used for the MMC clock or are some of these routed to the
> NAND pins as well?

There clocks are not used in NAND driver..

I understand your concern here, if there clocks are also routed to NAND
pins, then we also need to implement them here
actually, to answer your question, I need to query the ASIC team..

> 
> 
> Regards
> Martin
> 
> .
> 

