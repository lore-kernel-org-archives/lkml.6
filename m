Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AD913F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461EA20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461EA20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbeG3OlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:41:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:2659 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbeG3OlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:41:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 06:06:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="71684340"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jul 2018 06:06:17 -0700
Subject: Re: [PATCH V4 2/7] mmc: sdhci: Change SDMA address register for v4
 mode
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>,
        Jason Wu <jason.wu@unisoc.com>, zhang.lyra@gmail.com
References: <1532340508-8749-3-git-send-email-zhang.chunyan@linaro.org>
 <1532400479-23216-1-git-send-email-zhang.chunyan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6ff6d603-5273-e67c-1e5b-bfe9e00f80d4@intel.com>
Date:   Mon, 30 Jul 2018 16:04:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <1532400479-23216-1-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/18 05:47, Chunyan Zhang wrote:
> According to the SD host controller specification version 4.10, when
> Host Version 4 is enabled, SDMA uses ADMA System Address register
> (05Fh-058h) instead of using SDMA System Address register to
> support both 32-bit and 64-bit addressing.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index cab5350..b7ad8e5 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -729,7 +729,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
>  	}
>  }
>  
> -static u32 sdhci_sdma_address(struct sdhci_host *host)
> +static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
>  {
>  	if (host->bounce_buffer)
>  		return host->bounce_addr;
> @@ -737,6 +737,18 @@ static u32 sdhci_sdma_address(struct sdhci_host *host)
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
> +

Please remove this blank line

> +}
> +
>  static unsigned int sdhci_target_timeout(struct sdhci_host *host,
>  					 struct mmc_command *cmd,
>  					 struct mmc_data *data)
> @@ -996,8 +1008,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  					     SDHCI_ADMA_ADDRESS_HI);
>  		} else {
>  			WARN_ON(sg_cnt != 1);
> -			sdhci_writel(host, sdhci_sdma_address(host),
> -				     SDHCI_DMA_ADDRESS);
> +			sdhci_set_sdma_addr(host, sdhci_sdma_address(host));
>  		}
>  	}
>  
> @@ -2824,7 +2835,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  		 * some controllers are faulty, don't trust them.
>  		 */
>  		if (intmask & SDHCI_INT_DMA_END) {
> -			u32 dmastart, dmanow;
> +			dma_addr_t dmastart, dmanow;
>  
>  			dmastart = sdhci_sdma_address(host);
>  			dmanow = dmastart + host->data->bytes_xfered;
> @@ -2832,12 +2843,12 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
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
> @@ -3581,8 +3592,8 @@ int sdhci_setup_host(struct sdhci_host *host)
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

