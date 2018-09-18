Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B280AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7327C206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7327C206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbeIRWn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:43:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48232 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730373AbeIRWn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:43:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64E0E15BF;
        Tue, 18 Sep 2018 10:09:58 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 36AC03F5BD;
        Tue, 18 Sep 2018 10:09:58 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 26D601AE1396; Tue, 18 Sep 2018 18:10:17 +0100 (BST)
Date:   Tue, 18 Sep 2018 18:10:17 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: Re: [PATCH v7 5/6] iommu/arm-smmu-v3: Add support for non-strict mode
Message-ID: <20180918171016.GL16498@arm.com>
References: <cover.1536935328.git.robin.murphy@arm.com>
 <4f9444c7224ea0e6e4cef8ddbf77bb5292a383e3.1536935328.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f9444c7224ea0e6e4cef8ddbf77bb5292a383e3.1536935328.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 03:30:23PM +0100, Robin Murphy wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Dynamically choose strict or non-strict mode for page table config based
> on the iommu domain type.

It's the domain type in conjunction with the attribute that determines
whether we use lazy or strict invalidation.

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> [rm: convert to domain attribute]
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index f10c852479fc..7bbfa5f7ce8e 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -612,6 +612,7 @@ struct arm_smmu_domain {
>  	struct mutex			init_mutex; /* Protects smmu pointer */
>  
>  	struct io_pgtable_ops		*pgtbl_ops;
> +	bool				non_strict;
>  
>  	enum arm_smmu_domain_stage	stage;
>  	union {
> @@ -1633,6 +1634,9 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
>  	if (smmu->features & ARM_SMMU_FEAT_COHERENCY)
>  		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
>  
> +	if (smmu_domain->non_strict)
> +		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
> +
>  	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
>  	if (!pgtbl_ops)
>  		return -ENOMEM;
> @@ -1934,13 +1938,17 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>  {
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  
> -	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
> -		return -EINVAL;
> -
>  	switch (attr) {
>  	case DOMAIN_ATTR_NESTING:
> +		if (domain->type != IOMMU_DOMAIN_UNMANAGED)
> +			return -EINVAL;
>  		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
>  		return 0;
> +	case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
> +		if (domain->type != IOMMU_DOMAIN_DMA)
> +			return -EINVAL;
> +		*(int *)data = smmu_domain->non_strict;
> +		return 0;
>  	default:
>  		return -ENODEV;

Hmm, there's a change in behaviour here (and also in the set function)
which is that unknown attributes now return -ENODEV for managed domains
instead of -EINVAL. I don't know if that's a problem, but I'd be inclined
to switch on the domain type and then have a nested switch for the supported
attributes.

Will
