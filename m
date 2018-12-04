Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7C1C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31DCA2082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DCA2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbeLDI2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:28:11 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:39586 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLDI2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:28:11 -0500
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gU638-0006sj-ST from Jiada_Wang@mentor.com ; Tue, 04 Dec 2018 00:27:22 -0800
Received: from [172.30.112.76] (147.34.91.1) by svr-orw-mbx-03.mgc.mentorg.com
 (147.34.90.203) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 4 Dec
 2018 00:27:19 -0800
Subject: Re: [PATCH linux-next v2 6/6] ASoC: rsnd: add avb clocks
To:     Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20181203112427.18324-1-jiada_wang@mentor.com>
 <e42bdbde-0d1a-eb1f-58af-ef4cf468ac38@mentor.com>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <92855669-0970-e6d6-fee6-2a0b97f6082b@mentor.com>
Date:   Tue, 4 Dec 2018 17:27:17 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e42bdbde-0d1a-eb1f-58af-ef4cf468ac38@mentor.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir

Thanks for your comments
I will address your findings in next version

Thanks,
Jiada

On 2018/12/03 21:53, Vladimir Zapolskiy wrote:
> Hi Jiada,
>
> On 12/03/2018 01:24 PM, jiada_wang@mentor.com wrote:
>> From: Jiada Wang <jiada_wang@mentor.com>
>>
>> There are AVB Counter Clocks in ADG, each clock has 12bits integral
>> and 8 bits fractional dividers which operates with S0D1ϕ clock.
>>
>> This patch registers 8 AVB Counter Clocks when clock-cells of
>> rcar_sound node is 2,
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>   sound/soc/sh/rcar/adg.c  | 306 +++++++++++++++++++++++++++++++++++++--
>>   sound/soc/sh/rcar/gen.c  |   9 ++
>>   sound/soc/sh/rcar/rsnd.h |   9 ++
>>   3 files changed, 315 insertions(+), 9 deletions(-)
>>
>> diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
>> index 6768a66588eb..2c03d420ae76 100644
>> --- a/sound/soc/sh/rcar/adg.c
>> +++ b/sound/soc/sh/rcar/adg.c
>> @@ -5,6 +5,8 @@
>>   //  Copyright (C) 2013  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>   
>>   #include <linux/clk-provider.h>
>> +#include <linux/of_address.h>
>> +#include <dt-bindings/clock/renesas-adg.h>
> Drop the inclusion of the header above, see my comment to patch 5/6.
>
>>   #include "rsnd.h"
>>   
>>   #define CLKA	0
>> @@ -21,13 +23,33 @@
>>   
>>   #define BRRx_MASK(x) (0x3FF & x)
>>   
>> +#define ADG_CLK_NAME		"adg"
>> +#define AVB_CLK_NAME		"avb"
> Can you please remove two macro above and replace their usage by values in
> clk_register_avb() function?
>
> Also I don't think that it is good to hardcode parent clock name here,
> likely you should get it in runtime, see __clk_get_name().
>
>> +#define AVB_CLK_NUM		8
>> +#define AVB_CLK_NAME_SIZE	10
> The one macro above also can be removed in my opinion.
>
>> +#define AVB_MAX_RATE		25000000
>> +#define AVB_DIV_EN_COM		BIT(31)
>> +#define AVB_DIV_MASK		0x3ffff
>> +#define AVB_MAX_DIV		0x3ffc0
>> +
>>   static struct rsnd_mod_ops adg_ops = {
>>   	.name = "adg",
>>   };
>>   
>> +struct clk_avb {
>> +	struct clk_hw hw;
>> +	unsigned int idx;
>> +	struct rsnd_mod *mod;
>> +	/* lock reg access */
>> +	spinlock_t *lock;
>> +};
>> +
>> +#define to_clk_avb(_hw) container_of(_hw, struct clk_avb, hw)
>> +
>>   struct rsnd_adg {
>>   	struct clk *clk[CLKMAX];
>>   	struct clk *clkout[CLKOUTMAX];
>> +	struct clk *clkavb[AVB_CLK_NUM];
>>   	struct clk_onecell_data onecell;
>>   	struct rsnd_mod mod;
>>   	u32 flags;
>> @@ -37,6 +59,7 @@ struct rsnd_adg {
>>   
>>   	int rbga_rate_for_441khz; /* RBGA */
>>   	int rbgb_rate_for_48khz;  /* RBGB */
>> +	spinlock_t avb_lock;
>>   };
>>   
>>   #define LRCLK_ASYNC	(1 << 0)
>> @@ -408,6 +431,239 @@ void rsnd_adg_clk_control(struct rsnd_priv *priv, int enable)
>>   	}
>>   }
>>   
>> +static struct clk *rsnd_adg_clk_src_twocell_get(struct of_phandle_args *clkspec,
>> +						void *data)
>> +{
>> +	unsigned int clkidx = clkspec->args[1];
>> +	struct rsnd_adg *adg = data;
>> +	const char *type;
>> +	struct clk *clk;
>> +
>> +	switch (clkspec->args[0]) {
>> +	case ADG_FIX:
>> +		type = "fixed";
> Apparently you need 'type' local variable just to print an error message.
>
> Please remove the variable and update format strings accordingly.
>
>> +		if (clkidx >= CLKOUTMAX) {
>> +			pr_err("Invalid %s clock index %u\n", type,
>> +			       clkidx);
>> +			return ERR_PTR(-EINVAL);
>> +		}
>> +		clk = adg->clkout[clkidx];
>> +		break;
>> +	case ADG_AVB:
>> +		type = "avb";
>> +		if (clkidx >= AVB_CLK_NUM) {
>> +			pr_err("Invalid %s clock index %u\n", type,
>> +			       clkidx);
>> +			return ERR_PTR(-EINVAL);
>> +		}
>> +		clk = adg->clkavb[clkidx];
>> +		break;
>> +	default:
>> +		pr_err("Invalid ADG clock type %u\n", clkspec->args[0]);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	return clk;
>> +}
>> +
>> +static void clk_avb_div_write(struct rsnd_mod *mod, u32 data, int idx)
> unsigned int idx to match a type of 'struct clk_avb' field.
>
>> +{
>> +	switch (idx) {
>> +	case 0:
>> +		rsnd_mod_write(mod, AVB_CLK_DIV0, data);
>> +		break;
>> +	case 1:
>> +		rsnd_mod_write(mod, AVB_CLK_DIV1, data);
>> +		break;
>> +	case 2:
>> +		rsnd_mod_write(mod, AVB_CLK_DIV2, data);
>> +		break;
>> +	case 3:
>> +		rsnd_mod_write(mod, AVB_CLK_DIV3, data);
>> +		break;
>> +	case 4:
>> +		rsnd_mod_write(mod, AVB_CLK_DIV4, data);
>> +		break;
>> +	case 5:
>> +		rsnd_mod_write(mod, AVB_CLK_DIV5, data);
>> +		break;
>> +	case 6:
>> +		rsnd_mod_write(mod, AVB_CLK_DIV6, data);
>> +		break;
>> +	case 7:
>> +		rsnd_mod_write(mod, AVB_CLK_DIV7, data);
>> +		break;
>> +	}
>> +}
>> +
>> +static u32 clk_avb_div_read(struct rsnd_mod *mod, int idx)
> unsigned int idx to match a type of 'struct clk_avb' field.
>
>> +{
>> +	u32 val = 0;
>> +
>> +	switch (idx) {
>> +	case 0:
>> +		val = rsnd_mod_read(mod, AVB_CLK_DIV0);
>> +		break;
>> +	case 1:
>> +		val = rsnd_mod_read(mod, AVB_CLK_DIV1);
>> +		break;
>> +	case 2:
>> +		val = rsnd_mod_read(mod, AVB_CLK_DIV2);
>> +		break;
>> +	case 3:
>> +		val = rsnd_mod_read(mod, AVB_CLK_DIV3);
>> +		break;
>> +	case 4:
>> +		val = rsnd_mod_read(mod, AVB_CLK_DIV4);
>> +		break;
>> +	case 5:
>> +		val = rsnd_mod_read(mod, AVB_CLK_DIV5);
>> +		break;
>> +	case 6:
>> +		val = rsnd_mod_read(mod, AVB_CLK_DIV6);
>> +		break;
>> +	case 7:
>> +		val = rsnd_mod_read(mod, AVB_CLK_DIV7);
>> +		break;
>> +	}
>> +
>> +	return val;
>> +}
> Apparently the macro nature of rsnd_mod_read() and rsnd_mod_write()
> does not allow to define a helper mapping function from index into
> RSND_REG_AVB_CLK_DIVx, okay...
>
>> +
>> +static int clk_avb_is_enabled(struct clk_hw *hw)
>> +{
>> +	struct clk_avb *avb = to_clk_avb(hw);
>> +
>> +	return rsnd_mod_read(avb->mod, AVB_CLK_CONFIG) & BIT(avb->idx);
>> +}
>> +
>> +static int clk_avb_enabledisable(struct clk_hw *hw, int enable)
>> +{
>> +	struct clk_avb *avb = to_clk_avb(hw);
>> +	u32 val;
>> +
>> +	spin_lock(avb->lock);
>> +
>> +	val = rsnd_mod_read(avb->mod, AVB_CLK_CONFIG);
>> +	if (enable)
>> +		val |= BIT(avb->idx);
>> +	else
>> +		val &= ~BIT(avb->idx);
>> +	rsnd_mod_write(avb->mod, AVB_CLK_CONFIG,  val);
>> +
>> +	spin_unlock(avb->lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int clk_avb_enable(struct clk_hw *hw)
>> +{
>> +	return clk_avb_enabledisable(hw, 1);
>> +}
>> +
>> +static void clk_avb_disable(struct clk_hw *hw)
>> +{
>> +	clk_avb_enabledisable(hw, 0);
>> +}
>> +
>> +static unsigned long clk_avb_recalc_rate(struct clk_hw *hw,
>> +					 unsigned long parent_rate)
>> +{
>> +	struct clk_avb *avb = to_clk_avb(hw);
>> +	u32 div;
>> +
>> +	div = clk_avb_div_read(avb->mod, avb->idx) & AVB_DIV_MASK;
>> +	if (!div)
>> +		return parent_rate;
>> +
>> +	return parent_rate * 32 / div;
>> +}
>> +
>> +static unsigned int clk_avb_calc_div(unsigned long rate,
>> +				     unsigned long parent_rate)
>> +{
>> +	unsigned int div;
>> +
>> +	if (!rate)
>> +		rate = 1;
>> +
>> +	if (rate > AVB_MAX_RATE)
>> +		rate = AVB_MAX_RATE;
>> +
>> +	div = DIV_ROUND_CLOSEST(parent_rate * 32, rate);
>> +
>> +	if (div > AVB_MAX_DIV)
>> +		div = AVB_MAX_DIV;
>> +
>> +	return div;
>> +}
>> +
>> +static long clk_avb_round_rate(struct clk_hw *hw, unsigned long rate,
>> +			       unsigned long *parent_rate)
>> +{
>> +	unsigned int div = clk_avb_calc_div(rate, *parent_rate);
>> +
>> +	return (*parent_rate * 32) / div;
>> +}
>> +
>> +static int clk_avb_set_rate(struct clk_hw *hw, unsigned long rate,
>> +			    unsigned long parent_rate)
>> +{
>> +	struct clk_avb *avb = to_clk_avb(hw);
>> +	unsigned int div = clk_avb_calc_div(rate, parent_rate);
>> +	u32 val;
>> +
>> +	val = clk_avb_div_read(avb->mod, avb->idx) & ~AVB_DIV_MASK;
>> +	clk_avb_div_write(avb->mod, val | div, avb->idx);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct clk_ops clk_avb_ops = {
>> +	.enable = clk_avb_enable,
>> +	.disable = clk_avb_disable,
>> +	.is_enabled = clk_avb_is_enabled,
>> +	.recalc_rate = clk_avb_recalc_rate,
>> +	.round_rate = clk_avb_round_rate,
>> +	.set_rate = clk_avb_set_rate,
>> +};
>> +
>> +static struct clk *clk_register_avb(struct device *dev, struct rsnd_mod *mod,
>> +				    unsigned int id, spinlock_t *lock)
>> +{
>> +	struct clk_init_data init;
>> +	struct clk_avb *avb;
>> +	struct clk *clk;
>> +	char name[AVB_CLK_NAME_SIZE];
>> +	const char *parent_name = ADG_CLK_NAME;
>> +
>> +	avb = devm_kzalloc(dev, sizeof(*avb), GFP_KERNEL);
>> +	if (!avb)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	snprintf(name, AVB_CLK_NAME_SIZE, "%s%u", AVB_CLK_NAME, id);
>> +
>> +	avb->idx = id;
>> +	avb->lock = lock;
>> +	avb->mod = mod;
>> +
>> +	/* Register the clock. */
>> +	init.name = name;
>> +	init.ops = &clk_avb_ops;
>> +	init.flags = CLK_IS_BASIC;
>> +	init.parent_names = &parent_name;
>> +	init.num_parents = 1;
>> +
>> +	avb->hw.init = &init;
>> +
>> +	/* init DIV to a valid state */
>> +	clk_avb_div_write(avb->mod, avb->idx, AVB_MAX_DIV);
>> +
>> +	clk = devm_clk_register(dev, &avb->hw);
>> +
>> +	return clk;
>> +}
>> +
>>   static void rsnd_adg_get_clkin(struct rsnd_priv *priv,
>>   			       struct rsnd_adg *adg)
>>   {
>> @@ -436,6 +692,7 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
>>   	unsigned long req_48kHz_rate, req_441kHz_rate;
>>   	int i, req_size;
>>   	const char *parent_clk_name = NULL;
>> +	struct rsnd_mod *mod = rsnd_mod_get(adg);
>>   	static const char * const clkout_name[] = {
>>   		[CLKOUT]  = "audio_clkout",
>>   		[CLKOUT1] = "audio_clkout1",
>> @@ -540,21 +797,23 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
>>   	 */
>>   
>>   	of_property_read_u32(np, "#clock-cells", &count);
>> -	/*
>> -	 * for clkout
>> -	 */
>> -	if (!count) {
>> +
>> +	switch (count) {
>> +	case 0:
>> +		/*
>> +		 * for clkout
>> +		 */
>>   		clk = clk_register_fixed_rate(dev, clkout_name[CLKOUT],
>>   					      parent_clk_name, 0, req_rate[0]);
>>   		if (!IS_ERR(clk)) {
>>   			adg->clkout[CLKOUT] = clk;
>>   			of_clk_add_provider(np, of_clk_src_simple_get, clk);
>>   		}
>> -	}
>> -	/*
>> -	 * for clkout0/1/2/3
>> -	 */
>> -	else {
>> +		break;
>> +	case 1:
>> +		/*
>> +		 * for clkout0/1/2/3
>> +		 */
>>   		for (i = 0; i < CLKOUTMAX; i++) {
>>   			clk = clk_register_fixed_rate(dev, clkout_name[i],
>>   						      parent_clk_name, 0,
>> @@ -566,6 +825,33 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
>>   		adg->onecell.clk_num	= CLKOUTMAX;
>>   		of_clk_add_provider(np, of_clk_src_onecell_get,
>>   				    &adg->onecell);
>> +		break;
>> +	case 2:
>> +		/*
>> +		 * for clkout0/1/2/3 and avb clocks
>> +		 */
>> +		for (i = 0; i < CLKOUTMAX; i++) {
>> +			clk = clk_register_fixed_rate(dev, clkout_name[i],
>> +						      parent_clk_name, 0,
>> +						      req_rate[0]);
>> +			if (!IS_ERR(clk))
>> +				adg->clkout[i] = clk;
>> +		}
>> +
>> +		for (i = 0; i < AVB_CLK_NUM; i++) {
>> +			clk = clk_register_avb(dev, mod, i, &adg->avb_lock);
>> +			if (!IS_ERR(clk))
>> +				adg->clkavb[i] = clk;
>> +		}
>> +
>> +		of_clk_add_provider(np, rsnd_adg_clk_src_twocell_get, adg);
>> +
>> +		rsnd_mod_write(mod, AVB_CLK_CONFIG, AVB_DIV_EN_COM);
>> +
>> +		break;
>> +	default:
>> +		dev_err(dev, "Invalid clock-cell %d\n", count);
>> +		break;
>>   	}
>>   
>>   rsnd_adg_get_clkout_end:
>> @@ -612,6 +898,8 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
>>   	if (!adg)
>>   		return -ENOMEM;
>>   
>> +	spin_lock_init(&adg->avb_lock);
>> +
>>   	ret = rsnd_mod_init(priv, &adg->mod, &adg_ops,
>>   		      NULL, 0, 0);
>>   	if (ret)
> --
> Best wishes,
> Vladimir

