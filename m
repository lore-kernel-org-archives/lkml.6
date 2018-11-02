Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACE1C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F402081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F402081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeKBP3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 11:29:51 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:48641 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728216AbeKBP3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 11:29:51 -0400
X-UUID: fc0a81c35ad34fb0b350d9b5f9fe4757-20181102
X-UUID: fc0a81c35ad34fb0b350d9b5f9fe4757-20181102
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1177744751; Fri, 02 Nov 2018 14:23:33 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 2 Nov
 2018 14:23:32 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 2 Nov 2018 14:23:31 +0800
Message-ID: <1541139811.22369.11.camel@mhfsdcap03>
Subject: Re: [PATCH v2 04/14] iommu/io-pgtable-arm-v7s: Add paddr_to_iopte
 and iopte_to_paddr helpers
From:   Yong Wu <yong.wu@mediatek.com>
To:     Robin Murphy <Robin.Murphy@arm.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "youlin.pei@mediatek.com" <youlin.pei@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Kurtz <djkurtz@google.com>,
        "yingjoe.chen@mediatek.com" <yingjoe.chen@mediatek.com>,
        nd <nd@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 2 Nov 2018 14:23:31 +0800
In-Reply-To: <d24bd2a4-1030-e255-b339-d02eadc93f28@arm.com>
References: <1537779534-23575-1-git-send-email-yong.wu@mediatek.com>
         <1537779534-23575-5-git-send-email-yong.wu@mediatek.com>
         <d24bd2a4-1030-e255-b339-d02eadc93f28@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Thanks very much for your review.

On Thu, 2018-11-01 at 16:34 +0000, Robin Murphy wrote:
> [ apologies if anyone gets this twice, looks like our email's eaten 
> itself again... ]
> 
> On 24/09/2018 09:58, Yong Wu wrote:
> > Add two helper functions: paddr_to_iopte and iopte_to_paddr.
> 
> Nice and tidy! (although it will need rebasing now, but I think that's 
> just context conflicts)
> 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/iommu/io-pgtable-arm-v7s.c | 45 ++++++++++++++++++++++++++++----------
> >   1 file changed, 33 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> > index b5948ba..fa3b9ec 100644
> > --- a/drivers/iommu/io-pgtable-arm-v7s.c
> > +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> > @@ -173,18 +173,38 @@ struct arm_v7s_io_pgtable {
> >   	spinlock_t		split_lock;
> >   };
> >   
> > +static bool arm_v7s_pte_is_cont(arm_v7s_iopte pte, int lvl);
> > +
> >   static dma_addr_t __arm_v7s_dma_addr(void *pages)
> >   {
> >   	return (dma_addr_t)virt_to_phys(pages);
> >   }
> >   
> > -static arm_v7s_iopte *iopte_deref(arm_v7s_iopte pte, int lvl)
> > +static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
> > +				    struct arm_v7s_io_pgtable *data)
> 
> Nit: it seems to work out a little cleaner if we pass the io_pgtable_cfg 
> to these helpers directly, rather than re-deriving it from data each time.

I will use "io_pgtable_cfg" instead of "arm_v7s_io_pgtable" in the next
version. This is a minor change and I will keep your R-b.

> 
> Otherwise, though,
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> >   {
> > +	return paddr & ARM_V7S_LVL_MASK(lvl);
> > +}
> > +
> > +static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
> > +				  struct arm_v7s_io_pgtable *data)
> > +{
> > +	arm_v7s_iopte mask;
> > +
> >   	if (ARM_V7S_PTE_IS_TABLE(pte, lvl))
> > -		pte &= ARM_V7S_TABLE_MASK;
> > +		mask = ARM_V7S_TABLE_MASK;
> > +	else if (arm_v7s_pte_is_cont(pte, lvl))
> > +		mask = ARM_V7S_LVL_MASK(lvl) * ARM_V7S_CONT_PAGES;
> >   	else
> > -		pte &= ARM_V7S_LVL_MASK(lvl);
> > -	return phys_to_virt(pte);
> > +		mask = ARM_V7S_LVL_MASK(lvl);
> > +
> > +	return pte & mask;
> > +}
> > +
> > +static arm_v7s_iopte *iopte_deref(arm_v7s_iopte pte, int lvl,
> > +				  struct arm_v7s_io_pgtable *data)
> > +{
> > +	return phys_to_virt(iopte_to_paddr(pte, lvl, data));
> >   }
> >   
> >   static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
> > @@ -396,7 +416,7 @@ static int arm_v7s_init_pte(struct arm_v7s_io_pgtable *data,
> >   	if (num_entries > 1)
> >   		pte = arm_v7s_pte_to_cont(pte, lvl);
> >   
> > -	pte |= paddr & ARM_V7S_LVL_MASK(lvl);
> > +	pte |= paddr_to_iopte(paddr, lvl, data);
> >   
> >   	__arm_v7s_set_pte(ptep, pte, num_entries, cfg);
> >   	return 0;
> > @@ -462,7 +482,7 @@ static int __arm_v7s_map(struct arm_v7s_io_pgtable *data, unsigned long iova,
> >   	}
> >   
> >   	if (ARM_V7S_PTE_IS_TABLE(pte, lvl)) {
> > -		cptep = iopte_deref(pte, lvl);
> > +		cptep = iopte_deref(pte, lvl, data);
> >   	} else if (pte) {
> >   		/* We require an unmap first */
> >   		WARN_ON(!selftest_running);
> > @@ -512,7 +532,8 @@ static void arm_v7s_free_pgtable(struct io_pgtable *iop)
> >   		arm_v7s_iopte pte = data->pgd[i];
> >   
> >   		if (ARM_V7S_PTE_IS_TABLE(pte, 1))
> > -			__arm_v7s_free_table(iopte_deref(pte, 1), 2, data);
> > +			__arm_v7s_free_table(iopte_deref(pte, 1, data),
> > +					     2, data);
> >   	}
> >   	__arm_v7s_free_table(data->pgd, 1, data);
> >   	kmem_cache_destroy(data->l2_tables);
> > @@ -582,7 +603,7 @@ static size_t arm_v7s_split_blk_unmap(struct arm_v7s_io_pgtable *data,
> >   		if (!ARM_V7S_PTE_IS_TABLE(pte, 1))
> >   			return 0;
> >   
> > -		tablep = iopte_deref(pte, 1);
> > +		tablep = iopte_deref(pte, 1, data);
> >   		return __arm_v7s_unmap(data, iova, size, 2, tablep);
> >   	}
> >   
> > @@ -640,7 +661,7 @@ static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
> >   				io_pgtable_tlb_add_flush(iop, iova, blk_size,
> >   					ARM_V7S_BLOCK_SIZE(lvl + 1), false);
> >   				io_pgtable_tlb_sync(iop);
> > -				ptep = iopte_deref(pte[i], lvl);
> > +				ptep = iopte_deref(pte[i], lvl, data);
> >   				__arm_v7s_free_table(ptep, lvl + 1, data);
> >   			} else {
> >   				io_pgtable_tlb_add_flush(iop, iova, blk_size,
> > @@ -658,7 +679,7 @@ static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
> >   	}
> >   
> >   	/* Keep on walkin' */
> > -	ptep = iopte_deref(pte[0], lvl);
> > +	ptep = iopte_deref(pte[0], lvl, data);
> >   	return __arm_v7s_unmap(data, iova, size, lvl + 1, ptep);
> >   }
> >   
> > @@ -684,7 +705,7 @@ static phys_addr_t arm_v7s_iova_to_phys(struct io_pgtable_ops *ops,
> >   	do {
> >   		ptep += ARM_V7S_LVL_IDX(iova, ++lvl);
> >   		pte = READ_ONCE(*ptep);
> > -		ptep = iopte_deref(pte, lvl);
> > +		ptep = iopte_deref(pte, lvl, data);
> >   	} while (ARM_V7S_PTE_IS_TABLE(pte, lvl));
> >   
> >   	if (!ARM_V7S_PTE_IS_VALID(pte))
> > @@ -693,7 +714,7 @@ static phys_addr_t arm_v7s_iova_to_phys(struct io_pgtable_ops *ops,
> >   	mask = ARM_V7S_LVL_MASK(lvl);
> >   	if (arm_v7s_pte_is_cont(pte, lvl))
> >   		mask *= ARM_V7S_CONT_PAGES;
> > -	return (pte & mask) | (iova & ~mask);
> > +	return iopte_to_paddr(pte, lvl, data) | (iova & ~mask);
> >   }
> >   
> >   static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
> > 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


