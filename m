Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D530C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 07:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A36A20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 07:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A36A20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeKCQkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 12:40:00 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:7454 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeKCQkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 12:40:00 -0400
Received: from [192.168.0.111] (223.167.21.242) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Sat, 3 Nov 2018
 15:29:31 +0800
Subject: Re: [PATCH v6 3/3] clk: meson: add sub MMC clock controller driver
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>,
        <yixun.lan@amlogic.com>, <khilman@baylibre.com>,
        <carlo@caione.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <miquel.raynal@bootlin.com>,
        <boris.brezillon@bootlin.com>, <liang.yang@amlogic.com>,
        <jian.hu@amlogic.com>, <qiufang.dai@amlogic.com>,
        <hanjie.lin@amlogic.com>, <victor.wan@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1541089855-19356-1-git-send-email-jianxin.pan@amlogic.com>
 <1541089855-19356-4-git-send-email-jianxin.pan@amlogic.com>
 <CAFBinCBbWCoA-f8-dPkT1KFrFAtwZcRZo-N6mj4YockTuNeDhQ@mail.gmail.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <86789d73-5a6c-7729-ecd1-dcd342b2fcde@amlogic.com>
Date:   Sat, 3 Nov 2018 15:29:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCBbWCoA-f8-dPkT1KFrFAtwZcRZo-N6mj4YockTuNeDhQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [223.167.21.242]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thanks for the review and suggestion. Please see my comments below.

On 2018/11/2 2:16, Martin Blumenstingl wrote:
> Hi Jianxin,
> 
> On Thu, Nov 1, 2018 at 5:31 PM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
>>
>> From: Yixun Lan <yixun.lan@amlogic.com>
>>
>> The patch will add a MMC clock controller driver which used by MMC or NAND,
>> It provide a mux and divider clock, and three phase clocks - core, tx, tx.
>>
>> Two clocks are provided as the parent of MMC clock controller from
>> upper layer clock controller - eg "amlogic,axg-clkc" in AXG platform.
>>
>> To specify which clock the MMC or NAND driver may consume,
>> the preprocessor macros in the dt-bindings/clock/amlogic,mmc-clkc.h header
>> can be used in the device tree sources.
>>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> this looks good to me in general, some comments below
> 
>> ---
>>  drivers/clk/meson/Kconfig      |  10 ++
>>  drivers/clk/meson/Makefile     |   1 +
>>  drivers/clk/meson/clk-regmap.c |   1 -
>>  drivers/clk/meson/mmc-clkc.c   | 310 +++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 321 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/clk/meson/mmc-clkc.c
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index efaa70f..6bb0d44 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -15,6 +15,16 @@ config COMMON_CLK_MESON_AO
>>         select COMMON_CLK_REGMAP_MESON
>>         select RESET_CONTROLLER
>>
>> +config COMMON_CLK_MMC_MESON
>> +       tristate "Meson MMC Sub Clock Controller Driver"
>> +       select MFD_SYSCON
>> +       select COMMON_CLK_AMLOGIC
>> +       select COMMON_CLK_AMLOGIC_AUDIO
>> +       help
>> +         Support for the MMC sub clock controller on Amlogic Meson Platform,
>> +         which include S905 (GXBB, GXL), A113D/X (AXG) devices.
> can you confirm that (in the future) we will be able to use this with
> G12A and G12B as well?
Yes, this part can be reused in G12A and G12B two. 
> 
>> +         Say Y if you want this clock enabled.
>> +
>>  config COMMON_CLK_REGMAP_MESON
>>         bool
>>         select REGMAP
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index 39ce566..31c16d5 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -9,4 +9,5 @@ obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>>  obj-$(CONFIG_COMMON_CLK_GXBB)   += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
>>  obj-$(CONFIG_COMMON_CLK_AXG)    += axg.o axg-aoclk.o
>>  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)     += axg-audio.o
>> +obj-$(CONFIG_COMMON_CLK_MMC_MESON)     += mmc-clkc.o
>>  obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)  += clk-regmap.o
>> diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
>> index 305ee30..89cee4a 100644
>> --- a/drivers/clk/meson/clk-regmap.c
>> +++ b/drivers/clk/meson/clk-regmap.c
>> @@ -114,7 +114,6 @@ static int clk_regmap_div_set_rate(struct clk_hw *hw, unsigned long rate,
>>  };
>>
>>  /* Would prefer clk_regmap_div_ro_ops but clashes with qcom */
>> -
> unnecessary whitespace change, personally I would drop this file from the patch
OK, I will remove the unnecessary whitespace change here. 
Thanks for your time. 
> 
>>  const struct clk_ops clk_regmap_divider_ops = {
>>         .recalc_rate = clk_regmap_div_recalc_rate,
>>         .round_rate = clk_regmap_div_round_rate,
>> diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
>> new file mode 100644
>> index 0000000..a3e4c91
>> --- /dev/null
>> +++ b/drivers/clk/meson/mmc-clkc.c
>> @@ -0,0 +1,310 @@
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
>> +#include <linux/clk-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include <linux/of_device.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/platform_device.h>
>> +#include <dt-bindings/clock/amlogic,mmc-clkc.h>
>> +
>> +#include "clkc.h"
>> +#include "clkc-audio.h"
>> +
>> +/* clock ID used by internal driver */
>> +#define CLKID_MMC_MUX                  0
>> +
>> +#define   SD_EMMC_CLOCK                0
>> +#define   CLK_DELAY_STEP_PS            200
>> +#define   CLK_PHASE_STEP               30
>> +#define   CLK_PHASE_POINT_NUM          (360 / CLK_PHASE_STEP)
> CLK_PHASE_STEP and CLK_PHASE_POINT_NUM are unused
YES, I will remove them.
>> +
>> +#define MUX_CLK_NUM_PARENTS            2
>> +#define MMC_MAX_CLKS                   5
>> +
>> +struct mmc_clkc_data {
>> +       struct meson_clk_phase_delay_data       tx;
>> +       struct meson_clk_phase_delay_data       rx;
>> +};
>> +
>> +static struct clk_regmap_mux_data mmc_clkc_mux_data = {
>> +       .offset         = SD_EMMC_CLOCK,
>> +       .mask           = 0x3,
>> +       .shift          = 6,
>> +};
>> +
>> +struct meson_sclk_div_data  mmc_clkc_div_data = {
> can this be const?
The member cached_div need to  be changed danymicly in clk ops.
In addition, there are more than one instances of the controller, so I will alloc them danymicly.
> also there are two whitespaces after meson_sclk_div_data
OK, I will remove it.
>> +       .div = {
>> +               .reg_off = SD_EMMC_CLOCK,
>> +               .shift   = (0),
>> +               .width   = (6),
>> +       },
>> +       .hi = {
>> +               .reg_off = 0,
>> +               .shift   = 0,
>> +               .width   = 0,
>> +       },
>> +};
>> +
>> +static struct meson_clk_phase_data mmc_clkc_core_phase = {
>> +       .ph = {
>> +               .reg_off        = SD_EMMC_CLOCK,
>> +               .shift  = 8,
>> +               .width  = 2,
>> +       }
>> +};
>> +
>> +static const struct mmc_clkc_data mmc_clkc_gx_data = {
>> +       .tx = {
>> +               .phase = {
>> +                       .reg_off        = SD_EMMC_CLOCK,
>> +                       .shift  = 10,
>> +                       .width  = 2,
>> +               },
>> +               .delay = {
>> +                       .reg_off        = SD_EMMC_CLOCK,
>> +                       .shift  = 16,
>> +                       .width  = 4,
>> +               },
>> +               .delay_step_ps  = CLK_DELAY_STEP_PS,
>> +       },
>> +       .rx = {
>> +               .phase = {
>> +                       .reg_off        = SD_EMMC_CLOCK,
>> +                       .shift  = 12,
>> +                       .width  = 2,
>> +               },
>> +               .delay = {
>> +                       .reg_off        = SD_EMMC_CLOCK,
>> +                       .shift  = 20,
>> +                       .width  = 4,
>> +               },
>> +               .delay_step_ps  = CLK_DELAY_STEP_PS,
>> +       },
>> +};
>> +
>> +static const struct mmc_clkc_data mmc_clkc_axg_data = {
>> +       .tx = {
>> +               .phase = {
>> +                       .reg_off        = SD_EMMC_CLOCK,
>> +                       .shift  = 10,
>> +                       .width  = 2,
>> +               },
>> +               .delay = {
>> +                       .reg_off        = SD_EMMC_CLOCK,
>> +                       .shift  = 16,
>> +                       .width  = 6,
>> +               },
>> +               .delay_step_ps  = CLK_DELAY_STEP_PS,
>> +       },
>> +       .rx = {
>> +               .phase = {
>> +                       .reg_off        = SD_EMMC_CLOCK,
>> +                       .shift  = 12,
>> +                       .width  = 2,
>> +               },
>> +               .delay = {
>> +                       .reg_off        = SD_EMMC_CLOCK,
>> +                       .shift  = 22,
>> +                       .width  = 6,
>> +               },
>> +               .delay_step_ps  = CLK_DELAY_STEP_PS,
>> +       },
>> +};
>> +
>> +static const struct of_device_id mmc_clkc_match_table[] = {
>> +       {
>> +               .compatible     = "amlogic,gx-mmc-clkc",
>> +               .data           = &mmc_clkc_gx_data
>> +       },
>> +       {
>> +               .compatible     = "amlogic,axg-mmc-clkc",
>> +               .data           = &mmc_clkc_axg_data
>> +       },
>> +       {}
>> +};
>> +MODULE_DEVICE_TABLE(of, mmc_clkc_match_table);
>> +
>> +static struct clk_regmap *
>> +mmc_clkc_register_clk(struct device *dev, struct regmap *map,
>> +                     struct clk_init_data *init,
>> +                     const char *suffix, void *data)
>> +{
>> +       struct clk_regmap *clk;
>> +       char *name;
>> +       int ret;
>> +
>> +       clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
>> +       if (!clk)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       name = kasprintf(GFP_KERNEL, "%s#%s", dev_name(dev), suffix);
> use devm_kasprintf here? this will allow you to get rid of the kfree below
mmc_clkc_register_clk need to kfree(name) when it returns.
But devm_kasprintf will keep the memory until the device is removed.
Thanks for your time.
>> +       if (!name)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       init->name = name;
>> +
>> +       clk->map = map;
>> +       clk->data = data;
>> +       clk->hw.init = init;
>> +
>> +       ret = devm_clk_hw_register(dev, &clk->hw);
>> +       if (ret)
>> +               clk = ERR_PTR(ret);
>> +
>> +       kfree(name);
>> +       return clk;
>> +}
>> +
>> +static struct clk_regmap *mmc_clkc_register_mux(struct device *dev,
>> +                                               struct regmap *map)
>> +{
>> +       const char *parent_names[MUX_CLK_NUM_PARENTS];
>> +       struct clk_init_data init;
>> +       struct clk_regmap *mux;
>> +       struct clk *clk;
>> +       int i;
>> +
>> +       for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
>> +               char name[8];
>> +
>> +               snprintf(name, sizeof(name), "clkin%d", i);
>> +               clk = devm_clk_get(dev, name);
>> +               if (IS_ERR(clk)) {
>> +                       if (clk != ERR_PTR(-EPROBE_DEFER))
>> +                               dev_err(dev, "Missing clock %s\n", name);
>> +                       return ERR_PTR((long)clk);
>> +               }
>> +
>> +               parent_names[i] = __clk_get_name(clk);
>> +       }
>> +
>> +       init.ops = &clk_regmap_mux_ops;
>> +       init.flags = CLK_SET_RATE_PARENT;
>> +       init.parent_names = parent_names;
>> +       init.num_parents = MUX_CLK_NUM_PARENTS;
>> +
>> +       mux = mmc_clkc_register_clk(dev, map, &init, "mux", &mmc_clkc_mux_data);
>> +       if (IS_ERR(mux))
>> +               dev_err(dev, "Mux clock registration failed\n");
>> +
>> +       return mux;
>> +}
>> +
>> +static struct clk_regmap *
>> +mmc_clkc_register_clk_with_parent(struct device *dev, struct regmap *map,
>> +                                 char *suffix, const struct clk_hw *hw,
>> +                                 unsigned long flags,
>> +                                 const struct clk_ops *ops, void *data)
>> +{
>> +       struct clk_init_data init;
>> +       struct clk_regmap *clk;
>> +       const char *parent_name = clk_hw_get_name(hw);
>> +
>> +       init.ops = ops;
>> +       init.flags = flags;
>> +       init.parent_names = &parent_name;
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
>> +       struct clk_regmap *clk, *core;
>> +
>> +       /*cast to drop the const in match->data*/
>> +       data = (struct mmc_clkc_data *)of_device_get_match_data(dev);
> can you declare the data variable as "const struct mmc_clkc_data
> *data;" instead?
&data->rx and &data->tx are saved as 'data' member in struct clk_regmap. And it's not a const variable.
struct clk_regmap {
	struct clk_hw	hw;
	struct regmap	*map;
	void		*data;
};
mmc_clkc_register_clk_with_parent(..., void *data) is shared with other clocks,and the *data for mmc_clkc_div_data is not const.
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
>> +                                   GFP_KERNEL);
>> +       if (!onecell_data)
>> +               return -ENOMEM;
>> +
>> +       clk = mmc_clkc_register_mux(dev, map);
>> +       if (IS_ERR(clk))
>> +               return PTR_ERR(clk);
>> +       onecell_data->hws[CLKID_MMC_MUX]                = &clk->hw,
>> +
>> +       clk = mmc_clkc_register_clk_with_parent(dev, map, "div",
>> +                                               &clk->hw,
>> +                                               CLK_SET_RATE_PARENT,
>> +                                               &meson_sclk_div_ops,
>> +                                               &mmc_clkc_div_data);
>> +       if (IS_ERR(clk))
>> +               return PTR_ERR(clk);
>> +       onecell_data->hws[CLKID_MMC_DIV]                = &clk->hw,
>> +
>> +       core = mmc_clkc_register_clk_with_parent(dev, map, "core",
>> +                                                &clk->hw,
>> +                                                CLK_SET_RATE_PARENT,
>> +                                                &meson_clk_phase_ops,
>> +                                                &mmc_clkc_core_phase);
>> +       if (IS_ERR(core))
>> +               return PTR_ERR(core);
>> +       onecell_data->hws[CLKID_MMC_PHASE_CORE]         = &core->hw,
>> +
>> +       clk = mmc_clkc_register_clk_with_parent(dev, map, "rx",
>> +                                               &core->hw,  0,
>> +                                               &meson_clk_phase_delay_ops,
>> +                                               &data->rx);
>> +       if (IS_ERR(clk))
>> +               return PTR_ERR(clk);
>> +       onecell_data->hws[CLKID_MMC_PHASE_RX]           = &clk->hw,
>> +
>> +       clk = mmc_clkc_register_clk_with_parent(dev, map, "tx",
>> +                                               &core->hw,  0,
>> +                                               &meson_clk_phase_delay_ops,
>> +                                               &data->tx);
>> +       if (IS_ERR(clk))
>> +               return PTR_ERR(clk);
>> +       onecell_data->hws[CLKID_MMC_PHASE_TX]           = &clk->hw,
>> +
>> +       onecell_data->num                               = MMC_MAX_CLKS;
>> +
>> +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>> +                                          onecell_data);
>> +}
>> +
>> +static struct platform_driver mmc_clkc_driver = {
>> +       .probe          = mmc_clkc_probe,
>> +       .driver         = {
>> +               .name   = "meson-mmc-clkc",
>> +               .of_match_table = of_match_ptr(mmc_clkc_match_table),
>> +       },
>> +};
>> +
>> +module_platform_driver(mmc_clkc_driver);
>> +
>> +MODULE_DESCRIPTION("Amlogic AXG MMC clock driver");
>> +MODULE_AUTHOR("Jianxin Pan <jianxin.pan@amlogic.com>");
>> +MODULE_LICENSE("GPL v2");
>> --
>> 1.9.1
>>
> 
> Regards
> Martin
> 
> .
> 

