Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5866C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AD6216C4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AD6216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbeHOKcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 06:32:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:7240 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728583AbeHOKcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 06:32:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2018 00:41:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,242,1531810800"; 
   d="scan'208";a="248967102"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.72]) ([10.237.72.72])
  by orsmga005.jf.intel.com with ESMTP; 15 Aug 2018 00:41:37 -0700
Subject: Re: [PATCH mmc-next v3 1/3] mmc: sdhci: add adma_table_num member to
 struct sdhci_host
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180730104424.44fa39a5@xhacker.debian>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <553759fd-cf6d-a79d-1670-8bf94079725e@intel.com>
Date:   Wed, 15 Aug 2018 10:39:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730104424.44fa39a5@xhacker.debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/18 05:44, Jisheng Zhang wrote:
> This patch adds adma_table_num member to struct sdhci_host to give more
> flexibility to drivers to control the ADMA table number.
> 
> Default value of adma_table_num is set to (SDHCI_MAX_SEGS * 2 + 1).
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/mmc/host/sdhci.c | 17 +++++++++--------
>  drivers/mmc/host/sdhci.h |  2 ++
>  2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a7b5602ef6f7..14dd4a49e03b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3316,6 +3316,13 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
>  
>  	host->sdma_boundary = SDHCI_DEFAULT_BOUNDARY_ARG;
>  
> +	/*
> +	 * The DMA descriptor table number is calculated as the maximum

	 * The DMA table descriptor count is calculated as the maximum

> +	 * number of segments times 2, to allow for an alignment
> +	 * descriptor for each segment, plus 1 for a nop end descriptor.
> +	 */
> +	host->adma_table_num = SDHCI_MAX_SEGS * 2 + 1;

Let's make this adma_table_cnt

> +
>  	return host;
>  }
>  
> @@ -3561,18 +3568,12 @@ int sdhci_setup_host(struct sdhci_host *host)
>  		dma_addr_t dma;
>  		void *buf;
>  
> -		/*
> -		 * The DMA descriptor table size is calculated as the maximum
> -		 * number of segments times 2, to allow for an alignment
> -		 * descriptor for each segment, plus 1 for a nop end descriptor,
> -		 * all multipled by the descriptor size.
> -		 */
>  		if (host->flags & SDHCI_USE_64_BIT_DMA) {
> -			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
> +			host->adma_table_sz = host->adma_table_num *
>  					      SDHCI_ADMA2_64_DESC_SZ;
>  			host->desc_sz = SDHCI_ADMA2_64_DESC_SZ;
>  		} else {
> -			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
> +			host->adma_table_sz = host->adma_table_num *
>  					      SDHCI_ADMA2_32_DESC_SZ;
>  			host->desc_sz = SDHCI_ADMA2_32_DESC_SZ;
>  		}
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 23966f887da6..d55fd7033e93 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -563,6 +563,8 @@ struct sdhci_host {
>  	/* Host SDMA buffer boundary. */
>  	u32			sdma_boundary;
>  
> +	u32			adma_table_num;

Could use a comment

> +
>  	u64			data_timeout;
>  
>  	unsigned long private[0] ____cacheline_aligned;
> 

