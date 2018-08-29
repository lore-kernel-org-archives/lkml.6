Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77D2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3CA20833
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3CA20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbeH2Onl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:43:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:22379 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbeH2Onk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:43:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 03:47:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,301,1531810800"; 
   d="scan'208";a="66029314"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.98]) ([10.237.72.98])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2018 03:46:56 -0700
Subject: Re: [PATCH V7 4/9] mmc: sdhci: Add ADMA2 64-bit addressing support
 for V4 mode
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
 <1535526184-32718-5-git-send-email-zhang.chunyan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3d576407-9163-6a5e-11d6-7f27dd2fe57f@intel.com>
Date:   Wed, 29 Aug 2018 13:45:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535526184-32718-5-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/18 10:02, Chunyan Zhang wrote:
> ADMA2 64-bit addressing support is divided into V3 mode and V4 mode.
> So there are two kinds of descriptors for ADMA2 64-bit addressing
> i.e. 96-bit Descriptor for V3 mode, and 128-bit Descriptor for V4
> mode. 128-bit Descriptor is aligned to 8-byte.
> 
> For V4 mode, ADMA2 64-bit addressing is enabled via Host Control 2
> register.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>

Doesn't apply cleanly anymore, but nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 92 +++++++++++++++++++++++++++++++++++-------------
>  drivers/mmc/host/sdhci.h | 12 +++++--
>  2 files changed, 78 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 6fb70da..17345b6 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -266,6 +266,52 @@ static void sdhci_set_default_irqs(struct sdhci_host *host)
>  	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>  }
>  
> +static void sdhci_config_dma(struct sdhci_host *host)
> +{
> +	u8 ctrl;
> +	u16 ctrl2;
> +
> +	if (host->version < SDHCI_SPEC_200)
> +		return;
> +
> +	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> +
> +	/*
> +	 * Always adjust the DMA selection as some controllers
> +	 * (e.g. JMicron) can't do PIO properly when the selection
> +	 * is ADMA.
> +	 */
> +	ctrl &= ~SDHCI_CTRL_DMA_MASK;
> +	if (!(host->flags & SDHCI_REQ_USE_DMA))
> +		goto out;
> +
> +	/* Note if DMA Select is zero then SDMA is selected */
> +	if (host->flags & SDHCI_USE_ADMA)
> +		ctrl |= SDHCI_CTRL_ADMA32;
> +
> +	if (host->flags & SDHCI_USE_64_BIT_DMA) {
> +		/*
> +		 * If v4 mode, all supported DMA can be 64-bit addressing if
> +		 * controller supports 64-bit system address, otherwise only
> +		 * ADMA can support 64-bit addressing.
> +		 */
> +		if (host->v4_mode) {
> +			ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +			ctrl2 |= SDHCI_CTRL_64BIT_ADDR;
> +			sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
> +		} else if (host->flags & SDHCI_USE_ADMA) {
> +			/*
> +			 * Don't need to undo SDHCI_CTRL_ADMA32 in order to
> +			 * set SDHCI_CTRL_ADMA64.
> +			 */
> +			ctrl |= SDHCI_CTRL_ADMA64;
> +		}
> +	}
> +
> +out:
> +	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +}
> +
>  static void sdhci_init(struct sdhci_host *host, int soft)
>  {
>  	struct mmc_host *mmc = host->mmc;
> @@ -913,7 +959,6 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  
>  static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  {
> -	u8 ctrl;
>  	struct mmc_data *data = cmd->data;
>  
>  	host->data_timeout = 0;
> @@ -1009,25 +1054,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  		}
>  	}
>  
> -	/*
> -	 * Always adjust the DMA selection as some controllers
> -	 * (e.g. JMicron) can't do PIO properly when the selection
> -	 * is ADMA.
> -	 */
> -	if (host->version >= SDHCI_SPEC_200) {
> -		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> -		ctrl &= ~SDHCI_CTRL_DMA_MASK;
> -		if ((host->flags & SDHCI_REQ_USE_DMA) &&
> -			(host->flags & SDHCI_USE_ADMA)) {
> -			if (host->flags & SDHCI_USE_64_BIT_DMA)
> -				ctrl |= SDHCI_CTRL_ADMA64;
> -			else
> -				ctrl |= SDHCI_CTRL_ADMA32;
> -		} else {
> -			ctrl |= SDHCI_CTRL_SDMA;
> -		}
> -		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> -	}
> +	sdhci_config_dma(host);
>  
>  	if (!(host->flags & SDHCI_REQ_USE_DMA)) {
>  		int flags;
> @@ -3511,6 +3538,19 @@ static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
>  	return 0;
>  }
>  
> +static inline bool sdhci_can_64bit_dma(struct sdhci_host *host)
> +{
> +	/*
> +	 * According to SD Host Controller spec v4.10, bit[27] added from
> +	 * version 4.10 in Capabilities Register is used as 64-bit System
> +	 * Address support for V4 mode.
> +	 */
> +	if (host->version >= SDHCI_SPEC_410 && host->v4_mode)
> +		return host->caps & SDHCI_CAN_64BIT_V4;
> +
> +	return host->caps & SDHCI_CAN_64BIT;
> +}
> +
>  int sdhci_setup_host(struct sdhci_host *host)
>  {
>  	struct mmc_host *mmc;
> @@ -3582,7 +3622,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	 * SDHCI_QUIRK2_BROKEN_64_BIT_DMA must be left to the drivers to
>  	 * implement.
>  	 */
> -	if (host->caps & SDHCI_CAN_64BIT)
> +	if (sdhci_can_64bit_dma(host))
>  		host->flags |= SDHCI_USE_64_BIT_DMA;
>  
>  	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
> @@ -3616,8 +3656,8 @@ int sdhci_setup_host(struct sdhci_host *host)
>  		 */
>  		if (host->flags & SDHCI_USE_64_BIT_DMA) {
>  			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
> -					      SDHCI_ADMA2_64_DESC_SZ;
> -			host->desc_sz = SDHCI_ADMA2_64_DESC_SZ;
> +					      SDHCI_ADMA2_64_DESC_SZ(host);
> +			host->desc_sz = SDHCI_ADMA2_64_DESC_SZ(host);
>  		} else {
>  			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
>  					      SDHCI_ADMA2_32_DESC_SZ;
> @@ -3625,7 +3665,11 @@ int sdhci_setup_host(struct sdhci_host *host)
>  		}
>  
>  		host->align_buffer_sz = SDHCI_MAX_SEGS * SDHCI_ADMA2_ALIGN;
> -		buf = dma_alloc_coherent(mmc_dev(mmc), host->align_buffer_sz +
> +		/*
> +		 * Use zalloc to zero the reserved high 32-bits of 128-bit
> +		 * descriptors so that they never need to be written.
> +		 */
> +		buf = dma_zalloc_coherent(mmc_dev(mmc), host->align_buffer_sz +
>  					 host->adma_table_sz, &dma, GFP_KERNEL);
>  		if (!buf) {
>  			pr_warn("%s: Unable to allocate ADMA buffers - falling back to standard DMA\n",
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 61611e3..c5cc513 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -185,6 +185,7 @@
>  #define  SDHCI_CTRL_EXEC_TUNING		0x0040
>  #define  SDHCI_CTRL_TUNED_CLK		0x0080
>  #define  SDHCI_CTRL_V4_MODE		0x1000
> +#define  SDHCI_CTRL_64BIT_ADDR		0x2000
>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
>  
>  #define SDHCI_CAPABILITIES	0x40
> @@ -205,6 +206,7 @@
>  #define  SDHCI_CAN_VDD_330	0x01000000
>  #define  SDHCI_CAN_VDD_300	0x02000000
>  #define  SDHCI_CAN_VDD_180	0x04000000
> +#define  SDHCI_CAN_64BIT_V4	0x08000000
>  #define  SDHCI_CAN_64BIT	0x10000000
>  
>  #define  SDHCI_SUPPORT_SDR50	0x00000001
> @@ -309,8 +311,14 @@ struct sdhci_adma2_32_desc {
>   */
>  #define SDHCI_ADMA2_DESC_ALIGN	8
>  
> -/* ADMA2 64-bit DMA descriptor size */
> -#define SDHCI_ADMA2_64_DESC_SZ	12
> +/*
> + * ADMA2 64-bit DMA descriptor size
> + * According to SD Host Controller spec v4.10, there are two kinds of
> + * descriptors for 64-bit addressing mode: 96-bit Descriptor and 128-bit
> + * Descriptor, if Host Version 4 Enable is set in the Host Control 2
> + * register, 128-bit Descriptor will be selected.
> + */
> +#define SDHCI_ADMA2_64_DESC_SZ(host)	((host)->v4_mode ? 16 : 12)
>  
>  /*
>   * ADMA2 64-bit descriptor. Note 12-byte descriptor can't always be 8-byte
> 

