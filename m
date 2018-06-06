Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D59E3607CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932222AbeFFGcb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:32:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:27357 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932097AbeFFGc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:32:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,482,1520924400";
   d="scan'208";a="47659677"
Subject: Re: [PATCH V2 2/4] mmc: sdhci-msm: Add msm version specific ops and
 data structures
To: Vijay Viswanath <vviswana@codeaurora.org>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, dianders@google.com,
        sayalil@codeaurora.org
References: <1527587561-27448-1-git-send-email-vviswana@codeaurora.org>
 <1527587561-27448-3-git-send-email-vviswana@codeaurora.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <e0157064-1dee-e3a6-e4a5-5d5f12d629e8@intel.com>
Date: Wed, 6 Jun 2018 09:31:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527587561-27448-3-git-send-email-vviswana@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/18 12:52, Vijay Viswanath wrote:
> In addition to offsets of certain registers changing, the registers in
> core_mem have been shifted to HC mem as well. To access these
> registers, define msm version specific functions. These functions can
> be loaded into the function pointers at the time of probe based on
> the msm version detected.
> 
> Also defind new data structure to hold version specific Ops and
> register addresses.
> 
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-msm.c | 77 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 4050c99..2a66aa0 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -226,6 +226,24 @@ struct sdhci_msm_offset {
>  	.core_ddr_config_2 = 0x1bc,
>  };
>  
> +struct sdhci_msm_variant_ops {
> +	u8 (*msm_readb_relaxed)(struct sdhci_host *host, u32 offset);
> +	u32 (*msm_readl_relaxed)(struct sdhci_host *host, u32 offset);
> +	void (*msm_writeb_relaxed)(u8 val, struct sdhci_host *host, u32 offset);
> +	void (*msm_writel_relaxed)(u32 val, struct sdhci_host *host,
> +			u32 offset);
> +};
> +
> +/*
> + * From V5, register spaces have changed. Wrap this info in a structure
> + * and choose the data_structure based on version info mentioned in DT.
> + */
> +struct sdhci_msm_variant_info {
> +	bool mci_removed;
> +	const struct sdhci_msm_variant_ops *var_ops;
> +	const struct sdhci_msm_offset *offset;
> +};
> +
>  struct sdhci_msm_host {
>  	struct platform_device *pdev;
>  	void __iomem *core_mem;	/* MSM SDCC mapped address */
> @@ -245,8 +263,45 @@ struct sdhci_msm_host {
>  	wait_queue_head_t pwr_irq_wait;
>  	bool pwr_irq_flag;
>  	u32 caps_0;
> +	bool mci_removed;
> +	const struct sdhci_msm_variant_ops *var_ops;
> +	const struct sdhci_msm_offset *offset;
>  };
>  
> +/*
> + * APIs to read/write to vendor specific registers which were there in the
> + * core_mem region before MCI was removed.
> + */
> +static u32 sdhci_msm_mci_variant_readl_relaxed(struct sdhci_host *host,
> +		u32 offset)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +
> +	return readl_relaxed(msm_host->core_mem + offset);
> +}
> +
> +static u32 sdhci_msm_v5_variant_readl_relaxed(struct sdhci_host *host,
> +		u32 offset)
> +{
> +	return readl_relaxed(host->ioaddr + offset);
> +}
> +
> +static void sdhci_msm_mci_variant_writel_relaxed(u32 val,
> +		struct sdhci_host *host, u32 offset)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +
> +	writel_relaxed(val, msm_host->core_mem + offset);
> +}
> +
> +static void sdhci_msm_v5_variant_writel_relaxed(u32 val,
> +		struct sdhci_host *host, u32 offset)
> +{
> +	writel_relaxed(val, host->ioaddr + offset);
> +}
> +
>  static unsigned int msm_get_clock_rate_for_bus_mode(struct sdhci_host *host,
>  						    unsigned int clock)
>  {
> @@ -1481,6 +1536,28 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
>  	pr_debug("%s: supported caps: 0x%08x\n", mmc_hostname(mmc), caps);
>  }
>  
> +static const struct sdhci_msm_variant_ops mci_var_ops = {
> +	.msm_readl_relaxed = sdhci_msm_mci_variant_readl_relaxed,
> +	.msm_writel_relaxed = sdhci_msm_mci_variant_writel_relaxed,
> +};
> +
> +static const struct sdhci_msm_variant_ops v5_var_ops = {
> +	.msm_readl_relaxed = sdhci_msm_v5_variant_readl_relaxed,
> +	.msm_writel_relaxed = sdhci_msm_v5_variant_writel_relaxed,
> +};
> +
> +static const struct sdhci_msm_variant_info sdhci_msm_mci_var = {
> +	.mci_removed = 0,
> +	.var_ops = &mci_var_ops,
> +	.offset = &sdhci_msm_mci_offset,
> +};
> +
> +static const struct sdhci_msm_variant_info sdhci_msm_v5_var = {
> +	.mci_removed = 1,
> +	.var_ops = &v5_var_ops,
> +	.offset = &sdhci_msm_v5_offset,
> +};
> +
>  static const struct of_device_id sdhci_msm_dt_match[] = {
>  	{ .compatible = "qcom,sdhci-msm-v4" },
>  	{},
> 
