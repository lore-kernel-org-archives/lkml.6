Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754213AbeDZH6l (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:58:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:25968 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753067AbeDZH6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:58:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,330,1520924400";
   d="scan'208";a="194516774"
Subject: Re: [PATCH v4 01/12] mmc: sdhci-omap: Fix when capabilities are
 obtained from SDHCI_CAPABILITIES reg
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>
References: <20180425120937.29867-1-kishon@ti.com>
 <20180425120937.29867-2-kishon@ti.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <e083256d-96f8-3f1e-76d1-8062dcfd1a21@intel.com>
Date: Thu, 26 Apr 2018 10:57:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425120937.29867-2-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/18 15:09, Kishon Vijay Abraham I wrote:
> sdhci_omap_config_iodelay_pinctrl_state() requires caps and caps2 to be
> initialized (speed mode capabilities like UHS/HS200) before it is
> invoked. While mmc_of_parse() initializes caps/caps2 if capabilities is
> populated in device tree, it will remain uninitialized for capabilities
> obtained from SDHCI_CAPABILITIES register.
> Fix sdhci_omap_config_iodelay_pinctrl_state() to be used even while
> getting the capabilities from SDHCI_CAPABILITIES register by invoking
> sdhci_setup_host() before sdhci_omap_config_iodelay_pinctrl_state().
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-omap.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 1456abd5eeb9..9bb53702e0e5 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -916,10 +916,6 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  		goto err_put_sync;
>  	}
>  
> -	ret = sdhci_omap_config_iodelay_pinctrl_state(omap_host);
> -	if (ret)
> -		goto err_put_sync;
> -
>  	host->mmc_host_ops.get_ro = mmc_gpio_get_ro;
>  	host->mmc_host_ops.start_signal_voltage_switch =
>  					sdhci_omap_start_signal_voltage_switch;
> @@ -930,12 +926,23 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	sdhci_read_caps(host);
>  	host->caps |= SDHCI_CAN_DO_ADMA2;
>  
> -	ret = sdhci_add_host(host);
> +	ret = sdhci_setup_host(host);
>  	if (ret)
>  		goto err_put_sync;
>  
> +	ret = sdhci_omap_config_iodelay_pinctrl_state(omap_host);
> +	if (ret)
> +		goto err_cleanup_host;
> +
> +	ret = __sdhci_add_host(host);
> +	if (ret)
> +		goto err_cleanup_host;
> +
>  	return 0;
>  
> +err_cleanup_host:
> +	sdhci_cleanup_host(host);
> +
>  err_put_sync:
>  	pm_runtime_put_sync(dev);
>  
> 
