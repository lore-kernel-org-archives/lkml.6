Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2ACC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C7D242E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rl4NQhn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C7D242E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeFVNkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:40:36 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46224 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeFVNke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:40:34 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so3507488pld.13;
        Fri, 22 Jun 2018 06:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=otIejmBVikq7oNsLwNKR1qWag5YjH+S8XRMLq4tDSQQ=;
        b=rl4NQhn0fTo5Ix8QonLiKtmIX5zGvlSDXJE7jhm410P153cJlnQwu26GrIcFU2xs5y
         ddHxO9v7SyFatSvHNSy19LgZiQ6I68MWiBKKls7+df661uUvvfaAPQwOZZsWAHcWB4vB
         nX7JQAw9hVzGXnku3crmGnmB8W5qfumF/ENVKQ8ZXAo7txc5tXA2/n2PNdF0p6NOfGKT
         m3V1KWoNGcE7ed0KMdPPzjKxqPSbK5yDd/4zbodlnIa56+gNoDw2t4DVDmJXwnyunOU4
         skFiRLIGHt1EjK6Bz/PpviiCh80uJ63i+J/PiTVJ3hkeSuFysTIGk/YG8UG20BLgrWzC
         YsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=otIejmBVikq7oNsLwNKR1qWag5YjH+S8XRMLq4tDSQQ=;
        b=GihtquvnVjss4rRT7w8Sqng7LeNNSUaQ4t/AVOBOw39Wo8URxae/hawX6Sqe7d4Xr9
         KZ0NFpxCtISwdb3AapJ8jxVkF68TRaF2W31CzBfPVM6oLcRSPwczqA4yNYi0vK1Kre5c
         VSNgM9b72beQuiwbQhIHPgmp3Z9r887pU6jmu1NnQZjH0t97G8tGGIq9QgvABbJjR2Ej
         G2CASa7sN0SJY7zT2ojfPlABNOXjucCjqNnmrB+2mRnqMlqNLVcg9sxsIaswVzyAQXp/
         6bgkAmsUq+2dUOU5f2cmg3AIyQjpOzhotUA5gGIbMJexg+DRYQhLgyvlGSVSvtwYcD0i
         vFMA==
X-Gm-Message-State: APt69E0xcN0/tmBRka3JLMZRylxX4AVsgywiMVHa0XErY5FZSyx/8AbM
        mDA2Hzr50lCjE2AciiI+fh5DNg==
X-Google-Smtp-Source: ADUXVKL96AW35PStaL3056C18NsK56XdTf54zMF9T8183d3RAl+0f4n2Nou5LylGos2J3QhqreiqEQ==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21-v6mr1793612plp.168.1529674833417;
        Fri, 22 Jun 2018 06:40:33 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id m5-v6sm28684898pfa.93.2018.06.22.06.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 06:40:32 -0700 (PDT)
Subject: Re: [PATCH V4 2/4] watchdog: stm32: add pclk feature for stm32mp1
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1529571737-3552-1-git-send-email-ludovic.Barre@st.com>
 <1529571737-3552-3-git-send-email-ludovic.Barre@st.com>
 <20180621165335.GA4563@roeck-us.net>
 <0bfe0082-2134-2d3b-322f-cd6c193a9974@st.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3f65a889-f625-9521-ea09-bcf7b5b24927@roeck-us.net>
Date:   Fri, 22 Jun 2018 06:40:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0bfe0082-2134-2d3b-322f-cd6c193a9974@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22/2018 02:15 AM, Ludovic BARRE wrote:
> 
> 
> On 06/21/2018 06:53 PM, Guenter Roeck wrote:
>> On Thu, Jun 21, 2018 at 11:02:15AM +0200, Ludovic Barre wrote:
>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>
>>> This patch adds compatible data to manage pclk clock by
>>> compatible. Adds stm32mp1 support which requires pclk clock.
>>>
>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>> ---
>>>   drivers/watchdog/stm32_iwdg.c | 116 +++++++++++++++++++++++++++---------------
>>>   1 file changed, 74 insertions(+), 42 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
>>> index c97ad56..e00e3b3 100644
>>> --- a/drivers/watchdog/stm32_iwdg.c
>>> +++ b/drivers/watchdog/stm32_iwdg.c
>>> @@ -11,12 +11,13 @@
>>>   #include <linux/clk.h>
>>>   #include <linux/delay.h>
>>> -#include <linux/kernel.h>
>>> -#include <linux/module.h>
>>>   #include <linux/interrupt.h>
>>>   #include <linux/io.h>
>>>   #include <linux/iopoll.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>>   #include <linux/of.h>
>>> +#include <linux/of_device.h>
>>>   #include <linux/platform_device.h>
>>>   #include <linux/watchdog.h>
>>> @@ -54,11 +55,15 @@
>>>   #define TIMEOUT_US    100000
>>>   #define SLEEP_US    1000
>>> +#define HAS_PCLK    true
>>> +
>>>   struct stm32_iwdg {
>>>       struct watchdog_device    wdd;
>>>       void __iomem        *regs;
>>> -    struct clk        *clk;
>>> +    struct clk        *clk_lsi;
>>> +    struct clk        *clk_pclk;
>>>       unsigned int        rate;
>>> +    bool            has_pclk;
>>>   };
>>>   static inline u32 reg_read(void __iomem *base, u32 reg)
>>> @@ -133,6 +138,44 @@ static int stm32_iwdg_set_timeout(struct watchdog_device *wdd,
>>>       return 0;
>>>   }
>>> +static int stm32_iwdg_clk_init(struct platform_device *pdev,
>>> +                   struct stm32_iwdg *wdt)
>>> +{
>>> +    u32 ret;
>>> +
>>> +    wdt->clk_lsi = devm_clk_get(&pdev->dev, "lsi");
>>
>> I just noticed a subtle difference: This used to be
>>             devm_clk_get(&pdev->dev, NULL);
>> which would always get the first clock, no matter how it is named.
>> Can that cause problems with backward compatibility ?
> 
> You are right Guenter.
> 
> When there are multiple clocks, I prefer to use name interface.
> I find it easier to use, and avoid misunderstanding.
> 
> Today, only one "dtsi" define the watchdog and it's disabled
> (stm32f429.dtsi). I think it's good moment to move to clock named
> (before it is used anymore).
> 
> But you are right I forgot to change stm32f429.dtsi.
> If I add a commit for stm32f429.dtsi, it's Ok for you ?
> 

Not really. You are imposing a personal preference on others,
and you would make stm32f429.dtsi inconsistent since it doesn't
use clock names for anything else. This in turn means that people
will have an endless source of irritation since they will need
a clock name for this node but not for others.

You will have to get the arm and DT maintainers to agree on this change.

Thanks,
Guenter

> BR
> Ludo
> 
>>
>> Thanks,
>> Guenter
>>
>>> +    if (IS_ERR(wdt->clk_lsi)) {
>>> +        dev_err(&pdev->dev, "Unable to get lsi clock\n");
>>> +        return PTR_ERR(wdt->clk_lsi);
>>> +    }
>>> +
>>> +    /* optional peripheral clock */
>>> +    if (wdt->has_pclk) {
>>> +        wdt->clk_pclk = devm_clk_get(&pdev->dev, "pclk");
>>> +        if (IS_ERR(wdt->clk_pclk)) {
>>> +            dev_err(&pdev->dev, "Unable to get pclk clock\n");
>>> +            return PTR_ERR(wdt->clk_pclk);
>>> +        }
>>> +
>>> +        ret = clk_prepare_enable(wdt->clk_pclk);
>>> +        if (ret) {
>>> +            dev_err(&pdev->dev, "Unable to prepare pclk clock\n");
>>> +            return ret;
>>> +        }
>>> +    }
>>> +
>>> +    ret = clk_prepare_enable(wdt->clk_lsi);
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "Unable to prepare lsi clock\n");
>>> +        clk_disable_unprepare(wdt->clk_pclk);
>>> +        return ret;
>>> +    }
>>> +
>>> +    wdt->rate = clk_get_rate(wdt->clk_lsi);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static const struct watchdog_info stm32_iwdg_info = {
>>>       .options    = WDIOF_SETTIMEOUT |
>>>                 WDIOF_MAGICCLOSE |
>>> @@ -147,49 +190,42 @@ static const struct watchdog_ops stm32_iwdg_ops = {
>>>       .set_timeout    = stm32_iwdg_set_timeout,
>>>   };
>>> +static const struct of_device_id stm32_iwdg_of_match[] = {
>>> +    { .compatible = "st,stm32-iwdg", .data = (void *)!HAS_PCLK },
>>> +    { .compatible = "st,stm32mp1-iwdg", .data = (void *)HAS_PCLK },
>>> +    { /* end node */ }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, stm32_iwdg_of_match);
>>> +
>>>   static int stm32_iwdg_probe(struct platform_device *pdev)
>>>   {
>>>       struct watchdog_device *wdd;
>>> +    const struct of_device_id *match;
>>>       struct stm32_iwdg *wdt;
>>>       struct resource *res;
>>> -    void __iomem *regs;
>>> -    struct clk *clk;
>>>       int ret;
>>> +    match = of_match_device(stm32_iwdg_of_match, &pdev->dev);
>>> +    if (!match)
>>> +        return -ENODEV;
>>> +
>>> +    wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>>> +    if (!wdt)
>>> +        return -ENOMEM;
>>> +
>>> +    wdt->has_pclk = match->data;
>>> +
>>>       /* This is the timer base. */
>>>       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> -    regs = devm_ioremap_resource(&pdev->dev, res);
>>> -    if (IS_ERR(regs)) {
>>> +    wdt->regs = devm_ioremap_resource(&pdev->dev, res);
>>> +    if (IS_ERR(wdt->regs)) {
>>>           dev_err(&pdev->dev, "Could not get resource\n");
>>> -        return PTR_ERR(regs);
>>> +        return PTR_ERR(wdt->regs);
>>>       }
>>> -    clk = devm_clk_get(&pdev->dev, NULL);
>>> -    if (IS_ERR(clk)) {
>>> -        dev_err(&pdev->dev, "Unable to get clock\n");
>>> -        return PTR_ERR(clk);
>>> -    }
>>> -
>>> -    ret = clk_prepare_enable(clk);
>>> -    if (ret) {
>>> -        dev_err(&pdev->dev, "Unable to prepare clock %p\n", clk);
>>> +    ret = stm32_iwdg_clk_init(pdev, wdt);
>>> +    if (ret)
>>>           return ret;
>>> -    }
>>> -
>>> -    /*
>>> -     * Allocate our watchdog driver data, which has the
>>> -     * struct watchdog_device nested within it.
>>> -     */
>>> -    wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>>> -    if (!wdt) {
>>> -        ret = -ENOMEM;
>>> -        goto err;
>>> -    }
>>> -
>>> -    /* Initialize struct stm32_iwdg. */
>>> -    wdt->regs = regs;
>>> -    wdt->clk = clk;
>>> -    wdt->rate = clk_get_rate(clk);
>>>       /* Initialize struct watchdog_device. */
>>>       wdd = &wdt->wdd;
>>> @@ -217,7 +253,8 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
>>>       return 0;
>>>   err:
>>> -    clk_disable_unprepare(clk);
>>> +    clk_disable_unprepare(wdt->clk_lsi);
>>> +    clk_disable_unprepare(wdt->clk_pclk);
>>>       return ret;
>>>   }
>>> @@ -227,23 +264,18 @@ static int stm32_iwdg_remove(struct platform_device *pdev)
>>>       struct stm32_iwdg *wdt = platform_get_drvdata(pdev);
>>>       watchdog_unregister_device(&wdt->wdd);
>>> -    clk_disable_unprepare(wdt->clk);
>>> +    clk_disable_unprepare(wdt->clk_lsi);
>>> +    clk_disable_unprepare(wdt->clk_pclk);
>>>       return 0;
>>>   }
>>> -static const struct of_device_id stm32_iwdg_of_match[] = {
>>> -    { .compatible = "st,stm32-iwdg" },
>>> -    { /* end node */ }
>>> -};
>>> -MODULE_DEVICE_TABLE(of, stm32_iwdg_of_match);
>>> -
>>>   static struct platform_driver stm32_iwdg_driver = {
>>>       .probe        = stm32_iwdg_probe,
>>>       .remove        = stm32_iwdg_remove,
>>>       .driver = {
>>>           .name    = "iwdg",
>>> -        .of_match_table = stm32_iwdg_of_match,
>>> +        .of_match_table = of_match_ptr(stm32_iwdg_of_match),
>>>       },
>>>   };
>>>   module_platform_driver(stm32_iwdg_driver);
>>> -- 
>>> 2.7.4
>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

