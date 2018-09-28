Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7EDC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EFE2159D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EFE2159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbeI1SlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:41:18 -0400
Received: from foss.arm.com ([217.140.101.70]:48392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeI1SlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:41:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA65CED1;
        Fri, 28 Sep 2018 05:17:47 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B8E73F5D3;
        Fri, 28 Sep 2018 05:17:44 -0700 (PDT)
Date:   Fri, 28 Sep 2018 13:17:38 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: Re: [PATCH v8 4/7] iommu/io-pgtable-arm: Add support for non-strict
 mode
Message-ID: <20180928121738.GA1577@brain-police>
References: <cover.1537458163.git.robin.murphy@arm.com>
 <9a666d63a96ab97dc53df2a64b3a8d22a0986423.1537458163.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a666d63a96ab97dc53df2a64b3a8d22a0986423.1537458163.git.robin.murphy@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 05:10:24PM +0100, Robin Murphy wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Non-strict mode is simply a case of skipping 'regular' leaf TLBIs, since
> the sync is already factored out into ops->iotlb_sync at the core API
> level. Non-leaf invalidations where we change the page table structure
> itself still have to be issued synchronously in order to maintain walk
> caches correctly.
> 
> To save having to reason about it too much, make sure the invalidation
> in arm_lpae_split_blk_unmap() just performs its own unconditional sync
> to minimise the window in which we're technically violating the break-
> before-make requirement on a live mapping. This might work out redundant
> with an outer-level sync for strict unmaps, but we'll never be splitting
> blocks on a DMA fastpath anyway.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> [rm: tweak comment, commit message, split_blk_unmap logic and barriers]
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v8: Add barrier for the fiddly cross-cpu flush case
> 
>  drivers/iommu/io-pgtable-arm.c | 14 ++++++++++++--
>  drivers/iommu/io-pgtable.h     |  5 +++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 2f79efd16a05..237cacd4a62b 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -576,6 +576,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>  		tablep = iopte_deref(pte, data);
>  	} else if (unmap_idx >= 0) {
>  		io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
> +		io_pgtable_tlb_sync(&data->iop);
>  		return size;
>  	}
>  
> @@ -609,6 +610,13 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>  			io_pgtable_tlb_sync(iop);
>  			ptep = iopte_deref(pte, data);
>  			__arm_lpae_free_pgtable(data, lvl + 1, ptep);
> +		} else if (iop->cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT) {
> +			/*
> +			 * Order the PTE update against queueing the IOVA, to
> +			 * guarantee that a flush callback from a different CPU
> +			 * has observed it before the TLBIALL can be issued.
> +			 */
> +			smp_wmb();

Looks good to me. In the case that everything happens on the same CPU, are
we relying on the TLB invalidation code in the SMMU driver(s) to provide the
DSB for pushing the new entry out to the walker?

Will
