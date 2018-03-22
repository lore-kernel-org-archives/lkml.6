Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752088AbeCVQrO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:47:14 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34598 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeCVQrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:47:12 -0400
X-Google-Smtp-Source: AG47ELtHHSTVZgTyVGQ+ljXAnuV0tnnzLsNkjU+4OfzVTjzcWQ9uVIIDL29m3y6+RJdkJa+W0buBeA==
Date: Thu, 22 Mar 2018 09:47:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Xiaofeng Wei <xiaofeng.wei@nxp.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, hongjun.chen@nxp.com
Subject: Re: [PATCH] watchdog: booke_wdt: Disable the watchdog prior to
 setting a new timeout value in order to avoid the following situation
Message-ID: <20180322164710.GA31876@roeck-us.net>
References: <20180322035146.1236-1-xiaofeng.wei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322035146.1236-1-xiaofeng.wei@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 11:51:46AM +0800, Xiaofeng Wei wrote:
> A watchdog timer exception also occurs if the selected time base bit transitions from 0 to 1 due
> to an mtspr that writes a 1 to the bit when its previous value was 0.
> 
Please drop "in order to ..." from the subject line. Every patch hopefully does
that.

> Signed-off-by: Xiaofeng Wei <xiaofeng.wei@nxp.com>
> ---
>  drivers/watchdog/booke_wdt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
> index 3ad1e44..70e742c 100644
> --- a/drivers/watchdog/booke_wdt.c
> +++ b/drivers/watchdog/booke_wdt.c
> @@ -186,9 +186,15 @@ static int booke_wdt_stop(struct watchdog_device *wdog)
>  static int booke_wdt_set_timeout(struct watchdog_device *wdt_dev,
>  				 unsigned int timeout)
>  {
> +	if (watchdog_active(wdt_dev))
> +		on_each_cpu(__booke_wdt_disable, NULL, 0);
> +

Thios would only be necessary if the timeout actually changes. Also, does
the problem apply to _all_ chips supported by this driver or only to a
subset ?

Guenter

>  	wdt_dev->timeout = timeout;
>  	booke_wdt_set(wdt_dev);
>  
> +	if (watchdog_active(wdt_dev))
> +		on_each_cpu(__booke_wdt_enable, wdt_dev, 0);
> +
>  	return 0;
>  }
>  
> -- 
> 2.9.3
> 
