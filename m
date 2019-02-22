Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B416C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6DA2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfBVO36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:29:58 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33270 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfBVO34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:29:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C4D8A78;
        Fri, 22 Feb 2019 06:29:56 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 516DF3F690;
        Fri, 22 Feb 2019 06:29:55 -0800 (PST)
Subject: Re: [PATCH 7/7] iommu/ipmmu-vmsa: Add suspend/resume support
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>
Cc:     linux-renesas-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org
References: <20190220150531.2462-1-geert+renesas@glider.be>
 <20190220150531.2462-8-geert+renesas@glider.be>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3b661f22-4586-1806-140b-1b23806f7eda@arm.com>
Date:   Fri, 22 Feb 2019 14:29:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190220150531.2462-8-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 20/02/2019 15:05, Geert Uytterhoeven wrote:
> During PSCI system suspend, R-Car Gen3 SoCs are powered down, and all
> IPMMU state is lost.  Hence after s2ram, devices wired behind an IPMMU,
> and configured to use it, will see their DMA operations hang.
> 
> To fix this, restore all IPMMU contexts, and re-enable all active
> micro-TLBs during system resume.
> 
> To avoid overhead on platforms not needing it, the resume code has a
> build time dependency on sleep and PSCI support, and a runtime
> dependency on PSCI.

Frankly, that aspect looks horribly hacky. It's not overly reasonable 
for random device drivers to be poking at PSCI internals, and while it 
might happen to correlate on some known set of current SoCs with current 
firmware, in general it's really too fragile to be accurate:

- Firmware is free to implement suspend callbacks in a way which doesn't 
actually lose power.
- Support for CPU_SUSPEND does not imply that SYSTEM_SUSPEND is even 
implemented, let alone how it might behave.
- The dev_pm_ops callbacks can also be used for hibernate, wherein it 
doesn't really matter what the firmware may or may not do if the user 
has pulled the plug and resumed us a week later.

Furthermore, I think any attempt to detect whether you need to resume or 
not is inherently fraught with danger - from testing the arm-smmu 
runtime PM ops, I've seen register state take a surprisingly long time 
to decay in a switched-off power domain, to the point where unless you 
check every bit of every register you can't necessarily be certain that 
they're really all still valid, and by that point you're doing far more 
work than just unconditionally reinitialising the whole state anyway. 
Upon resuming from hibernate, the state left by the cold-boot stage 
almost certainly *will* be valid, but it probably won't be the state you 
actually want.

Really, the whole idea smells of the premature optimisation demons 
anyway - is the resume overhead measurably significant?

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This patch takes a different approach than the BSP, which implements a
> bulk save/restore of all registers during system suspend/resume.
> 
>   drivers/iommu/ipmmu-vmsa.c | 52 +++++++++++++++++++++++++++++++++++++-
>   1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 92a766dd8b459f0c..5d22139914e8f033 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -22,6 +22,7 @@
>   #include <linux/of_iommu.h>
>   #include <linux/of_platform.h>
>   #include <linux/platform_device.h>
> +#include <linux/psci.h>
>   #include <linux/sizes.h>
>   #include <linux/slab.h>
>   #include <linux/sys_soc.h>
> @@ -36,7 +37,10 @@
>   #define arm_iommu_detach_device(...)	do {} while (0)
>   #endif
>   
> -#define IPMMU_CTX_MAX 8U
> +#define IPMMU_CTX_MAX		8U
> +#define IPMMU_CTX_INVALID	-1
> +
> +#define IPMMU_UTLB_MAX		48U
>   
>   struct ipmmu_features {
>   	bool use_ns_alias_offset;
> @@ -58,6 +62,7 @@ struct ipmmu_vmsa_device {
>   	spinlock_t lock;			/* Protects ctx and domains[] */
>   	DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
>   	struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
> +	s8 utlb_ctx[IPMMU_UTLB_MAX];
>   
>   	struct iommu_group *group;
>   	struct dma_iommu_mapping *mapping;
> @@ -335,6 +340,7 @@ static void ipmmu_utlb_enable(struct ipmmu_vmsa_domain *domain,
>   	ipmmu_write(mmu, IMUCTR(utlb),
>   		    IMUCTR_TTSEL_MMU(domain->context_id) | IMUCTR_FLUSH |
>   		    IMUCTR_MMUEN);
> +	mmu->utlb_ctx[utlb] = domain->context_id;
>   }
>   
>   /*
> @@ -346,6 +352,7 @@ static void ipmmu_utlb_disable(struct ipmmu_vmsa_domain *domain,
>   	struct ipmmu_vmsa_device *mmu = domain->mmu;
>   
>   	ipmmu_write(mmu, IMUCTR(utlb), 0);
> +	mmu->utlb_ctx[utlb] = IPMMU_CTX_INVALID;
>   }
>   
>   static void ipmmu_tlb_flush_all(void *cookie)
> @@ -1043,6 +1050,7 @@ static int ipmmu_probe(struct platform_device *pdev)
>   	spin_lock_init(&mmu->lock);
>   	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
>   	mmu->features = of_device_get_match_data(&pdev->dev);
> +	memset(mmu->utlb_ctx, IPMMU_CTX_INVALID, mmu->features->num_utlbs);
>   	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
>   
>   	/* Map I/O memory and request IRQ. */
> @@ -1158,10 +1166,52 @@ static int ipmmu_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM_PSCI_FW)
> +static int ipmmu_resume_noirq(struct device *dev)
> +{
> +	struct ipmmu_vmsa_device *mmu = dev_get_drvdata(dev);
> +	unsigned int i;
> +
> +	/* This is the best we can do to check for the presence of PSCI */
> +	if (!psci_ops.cpu_suspend)
> +		return 0;
> +
> +	/* Reset root MMU and restore contexts */
> +	if (ipmmu_is_root(mmu)) {
> +		ipmmu_device_reset(mmu);
> +
> +		for (i = 0; i < mmu->num_ctx; i++) {
> +			if (!mmu->domains[i])
> +				continue;
> +
> +			ipmmu_context_init(mmu->domains[i]);
> +		}

Unless the hardware has some programming sequence requirement, it looks 
like it could be a little more efficient to roll this logic into 
ipmmu_device_reset() itself such that no IMCR gets written twice, much 
like I did with arm_smmu_write_context_bank()/arm-smmu_device_reset().

Robin.

> +	}
> +
> +	/* Re-enable active micro-TLBs */
> +	for (i = 0; i < mmu->features->num_utlbs; i++) {
> +		if (mmu->utlb_ctx[i] == IPMMU_CTX_INVALID)
> +			continue;
> +
> +		ipmmu_utlb_enable(mmu->root->domains[mmu->utlb_ctx[i]], i);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops ipmmu_pm  = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, ipmmu_resume_noirq)
> +};
> +#define DEV_PM_OPS	&ipmmu_pm
> +#else
> +#define DEV_PM_OPS	NULL
> +#endif /* CONFIG_PM_SLEEP && CONFIG_ARM_PSCI_FW */
> +
>   static struct platform_driver ipmmu_driver = {
>   	.driver = {
>   		.name = "ipmmu-vmsa",
>   		.of_match_table = of_match_ptr(ipmmu_of_ids),
> +		.pm = DEV_PM_OPS,
>   	},
>   	.probe = ipmmu_probe,
>   	.remove	= ipmmu_remove,
> 
