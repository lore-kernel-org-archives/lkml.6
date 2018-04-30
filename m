Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753044AbeD3LSa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 07:18:30 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35752 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752668AbeD3LS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 07:18:29 -0400
X-Google-Smtp-Source: AB8JxZquBUopHcrqa6xBHSDyldom1b1d7sU9dDPSPKvvw/pF5icpX6gLxMXXLeJ0XUl4L3VaDt4yyA==
Subject: Re: [PATCH] watchdog: sp805: add restart handler
To: Jongsung Kim <neidhard.kim@lge.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Chanho Min <chanho.min@lge.com>
References: <20180430064433.28715-1-neidhard.kim@lge.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <452a2320-c297-2bd2-2e98-0b71a077c065@roeck-us.net>
Date: Mon, 30 Apr 2018 04:18:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430064433.28715-1-neidhard.kim@lge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/29/2018 11:44 PM, Jongsung Kim wrote:
> Add restart handler for SP805 watchdog so that the driver can be
> used to reboot the system.
> 
> Signed-off-by: Jongsung Kim <neidhard.kim@lge.com>
> ---
>   drivers/watchdog/sp805_wdt.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index 01d816251302..01f7b6c29f92 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -23,6 +23,7 @@
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
>   #include <linux/pm.h>
> +#include <linux/reboot.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
>   #include <linux/types.h>
> @@ -67,6 +68,7 @@ struct sp805_wdt {
>   	struct clk			*clk;
>   	struct amba_device		*adev;
>   	unsigned int			load_val;
> +	struct notifier_block		restart;
>   };
>   
>   static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -200,6 +202,18 @@ static const struct watchdog_ops wdt_ops = {
>   	.get_timeleft	= wdt_timeleft,
>   };
>   
> +static int
> +wdt_restart(struct notifier_block *this, unsigned long mode, void *cmd)
> +{
> +	struct sp805_wdt *wdt = container_of(this, struct sp805_wdt, restart);
> +
> +	writel_relaxed(0, wdt->base + WDTCONTROL);
> +	writel_relaxed(0, wdt->base + WDTLOAD);
> +	writel_relaxed(INT_ENABLE | RESET_ENABLE, wdt->base + WDTCONTROL);
> +
> +	return 0;
> +}
> +
>   static int
>   sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>   {
> @@ -241,6 +255,10 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>   	}
>   	amba_set_drvdata(adev, wdt);
>   
> +	wdt->restart.notifier_call = wdt_restart;
> +	wdt->restart.priority = 128;
> +	register_restart_handler(&wdt->restart);
> +

Why not use the watchdog core ?

Guenter

>   	dev_info(&adev->dev, "registration successful\n");
>   	return 0;
>   
> @@ -253,6 +271,7 @@ static int sp805_wdt_remove(struct amba_device *adev)
>   {
>   	struct sp805_wdt *wdt = amba_get_drvdata(adev);
>   
> +	unregister_restart_handler(&wdt->restart);
>   	watchdog_unregister_device(&wdt->wdd);
>   	watchdog_set_drvdata(&wdt->wdd, NULL);
>   
> 
