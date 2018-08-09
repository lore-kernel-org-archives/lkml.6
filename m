Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9317C4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9530B21C36
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9530B21C36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeHIFCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 01:02:50 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:29840 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbeHIFCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 01:02:50 -0400
Received: from [192.168.90.200] (10.18.20.235) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 9 Aug 2018
 10:40:21 +0800
CC:     <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Carlo Caione <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jian Hu <jian.hu@amlogic.com>
Subject: Re: [PATCH v3 2/2] clk: meson: add sub MMC clock controller driver
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
References: <20180712211244.11428-1-yixun.lan@amlogic.com>
 <20180712211244.11428-3-yixun.lan@amlogic.com>
 <153261840298.48062.2497103873681297587@swboyd.mtv.corp.google.com>
 <f52d2511-bab7-2c39-cea7-8702e27d2ef8@amlogic.com>
 <153270970080.48062.18399022907046343950@swboyd.mtv.corp.google.com>
 <153270995155.48062.4302847978258086624@swboyd.mtv.corp.google.com>
 <e89f28253070abae5dc755800feee500cc3396ce.camel@baylibre.com>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <1e5f7ba3-59c1-27c8-89b7-cce87659462e@amlogic.com>
Date:   Thu, 9 Aug 2018 10:39:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <e89f28253070abae5dc755800feee500cc3396ce.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome

On 07/30/18 16:57, Jerome Brunet wrote:
> On Fri, 2018-07-27 at 09:45 -0700, Stephen Boyd wrote:
>> Quoting Stephen Boyd (2018-07-27 09:41:40)
>>> Quoting Yixun Lan (2018-07-27 07:52:23)
>>>> HI Stephen:
>>>>
>>>> On 07/26/2018 11:20 PM, Stephen Boyd wrote:
>>>>> Quoting Yixun Lan (2018-07-12 14:12:44)
>>>>>> diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..36c4c7cd69a6
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/clk/meson/mmc-clkc.c
>>>>>> @@ -0,0 +1,367 @@
>>>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>>>> +/*
>>>>>> + * Amlogic Meson MMC Sub Clock Controller Driver
>>>>>> + *
>>>>>> + * Copyright (c) 2017 Baylibre SAS.
>>>>>> + * Author: Jerome Brunet <jbrunet@baylibre.com>
>>>>>> + *
>>>>>> + * Copyright (c) 2018 Amlogic, inc.
>>>>>> + * Author: Yixun Lan <yixun.lan@amlogic.com>
>>>>>> + */
>>>>>> +
>>>>>> +#include <linux/clk.h>
>>>>>
>>>>> Is this include used?
>>>>>
>>>>
>>>> this is needed by clk_get_rate()
>>>> see drivers/clk/meson/mmc-clkc.c:204
>>>
>>> Hmm ok. That's unfortunate.
>>
>> You should be able to read the hardware to figure out the clk frequency?
>> This may be a sign that the phase clk_ops are bad and should be passing
>> in the frequency of the parent clk to the op so that phase can be
>> calculated. Jerome?
>>
> 
> It could be a away to do it but:
> a) if we modify the API, we would need to update every clock driver using it.
>    There is not that many users of the phase API but still, it is annoying
> b) This particular driver need the parent rate, other might need something else
> I guess. (parent phase ??, duty cycle ??) 
> 
> I think the real problem here it that you are using the consumer API. You should
> be using the provider API like clk_hw_get_rate. Look at the clk-divider.c which
> use clk_hw_round_rate() on the parent clock. 
I will replace it with clk_hw_get_rate()

> 
> Clock drivers should deal with 'struct clk_hw', not 'struct clk'. I think it was
> mentioned in the past that the 'clk' within 'struct clk_hw' might be removed
> someday.
> 
> Yixun, please don't put your clock driver within the controller driver. Please
> implement your 'phase-delay' clock in its own file and export the ops, like
> every other clock in the amlogic directory. Also, please review your list of
> '#define', some of them are unnecessary copy/paste from the MMC driver.
> 
will implement a clk-phase-delay.c

I can move the extra CC list

Yixun
