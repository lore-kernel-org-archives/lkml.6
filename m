Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED07C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353CB20878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388438AbfAKRAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:00:14 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59692 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728800AbfAKRAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:00:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9C7180D;
        Fri, 11 Jan 2019 09:00:12 -0800 (PST)
Received: from [10.1.196.128] (ostrya.cambridge.arm.com [10.1.196.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22BC83F5AF;
        Fri, 11 Jan 2019 09:00:09 -0800 (PST)
Subject: Re: [RFC v3 11/21] iommu/smmuv3: Implement cache_invalidate
To:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, will.deacon@arm.com, robin.murphy@arm.com
Cc:     marc.zyngier@arm.com, peter.maydell@linaro.org,
        kevin.tian@intel.com, ashok.raj@intel.com, christoffer.dall@arm.com
References: <20190108102633.17482-1-eric.auger@redhat.com>
 <20190108102633.17482-12-eric.auger@redhat.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <ee098c32-4c1f-90fe-eba3-b0e16995bacd@arm.com>
Date:   Fri, 11 Jan 2019 16:59:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190108102633.17482-12-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2019 10:26, Eric Auger wrote:
> Implement IOMMU_INV_TYPE_TLB invalidations. When
> nr_pages is null we interpret this as a context
> invalidation.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> The user API needs to be refined to discriminate context
> invalidations from NH_VA invalidations. Also the leaf attribute
> is not yet properly handled.
> 
> v2 -> v3:
> - replace __arm_smmu_tlb_sync by arm_smmu_cmdq_issue_sync
> 
> v1 -> v2:
> - properly pass the asid
> ---
>  drivers/iommu/arm-smmu-v3.c | 40 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 0e006babc8a6..ca72e0ce92f6 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2293,6 +2293,45 @@ static int arm_smmu_set_pasid_table(struct iommu_domain *domain,
>  	return ret;
>  }
>  
> +static int
> +arm_smmu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
> +			  struct iommu_cache_invalidate_info *inv_info)
> +{
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +
> +	if (smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
> +		return -EINVAL;
> +
> +	if (!smmu)
> +		return -EINVAL;
> +
> +	switch (inv_info->hdr.type) {
> +	case IOMMU_INV_TYPE_TLB:
> +		/*
> +		 * TODO: On context invalidation, the userspace sets nr_pages
> +		 * to 0. Refine the API to add a dedicated flags and also
> +		 * properly handle the leaf parameter.
> +		 */

That's what inv->granularity is for: if inv->granularity is PASID_SEL,
then the invalidation is for the whole context (and nr_pages, size,
addr, etc. should be ignored). If inv->granularity is PAGE_PASID, then
it's a range. The names could probably be improved but it's already in
the API

Thanks,
Jean

> +		if (!inv_info->nr_pages) {
> +			smmu_domain->s1_cfg.cd.asid = inv_info->arch_id;
> +			arm_smmu_tlb_inv_context(smmu_domain);
> +		} else {
> +			size_t granule = 1 << (inv_info->size + 12);
> +			size_t size = inv_info->nr_pages * granule;
> +
> +			smmu_domain->s1_cfg.cd.asid = inv_info->arch_id;
> +			arm_smmu_tlb_inv_range_nosync(inv_info->addr, size,
> +						      granule, false,
> +						      smmu_domain);
> +			arm_smmu_cmdq_issue_sync(smmu);
> +		}
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static struct iommu_ops arm_smmu_ops = {
>  	.capable		= arm_smmu_capable,
>  	.domain_alloc		= arm_smmu_domain_alloc,
> @@ -2312,6 +2351,7 @@ static struct iommu_ops arm_smmu_ops = {
>  	.get_resv_regions	= arm_smmu_get_resv_regions,
>  	.put_resv_regions	= arm_smmu_put_resv_regions,
>  	.set_pasid_table	= arm_smmu_set_pasid_table,
> +	.cache_invalidate	= arm_smmu_cache_invalidate,
>  	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>  };
>  
> 

