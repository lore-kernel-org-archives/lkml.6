Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712C0C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D0F2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D0F2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeKBPaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 11:30:10 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:29113 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728216AbeKBPaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 11:30:10 -0400
X-UUID: 6b12abb8b9ac4d2bad30475a6e34a0e8-20181102
X-UUID: 6b12abb8b9ac4d2bad30475a6e34a0e8-20181102
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1385027127; Fri, 02 Nov 2018 14:23:58 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 2 Nov
 2018 14:23:56 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 2 Nov 2018 14:23:55 +0800
Message-ID: <1541139835.22369.12.camel@mhfsdcap03>
Subject: Re: [PATCH v2 05/14] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB
 Mode
From:   Yong Wu <yong.wu@mediatek.com>
To:     Robin Murphy <Robin.Murphy@arm.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Daniel Kurtz <djkurtz@google.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "yingjoe.chen@mediatek.com" <yingjoe.chen@mediatek.com>,
        "youlin.pei@mediatek.com" <youlin.pei@mediatek.com>,
        nd <nd@arm.com>
Date:   Fri, 2 Nov 2018 14:23:55 +0800
In-Reply-To: <2033be12-3d32-3155-4202-386281cbbaa0@arm.com>
References: <1537779534-23575-1-git-send-email-yong.wu@mediatek.com>
         <1537779534-23575-6-git-send-email-yong.wu@mediatek.com>
         <2033be12-3d32-3155-4202-386281cbbaa0@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-01 at 16:35 +0000, Robin Murphy wrote:
> On 24/09/2018 09:58, Yong Wu wrote:
> > MediaTek extend the arm v7s descriptor to support the dram over 4GB.
> > 
> > In the mt2712 and mt8173, it's called "4GB mode", the physical address
> > is from 0x4000_0000 to 0x1_3fff_ffff, but from EMI point of view, it
> > is remapped to high address from 0x1_0000_0000 to 0x1_ffff_ffff, the
> > bit32 is always enabled. thus, in the M4U, we always enable the bit9
> > for all PTEs which means to enable bit32 of physical address.
> > 
> > but in mt8183, M4U support the dram from 0x4000_0000 to 0x3_ffff_ffff
> > which isn't remaped. We extend the PTEs: the bit9 represent bit32 of
> > PA and the bit4 represent bit33 of PA. Meanwhile the iova still is
> > 32bits.
> > 
> > In order to unify code, in the "4GB mode", we add the bit32 for the
> > physical address manually in our driver.
> > 
> > Correspondingly, Adding bit32 and bit33 for the PA in the iova_to_phys
> > has to been moved into v7s.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/iommu/io-pgtable-arm-v7s.c | 34 +++++++++++++++++++++++++++-------
> >   drivers/iommu/io-pgtable.h         |  7 +++----
> >   drivers/iommu/mtk_iommu.c          | 16 ++++++++++------
> >   drivers/iommu/mtk_iommu.h          |  1 +
> >   4 files changed, 41 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> > index fa3b9ec..3679a5f 100644
> > --- a/drivers/iommu/io-pgtable-arm-v7s.c
> > +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> > @@ -124,7 +124,9 @@
> >   #define ARM_V7S_TEX_MASK		0x7
> >   #define ARM_V7S_ATTR_TEX(val)		(((val) & ARM_V7S_TEX_MASK) << ARM_V7S_TEX_SHIFT)
> >   
> > -#define ARM_V7S_ATTR_MTK_4GB		BIT(9) /* MTK extend it for 4GB mode */
> > +/* MediaTek extend the two bits below for over 4GB mode */
> > +#define ARM_V7S_ATTR_MTK_PA_BIT32	BIT(9)
> > +#define ARM_V7S_ATTR_MTK_PA_BIT33	BIT(4)
> >   
> >   /* *well, except for TEX on level 2 large pages, of course :( */
> >   #define ARM_V7S_CONT_PAGE_TEX_SHIFT	6
> > @@ -183,13 +185,24 @@ static dma_addr_t __arm_v7s_dma_addr(void *pages)
> >   static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
> >   				    struct arm_v7s_io_pgtable *data)
> >   {
> > -	return paddr & ARM_V7S_LVL_MASK(lvl);
> > +	arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
> > +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> > +
> > +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
> > +		if (paddr & BIT_ULL(32))
> > +			pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
> > +		if (paddr & BIT_ULL(33))
> > +			pte |= ARM_V7S_ATTR_MTK_PA_BIT33;
> > +	}
> > +	return pte;
> >   }
> >   
> >   static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
> >   				  struct arm_v7s_io_pgtable *data)
> >   {
> > +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> >   	arm_v7s_iopte mask;
> > +	phys_addr_t paddr;
> >   
> >   	if (ARM_V7S_PTE_IS_TABLE(pte, lvl))
> >   		mask = ARM_V7S_TABLE_MASK;
> > @@ -198,7 +211,15 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
> >   	else
> >   		mask = ARM_V7S_LVL_MASK(lvl);
> >   
> > -	return pte & mask;
> > +	paddr = pte & mask;
> > +	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT) &&
> 
> I don't think we need this IS_ENABLED() check - we don't have one in the 
> equivalent paddr_to_iopte() case above, and what it's protecting is 
> clearly a no-op anyway when paddr has a 32-bit type (a GCC 7 build for 
> non-LPAE arch/arm doesn't complain with the check removed).

OK.I will delete IS_ENABLED here.
Thanks.

> 
> Other than that, though, the rest looks good now;
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> > +	    cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
> > +		if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
> > +			paddr |= BIT_ULL(32);
> > +		if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
> > +			paddr |= BIT_ULL(33);
> > +	}
> > +	return paddr;
> >   }
> >   
> >   static arm_v7s_iopte *iopte_deref(arm_v7s_iopte pte, int lvl,
> > @@ -315,9 +336,6 @@ static arm_v7s_iopte arm_v7s_prot_to_pte(int prot, int lvl,
> >   	if (lvl == 1 && (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS))
> >   		pte |= ARM_V7S_ATTR_NS_SECTION;
> >   
> > -	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)
> > -		pte |= ARM_V7S_ATTR_MTK_4GB;
> > -
> >   	return pte;
> >   }
> >   
> > @@ -504,7 +522,9 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
> >   	if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
> >   		return 0;
> >   
> > -	if (WARN_ON(upper_32_bits(iova) || upper_32_bits(paddr)))
> > +	if (WARN_ON(upper_32_bits(iova)) ||
> > +	    WARN_ON(upper_32_bits(paddr) &&
> > +		    !(iop->cfg.quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)))
> >   		return -ERANGE;
> >   
> >   	ret = __arm_v7s_map(data, iova, paddr, size, prot, 1, data->pgd);
> > diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> > index 2df7909..ee7beb5 100644
> > --- a/drivers/iommu/io-pgtable.h
> > +++ b/drivers/iommu/io-pgtable.h
> > @@ -62,10 +62,9 @@ struct io_pgtable_cfg {
> >   	 *	(unmapped) entries but the hardware might do so anyway, perform
> >   	 *	TLB maintenance when mapping as well as when unmapping.
> >   	 *
> > -	 * IO_PGTABLE_QUIRK_ARM_MTK_4GB: (ARM v7s format) Set bit 9 in all
> > -	 *	PTEs, for Mediatek IOMMUs which treat it as a 33rd address bit
> > -	 *	when the SoC is in "4GB mode" and they can only access the high
> > -	 *	remap of DRAM (0x1_00000000 to 0x1_ffffffff).
> > +	 * IO_PGTABLE_QUIRK_ARM_MTK_4GB: (ARM v7s format) MediaTek IOMMUs extend
> > +	 *	to support up to 34 bits PA where the bit32 and bit33 are
> > +	 *	encoded in the bit9 and bit4 of the PTE respectively.
> >   	 *
> >   	 * IO_PGTABLE_QUIRK_NO_DMA: Guarantees that the tables will only ever
> >   	 *	be accessed by a fully cache-coherent IOMMU or CPU (e.g. for a
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index c0e2da5..84a12ed 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -367,12 +367,18 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
> >   			 phys_addr_t paddr, size_t size, int prot)
> >   {
> >   	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> > +	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
> >   	unsigned long flags;
> >   	int ret;
> >   
> > +	/* The "4GB mode" M4U physically can not use the lower remap of Dram. */
> > +	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT) &&
> > +	    data->plat_data->has_4gb_mode &&
> > +	    data->enable_4GB)
> > +		paddr |= BIT_ULL(32);
> > +
> >   	spin_lock_irqsave(&dom->pgtlock, flags);
> > -	ret = dom->iop->map(dom->iop, iova, paddr & DMA_BIT_MASK(32),
> > -			    size, prot);
> > +	ret = dom->iop->map(dom->iop, iova, paddr, size, prot);
> >   	spin_unlock_irqrestore(&dom->pgtlock, flags);
> >   
> >   	return ret;
> > @@ -401,7 +407,6 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
> >   					  dma_addr_t iova)
> >   {
> >   	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> > -	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
> >   	unsigned long flags;
> >   	phys_addr_t pa;
> >   
> > @@ -409,9 +414,6 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
> >   	pa = dom->iop->iova_to_phys(dom->iop, iova);
> >   	spin_unlock_irqrestore(&dom->pgtlock, flags);
> >   
> > -	if (data->enable_4GB)
> > -		pa |= BIT_ULL(32);
> > -
> >   	return pa;
> >   }
> >   
> > @@ -735,10 +737,12 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
> >   
> >   static const struct mtk_iommu_plat_data mt2712_data = {
> >   	.m4u_plat = M4U_MT2712,
> > +	.has_4gb_mode = true,
> >   };
> >   
> >   static const struct mtk_iommu_plat_data mt8173_data = {
> >   	.m4u_plat = M4U_MT8173,
> > +	.has_4gb_mode = true,
> >   };
> >   
> >   static const struct of_device_id mtk_iommu_of_ids[] = {
> > diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> > index 333a0ef..a243047 100644
> > --- a/drivers/iommu/mtk_iommu.h
> > +++ b/drivers/iommu/mtk_iommu.h
> > @@ -43,6 +43,7 @@ enum mtk_iommu_plat {
> >   
> >   struct mtk_iommu_plat_data {
> >   	enum mtk_iommu_plat m4u_plat;
> > +	bool has_4gb_mode;
> >   };
> >   
> >   struct mtk_iommu_domain;
> > 


