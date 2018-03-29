Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeC2Mpr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:45:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:30334 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751008AbeC2Mpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:45:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="37863215"
Subject: Re: [PATCH V4 3/3] mmc: sdhci: Add MSI interrupt support for O2 SD
 host
To: "ernest.zhang" <ernest.zhang@bayhubtech.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com,
        yuxiang.wan@bayhubtech.com
References: <1520604265-4430-1-git-send-email-ernest.zhang@bayhubtech.com>
 <1520604265-4430-3-git-send-email-ernest.zhang@bayhubtech.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ac6505aa-603f-f10e-70fa-7c51af77f7fa@intel.com>
Date: Thu, 29 Mar 2018 15:44:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520604265-4430-3-git-send-email-ernest.zhang@bayhubtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/18 16:04, ernest.zhang wrote:
> Add MSI interrupt support if the SD host device can support MSI interrupt.
> 
> Changes: Enable MSI interrupt if the MSI capability bit is set in 
> capability register.
> 
> Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index a918984..7d04f4b 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -391,6 +391,23 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  		if (reg & 0x1)
>  			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>  
> +#if defined(CONFIG_PCI_MSI)

Do you really need to check CONFIG_PCI_MSI ?

> +		if (pci_find_capability(chip->pdev, PCI_CAP_ID_MSI)) {
> +			ret = pci_enable_msi(chip->pdev);
> +			if (!ret) {
> +				host->irq = chip->pdev->irq;
> +				pr_info("%s: use MSI irq, irq=%d\n",
> +					mmc_hostname(host->mmc), host->irq);
> +			} else {
> +				pr_err("%s: enable PCI MSI failed, err=%d\n",
> +					mmc_hostname(host->mmc), ret);
> +			}
> +		} else {
> +			pr_info("%s: unsupport msi, use INTx irq\n",
> +				mmc_hostname(host->mmc));
> +		}
> +#endif
> +
>  		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
>  			ret = pci_read_config_dword(chip->pdev,
>  						    O2_SD_MISC_SETTING, &reg);
> 
