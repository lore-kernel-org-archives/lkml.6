Return-Path: <shuah@kernel.org>
X-Google-Smtp-Source: AG47ELst+0wBX5KEmOiOGnALK6pMqcJOWomKgUOA3/TdN568fnbIYllx8nn72S++Mhthvn5iUsdX
ARC-Seal: i=1; a=rsa-sha256; t=1519663236; cv=none;
        d=google.com; s=arc-20160816;
        b=QKCqj2/oTN5ZhILcPWINeIkKGIWcRrCrqXnjQqZQHr4DgH/h/3In+JEpK4n/PwXHBp
         xHvpm6hnByML9OXYAYmtcHKlfkdGyi9xeunOVMARSKRie82nq4Pk1IX8AS9QzduCpQ/K
         63VrR2RPGcOcL5xXL4dqunoOVcCkQBGoP6aA/iuIewYrm73iJhxmHWSlySqKAj1kzy2W
         UTyQz7LwUPYOjIRrFbi9FpB5wEaU1HIzdVzPWEuWuH2qWV9dq+ZqX2kOHRk2y/5UxK+k
         TWB086xhBya7n4SVyFQF/tvtRG7xYldbW1kFaQI8Hn1dNXR7/Qrr+A24N8mH5P0yTNYu
         zYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:reply-to
         :arc-authentication-results;
        bh=180Gh+3BW6qNcE+xKr7MMadiHIl1B4LO/NFDUrGlmjE=;
        b=k2XFH+RigOjKIkaR7fmsulA4A1jy784HRTLs0u+cXuJTOIIOBTjd2o9XVP/oONdIh8
         zrubZdq22wTU3Jo9XvDAdEli7p1eMVo63fAnBrnTu7UjHHOO1Rmzjvl6bEnbuUOXcKGO
         h1cGjcABwkY1ckzPBNSviZ6/0AAbJvuySnVUH3M/XIDwLrWPVqFQeIkCFCTdvugP+w8k
         RUEdduax/su3V6sUR6MmLqI2Xm3r10Jzvn0dfPwIjW5tmABF3Q0WKMwONcBOVo65t0bs
         tscUqm2HpfBSe0SfKqnJ4/gdoJ7lPokV9b+rQIQnbVGVnASzs6alQuYM9C7BHB7Ga35n
         v1Ig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 64.68.200.34 is neither permitted nor denied by best guess record for domain of shuah@kernel.org) smtp.mailfrom=shuah@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 64.68.200.34 is neither permitted nor denied by best guess record for domain of shuah@kernel.org) smtp.mailfrom=shuah@kernel.org
Reply-To: shuah@kernel.org
Subject: Re: [PATCH] usbip: vudc: fix null pointer dereference on udc->lock
To: Colin King <colin.king@canonical.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuahkh@osg.samsung.com>, Shuah Khan <shuah@kernel.org>
References: <20180222173917.10841-1-colin.king@canonical.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <0e3059a0-1310-5d08-4623-f1cf34c52fc0@kernel.org>
Date: Mon, 26 Feb 2018 09:40:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222173917.10841-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593123702701163352?=
X-GMAIL-MSGID: =?utf-8?q?1593482398185269412?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/22/2018 10:39 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the driver attempts to spin lock on udc->lock before a NULL
> pointer check is performed on udc, hence there is a potential null
> pointer dereference on udc->lock.  Fix this by moving the null check
> on udc before the lock occurs.
> 
> Fixes: ea6873a45a22 ("usbip: vudc: Add SysFS infrastructure for VUDC")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/usb/usbip/vudc_sysfs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vudc_sysfs.c b/drivers/usb/usbip/vudc_sysfs.c
> index d86f72bbbb91..6dcd3ff655c3 100644
> --- a/drivers/usb/usbip/vudc_sysfs.c
> +++ b/drivers/usb/usbip/vudc_sysfs.c
> @@ -105,10 +105,14 @@ static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *a
>  	if (rv != 0)
>  		return -EINVAL;
>  
> +	if (!udc) {
> +		dev_err(dev, "no device");
> +		return -ENODEV;
> +	}
>  	spin_lock_irqsave(&udc->lock, flags);
>  	/* Don't export what we don't have */
> -	if (!udc || !udc->driver || !udc->pullup) {
> -		dev_err(dev, "no device or gadget not bound");
> +	if (!udc->driver || !udc->pullup) {
> +		dev_err(dev, "gadget not bound");
>  		ret = -ENODEV;
>  		goto unlock;
>  	}
> 

Thanks for the patch. Looks good to me.

Acked-by: Shuah Khan <shuahkh@osg.samsung.com>

thanks,
-- Shuah
