Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525095245; cv=none;
        d=google.com; s=arc-20160816;
        b=avO4XIt8SgpedqLfTMMkHPXounqwCMpv71qmM1ONcjbHtk6XYxqrVnncN6ERo04K2a
         shGkN6OdhQ2tnmUPkIyoMko2f+Khj14wE1NHysibA92f/aE8XIbMRDRsrqWbGBvGbG3v
         B1MTecn881IbDIAjUErOWzjLYRJKCECbFATfO48V6w/X+tLjXg1T1xKZiryMxz7kMh9Q
         MLV8tik6yRUbgrJhrhwT/8V7DzGHxOX437tY0sXBAp3mlPxb3+1gknEI9upyG/PdiIqC
         1PxTDPDTCZQziNWSkGvXzKv/0/KwQircdNLO7H0eiNdLdmFhHeuahYsBAS4wnznNcYTL
         0e1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:sender
         :dkim-signature:arc-authentication-results;
        bh=PRCEm3wQAFTpZcfLPz4ptLGehklu0cbr2r6c2dvCxtA=;
        b=CSXlUOHdQ0eTzg03eX5jt39R/PWVUgI3CCYLnhIiPJlps6LZzf5y9Ke22GNVZ/oeZi
         L/LcRGgkgVSxlyVp9iWnPOo63RXHK1wqS4lE5pY/i0CGaKx6f+wuIPAPI3ncH4LO3Us5
         v7JRJFo4c6tU/iSJztaHn1I0sLgOoesmp/X+gYUk4x2CMT7Va1pwGiS+imdqAe8beBeG
         fRmd/v6yWRnVHsoZYXY66KuOotRQGYAchVF/q14a43Q+CE15tv5KY1G4p6cXNstdviGC
         e2MsHW0rvTo0iMkFFTb65WFb/uphVPQ4z1Poaapx+SojvG1LOxh1zgnYSEHf4bCYgEUT
         qwHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SOv+MJar;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SOv+MJar;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AB8JxZqvN39ccO8M7DhOEl2G/XGFm0DbwdOC+NYdSOf2hgoikPb45+iomFvatLPxRcSqU2pAnEBz/A==
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 3/4] usb: typec: fusb302: Fix debugfs issue
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20180430124158.45269-1-heikki.krogerus@linux.intel.com>
 <20180430124158.45269-4-heikki.krogerus@linux.intel.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <293cc83d-28d9-149e-9c7a-f73b6df930d7@roeck-us.net>
Date: Mon, 30 Apr 2018 06:34:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430124158.45269-4-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599175003192024015?=
X-GMAIL-MSGID: =?utf-8?q?1599178271963765741?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/30/2018 05:41 AM, Heikki Krogerus wrote:
> Removing the "fusb302" debugfs directory when unloading
> the driver. That allows the driver to be loaded more then
> ones.
> 
> This fixes an issue where the driver, if unloaded, can't be
> re-loaded, as the "fusb302" debugfs directory already
> exists. While here, removing useless condition when creating
> the debugfs directory.
> 
> Fixes: 76f0c53d08b9 ("usb: typec: fusb302: Move out of staging")
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>   drivers/usb/typec/fusb302/fusb302.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/fusb302/fusb302.c b/drivers/usb/typec/fusb302/fusb302.c
> index eba6bb890b17..0e5d0aa052f5 100644
> --- a/drivers/usb/typec/fusb302/fusb302.c
> +++ b/drivers/usb/typec/fusb302/fusb302.c
> @@ -218,11 +218,9 @@ static struct dentry *rootdir;
>   static int fusb302_debugfs_init(struct fusb302_chip *chip)
>   {
>   	mutex_init(&chip->logbuffer_lock);
> -	if (!rootdir) {
> -		rootdir = debugfs_create_dir("fusb302", NULL);
> -		if (!rootdir)
> -			return -ENOMEM;
> -	}

I think the idea here was to permit more than one instance of the driver,
and have all debugfs file entries under the fusb302 directory. Loading the
second instance will fail after this patch is applied.

> +	rootdir = debugfs_create_dir("fusb302", NULL);
> +	if (!rootdir)
> +		return -ENOMEM;
>   
>   	chip->dentry = debugfs_create_file(dev_name(chip->dev),
>   					   S_IFREG | 0444, rootdir,
> @@ -234,6 +232,7 @@ static int fusb302_debugfs_init(struct fusb302_chip *chip)
>   static void fusb302_debugfs_exit(struct fusb302_chip *chip)
>   {
>   	debugfs_remove(chip->dentry);
> +	debugfs_remove(rootdir); >   }
>   
>   #else
> 
