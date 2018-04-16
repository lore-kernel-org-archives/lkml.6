Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeDPR3B (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 13:29:01 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:44358 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeDPR3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 13:29:00 -0400
Date: Mon, 16 Apr 2018 10:28:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ahsan Hussain <ahsan_hussain@mentor.com>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, chombour <Cedric_Hombourger@mentor.com>,
        ahsann <Noor_Ahsan@mentor.com>, m.purski@samsung.com
Subject: Re: [PATCH 1/1] hwmon: (ina2xx) initialize mutex before locking
Message-ID: <20180416172858.GA9447@roeck-us.net>
References: <f286b0f4-948f-74a7-6dc1-90ca88f3dcdc@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f286b0f4-948f-74a7-6dc1-90ca88f3dcdc@mentor.com>
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

On Mon, Apr 16, 2018 at 10:08:19PM +0500, Ahsan Hussain wrote:
> 
> Upstream commit
> 
> 8d008c0c ("hwmon: (ina2xx) Make calibration register value fixed")
> 
This doesn't have to be on separate lines; as written, it just causes
confusion.

> makes ina2xx_set_shunt() call mutex_lock on an un-initialized mutex.
> Initialize it prior so we don't get a NULL pointer dereference error
> 
> Signed-off-by: Ahsan Hussain <ahsan_hussain@mentor.com>

Good find, but your patch is corrupted to the point where any attenpt to
fix it up on my side failed. Please resend without corruption, and please
provide a Fixes: line.

Thanks,
Guenter

> ---
>  drivers/hwmon/ina2xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> index a629f7c..1304f01 100644
> --- a/drivers/hwmon/ina2xx.c
> +++ b/drivers/hwmon/ina2xx.c
> @@ -457,6 +457,8 @@ static int ina2xx_probe(struct i2c_client *client,
>  			val = INA2XX_RSHUNT_DEFAULT;
>  	}
>  +	mutex_init(&data->config_lock);
> +
>  	ina2xx_set_shunt(data, val);
>   	ina2xx_regmap_config.max_register = data->config->registers;
> @@ -473,8 +475,6 @@ static int ina2xx_probe(struct i2c_client *client,
>  		return -ENODEV;
>  	}
>  -	mutex_init(&data->config_lock);
> -
>  	data->groups[group++] = &ina2xx_group;
>  	if (id->driver_data == ina226)
>  		data->groups[group++] = &ina226_group;
> -- 
> 2.7.4
> 
