Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752508AbeENIh3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:37:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35183 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752476AbeENIhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:37:25 -0400
Subject: Re: [PATCH 1/3] thermal: imx: remove cpufreq cooling registration
To: Anson Huang <Anson.Huang@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, rui.zhang@intel.com, edubezval@gmail.com
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1526285359-17978-1-git-send-email-Anson.Huang@nxp.com>
From: Bastian Stender <bst@pengutronix.de>
Message-ID: <5a449fc0-4d3e-c7c7-0e9a-43efb4b909cf@pengutronix.de>
Date: Mon, 14 May 2018 10:37:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526285359-17978-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:7c06:bf8a:7e39:c388
X-SA-Exim-Mail-From: bst@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/14/2018 10:09 AM, Anson Huang wrote:
> This patch removes cpufreq cooling registration in
> thermal .probe function, cpufreq cooling should be
> done in cpufreq driver when it is ready.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

It seems you are trying to achieve something similar to a patch I sent a
couple of month ago. Unfortunately I did not have the time to rework it yet:

   https://patchwork.kernel.org/patch/10059085/

Some of the comments might apply here too.

Regards,
Bastian

> ---
>   drivers/thermal/imx_thermal.c | 16 ----------------
>   1 file changed, 16 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index c30dc21..8eedb97 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -9,7 +9,6 @@
>   
>   #include <linux/clk.h>
>   #include <linux/cpufreq.h>
> -#include <linux/cpu_cooling.h>
>   #include <linux/delay.h>
>   #include <linux/device.h>
>   #include <linux/init.h>
> @@ -207,7 +206,6 @@ static struct thermal_soc_data thermal_imx7d_data = {
>   struct imx_thermal_data {
>   	struct cpufreq_policy *policy;
>   	struct thermal_zone_device *tz;
> -	struct thermal_cooling_device *cdev;
>   	enum thermal_device_mode mode;
>   	struct regmap *tempmon;
>   	u32 c1, c2; /* See formula in imx_init_calib() */
> @@ -729,22 +727,12 @@ static int imx_thermal_probe(struct platform_device *pdev)
>   		return -EPROBE_DEFER;
>   	}
>   
> -	data->cdev = cpufreq_cooling_register(data->policy);
> -	if (IS_ERR(data->cdev)) {
> -		ret = PTR_ERR(data->cdev);
> -		dev_err(&pdev->dev,
> -			"failed to register cpufreq cooling device: %d\n", ret);
> -		cpufreq_cpu_put(data->policy);
> -		return ret;
> -	}
> -
>   	data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
>   	if (IS_ERR(data->thermal_clk)) {
>   		ret = PTR_ERR(data->thermal_clk);
>   		if (ret != -EPROBE_DEFER)
>   			dev_err(&pdev->dev,
>   				"failed to get thermal clk: %d\n", ret);
> -		cpufreq_cooling_unregister(data->cdev);
>   		cpufreq_cpu_put(data->policy);
>   		return ret;
>   	}
> @@ -759,7 +747,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
>   	ret = clk_prepare_enable(data->thermal_clk);
>   	if (ret) {
>   		dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
> -		cpufreq_cooling_unregister(data->cdev);
>   		cpufreq_cpu_put(data->policy);
>   		return ret;
>   	}
> @@ -775,7 +762,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev,
>   			"failed to register thermal zone device %d\n", ret);
>   		clk_disable_unprepare(data->thermal_clk);
> -		cpufreq_cooling_unregister(data->cdev);
>   		cpufreq_cpu_put(data->policy);
>   		return ret;
>   	}
> @@ -811,7 +797,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
>   		clk_disable_unprepare(data->thermal_clk);
>   		thermal_zone_device_unregister(data->tz);
> -		cpufreq_cooling_unregister(data->cdev);
>   		cpufreq_cpu_put(data->policy);
>   		return ret;
>   	}
> @@ -831,7 +816,6 @@ static int imx_thermal_remove(struct platform_device *pdev)
>   		clk_disable_unprepare(data->thermal_clk);
>   
>   	thermal_zone_device_unregister(data->tz);
> -	cpufreq_cooling_unregister(data->cdev);
>   	cpufreq_cpu_put(data->policy);
>   
>   	return 0;
> 

-- 
Pengutronix e.K.
Industrial Linux Solutions
http://www.pengutronix.de/
Peiner Str. 6-8, 31137 Hildesheim, Germany
Amtsgericht Hildesheim, HRA 2686
