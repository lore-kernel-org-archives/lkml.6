Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964829AbeEIR3k (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:29:40 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:38421 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935265AbeEIR3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:29:38 -0400
Date: Wed, 9 May 2018 10:29:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, jdelvare@suse.com,
        stewart@linux.vnet.ibm.com
Subject: Re: [PATCH 2/3] hwmon: (ibmpowernv): Add support to read 64 bit
 sensors
Message-ID: <20180509172926.GA20996@roeck-us.net>
References: <1525688738-9185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1525688738-9185-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525688738-9185-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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

On Mon, May 07, 2018 at 03:55:37PM +0530, Shilpasri G Bhat wrote:
> The firmware has supported for reading sensor values of size u32.
> This patch adds support to use newer firmware functions which allows
> to read the sensors of size u64.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

I won't apply for the time being since it depends on patch 1/3 which is
outside hwmon.

> ---
>  drivers/hwmon/ibmpowernv.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index 5ccdd0b..74d9b5a 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -101,9 +101,10 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
>  	struct sensor_data *sdata = container_of(devattr, struct sensor_data,
>  						 dev_attr);
>  	ssize_t ret;
> -	u32 x;
> +	u64 x;
> +
> +	ret =  opal_get_sensor_data_u64(sdata->id, &x);
>  
> -	ret = opal_get_sensor_data(sdata->id, &x);
>  	if (ret)
>  		return ret;
>  
> @@ -114,7 +115,7 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
>  	else if (sdata->type == POWER_INPUT)
>  		x *= 1000000;
>  
> -	return sprintf(buf, "%u\n", x);
> +	return sprintf(buf, "%llu\n", x);
>  }
>  
>  static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
