Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A085EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716C22147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FenfkPDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfBTPfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:35:40 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:42176 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfBTPfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:35:39 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 759AC2D1;
        Wed, 20 Feb 2019 16:35:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1550676937;
        bh=wG+g31GiUc4JVZIGRc/sSbALzRZekWDi60DOT4brgOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FenfkPDAPQEMixguEcfCcYYTF4dzqqa8I7KSreI/xvJDrbdz6rV6E4Teg2eA3DsVr
         Qcwh62TcEpE5N2LppCtQWHbs7D2Ex5oPLpXsIywU8hMOyMccUXscDmd/vDidI2FAp7
         RfNzo/b8w+Dpt3/6nh4+J8CzmnLxSKp2NuLR12ys=
Date:   Wed, 20 Feb 2019 17:35:33 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] iommu/ipmmu-vmsa: Extract hardware context
 initialization
Message-ID: <20190220153533.GH3516@pendragon.ideasonboard.com>
References: <20190220150531.2462-1-geert+renesas@glider.be>
 <20190220150531.2462-7-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190220150531.2462-7-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wed, Feb 20, 2019 at 04:05:30PM +0100, Geert Uytterhoeven wrote:
> ipmmu_domain_init_context() takes care of (1) initializing the software
> domain, and (2) initializing the hardware context for the domain.
> 
> Extract the code to initialize the hardware context into a new subroutine
> ipmmu_context_init(), to prepare for later reuse.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 91 ++++++++++++++++++++------------------
>  1 file changed, 48 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 0a21e734466eb1bd..92a766dd8b459f0c 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -404,52 +404,10 @@ static void ipmmu_domain_free_context(struct ipmmu_vmsa_device *mmu,
>  	spin_unlock_irqrestore(&mmu->lock, flags);
>  }
>  
> -static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
> +static void ipmmu_context_init(struct ipmmu_vmsa_domain *domain)

ipmmu_context_init() vs. ipmmmu_domain_init_context() is confusing. You
could call this one ipmmu_domain_setup_context() maybe ?

>  {
>  	u64 ttbr;
>  	u32 tmp;
> -	int ret;
> -
> -	/*
> -	 * Allocate the page table operations.
> -	 *
> -	 * VMSA states in section B3.6.3 "Control of Secure or Non-secure memory
> -	 * access, Long-descriptor format" that the NStable bit being set in a
> -	 * table descriptor will result in the NStable and NS bits of all child
> -	 * entries being ignored and considered as being set. The IPMMU seems
> -	 * not to comply with this, as it generates a secure access page fault
> -	 * if any of the NStable and NS bits isn't set when running in
> -	 * non-secure mode.
> -	 */
> -	domain->cfg.quirks = IO_PGTABLE_QUIRK_ARM_NS;
> -	domain->cfg.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K;
> -	domain->cfg.ias = 32;
> -	domain->cfg.oas = 40;
> -	domain->cfg.tlb = &ipmmu_gather_ops;
> -	domain->io_domain.geometry.aperture_end = DMA_BIT_MASK(32);
> -	domain->io_domain.geometry.force_aperture = true;
> -	/*
> -	 * TODO: Add support for coherent walk through CCI with DVM and remove
> -	 * cache handling. For now, delegate it to the io-pgtable code.
> -	 */
> -	domain->cfg.iommu_dev = domain->mmu->root->dev;
> -
> -	/*
> -	 * Find an unused context.
> -	 */
> -	ret = ipmmu_domain_allocate_context(domain->mmu->root, domain);
> -	if (ret < 0)
> -		return ret;
> -
> -	domain->context_id = ret;
> -
> -	domain->iop = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &domain->cfg,
> -					   domain);
> -	if (!domain->iop) {
> -		ipmmu_domain_free_context(domain->mmu->root,
> -					  domain->context_id);
> -		return -EINVAL;
> -	}
>  
>  	/* TTBR0 */
>  	ttbr = domain->cfg.arm_lpae_s1_cfg.ttbr[0];
> @@ -495,7 +453,54 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
>  	 */
>  	ipmmu_ctx_write_all(domain, IMCTR,
>  			    IMCTR_INTEN | IMCTR_FLUSH | IMCTR_MMUEN);
> +}
> +
> +static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
> +{
> +	int ret;
> +
> +	/*
> +	 * Allocate the page table operations.
> +	 *
> +	 * VMSA states in section B3.6.3 "Control of Secure or Non-secure memory
> +	 * access, Long-descriptor format" that the NStable bit being set in a
> +	 * table descriptor will result in the NStable and NS bits of all child
> +	 * entries being ignored and considered as being set. The IPMMU seems
> +	 * not to comply with this, as it generates a secure access page fault
> +	 * if any of the NStable and NS bits isn't set when running in
> +	 * non-secure mode.
> +	 */
> +	domain->cfg.quirks = IO_PGTABLE_QUIRK_ARM_NS;
> +	domain->cfg.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K;
> +	domain->cfg.ias = 32;
> +	domain->cfg.oas = 40;
> +	domain->cfg.tlb = &ipmmu_gather_ops;
> +	domain->io_domain.geometry.aperture_end = DMA_BIT_MASK(32);
> +	domain->io_domain.geometry.force_aperture = true;
> +	/*
> +	 * TODO: Add support for coherent walk through CCI with DVM and remove
> +	 * cache handling. For now, delegate it to the io-pgtable code.
> +	 */
> +	domain->cfg.iommu_dev = domain->mmu->root->dev;
> +
> +	/*
> +	 * Find an unused context.
> +	 */
> +	ret = ipmmu_domain_allocate_context(domain->mmu->root, domain);
> +	if (ret < 0)
> +		return ret;
> +
> +	domain->context_id = ret;
> +
> +	domain->iop = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &domain->cfg,
> +					   domain);
> +	if (!domain->iop) {
> +		ipmmu_domain_free_context(domain->mmu->root,
> +					  domain->context_id);
> +		return -EINVAL;
> +	}
>  
> +	ipmmu_context_init(domain);
>  	return 0;
>  }
>  

-- 
Regards,

Laurent Pinchart
