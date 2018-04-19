Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751168AbeDSEQh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 00:16:37 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43949 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbeDSEQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 00:16:35 -0400
X-Google-Smtp-Source: AIpwx48tvhQFhIO2sjto7abvx5QZ0TXXkIZB0UAKA3/DGctu3xLGmhTa4yPLWegQC+19/1N2hFtrMg==
Date: Thu, 19 Apr 2018 09:46:32 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Markus Mayer <code@mmayer.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Power Management List <linux-pm@vger.kernel.org>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Markus Mayer <mmayer@broadcom.com>
Subject: Re: [PATCH 2/2] cpufreq: brcmstb-avs-cpufreq: prefer SCMI cpufreq if
 supported
Message-ID: <20180419041632.GF24576@vireshk-i7>
References: <20180418155643.36464-1-code@mmayer.net>
 <20180418155643.36464-3-code@mmayer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418155643.36464-3-code@mmayer.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-04-18, 08:56, Markus Mayer wrote:
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

What about adding !CONFIG_ARM_SCMI_PROTOCOL in Kconfig dependency and don't
compile the driver at all ?

-- 
viresh
