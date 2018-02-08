Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeBHOQF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:16:05 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37835 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeBHOQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:16:03 -0500
X-Google-Smtp-Source: AH8x225+M9ojgKAW3TS0B+BpS8gBi5pwtn7ImCNGHo05p3p55CzocbpjmZTw2kUHmFLEuat9oMYw2Q==
Subject: Re: [PATCH] watchdog: imx2_wdt: allow setting timeout in devicetree
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180208131108.3048-1-marcus.folkesson@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e70ce3b6-1fb6-5d18-25bd-4fe7bf15b296@roeck-us.net>
Date: Thu, 8 Feb 2018 06:15:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180208131108.3048-1-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2018 05:11 AM, Marcus Folkesson wrote:
> By following best practice described in
> Documentation/watchdog/watchdog-kernel-api.txt, it also let us to set
> timout-sec property in devicetree.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt | 2 ++
>   drivers/watchdog/imx2_wdt.c                                | 8 ++------
>   2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> index 107280ef0025..adc6b76fcb3a 100644
> --- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> @@ -11,6 +11,7 @@ Optional properties:
>     detail please see: Documentation/devicetree/bindings/regmap/regmap.txt.
>   - fsl,ext-reset-output: If present the watchdog device is configured to
>     assert its external reset (WDOG_B) instead of issuing a software reset.
> +- timeout-sec : Contains the watchdog timeout in seconds
>   
>   Examples:
>   
> @@ -19,4 +20,5 @@ wdt@73f98000 {
>   	reg = <0x73f98000 0x4000>;
>   	interrupts = <58>;
>   	big-endian;
> +	timeout-sec = <20>;
>   };
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 4874b0f18650..b8674c5c2d9f 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -76,7 +76,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>   				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>   
>   
> -static unsigned timeout = IMX2_WDT_DEFAULT_TIME;
> +static unsigned timeout;
>   module_param(timeout, uint, 0);
>   MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
>   				__MODULE_STRING(IMX2_WDT_DEFAULT_TIME) ")");
> @@ -275,6 +275,7 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>   	wdog->info		= &imx2_wdt_info;
>   	wdog->ops		= &imx2_wdt_ops;
>   	wdog->min_timeout	= 1;
> +	wdog->timeout		= IMX2_WDT_DEFAULT_TIME;
>   	wdog->max_hw_heartbeat_ms = IMX2_WDT_MAX_TIME * 1000;
>   	wdog->parent		= &pdev->dev;
>   
> @@ -293,11 +294,6 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>   
>   	wdev->ext_reset = of_property_read_bool(pdev->dev.of_node,
>   						"fsl,ext-reset-output");
> -	wdog->timeout = clamp_t(unsigned, timeout, 1, IMX2_WDT_MAX_TIME);
> -	if (wdog->timeout != timeout)
> -		dev_warn(&pdev->dev, "Initial timeout out of range! Clamped from %u to %u\n",
> -			 timeout, wdog->timeout);
> -
>   	platform_set_drvdata(pdev, wdog);
>   	watchdog_set_drvdata(wdog, wdev);
>   	watchdog_set_nowayout(wdog, nowayout);
> 
