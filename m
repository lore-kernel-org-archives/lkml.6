Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA9713F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4819E20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4819E20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbeG3OmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:42:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:20898 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbeG3OmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:42:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 06:07:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="71684561"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jul 2018 06:07:10 -0700
Subject: Re: [PATCH V4 3/7] mmc: sdhci: add ADMA2 64-bit addressing support
 for V4 mode
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>,
        Jason Wu <jason.wu@unisoc.com>, zhang.lyra@gmail.com
References: <1532340508-8749-1-git-send-email-zhang.chunyan@linaro.org>
 <1532340508-8749-4-git-send-email-zhang.chunyan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <1179b8d9-056e-17de-6fcb-3d2b6334e1c6@intel.com>
Date:   Mon, 30 Jul 2018 16:05:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <1532340508-8749-4-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/18 13:08, Chunyan Zhang wrote:
> ADMA2 64-bit addressing support is divided into V3 mode and V4 mode.
> So there are two kinds of descriptors for ADMA2 64-bit addressing
> i.e. 96-bit Descriptor for V3 mode, and 128-bit Descriptor for V4
> mode. 128-bit Descriptor is aligned to 8-byte.
> 
> For V4 mode, ADMA2 64-bit addressing is enabled via Host Control 2
> register.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 90 ++++++++++++++++++++++++++++++++++--------------
>  drivers/mmc/host/sdhci.h | 15 ++++++--
>  2 files changed, 78 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9cb17c0..ce71afa 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -271,6 +271,46 @@ static void sdhci_set_default_irqs(struct sdhci_host *host)
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
> +	if ((host->flags & SDHCI_REQ_USE_DMA) &&

	if (!(host->flags & SDHCI_REQ_USE_DMA))
		goto out;

> +	    (host->flags & SDHCI_USE_ADMA))
> +		ctrl |= SDHCI_CTRL_ADMA32;

	/* Note if DMA Select is zero then SDMA is selected */
	if (host->flags & SDHCI_USE_ADMA)
		ctrl |= SDHCI_CTRL_ADMA32;

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
> +		} else {
> +			if ((host->flags & SDHCI_REQ_USE_DMA) &&

The 'else' and 'if' should be together i.e.

		} else if (host->flags & SDHCI_USE_ADMA) {
			/*
			 * Don't need to undo SDHCI_CTRL_ADMA32 in order to set
			 * SDHCI_CTRL_ADMA64.
			 */
			ctrl |= SDHCI_CTRL_ADMA64;
		}

> +			    (host->flags & SDHCI_USE_ADMA))
> +				ctrl |= SDHCI_CTRL_ADMA64;
> +		}
> +	}
> +

out:

> +	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +}
> +
>  static void sdhci_init(struct sdhci_host *host, int soft)
>  {
>  	struct mmc_host *mmc = host->mmc;
> @@ -916,7 +956,6 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  
>  static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  {
> -	u8 ctrl;
>  	struct mmc_data *data = cmd->data;
>  
>  	host->data_timeout = 0;
> @@ -1012,25 +1051,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
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
> @@ -3503,6 +3524,19 @@ static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
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
> @@ -3539,7 +3573,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>  
>  	override_timeout_clk = host->timeout_clk;
>  
> -	if (host->version > SDHCI_SPEC_300) {
> +	if (host->version > SDHCI_SPEC_420) {

Please make this and the addition of the SDHCI_SPEC_4xx defines
a separate patch.

>  		pr_err("%s: Unknown controller version (%d). You may experience problems.\n",
>  		       mmc_hostname(mmc), host->version);
>  	}
> @@ -3574,7 +3608,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	 * SDHCI_QUIRK2_BROKEN_64_BIT_DMA must be left to the drivers to
>  	 * implement.
>  	 */
> -	if (host->caps & SDHCI_CAN_64BIT)
> +	if (sdhci_can_64bit_dma(host))
>  		host->flags |= SDHCI_USE_64_BIT_DMA;
>  
>  	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
> @@ -3608,8 +3642,8 @@ int sdhci_setup_host(struct sdhci_host *host)
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
> @@ -3617,7 +3651,13 @@ int sdhci_setup_host(struct sdhci_host *host)
>  		}
>  
>  		host->align_buffer_sz = SDHCI_MAX_SEGS * SDHCI_ADMA2_ALIGN;
> -		buf = dma_alloc_coherent(mmc_dev(mmc), host->align_buffer_sz +
> +		/*
> +		 * Host Controller Version 4.00 or later can support 128-bit
> +		 * and 96-bit Descriptor for 64-bit addressing mode. 128-bit
> +		 * Descriptor is for v4 mode, and high 32-bit of it is reserved
> +		 * according to the specification v4.10.
> +		 */

But the point is zalloc() lets us skip writing the reserved bits.
How about:

		/*
		 * Use zalloc to zero the reserved high 32-bits of 128-bit
		 * descriptors so that they never need to be written.
		 */

> +		buf = dma_zalloc_coherent(mmc_dev(mmc), host->align_buffer_sz +
>  					 host->adma_table_sz, &dma, GFP_KERNEL);
>  		if (!buf) {
>  			pr_warn("%s: Unable to allocate ADMA buffers - falling back to standard DMA\n",
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 519d939..23318ff 100644
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
> @@ -271,6 +273,9 @@
>  #define   SDHCI_SPEC_100	0
>  #define   SDHCI_SPEC_200	1
>  #define   SDHCI_SPEC_300	2
> +#define   SDHCI_SPEC_400	3
> +#define   SDHCI_SPEC_410	4
> +#define   SDHCI_SPEC_420	5
>  
>  /*
>   * End of controller registers.
> @@ -306,8 +311,14 @@ struct sdhci_adma2_32_desc {
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

