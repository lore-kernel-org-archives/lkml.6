Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1A1C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C462172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C462172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeI1Oxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:53:37 -0400
Received: from mail-sz2.amlogic.com ([211.162.65.114]:14064 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeI1Oxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:53:37 -0400
Received: from [10.28.18.92] (10.28.18.92) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 28 Sep
 2018 16:31:27 +0800
Subject: Re: [PATCH v4 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <jianxin.pan@amlogic.com>, <boris.brezillon@bootlin.com>,
        <linux-mtd@lists.infradead.org>, <yixun.lan@amlogic.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <richard@nod.at>, <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>, <carlo@caione.org>,
        <khilman@baylibre.com>, <robh@kernel.org>, <jian.hu@amlogic.com>,
        <hanjie.lin@amlogic.com>, <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1537433449-65213-1-git-send-email-jianxin.pan@amlogic.com>
 <1537433449-65213-3-git-send-email-jianxin.pan@amlogic.com>
 <CAFBinCAaphyifUNyDQr7th2Mt=A+UQnzai0edKLCPNbxhh2w+Q@mail.gmail.com>
 <f75b6f23-6d58-2145-30f3-b23e4b69966b@amlogic.com>
 <CAFBinCBLfoqnLK_hu6fufO4MXKKoRDPDuJgLasCNYWeuL6tCKw@mail.gmail.com>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <6ed594d7-ca01-1b07-e68a-2998c1f9c263@amlogic.com>
Date:   Fri, 28 Sep 2018 16:31:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCBLfoqnLK_hu6fufO4MXKKoRDPDuJgLasCNYWeuL6tCKw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.92]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/27/2018 5:12 PM, Martin Blumenstingl wrote:
> Hello Liang,
> 
> On Thu, Sep 27, 2018 at 10:19 AM Liang Yang <liang.yang@amlogic.com> wrote:
>>
>> Hello Martin,
>>
>> On 9/22/2018 11:32 PM, Martin Blumenstingl wrote:
>>> Hello,
>>>
>>> On Thu, Sep 20, 2018 at 10:51 AM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
>>> [snip]
>>>> +static int meson_nfc_clk_init(struct meson_nfc *nfc)
>>>> +{
>>>> +       int ret;
>>>> +
>>>> +       /* request core clock */
>>>> +       nfc->core_clk = devm_clk_get(nfc->dev, "core");
>>>> +       if (IS_ERR(nfc->core_clk)) {
>>>> +               dev_err(nfc->dev, "failed to get core clk\n");
>>>> +               return PTR_ERR(nfc->core_clk);
>>>> +       }
>>>> +
>>>> +       nfc->device_clk = devm_clk_get(nfc->dev, "device");
>>>> +       if (IS_ERR(nfc->device_clk)) {
>>>> +               dev_err(nfc->dev, "failed to get device clk\n");
>>>> +               return PTR_ERR(nfc->device_clk);
>>>> +       }
>>>> +
>>>> +       nfc->phase_tx = devm_clk_get(nfc->dev, "tx");
>>>> +       if (IS_ERR(nfc->phase_tx)) {
>>>> +               dev_err(nfc->dev, "failed to get tx clk\n");
>>>> +               return PTR_ERR(nfc->phase_tx);
>>>> +       }
>>>> +
>>>> +       nfc->phase_rx = devm_clk_get(nfc->dev, "rx");
>>>> +       if (IS_ERR(nfc->phase_rx)) {
>>>> +               dev_err(nfc->dev, "failed to get rx clk\n");
>>>> +               return PTR_ERR(nfc->phase_rx);
>>>> +       }
>>> neither the "rx" nor the "tx" clock are documented in the dt-bindings patch
>>>
>>
>> ok, i will add them later.
>>
>>>> +       /* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
>>>> +       regmap_update_bits(nfc->reg_clk, 0,
>>>> +                          CLK_SELECT_NAND | CLK_ALWAYS_ON | CLK_DIV_MASK,
>>>> +                          CLK_SELECT_NAND | CLK_ALWAYS_ON | CLK_DIV_MASK);
>>> clk_set_rate also works for clocks that are not enabled yet (except if
>>> they have the flag CLK_SET_RATE_UNGATE)
>>> this should help you to remove CLK_DIV_MASK here
>>>
>>
>> if not set clk_div_mask here, the value 0x00 of divider means nand clock
>> off, even read/write nand register is forbidden.
> ah, now I see the pattern here.
> Jerome has written a "sclk-div" driver (which is currently only used
> for the audio clocks on AXG). based on reading the code it seems that
> switching the driver of the divider clock to sclk-div would allow you
> to remove setting CLK_DIV_MASK here:
> - the  "hi" parameter in struct meson_sclk_div_data is optional ->
> then the sclk-div clock won't try to change the duty cycle
> - sclk_div_init reads the divider at initialization time - if it's 0
> it takes the maximum possible divider value
> - sclk_div_enable (which you're going to call anyways, through
> clk_prepare_enable) will then set the divider to the greatest possible
> value
> 
I read the code and it makes sense.
I try ro add mmc_clkc_regmap_divider_ops in clk-regmap.c and implement 
the initial value when enable call. like this:
+static int mmc_clkc_regmap_div_enable(struct clk_hw *hw)
+{
+       struct clk_regmap *clk = to_clk_regmap(hw);
+       struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
+       unsigned int val;
+
+       regmap_read(clk->map, div->offset, &val);
+       val &= clk_div_mask(div->width);
+       if (!val)
+               regmap_update_bits(clk->map, div->offset,
+                                  clk_div_mask(div->width) << div->shift,
+                                  clk_div_mask(div->width));

+       return 0;
+}

it works.

>>> is CLK_SELECT_NAND a bit that switches the clock output from the sdmmc
>>> controller to the NAND controller?
>>> if so: can this be modeled as a mux clock?
>>>
>>
>> it seems to like a gate. 1: nand is selected; 0: emmc is selected.
>> Is it suitable for making it as a mux clock?
> my understanding of a gate is:
> - register value X = OFF, value Y = ON
> 
> but in your case it's:
> - 0 = eMMC is ON but NAND is OFF
> - 1 = eMMC is OFF but NAND is ON
> (so both values mean "on", just for different contexts)
> 
> I believe you need to set this value for eMMC as well:
> what if the bootloader (or hardware defaults, etc.) incorrectly sets
> the value to 1 but the Linux .dts is configured to use eMMC?
> 
en , we need set 0 for emmc as well.

>>> the public S905 datasheet doesn't mention CLK_ALWAYS_ON at bit 28 but
>>> uses bit 24 instead. the description from the datasheet:
>>> Cfg_always_on:
>>> 1: Keep clock always on
>>> 0: Clock on/off controlled by activities.
>>>       Any APB3 access or descriptor execution will turn clock on.
>>> Recommended value: 0
>>>
>>> can you please explain what CLK_ALWAYS_ON does and why it has to be 1?
>>>
>>
>> em , it is the same as bit 24 in S905 datasheet, only moves to bit 28.
>> it means keeping internal clock on whether nand wroks or not.
>> it doesn't have to be 1; i have tried 0 successfully on AXG platform.
> my preference would be to use the recommended value from the datasheet
> unless there's a good argument why it has to be different
> 
>
indeed, i will adopt the recommended value.

> Regards
> Martin
> 
> .
> 
