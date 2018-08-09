Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999CAC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519062151C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519062151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbeHINdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:33:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52256 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbeHINdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:33:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BE8B18A;
        Thu,  9 Aug 2018 04:08:40 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D93C3F5D4;
        Thu,  9 Aug 2018 04:08:37 -0700 (PDT)
Subject: Re: [PATCH v4 5/5] iommu/arm-smmu-v3: add bootup option "arm_iommu"
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>
References: <1533558424-16748-1-git-send-email-thunder.leizhen@huawei.com>
 <1533558424-16748-6-git-send-email-thunder.leizhen@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c46fa263-2dfa-b8fc-b2c1-0b1bf6029748@arm.com>
Date:   Thu, 9 Aug 2018 12:08:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533558424-16748-6-git-send-email-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/18 13:27, Zhen Lei wrote:
> Add a bootup option to make the system manager can choose which mode to
> be used. The default mode is strict.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
>   drivers/iommu/arm-smmu-v3.c                     | 17 ++++++++++++++++-
>   2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 533ff5c..426e989 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1720,6 +1720,15 @@
>   		nobypass	[PPC/POWERNV]
>   			Disable IOMMU bypass, using IOMMU for PCI devices.
> 
> +	arm_iommu=	[ARM64]
> +		non-strict	[Default Off]

Again, I'd much rather have "iommu.non_strict= { "0" | "1" }" in line 
with the passthrough option.

Robin.

> +			Put off TLBs invalidation and release memory first.
> +			It's good for scatter-gather performance but lacks full
> +			isolation, an untrusted device can access the reused
> +			memory because the TLBs may still valid. Please take
> +			full consideration before choosing this mode.
> +			Note that, VFIO will always use strict mode.
> +
>   	iommu.passthrough=
>   			[ARM64] Configure DMA to bypass the IOMMU by default.
>   			Format: { "0" | "1" }
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 904bc1e..9a30892 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -631,6 +631,21 @@ struct arm_smmu_option_prop {
>   	{ 0, NULL},
>   };
> 
> +static u32 smmu_non_strict __read_mostly;
> +
> +static int __init arm_smmu_setup(char *str)
> +{
> +	if (!strncmp(str, "non-strict", 10)) {
> +		smmu_non_strict = 1;
> +		pr_warn("WARNING: iommu non-strict mode is chosen.\n"
> +			"It's good for scatter-gather performance but lacks full isolation\n");
> +		add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
> +	}
> +
> +	return 0;
> +}
> +early_param("arm_iommu", arm_smmu_setup);
> +
>   static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
>   						 struct arm_smmu_device *smmu)
>   {
> @@ -1622,7 +1637,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
>   	if (smmu->features & ARM_SMMU_FEAT_COHERENCY)
>   		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
> 
> -	if (domain->type == IOMMU_DOMAIN_DMA) {
> +	if ((domain->type == IOMMU_DOMAIN_DMA) && smmu_non_strict) {
>   		domain->non_strict = 1;
>   		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
>   	}
> --
> 1.8.3
> 
> 
