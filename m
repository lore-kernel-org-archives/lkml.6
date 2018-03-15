Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932308AbeCOOfY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:35:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:7686 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752524AbeCOOfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:35:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,311,1517904000";
   d="scan'208";a="211604661"
Subject: Re: [PATCH v3 11/11] mmc: sdhci-omap: Add sdhci_omap specific ops for
 enable_sdio_irq
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180307132020.30951-1-kishon@ti.com>
 <20180307132020.30951-12-kishon@ti.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <bac91c3b-9e67-0686-002f-a8547321504d@intel.com>
Date: Thu, 15 Mar 2018 16:34:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307132020.30951-12-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/18 15:20, Kishon Vijay Abraham I wrote:
> Add sdhci_omap_enable_sdio_irq to set CTPL and CLKEXTFREE bits in
> MMCHS_CON register required to detect asynchronous card interrupt
> on DAT[1].
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-omap.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 14dd51b51b41..8ceb3956b211 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -36,6 +36,7 @@
>  #define CON_DDR			BIT(19)
>  #define CON_CLKEXTFREE		BIT(16)
>  #define CON_PADEN		BIT(15)
> +#define CON_CTPL		BIT(11)
>  #define CON_INIT		BIT(1)
>  #define CON_OD			BIT(0)
>  
> @@ -226,6 +227,23 @@ static void sdhci_omap_conf_bus_power(struct sdhci_omap_host *omap_host,
>  	}
>  }
>  
> +static void sdhci_omap_enable_sdio_irq(struct mmc_host *mmc, int enable)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +	u32 reg;
> +
> +	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_CON);
> +	if (enable)
> +		reg |= (CON_CTPL | CON_CLKEXTFREE);
> +	else
> +		reg &= ~(CON_CTPL | CON_CLKEXTFREE);
> +	sdhci_omap_writel(omap_host, SDHCI_OMAP_CON, reg);
> +
> +	sdhci_enable_sdio_irq(mmc, enable);
> +}
> +
>  static inline void sdhci_omap_set_dll(struct sdhci_omap_host *omap_host,
>  				      int count)
>  {
> @@ -962,6 +980,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	host->mmc_host_ops.set_ios = sdhci_omap_set_ios;
>  	host->mmc_host_ops.card_busy = sdhci_omap_card_busy;
>  	host->mmc_host_ops.execute_tuning = sdhci_omap_execute_tuning;
> +	host->mmc_host_ops.enable_sdio_irq = sdhci_omap_enable_sdio_irq;
>  
>  	ret = sdhci_setup_host(host);
>  	if (ret)
> 
