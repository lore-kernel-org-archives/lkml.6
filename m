Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753054AbeBIWcN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 17:32:13 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39318 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752488AbeBIWcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 17:32:11 -0500
X-Google-Smtp-Source: AH8x225DhS+fWISIZbdG40upWlL01cUr+C55/X/HtCJPu2+aeSJ876gBsLZq4fG7UNfjvdTrf954FA==
Date: Fri, 9 Feb 2018 14:32:09 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] watchdog: asm9260_wdt: fix error handling in
 asm9260_wdt_probe()
Message-ID: <20180209223209.GA19627@roeck-us.net>
References: <1518213389-19246-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518213389-19246-1-git-send-email-khoroshilov@ispras.ru>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 12:56:29AM +0300, Alexey Khoroshilov wrote:
> If devm_reset_control_get_exclusive() fails, asm9260_wdt_probe()
> returns immediately. But clks has been already enabled at that point,
> so it is required to disable them.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  drivers/watchdog/asm9260_wdt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_wdt.c
> index 7dd0da644a7f..de9e538a5fa8 100644
> --- a/drivers/watchdog/asm9260_wdt.c
> +++ b/drivers/watchdog/asm9260_wdt.c
> @@ -297,8 +297,10 @@ static int asm9260_wdt_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	priv->rst = devm_reset_control_get_exclusive(&pdev->dev, "wdt_rst");
> -	if (IS_ERR(priv->rst))
> -		return PTR_ERR(priv->rst);
> +	if (IS_ERR(priv->rst)) {
> +		ret = PTR_ERR(priv->rst);
> +		goto clk_off;
> +	}

Good catch.

I would prefer to move the code around, ie call
devm_reset_control_get_exclusive() first and get the clocks
later.

Thanks,
Guenter

>  
>  	wdd = &priv->wdd;
>  	wdd->info = &asm9260_wdt_ident;
> -- 
> 2.7.4
> 
