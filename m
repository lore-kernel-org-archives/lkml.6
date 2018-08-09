Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E6EC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A37021D5B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A37021D5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbeHINax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:30:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52204 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbeHINax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:30:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA13D18A;
        Thu,  9 Aug 2018 04:06:32 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D6513F5D4;
        Thu,  9 Aug 2018 04:06:31 -0700 (PDT)
Subject: Re: [PATCH v4 4/5] iommu/arm-smmu-v3: add support for non-strict mode
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>
References: <1533558424-16748-1-git-send-email-thunder.leizhen@huawei.com>
 <1533558424-16748-5-git-send-email-thunder.leizhen@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <94c88d9e-818e-f893-9ee2-7a0cf425bd9a@arm.com>
Date:   Thu, 9 Aug 2018 12:06:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533558424-16748-5-git-send-email-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/18 13:27, Zhen Lei wrote:
> Dynamically choose strict or non-strict mode for page table config based
> on the iommu domain type.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/arm-smmu-v3.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 2f1304b..904bc1e 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1622,6 +1622,11 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
>   	if (smmu->features & ARM_SMMU_FEAT_COHERENCY)
>   		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
> 
> +	if (domain->type == IOMMU_DOMAIN_DMA) {
> +		domain->non_strict = 1;
> +		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
> +	}
> +
>   	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
>   	if (!pgtbl_ops)
>   		return -ENOMEM;
> @@ -1782,7 +1787,7 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
>   {
>   	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
> 
> -	if (smmu)
> +	if (smmu && !domain->non_strict)

That doesn't smell right - even in non-strict domains we still need 
stuff like walk cache invalidations for non-leaf unmaps to be 
synchronous, so we can't just ignore all sync operations at the driver 
level. I think the right thing to do to elide the "normal" sync on unmap 
is to first convert __iommu_dma_unmap to use 
iommu_unmap_fast()/iommu_tlb_sync(), then make it not issue that sync at 
all for non-strict domains.

Robin.

>   		__arm_smmu_tlb_sync(smmu);
>   }
> 
> --
> 1.8.3
> 
> 
