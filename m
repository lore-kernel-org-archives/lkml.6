Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45E5C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 04:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9257720844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 04:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9257720844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732589AbeHAF4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 01:56:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36040 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726960AbeHAF4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 01:56:07 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4BCE6DC469667;
        Wed,  1 Aug 2018 12:12:31 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Wed, 1 Aug 2018
 12:12:31 +0800
Subject: Re: [PATCH] pinctrl: berlin: fix 'pctrl->functions' allocation in
 berlin_pinctrl_build_state
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
References: <20180731142501.21888-1-yuehaibing@huawei.com>
 <20180801103645.5df924b9@xhacker.debian>
CC:     <linus.walleij@linaro.org>, <yamada.masahiro@socionext.com>,
        <keescook@chromium.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <e2b74e25-9fbd-312b-8fd5-e2e72ad79771@huawei.com>
Date:   Wed, 1 Aug 2018 12:12:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180801103645.5df924b9@xhacker.debian>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/1 10:36, Jisheng Zhang wrote:
> Hi,
> 
> On Tue, 31 Jul 2018 22:25:01 +0800 YueHaibing wrote:
> 
>> fixes following Smatch static check warning:
>>
>>  drivers/pinctrl/berlin/berlin.c:237 berlin_pinctrl_build_state()
>>  warn: passing devm_ allocated variable to kfree. 'pctrl->functions'
>>
>> As we will be calling krealloc() on pointer 'pctrl->functions', which means
>> kfree() will be called in there, devm_kzalloc() shouldn't be used with
>> the allocation in the first place.  Fix the warning by calling kcalloc()
>> and managing the free procedure in error path on our own.
> 
> Good catch. Comments below.
> 
>>
>> Fixes: 3de68d331c24 ("pinctrl: berlin: add the core pinctrl driver for Marvell Berlin SoCs")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/pinctrl/berlin/berlin.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berlin.c
>> index d6d183e..db2afb2 100644
>> --- a/drivers/pinctrl/berlin/berlin.c
>> +++ b/drivers/pinctrl/berlin/berlin.c
>> @@ -216,10 +216,8 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
>>  	}
>>  
>>  	/* we will reallocate later */
>> -	pctrl->functions = devm_kcalloc(&pdev->dev,
>> -					max_functions,
>> -					sizeof(*pctrl->functions),
>> -					GFP_KERNEL);
>> +	pctrl->functions = kcalloc(max_functions,
>> +				   sizeof(*pctrl->functions), GFP_KERNEL);
>>  	if (!pctrl->functions)
>>  		return -ENOMEM;
>>  
>> @@ -257,8 +255,10 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
>>  				function++;
>>  			}
>>  
>> -			if (!found)
>> +			if (!found) {
>> +				kfree(function);
> 
> is it enough to just free one function? I think we need to free functions.

Yep, should free 'pctrl->functions', Thanks!

Will send v2.

> 
>>  				return -EINVAL;
>> +			}
>>  
>>  			if (!function->groups) {
>>  				function->groups =
>> @@ -267,8 +267,10 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
>>  						     sizeof(char *),
>>  						     GFP_KERNEL);
>>  
>> -				if (!function->groups)
>> +				if (!function->groups) {
>> +					kfree(function);
> 
> ditto
> 
>>  					return -ENOMEM;
>> +				}
>>  			}
>>  
>>  			groups = function->groups;
> 
> 
> 

