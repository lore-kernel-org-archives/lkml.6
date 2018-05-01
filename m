Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbeEAKnL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 06:43:11 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44027 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753700AbeEAKnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 06:43:08 -0400
X-Google-Smtp-Source: AB8JxZobWakwu/IRRs7emYIUT9PmiG7mVj74QDNO8KRqe9nxBMFU3NwzjhfE6Md7ChGC8MhZMMycvg==
Date: Tue, 1 May 2018 12:43:04 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/18] thermal: exynos: check return values of
 ->get_trip_[temp,hyst] methods
Message-ID: <20180501104304.GL27619@mai>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180426115236epcas2p3764927b3c23113fb4c3771b753a51199@epcas2p3.samsung.com>
 <1524743493-28113-16-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524743493-28113-16-git-send-email-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 01:51:30PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Check return values of ->get_trip_[temp,hyst] methods in
> exynos_tmu_initialize().
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 244aaf6..abe0737 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -357,19 +357,23 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>  		/* Write temperature code for rising and falling threshold */
>  		for (i = 0; i < ntrips; i++) {
>  			/* Write temperature code for rising threshold */
> -			tzd->ops->get_trip_temp(tzd, i, &temp);
> +			ret = tzd->ops->get_trip_temp(tzd, i, &temp);
> +			if (ret)
> +				goto err;
>  			temp /= MCELSIUS;
>  			data->tmu_set_trip_temp(data, i, temp);
>  
>  			/* Write temperature code for falling threshold */
> -			tzd->ops->get_trip_hyst(tzd, i, &hyst);
> +			ret = tzd->ops->get_trip_hyst(tzd, i, &hyst);
> +			if (ret)
> +				goto err;

Could this fail for 4210 ?

>  			hyst /= MCELSIUS;
>  			data->tmu_set_trip_hyst(data, i, temp, hyst);
>  		}
>  
>  		data->tmu_clear_irqs(data);
>  	}
> -
> +err:
>  	clk_disable(data->clk);
>  	mutex_unlock(&data->lock);
>  	if (!IS_ERR(data->clk_sec))
> -- 
> 1.9.1
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
