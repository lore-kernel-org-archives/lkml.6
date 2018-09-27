Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EBBC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BF82083A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7BF82083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeI0OgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:36:21 -0400
Received: from mail-sz2.amlogic.com ([211.162.65.114]:40763 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbeI0OgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:36:21 -0400
Received: from [10.28.18.92] (10.28.18.92) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 27 Sep
 2018 16:19:38 +0800
Subject: Re: [PATCH v4 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <jianxin.pan@amlogic.com>
CC:     <boris.brezillon@bootlin.com>, <linux-mtd@lists.infradead.org>,
        <yixun.lan@amlogic.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <richard@nod.at>, <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>, <carlo@caione.org>,
        <khilman@baylibre.com>, <robh@kernel.org>, <jian.hu@amlogic.com>,
        <hanjie.lin@amlogic.com>, <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1537433449-65213-1-git-send-email-jianxin.pan@amlogic.com>
 <1537433449-65213-3-git-send-email-jianxin.pan@amlogic.com>
 <CAFBinCAaphyifUNyDQr7th2Mt=A+UQnzai0edKLCPNbxhh2w+Q@mail.gmail.com>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <f75b6f23-6d58-2145-30f3-b23e4b69966b@amlogic.com>
Date:   Thu, 27 Sep 2018 16:16:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCAaphyifUNyDQr7th2Mt=A+UQnzai0edKLCPNbxhh2w+Q@mail.gmail.com>
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

Hello Martin,

On 9/22/2018 11:32 PM, Martin Blumenstingl wrote:
> Hello,
> 
> On Thu, Sep 20, 2018 at 10:51 AM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
> [snip]
>> +static int meson_nfc_clk_init(struct meson_nfc *nfc)
>> +{
>> +       int ret;
>> +
>> +       /* request core clock */
>> +       nfc->core_clk = devm_clk_get(nfc->dev, "core");
>> +       if (IS_ERR(nfc->core_clk)) {
>> +               dev_err(nfc->dev, "failed to get core clk\n");
>> +               return PTR_ERR(nfc->core_clk);
>> +       }
>> +
>> +       nfc->device_clk = devm_clk_get(nfc->dev, "device");
>> +       if (IS_ERR(nfc->device_clk)) {
>> +               dev_err(nfc->dev, "failed to get device clk\n");
>> +               return PTR_ERR(nfc->device_clk);
>> +       }
>> +
>> +       nfc->phase_tx = devm_clk_get(nfc->dev, "tx");
>> +       if (IS_ERR(nfc->phase_tx)) {
>> +               dev_err(nfc->dev, "failed to get tx clk\n");
>> +               return PTR_ERR(nfc->phase_tx);
>> +       }
>> +
>> +       nfc->phase_rx = devm_clk_get(nfc->dev, "rx");
>> +       if (IS_ERR(nfc->phase_rx)) {
>> +               dev_err(nfc->dev, "failed to get rx clk\n");
>> +               return PTR_ERR(nfc->phase_rx);
>> +       }
> neither the "rx" nor the "tx" clock are documented in the dt-bindings patch
> 

ok, i will add them later.

>> +       /* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
>> +       regmap_update_bits(nfc->reg_clk, 0,
>> +                          CLK_SELECT_NAND | CLK_ALWAYS_ON | CLK_DIV_MASK,
>> +                          CLK_SELECT_NAND | CLK_ALWAYS_ON | CLK_DIV_MASK);
> clk_set_rate also works for clocks that are not enabled yet (except if
> they have the flag CLK_SET_RATE_UNGATE)
> this should help you to remove CLK_DIV_MASK here
> 

if not set clk_div_mask here, the value 0x00 of divider means nand clock 
off, even read/write nand register is forbidden.

> is CLK_SELECT_NAND a bit that switches the clock output from the sdmmc
> controller to the NAND controller?
> if so: can this be modeled as a mux clock?
> 

it seems to like a gate. 1: nand is selected; 0: emmc is selected.
Is it suitable for making it as a mux clock?

> the public S905 datasheet doesn't mention CLK_ALWAYS_ON at bit 28 but
> uses bit 24 instead. the description from the datasheet:
> Cfg_always_on:
> 1: Keep clock always on
> 0: Clock on/off controlled by activities.
>      Any APB3 access or descriptor execution will turn clock on.
> Recommended value: 0
> 
> can you please explain what CLK_ALWAYS_ON does and why it has to be 1?
> 

em , it is the same as bit 24 in S905 datasheet, only moves to bit 28.
it means keeping internal clock on whether nand wroks or not.
it doesn't have to be 1; i have tried 0 successfully on AXG platform.

> 
> Regards
> Martin
> 
> .
> 
