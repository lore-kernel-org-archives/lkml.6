Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755332AbeDPMRC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:17:02 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44103 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbeDPMRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:17:00 -0400
X-Google-Smtp-Source: AIpwx4+PVCKAQX/NQjmUzKG49D4rop4eiqSA8rJFMemRTnY9tthgm9nN3HA7qWeghfNO4t7yjQVZVA==
Subject: Re: [PATCH 02/14] thermal: exynos: Propagate error value from
 tmu_read()
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180416101350epcas1p46d9415458ec463afb2a071a9f765f0ed@epcas1p4.samsung.com>
 <1523873525-23718-3-git-send-email-b.zolnierkie@samsung.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <39e461aa-2a60-f3cf-d116-fc7e97f9da2e@linaro.org>
Date: Mon, 16 Apr 2018 14:16:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523873525-23718-3-git-send-email-b.zolnierkie@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2018 12:11, Bartlomiej Zolnierkiewicz wrote:
> From: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> tmu_read() in case of Exynos4210 might return error for out of bound
> values. Current code ignores such value, what leads to reporting critical
> temperature value. Add proper error code propagation to exynos_get_temp()
> function.

For me the comment in the function exynos4210_tmu_read

/* "temp_code" should range between 75 and 175 */

... is strange. I would double check this assertion before dealing with
the error value.

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> CC: stable@vger.kernel.org # v4.6+
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 986cbd0..ac83f72 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -892,6 +892,7 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
>  static int exynos_get_temp(void *p, int *temp)
>  {
>  	struct exynos_tmu_data *data = p;
> +	int value, ret = 0;
>  
>  	if (!data || !data->tmu_read || !data->enabled)
>  		return -EINVAL;
> @@ -899,12 +900,16 @@ static int exynos_get_temp(void *p, int *temp)
>  	mutex_lock(&data->lock);
>  	clk_enable(data->clk);
>  
> -	*temp = code_to_temp(data, data->tmu_read(data)) * MCELSIUS;
> +	value = data->tmu_read(data);
> +	if (value < 0)
> +		ret = value;
> +	else
> +		*temp = code_to_temp(data, value) * MCELSIUS;
>  
>  	clk_disable(data->clk);
>  	mutex_unlock(&data->lock);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  #ifdef CONFIG_THERMAL_EMULATION
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
