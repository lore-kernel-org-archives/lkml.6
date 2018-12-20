Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20751C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA15120989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbeLTMjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:39:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:26754 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730500AbeLTMjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:39:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2018 04:39:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,377,1539673200"; 
   d="scan'208";a="112089937"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by orsmga003.jf.intel.com with ESMTP; 20 Dec 2018 04:39:29 -0800
Subject: Re: [PATCH V4 2/4] mmc: cqhci: DMA Configuration prior to CQE
To:     Sowjanya Komatineni <skomatineni@nvidia.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, mperttunen@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        ulf.hansson@linaro.org
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <1545262938-20636-1-git-send-email-skomatineni@nvidia.com>
 <1545262938-20636-3-git-send-email-skomatineni@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b6789159-c4ce-cc28-e7f5-33ab1e95175f@intel.com>
Date:   Thu, 20 Dec 2018 14:37:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1545262938-20636-3-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/18 1:42 AM, Sowjanya Komatineni wrote:
> eMMC-5.1 JESD84-B51 Spec (Section 6.6.39.1), mentions "Prior to
> enabling command queuing, the block size shall be set to 512 B.
> Device may respond with an error to CMD46/CMD47 if block size
> is not 512 B".

This doesn't seem to relate to the host controller implementation.  "The
device" means the eMMC.

We don't want to disable and re-enable in the request function, so that
change is not good for controllers that don't have your problem.  Another
thing to consider is that the block size register may not need to be changed
- for example when cqhci is halted to allow a manual discard, the block size
register is not updated, so I would expect its value to be unchanged.

There are ways you can solve this in your driver.  You could look at using
SDHCI I/O accessors, and/or implement your own ->enable() instead of calling
sdhci_cqe_enable() directly.  Would that be feasible?

> 
> This patch fixes the sequence to follow exact as per the spec.
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

