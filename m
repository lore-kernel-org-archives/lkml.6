Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A21C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553822064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553822064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeH2Onl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:43:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:22379 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727172AbeH2Onk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:43:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 03:47:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,301,1531810800"; 
   d="scan'208";a="66029307"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.98]) ([10.237.72.98])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2018 03:46:12 -0700
Subject: Re: [PATCH V7 3/9] mmc: sdhci: Change SDMA address register for v4
 mode
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
 <1535526184-32718-4-git-send-email-zhang.chunyan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <177be6f0-fb47-feb6-e76a-803e8c6938b6@intel.com>
Date:   Wed, 29 Aug 2018 13:44:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535526184-32718-4-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/18 10:02, Chunyan Zhang wrote:
> According to the SD host controller specification version 4.10, when
> Host Version 4 is enabled, SDMA uses ADMA System Address register
> (05Fh-058h) instead of using SDMA System Address register to
> support both 32-bit and 64-bit addressing.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0c61105..6fb70da 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -727,7 +727,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
>  	}
>  }
>  
> -static u32 sdhci_sdma_address(struct sdhci_host *host)
> +static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
>  {
>  	if (host->bounce_buffer)
>  		return host->bounce_addr;
> @@ -735,6 +735,17 @@ static u32 sdhci_sdma_address(struct sdhci_host *host)
>  		return sg_dma_address(host->data->sg);
>  }
>  
> +static void sdhci_set_sdma_addr(struct sdhci_host *host, dma_addr_t addr)
> +{
> +	if (host->v4_mode) {
> +		sdhci_writel(host, addr, SDHCI_ADMA_ADDRESS);
> +		if (host->flags & SDHCI_USE_64_BIT_DMA)
> +			sdhci_writel(host, (u64)addr >> 32, SDHCI_ADMA_ADDRESS_HI);
> +	} else {
> +		sdhci_writel(host, addr, SDHCI_DMA_ADDRESS);
> +	}
> +}
> +
>  static unsigned int sdhci_target_timeout(struct sdhci_host *host,
>  					 struct mmc_command *cmd,
>  					 struct mmc_data *data)
> @@ -994,8 +1005,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  					     SDHCI_ADMA_ADDRESS_HI);
>  		} else {
>  			WARN_ON(sg_cnt != 1);
> -			sdhci_writel(host, sdhci_sdma_address(host),
> -				     SDHCI_DMA_ADDRESS);
> +			sdhci_set_sdma_addr(host, sdhci_sdma_address(host));
>  		}
>  	}
>  
> @@ -2830,7 +2840,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  		 * some controllers are faulty, don't trust them.
>  		 */
>  		if (intmask & SDHCI_INT_DMA_END) {
> -			u32 dmastart, dmanow;
> +			dma_addr_t dmastart, dmanow;
>  
>  			dmastart = sdhci_sdma_address(host);
>  			dmanow = dmastart + host->data->bytes_xfered;
> @@ -2838,12 +2848,12 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  			 * Force update to the next DMA block boundary.
>  			 */
>  			dmanow = (dmanow &
> -				~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
> +				~((dma_addr_t)SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
>  				SDHCI_DEFAULT_BOUNDARY_SIZE;
>  			host->data->bytes_xfered = dmanow - dmastart;
> -			DBG("DMA base 0x%08x, transferred 0x%06x bytes, next 0x%08x\n",
> -			    dmastart, host->data->bytes_xfered, dmanow);
> -			sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
> +			DBG("DMA base %pad, transferred 0x%06x bytes, next %pad\n",
> +			    &dmastart, host->data->bytes_xfered, &dmanow);
> +			sdhci_set_sdma_addr(host, dmanow);
>  		}
>  
>  		if (intmask & SDHCI_INT_DATA_END) {
> @@ -3590,8 +3600,8 @@ int sdhci_setup_host(struct sdhci_host *host)
>  		}
>  	}
>  
> -	/* SDMA does not support 64-bit DMA */
> -	if (host->flags & SDHCI_USE_64_BIT_DMA)
> +	/* SDMA does not support 64-bit DMA if v4 mode not set */
> +	if ((host->flags & SDHCI_USE_64_BIT_DMA) && !host->v4_mode)
>  		host->flags &= ~SDHCI_USE_SDMA;
>  
>  	if (host->flags & SDHCI_USE_ADMA) {
> 

