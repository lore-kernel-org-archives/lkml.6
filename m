Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D35C7112C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DBD20833
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19DBD20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeJXTZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:25:47 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:21872 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbeJXTZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:25:47 -0400
Received: from [10.18.29.185] (10.18.29.185) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 24 Oct
 2018 18:57:50 +0800
Subject: Re: [PATCH v5 1/3] clk: meson: add emmc sub clock phase delay driver
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
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-2-git-send-email-jianxin.pan@amlogic.com>
 <10a0572db79ef0cb4f345c8ba2685bea5670b1a5.camel@baylibre.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <04c6457f-4cc1-9af5-c56e-6880d5abc40d@amlogic.com>
Date:   Wed, 24 Oct 2018 18:57:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <10a0572db79ef0cb4f345c8ba2685bea5670b1a5.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.185]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/24 16:58, Jerome Brunet wrote:
> On Thu, 2018-10-18 at 13:07 +0800, Jianxin Pan wrote:
>> From: Yixun Lan <yixun.lan@amlogic.com>
[...]
>>
>> --- /dev/null
>> +++ b/drivers/clk/meson/clk-phase-delay.c
>> @@ -0,0 +1,79 @@
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
>> +#include <linux/clk-provider.h>
>> +#include "clkc.h"
>> +
>> +static int meson_clk_phase_delay_get_phase(struct clk_hw *hw)
>> +{
>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>> +	struct meson_clk_phase_delay_data *ph =
>> +		meson_clk_get_phase_delay_data(clk);
>> +	unsigned long period_ps, p, d;
>> +	int degrees;
>> +	u32 val;
>> +
>> +	regmap_read(clk->map, ph->phase.reg_off, &val);
>> +	p = PARM_GET(ph->phase.width, ph->phase.shift, val);
> 
> there is an helper for this: meson_parm_read()
OK. I will use meson_parm_read instead. Thanks for your review.

The result of regmap_read is shared by two PARM_GETs: phase and delay.
There will be one more register read when change to meson_parm_read, but I don't think it matters.

> 
>> +	degrees = p * 360 / (1 << (ph->phase.width));
>> +
>> +	period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
>> +				 clk_hw_get_rate(hw));
>> +
>> +	d = PARM_GET(ph->delay.width, ph->delay.shift, val);
>> +	degrees += d * ph->delay_step_ps * 360 / period_ps;
>> +	degrees %= 360;
>> +
>> +	return degrees;
>> +}
>> +
>> +static void meson_clk_apply_phase_delay(struct clk_regmap *clk,
>> +					unsigned int phase,
>> +					unsigned int delay)
> 
> This helper function is a bit overkill.
> simply call meson_parm_write() twice in meson_clk_phase_delay_set_phase().
OK. I will use meson_parm_write() instead.
With meson_parm_write(), there will be one more register read and write
> 
>> +{
>> +	struct meson_clk_phase_delay_data *ph = clk->data;
>> +	u32 val;
>> +
>> +	regmap_read(clk->map, ph->delay.reg_off, &val);
>> +	val = PARM_SET(ph->phase.width, ph->phase.shift, val, phase);
>> +	val = PARM_SET(ph->delay.width, ph->delay.shift, val, delay);
>> +	regmap_write(clk->map, ph->delay.reg_off, val);
>> +}
>> +
>> +static int meson_clk_phase_delay_set_phase(struct clk_hw *hw, int degrees)
>> +{
>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>> +	struct meson_clk_phase_delay_data *ph =
>> +		meson_clk_get_phase_delay_data(clk);
>> +	unsigned long period_ps, d = 0, r;
>> +	u64 p;
>> +
>> +	p = degrees % 360;
>> +	period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
>> +				 clk_hw_get_rate(hw));
>> +
>> +	/* First compute the phase index (p), the remainder (r) is the
>> +	 * part we'll try to acheive using the delays (d).
>> +	 */
>> +	r = do_div(p, 360 / (1 << (ph->phase.width)));
>> +	d = DIV_ROUND_CLOSEST(r * period_ps,
>> +			      360 * ph->delay_step_ps);
>> +	d = min(d, PMASK(ph->delay.width));
>> +
>> +	meson_clk_apply_phase_delay(clk, p, d);
>> +	return 0;
>> +}
>> +
>> +const struct clk_ops meson_clk_phase_delay_ops = {
>> +	.get_phase = meson_clk_phase_delay_get_phase,
>> +	.set_phase = meson_clk_phase_delay_set_phase,
>> +};
>> +EXPORT_SYMBOL_GPL(meson_clk_phase_delay_ops);
>> diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
>> index 6b96d55..3309d78 100644
>> --- a/drivers/clk/meson/clkc.h
>> +++ b/drivers/clk/meson/clkc.h
>> @@ -105,6 +105,18 @@ struct clk_regmap _name = {						\
>>  	},								\
>>  };
>>  
>> +struct meson_clk_phase_delay_data {
>> +	struct parm			phase;
>> +	struct parm			delay;
>> +	unsigned int			delay_step_ps;
>> +};
>> +
>> +static inline struct meson_clk_phase_delay_data *
>> +meson_clk_get_phase_delay_data(struct clk_regmap *clk)
>> +{
>> +	return (struct meson_clk_phase_delay_data *)clk->data;
>> +}
>> +
>>  /* clk_ops */
>>  extern const struct clk_ops meson_clk_pll_ro_ops;
>>  extern const struct clk_ops meson_clk_pll_ops;
>> @@ -112,5 +124,6 @@ struct clk_regmap _name = {						\
>>  extern const struct clk_ops meson_clk_mpll_ro_ops;
>>  extern const struct clk_ops meson_clk_mpll_ops;
>>  extern const struct clk_ops meson_clk_phase_ops;
>> +extern const struct clk_ops meson_clk_phase_delay_ops;
>>  
>>  #endif /* __CLKC_H */
> 
> 
> .
> 

