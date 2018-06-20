Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D6BC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA11C20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKcd0dw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA11C20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754337AbeFTJTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:19:50 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46688 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753930AbeFTJTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:19:45 -0400
Received: by mail-pg0-f68.google.com with SMTP id d2-v6so1196320pga.13;
        Wed, 20 Jun 2018 02:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0Nq3+jbAsiWYgyRndlPMDp5Cw4VErmoPKaYsJon1Me4=;
        b=EKcd0dw74lwTEIEuWavmpoQNd91qYkalaY1rEdgufT4LmwMU42S+vmSnPoujAYn6wT
         4pRRY4zbSJiHIeFWdSRSIkTFnoDxGl54datH5WsjC6AEHWYxtUWN+pAlV5DGykDAJsqQ
         aK0VHlb0WGcrgd0k52xBV2B2+g4/PqXpvJwRJe5et9IrqHI5C2xg5+nDEEk67vUwqDiM
         aF6FlPZMEW6m5EAaKY6uX8qnWksfHeAREqGFg7YHRmsx/A460yC3qLgDji1wKIPxRbFv
         2t8tCv9WS9Oe9KxqQ2OGcvxjwhXMS9IuqOB6SW02ZFKhLmM+93aRCdlsXzuA7Pg7YbuT
         KKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Nq3+jbAsiWYgyRndlPMDp5Cw4VErmoPKaYsJon1Me4=;
        b=X//uyivVFmEyulmmcZIGhc4UzqlcB2CWTVh60EYLPfysw2RFDZpubwl2PjnjWMwJj8
         4XqJubXETHWHGCYPcH+iLZNN2zN66iegeonQ6xGmqHZ26FBQCV1+4ovRroOnAyAAJl23
         fjl+/RPh8dxqy418qfUJg5EqSCiescr1Sb37HbTFj2s/8X96lHtlhjDtwk8XZqI7R5QZ
         i8r+74cQB/rHzLKlHeTsP1xCyaPhe0U41UCVI43Q79mGOsH2vP/tniuhbRnpbZ0/DA90
         ZjH/S82eD8CjEpGHyBOccX3faO0EXqyNfB1xLUWvRzuprKTJ9pM+mUED4PlK0Gt56Mlw
         XZ4w==
X-Gm-Message-State: APt69E1sPiViHU95tgGBdUBa6yFS5KazSf/BVjoadXIf6Ye8+TvfyOss
        /uKZl35j+sNY2MIt/XJSPBLCrg==
X-Google-Smtp-Source: ADUXVKIcwZDQ7xqGR0o+UiNmsOtupcSrUpFLiMUhQfCzUebbasFPEy1Cde4BHOjMTGkq3TE6O1Oe2w==
X-Received: by 2002:a62:4715:: with SMTP id u21-v6mr21889135pfa.89.1529486384453;
        Wed, 20 Jun 2018 02:19:44 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g10-v6sm2776398pfi.148.2018.06.20.02.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 02:19:43 -0700 (PDT)
Subject: Re: [PATCH V2 1/3] watchdog: stm32: add pclk feature for stm32mp1
To:     Ludovic Barre <ludovic.Barre@st.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1529481238-15277-1-git-send-email-ludovic.Barre@st.com>
 <1529481238-15277-2-git-send-email-ludovic.Barre@st.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6162d701-2afd-5a22-d38f-7fb9e726cff7@roeck-us.net>
Date:   Wed, 20 Jun 2018 02:19:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529481238-15277-2-git-send-email-ludovic.Barre@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/2018 12:53 AM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch adds config data to manage specific properties by
> compatible. Adds stm32mp1 config which requires pclk clock.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>   .../devicetree/bindings/watchdog/st,stm32-iwdg.txt |  21 +++-
>   drivers/watchdog/stm32_iwdg.c                      | 132 ++++++++++++++-------
>   2 files changed, 104 insertions(+), 49 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
> index cc13b10a..f07f6d89 100644
> --- a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
> +++ b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
> @@ -2,18 +2,31 @@ STM32 Independent WatchDoG (IWDG)
>   ---------------------------------
>   
>   Required properties:
> -- compatible: "st,stm32-iwdg"
> -- reg: physical base address and length of the registers set for the device
> -- clocks: must contain a single entry describing the clock input
> +- compatible: Should be either "st,stm32-iwdg" or "st,stm32mp1-iwdg"
> +- reg: Physical base address and length of the registers set for the device
> +- clocks: Reference to the clock entry lsi. Additional pclk clock entry
> +  is required only for st,stm32mp1-iwdg.
> +- clock-names: Name of the clocks used.
> +  "lsi" for st,stm32-iwdg
> +  "pclk", "lsi" for st,stm32mp1-iwdg
>   
>   Optional Properties:
>   - timeout-sec: Watchdog timeout value in seconds.
>   
> -Example:
> +Examples:
>   
>   iwdg: watchdog@40003000 {
>   	compatible = "st,stm32-iwdg";
>   	reg = <0x40003000 0x400>;
>   	clocks = <&clk_lsi>;
> +	clock-names = "lsi";
> +	timeout-sec = <32>;
> +};
> +
> +iwdg: iwdg@5a002000 {
> +	compatible = "st,stm32mp1-iwdg";
> +	reg = <0x5a002000 0x400>;
> +	clocks = <&rcc IWDG2>, <&clk_lsi>;
> +	clock-names = "pclk", "lsi";
>   	timeout-sec = <32>;
>   };
> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> index c97ad56..fc96670 100644
> --- a/drivers/watchdog/stm32_iwdg.c
> +++ b/drivers/watchdog/stm32_iwdg.c
> @@ -11,12 +11,13 @@
>   
>   #include <linux/clk.h>
>   #include <linux/delay.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
>   #include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
>   #include <linux/of.h>
> +#include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   #include <linux/watchdog.h>
>   
> @@ -54,11 +55,17 @@
>   #define TIMEOUT_US	100000
>   #define SLEEP_US	1000
>   
> +struct stm32_iwdg_config {
> +	bool has_pclk;
> +};
> +

This data structure is unnecessary. Just assign the boolean directly to .data
and ...

>   struct stm32_iwdg {
> -	struct watchdog_device	wdd;
> -	void __iomem		*regs;
> -	struct clk		*clk;
> -	unsigned int		rate;
> +	struct watchdog_device		wdd;
> +	void __iomem			*regs;
> +	struct stm32_iwdg_config	*config;

declare bool has_pclk here.

> +	struct clk			*clk_lsi;
> +	struct clk			*clk_pclk;
> +	unsigned int			rate;
>   };
>   
>   static inline u32 reg_read(void __iomem *base, u32 reg)
> @@ -133,6 +140,44 @@ static int stm32_iwdg_set_timeout(struct watchdog_device *wdd,
>   	return 0;
>   }
>   
> +static int stm32_iwdg_clk_init(struct platform_device *pdev,
> +			       struct stm32_iwdg *wdt)
> +{
> +	u32 ret;
> +
> +	wdt->clk_lsi = devm_clk_get(&pdev->dev, "lsi");
> +	if (IS_ERR(wdt->clk_lsi)) {
> +		dev_err(&pdev->dev, "Unable to get lsi clock\n");
> +		return PTR_ERR(wdt->clk_lsi);
> +	}
> +
> +	/* optional peripheral clock */
> +	if (wdt->config->has_pclk) {
> +		wdt->clk_pclk = devm_clk_get(&pdev->dev, "pclk");
> +		if (IS_ERR(wdt->clk_pclk)) {
> +			dev_err(&pdev->dev, "Unable to get pclk clock\n");
> +			return PTR_ERR(wdt->clk_pclk);
> +		}
> +
> +		ret = clk_prepare_enable(wdt->clk_pclk);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Unable to prepare pclk clock\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = clk_prepare_enable(wdt->clk_lsi);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to prepare lsi clock\n");
> +		clk_disable_unprepare(wdt->clk_pclk);
> +		return ret;
> +	}
> +
> +	wdt->rate = clk_get_rate(wdt->clk_lsi);
> +
> +	return 0;
> +}
> +
>   static const struct watchdog_info stm32_iwdg_info = {
>   	.options	= WDIOF_SETTIMEOUT |
>   			  WDIOF_MAGICCLOSE |
> @@ -147,49 +192,50 @@ static const struct watchdog_ops stm32_iwdg_ops = {
>   	.set_timeout	= stm32_iwdg_set_timeout,
>   };
>   
> +static const struct stm32_iwdg_config stm32_iwdg_cfg = {
> +	.has_pclk = false,
> +};
> +
> +static const struct stm32_iwdg_config stm32mp1_iwdg_cfg = {
> +	.has_pclk = true,
> +};
> +
> +static const struct of_device_id stm32_iwdg_of_match[] = {
> +	{ .compatible = "st,stm32-iwdg", .data = &stm32_iwdg_cfg },
> +	{ .compatible = "st,stm32mp1-iwdg", .data = &stm32mp1_iwdg_cfg },
> +	{ /* end node */ }
> +};
> +MODULE_DEVICE_TABLE(of, stm32_iwdg_of_match);
> +
>   static int stm32_iwdg_probe(struct platform_device *pdev)
>   {
>   	struct watchdog_device *wdd;
> +	const struct of_device_id *match;
>   	struct stm32_iwdg *wdt;
>   	struct resource *res;
> -	void __iomem *regs;
> -	struct clk *clk;
>   	int ret;
>   
> +	match = of_match_device(stm32_iwdg_of_match, &pdev->dev);
> +	if (!match || !match->data)
> +		return -ENODEV;
> +
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	wdt->config = (struct stm32_iwdg_config *)match->data;
> +
>   	/* This is the timer base. */
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	regs = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(regs)) {
> +	wdt->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(wdt->regs)) {
>   		dev_err(&pdev->dev, "Could not get resource\n");
> -		return PTR_ERR(regs);
> +		return PTR_ERR(wdt->regs);
>   	}
>   
> -	clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(clk)) {
> -		dev_err(&pdev->dev, "Unable to get clock\n");
> -		return PTR_ERR(clk);
> -	}
> -
> -	ret = clk_prepare_enable(clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Unable to prepare clock %p\n", clk);
> +	ret = stm32_iwdg_clk_init(pdev, wdt);
> +	if (ret)
>   		return ret;
> -	}
> -
> -	/*
> -	 * Allocate our watchdog driver data, which has the
> -	 * struct watchdog_device nested within it.
> -	 */
> -	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> -	if (!wdt) {
> -		ret = -ENOMEM;
> -		goto err;
> -	}
> -
> -	/* Initialize struct stm32_iwdg. */
> -	wdt->regs = regs;
> -	wdt->clk = clk;
> -	wdt->rate = clk_get_rate(clk);
>   
>   	/* Initialize struct watchdog_device. */
>   	wdd = &wdt->wdd;
> @@ -217,7 +263,8 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
>   
>   	return 0;
>   err:
> -	clk_disable_unprepare(clk);
> +	clk_disable_unprepare(wdt->clk_lsi);
> +	clk_disable_unprepare(wdt->clk_pclk);
>   
>   	return ret;
>   }
> @@ -227,23 +274,18 @@ static int stm32_iwdg_remove(struct platform_device *pdev)
>   	struct stm32_iwdg *wdt = platform_get_drvdata(pdev);
>   
>   	watchdog_unregister_device(&wdt->wdd);
> -	clk_disable_unprepare(wdt->clk);
> +	clk_disable_unprepare(wdt->clk_lsi);
> +	clk_disable_unprepare(wdt->clk_pclk);
>   
>   	return 0;
>   }
>   
> -static const struct of_device_id stm32_iwdg_of_match[] = {
> -	{ .compatible = "st,stm32-iwdg" },
> -	{ /* end node */ }
> -};
> -MODULE_DEVICE_TABLE(of, stm32_iwdg_of_match);
> -
>   static struct platform_driver stm32_iwdg_driver = {
>   	.probe		= stm32_iwdg_probe,
>   	.remove		= stm32_iwdg_remove,
>   	.driver = {
>   		.name	= "iwdg",
> -		.of_match_table = stm32_iwdg_of_match,
> +		.of_match_table = of_match_ptr(stm32_iwdg_of_match),
>   	},
>   };
>   module_platform_driver(stm32_iwdg_driver);
> 

