Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeFEJhH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:37:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:57779 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751502AbeFEJhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:37:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,478,1520924400";
   d="scan'208";a="54857045"
Subject: Re: [PATCH] mmc: tegra: Use sdhci_pltfm_clk_get_max_clock
To: Aapo Vienamo <avienamo@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <1528126540-27004-1-git-send-email-avienamo@nvidia.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0c9cb398-07ac-360b-c661-31670f64fe06@intel.com>
Date: Tue, 5 Jun 2018 12:35:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1528126540-27004-1-git-send-email-avienamo@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/18 18:35, Aapo Vienamo wrote:
> The sdhci get_max_clock callback is set to sdhci_pltfm_clk_get_max_clock
> and tegra_sdhci_get_max_clock is removed. It appears that the
> shdci-tegra specific callback was originally introduced due to the
> requirement that the host clock has to be twice the bus clock on DDR50
> mode. As far as I can tell the only effect the removal has on DDR50 mode
> is in cases where the parent clock is unable to supply the requested
> clock rate, causing the DDR50 mode to run at a lower frequency.
> Currently the DDR50 mode isn't enabled on any of the SoCs and would also
> require configuring the SDHCI clock divider register to function
> properly.
> 
> The problem with tegra_sdhci_get_max_clock is that it divides the clock
> rate by two and thus artificially limits the maximum frequency of faster
> signaling modes which don't have the host-bus frequency ratio requirement
> of DDR50 such as SDR104 and HS200. Furthermore, the call to
> clk_round_rate() may return an error which isn't handled by
> tegra_sdhci_get_max_clock.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 970d38f6..c8745b5 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -234,17 +234,6 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
>  	sdhci_set_uhs_signaling(host, timing);
>  }
>  
> -static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
> -{
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -
> -	/*
> -	 * DDR modes require the host to run at double the card frequency, so
> -	 * the maximum rate we can support is half of the module input clock.
> -	 */
> -	return clk_round_rate(pltfm_host->clk, UINT_MAX) / 2;
> -}
> -
>  static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned int tap)
>  {
>  	u32 reg;
> @@ -309,7 +298,7 @@ static const struct sdhci_ops tegra_sdhci_ops = {
>  	.platform_execute_tuning = tegra_sdhci_execute_tuning,
>  	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
>  	.voltage_switch = tegra_sdhci_voltage_switch,
> -	.get_max_clock = tegra_sdhci_get_max_clock,
> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_tegra20_pdata = {
> @@ -357,7 +346,7 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
>  	.platform_execute_tuning = tegra_sdhci_execute_tuning,
>  	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
>  	.voltage_switch = tegra_sdhci_voltage_switch,
> -	.get_max_clock = tegra_sdhci_get_max_clock,
> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
> 
