Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AA7C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D71B20890
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D71B20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeGYJA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:00:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:10110 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbeGYJA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:00:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2018 00:50:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,400,1526367600"; 
   d="scan'208";a="248732247"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2018 00:50:26 -0700
Subject: Re: [PATCH V7 5/5] mmc: sdhci: Add MSI interrupt support for O2 SD
 host
To:     "ernest.zhang" <ernest.zhang@bayhubtech.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     chuanjin.pang@bayhubtech.com, mike.li@bayhubtech.com,
        chevron.li@bayhubtech.com, shirley.her@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, bobby.wu@bayhubtech.com
References: <20180716062655.24703-1-ernest.zhang@bayhubtech.com>
 <20180716062655.24703-5-ernest.zhang@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4c711813-e688-afca-371c-9396325fdbe5@intel.com>
Date:   Wed, 25 Jul 2018 10:48:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180716062655.24703-5-ernest.zhang@bayhubtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/18 09:26, ernest.zhang wrote:
> Add MSI interrupt support if the SD host device can support MSI interrupt.
> 
> Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in V7:
> 	N/A
> 
> Changes in V6:
> 	1. Move change log to correct place.
> 	2. Reduce unneeded pr_info prints.
> 	3. In function sdhci_pci_o2_probe_slot, remove using local
> 	variable 'mmc' instead of using 'host->mmc'.
> 	4. Make the msi enable code a sperate function.
> 
> Changes in V5:
> 	1. Because pci_enable_msi is marked as deprecated and should not be
> 	used in new code, use pci_alloc_irq_vectors instead.
> 	2. Remove unneeded CONFIG_PCI_MSI macro check.
> 
> Changes in V4:
> 	Enable MSI interrupt if the MSI capability bit is set in
> 	capability register.
> 
> Changes in V1~V3:
> 	N/A
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 7747e8ba2e3d..56bc71763956 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -260,6 +260,29 @@ static void sdhci_pci_o2_fujin2_pci_init(struct sdhci_pci_chip *chip)
>  	pci_write_config_dword(chip->pdev, O2_SD_MISC_CTRL4, scratch_32);
>  }
>  
> +static void sdhci_pci_o2_enable_msi(struct sdhci_pci_chip *chip,
> +				    struct sdhci_host *host)
> +{
> +	int ret;
> +
> +	ret = pci_find_capability(chip->pdev, PCI_CAP_ID_MSI);
> +	if (!ret) {
> +		pr_info("%s: unsupport msi, use INTx irq\n",
> +			mmc_hostname(host->mmc));
> +		return;
> +	}
> +
> +	ret = pci_alloc_irq_vectors(chip->pdev, 1, 1,
> +				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +	if (ret < 0) {
> +		pr_err("%s: enable PCI MSI failed, err=%d\n",
> +		       mmc_hostname(host->mmc), ret);
> +		return;
> +	}
> +
> +	host->irq = pci_irq_vector(chip->pdev, 0);
> +}
> +
>  int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  {
>  	struct sdhci_pci_chip *chip;
> @@ -279,6 +302,8 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  		if (reg & 0x1)
>  			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>  
> +		sdhci_pci_o2_enable_msi(chip, host);
> +
>  		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
>  			ret = pci_read_config_dword(chip->pdev,
>  						    O2_SD_MISC_SETTING, &reg);
> 

