Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759C1C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5F3218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfAaJgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:36:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:6408 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfAaJgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:36:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 01:36:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,543,1539673200"; 
   d="scan'208";a="143007840"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2019 01:36:49 -0800
Subject: Re: [PATCH 2/2] mmc: cqhci: replace DCMD_SLOT with cq_host->dcmd_slot
To:     Alamy Liu <alamy.liu@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190114191724.29960-1-alamy.liu@gmail.com>
 <20190114191724.29960-2-alamy.liu@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <01a6c26a-16a3-7164-8266-c8a834986313@intel.com>
Date:   Thu, 31 Jan 2019 11:35:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190114191724.29960-2-alamy.liu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/19 9:17 PM, Alamy Liu wrote:
> Prevent to use fixed value (DCMD_SLOT) after it had been determined
> and saved in a variable (cq_host->dcmd).

dcmd_slot is always 31 (i.e. DCMD_SLOT) so why not go the other way and get
rid of dcmd_slot and just use DCMD_SLOT?

> 
> Signed-off-by: Alamy Liu <alamy.liu@gmail.com>
> ---
>  drivers/mmc/host/cqhci.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 26d63594b7..4cc7863c13 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -76,7 +76,8 @@ static void setup_trans_desc(struct cqhci_host *cq_host, u8 tag)
>  	if (cq_host->link_desc_len > 8)
>  		*(link_temp + 8) = 0;
>  
> -	if (tag == DCMD_SLOT && (cq_host->mmc->caps2 & MMC_CAP2_CQE_DCMD)) {
> +	if ((tag == cq_host->dcmd_slot)
> +	    && (cq_host->mmc->caps2 & MMC_CAP2_CQE_DCMD)) {
>  		*link_temp = CQHCI_VALID(0) | CQHCI_ACT(0) | CQHCI_END(1);
>  		return;
>  	}
> @@ -548,9 +549,9 @@ static void cqhci_post_req(struct mmc_host *host, struct mmc_request *mrq)
>  	}
>  }
>  
> -static inline int cqhci_tag(struct mmc_request *mrq)
> +static inline int cqhci_tag(struct mmc_request *mrq, struct cqhci_host *cq_host)
>  {
> -	return mrq->cmd ? DCMD_SLOT : mrq->tag;
> +	return mrq->cmd ? cq_host->dcmd_slot : mrq->tag;
>  }
>  
>  static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> @@ -558,8 +559,8 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	int err = 0;
>  	u64 data = 0;
>  	u64 *task_desc = NULL;
> -	int tag = cqhci_tag(mrq);
>  	struct cqhci_host *cq_host = mmc->cqe_private;
> +	int tag = cqhci_tag(mrq, cq_host);
>  	unsigned long flags;
>  
>  	if (!cq_host->enabled) {
> @@ -824,7 +825,7 @@ static bool cqhci_timeout(struct mmc_host *mmc, struct mmc_request *mrq,
>  			  bool *recovery_needed)
>  {
>  	struct cqhci_host *cq_host = mmc->cqe_private;
> -	int tag = cqhci_tag(mrq);
> +	int tag = cqhci_tag(mrq, cq_host);
>  	struct cqhci_slot *slot = &cq_host->slot[tag];
>  	unsigned long flags;
>  	bool timed_out;
> 

