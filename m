Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F99AC2F3D5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3855C20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbfAUOPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:15:04 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34414 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729476AbfAUNvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:51:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A2D2EBD;
        Mon, 21 Jan 2019 05:51:51 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29DE13F614;
        Mon, 21 Jan 2019 05:51:49 -0800 (PST)
Subject: Re: [PATCH 1/3] iommu/arm-smmu: Move to bitmap for arm_smmu_domain
 atrributes
To:     Vivek Gautam <vivek.gautam@codeaurora.org>, will.deacon@arm.com,
        joro@8bytes.org, iommu@lists.linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, tfiga@chromium.org,
        pratikp@codeaurora.org, pdaly@codeaurora.org,
        jcrouse@codeaurora.org
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
 <20190121055335.15430-2-vivek.gautam@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b0688376-f922-9d17-eb66-f28df6963bcf@arm.com>
Date:   Mon, 21 Jan 2019 13:51:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190121055335.15430-2-vivek.gautam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2019 05:53, Vivek Gautam wrote:
> A number of arm_smmu_domain's attributes can be assigned based
> on the iommu domains's attributes. These local attributes better
> be managed by a bitmap.
> So remove boolean flags and move to a 32-bit bitmap, and enable
> each bits separtely.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>   drivers/iommu/arm-smmu.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 7ebbcf1b2eb3..52b300dfc096 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -257,10 +257,11 @@ struct arm_smmu_domain {
>   	const struct iommu_gather_ops	*tlb_ops;
>   	struct arm_smmu_cfg		cfg;
>   	enum arm_smmu_domain_stage	stage;
> -	bool				non_strict;
>   	struct mutex			init_mutex; /* Protects smmu pointer */
>   	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
>   	struct iommu_domain		domain;
> +#define ARM_SMMU_DOMAIN_ATTR_NON_STRICT	BIT(0)
> +	unsigned int			attr;
>   };
>   
>   struct arm_smmu_option_prop {
> @@ -901,7 +902,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
>   		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
>   
> -	if (smmu_domain->non_strict)
> +	if (smmu_domain->attr & ARM_SMMU_DOMAIN_ATTR_NON_STRICT)
>   		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
>   
>   	/* Non coherent page table mappings only for Stage-1 */
> @@ -1598,7 +1599,8 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>   	case IOMMU_DOMAIN_DMA:
>   		switch (attr) {
>   		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
> -			*(int *)data = smmu_domain->non_strict;
> +			*(int *)data = !!(smmu_domain->attr &
> +					  ARM_SMMU_DOMAIN_ATTR_NON_STRICT);
>   			return 0;
>   		default:
>   			return -ENODEV;
> @@ -1638,7 +1640,7 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
>   	case IOMMU_DOMAIN_DMA:
>   		switch (attr) {
>   		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
> -			smmu_domain->non_strict = *(int *)data;
> +			smmu_domain->attr |= ARM_SMMU_DOMAIN_ATTR_NON_STRICT;

But what if *data == 0?

Robin.

>   			break;
>   		default:
>   			ret = -ENODEV;
> 
