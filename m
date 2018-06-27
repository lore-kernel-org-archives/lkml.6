Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD50C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F58264D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWERpaP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F58264D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932364AbeF0Apd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 20:45:33 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42478 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752638AbeF0Apa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 20:45:30 -0400
Received: by mail-pf0-f193.google.com with SMTP id w7-v6so144726pfn.9;
        Tue, 26 Jun 2018 17:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zq5Io9msaBInykPt7rnSqUbiFPxyaBXmEBSGUm74SOQ=;
        b=JWERpaP5xi/wL60x2n07YcvR6o97yfSpdXanvaZZBihKotillhQevutXlQm88t3vRk
         k+3R8bX2YVH6JYNRLoi9B+OC6Z8A+O0ZDWMdNicjHOIQsZVFPvBpffeRNAp4AXC4So/k
         hDlpKM0/6tdcqwpeRhyMyNtuJWlwV1cagiYRbyXYcJpgRG5KepC1/7Vt72lvqEbHRPke
         6Kh781vqSztRlR12zaF3igk4pRvWKUn+Vsjj21WGGKpW3IIPHKY31uj3YhHO6lPcgUD+
         1LxpfZzOBfWb6dctbhAD4xictV5Mxt7zwtwxbwazlH7Ti5Mhp57LkPcXX2YYtX2gnU+R
         zvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zq5Io9msaBInykPt7rnSqUbiFPxyaBXmEBSGUm74SOQ=;
        b=YzQmVNCMm7acME9/1fXOWCxT5xyGDLT+Z8z7+szkHnpMs41DKlW8CpUHZ0YqAhMqr7
         1DFZp5TlrA9iL0Un+++ag29570oPMIFE9YNiyJnhEtzPPaKYslia86sy5REUY7x+c+65
         NP/ZAZu0FgXfV/hRd8CFdcVQeUKD7LKc/bgmLwey2wze5dxxxvb5TAi1nhcMkNfuTCqg
         4IL7+mIzwOd8hraHiV6XoUkCMbrgYuS0XjgbiGLzWEWgendceLkGC6W8817Vo31JNQkT
         dYLb8QsdA+cJ0lIHjMFweBGgf7nwdRHrxWYpKaAnA0D5atfO5XKEnIGj5IX+KuHs0KPR
         KSnQ==
X-Gm-Message-State: APt69E2CLSt6iSrhTEkkQiOtGSqrZAWonjTe1ytIcN11TJFVWyXr8xuh
        XVLzW4SZrFzXTdMawhjNLygDVg==
X-Google-Smtp-Source: AAOMgpe5B9ji4Ey0Z6IB1It4gtP+2XKKgMFAdGUHXDW3LBNb+pfKXb5PZ1Zii9/3SogXCS/5mIZUZQ==
X-Received: by 2002:a62:b94:: with SMTP id 20-v6mr3570008pfl.234.1530060329997;
        Tue, 26 Jun 2018 17:45:29 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id q6-v6sm3214122pgc.21.2018.06.26.17.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 17:45:29 -0700 (PDT)
Subject: Re: [PATCH V5 2/5] watchdog: stm32: add pclk feature for stm32mp1
To:     Ludovic Barre <ludovic.Barre@st.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
 <1529941383-8653-3-git-send-email-ludovic.Barre@st.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ccfad549-6ec3-0fd8-145a-74e5fd98b055@roeck-us.net>
Date:   Tue, 26 Jun 2018 17:45:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529941383-8653-3-git-send-email-ludovic.Barre@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 08:43 AM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch adds compatible data to manage pclk clock by
> compatible. Adds stm32mp1 support which requires pclk clock.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>

I take it that everyone is aware that this patch will result in a window
where the driver won't work anymore since the DT files are not updated
yet and the clock name is now mandatory. This goes in line with my
unhappiness about the now mandatory clock names, even if there is only
a single clock.

Having said that, since everyone else is ok with it,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/stm32_iwdg.c | 116 +++++++++++++++++++++++++++---------------
>   1 file changed, 74 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> index c97ad56..e00e3b3 100644
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
> @@ -54,11 +55,15 @@
>   #define TIMEOUT_US	100000
>   #define SLEEP_US	1000
>   
> +#define HAS_PCLK	true
> +
>   struct stm32_iwdg {
>   	struct watchdog_device	wdd;
>   	void __iomem		*regs;
> -	struct clk		*clk;
> +	struct clk		*clk_lsi;
> +	struct clk		*clk_pclk;
>   	unsigned int		rate;
> +	bool			has_pclk;
>   };
>   
>   static inline u32 reg_read(void __iomem *base, u32 reg)
> @@ -133,6 +138,44 @@ static int stm32_iwdg_set_timeout(struct watchdog_device *wdd,
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
> +	if (wdt->has_pclk) {
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
> @@ -147,49 +190,42 @@ static const struct watchdog_ops stm32_iwdg_ops = {
>   	.set_timeout	= stm32_iwdg_set_timeout,
>   };
>   
> +static const struct of_device_id stm32_iwdg_of_match[] = {
> +	{ .compatible = "st,stm32-iwdg", .data = (void *)!HAS_PCLK },
> +	{ .compatible = "st,stm32mp1-iwdg", .data = (void *)HAS_PCLK },
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
> +	if (!match)
> +		return -ENODEV;
> +
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	wdt->has_pclk = match->data;
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
> @@ -217,7 +253,8 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
>   
>   	return 0;
>   err:
> -	clk_disable_unprepare(clk);
> +	clk_disable_unprepare(wdt->clk_lsi);
> +	clk_disable_unprepare(wdt->clk_pclk);
>   
>   	return ret;
>   }
> @@ -227,23 +264,18 @@ static int stm32_iwdg_remove(struct platform_device *pdev)
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

