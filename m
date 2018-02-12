Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932378AbeBLBK4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 20:10:56 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:47063 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932266AbeBLBKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 20:10:55 -0500
X-Google-Smtp-Source: AH8x225Tjj3k2/zbcxFaT/xLzDHKVOt4RH/l5cEha9y8CwZvB/YDNVkaCkN43tnk2HtLn08qekHNqQ==
Date: Sun, 11 Feb 2018 17:10:51 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [v3, 1/7] watchdog: sama5d4: make use of timeout-secs provided
 in devicetree
Message-ID: <20180212011051.GA4673@roeck-us.net>
References: <20180211200847.25000-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211200847.25000-1-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 09:08:41PM +0100, Marcus Folkesson wrote:
> watchdog_init_timeout() will allways pick timeout_param since it
> defaults to a valid timeout.
> 
> Following best practice described in
> Documentation/watchdog/watchdog-kernel-api.txt to make use of
> the parameter logic.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Notes:
>     v3:
>     	- Use wdd->timeout instead of wdt_timeout when print out
>     	  timout in probe function.
> 
>  drivers/watchdog/sama5d4_wdt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
> index 0ae947c3d7bc..255169916dbb 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c
> @@ -33,7 +33,7 @@ struct sama5d4_wdt {
>  	unsigned long		last_ping;
>  };
>  
> -static int wdt_timeout = WDT_DEFAULT_TIMEOUT;
> +static int wdt_timeout;
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  
>  module_param(wdt_timeout, int, 0);
> @@ -212,7 +212,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	wdd = &wdt->wdd;
> -	wdd->timeout = wdt_timeout;
> +	wdd->timeout = WDT_DEFAULT_TIMEOUT;
>  	wdd->info = &sama5d4_wdt_info;
>  	wdd->ops = &sama5d4_wdt_ops;
>  	wdd->min_timeout = MIN_WDT_TIMEOUT;
> @@ -273,7 +273,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, wdt);
>  
>  	dev_info(&pdev->dev, "initialized (timeout = %d sec, nowayout = %d)\n",
> -		 wdt_timeout, nowayout);
> +		 wdd->timeout, nowayout);
>  
>  	return 0;
>  }
