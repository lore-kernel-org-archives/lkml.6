Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54817C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AB5218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbfAaJyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:54:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:12724 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfAaJyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:54:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 01:54:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,543,1539673200"; 
   d="scan'208";a="112580613"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by orsmga006.jf.intel.com with ESMTP; 31 Jan 2019 01:54:45 -0800
Subject: Re: [PATCH] mmc: cqhci: data size depending on queue depth
To:     Alamy Liu <alamy.liu@gmail.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190115191356.32714-1-alamy.liu@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <16f9aaea-2e6c-a754-5029-dfbc1a2edba7@intel.com>
Date:   Thu, 31 Jan 2019 11:53:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115191356.32714-1-alamy.liu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/19 9:13 PM, Alamy Liu wrote:
> CQE_DCMD is not necessary to be enabled when CQE is enabled.
> (Software could halt CQE to send command, or via DCMD)
> 
> In the case that CQE_DCMD is not enabled, it still needs to allocate
> space for data transfer. For instance:
>   CQE_DCMD is enabled:  32 slots space
>   CQE_DCMD is disabled: 31 slots space (is good enough)

Is that the right way around?

If DCMD is enabled then we need 31 slots for data transfer and 1 for DCMD.
If DCMD is disabled then we need 32 slots for data transfer.

> 
> Signed-off-by: Alamy Liu <alamy.liu@gmail.com>
> ---
>  drivers/mmc/host/cqhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 4cc7863c13..974997b6cb 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -202,7 +202,7 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
>  	cq_host->desc_size = cq_host->slot_sz * cq_host->num_slots;
>  
>  	cq_host->data_size = cq_host->trans_desc_len * cq_host->mmc->max_segs *
> -		(cq_host->num_slots - 1);
> +		cq_host->mmc->cqe_qdepth;

So there is not enough being allocated for the !(mmc->caps2 &
MMC_CAP2_CQE_DCMD) case, which means this is a fix?  In that case, please
add a fixes tag, cc stable, and make the commit message clear that this is a
fix.

>  
>  	pr_debug("%s: cqhci: desc_size: %zu data_sz: %zu slot-sz: %d\n",
>  		 mmc_hostname(cq_host->mmc), cq_host->desc_size, cq_host->data_size,
> 

