Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0B9C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29667215B2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29667215B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbeHORBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:01:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:24959 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729125AbeHORBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:01:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2018 07:08:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,243,1531810800"; 
   d="scan'208";a="75571183"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.72]) ([10.237.72.72])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2018 07:08:52 -0700
Subject: Re: [PATCH mmc-next v3 2/3] mmc: sdhci: introduce adma_write_desc()
 hook to struct sdhci_ops
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180730104228.28b58bd0@xhacker.debian>
 <20180730104531.388b4f39@xhacker.debian>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0bf86945-d2da-3e04-0cfc-b7bc1a2c1702@intel.com>
Date:   Wed, 15 Aug 2018 17:07:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730104531.388b4f39@xhacker.debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/18 05:45, Jisheng Zhang wrote:
> Add this hook so that it can be overridden with driver specific
> implementations. We also rename the original sdhci_adma_write_desc()
> to _sdhci_adma_write_desc() and export it, so that it could be reused
> by driver's specific implementations.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/mmc/host/sdhci.c | 31 +++++++++++++++++++++++--------
>  drivers/mmc/host/sdhci.h |  6 ++++++
>  2 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 14dd4a49e03b..50c846d99182 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -554,8 +554,8 @@ static void sdhci_kunmap_atomic(void *buffer, unsigned long *flags)
>  	local_irq_restore(*flags);
>  }
>  
> -static void sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
> -				  dma_addr_t addr, int len, unsigned cmd)
> +unsigned int _sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
> +				    dma_addr_t addr, int len, unsigned int cmd)
>  {
>  	struct sdhci_adma2_64_desc *dma_desc = desc;
>  
> @@ -566,6 +566,19 @@ static void sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
>  
>  	if (host->flags & SDHCI_USE_64_BIT_DMA)
>  		dma_desc->addr_hi = cpu_to_le32((u64)addr >> 32);
> +
> +	return host->desc_sz;
> +}
> +EXPORT_SYMBOL_GPL(_sdhci_adma_write_desc);

Let's make the exported name without the _ i.e.sdhci_adma_write_desc

> +
> +static unsigned int sdhci_adma_write_desc(struct sdhci_host *host, void *desc,

Let's inline this and use __ i.e.

static inline void __sdhci_adma_write_desc(struct sdhci_host *host,

> +					  dma_addr_t addr, int len,
> +					  unsigned int cmd)
> +{
> +	if (host->ops->adma_write_desc)
> +		return host->ops->adma_write_desc(host, desc, addr, len, cmd);
> +
> +	return _sdhci_adma_write_desc(host, desc, addr, len, cmd);
>  }
>  
>  static void sdhci_adma_mark_end(void *desc)
> @@ -585,6 +598,7 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
>  	void *desc, *align;
>  	char *buffer;
>  	int len, offset, i;
> +	unsigned int desc_sz;
>  
>  	/*
>  	 * The spec does not specify endianness of descriptor table.
> @@ -618,15 +632,16 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
>  			}
>  
>  			/* tran, valid */
> -			sdhci_adma_write_desc(host, desc, align_addr, offset,
> -					      ADMA2_TRAN_VALID);
> +			desc_sz = sdhci_adma_write_desc(host, desc,

Instead of returning desc_sz, might just as well pass &desc and have the
function set its new value.

> +							align_addr, offset,
> +							ADMA2_TRAN_VALID);
>  
>  			BUG_ON(offset > 65536);
>  
>  			align += SDHCI_ADMA2_ALIGN;
>  			align_addr += SDHCI_ADMA2_ALIGN;
>  
> -			desc += host->desc_sz;
> +			desc += desc_sz;
>  
>  			addr += offset;
>  			len -= offset;
> @@ -636,9 +651,9 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
>  
>  		if (len) {
>  			/* tran, valid */
> -			sdhci_adma_write_desc(host, desc, addr, len,
> -					      ADMA2_TRAN_VALID);
> -			desc += host->desc_sz;
> +			desc_sz = sdhci_adma_write_desc(host, desc, addr, len,
> +							ADMA2_TRAN_VALID);
> +			desc += desc_sz;
>  		}
>  
>  		/*
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d55fd7033e93..0aad0ee8f63b 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -605,6 +605,9 @@ struct sdhci_ops {
>  	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
>  	void    (*card_event)(struct sdhci_host *host);
>  	void	(*voltage_switch)(struct sdhci_host *host);
> +	unsigned int	(*adma_write_desc)(struct sdhci_host *host, void *desc,
> +					   dma_addr_t addr, int len,
> +					   unsigned int cmd);
>  };
>  
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> @@ -735,6 +738,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
>  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  				      struct mmc_ios *ios);
>  void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
> +unsigned int _sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
> +				    dma_addr_t addr, int len,
> +				    unsigned int cmd);
>  
>  #ifdef CONFIG_PM
>  int sdhci_suspend_host(struct sdhci_host *host);
> 

