Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbeEBNWD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:22:03 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37482 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeEBNWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:22:00 -0400
X-Google-Smtp-Source: AB8JxZqM5BAH8WavahHrwftuz1X+mUtPgsT3mBuralnKff0tH7PKcM0sl5wYC75epJkY+X6JDf5T2w==
Subject: Re: [PATCH v2] watchdog: sp805: add restart handler
To: Jongsung Kim <neidhard.kim@lge.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chanho Min <chanho.min@lge.com>
References: <1525247979-23156-1-git-send-email-neidhard.kim@lge.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <cf2f151a-06d7-368e-7ae5-68e992dfc3ea@roeck-us.net>
Date: Wed, 2 May 2018 06:21:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525247979-23156-1-git-send-email-neidhard.kim@lge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2018 12:59 AM, Jongsung Kim wrote:
> Add restart handler for SP805 watchdog so that the driver can be
> used to reboot the system.
> 
> Signed-off-by: Jongsung Kim <neidhard.kim@lge.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/watchdog/sp805_wdt.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index 03805bc..969369e 100644
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
> 
Please add the restart priority

	watchdog_set_restart_priority(&wdt->wdd, 128);

before registering the watchdog.

Thanks,
Guenter
