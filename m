Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07144C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9386820671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9386820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbeG0HmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 03:42:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:31024 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbeG0HmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 03:42:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2018 23:21:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,408,1526367600"; 
   d="scan'208";a="59898591"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by orsmga007.jf.intel.com with ESMTP; 26 Jul 2018 23:21:53 -0700
Subject: Re: [PATCH] mmc: host: iproc: Add ACPI support to IPROC SDHCI
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1531845907-26213-1-git-send-email-srinath.mannam@broadcom.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b8bc96ee-e035-7a51-499f-b16dc3c7edd0@intel.com>
Date:   Fri, 27 Jul 2018 09:20:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <1531845907-26213-1-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/18 19:45, Srinath Mannam wrote:
> Add ACPI support to all IPROC SDHCI varients
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
> ---
>  drivers/mmc/host/Kconfig       |   1 +
>  drivers/mmc/host/sdhci-iproc.c | 187 ++++++++++++++++++++++++++++-------------
>  2 files changed, 128 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 0581c19..bc6702e 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -334,6 +334,7 @@ config MMC_SDHCI_IPROC
>  	tristate "SDHCI support for the BCM2835 & iProc SD/MMC Controller"
>  	depends on ARCH_BCM2835 || ARCH_BCM_IPROC || COMPILE_TEST
>  	depends on MMC_SDHCI_PLTFM
> +	depends on OF || ACPI
>  	default ARCH_BCM_IPROC
>  	select MMC_SDHCI_IO_ACCESSORS
>  	help
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index d0e83db..7c5c923 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -15,6 +15,7 @@
>   * iProc SDHCI platform driver
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/mmc/host.h>
> @@ -162,9 +163,19 @@ static void sdhci_iproc_writeb(struct sdhci_host *host, u8 val, int reg)
>  	sdhci_iproc_writel(host, newval, reg & ~3);
>  }
>  
> +static unsigned int sdhci_iproc_get_max_clock(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +	if (pltfm_host->clk)
> +		return sdhci_pltfm_clk_get_max_clock(host);
> +	else
> +		return pltfm_host->clock;
> +}
> +
>  static const struct sdhci_ops sdhci_iproc_ops = {
>  	.set_clock = sdhci_set_clock,
> -	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +	.get_max_clock = sdhci_iproc_get_max_clock,
>  	.set_bus_width = sdhci_set_bus_width,
>  	.reset = sdhci_reset,
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
> @@ -178,34 +189,24 @@ static const struct sdhci_ops sdhci_iproc_32only_ops = {
>  	.write_w = sdhci_iproc_writew,
>  	.write_b = sdhci_iproc_writeb,
>  	.set_clock = sdhci_set_clock,
> -	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +	.get_max_clock = sdhci_iproc_get_max_clock,
>  	.set_bus_width = sdhci_set_bus_width,
>  	.reset = sdhci_reset,
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
>  };
>  
> +enum sdhci_pltfm_type {
> +	SDHCI_PLTFM_IPROC_CYGNUS,
> +	SDHCI_PLTFM_IPROC,
> +	SDHCI_PLTFM_BCM2835,
> +};
> +
>  static const struct sdhci_pltfm_data sdhci_iproc_cygnus_pltfm_data = {
>  	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
>  	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN | SDHCI_QUIRK2_HOST_OFF_CARD_ON,
>  	.ops = &sdhci_iproc_32only_ops,
>  };
>  
> -static const struct sdhci_iproc_data iproc_cygnus_data = {
> -	.pdata = &sdhci_iproc_cygnus_pltfm_data,
> -	.caps = ((0x1 << SDHCI_MAX_BLOCK_SHIFT)
> -			& SDHCI_MAX_BLOCK_MASK) |
> -		SDHCI_CAN_VDD_330 |
> -		SDHCI_CAN_VDD_180 |
> -		SDHCI_CAN_DO_SUSPEND |
> -		SDHCI_CAN_DO_HISPD |
> -		SDHCI_CAN_DO_ADMA2 |
> -		SDHCI_CAN_DO_SDMA,
> -	.caps1 = SDHCI_DRIVER_TYPE_C |
> -		 SDHCI_DRIVER_TYPE_D |
> -		 SDHCI_SUPPORT_DDR50,
> -	.mmc_caps = MMC_CAP_1_8V_DDR,
> -};
> -
>  static const struct sdhci_pltfm_data sdhci_iproc_pltfm_data = {
>  	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
>  		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> @@ -213,21 +214,6 @@ static const struct sdhci_pltfm_data sdhci_iproc_pltfm_data = {
>  	.ops = &sdhci_iproc_ops,
>  };
>  
> -static const struct sdhci_iproc_data iproc_data = {
> -	.pdata = &sdhci_iproc_pltfm_data,
> -	.caps = ((0x1 << SDHCI_MAX_BLOCK_SHIFT)
> -			& SDHCI_MAX_BLOCK_MASK) |
> -		SDHCI_CAN_VDD_330 |
> -		SDHCI_CAN_VDD_180 |
> -		SDHCI_CAN_DO_SUSPEND |
> -		SDHCI_CAN_DO_HISPD |
> -		SDHCI_CAN_DO_ADMA2 |
> -		SDHCI_CAN_DO_SDMA,
> -	.caps1 = SDHCI_DRIVER_TYPE_C |
> -		 SDHCI_DRIVER_TYPE_D |
> -		 SDHCI_SUPPORT_DDR50,
> -};
> -
>  static const struct sdhci_pltfm_data sdhci_bcm2835_pltfm_data = {
>  	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
>  		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> @@ -237,38 +223,104 @@ static const struct sdhci_pltfm_data sdhci_bcm2835_pltfm_data = {
>  	.ops = &sdhci_iproc_32only_ops,
>  };
>  
> -static const struct sdhci_iproc_data bcm2835_data = {
> -	.pdata = &sdhci_bcm2835_pltfm_data,
> -	.caps = ((0x1 << SDHCI_MAX_BLOCK_SHIFT)
> -			& SDHCI_MAX_BLOCK_MASK) |
> -		SDHCI_CAN_VDD_330 |
> -		SDHCI_CAN_DO_HISPD,
> -	.caps1 = SDHCI_DRIVER_TYPE_A |
> -		 SDHCI_DRIVER_TYPE_C,
> -	.mmc_caps = 0x00000000,
> +static const struct sdhci_iproc_data sdhci_iproc_data_list[] = {

Why change to an array?  Also would need to be a separate patch.

> +	[SDHCI_PLTFM_IPROC_CYGNUS] = {
> +		/* SDHCI IPROC CYGNUS */
> +		.pdata = &sdhci_iproc_cygnus_pltfm_data,
> +		.caps = ((0x1 << SDHCI_MAX_BLOCK_SHIFT)
> +				& SDHCI_MAX_BLOCK_MASK) |
> +			SDHCI_CAN_VDD_330 |
> +			SDHCI_CAN_VDD_180 |
> +			SDHCI_CAN_DO_SUSPEND |
> +			SDHCI_CAN_DO_HISPD |
> +			SDHCI_CAN_DO_ADMA2 |
> +			SDHCI_CAN_DO_SDMA,
> +		.caps1 = SDHCI_DRIVER_TYPE_C |
> +			SDHCI_DRIVER_TYPE_D |
> +			SDHCI_SUPPORT_DDR50,
> +		.mmc_caps = MMC_CAP_1_8V_DDR,
> +	},
> +	[SDHCI_PLTFM_IPROC] = {
> +		/* SDHCI IPROC */
> +		.pdata = &sdhci_iproc_pltfm_data,
> +		.caps = ((0x1 << SDHCI_MAX_BLOCK_SHIFT)
> +				& SDHCI_MAX_BLOCK_MASK) |
> +			SDHCI_CAN_VDD_330 |
> +			SDHCI_CAN_VDD_180 |
> +			SDHCI_CAN_DO_SUSPEND |
> +			SDHCI_CAN_DO_HISPD |
> +			SDHCI_CAN_DO_ADMA2 |
> +			SDHCI_CAN_DO_SDMA,
> +		.caps1 = SDHCI_DRIVER_TYPE_C |
> +			SDHCI_DRIVER_TYPE_D |
> +			SDHCI_SUPPORT_DDR50,
> +	},
> +	[SDHCI_PLTFM_BCM2835] = {
> +		/* SDHCI BCM2835 */
> +		.pdata = &sdhci_bcm2835_pltfm_data,
> +		.caps = ((0x1 << SDHCI_MAX_BLOCK_SHIFT)
> +				& SDHCI_MAX_BLOCK_MASK) |
> +			SDHCI_CAN_VDD_330 |
> +			SDHCI_CAN_DO_HISPD,
> +		.caps1 = SDHCI_DRIVER_TYPE_A |
> +			SDHCI_DRIVER_TYPE_C,
> +		.mmc_caps = 0x00000000,
> +
> +	},
>  };
>  
>  static const struct of_device_id sdhci_iproc_of_match[] = {
> -	{ .compatible = "brcm,bcm2835-sdhci", .data = &bcm2835_data },
> -	{ .compatible = "brcm,sdhci-iproc-cygnus", .data = &iproc_cygnus_data},
> -	{ .compatible = "brcm,sdhci-iproc", .data = &iproc_data },
> +	{
> +		.compatible = "brcm,bcm2835-sdhci",
> +		.data = (void *)SDHCI_PLTFM_BCM2835
> +	},
> +	{
> +		.compatible = "brcm,sdhci-iproc-cygnus",
> +		.data = (void *)SDHCI_PLTFM_IPROC_CYGNUS
> +	},
> +	{
> +		.compatible = "brcm,sdhci-iproc",
> +		.data = (void *)SDHCI_PLTFM_IPROC
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
>  
> +static const struct acpi_device_id sdhci_iproc_acpi_ids[] = {
> +	{ .id = "BRCM5871", .driver_data = SDHCI_PLTFM_IPROC_CYGNUS },
> +	{ .id = "BRCM5872", .driver_data = SDHCI_PLTFM_IPROC },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(acpi, sdhci_iproc_acpi_ids);
> +
>  static int sdhci_iproc_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	const struct of_device_id *match;
> +	const struct acpi_device_id *acpi_id;
>  	const struct sdhci_iproc_data *iproc_data;
>  	struct sdhci_host *host;
>  	struct sdhci_iproc_host *iproc_host;
>  	struct sdhci_pltfm_host *pltfm_host;
>  	int ret;
> +	enum sdhci_pltfm_type plat_type;
> +
> +	if (dev->of_node) {
> +		match = of_match_device(sdhci_iproc_of_match, dev);
> +		if (match)
> +			plat_type = (enum sdhci_pltfm_type)match->data;
> +		else
> +			return -ENODEV;
> +	} else if (has_acpi_companion(dev)) {
> +		acpi_id = acpi_match_device(sdhci_iproc_acpi_ids, dev);
> +		if (acpi_id)
> +			plat_type = (enum sdhci_pltfm_type)acpi_id->driver_data;
> +		else
> +			return -ENODEV;
> +	} else
> +		return -ENODEV;
>  
> -	match = of_match_device(sdhci_iproc_of_match, &pdev->dev);
> -	if (!match)
> -		return -EINVAL;
> -	iproc_data = match->data;
> +	iproc_data = &sdhci_iproc_data_list[plat_type];
>  
>  	host = sdhci_pltfm_init(pdev, iproc_data->pdata, sizeof(*iproc_host));
>  	if (IS_ERR(host))
> @@ -284,17 +336,30 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>  
>  	host->mmc->caps |= iproc_host->data->mmc_caps;
>  
> -	pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(pltfm_host->clk)) {
> -		ret = PTR_ERR(pltfm_host->clk);
> -		goto err;
> -	}
> -	ret = clk_prepare_enable(pltfm_host->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to enable host clk\n");
> -		goto err;
> +	if (dev->of_node) {
> +		pltfm_host->clk = devm_clk_get(dev, NULL);
> +		if (IS_ERR(pltfm_host->clk)) {
> +			ret = PTR_ERR(pltfm_host->clk);
> +			goto err;
> +		}
> +		ret = clk_prepare_enable(pltfm_host->clk);
> +		if (ret) {
> +			dev_err(dev, "failed to enable host clk\n");
> +			goto err;
> +		}
> +	} else if (has_acpi_companion(dev)) {
> +		/*
> +		 * When Driver probe with ACPI device, clock devices
> +		 * are not available, so sdhci clock get from
> +		 * clock-frequency property given in _DSD object.
> +		 */
> +		device_property_read_u32(dev, "clock-frequency",
> +					 &pltfm_host->clock);

Is this a new property, or is it documented?  Did you consider enhancing
__sdhci_read_caps() and using the existing "sdhci-caps" and
"sdhci-caps-mask" properties?

> +		if (!pltfm_host->clock) {
> +			ret = -ENODEV;
> +			goto err;
> +		}
>  	}
> -
>  	if (iproc_host->data->pdata->quirks & SDHCI_QUIRK_MISSING_CAPS) {
>  		host->caps = iproc_host->data->caps;
>  		host->caps1 = iproc_host->data->caps1;
> @@ -307,7 +372,8 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_clk:
> -	clk_disable_unprepare(pltfm_host->clk);
> +	if (dev->of_node)
> +		clk_disable_unprepare(pltfm_host->clk);
>  err:
>  	sdhci_pltfm_free(pdev);
>  	return ret;
> @@ -317,6 +383,7 @@ static struct platform_driver sdhci_iproc_driver = {
>  	.driver = {
>  		.name = "sdhci-iproc",
>  		.of_match_table = sdhci_iproc_of_match,
> +		.acpi_match_table = ACPI_PTR(sdhci_iproc_acpi_ids),
>  		.pm = &sdhci_pltfm_pmops,
>  	},
>  	.probe = sdhci_iproc_probe,
> 

