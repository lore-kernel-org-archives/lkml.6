Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932890AbeCJDWv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 22:22:51 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34555 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932855AbeCJDWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 22:22:48 -0500
X-Google-Smtp-Source: AG47ELtRlfh1xC2hloZr3bBiVKuoUD+hq/p3tOk3N1tRTEmgwV4f7YRnv6fgPDhpjj6yr/jRNxEdkg==
Subject: Re: [PATCH 2/2] watchdog: dw: save/restore control and timeout across
 suspend/resume
To: Brian Norris <briannorris@chromium.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
References: <20180310024431.160195-1-briannorris@chromium.org>
 <20180310024431.160195-2-briannorris@chromium.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <9a79920c-71a6-d609-aefc-15b92802a3ed@roeck-us.net>
Date: Fri, 9 Mar 2018 19:22:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310024431.160195-2-briannorris@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2018 06:44 PM, Brian Norris wrote:
> Some platforms lose this state in suspend. It should be safe to do this
> unconditionally.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/dw_wdt.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 6925d3e6c6b3..094986047194 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -57,6 +57,9 @@ struct dw_wdt {
>   	unsigned long		rate;
>   	struct watchdog_device	wdd;
>   	struct reset_control	*rst;
> +	/* Save/restore */
> +	u32			control;
> +	u32			timeout;
>   };
>   
>   #define to_dw_wdt(wdd)	container_of(wdd, struct dw_wdt, wdd)
> @@ -204,6 +207,9 @@ static int dw_wdt_suspend(struct device *dev)
>   {
>   	struct dw_wdt *dw_wdt = dev_get_drvdata(dev);
>   
> +	dw_wdt->control = readl(dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
> +	dw_wdt->timeout = readl(dw_wdt->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
> +
>   	clk_disable_unprepare(dw_wdt->clk);
>   
>   	return 0;
> @@ -217,6 +223,9 @@ static int dw_wdt_resume(struct device *dev)
>   	if (err)
>   		return err;
>   
> +	writel(dw_wdt->timeout, dw_wdt->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
> +	writel(dw_wdt->control, dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
> +
>   	dw_wdt_ping(&dw_wdt->wdd);
>   
>   	return 0;
> 
