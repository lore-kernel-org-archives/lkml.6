Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeEPIIc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:08:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:21748 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751395AbeEPII2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:08:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="199770756"
Subject: Re: [PATCH V5 3/3] mmc: sdhci: Add MSI interrupt support for O2 SD
 host
To: "ernest.zhang" <ernest.zhang@bayhubtech.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: Xiaoguang Yu <xiaoguang.yu@bayhubtech.com>,
        Shirley Her <shirley.her@bayhubtech.com>,
        Yuxiang Wan <yuxiang.wan@bayhubtech.com>
References: <20180420163950.11756-1-ernest.zhang@bayhubtech.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b3e93d89-8f95-be29-32d9-2bc8f6d83f62@intel.com>
Date: Wed, 16 May 2018 11:07:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420163950.11756-1-ernest.zhang@bayhubtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/18 19:39, ernest.zhang wrote:
> Add MSI interrupt support if the SD host device can support MSI interrupt.
> 
> Changes in V5:

The change log goes below the --- line or in a separate cover email.

> 	1. Because pci_enable_msi is marked as deprecated and should not be
> 	used in new code, use pci_alloc_irq_vectors instead.
> 	2. Remove unneeded CONFIG_PCI_MSI macro check
> 
> Changes in V4:
> 	Enable MSI interrupt if the MSI capability bit is set in
> 	capability register.
> 
> Changes in V3:
> 	None. This patch is add in V4.
> 
> Changes in V2:
> 	None. This patch is add in V4.
> 
> Changes in V1:
> 	None. This patch is add in V4.
> 
> Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 96adaae..374c783 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -358,11 +358,13 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  {
>  	struct sdhci_pci_chip *chip;
>  	struct sdhci_host *host;
> +	struct mmc_host *mmc;
>  	u32 reg;
>  	int ret;
>  
>  	chip = slot->chip;
>  	host = slot->host;
> +	mmc = host->mmc;
>  	switch (chip->pdev->device) {
>  	case PCI_DEVICE_ID_O2_SDS0:
>  	case PCI_DEVICE_ID_O2_SEABIRD0:
> @@ -373,6 +375,28 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  		if (reg & 0x1)
>  			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>  
> +		if (pci_find_capability(chip->pdev, PCI_CAP_ID_MSI)) {
> +			ret = pci_alloc_irq_vectors(chip->pdev, 1, 1,
> +						    PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +			if (ret == 1) {
> +				ret = pci_irq_vector(chip->pdev, 0);
> +				if (ret >= 0) {
> +					host->irq = ret;
> +					pr_info("%s: use MSI irq, irq=%d\n",
> +						mmc_hostname(mmc), host->irq);
> +				} else {
> +					pr_err("%s: failed to get device irq, err=%d\n",
> +					       mmc_hostname(mmc), ret);
> +				}
> +			} else {
> +				pr_err("%s: enable PCI MSI failed, err=%d\n",
> +				       mmc_hostname(mmc), ret);
> +			}
> +		} else {
> +			pr_info("%s: unsupport msi, use INTx irq\n",
> +				mmc_hostname(mmc));
> +		}

There seem to be more prints here than you really need.  Please reduce them
and make this a separate function.

> +
>  		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
>  			ret = pci_read_config_dword(chip->pdev,
>  						    O2_SD_MISC_SETTING, &reg);
> @@ -380,11 +404,11 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  				return -EIO;
>  			if (reg & (1 << 4)) {
>  				pr_info("%s: emmc 1.8v flag is set, force 1.8v signaling voltage\n",
> -					mmc_hostname(host->mmc));
> +					mmc_hostname(mmc));

The change from using 'host->mmc' to using local variable 'mmc' needs to be
a separate patch.

>  				host->flags &= ~SDHCI_SIGNALING_330;
>  				host->flags |= SDHCI_SIGNALING_180;
> -				host->mmc->caps2 |= MMC_CAP2_NO_SD;
> -				host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
> +				mmc->caps2 |= MMC_CAP2_NO_SD;
> +				mmc->caps2 |= MMC_CAP2_NO_SDIO;

Ditto

>  			}
>  		}
>  
> 
