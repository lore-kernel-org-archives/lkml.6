Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AB0C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2374820883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2374820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932922AbeFUNV4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:21:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:53484 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932621AbeFUNVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:21:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 06:21:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,252,1526367600"; 
   d="scan'208";a="51129851"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by orsmga008.jf.intel.com with ESMTP; 21 Jun 2018 06:21:48 -0700
Subject: Re: [PATCH V2 3/7] mmc: sdhci: add ADMA2 64-bit addressing support
 for V4 mode
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
References: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
 <1529028255-6022-4-git-send-email-zhang.chunyan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ecd5f7df-a2ce-76a0-2be6-a151428aaf58@intel.com>
Date:   Thu, 21 Jun 2018 16:20:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1529028255-6022-4-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/18 05:04, Chunyan Zhang wrote:
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
>  drivers/mmc/host/sdhci.c | 50 +++++++++++++++++++++++++++++++++++-------------
>  drivers/mmc/host/sdhci.h | 23 +++++++++++++++++-----
>  2 files changed, 55 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f57201f..5d3b0d8 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -585,6 +585,8 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
>  	void *desc, *align;
>  	char *buffer;
>  	int len, offset, i;
> +	unsigned int adma2_align = SDHCI_ADMA2_ALIGN(host);
> +	unsigned int adma2_mask = SDHCI_ADMA2_MASK(host);
>  
>  	/*
>  	 * The spec does not specify endianness of descriptor table.
> @@ -608,8 +610,8 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
>  		 * buffer for the (up to three) bytes that screw up the
>  		 * alignment.
>  		 */
> -		offset = (SDHCI_ADMA2_ALIGN - (addr & SDHCI_ADMA2_MASK)) &
> -			 SDHCI_ADMA2_MASK;
> +		offset = (adma2_align - (addr & adma2_align)) &
> +			 adma2_mask;
>  		if (offset) {
>  			if (data->flags & MMC_DATA_WRITE) {
>  				buffer = sdhci_kmap_atomic(sg, &flags);
> @@ -623,8 +625,8 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
>  
>  			BUG_ON(offset > 65536);
>  
> -			align += SDHCI_ADMA2_ALIGN;
> -			align_addr += SDHCI_ADMA2_ALIGN;
> +			align += adma2_align;
> +			align_addr += adma2_align;
>  
>  			desc += host->desc_sz;
>  
> @@ -668,13 +670,15 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
>  	void *align;
>  	char *buffer;
>  	unsigned long flags;
> +	unsigned int adma2_align = SDHCI_ADMA2_ALIGN(host);
> +	unsigned int adma2_mask = SDHCI_ADMA2_MASK(host);
>  
>  	if (data->flags & MMC_DATA_READ) {
>  		bool has_unaligned = false;
>  
>  		/* Do a quick scan of the SG list for any unaligned mappings */
>  		for_each_sg(data->sg, sg, host->sg_count, i)
> -			if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
> +			if (sg_dma_address(sg) & adma2_mask) {
>  				has_unaligned = true;
>  				break;
>  			}
> @@ -686,15 +690,15 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
>  			align = host->align_buffer;
>  
>  			for_each_sg(data->sg, sg, host->sg_count, i) {
> -				if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
> -					size = SDHCI_ADMA2_ALIGN -
> -					       (sg_dma_address(sg) & SDHCI_ADMA2_MASK);
> +				if (sg_dma_address(sg) & adma2_mask) {
> +					size = adma2_align -
> +					       (sg_dma_address(sg) & adma2_mask);
>  
>  					buffer = sdhci_kmap_atomic(sg, &flags);
>  					memcpy(buffer, align, size);
>  					sdhci_kunmap_atomic(buffer, &flags);
>  
> -					align += SDHCI_ADMA2_ALIGN;
> +					align += adma2_align;
>  				}
>  			}
>  		}
> @@ -3400,6 +3404,26 @@ static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
>  	return 0;
>  }
>  
> +static inline bool sdhci_use_64bit_dma(struct sdhci_host *host)
> +{
> +	u32 addr64bit_en;
> +
> +	/*
> +	 * According to SD Host Controller spec v4.10, bit[27] added from
> +	 * version 4.10 in Capabilities Register is used as 64-bit System
> +	 * Address support for V4 mode, 64-bit DMA Addressing for V4 mode
> +	 * is enabled only if 64-bit Addressing =1 in the Host Control 2
> +	 * register.
> +	 */
> +	if (host->version == SDHCI_SPEC_410 && host->v4_mode) {
> +		addr64bit_en = (sdhci_readw(host, SDHCI_HOST_CONTROL2) &
> +				SDHCI_CTRL_64BIT_ADDR);

This seems the wrong way around.  SDHCI_CTRL_64BIT_ADDR should be set based
on the driver's requirements, not read to determine what the driver will do.

Can you clarify what SDHCI_CTRL_64BIT_ADDR is for?


> +		return addr64bit_en && (host->caps & SDHCI_CAN_64BIT_V4);
> +	}
> +
> +	return host->caps & SDHCI_CAN_64BIT;
> +}
> +
>  int sdhci_setup_host(struct sdhci_host *host)
>  {
>  	struct mmc_host *mmc;
> @@ -3471,7 +3495,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	 * SDHCI_QUIRK2_BROKEN_64_BIT_DMA must be left to the drivers to
>  	 * implement.
>  	 */
> -	if (host->caps & SDHCI_CAN_64BIT)
> +	if (sdhci_use_64bit_dma(host))
>  		host->flags |= SDHCI_USE_64_BIT_DMA;
>  
>  	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
> @@ -3505,15 +3529,15 @@ int sdhci_setup_host(struct sdhci_host *host)
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
>  			host->desc_sz = SDHCI_ADMA2_32_DESC_SZ;
>  		}
>  
> -		host->align_buffer_sz = SDHCI_MAX_SEGS * SDHCI_ADMA2_ALIGN;
> +		host->align_buffer_sz = SDHCI_MAX_SEGS * SDHCI_ADMA2_ALIGN(host);
>  		buf = dma_alloc_coherent(mmc_dev(mmc), host->align_buffer_sz +
>  					 host->adma_table_sz, &dma, GFP_KERNEL);

This needs to be dma_zalloc_coherent to ensure that the unused 4-bytes in
each 16-byte descriptor is zero.

>  		if (!buf) {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 128b0ba..820a863 100644
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
> @@ -206,6 +207,7 @@
>  #define  SDHCI_CAN_VDD_300	0x02000000
>  #define  SDHCI_CAN_VDD_180	0x04000000
>  #define  SDHCI_CAN_64BIT	0x10000000
> +#define  SDHCI_CAN_64BIT_V4	0x8000000

Please make it 8 digits and put it in the right numerical order

>  
>  #define  SDHCI_SUPPORT_SDR50	0x00000001
>  #define  SDHCI_SUPPORT_SDR104	0x00000002
> @@ -297,9 +299,14 @@ struct sdhci_adma2_32_desc {
>  	__le32	addr;
>  }  __packed __aligned(4);
>  
> -/* ADMA2 data alignment */
> -#define SDHCI_ADMA2_ALIGN	4
> -#define SDHCI_ADMA2_MASK	(SDHCI_ADMA2_ALIGN - 1)
> +/*
> + * ADMA2 data alignment
> + * According to SD Host Controller spec v4.10, if Host Version 4 Enable is set
> + * in the Host Control 2 register, 128-bit Descriptor will be selected which
> + * shall be aligned 8-byte address boundary.
> + */
> +#define SDHCI_ADMA2_ALIGN(host)	((host)->v4_mode ? 8 : 4)
> +#define SDHCI_ADMA2_MASK(host)	(SDHCI_ADMA2_ALIGN(host) - 1)

Are you really sure about that, because it reads like it is still 4-byte
alignment for data and 8-byte alignment for descriptors, which is what we
already do.

>  
>  /*
>   * ADMA2 descriptor alignment.  Some controllers (e.g. Intel) require 8 byte
> @@ -308,8 +315,14 @@ struct sdhci_adma2_32_desc {
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

