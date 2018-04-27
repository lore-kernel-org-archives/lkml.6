Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757347AbeD0CN6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 22:13:58 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35540 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757197AbeD0CN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 22:13:56 -0400
X-Google-Smtp-Source: AB8JxZrHLu+XFqmztzgUmKMpisESCUT4BOK2PDqxMQXt3NcSYeWTIZCclo3XAldfrimNeGcKMog5BQ==
Date: Thu, 26 Apr 2018 19:13:53 -0700
From: Eduardo Valentin <edubezval@gmail.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] thermal: armada_thermal: Replace mdelay with
 usleep_range in armada380_init_sensor
Message-ID: <20180427021352.GC30803@localhost.localdomain>
References: <1523348008-29461-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523348008-29461-1-git-send-email-baijiaju1990@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 04:13:28PM +0800, Jia-Ju Bai wrote:
> armada380_init_sensor() is never called in atomic context.
> 
> armada380_init_sensor() is set as ".init_sensor" in
> struct armada_thermal_data.
> ".init_sensor" is called armada_thermal_probe().
> armada_thermal_probe() is set as ".probe" in struct platform_driver.
> This function is not called in atomic context.
> 
> Despite never getting called from atomic context, armada380_init_sensor()
> calls mdelay() to busily wait.
> This is not necessary and can be replaced with usleep_range() to
> avoid busy waiting.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/thermal/armada_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index ae75328..c289ae4 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -143,7 +143,7 @@ static void armada380_init_sensor(struct platform_device *pdev,
>  	if (!(reg & A380_HW_RESET)) {
>  		reg |= A380_HW_RESET;
>  		writel(reg, priv->control);
> -		mdelay(10);
> +		usleep_range(10000, 11000);

This does not apply:
checking file drivers/thermal/armada_thermal.c
Hunk #1 FAILED at 143.
1 out of 1 hunk FAILED

That mdelay() is not existing anymore.

>  	}
>  }
>  
> -- 
> 1.9.1
> 
