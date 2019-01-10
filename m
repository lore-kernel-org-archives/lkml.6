Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB11C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7FE214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfAJNTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:19:10 -0500
Received: from mga05.intel.com ([192.55.52.43]:60529 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728746AbfAJNTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:19:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 05:19:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,461,1539673200"; 
   d="scan'208";a="133376908"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jan 2019 05:19:07 -0800
Subject: Re: [PATCH V7 2/2] mmc: tegra: HW Command Queue Support for Tegra
 SDMMC
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        ulf.hansson@linaro.org, Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <1546457808-18270-1-git-send-email-skomatineni@nvidia.com>
 <1546457808-18270-3-git-send-email-skomatineni@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <5722018a-7654-c6f9-c2aa-2817b39b1a35@intel.com>
Date:   Thu, 10 Jan 2019 15:17:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1546457808-18270-3-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Chunyan Zhang the contributor of sdhci-sprd which is the only other v4
mode user at present

On 2/01/19 9:36 PM, Sowjanya Komatineni wrote:
> This patch adds HW Command Queue for supported Tegra SDMMC
> controllers.
> 
> As per SD Host 4.20 Spec for Host Control 1 Register, DMA Select
> options supported are
> 
> With Host Version 4 Enable = 0,
> b'00:SDMA, b'10:32-bit ADMA2, b'11:64-bit ADMA2
> 
> With Host Version 4 Enable = 1,
> b'00:SDMA, b'10:ADMA2, b'11:ADMA3
> Support for 32-bit or 64-bit system addressing of DMAs is selected
> thru 64-bit Addressing in Host Control 2 register.
> 
> ADMA3 performs integrated descriptor and each command descriptor
> is followed by ADMA2 descriptor. Command queuing need to fetch
> command and transfer descriptors so need ADMA3 DMA Type.
> 
> Tegra SDMMC Host design prevents write access to BLOCK_COUNT
> registers when CQE is enabled to prevent SW from updating block
> size during Command Queue mode so need tegra specific sdhci
> cqe callback.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/Kconfig       |   1 +
>  drivers/mmc/host/sdhci-tegra.c | 107 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci.c       |  16 ++++--
>  drivers/mmc/host/sdhci.h       |   1 +
>  4 files changed, 120 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 1b58739d9744..5aa2de2c7609 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -250,6 +250,7 @@ config MMC_SDHCI_TEGRA
>  	depends on ARCH_TEGRA
>  	depends on MMC_SDHCI_PLTFM
>  	select MMC_SDHCI_IO_ACCESSORS
> +	select MMC_CQHCI
>  	help
>  	  This selects the Tegra SD/MMC controller. If you have a Tegra
>  	  platform with SD or MMC devices, say Y or M here.
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 7b95d088fdef..7beecd1da94a 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -33,6 +33,7 @@
>  #include <linux/ktime.h>
>  
>  #include "sdhci-pltfm.h"
> +#include "cqhci.h"
>  
>  /* Tegra SDHOST controller vendor register definitions */
>  #define SDHCI_TEGRA_VENDOR_CLOCK_CTRL			0x100
> @@ -89,6 +90,9 @@
>  #define NVQUIRK_NEEDS_PAD_CONTROL			BIT(7)
>  #define NVQUIRK_DIS_CARD_CLK_CONFIG_TAP			BIT(8)
>  
> +/* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
> +#define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
> +
>  struct sdhci_tegra_soc_data {
>  	const struct sdhci_pltfm_data *pdata;
>  	u32 nvquirks;
> @@ -128,6 +132,7 @@ struct sdhci_tegra {
>  	u32 default_tap;
>  	u32 default_trim;
>  	u32 dqs_trim;
> +	bool enable_hwcq;
>  };
>  
>  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> @@ -836,6 +841,49 @@ static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
>  		tegra_host->pad_calib_required = true;
>  }
>  
> +static void sdhci_tegra_cqe_enable(struct mmc_host *mmc)
> +{
> +	struct cqhci_host *cq_host = mmc->cqe_private;
> +	u32 cqcfg = 0;
> +
> +	/* Tegra SDMMC Controller design prevents write access to BLOCK_COUNT
> +	 * registers when CQE is enabled.
> +	 */
> +	cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
> +	if (cqcfg & CQHCI_ENABLE)
> +		cqhci_writel(cq_host, (cqcfg & ~CQHCI_ENABLE), CQHCI_CFG);
> +
> +	sdhci_cqe_enable(mmc);
> +
> +	if (cqcfg & CQHCI_ENABLE)
> +		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
> +
> +}
> +
> +static void sdhci_tegra_dumpregs(struct mmc_host *mmc)
> +{
> +	sdhci_dumpregs(mmc_priv(mmc));
> +}
> +
> +static u32 sdhci_tegra_cqhci_irq(struct sdhci_host *host, u32 intmask)
> +{
> +	int cmd_error = 0;
> +	int data_error = 0;
> +
> +	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
> +		return intmask;
> +
> +	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> +
> +	return 0;
> +}
> +
> +static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
> +	.enable	= sdhci_tegra_cqe_enable,
> +	.disable = sdhci_cqe_disable,
> +	.dumpregs = sdhci_tegra_dumpregs,
> +};
> +
>  static const struct sdhci_ops tegra_sdhci_ops = {
>  	.get_ro     = tegra_sdhci_get_ro,
>  	.read_w     = tegra_sdhci_readw,
> @@ -989,6 +1037,7 @@ static const struct sdhci_ops tegra186_sdhci_ops = {
>  	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
>  	.voltage_switch = tegra_sdhci_voltage_switch,
>  	.get_max_clock = tegra_sdhci_get_max_clock,
> +	.irq = sdhci_tegra_cqhci_irq,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
> @@ -1030,6 +1079,55 @@ static const struct of_device_id sdhci_tegra_dt_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_tegra_dt_match);
>  
> +static int sdhci_tegra_add_host(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> +	struct cqhci_host *cq_host;
> +	bool dma64;
> +	int ret;
> +
> +	if (!tegra_host->enable_hwcq)
> +		return sdhci_add_host(host);
> +
> +	host->v4_mode = true;

Can you use sdhci_enable_v4_mode() here?

> +
> +	ret = sdhci_setup_host(host);
> +	if (ret)
> +		return ret;
> +
> +	host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
> +
> +	cq_host = devm_kzalloc(host->mmc->parent,
> +				sizeof(*cq_host), GFP_KERNEL);
> +	if (!cq_host) {
> +		ret = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	cq_host->mmio = host->ioaddr + SDHCI_TEGRA_CQE_BASE_ADDR;
> +	cq_host->ops = &sdhci_tegra_cqhci_ops;
> +
> +	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
> +	if (dma64)
> +		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> +
> +	ret = cqhci_init(cq_host, host->mmc, dma64);
> +	if (ret)
> +		goto cleanup;
> +
> +	ret = __sdhci_add_host(host);
> +	if (ret)
> +		goto cleanup;
> +
> +	return 0;
> +
> +cleanup:
> +	sdhci_cleanup_host(host);
> +	return ret;
> +
> +}
> +
>  static int sdhci_tegra_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *match;
> @@ -1039,6 +1137,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  	struct sdhci_tegra *tegra_host;
>  	struct clk *clk;
>  	int rc;
> +	struct resource *iomem;
>  
>  	match = of_match_device(sdhci_tegra_dt_match, &pdev->dev);
>  	if (!match)
> @@ -1056,6 +1155,12 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  	tegra_host->pad_control_available = false;
>  	tegra_host->soc_data = soc_data;
>  
> +	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (resource_size(iomem) > SDHCI_TEGRA_CQE_BASE_ADDR)
> +		tegra_host->enable_hwcq = true;
> +	else
> +		tegra_host->enable_hwcq = false;
> +
>  	if (soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL) {
>  		rc = tegra_sdhci_init_pinctrl_info(&pdev->dev, tegra_host);
>  		if (rc == 0)
> @@ -1117,7 +1222,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  
>  	usleep_range(2000, 4000);
>  
> -	rc = sdhci_add_host(host);
> +	rc = sdhci_tegra_add_host(host);
>  	if (rc)
>  		goto err_add_host;
>  
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index fde984d10619..c368230c364d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3308,10 +3308,18 @@ void sdhci_cqe_enable(struct mmc_host *mmc)
>  
>  	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>  	ctrl &= ~SDHCI_CTRL_DMA_MASK;
> -	if (host->flags & SDHCI_USE_64_BIT_DMA)
> -		ctrl |= SDHCI_CTRL_ADMA64;
> -	else
> -		ctrl |= SDHCI_CTRL_ADMA32;
> +	/* As per SD Host 4.20 Spec, Host with V4 Mode enable supports ADMA3
> +	 * DMA type. ADMA3 performs integrated descriptor which is needed for
> +	 * cmd queuing as it need to fetch both cmd and transfer descriptors.
> +	 */

ADMA3 support is optional so we still need to check the capabilities bit 59.

Also, it doesn't seem unreasonable to assume that ADMA3 capable devices use
ADMA3 for CQE but that is not part of the standard specifications, so we
should be clear to state that is an assumption that we are making, not
something derived from the specification.

> +	if (host->v4_mode) {
> +		ctrl |= SDHCI_CTRL_ADMA3;
> +	} else {
> +		if (host->flags & SDHCI_USE_64_BIT_DMA)
> +			ctrl |= SDHCI_CTRL_ADMA64;
> +		else
> +			ctrl |= SDHCI_CTRL_ADMA32;
> +	}

Prefer not to nest the 2nd if-clause in a block i.e. it can be like this:

	if ()
	else if ()
	else

>  	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>  
>  	sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, 512),
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index b001cf4d3d7e..6e2a08f92645 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -88,6 +88,7 @@
>  #define   SDHCI_CTRL_ADMA1	0x08
>  #define   SDHCI_CTRL_ADMA32	0x10
>  #define   SDHCI_CTRL_ADMA64	0x18
> +#define   SDHCI_CTRL_ADMA3	0x18
>  #define   SDHCI_CTRL_8BITBUS	0x20
>  #define  SDHCI_CTRL_CDTEST_INS	0x40
>  #define  SDHCI_CTRL_CDTEST_EN	0x80
> 

