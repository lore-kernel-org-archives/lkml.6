Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeCXAWz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 20:22:55 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33615 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCXAWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 20:22:53 -0400
X-Google-Smtp-Source: AG47ELvJRxe2udSMg1JD9BbGCWRCqf7bzjxvzxIIEuTxUG5LKZr7FzNGfaBIbt93Z2zqluTatlEYgw==
Subject: Re: [PATCH] watchdog: davinci_wdt: fix error handling in
 davinci_wdt_probe()
To: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
References: <1521841006-12153-1-git-send-email-khoroshilov@ispras.ru>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <b08164bd-eef1-dae5-ebbd-a42ca55f46d9@roeck-us.net>
Date: Fri, 23 Mar 2018 17:22:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521841006-12153-1-git-send-email-khoroshilov@ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/2018 02:36 PM, Alexey Khoroshilov wrote:
> clk_disable_unprepare() was added to one error path,
> but there is another one. The patch makes sure clk is
> disabled at the both of them.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/davinci_wdt.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
> index 3e4c592c239f..6c6594261cb7 100644
> --- a/drivers/watchdog/davinci_wdt.c
> +++ b/drivers/watchdog/davinci_wdt.c
> @@ -236,15 +236,22 @@ static int davinci_wdt_probe(struct platform_device *pdev)
>   
>   	wdt_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	davinci_wdt->base = devm_ioremap_resource(dev, wdt_mem);
> -	if (IS_ERR(davinci_wdt->base))
> -		return PTR_ERR(davinci_wdt->base);
> +	if (IS_ERR(davinci_wdt->base)) {
> +		ret = PTR_ERR(davinci_wdt->base);
> +		goto err_clk_disable;
> +	}
>   
>   	ret = watchdog_register_device(wdd);
> -	if (ret < 0) {
> -		clk_disable_unprepare(davinci_wdt->clk);
> +	if (ret) {
>   		dev_err(dev, "cannot register watchdog device\n");
> +		goto err_clk_disable;
>   	}
>   
> +	return 0;
> +
> +err_clk_disable:
> +	clk_disable_unprepare(davinci_wdt->clk);
> +
>   	return ret;
>   }
>   
> 
