Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbeDSKgG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:36:06 -0400
Received: from foss.arm.com ([217.140.101.70]:35446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751151AbeDSKgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:36:04 -0400
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Markus Mayer <mmayer@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] cpufreq: brcmstb-avs-cpufreq: prefer SCMI cpufreq if
 supported
To: Markus Mayer <code@mmayer.net>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <20180418155643.36464-1-code@mmayer.net>
 <20180418155643.36464-3-code@mmayer.net>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <0f011724-85fe-d411-b99d-dfd33e206052@arm.com>
Date: Thu, 19 Apr 2018 11:35:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418155643.36464-3-code@mmayer.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/04/18 16:56, Markus Mayer wrote:
> From: Jim Quinlan <jim2101024@gmail.com>
> 
> If the SCMI cpufreq driver is supported, we bail, so that the new
> approach can be used.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> index b07559b9ed99..b4861a730162 100644
> --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> @@ -164,6 +164,8 @@
>  #define BRCM_AVS_CPU_INTR	"brcm,avs-cpu-l2-intr"
>  #define BRCM_AVS_HOST_INTR	"sw_intr"
>  
> +#define ARM_SCMI_COMPAT		"arm,scmi"
> +
>  struct pmap {
>  	unsigned int mode;
>  	unsigned int p1;
> @@ -511,6 +513,20 @@ static int brcm_avs_prepare_init(struct platform_device *pdev)
>  	struct device *dev;
>  	int host_irq, ret;
>  

Will this platform have both SCMI and BRCM_AVS_CPU_DATA nodes enabled ?
If so, is it not better to just keep only the preferred node enabled
instead ?

> +	/*
> +	 * If the SCMI cpufreq driver is supported, we bail, so that the more
> +	 * modern approach can be used.
> +	 */
> +	if (IS_ENABLED(CONFIG_ARM_SCMI_PROTOCOL)) {
> +		struct device_node *np;
> +
> +		np = of_find_compatible_node(NULL, NULL, ARM_SCMI_COMPAT);
> +		if (np) {
> +			of_node_put(np);
> +			return -ENXIO;
> +		}
> +	}
> +

Clearly not a good approach.

-- 
Regards,
Sudeep
