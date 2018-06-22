Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0677C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E77723F77
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E77723F77
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeFVJQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:16:03 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:49714 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751086AbeFVJQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:16:01 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5M9EJXK019067;
        Fri, 22 Jun 2018 11:15:22 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2jrp8m1ywy-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 22 Jun 2018 11:15:22 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 639BB38;
        Fri, 22 Jun 2018 09:15:21 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 38DA125A5;
        Fri, 22 Jun 2018 09:15:21 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.46) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 22 Jun
 2018 11:15:20 +0200
Subject: Re: [PATCH V4 2/4] watchdog: stm32: add pclk feature for stm32mp1
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1529571737-3552-1-git-send-email-ludovic.Barre@st.com>
 <1529571737-3552-3-git-send-email-ludovic.Barre@st.com>
 <20180621165335.GA4563@roeck-us.net>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <0bfe0082-2134-2d3b-322f-cd6c193a9974@st.com>
Date:   Fri, 22 Jun 2018 11:15:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621165335.GA4563@roeck-us.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/21/2018 06:53 PM, Guenter Roeck wrote:
> On Thu, Jun 21, 2018 at 11:02:15AM +0200, Ludovic Barre wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch adds compatible data to manage pclk clock by
>> compatible. Adds stm32mp1 support which requires pclk clock.
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/watchdog/stm32_iwdg.c | 116 +++++++++++++++++++++++++++---------------
>>   1 file changed, 74 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
>> index c97ad56..e00e3b3 100644
>> --- a/drivers/watchdog/stm32_iwdg.c
>> +++ b/drivers/watchdog/stm32_iwdg.c
>> @@ -11,12 +11,13 @@
>>   
>>   #include <linux/clk.h>
>>   #include <linux/delay.h>
>> -#include <linux/kernel.h>
>> -#include <linux/module.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/io.h>
>>   #include <linux/iopoll.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>>   #include <linux/of.h>
>> +#include <linux/of_device.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/watchdog.h>
>>   
>> @@ -54,11 +55,15 @@
>>   #define TIMEOUT_US	100000
>>   #define SLEEP_US	1000
>>   
>> +#define HAS_PCLK	true
>> +
>>   struct stm32_iwdg {
>>   	struct watchdog_device	wdd;
>>   	void __iomem		*regs;
>> -	struct clk		*clk;
>> +	struct clk		*clk_lsi;
>> +	struct clk		*clk_pclk;
>>   	unsigned int		rate;
>> +	bool			has_pclk;
>>   };
>>   
>>   static inline u32 reg_read(void __iomem *base, u32 reg)
>> @@ -133,6 +138,44 @@ static int stm32_iwdg_set_timeout(struct watchdog_device *wdd,
>>   	return 0;
>>   }
>>   
>> +static int stm32_iwdg_clk_init(struct platform_device *pdev,
>> +			       struct stm32_iwdg *wdt)
>> +{
>> +	u32 ret;
>> +
>> +	wdt->clk_lsi = devm_clk_get(&pdev->dev, "lsi");
> 
> I just noticed a subtle difference: This used to be
> 			devm_clk_get(&pdev->dev, NULL);
> which would always get the first clock, no matter how it is named.
> Can that cause problems with backward compatibility ?

You are right Guenter.

When there are multiple clocks, I prefer to use name interface.
I find it easier to use, and avoid misunderstanding.

Today, only one "dtsi" define the watchdog and it's disabled
(stm32f429.dtsi). I think it's good moment to move to clock named
(before it is used anymore).

But you are right I forgot to change stm32f429.dtsi.
If I add a commit for stm32f429.dtsi, it's Ok for you ?

BR
Ludo

> 
> Thanks,
> Guenter
> 
>> +	if (IS_ERR(wdt->clk_lsi)) {
>> +		dev_err(&pdev->dev, "Unable to get lsi clock\n");
>> +		return PTR_ERR(wdt->clk_lsi);
>> +	}
>> +
>> +	/* optional peripheral clock */
>> +	if (wdt->has_pclk) {
>> +		wdt->clk_pclk = devm_clk_get(&pdev->dev, "pclk");
>> +		if (IS_ERR(wdt->clk_pclk)) {
>> +			dev_err(&pdev->dev, "Unable to get pclk clock\n");
>> +			return PTR_ERR(wdt->clk_pclk);
>> +		}
>> +
>> +		ret = clk_prepare_enable(wdt->clk_pclk);
>> +		if (ret) {
>> +			dev_err(&pdev->dev, "Unable to prepare pclk clock\n");
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	ret = clk_prepare_enable(wdt->clk_lsi);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Unable to prepare lsi clock\n");
>> +		clk_disable_unprepare(wdt->clk_pclk);
>> +		return ret;
>> +	}
>> +
>> +	wdt->rate = clk_get_rate(wdt->clk_lsi);
>> +
>> +	return 0;
>> +}
>> +
>>   static const struct watchdog_info stm32_iwdg_info = {
>>   	.options	= WDIOF_SETTIMEOUT |
>>   			  WDIOF_MAGICCLOSE |
>> @@ -147,49 +190,42 @@ static const struct watchdog_ops stm32_iwdg_ops = {
>>   	.set_timeout	= stm32_iwdg_set_timeout,
>>   };
>>   
>> +static const struct of_device_id stm32_iwdg_of_match[] = {
>> +	{ .compatible = "st,stm32-iwdg", .data = (void *)!HAS_PCLK },
>> +	{ .compatible = "st,stm32mp1-iwdg", .data = (void *)HAS_PCLK },
>> +	{ /* end node */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, stm32_iwdg_of_match);
>> +
>>   static int stm32_iwdg_probe(struct platform_device *pdev)
>>   {
>>   	struct watchdog_device *wdd;
>> +	const struct of_device_id *match;
>>   	struct stm32_iwdg *wdt;
>>   	struct resource *res;
>> -	void __iomem *regs;
>> -	struct clk *clk;
>>   	int ret;
>>   
>> +	match = of_match_device(stm32_iwdg_of_match, &pdev->dev);
>> +	if (!match)
>> +		return -ENODEV;
>> +
>> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>> +	if (!wdt)
>> +		return -ENOMEM;
>> +
>> +	wdt->has_pclk = match->data;
>> +
>>   	/* This is the timer base. */
>>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	regs = devm_ioremap_resource(&pdev->dev, res);
>> -	if (IS_ERR(regs)) {
>> +	wdt->regs = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(wdt->regs)) {
>>   		dev_err(&pdev->dev, "Could not get resource\n");
>> -		return PTR_ERR(regs);
>> +		return PTR_ERR(wdt->regs);
>>   	}
>>   
>> -	clk = devm_clk_get(&pdev->dev, NULL);
>> -	if (IS_ERR(clk)) {
>> -		dev_err(&pdev->dev, "Unable to get clock\n");
>> -		return PTR_ERR(clk);
>> -	}
>> -
>> -	ret = clk_prepare_enable(clk);
>> -	if (ret) {
>> -		dev_err(&pdev->dev, "Unable to prepare clock %p\n", clk);
>> +	ret = stm32_iwdg_clk_init(pdev, wdt);
>> +	if (ret)
>>   		return ret;
>> -	}
>> -
>> -	/*
>> -	 * Allocate our watchdog driver data, which has the
>> -	 * struct watchdog_device nested within it.
>> -	 */
>> -	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>> -	if (!wdt) {
>> -		ret = -ENOMEM;
>> -		goto err;
>> -	}
>> -
>> -	/* Initialize struct stm32_iwdg. */
>> -	wdt->regs = regs;
>> -	wdt->clk = clk;
>> -	wdt->rate = clk_get_rate(clk);
>>   
>>   	/* Initialize struct watchdog_device. */
>>   	wdd = &wdt->wdd;
>> @@ -217,7 +253,8 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
>>   
>>   	return 0;
>>   err:
>> -	clk_disable_unprepare(clk);
>> +	clk_disable_unprepare(wdt->clk_lsi);
>> +	clk_disable_unprepare(wdt->clk_pclk);
>>   
>>   	return ret;
>>   }
>> @@ -227,23 +264,18 @@ static int stm32_iwdg_remove(struct platform_device *pdev)
>>   	struct stm32_iwdg *wdt = platform_get_drvdata(pdev);
>>   
>>   	watchdog_unregister_device(&wdt->wdd);
>> -	clk_disable_unprepare(wdt->clk);
>> +	clk_disable_unprepare(wdt->clk_lsi);
>> +	clk_disable_unprepare(wdt->clk_pclk);
>>   
>>   	return 0;
>>   }
>>   
>> -static const struct of_device_id stm32_iwdg_of_match[] = {
>> -	{ .compatible = "st,stm32-iwdg" },
>> -	{ /* end node */ }
>> -};
>> -MODULE_DEVICE_TABLE(of, stm32_iwdg_of_match);
>> -
>>   static struct platform_driver stm32_iwdg_driver = {
>>   	.probe		= stm32_iwdg_probe,
>>   	.remove		= stm32_iwdg_remove,
>>   	.driver = {
>>   		.name	= "iwdg",
>> -		.of_match_table = stm32_iwdg_of_match,
>> +		.of_match_table = of_match_ptr(stm32_iwdg_of_match),
>>   	},
>>   };
>>   module_platform_driver(stm32_iwdg_driver);
>> -- 
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
