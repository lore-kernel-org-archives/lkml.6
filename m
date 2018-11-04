Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B13ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E852082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E852082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbeKEA1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 19:27:47 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:8755 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbeKEA1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 19:27:46 -0500
Received: from [192.168.0.111] (223.167.21.242) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Sun, 4 Nov 2018
 23:12:17 +0800
Subject: Re: [PATCH v6 1/3] clk: meson: add emmc sub clock phase delay driver
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
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1541089855-19356-1-git-send-email-jianxin.pan@amlogic.com>
 <1541089855-19356-2-git-send-email-jianxin.pan@amlogic.com>
 <154130056376.88331.17004780065573288593@swboyd.mtv.corp.google.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <efb9f8e2-8937-2a0a-6f13-2c4ed66fd6e4@amlogic.com>
Date:   Sun, 4 Nov 2018 23:12:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <154130056376.88331.17004780065573288593@swboyd.mtv.corp.google.com>
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

Hi Stephen,

Thanks for your review. 
Please see me comments below.

On 2018/11/4 11:02, Stephen Boyd wrote:
> Quoting Jianxin Pan (2018-11-01 09:30:53)
>> diff --git a/drivers/clk/meson/clk-phase-delay.c b/drivers/clk/meson/clk-phase-delay.c
>> new file mode 100644
>> index 0000000..83e74ed
>> --- /dev/null
>> +++ b/drivers/clk/meson/clk-phase-delay.c
>> @@ -0,0 +1,66 @@
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
>> +#include <linux/clk-provider.h>
>> +#include "clkc.h"
>> +
>> +static int meson_clk_phase_delay_get_phase(struct clk_hw *hw)
>> +{
>> +       struct clk_regmap *clk = to_clk_regmap(hw);
>> +       struct meson_clk_phase_delay_data *ph =
>> +               meson_clk_get_phase_delay_data(clk);
> 
> Nitpick: Do this after declaring variables because it splits a line.
OK. I will split the assignment into another line. Thank you.
> 
>> +       unsigned long period_ps, p, d;
>> +       int degrees;
>> +
>> +       p = meson_parm_read(clk->map, &ph->phase);
>> +       degrees = p * 360 / (1 << (ph->phase.width));
> 
> Nitpick: Remove useless parenthesis.
OK. I will remove them.
> 
>> +
>> +       period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
> 
> Is the cast necessary?
Yes, the cast can be droped. NSEC_PER_SEC is already defined wit type long.
> 
>> +                                clk_hw_get_rate(hw));
>> +
>> +       d = meson_parm_read(clk->map, &ph->delay);
>> +       degrees += d * ph->delay_step_ps * 360 / period_ps;
>> +       degrees %= 360;
>> +
>> +       return degrees;
>> +}
>> +
>> +static int meson_clk_phase_delay_set_phase(struct clk_hw *hw, int degrees)
>> +{
>> +       struct clk_regmap *clk = to_clk_regmap(hw);
>> +       struct meson_clk_phase_delay_data *ph =
>> +               meson_clk_get_phase_delay_data(clk);
>> +       unsigned long period_ps, d = 0, r;
>> +       u64 p;
>> +
>> +       p = degrees % 360;
> 
> We don't allow phase to be larger than 360 so this isn't needed.
OK, Thank you.
> 
>> +       period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
> 
> Drop the cast?
OK.
> 
>> +                                clk_hw_get_rate(hw));
>> +
>> +       /* First compute the phase index (p), the remainder (r) is the
> 
> Nitpick: Please leave /* on it's own line.
OK.
> 
>> +        * part we'll try to acheive using the delays (d).
>> +        */
>> +       r = do_div(p, 360 / (1 << (ph->phase.width)));
> 
> Drop useless parenthesis please.
OK, I will fix it. Thank you.
> 
>> +       d = DIV_ROUND_CLOSEST(r * period_ps,
>> +                             360 * ph->delay_step_ps);
>> +       d = min(d, PMASK(ph->delay.width));
>> +
>> +       meson_parm_write(clk->map, &ph->phase, p);
>> +       meson_parm_write(clk->map, &ph->delay, d);
>> +       return 0;
>> +}
> 
> .
> 

