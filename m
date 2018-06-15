Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85724C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DBA208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DBA208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966235AbeFOQwA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:52:00 -0400
Received: from foss.arm.com ([217.140.101.70]:44762 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965985AbeFOQv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:51:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75CD315B2;
        Fri, 15 Jun 2018 09:51:58 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 47BBD3F25D;
        Fri, 15 Jun 2018 09:51:58 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id D05571AE2F86; Fri, 15 Jun 2018 17:52:32 +0100 (BST)
Date:   Fri, 15 Jun 2018 17:52:32 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     robin.murphy@arm.com, joro@8bytes.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, pdaly@codeaurora.org
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add support to use Last level cache
Message-ID: <20180615165232.GE2202@arm.com>
References: <20180615105329.26800-1-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615105329.26800-1-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On Fri, Jun 15, 2018 at 04:23:29PM +0530, Vivek Gautam wrote:
> Qualcomm SoCs have an additional level of cache called as
> System cache or Last level cache[1]. This cache sits right
> before the DDR, and is tightly coupled with the memory
> controller.
> The cache is available to all the clients present in the
> SoC system. The clients request their slices from this system
> cache, make it active, and can then start using it. For these
> clients with smmu, to start using the system cache for
> dma buffers and related page tables [2], few of the memory
> attributes need to be set accordingly.
> This change makes the related memory Outer-Shareable, and
> updates the MAIR with necessary protection.
> 
> The MAIR attribute requirements are:
>     Inner Cacheablity = 0
>     Outer Cacheablity = 1, Write-Back Write Allocate
>     Outer Shareablity = 1

Hmm, so is this cache coherent with the CPU or not? Why don't normal
non-cacheable mappings allocated in the LLC by default?

> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index f7a96bcf94a6..8058e7205034 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -249,6 +249,7 @@ struct arm_smmu_domain {
>  	struct mutex			init_mutex; /* Protects smmu pointer */
>  	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
>  	struct iommu_domain		domain;
> +	bool				has_sys_cache;
>  };
>  
>  struct arm_smmu_option_prop {
> @@ -862,6 +863,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  
>  	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
>  		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
> +	if (smmu_domain->has_sys_cache)
> +		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_SYS_CACHE;
>  
>  	smmu_domain->smmu = smmu;
>  	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
> @@ -1477,6 +1480,9 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>  	case DOMAIN_ATTR_NESTING:
>  		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
>  		return 0;
> +	case DOMAIN_ATTR_USE_SYS_CACHE:
> +		*((int *)data) = smmu_domain->has_sys_cache;
> +		return 0;

I really don't like exposing this to clients directly like this,
particularly as there aren't any in-tree users. I would prefer that we
provide a way for the io-pgtable code to have its MAIR values overridden
so that all non-coherent DMA ends up using the system cache.

Will
