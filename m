Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932344AbeD0CMO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 22:12:14 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39943 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754298AbeD0CMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 22:12:12 -0400
X-Google-Smtp-Source: AB8JxZrBicjCQVjI3q4qcoEPOC0TwMv0qfWiL0/PZPkxlKw9t8rc6NHLGrvuq4Rjb/IoOIhNlsP+CA==
Date: Thu, 26 Apr 2018 19:12:07 -0700
From: Eduardo Valentin <edubezval@gmail.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] thermal: armada_thermal: Replace mdelay with msleep
 in armada375_init_sensor
Message-ID: <20180427021204.GB30803@localhost.localdomain>
References: <1523347996-29417-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523347996-29417-1-git-send-email-baijiaju1990@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 04:13:16PM +0800, Jia-Ju Bai wrote:
> armada375_init_sensor() is never called in atomic context.
> 
> armada375_init_sensor() is set as ".init_sensor" in
> struct armada_thermal_data.
> ".init_sensor" is called armada_thermal_probe().
> armada_thermal_probe() is set as ".probe" in struct platform_driver.
> This function is not called in atomic context.
> 
> Despite never getting called from atomic context, armada375_init_sensor()
> calls mdelay() to busily wait.
> This is not necessary and can be replaced with msleep() to
> avoid busy waiting.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/thermal/armada_thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index ae75328..0825a7a 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -127,11 +127,11 @@ static void armada375_init_sensor(struct platform_device *pdev,
>  	reg &= ~A375_HW_RESETn;
>  
>  	writel(reg, priv->control + 4);
> -	mdelay(20);
> +	msleep(20);
>  
>  	reg |= A375_HW_RESETn;
>  	writel(reg, priv->control + 4);
> -	mdelay(50);
> +	msleep(50);

Already done:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/armada_thermal.c#n144

>  }
>  
>  static void armada380_init_sensor(struct platform_device *pdev,
> -- 
> 1.9.1
> 
