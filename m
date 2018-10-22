Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C8BC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 05:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8154C20779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 05:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8154C20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbeJVOQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 10:16:36 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:36767 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeJVOQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 10:16:36 -0400
Received: from [10.18.29.185] (10.18.29.185) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Mon, 22 Oct
 2018 13:59:18 +0800
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
 <01d07c83-b17e-70b5-6e9b-8150ee3aedf2@amlogic.com>
 <153997220960.53599.2059896905852359614@swboyd.mtv.corp.google.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <9ddb0f0f-994c-b743-99cd-05ec094a6afc@amlogic.com>
Date:   Mon, 22 Oct 2018 13:59:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <153997220960.53599.2059896905852359614@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.29.185]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/20 2:03, Stephen Boyd wrote:
> Quoting Jianxin Pan (2018-10-19 09:12:53)
>> On 2018/10/19 1:13, Stephen Boyd wrote:
>>> Quoting Jianxin Pan (2018-10-17 22:07:25)
>>>> diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
>>>> index 305ee30..f96314d 100644
>>>> --- a/drivers/clk/meson/clk-regmap.c
>>>> +++ b/drivers/clk/meson/clk-regmap.c
>>>> @@ -113,8 +113,25 @@ static int clk_regmap_div_set_rate(struct clk_hw *hw, unsigned long rate,
>>>>                                   clk_div_mask(div->width) << div->shift, val);
>>>>  };
>>>>  
>>>> -/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */
>>>> +static void clk_regmap_div_init(struct clk_hw *hw)
>>>> +{
>>>> +       struct clk_regmap *clk = to_clk_regmap(hw);
>>>> +       struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
>>>> +       unsigned int val;
>>>> +       int ret;
>>>> +
>>>> +       ret = regmap_read(clk->map, div->offset, &val);
>>>> +       if (ret)
>>>> +               return;
>>>>  
>>>> +       val &= (clk_div_mask(div->width) << div->shift);
>>>> +       if (!val)
>>>> +               regmap_update_bits(clk->map, div->offset,
>>>> +                                  clk_div_mask(div->width) << div->shift,
>>>> +                                  clk_div_mask(div->width));
>>>> +}
>>>> +
>>>> +/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */
>>>
>>> We should add a patch to rename the symbol for qcom, i.e.
>>> qcom_clk_regmap_div_ro_ops, and then any symbols in this directory
>>> should be meson_clk_regmap_div_ro_ops.
>> "/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */"
>> This comment is not introduced in this patch.
>> I followed the naming style in this file and add clk_regmap_divider_with_init_ops.
>>
>> @Jerome， What's your suggestion about this？
> 
> Yes you don't need to fix anything in this series. Just saying that in
> the future we should work on cleaning this up.
> 
OK. Thank you!
> .
> 

