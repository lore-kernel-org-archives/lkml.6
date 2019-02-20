Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEE7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2EA20880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hKIZgyEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfBTPbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:31:04 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:42124 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBTPbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:31:03 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7D1392D1;
        Wed, 20 Feb 2019 16:31:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1550676661;
        bh=GqxeuJFbeTzGILdrnIayvVM4Pw2sI2xaNjheL8cab70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hKIZgyEob6d61sdjQ0av87TifVZgKVd9/zxItCbU23uByfqIfo1c8F7i5MBuZsG5n
         E+kuzm8iWagj56Xb0SkhBbmgSH5xuuw/cMegbIiYpKoIumzkKSl3GDeZgyj2DvUr/u
         F/Hs3rCiZk05BlU6qL/R3aJNvedprZCQgLa7RZME=
Date:   Wed, 20 Feb 2019 17:30:57 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] iommu/ipmmu-vmsa: Prepare to handle 40-bit error
 addresses
Message-ID: <20190220153057.GF3516@pendragon.ideasonboard.com>
References: <20190220150531.2462-1-geert+renesas@glider.be>
 <20190220150531.2462-4-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190220150531.2462-4-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wed, Feb 20, 2019 at 04:05:27PM +0100, Geert Uytterhoeven wrote:
> On R-Car Gen3, the faulting virtual address is a 40-bit address, and
> comprised of two registers.  Read the upper address part, and combine
> both parts, when running on a 64-bit system.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Apart from this, the driver doesn't support 40-bit IOVA addresses yet.
> ---
>  drivers/iommu/ipmmu-vmsa.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index ac70cb967ff821c6..4d07c26c97848b65 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -186,7 +186,9 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
>  #define IMMAIR_ATTR_IDX_WBRWA		1
>  #define IMMAIR_ATTR_IDX_DEV		2
>  
> -#define IMEAR				0x0030
> +#define IMEAR				0x0030	/* R-Car Gen2 */
> +#define IMELAR				IMEAR	/* R-Car Gen3 */

I would have defined that as a single macro.

> +#define IMEUAR				0x0034	/* R-Car Gen3 */
>  
>  #define IMPCTR				0x0200
>  #define IMPSTR				0x0208
> @@ -521,14 +523,16 @@ static irqreturn_t ipmmu_domain_irq(struct ipmmu_vmsa_domain *domain)
>  {
>  	const u32 err_mask = IMSTR_MHIT | IMSTR_ABORT | IMSTR_PF | IMSTR_TF;
>  	struct ipmmu_vmsa_device *mmu = domain->mmu;
> +	unsigned long iova;

Isn't there a more appropriate type, such as dma_addr_t possibly ?

>  	u32 status;
> -	u32 iova;
>  
>  	status = ipmmu_ctx_read_root(domain, IMSTR);
>  	if (!(status & err_mask))
>  		return IRQ_NONE;
>  
> -	iova = ipmmu_ctx_read_root(domain, IMEAR);
> +	iova = ipmmu_ctx_read_root(domain, IMELAR);
> +	if (IS_ENABLED(CONFIG_64BIT))
> +		iova |= (u64)ipmmu_ctx_read_root(domain, IMEUAR) << 32;
>  
>  	/*
>  	 * Clear the error status flags. Unlike traditional interrupt flag
> @@ -540,10 +544,10 @@ static irqreturn_t ipmmu_domain_irq(struct ipmmu_vmsa_domain *domain)
>  
>  	/* Log fatal errors. */
>  	if (status & IMSTR_MHIT)
> -		dev_err_ratelimited(mmu->dev, "Multiple TLB hits @0x%08x\n",
> +		dev_err_ratelimited(mmu->dev, "Multiple TLB hits @0x%lx\n",
>  				    iova);
>  	if (status & IMSTR_ABORT)
> -		dev_err_ratelimited(mmu->dev, "Page Table Walk Abort @0x%08x\n",
> +		dev_err_ratelimited(mmu->dev, "Page Table Walk Abort @0x%lx\n",
>  				    iova);
>  
>  	if (!(status & (IMSTR_PF | IMSTR_TF)))
> @@ -559,7 +563,7 @@ static irqreturn_t ipmmu_domain_irq(struct ipmmu_vmsa_domain *domain)
>  		return IRQ_HANDLED;
>  
>  	dev_err_ratelimited(mmu->dev,
> -			    "Unhandled fault: status 0x%08x iova 0x%08x\n",
> +			    "Unhandled fault: status 0x%08x iova 0x%lx\n",
>  			    status, iova);
>  
>  	return IRQ_HANDLED;

-- 
Regards,

Laurent Pinchart
