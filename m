Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA989C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD5C208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD5C208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933381AbeGJMop (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:44:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:38874 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754089AbeGJMoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:44:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 05:44:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,334,1526367600"; 
   d="scan'208";a="55406513"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by orsmga007.jf.intel.com with ESMTP; 10 Jul 2018 05:44:39 -0700
Subject: Re: [PATCH V6 2/3] mmc: sdhci: Add support for O2 hardware tuning
To:     "ernest.zhang" <ernest.zhang@bayhubtech.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     chuanjin.pang@bayhubtech.com, mike.li@bayhubtech.com,
        chevron.li@bayhubtech.com, shirley.her@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, bobby.wu@bayhubtech.com
References: <20180626154647.11623-1-ernest.zhang@bayhubtech.com>
 <20180626154647.11623-2-ernest.zhang@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <23e58ccf-ae8a-be2f-0f48-e098db9a8ac9@intel.com>
Date:   Tue, 10 Jul 2018 15:43:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180626154647.11623-2-ernest.zhang@bayhubtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/18 18:46, ernest.zhang wrote:
> Add hardware tuning function instead of software tuning because O2/Bayhub
> SD host controller support hardware tuning.
> 
> Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
> ---
> Changes in V6:
> 	1. From module 'sdhci' export the symbols 'sdhci_start_tuning',
> 	'sdhci_end_tuning','sdhci_send_tuning' and 'sdhci_reset_tuning'.
> 	2. Remove local tuning related functions in sdhci-pci-o2-micro.c
> 	instead of above function exported in sdhci module.
> 	3. Remove unneeded braces in function sdhci_set_transfer_mode.
> 	4. Move change log to correct place.
> 
> Changes in V5:
> 	In function sdhci_o2_send_tuning, mrq.data should set to NULL for
> 	cmd.data has been set to NULL.
> 
> Changes in V4:
> 	Patch V3 delete register SDHCI_TRANSFER_MODE write operation before
> 	send hardware tuning command in function sdhci_o2_send_tuning. This
> 	is a mistake. The write operation is essential for tuning command.
> 	Add it back.
> 
> Changes in V3:
> 	Rebase the patch on the mmc tree 'next' branch.
> 
> Changes in V2:
> 	Modify code format, and delete unused code path.
> 
> Changes in V1:
> 	Add many functions to execute hardware tuning for eMMC 1.8V HS200
> 	mode, the hardware tuning procedure is based on O2/Bayhub hardware
> 	tuning spec.
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 81 ++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c             | 16 ++++---
>  drivers/mmc/host/sdhci.h             |  5 +++
>  3 files changed, 97 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 94cf3cd..7747e8b 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -17,6 +17,9 @@
>   */
>  
>  #include <linux/pci.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/delay.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-pci.h"
> @@ -55,6 +58,82 @@
>  
>  #define O2_SD_VENDOR_SETTING	0x110
>  #define O2_SD_VENDOR_SETTING2	0x1C8
> +#define O2_SD_HW_TUNING_DISABLE	BIT(4)
> +
> +static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
> +{
> +	u16 reg;
> +
> +	/* enable hardware tuning */
> +	reg = sdhci_readw(host, O2_SD_VENDOR_SETTING);
> +	reg &= ~O2_SD_HW_TUNING_DISABLE;
> +	sdhci_writew(host, reg, O2_SD_VENDOR_SETTING);
> +}
> +
> +static void __sdhci_o2_execute_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	int i;
> +
> +	sdhci_send_tuning(host, MMC_SEND_TUNING_BLOCK_HS200);
> +
> +	for (i = 0; i < 150; i++) {
> +		u16 ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +
> +		if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
> +			if (ctrl & SDHCI_CTRL_TUNED_CLK) {
> +				host->tuning_done = true;
> +				return;
> +			}
> +			pr_warn("%s: HW tuning failed !\n",
> +				mmc_hostname(host->mmc));
> +			break;
> +		}
> +
> +		mdelay(1);
> +	}
> +
> +	pr_info("%s: Tuning failed, falling back to fixed sampling clock\n",
> +		mmc_hostname(host->mmc));
> +	sdhci_reset_tuning(host);
> +}
> +
> +static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	int current_bus_width = 0;
> +
> +	/*
> +	 * This handler only implements the eMMC tuning that is specific to
> +	 * this controller.  Fall back to the standard method for other TIMING.
> +	 */
> +	if (host->timing != MMC_TIMING_MMC_HS200)
> +		return sdhci_execute_tuning(mmc, opcode);
> +
> +	if (WARN_ON(opcode != MMC_SEND_TUNING_BLOCK_HS200))
> +		return -EINVAL;
> +
> +	/*
> +	 * o2 sdhci host didn't support 8bit emmc tuning
> +	 */
> +	if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
> +		current_bus_width = mmc->ios.bus_width;
> +		sdhci_set_bus_width(host, MMC_BUS_WIDTH_4);
> +	}
> +
> +	sdhci_o2_set_tuning_mode(host);
> +
> +	sdhci_start_tuning(host);
> +
> +	__sdhci_o2_execute_tuning(host, opcode);
> +
> +	sdhci_end_tuning(host);
> +
> +	if (current_bus_width == MMC_BUS_WIDTH_8)
> +		sdhci_set_bus_width(host, current_bus_width);
> +
> +	host->flags &= ~SDHCI_HS400_TUNING;
> +	return 0;
> +}
>  
>  static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
>  {
> @@ -215,6 +294,8 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  			}
>  		}
>  
> +		host->mmc_host_ops.execute_tuning = sdhci_o2_execute_tuning;
> +
>  		if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
>  			break;
>  		/* set dll watch dog timer */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1c828e0..4f3e3c2 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1029,7 +1029,9 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>  	if (data == NULL) {
>  		if (host->quirks2 &
>  			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
> -			sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
> +			/* must not clear SDHCI_TRANSFER_MODE when tuning */
> +			if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
> +				sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
>  		} else {
>  		/* clear Auto CMD settings for no data CMDs */
>  			mode = sdhci_readw(host, SDHCI_TRANSFER_MODE);
> @@ -2103,7 +2105,7 @@ static int sdhci_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
>  	return 0;
>  }
>  


Please put the export changes below into a separate patch.


> -static void sdhci_start_tuning(struct sdhci_host *host)
> +void sdhci_start_tuning(struct sdhci_host *host)
>  {
>  	u16 ctrl;
>  
> @@ -2126,14 +2128,16 @@ static void sdhci_start_tuning(struct sdhci_host *host)
>  	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_INT_ENABLE);
>  	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_SIGNAL_ENABLE);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_start_tuning);
>  
> -static void sdhci_end_tuning(struct sdhci_host *host)
> +void sdhci_end_tuning(struct sdhci_host *host)
>  {
>  	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>  	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_end_tuning);
>  
> -static void sdhci_reset_tuning(struct sdhci_host *host)
> +void sdhci_reset_tuning(struct sdhci_host *host)
>  {
>  	u16 ctrl;
>  
> @@ -2142,6 +2146,7 @@ static void sdhci_reset_tuning(struct sdhci_host *host)
>  	ctrl &= ~SDHCI_CTRL_EXEC_TUNING;
>  	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_reset_tuning);
>  
>  static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
>  {
> @@ -2162,7 +2167,7 @@ static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
>   * interrupt setup is different to other commands and there is no timeout
>   * interrupt so special handling is needed.
>   */
> -static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
> +void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
>  {
>  	struct mmc_host *mmc = host->mmc;
>  	struct mmc_command cmd = {};
> @@ -2212,6 +2217,7 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
>  			   msecs_to_jiffies(50));
>  
>  }
> +EXPORT_SYMBOL_GPL(sdhci_send_tuning);
>  
>  static void __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
>  {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 23966f8..2a09c0a 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -748,4 +748,9 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>  
>  void sdhci_dumpregs(struct sdhci_host *host);
>  
> +void sdhci_start_tuning(struct sdhci_host *host);
> +void sdhci_end_tuning(struct sdhci_host *host);
> +void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
> +void sdhci_reset_tuning(struct sdhci_host *host);
> +
>  #endif /* __SDHCI_HW_H */
> 

