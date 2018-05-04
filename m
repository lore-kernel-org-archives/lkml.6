Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeEDNLm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:11:42 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43224 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbeEDNLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:11:40 -0400
X-Google-Smtp-Source: AB8JxZquDaoZnycLNcd7TzZQPZNtu8gprK2eTIA//fuVKdfvV5L6jevT4VIJNI1pLywO0NyrWlQxhQ==
Subject: Re: [PATCH v3] watchdog: sp805: add restart handler
To: Jongsung Kim <neidhard.kim@lge.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chanho Min <chanho.min@lge.com>
References: <cf2f151a-06d7-368e-7ae5-68e992dfc3ea@roeck-us.net>
 <1525413903-7066-1-git-send-email-neidhard.kim@lge.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1b084bff-84fd-18fa-7bee-dd00e33405a2@roeck-us.net>
Date: Fri, 4 May 2018 06:11:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525413903-7066-1-git-send-email-neidhard.kim@lge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2018 11:05 PM, Jongsung Kim wrote:
> Add restart handler for SP805 watchdog so that the driver can be
> used to reboot the system.
> 
> Signed-off-by: Jongsung Kim <neidhard.kim@lge.com>
> Cc: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---

For future patches: change log goes here, please.

Thanks,
Guenter

>   drivers/watchdog/sp805_wdt.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index 03805bc..9849db0 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -121,6 +121,18 @@ static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>   	return div_u64(load, rate);
>   }
>   
> +static int
> +wdt_restart(struct watchdog_device *wdd, unsigned long mode, void *cmd)
> +{
> +	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	writel_relaxed(0, wdt->base + WDTCONTROL);
> +	writel_relaxed(0, wdt->base + WDTLOAD);
> +	writel_relaxed(INT_ENABLE | RESET_ENABLE, wdt->base + WDTCONTROL);
> +
> +	return 0;
> +}
> +
>   static int wdt_config(struct watchdog_device *wdd, bool ping)
>   {
>   	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
> @@ -197,6 +209,7 @@ static const struct watchdog_ops wdt_ops = {
>   	.ping		= wdt_ping,
>   	.set_timeout	= wdt_setload,
>   	.get_timeleft	= wdt_timeleft,
> +	.restart	= wdt_restart,
>   };
>   
>   static int
> @@ -230,6 +243,7 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>   	spin_lock_init(&wdt->lock);
>   	watchdog_set_nowayout(&wdt->wdd, nowayout);
>   	watchdog_set_drvdata(&wdt->wdd, wdt);
> +	watchdog_set_restart_priority(&wdt->wdd, 128);
>   	wdt_setload(&wdt->wdd, DEFAULT_TIMEOUT);
>   
>   	ret = watchdog_register_device(&wdt->wdd);
> 
