Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7185CC67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DD72080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DD72080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbeLMEzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:55:09 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:19689 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbeLMEzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:55:09 -0500
Received: from [10.18.29.207] (10.18.29.207) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 13 Dec
 2018 12:55:25 +0800
Subject: Re: [PATCH RESEND v7 3/4] clk: meson: add sub MMC clock controller
 driver
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
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
References: <1544457877-51301-1-git-send-email-jianxin.pan@amlogic.com>
 <1544457877-51301-4-git-send-email-jianxin.pan@amlogic.com>
 <10f2875c9724d9d9dd4bd32eab1fa3f8e42a809c.camel@baylibre.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <11bb5068-2c93-a415-b295-6ca994621280@amlogic.com>
Date:   Thu, 13 Dec 2018 12:55:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <10f2875c9724d9d9dd4bd32eab1fa3f8e42a809c.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.207]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/12 0:59, Jerome Brunet wrote:
> On Tue, 2018-12-11 at 00:04 +0800, Jianxin Pan wrote:
>> From: Yixun Lan <yixun.lan@amlogic.com>
>>
[...]
>>  
>> +config COMMON_CLK_MMC_MESON
>> +	tristate "Meson MMC Sub Clock Controller Driver"
>> +	select MFD_SYSCON
>> +	select COMMON_CLK_AMLOGIC
>> +	select COMMON_CLK_AMLOGIC_AUDIO
> 
> No it is wrong for the mmc to select AUDIO clocks.
> If as a result of your patch sclk is needed for things, make the necessary
> change in the Makefile.
OK, I will add COMMON_CLK_AMLOGIC_SCLKDIV for sclk-div.
> 
[...]>> +#include <linux/clk.h>
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
> 
> Again having audio in the mmc controller is wrong.
> Please make the necessary rework.
Yes, I will split out sclk-div.h from clkc-audio.h in the next version.
Thanks for your time.
> 
>> +
>> +/* clock ID used by internal driver */
>> +#define CLKID_MMC_MUX			0
>> +
>> +#define   SD_EMMC_CLOCK		0
>            ^
> why the multiple space here ? this looks odd
I will check the alignement  in the whole patchset and fix them, Thank you.
> 
>> +#define   CLK_DELAY_STEP_PS		200
> 
> Please keep thing aligned aligned consistently.
> 
>> +
>> +#define MUX_CLK_NUM_PARENTS		2
>> +#define MMC_MAX_CLKS			5
>> +
>> +struct mmc_clkc_data {
>> +	struct meson_clk_phase_delay_data	tx;
>> +	struct meson_clk_phase_delay_data	rx;
> 
> Why use a tab above ?
OK
> 
>> +};
>> +
>> +static struct clk_regmap_mux_data mmc_clkc_mux_data = {
>> +	.offset		= SD_EMMC_CLOCK,
>> +	.mask		= 0x3,
>> +	.shift		= 6,
>> +};
>> +
>> +static const struct meson_sclk_div_data mmc_clkc_div_data = {
>> +	.div = {
>> +		.reg_off = SD_EMMC_CLOCK,
>> +		.shift   = (0),
>> +		.width   = (6),
> 
> Please remove the unncessary parenthesis
OK, I will remove them.
> 
>> +	},
>> +	.hi = {
>> +		.width   = 0,
>> +	},
> 
> structure is a static const, all non-list members will be zero
> drop the 
OK, I will remove it in the next version. 
> 
>> +	.flags = CLK_DIVIDER_ONE_BASED,
>> +};
>> +
>> +static struct meson_clk_phase_data mmc_clkc_core_phase = {
>> +	.ph = {
>> +		.reg_off	= SD_EMMC_CLOCK,
>> +		.shift	= 8,
>> +		.width	= 2,
>> +	}
>> +};
>> +
>> +static const struct mmc_clkc_data mmc_clkc_gx_data = {
>> +	.tx = {
>> +		.phase = {
>> +			.reg_off	= SD_EMMC_CLOCK,
>> +			.shift	= 10,
>> +			.width	= 2,
>> +		},
>> +		.delay = {
>> +			.reg_off	= SD_EMMC_CLOCK,
>> +			.shift	= 16,
>> +			.width	= 4,
>> +		},
> 
> Again, an effort on alignement would appreciated, same below
OK, I will fix them.
> 
>> +		.delay_step_ps	= CLK_DELAY_STEP_PS,
>> +	},
>> +	.rx = {
>> +		.phase = {
>> +			.reg_off	= SD_EMMC_CLOCK,
>> +			.shift	= 12,
>> +			.width	= 2,
>> +		},
>> +		.delay = {
>> +			.reg_off	= SD_EMMC_CLOCK,
>> +			.shift	= 20,
>> +			.width	= 4,
>> +		},
>> +		.delay_step_ps	= CLK_DELAY_STEP_PS,
>> +	},
>> +};
>> +
>> +static const struct mmc_clkc_data mmc_clkc_axg_data = {
>> +	.tx = {
>> +		.phase = {
>> +			.reg_off	= SD_EMMC_CLOCK,
>> +			.shift	= 10,
>> +			.width	= 2,
>> +		},
>> +		.delay = {
>> +			.reg_off	= SD_EMMC_CLOCK,
>> +			.shift	= 16,
>> +			.width	= 6,
>> +		},
>> +		.delay_step_ps	= CLK_DELAY_STEP_PS,
>> +	},
>> +	.rx = {
>> +		.phase = {
>> +			.reg_off	= SD_EMMC_CLOCK,
>> +			.shift	= 12,
>> +			.width	= 2,
>> +		},
>> +		.delay = {
>> +			.reg_off	= SD_EMMC_CLOCK,
>> +			.shift	= 22,
>> +			.width	= 6,
>> +		},
>> +		.delay_step_ps	= CLK_DELAY_STEP_PS,
>> +	},
>> +};
>> +
>> +static const struct of_device_id mmc_clkc_match_table[] = {
>> +	{
>> +		.compatible	= "amlogic,gx-mmc-clkc",
>> +		.data		= &mmc_clkc_gx_data
>> +	},
>> +	{
>> +		.compatible	= "amlogic,axg-mmc-clkc",
>> +		.data		= &mmc_clkc_axg_data
>> +	},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, mmc_clkc_match_table);
>> +
>> +static struct clk_regmap *
>> +mmc_clkc_register_clk(struct device *dev, struct regmap *map,
>> +		      struct clk_init_data *init,
>> +		      const char *suffix, void *data)
>> +{
>> +	struct clk_regmap *clk;
>> +	char *name;
>> +	int ret;
>> +
>> +	clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
>> +	if (!clk)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	name = kasprintf(GFP_KERNEL, "%s#%s", dev_name(dev), suffix);
>> +	if (!name)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	init->name = name;
>> +
> 
> nitpick: remove this newline
OK.
> 
>> +	clk->map = map;
>> +	clk->data = data;
>> +	clk->hw.init = init;
>> +
>> +	ret = devm_clk_hw_register(dev, &clk->hw);
>> +	if (ret)
>> +		clk = ERR_PTR(ret);
>> +
>> +	kfree(name);
>> +	return clk;
>> +}
>> +
>> +static struct clk_regmap *mmc_clkc_register_mux(struct device *dev,
>> +						struct regmap *map)
>> +{
>> +	const char *parent_names[MUX_CLK_NUM_PARENTS];
>> +	struct clk_init_data init;
>> +	struct clk_regmap *mux;
>> +	struct clk *clk;
>> +	int i;
>> +
>> +	for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
>> +		char name[8];
>> +
>> +		snprintf(name, sizeof(name), "clkin%d", i);
>> +		clk = devm_clk_get(dev, name);
>> +		if (IS_ERR(clk)) {
>> +			if (clk != ERR_PTR(-EPROBE_DEFER))
>> +				dev_err(dev, "Missing clock %s\n", name);
>> +			return ERR_PTR((long)clk);
> 
> I don't think this cast is necessary     ^
Yes, return clk is ok here.
> 
>> +		}
>> +
>> +		parent_names[i] = __clk_get_name(clk);
>> +	}
>> +
>> +	init.ops = &clk_regmap_mux_ops;
>> +	init.flags = CLK_SET_RATE_PARENT;
>> +	init.parent_names = parent_names;
>> +	init.num_parents = MUX_CLK_NUM_PARENTS;
>> +
>> +	mux = mmc_clkc_register_clk(dev, map, &init, "mux",
>> &mmc_clkc_mux_data);
>> +	if (IS_ERR(mux))
>> +		dev_err(dev, "Mux clock registration failed\n");
>> +
>> +	return mux;
>> +}
>> +
>> +static struct clk_regmap *
>> +mmc_clkc_register_clk_with_parent(struct device *dev, struct regmap *map,
>> +				  char *suffix, const struct clk_hw *hw,
>> +				  unsigned long flags,
>> +				  const struct clk_ops *ops, void *data)
>> +{
>> +	struct clk_init_data init;
>> +	struct clk_regmap *clk;
>> +	const char *parent_name = clk_hw_get_name(hw);
>> +
>> +	init.ops = ops;
>> +	init.flags = flags;
>> +	init.parent_names = &parent_name;
>> +	init.num_parents = 1;
>> +
>> +	clk = mmc_clkc_register_clk(dev, map, &init, suffix, data);
>> +	if (IS_ERR(clk))
>> +		dev_err(dev, "Core %s clock registration failed\n", suffix);
> 
>                                ^
> this function is not only called by the core clock, is it ?
OK, I will drop "Core" in this line.
> 
>> +
>> +	return clk;
>> +}
>> +
>> +static int mmc_clkc_probe(struct platform_device *pdev)
>> +{
>> +	struct clk_hw_onecell_data *onecell_data;
>> +	struct device *dev = &pdev->dev;
>> +	struct mmc_clkc_data *data;
>> +	struct regmap *map;
>> +	struct clk_regmap *clk, *core;
>> +	struct meson_sclk_div_data *div_data;
>> +
>> +	/*cast to drop the const in match->data*/
>> +	data = (struct mmc_clkc_data *)of_device_get_match_data(dev);
>> +	if (!data)
>> +		return -ENODEV;
>> +
>> +	map = syscon_node_to_regmap(dev->of_node);
>> +	if (IS_ERR(map)) {
>> +		dev_err(dev, "could not find mmc clock controller\n");
>> +		return PTR_ERR(map);
>> +	}
>> +
>> +	onecell_data = devm_kzalloc(dev, sizeof(*onecell_data) +
>> +				    sizeof(*onecell_data->hws) * MMC_MAX_CLKS,
>> +				    GFP_KERNEL);
>> +	if (!onecell_data)
>> +		return -ENOMEM;
>> +
>> +	clk = mmc_clkc_register_mux(dev, map);
>> +	if (IS_ERR(clk))
>> +		return PTR_ERR(clk);
>> +	onecell_data->hws[CLKID_MMC_MUX]		= &clk->hw,
> 
> It does not really need to have an ID or be in the onecell data if you are not
> going to expose it. On the other controllers, we are using the onecell for the
> registration as well, which is why there is unexpeosed IDs, but it is not the
> case here.
> 
> ... and please, stop with this unnecessary tab. a space will do. same below.
CLKID_MMC_MUX is an internal clock, and I will remove the ID and onecell date in the next version.
And I will double check and fix tabs. Thank you.
> 
>> +
>> +	div_data = devm_kzalloc(dev, sizeof(*div_data), GFP_KERNEL);
>> +	if (!div_data)
>> +		return -ENOMEM;
>> +	*div_data = mmc_clkc_div_data;
> 
> memcpy would be more appropriate.
Sure.
> 
>> +
>> +	clk = mmc_clkc_register_clk_with_parent(dev, map, "div",
>> +						&clk->hw,
[...]
> 
> 
> .
> 

