Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752451AbeCOOSX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:18:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:16016 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752361AbeCOOSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:18:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,311,1517904000";
   d="scan'208";a="211600780"
Subject: Re: [PATCH v3 01/11] mmc: sdhci-omap: Fix when capabilities are
 obtained from SDHCI_CAPABILITIES reg
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180307132020.30951-1-kishon@ti.com>
 <20180307132020.30951-2-kishon@ti.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <e9ac3f68-2d75-6648-7774-786c20f6746c@intel.com>
Date: Thu, 15 Mar 2018 16:17:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307132020.30951-2-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/18 15:20, Kishon Vijay Abraham I wrote:
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
> ---
>  drivers/mmc/host/sdhci-omap.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 1456abd5eeb9..3cce30584d2f 100644
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
> @@ -930,7 +926,15 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	sdhci_read_caps(host);
>  	host->caps |= SDHCI_CAN_DO_ADMA2;
>  
> -	ret = sdhci_add_host(host);
> +	ret = sdhci_setup_host(host);
> +	if (ret)
> +		goto err_put_sync;
> +
> +	ret = sdhci_omap_config_iodelay_pinctrl_state(omap_host);
> +	if (ret)
> +		goto err_put_sync;
> +
> +	ret = __sdhci_add_host(host);
>  	if (ret)
>  		goto err_put_sync;

if __sdhci_add_host() fails, then sdhci_cleanup_host() needs to be called to
free resources allocated by sdhci_setup_host().
