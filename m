Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E723AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964A52087E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964A52087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbeHWPAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:00:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:4613 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbeHWPAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:00:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2018 04:31:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,278,1531810800"; 
   d="scan'208";a="256605377"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.137]) ([10.237.72.137])
  by fmsmga005.fm.intel.com with ESMTP; 23 Aug 2018 04:31:31 -0700
Subject: Re: [PATCH v4 2/3] mmc: sdhci: introduce adma_write_desc() hook to
 struct sdhci_ops
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180823180549.78e508db@xhacker.debian>
 <20180823180822.7e904f73@xhacker.debian>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <239c59fc-9081-15fc-295c-345818d01f99@intel.com>
Date:   Thu, 23 Aug 2018 14:29:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180823180822.7e904f73@xhacker.debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/18 13:08, Jisheng Zhang wrote:
> Add this hook so that it can be overridden with driver specific
> implementations. We also let the original sdhci_adma_write_desc()
> accept &desc so that the function can set its new value. Then export
> the function so that it could be reused by driver's specific
> implementations.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 37 +++++++++++++++++++++++--------------
>  drivers/mmc/host/sdhci.h |  4 ++++
>  2 files changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 52ccf4644384..eb21d2db7f05 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -554,10 +554,10 @@ static void sdhci_kunmap_atomic(void *buffer, unsigned long *flags)
>  	local_irq_restore(*flags);
>  }
>  
> -static void sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
> -				  dma_addr_t addr, int len, unsigned cmd)
> +void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
> +			   dma_addr_t addr, int len, unsigned int cmd)
>  {
> -	struct sdhci_adma2_64_desc *dma_desc = desc;
> +	struct sdhci_adma2_64_desc *dma_desc = *desc;
>  
>  	/* 32-bit and 64-bit descriptors have these members in same position */
>  	dma_desc->cmd = cpu_to_le16(cmd);
> @@ -566,6 +566,19 @@ static void sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
>  
>  	if (host->flags & SDHCI_USE_64_BIT_DMA)
>  		dma_desc->addr_hi = cpu_to_le32((u64)addr >> 32);
> +
> +	*desc += host->desc_sz;
> +}
> +EXPORT_SYMBOL_GPL(sdhci_adma_write_desc);
> +
> +static inline void __sdhci_adma_write_desc(struct sdhci_host *host,
> +					   void **desc, dma_addr_t addr,
> +					   int len, unsigned int cmd)
> +{
> +	if (host->ops->adma_write_desc)
> +		host->ops->adma_write_desc(host, desc, addr, len, cmd);
> +
> +	sdhci_adma_write_desc(host, desc, addr, len, cmd);
>  }
>  
>  static void sdhci_adma_mark_end(void *desc)
> @@ -618,28 +631,24 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
>  			}
>  
>  			/* tran, valid */
> -			sdhci_adma_write_desc(host, desc, align_addr, offset,
> -					      ADMA2_TRAN_VALID);
> +			__sdhci_adma_write_desc(host, &desc, align_addr,
> +						offset, ADMA2_TRAN_VALID);
>  
>  			BUG_ON(offset > 65536);
>  
>  			align += SDHCI_ADMA2_ALIGN;
>  			align_addr += SDHCI_ADMA2_ALIGN;
>  
> -			desc += host->desc_sz;
> -
>  			addr += offset;
>  			len -= offset;
>  		}
>  
>  		BUG_ON(len > 65536);
>  
> -		if (len) {
> -			/* tran, valid */
> -			sdhci_adma_write_desc(host, desc, addr, len,
> -					      ADMA2_TRAN_VALID);
> -			desc += host->desc_sz;
> -		}
> +		/* tran, valid */
> +		if (len)
> +			__sdhci_adma_write_desc(host, &desc, addr, len,
> +						ADMA2_TRAN_VALID);
>  
>  		/*
>  		 * If this triggers then we have a calculation bug
> @@ -656,7 +665,7 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
>  		}
>  	} else {
>  		/* Add a terminating entry - nop, end, valid */
> -		sdhci_adma_write_desc(host, desc, 0, 0, ADMA2_NOP_END_VALID);
> +		__sdhci_adma_write_desc(host, &desc, 0, 0, ADMA2_NOP_END_VALID);
>  	}
>  }
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 25bddd21de31..2115416f973a 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -606,6 +606,8 @@ struct sdhci_ops {
>  	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
>  	void    (*card_event)(struct sdhci_host *host);
>  	void	(*voltage_switch)(struct sdhci_host *host);
> +	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
> +				   dma_addr_t addr, int len, unsigned int cmd);
>  };
>  
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> @@ -736,6 +738,8 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
>  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  				      struct mmc_ios *ios);
>  void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
> +void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
> +			   dma_addr_t addr, int len, unsigned int cmd);
>  
>  #ifdef CONFIG_PM
>  int sdhci_suspend_host(struct sdhci_host *host);
> 

