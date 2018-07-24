Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA177C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F02720880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F02720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388888AbeGXXza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:55:30 -0400
Received: from foss.arm.com ([217.140.101.70]:58680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388679AbeGXXz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:55:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4CDC7A9;
        Tue, 24 Jul 2018 15:46:48 -0700 (PDT)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A69C33F5B3;
        Tue, 24 Jul 2018 15:46:46 -0700 (PDT)
Subject: Re: [PATCH v3 6/6] iommu/arm-smmu-v3: add bootup option
 "iommu_strict_mode"
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
 <1531376312-2192-7-git-send-email-thunder.leizhen@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <33053c8f-3ac3-e1d6-e260-fd36c4af9312@arm.com>
Date:   Tue, 24 Jul 2018 23:46:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531376312-2192-7-git-send-email-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-12 7:18 AM, Zhen Lei wrote:
> Because the non-strict mode introduces a vulnerability window, so add a
> bootup option to make the manager can choose which mode to be used. The
> default mode is IOMMU_STRICT.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++
>   drivers/iommu/arm-smmu-v3.c                     | 32 ++++++++++++++++++++++---
>   2 files changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index efc7aa7..0cc80bc 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1720,6 +1720,18 @@
>   		nobypass	[PPC/POWERNV]
>   			Disable IOMMU bypass, using IOMMU for PCI devices.
>   
> +	iommu_strict_mode=	[arm-smmu-v3]

If anything this should belong to iommu-dma, as that's where the actual 
decision of whether to use a flush queue or not happens. Also it would 
be nice to stick to the iommu.* option namespace in the hope of 
maintaining some consistency.

> +		0 - strict mode
> +		    Make sure all related TLBs to be invalidated before the
> +		    memory released.
> +		1 - non-strict mode
> +		    Put off TLBs invalidation and release memory first. This mode
> +		    introduces a vlunerability window, an untrusted device can
> +		    access the reused memory because the TLBs may still valid.
> +		    Please take full consideration before choosing this mode.
> +		    Note that, VFIO is always use strict mode.
> +		others - strict mode
> +
>   	iommu.passthrough=
>   			[ARM64] Configure DMA to bypass the IOMMU by default.
>   			Format: { "0" | "1" }
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 4a198a0..9b72fc4 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -631,6 +631,24 @@ struct arm_smmu_option_prop {
>   	{ 0, NULL},
>   };
>   
> +static u32 iommu_strict_mode __read_mostly = IOMMU_STRICT;
> +
> +static int __init setup_iommu_strict_mode(char *str)
> +{
> +	u32 strict_mode = IOMMU_STRICT;
> +
> +	get_option(&str, &strict_mode);
> +	if (strict_mode == IOMMU_NON_STRICT) {
> +		iommu_strict_mode = strict_mode;
> +		pr_warn("WARNING: iommu non-strict mode is chose.\n"
> +			"It's good for scatter-gather performance but lacks full isolation\n");
> +		add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
> +	}
> +
> +	return 0;
> +}
> +early_param("iommu_strict_mode", setup_iommu_strict_mode);
> +
>   static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
>   						 struct arm_smmu_device *smmu)
>   {
> @@ -1441,7 +1459,7 @@ static bool arm_smmu_capable(enum iommu_cap cap)
>   	case IOMMU_CAP_NOEXEC:
>   		return true;
>   	case IOMMU_CAP_NON_STRICT:
> -		return true;
> +		return (iommu_strict_mode == IOMMU_NON_STRICT) ? true : false;

Ugh. The "completely redundant ternany" idiom hurts my soul :(

Robin.

>   	default:
>   		return false;
>   	}
> @@ -1750,6 +1768,14 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   	return ret;
>   }
>   
> +static u32 arm_smmu_strict_mode(struct iommu_domain *domain)
> +{
> +	if (iommu_strict_mode == IOMMU_NON_STRICT)
> +		return IOMMU_DOMAIN_STRICT_MODE(domain);
> +
> +	return IOMMU_STRICT;
> +}
> +
>   static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
>   			phys_addr_t paddr, size_t size, int prot)
>   {
> @@ -1769,7 +1795,7 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
>   	if (!ops)
>   		return 0;
>   
> -	return ops->unmap(ops, iova | IOMMU_DOMAIN_STRICT_MODE(domain), size);
> +	return ops->unmap(ops, iova | arm_smmu_strict_mode(domain), size);
>   }
>   
>   static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
> @@ -1784,7 +1810,7 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
>   {
>   	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
>   
> -	if (smmu && (IOMMU_DOMAIN_STRICT_MODE(domain) == IOMMU_STRICT))
> +	if (smmu && (arm_smmu_strict_mode(domain) == IOMMU_STRICT))
>   		__arm_smmu_tlb_sync(smmu);
>   }
>   
> 
