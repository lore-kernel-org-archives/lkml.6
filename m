Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AB6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C336620C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfB0Npv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:45:51 -0500
Received: from mga04.intel.com ([192.55.52.120]:31928 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730166AbfB0Npv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:45:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 05:45:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,419,1544515200"; 
   d="scan'208";a="127647069"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by fmsmga008.fm.intel.com with ESMTP; 27 Feb 2019 05:45:48 -0800
Subject: Re: [PATCH v2 2/2] mmc: cqhci: Fix a tiny potential memory leak on
 error condition
To:     Alamy Liu <alamy.liu@gmail.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20190225192214.3881-1-alamy.liu@gmail.com>
 <20190225192214.3881-2-alamy.liu@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <81a6b332-f6ac-a6fe-15e9-c6cf96a4a603@intel.com>
Date:   Wed, 27 Feb 2019 15:44:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190225192214.3881-2-alamy.liu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/19 9:22 PM, Alamy Liu wrote:
> Free up the allocated memory in the case of error return
> 
> --- code study ---
> The value of mmc_host->cqe_enabled stays 'false'.
> Thus, cqhci_disable (mmc_cqe_ops->cqe_disable) won't be called to
> free the memory.
> Also, cqhci_disable() seems to be designed to disable and free
> all resources, not suitable to handle this corner case.
> 
> Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
> Signed-off-by: Alamy Liu <alamy.liu@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/cqhci.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 974997b6cb..795893ba47 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -218,12 +218,21 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
>  						 cq_host->desc_size,
>  						 &cq_host->desc_dma_base,
>  						 GFP_KERNEL);
> +	if (!cq_host->desc_base)
> +		return -ENOMEM;
> +
>  	cq_host->trans_desc_base = dmam_alloc_coherent(mmc_dev(cq_host->mmc),
>  					      cq_host->data_size,
>  					      &cq_host->trans_desc_dma_base,
>  					      GFP_KERNEL);
> -	if (!cq_host->desc_base || !cq_host->trans_desc_base)
> +	if (!cq_host->trans_desc_base) {
> +		dmam_free_coherent(mmc_dev(cq_host->mmc), cq_host->desc_size,
> +				   cq_host->desc_base,
> +				   cq_host->desc_dma_base);
> +		cq_host->desc_base = NULL;
> +		cq_host->desc_dma_base = 0;
>  		return -ENOMEM;
> +	}
>  
>  	pr_debug("%s: cqhci: desc-base: 0x%p trans-base: 0x%p\n desc_dma 0x%llx trans_dma: 0x%llx\n",
>  		 mmc_hostname(cq_host->mmc), cq_host->desc_base, cq_host->trans_desc_base,
> 

