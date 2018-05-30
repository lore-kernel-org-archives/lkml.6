Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753765AbeE3T7I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:59:08 -0400
Received: from vern.gendns.com ([206.190.152.46]:49590 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753695AbeE3T7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:59:04 -0400
Subject: Re: [PATCH 6/9] clk: davinci: pll: allow dev == NULL
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, brgl@bgdev.pl
References: <20180525181150.17873-1-david@lechnology.com>
 <20180525181150.17873-7-david@lechnology.com>
 <20180530194559.982.42844@harbor.lan>
From: David Lechner <david@lechnology.com>
Message-ID: <41524516-3b58-0db8-1e67-3d76f8596a23@lechnology.com>
Date: Wed, 30 May 2018 14:59:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180530194559.982.42844@harbor.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30/2018 02:46 PM, Michael Turquette wrote:
> Hi David,
> 
> Quoting David Lechner (2018-05-25 11:11:47)
>> This modifies the TI Davinci PLL clock driver to allow for the case
>> when dev == NULL. On some (most) SoCs that use this driver, the PLL
>> clock needs to be registered during early boot because it is used
>> for clocksource/clkevent and there will be no platform device available.
> 
> A lot of this stuff feels like a step backwards. E.g:
> 
>> diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
>> index 23a24c944f1d..2eb981e61185 100644
>> --- a/drivers/clk/davinci/pll.c
>> +++ b/drivers/clk/davinci/pll.c
>> @@ -11,6 +11,7 @@
>>   
>>   #include <linux/clk-provider.h>
>>   #include <linux/clk.h>
>> +#include <linux/clk/davinci.h>
>>   #include <linux/delay.h>
>>   #include <linux/err.h>
>>   #include <linux/io.h>
>> @@ -223,6 +224,7 @@ static const struct clk_ops dm365_pll_ops = {
>>   
>>   /**
>>    * davinci_pll_div_register - common *DIV clock implementation
>> + * @dev: The PLL platform device or NULL
>>    * @name: the clock name
>>    * @parent_name: the parent clock name
>>    * @reg: the *DIV register
>> @@ -240,17 +242,21 @@ static struct clk *davinci_pll_div_register(struct device *dev,
>>          const struct clk_ops *divider_ops = &clk_divider_ops;
>>          struct clk_gate *gate;
>>          struct clk_divider *divider;
>> +       struct clk *clk;
>> +       int ret;
>>   
>> -       gate = devm_kzalloc(dev, sizeof(*gate), GFP_KERNEL);
>> +       gate = kzalloc(sizeof(*gate), GFP_KERNEL);
>>          if (!gate)
>>                  return ERR_PTR(-ENOMEM);
>>   
>>          gate->reg = reg;
>>          gate->bit_idx = DIV_ENABLE_SHIFT;
>>   
>> -       divider = devm_kzalloc(dev, sizeof(*divider), GFP_KERNEL);
>> -       if (!divider)
>> -               return ERR_PTR(-ENOMEM);
>> +       divider = kzalloc(sizeof(*divider), GFP_KERNEL);
>> +       if (!divider) {
>> +               ret = -ENOMEM;
>> +               goto err_free_gate;
>> +       }
>>   
>>          divider->reg = reg;
>>          divider->shift = DIV_RATIO_SHIFT;
> 
> Oh no my poor devm_ helpers!
> 
> I understand that we need to support early boot drivers better, so this
> patch can be merged.
> 
> However I'm curious if you're tracking Bartosz's early_platform_driver
> efforts? Converting to that if it is ever merged would likely be
> cleaner:
> 
> https://lkml.kernel.org/r/20180511162028.20616-1-brgl@bgdev.pl
> 
> Best regards,
> Mike
> 

Yes. In fact, this is what got Bartosz working on it in the first
place. :-)
