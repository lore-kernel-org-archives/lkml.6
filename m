Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CECFC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382AD20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382AD20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733071AbeHAGsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 02:48:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10199 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732944AbeHAGsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 02:48:51 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3B24B98AEBB26;
        Wed,  1 Aug 2018 13:05:04 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Wed, 1 Aug 2018
 13:05:02 +0800
Subject: Re: [PATCH v2] pinctrl: berlin: fix 'pctrl->functions' allocation in
 berlin_pinctrl_build_state
To:     <linus.walleij@linaro.org>, <yamada.masahiro@socionext.com>,
        <keescook@chromium.org>, <Jisheng.Zhang@synaptics.com>
References: <20180801050249.20084-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <f37eed34-1baa-e526-0b0c-501d304b6fbe@huawei.com>
Date:   Wed, 1 Aug 2018 13:05:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180801050249.20084-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I send a wrong patch, pls ignore this.

On 2018/8/1 13:02, YueHaibing wrote:
> fixes following Smatch static check warning:
> 
>  drivers/pinctrl/berlin/berlin.c:237 berlin_pinctrl_build_state()
>  warn: passing devm_ allocated variable to kfree. 'pctrl->functions'
> 
> As we will be calling krealloc() on pointer 'pctrl->functions', which means
> kfree() will be called in there, devm_kzalloc() shouldn't be used with
> the allocation in the first place.  Fix the warning by calling kcalloc()
> and managing the free procedure in error path on our own.
> 
> Fixes: 3de68d331c24 ("pinctrl: berlin: add the core pinctrl driver for Marvell Berlin SoCs")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: free pctrl->functions instead of function as Jisheng Zhang suggested
> ---
>  drivers/pinctrl/berlin/berlin.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berlin.c
> index d6d183e..b5903ff 100644
> --- a/drivers/pinctrl/berlin/berlin.c
> +++ b/drivers/pinctrl/berlin/berlin.c
> @@ -216,10 +216,8 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
>  	}
>  
>  	/* we will reallocate later */
> -	pctrl->functions = devm_kcalloc(&pdev->dev,
> -					max_functions,
> -					sizeof(*pctrl->functions),
> -					GFP_KERNEL);
> +	pctrl->functions = kcalloc(max_functions,
> +				   sizeof(*pctrl->functions), GFP_KERNEL);
>  	if (!pctrl->functions)
>  		return -ENOMEM;
>  
> @@ -257,8 +255,10 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
>  				function++;
>  			}
>  
> -			if (!found)
> +			if (!found) {
> +				kfree( );
>  				return -EINVAL;
> +			}
>  
>  			if (!function->groups) {
>  				function->groups =
> @@ -267,8 +267,10 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
>  						     sizeof(char *),
>  						     GFP_KERNEL);
>  
> -				if (!function->groups)
> +				if (!function->groups) {
> +					kfree(pctrl->functions);
>  					return -ENOMEM;
> +				}
>  			}
>  
>  			groups = function->groups;
> 

