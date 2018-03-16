Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeCPEfk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 00:35:40 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34389 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbeCPEfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 00:35:38 -0400
X-Google-Smtp-Source: AG47ELvI0aYUBoOWDYHnXhDulJqM5RyGPEuyn8jzMMSmalt6Cdean4EyW7VlohV0vVeyNHV/knhWlg==
Date: Fri, 16 Mar 2018 10:05:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: sboyd@kernel.org, andy.gross@linaro.org, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] soc: qcom: rpmpd: Add support for get/set
 performance state
Message-ID: <20180316043535.GQ15832@vireshk-i7>
References: <20180316040824.21472-1-rnayak@codeaurora.org>
 <20180316040824.21472-5-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316040824.21472-5-rnayak@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-03-18, 09:38, Rajendra Nayak wrote:
> With genpd now expecting powerdomain drivers supporting performance
> state to support get/set performance state callbacks, add support for it
> in the rpmpd driver.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/soc/qcom/rpmpd.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
> index c8754d867c33..4058c5b450c6 100644
> --- a/drivers/soc/qcom/rpmpd.c
> +++ b/drivers/soc/qcom/rpmpd.c
> @@ -14,6 +14,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
>  #include <linux/soc/qcom/smd-rpm.h>
>  
>  #include <dt-bindings/mfd/qcom-rpm.h>
> @@ -29,6 +30,8 @@
>  #define KEY_ENABLE		0x6e657773 /* swen */
>  #define KEY_FLOOR_CORNER	0x636676   /* vfc */
>  
> +#define MAX_RPMPD_STATE		6
> +
>  #define DEFINE_RPMPD_CORN_SMPA(_platform, _name, _active, r_id)		\
>  	static struct rpmpd _platform##_##_active;			\
>  	static struct rpmpd _platform##_##_name = {			\
> @@ -222,6 +225,43 @@ static int rpmpd_power_off(struct generic_pm_domain *domain)
>  	return ret;
>  }
>  
> +static int rpmpd_set_performance(struct generic_pm_domain *domain,
> +			     unsigned int state)
> +{
> +	int ret = 0;
> +	struct rpmpd *pd = domain_to_rpmpd(domain);
> +
> +	mutex_lock(&rpmpd_lock);
> +
> +	if (state > MAX_RPMPD_STATE)
> +		goto out;
> +
> +	pd->corner = state;
> +
> +	if (!pd->enabled && (pd->key != KEY_FLOOR_CORNER))
> +		goto out;
> +
> +	ret = rpmpd_aggregate_corner(pd);
> +
> +out:
> +	mutex_unlock(&rpmpd_lock);
> +
> +	return ret;
> +}
> +
> +static unsigned int rpmpd_get_performance(struct generic_pm_domain *genpd,
> +					  struct dev_pm_opp *opp)
> +{
> +	struct device_node *np;
> +	unsigned int corner = 0;
> +
> +	np = dev_pm_opp_get_of_node(opp);
> +	of_property_read_u32(np, "qcom,level", &corner);

Don't we want to error out or do something else in case of an error ?

> +	of_node_put(np);
> +
> +	return corner;
> +}
> +
>  static int rpmpd_probe(struct platform_device *pdev)
>  {
>  	int i;
> @@ -259,6 +299,8 @@ static int rpmpd_probe(struct platform_device *pdev)
>  		rpmpds[i]->rpm = rpm;
>  		rpmpds[i]->pd.power_off = rpmpd_power_off;
>  		rpmpds[i]->pd.power_on = rpmpd_power_on;
> +		rpmpds[i]->pd.set_performance_state = rpmpd_set_performance;
> +		rpmpds[i]->pd.get_performance_state = rpmpd_get_performance;
>  		pm_genpd_init(&rpmpds[i]->pd, NULL, true);
>  
>  		data->domains[i] = &rpmpds[i]->pd;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
