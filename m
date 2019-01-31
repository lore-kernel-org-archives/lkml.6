Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3A1C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC26320B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbfAaKLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:11:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:1911 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731989AbfAaKLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:11:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 02:11:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,543,1539673200"; 
   d="scan'208";a="112584441"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by orsmga006.jf.intel.com with ESMTP; 31 Jan 2019 02:11:42 -0800
Subject: Re: [PATCH] mmc: cqhci: Fix a tiny potential memory leak on error
 condition
To:     Alamy Liu <alamy.liu@gmail.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190116002440.1678-1-alamy.liu@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a596ffb2-770c-08f8-f170-d69082876f14@intel.com>
Date:   Thu, 31 Jan 2019 12:10:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190116002440.1678-1-alamy.liu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/19 2:24 AM, Alamy Liu wrote:
> In the error case:
>    either cq_host->desc_base
>        or cq_host->trans_desc_base
> might have been granted memory successfully.
> 
> The value of mmc_host->cqe_enabled stays 'false'.
> Thus, cqhci_disable (mmc_cqe_ops->cqe_disable) won't be called to
> free the memory.
> Also, cqhci_disable() is designed to disable and free all resources,
> not suitable to handle this corner case.
> 
> Signed-off-by: Alamy Liu <alamy.liu@gmail.com>
> ---
>  drivers/mmc/host/cqhci.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 974997b6cb..58ad8cd613 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -223,7 +223,7 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
>  					      &cq_host->trans_desc_dma_base,
>  					      GFP_KERNEL);
>  	if (!cq_host->desc_base || !cq_host->trans_desc_base)
> -		return -ENOMEM;
> +		goto err_free_dma;
>  
>  	pr_debug("%s: cqhci: desc-base: 0x%p trans-base: 0x%p\n desc_dma 0x%llx trans_dma: 0x%llx\n",
>  		 mmc_hostname(cq_host->mmc), cq_host->desc_base, cq_host->trans_desc_base,
> @@ -234,6 +234,24 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
>  		setup_trans_desc(cq_host, i);
>  
>  	return 0;
> +
> +err_free_dma:
> +	if (cq_host->desc_base) {
> +		dmam_free_coherent(mmc_dev(cq_host->mmc), cq_host->desc_size,
> +				   cq_host->desc_base,
> +				   cq_host->desc_dma_base);
> +		cq_host->desc_base = NULL;
> +		cq_host->desc_dma_base = 0;
> +	}
> +	if (cq_host->trans_desc_base) {
> +		dmam_free_coherent(mmc_dev(cq_host->mmc), cq_host->data_size,
> +				   cq_host->trans_desc_base,
> +				   cq_host->trans_desc_dma_base);
> +		cq_host->trans_desc_base = NULL;
> +		cq_host->trans_desc_dma_base = 0;
> +	}
> +
> +	return -ENOMEM;
>  }
>  
>  static void __cqhci_enable(struct cqhci_host *cq_host)
> 

Normally, error handling is done step-by-step e.g.

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 26d63594b7ea..d015b465ade4 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -217,12 +217,15 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
 						 cq_host->desc_size,
 						 &cq_host->desc_dma_base,
 						 GFP_KERNEL);
+	if (!cq_host->desc_base)
+		return -ENOMEM;
+
 	cq_host->trans_desc_base = dmam_alloc_coherent(mmc_dev(cq_host->mmc),
 					      cq_host->data_size,
 					      &cq_host->trans_desc_dma_base,
 					      GFP_KERNEL);
-	if (!cq_host->desc_base || !cq_host->trans_desc_base)
-		return -ENOMEM;
+	if (!cq_host->trans_desc_base)
+		goto err_free_dma;
 
 	pr_debug("%s: cqhci: desc-base: 0x%p trans-base: 0x%p\n desc_dma 0x%llx trans_dma: 0x%llx\n",
 		 mmc_hostname(cq_host->mmc), cq_host->desc_base, cq_host->trans_desc_base,
@@ -233,6 +236,13 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
 		setup_trans_desc(cq_host, i);
 
 	return 0;
+
+err_free_dma:
+	dmam_free_coherent(mmc_dev(cq_host->mmc), cq_host->desc_size,
+			   cq_host->desc_base, cq_host->desc_dma_base);
+	cq_host->desc_base = NULL;
+	cq_host->desc_dma_base = 0;
+	return NULL;
 }
 
 static void __cqhci_enable(struct cqhci_host *cq_host)
