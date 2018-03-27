Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeC0VEK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:04:10 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40411 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeC0VEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:04:09 -0400
X-Google-Smtp-Source: AIpwx4/h7DL6l7hifmFsdAfKXEF3LL8cY3XyuUy2j9iDc70BMILD3BR/APvdTk8Fhvu5u1t2ZnP8TA==
Subject: Re: [PATCH v2] aspeed: watchdog: Set bootstatus during probe
To: Eddie James <eajames@linux.vnet.ibm.com>,
        linux-watchdog@vger.kernel.org
Cc: openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        wim@linux-watchdog.org, joel@jms.id.au
References: <1522181367-11231-1-git-send-email-eajames@linux.vnet.ibm.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <09152d5f-5b49-9b8b-5ac3-829a2c9aab2e@roeck-us.net>
Date: Tue, 27 Mar 2018 14:04:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522181367-11231-1-git-send-email-eajames@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/2018 01:09 PM, Eddie James wrote:
> Check the aspeed timeout status register to see if the system has booted
> from the secondary boot source. If so, set the watchdog device
> bootstatus flag for "Card previously reset the CPU."
> 
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v1:
>   - use bootstatus instead of status
>   - use WDIOF_CARDRESET instead of raw register contents
> 
>   drivers/watchdog/aspeed_wdt.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index a5b8eb2..1abe4d0 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -55,6 +55,8 @@ struct aspeed_wdt_config {
>   #define   WDT_CTRL_WDT_INTR		BIT(2)
>   #define   WDT_CTRL_RESET_SYSTEM		BIT(1)
>   #define   WDT_CTRL_ENABLE		BIT(0)
> +#define WDT_TIMEOUT_STATUS	0x10
> +#define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY	BIT(1)
>   
>   /*
>    * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
> @@ -192,6 +194,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   	struct device_node *np;
>   	const char *reset_type;
>   	u32 duration;
> +	u32 status;
>   	int ret;
>   
>   	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> @@ -307,6 +310,10 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   		writel(duration - 1, wdt->base + WDT_RESET_WIDTH);
>   	}
>   
> +	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
> +	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY)
> +		wdt->wdd.bootstatus = WDIOF_CARDRESET;
> +
>   	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
>   	if (ret) {
>   		dev_err(&pdev->dev, "failed to register\n");
> 
