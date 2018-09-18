Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66861C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B897206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B897206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbeIRWnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:43:33 -0400
Received: from foss.arm.com ([217.140.101.70]:48248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730373AbeIRWnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:43:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 388797A9;
        Tue, 18 Sep 2018 10:10:02 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A7EF3F5BD;
        Tue, 18 Sep 2018 10:10:02 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id ECE8F1AE1396; Tue, 18 Sep 2018 18:10:20 +0100 (BST)
Date:   Tue, 18 Sep 2018 18:10:20 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: Re: [PATCH v7 6/6] iommu/arm-smmu: Support non-strict mode
Message-ID: <20180918171020.GM16498@arm.com>
References: <cover.1536935328.git.robin.murphy@arm.com>
 <09be4304bf23dde899be48dbddd93b09296f76bd.1536935328.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09be4304bf23dde899be48dbddd93b09296f76bd.1536935328.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 03:30:24PM +0100, Robin Murphy wrote:
> All we need is to wire up .flush_iotlb_all properly and implement the
> domain attribute, and iommu-dma and io-pgtable-arm will do the rest for
> us. Rather than bother implementing it for v7s format for the highly
> unlikely chance of that being relevant, we can simply hide the
> non-strict flag from io-pgtable for that combination just so anyone who
> does actually try it will simply get over-invalidation instead of
> failure to initialise domains.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 40 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index fd1b80ef9490..aa5be334753b 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -246,6 +246,7 @@ struct arm_smmu_domain {
>  	const struct iommu_gather_ops	*tlb_ops;
>  	struct arm_smmu_cfg		cfg;
>  	enum arm_smmu_domain_stage	stage;
> +	bool				non_strict;
>  	struct mutex			init_mutex; /* Protects smmu pointer */
>  	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
>  	struct iommu_domain		domain;
> @@ -863,6 +864,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
>  		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
>  
> +	if (smmu_domain->non_strict && cfg->fmt != ARM_SMMU_CTX_FMT_AARCH32_S)
> +		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;

Does this mean we end up over-invalidating when using short-descriptor?
Could we not bypass the flush queue in this case instead? Ideally, we'd
just reject the domain attribute but I don't know if we know about the
page-table format early enough for that. Alternatively, we could force
long format if the attribute is set.

What do you think?

Will
