Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932218AbeD0CL3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 22:11:29 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38915 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757142AbeD0CL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 22:11:27 -0400
X-Google-Smtp-Source: AB8JxZock387xCInFusbKvXfSYuSUwJ+oj3AQt36M9KA2wbHDqRo7FOzKu3Br0iNKICs6gjkdc2TNQ==
Date: Thu, 26 Apr 2018 19:11:24 -0700
From: Eduardo Valentin <edubezval@gmail.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] thermal: armada_thermal: Replace mdelay with
 usleep_range in armada370_init_sensor
Message-ID: <20180427021122.GA30803@localhost.localdomain>
References: <1523347982-29373-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523347982-29373-1-git-send-email-baijiaju1990@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jia-Ju,

On Tue, Apr 10, 2018 at 04:13:02PM +0800, Jia-Ju Bai wrote:
> armada370_init_sensor() is never called in atomic context.
> 
> armada370_init_sensor() is set as ".init_sensor" in 
> struct armada_thermal_data.
> ".init_sensor" is called armada_thermal_probe().
> armada_thermal_probe() is set as ".probe" in struct platform_driver.
> This function is not called in atomic context.
> 
> Despite never getting called from atomic context, armada370_init_sensor()
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
> index ae75328..807fe74 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -113,7 +113,7 @@ static void armada370_init_sensor(struct platform_device *pdev,
>  	reg &= ~PMU_TDC0_START_CAL_MASK;
>  	writel(reg, priv->control);
>  
> -	mdelay(10);
> +	usleep_range(10000, 11000);

Cool, but these have been already translated into msleep():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/armada_thermal.c#n141


>  }
>  
>  static void armada375_init_sensor(struct platform_device *pdev,
> -- 
> 1.9.1
> 
