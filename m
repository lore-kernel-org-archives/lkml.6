Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4136C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80A1216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80A1216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbeHCPPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:15:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:25780 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730601AbeHCPPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:15:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2018 06:18:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,438,1526367600"; 
   d="scan'208";a="77068923"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.153]) ([10.237.72.153])
  by fmsmga004.fm.intel.com with ESMTP; 03 Aug 2018 06:18:44 -0700
Subject: Re: [PATCH v3 2/2] mmc: host: iproc: Add ACPI support to IPROC SDHCI
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        vikram.prakash@broadcom.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1532931343-9499-1-git-send-email-srinath.mannam@broadcom.com>
 <1532931343-9499-3-git-send-email-srinath.mannam@broadcom.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <7a67a1f9-9cd1-103e-cfa1-e032f346e164@intel.com>
Date:   Fri, 3 Aug 2018 16:17:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532931343-9499-3-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/18 09:15, Srinath Mannam wrote:
> Add ACPI support to all IPROC SDHCI varients
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>

One minor comment below, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/Kconfig       |  1 +
>  drivers/mmc/host/sdhci-iproc.c | 63 +++++++++++++++++++++++++++++-------------
>  2 files changed, 45 insertions(+), 19 deletions(-)
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
> index d0e83db..abf5269 100644
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
> @@ -178,7 +189,7 @@ static const struct sdhci_ops sdhci_iproc_32only_ops = {
>  	.write_w = sdhci_iproc_writew,
>  	.write_b = sdhci_iproc_writeb,
>  	.set_clock = sdhci_set_clock,
> -	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +	.get_max_clock = sdhci_iproc_get_max_clock,
>  	.set_bus_width = sdhci_set_bus_width,
>  	.reset = sdhci_reset,
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
> @@ -256,19 +267,29 @@ static const struct of_device_id sdhci_iproc_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
>  
> +static const struct acpi_device_id sdhci_iproc_acpi_ids[] = {
> +	{ .id = "BRCM5871", .driver_data = (kernel_ulong_t)&iproc_cygnus_data },
> +	{ .id = "BRCM5872", .driver_data = (kernel_ulong_t)&iproc_data },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(acpi, sdhci_iproc_acpi_ids);
> +
>  static int sdhci_iproc_probe(struct platform_device *pdev)
>  {
> -	const struct of_device_id *match;
> -	const struct sdhci_iproc_data *iproc_data;
> +	struct device *dev = &pdev->dev;
> +	const struct sdhci_iproc_data *iproc_data = NULL;
>  	struct sdhci_host *host;
>  	struct sdhci_iproc_host *iproc_host;
>  	struct sdhci_pltfm_host *pltfm_host;
>  	int ret;
>  
> -	match = of_match_device(sdhci_iproc_of_match, &pdev->dev);
> -	if (!match)
> -		return -EINVAL;
> -	iproc_data = match->data;
> +	if (dev->of_node)
> +		iproc_data = of_device_get_match_data(dev);
> +	else if (has_acpi_companion(dev))
> +		iproc_data = acpi_device_get_match_data(dev);

Can you use device_get_match_data() here

> +
> +	if (!iproc_data)
> +		return -ENODEV;
>  
>  	host = sdhci_pltfm_init(pdev, iproc_data->pdata, sizeof(*iproc_host));
>  	if (IS_ERR(host))
> @@ -280,19 +301,21 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>  	iproc_host->data = iproc_data;
>  
>  	mmc_of_parse(host->mmc);
> -	sdhci_get_of_property(pdev);
> +	sdhci_get_property(pdev);
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
>  	}
>  
>  	if (iproc_host->data->pdata->quirks & SDHCI_QUIRK_MISSING_CAPS) {
> @@ -307,7 +330,8 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_clk:
> -	clk_disable_unprepare(pltfm_host->clk);
> +	if (dev->of_node)
> +		clk_disable_unprepare(pltfm_host->clk);
>  err:
>  	sdhci_pltfm_free(pdev);
>  	return ret;
> @@ -317,6 +341,7 @@ static struct platform_driver sdhci_iproc_driver = {
>  	.driver = {
>  		.name = "sdhci-iproc",
>  		.of_match_table = sdhci_iproc_of_match,
> +		.acpi_match_table = ACPI_PTR(sdhci_iproc_acpi_ids),
>  		.pm = &sdhci_pltfm_pmops,
>  	},
>  	.probe = sdhci_iproc_probe,
> 

