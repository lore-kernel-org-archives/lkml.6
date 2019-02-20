Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F16AC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3500B2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wUa+lG4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfBTPmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:42:43 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:42226 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfBTPmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:42:43 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 460172D1;
        Wed, 20 Feb 2019 16:42:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1550677360;
        bh=5eChLWb0yK50enMDGcVOLW2Y4hPzxceg/XJQ/kRGbjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wUa+lG4xE4TaMRFLE8kVDbHYXq4lO7kGYPNnH2UUH7mKH2U1BD+PsTLdiankKUrHz
         Hnm8Dxs5iGdxFvekoo35nFxLducDe3g9eOpWf7r4QEa0RUaYBEOn7as3yvABLoScO2
         Y+E++6RJWX4mw2I17QsCtt8GFhRIezVJk2jbHOp0=
Date:   Wed, 20 Feb 2019 17:42:36 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] iommu/ipmmu-vmsa: Add suspend/resume support
Message-ID: <20190220154236.GI3516@pendragon.ideasonboard.com>
References: <20190220150531.2462-1-geert+renesas@glider.be>
 <20190220150531.2462-8-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190220150531.2462-8-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wed, Feb 20, 2019 at 04:05:31PM +0100, Geert Uytterhoeven wrote:
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
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This patch takes a different approach than the BSP, which implements a
> bulk save/restore of all registers during system suspend/resume.

I like this approach better too.

>  drivers/iommu/ipmmu-vmsa.c | 52 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 92a766dd8b459f0c..5d22139914e8f033 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_iommu.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/psci.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/sys_soc.h>
> @@ -36,7 +37,10 @@
>  #define arm_iommu_detach_device(...)	do {} while (0)
>  #endif
>  
> -#define IPMMU_CTX_MAX 8U
> +#define IPMMU_CTX_MAX		8U
> +#define IPMMU_CTX_INVALID	-1
> +
> +#define IPMMU_UTLB_MAX		48U
>  
>  struct ipmmu_features {
>  	bool use_ns_alias_offset;
> @@ -58,6 +62,7 @@ struct ipmmu_vmsa_device {
>  	spinlock_t lock;			/* Protects ctx and domains[] */
>  	DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
>  	struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
> +	s8 utlb_ctx[IPMMU_UTLB_MAX];

How about making this a bitmask instead to save memory ? I would also
rename it as utlb_ctx doesn't really carry the meaning of the field,
whose purpose is to store whether the µTLB is enabled or disabled.

>  
>  	struct iommu_group *group;
>  	struct dma_iommu_mapping *mapping;
> @@ -335,6 +340,7 @@ static void ipmmu_utlb_enable(struct ipmmu_vmsa_domain *domain,
>  	ipmmu_write(mmu, IMUCTR(utlb),
>  		    IMUCTR_TTSEL_MMU(domain->context_id) | IMUCTR_FLUSH |
>  		    IMUCTR_MMUEN);
> +	mmu->utlb_ctx[utlb] = domain->context_id;
>  }
>  
>  /*
> @@ -346,6 +352,7 @@ static void ipmmu_utlb_disable(struct ipmmu_vmsa_domain *domain,
>  	struct ipmmu_vmsa_device *mmu = domain->mmu;
>  
>  	ipmmu_write(mmu, IMUCTR(utlb), 0);
> +	mmu->utlb_ctx[utlb] = IPMMU_CTX_INVALID;
>  }
>  
>  static void ipmmu_tlb_flush_all(void *cookie)
> @@ -1043,6 +1050,7 @@ static int ipmmu_probe(struct platform_device *pdev)
>  	spin_lock_init(&mmu->lock);
>  	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
>  	mmu->features = of_device_get_match_data(&pdev->dev);
> +	memset(mmu->utlb_ctx, IPMMU_CTX_INVALID, mmu->features->num_utlbs);
>  	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
>  
>  	/* Map I/O memory and request IRQ. */
> @@ -1158,10 +1166,52 @@ static int ipmmu_remove(struct platform_device *pdev)
>  	return 0;
>  }
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

PSCI suspend disabling power to the SoC completely may be a common
behaviour on our development boards, but isn't mandated by the PSCI
specification if I'm not mistaken. Is there a way to instead detect that
power has been lost, perhaps by checking whether a register has been
reset to its default value ?

> +
> +	/* Reset root MMU and restore contexts */

I think the rest of the code adds a period at the end of sentences in
comments.

> +	if (ipmmu_is_root(mmu)) {
> +		ipmmu_device_reset(mmu);
> +
> +		for (i = 0; i < mmu->num_ctx; i++) {
> +			if (!mmu->domains[i])
> +				continue;
> +
> +			ipmmu_context_init(mmu->domains[i]);
> +		}
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
>  static struct platform_driver ipmmu_driver = {
>  	.driver = {
>  		.name = "ipmmu-vmsa",
>  		.of_match_table = of_match_ptr(ipmmu_of_ids),
> +		.pm = DEV_PM_OPS,

I would have used conditional compilation here instead of using a
DEV_PM_OPS macro, as I think the macro decreases readability (and also
given how its generic name could later conflict with something else).

>  	},
>  	.probe = ipmmu_probe,
>  	.remove	= ipmmu_remove,

-- 
Regards,

Laurent Pinchart
