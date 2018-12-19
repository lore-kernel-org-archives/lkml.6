Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF39C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C632720874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeLSJF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:05:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:62140 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbeLSJF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:05:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 01:05:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,372,1539673200"; 
   d="scan'208";a="120035186"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by orsmga001.jf.intel.com with ESMTP; 19 Dec 2018 01:05:54 -0800
Subject: Re: [PATCH V1] mmc: cqhci: DMA Configuration prior to CQE
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1544811715-23792-1-git-send-email-skomatineni@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <15dbfe38-f9fe-fbb1-2c98-a60c0101200a@intel.com>
Date:   Wed, 19 Dec 2018 11:04:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1544811715-23792-1-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/18 8:21 PM, Sowjanya Komatineni wrote:
> eMMC-5.1 JESD85-B51 Spec (Section 6.6.39), mentions DMA selection

There is no JESD85-B51.  I presume you mean JESD84-B51, but I can't find any
reference to DMA in 6.6.39.  All the host controller relevant material seems
to be in Annex B.  Can you clarify this reference?

> and DMA Block size configuration on SDHCI Host need to be done
> prior to enabling Command Queue Engine.
> 
> This patch fixes the sequence to follow the spec.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/cqhci.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 159270e947cf..f701342e7212 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -248,6 +248,9 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
>  		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
>  	}
>  
> +	if (cq_host->ops->enable)
> +		cq_host->ops->enable(mmc);
> +
>  	cqcfg &= ~(CQHCI_DCMD | CQHCI_TASK_DESC_SZ);
>  
>  	if (mmc->caps2 & MMC_CAP2_CQE_DCMD)
> @@ -273,9 +276,6 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
>  
>  	mmc->cqe_on = true;
>  
> -	if (cq_host->ops->enable)
> -		cq_host->ops->enable(mmc);
> -
>  	/* Ensure all writes are done before interrupts are enabled */
>  	wmb();
>  
> @@ -561,6 +561,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	int tag = cqhci_tag(mrq);
>  	struct cqhci_host *cq_host = mmc->cqe_private;
>  	unsigned long flags;
> +	u32 cqcfg = 0;
>  
>  	if (!cq_host->enabled) {
>  		pr_err("%s: cqhci: not enabled\n", mmc_hostname(mmc));
> @@ -579,8 +580,19 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  			pr_err("%s: cqhci: CQE failed to exit halt state\n",
>  			       mmc_hostname(mmc));
>  		}
> +		/* Configuration must not be changed while enabled */
> +		cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
> +		if (cqcfg & CQHCI_ENABLE) {
> +			cqcfg &= ~CQHCI_ENABLE;
> +			cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
> +		}
> +
>  		if (cq_host->ops->enable)
>  			cq_host->ops->enable(mmc);
> +
> +		cqcfg |= CQHCI_ENABLE;
> +		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
> +
>  	}
>  
>  	if (mrq->data) {
> 

