Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FC9C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D833121C16
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D833121C16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbeHIMtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:49:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51598 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbeHIMtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:49:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B8EE15A2;
        Thu,  9 Aug 2018 03:25:04 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1F733F5D4;
        Thu,  9 Aug 2018 03:25:02 -0700 (PDT)
Subject: Re: [PATCH v4 1/5] iommu/arm-smmu-v3: fix the implementation of
 flush_iotlb_all hook
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>
References: <1533558424-16748-1-git-send-email-thunder.leizhen@huawei.com>
 <1533558424-16748-2-git-send-email-thunder.leizhen@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8e00e0c2-c3d1-96ed-569a-b03170fb23a4@arm.com>
Date:   Thu, 9 Aug 2018 11:25:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533558424-16748-2-git-send-email-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/18 13:27, Zhen Lei wrote:
> .flush_iotlb_all can not just wait for previous tlbi operations to be
> completed, but should also invalid all TLBs of the related domain.

I think it was like that because the only caller in practice was 
iommu_group_create_direct_mappings(), and at that point any relevant 
invalidations would have already been issued anyway. Once 
flush_iotlb_all actually does what it's supposed to we'll get a bit of 
unavoidable over-invalidation on that path, but it's no big deal.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/arm-smmu-v3.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 4810f61..2f1304b 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1770,6 +1770,14 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
>   	return ops->unmap(ops, iova, size);
>   }
> 
> +static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +
> +	if (smmu_domain->smmu)
> +		arm_smmu_tlb_inv_context(smmu_domain);
> +}
> +
>   static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
>   {
>   	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
> @@ -1998,7 +2006,7 @@ static void arm_smmu_put_resv_regions(struct device *dev,
>   	.map			= arm_smmu_map,
>   	.unmap			= arm_smmu_unmap,
>   	.map_sg			= default_iommu_map_sg,
> -	.flush_iotlb_all	= arm_smmu_iotlb_sync,
> +	.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
>   	.iotlb_sync		= arm_smmu_iotlb_sync,
>   	.iova_to_phys		= arm_smmu_iova_to_phys,
>   	.add_device		= arm_smmu_add_device,
> --
> 1.8.3
> 
> 
