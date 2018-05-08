Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754022AbeEHD2l (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 23:28:41 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44756 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753896AbeEHD2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 23:28:38 -0400
X-Google-Smtp-Source: AB8JxZpXXdXvoP4YFyq9P7ts1e1IUDOCOXZJVElOs9/oBu9NZWj1/bHRZtL7d4n5R2VZD0vLz8xtag==
Subject: Re: [PATCH] watchdog: mena21_wdt: Fix a possible data race in
 a21_wdt_set_timeout
To: Jia-Ju Bai <baijiaju1990@gmail.com>, morbidrsa@gmail.com,
        wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180508031825.12525-1-baijiaju1990@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <64e08944-0578-ac4c-8dea-e1e704685e77@roeck-us.net>
Date: Mon, 7 May 2018 20:28:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508031825.12525-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 08:18 PM, Jia-Ju Bai wrote:
> The write operation to "wdt->timeout" is protected by
> the lock on line 118, but the read operation to
> this data on line 105 is not protected by the lock.
> Thus, there may exist a data race for "wdt->timeout".
> 
> To fix this data race, the read operation to "wdt->timeout"
> should be also protected by the lock.
> 

There is no race. There is already a mutex in the watchdog core which serializes
calls to the various API functions. It would make more sense to drop drv->lock
from the driver.

Guenter

> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>   drivers/watchdog/mena21_wdt.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
> index 25d5d2b8cfbe..05ca69042829 100644
> --- a/drivers/watchdog/mena21_wdt.c
> +++ b/drivers/watchdog/mena21_wdt.c
> @@ -102,14 +102,15 @@ static int a21_wdt_set_timeout(struct watchdog_device *wdt,
>   		return -EINVAL;
>   	}
>   
> +	mutex_lock(&drv->lock);
> +
>   	if (timeout == 30 && wdt->timeout == 1) {
> +		mutex_unlock(&drv->lock);
>   		dev_err(wdt->parent,
>   			"Transition from fast to slow mode not allowed\n");
>   		return -EINVAL;
>   	}
>   
> -	mutex_lock(&drv->lock);
> -
>   	if (timeout == 1)
>   		gpio_set_value(drv->gpios[GPIO_WD_FAST], 1);
>   	else
> 
