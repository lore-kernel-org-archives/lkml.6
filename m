Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31911C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0331205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0331205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeJ3WfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:35:18 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:48908 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbeJ3WfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:35:18 -0400
Received: from [10.18.29.185] (10.18.29.185) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 30 Oct
 2018 21:41:38 +0800
Subject: Re: [PATCH v5 3/3] clk: meson: add sub MMC clock controller driver
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Neil Armstrong <narmstrong@baylibre.com>, <yixun.lan@amlogic.com>,
        <khilman@baylibre.com>, <carlo@caione.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <miquel.raynal@bootlin.com>, <boris.brezillon@bootlin.com>,
        <liang.yang@amlogic.com>, <jian.hu@amlogic.com>,
        <qiufang.dai@amlogic.com>, <hanjie.lin@amlogic.com>,
        <victor.wan@amlogic.com>, <linux-clk@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-4-git-send-email-jianxin.pan@amlogic.com>
 <a8d359208edfdc75cb5c6de378796f76e0572a0f.camel@baylibre.com>
 <eda2faf2-cf06-902d-36ff-48ceafcb4a4b@amlogic.com>
 <f4d239df2f1333b005680f9bfdd2eba93e7f86e5.camel@baylibre.com>
 <CAFBinCCuqUmVNdwUm7WbkHy1eWvOA5oQ5FcOuytbYNbgGcXnRQ@mail.gmail.com>
 <3723695d951e0d30e8a0117d336d8f268269a030.camel@baylibre.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <79e2e947-ea85-5f39-13b0-f5c67aff5949@amlogic.com>
Date:   Tue, 30 Oct 2018 21:41:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3723695d951e0d30e8a0117d336d8f268269a030.camel@baylibre.com>
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

Hi Jerome,

On 2018/10/29 3:16, Jerome Brunet wrote:
> On Thu, 2018-10-25 at 22:58 +0200, Martin Blumenstingl wrote:
>> Hi Jerome,
>>
>> On Thu, Oct 25, 2018 at 2:54 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>> [snip]
>>>>>> +static void clk_regmap_div_init(struct clk_hw *hw)
>>>>>> +{
>>>>>> + struct clk_regmap *clk = to_clk_regmap(hw);
>>>>>> + struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
>>>>>> + unsigned int val;
>>>>>> + int ret;
>>>>>> +
>>>>>> + ret = regmap_read(clk->map, div->offset, &val);
>>>>>> + if (ret)
>>>>>> +         return;
>>>>>>
>>>>>> + val &= (clk_div_mask(div->width) << div->shift);
>>>>>> + if (!val)
>>>>>> +         regmap_update_bits(clk->map, div->offset,
>>>>>> +                            clk_div_mask(div->width) << div->shift,
>>>>>> +                            clk_div_mask(div->width));
>>>>>
>>>>> This is wrong for several reasons:
>>>>> * You should hard code the initial value in the driver.
>>>>> * If shift is not 0, I doubt this will give the expected result.
>>>>
>>>> The value 0x00 of divider means nand clock off then read/write nand register is forbidden.
>>>
>>> That is not entirely true, you can access the clock register or you'd be in a
>>> chicken and egg situation.
>>>
>>>> Should we set the initial value in nand driver, or in sub emmc clk driver?
>>>
>>> In the nand driver, which is the consumer of the clock. see my previous comments
>>> about it.
>>
>> an old version of this series had the code still in the NAND driver
>> (by writing to the registers directly instead of using the clk API).
>> this looks pretty much like a "sclk-div" to me (as I commented in v3
>> of this series: [0]):
>> - value 0 means disabled
>> - positive divider values
>> - (probably no duty control, but that's optional as far as I
>> understand sclk-div)
>> - uses max divider value when enabling the clock
>>
>> if switching to sclk-div works then we can get rid of some duplicate code
> 
> It is possible:
> There is a couple of things to note though:
> 
> * sclk does not 'uses max divider value when enabling the clock': Since this
> divider can gate, it needs to save the divider value when disabling, since the
> divider value is no longer stored in the register,
> On init, this cached value is  saved as it is. If the divider is initially
> disabled, we have to set the cached value to something that makes sense, in case
> the clock is enabled without a prior call to clk_set_rate().
> 
> So in sclk, the clock setting is not changed nor hard coded in init, and this is
> a very important difference.
>  
> * Even if sclk zero value means gated, it is still a zero based divider, while
> eMMC/Nand divider is one based. It this controller was to sclk, then something
> needs to be done for this.
> 
> * Since sclk caches a value in its data, and there can multiple instance of eMMC
> /NAND clock controller, some care must be taken when registering the data.
> 
> Both the generic divider and sclk could work here ... it's up to you Jianxin.
Thank you for the detailed explanation.
I will use sclk here.

With generic divider, there is a WARNING in divider_recalc_rate() durning clk_register():
[    0.918238] ffe05000.clock-controller#div: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set
[    0.925581] WARNING: CPU: 3 PID: 1 at drivers/clk/clk-divider.c:127 divider_recalc_rate+0x88/0x90
Then I still need to hard code the initual value, or add CLK_DIVIDER_ALLOW_ZERO flags.
> 
>>
>>
>> Regards
>> Martin
>>
>>
>> [0] https://patchwork.kernel.org/patch/10607157/#22238243
> 
> 
> .
> 

