Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932769AbeEHOsc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:48:32 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:51826 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932659AbeEHOsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:48:30 -0400
Date: Tue, 8 May 2018 07:48:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: morbidrsa@gmail.com, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: mena21_wdt: Drop unnecessary mutex lock
Message-ID: <20180508144822.GA11268@roeck-us.net>
References: <20180508071206.13375-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508071206.13375-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 03:12:06PM +0800, Jia-Ju Bai wrote:
> There is already a mutex in the watchdog core which serializes
> calls to the various API functions. 
> So the mutex lock "drv->lock" is unnecessary and can be dropped.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/mena21_wdt.c | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
> index 25d5d2b8cfbe..0be7f50e8ff9 100644
> --- a/drivers/watchdog/mena21_wdt.c
> +++ b/drivers/watchdog/mena21_wdt.c
> @@ -31,7 +31,6 @@ enum a21_wdt_gpios {
>  
>  struct a21_wdt_drv {
>  	struct watchdog_device wdt;
> -	struct mutex lock;
>  	unsigned gpios[NUM_GPIOS];
>  };
>  
> @@ -55,12 +54,8 @@ static int a21_wdt_start(struct watchdog_device *wdt)
>  {
>  	struct a21_wdt_drv *drv = watchdog_get_drvdata(wdt);
>  
> -	mutex_lock(&drv->lock);
> -
>  	gpio_set_value(drv->gpios[GPIO_WD_ENAB], 1);
>  
> -	mutex_unlock(&drv->lock);
> -
>  	return 0;
>  }
>  
> @@ -68,12 +63,8 @@ static int a21_wdt_stop(struct watchdog_device *wdt)
>  {
>  	struct a21_wdt_drv *drv = watchdog_get_drvdata(wdt);
>  
> -	mutex_lock(&drv->lock);
> -
>  	gpio_set_value(drv->gpios[GPIO_WD_ENAB], 0);
>  
> -	mutex_unlock(&drv->lock);
> -
>  	return 0;
>  }
>  
> @@ -81,14 +72,10 @@ static int a21_wdt_ping(struct watchdog_device *wdt)
>  {
>  	struct a21_wdt_drv *drv = watchdog_get_drvdata(wdt);
>  
> -	mutex_lock(&drv->lock);
> -
>  	gpio_set_value(drv->gpios[GPIO_WD_TRIG], 0);
>  	ndelay(10);
>  	gpio_set_value(drv->gpios[GPIO_WD_TRIG], 1);
>  
> -	mutex_unlock(&drv->lock);
> -
>  	return 0;
>  }
>  
> @@ -108,8 +95,6 @@ static int a21_wdt_set_timeout(struct watchdog_device *wdt,
>  		return -EINVAL;
>  	}
>  
> -	mutex_lock(&drv->lock);
> -
>  	if (timeout == 1)
>  		gpio_set_value(drv->gpios[GPIO_WD_FAST], 1);
>  	else
> @@ -117,8 +102,6 @@ static int a21_wdt_set_timeout(struct watchdog_device *wdt,
>  
>  	wdt->timeout = timeout;
>  
> -	mutex_unlock(&drv->lock);
> -
>  	return 0;
>  }
>  
> @@ -191,7 +174,6 @@ static int a21_wdt_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>  
> -	mutex_init(&drv->lock);
>  	watchdog_init_timeout(&a21_wdt, 30, &pdev->dev);
>  	watchdog_set_nowayout(&a21_wdt, nowayout);
>  	watchdog_set_drvdata(&a21_wdt, drv);
> -- 
> 2.17.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
