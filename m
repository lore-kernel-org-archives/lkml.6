Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB960C282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4522077B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbfAaG7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 01:59:09 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:36709 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725963AbfAaG7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 01:59:08 -0500
X-UUID: cc58c7ab19ce4861bb21f170bf770489-20190131
X-UUID: cc58c7ab19ce4861bb21f170bf770489-20190131
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1060088888; Thu, 31 Jan 2019 14:58:59 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 14:58:57 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 14:58:57 +0800
Message-ID: <1548917937.3292.15.camel@mhfsdcap03>
Subject: Re: [PATCH v6 06/20] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB
 Mode
From:   Yong Wu <yong.wu@mediatek.com>
To:     Evan Green <evgreen@chromium.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
        <yingjoe.chen@mediatek.com>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 31 Jan 2019 14:58:57 +0800
In-Reply-To: <CAE=gft5bga+pM_7syKMnnma78xYN0HT4LaPPEftJ9DNqFf=zWw@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
         <1546314952-15990-7-git-send-email-yong.wu@mediatek.com>
         <CAE=gft5bga+pM_7syKMnnma78xYN0HT4LaPPEftJ9DNqFf=zWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-30 at 10:28 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 7:57 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > MediaTek extend the arm v7s descriptor to support the dram over 4GB.
> >
> > In the mt2712 and mt8173, it's called "4GB mode", the physical address
> > is from 0x4000_0000 to 0x1_3fff_ffff, but from EMI point of view, it
> > is remapped to high address from 0x1_0000_0000 to 0x1_ffff_ffff, the
> > bit32 is always enabled. thus, in the M4U, we always enable the bit9
> > for all PTEs which means to enable bit32 of physical address.
> 
> I got a little lost here. I get that you're trying to explain why you
> always used to set bit32 of the physical address. But I don't totally
> get the part about physical addresses being from 0x4000_0000 -
> 0x1_3fff_ffff, but also from 0x1_0000_0000-0x1_ffff_ffff. Are you
> saying that the physical addresses from the iommu's perspective were
> always >0x1_0000_0000? 

Yes. From the IOMMU's perspective, the Physical address is from
0x1_0000_0000 to 0x1_ffff_ffff.

> But then from whose perspective is it 0x4000_0000? ... 

I guess from SW point view. it is from 0x4000_0000 to 0x1_3fff_ffff.

If 4GB mode is enabled, the memory property in dts like this:

	memory@40000000 {
		device_type = "memory";
		reg = <0 0x40000000 0x00000001 0x00000000>;
	};

> oh, or you're saying there was some sort of remapping
> facility that moved the physical addresses around?
> 
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
> > Regarding whether the pagetable address could be over 4GB, the mt8183
> > support it while the previous mt8173 don't. thus keep it as is.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> >  drivers/iommu/io-pgtable-arm-v7s.c | 31 ++++++++++++++++++++++++-------
> >  drivers/iommu/io-pgtable.h         |  7 +++----
> >  drivers/iommu/mtk_iommu.c          | 14 ++++++++------
> >  drivers/iommu/mtk_iommu.h          |  1 +
> >  4 files changed, 36 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> > index 11d8505..8803a35 100644
> > --- a/drivers/iommu/io-pgtable-arm-v7s.c
> > +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> > @@ -124,7 +124,9 @@
> >  #define ARM_V7S_TEX_MASK               0x7
> >  #define ARM_V7S_ATTR_TEX(val)          (((val) & ARM_V7S_TEX_MASK) << ARM_V7S_TEX_SHIFT)
> >
> > -#define ARM_V7S_ATTR_MTK_4GB           BIT(9) /* MTK extend it for 4GB mode */
> > +/* MediaTek extend the two bits below for over 4GB mode */
> > +#define ARM_V7S_ATTR_MTK_PA_BIT32      BIT(9)
> > +#define ARM_V7S_ATTR_MTK_PA_BIT33      BIT(4)
> 
> If other vendors start doing stuff like this we'll need a more generic
> way to handle this... but I guess until we see a pattern this is okay.
> 
> >
> >  /* *well, except for TEX on level 2 large pages, of course :( */
> >  #define ARM_V7S_CONT_PAGE_TEX_SHIFT    6
> > @@ -183,13 +185,22 @@ static dma_addr_t __arm_v7s_dma_addr(void *pages)
> >  static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
> >                                     struct io_pgtable_cfg *cfg)
> >  {
> > -       return paddr & ARM_V7S_LVL_MASK(lvl);
> > +       arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
> > +
> > +       if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
> > +               if (paddr & BIT_ULL(32))
> > +                       pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
> > +               if (paddr & BIT_ULL(33))
> > +                       pte |= ARM_V7S_ATTR_MTK_PA_BIT33;
> > +       }
> > +       return pte;
> >  }
> >
> >  static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
> >                                   struct io_pgtable_cfg *cfg)
> >  {
> >         arm_v7s_iopte mask;
> > +       phys_addr_t paddr;
> >
> >         if (ARM_V7S_PTE_IS_TABLE(pte, lvl))
> >                 mask = ARM_V7S_TABLE_MASK;
> > @@ -198,7 +209,14 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
> >         else
> >                 mask = ARM_V7S_LVL_MASK(lvl);
> >
> > -       return pte & mask;
> > +       paddr = pte & mask;
> > +       if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
> > +               if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
> > +                       paddr |= BIT_ULL(32);
> > +               if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
> > +                       paddr |= BIT_ULL(33);
> > +       }
> > +       return paddr;
> >  }
> >
> >  static arm_v7s_iopte *iopte_deref(arm_v7s_iopte pte, int lvl,
> > @@ -315,9 +333,6 @@ static arm_v7s_iopte arm_v7s_prot_to_pte(int prot, int lvl,
> >         if (lvl == 1 && (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS))
> >                 pte |= ARM_V7S_ATTR_NS_SECTION;
> >
> > -       if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)
> > -               pte |= ARM_V7S_ATTR_MTK_4GB;
> > -
> 
> So despite getting lost in the details, I guess the reason it's okay
> that this goes from unconditional to conditional on bit32 is that
> before, with the older chips, all physical addresses were above 4GB,
> so we'll always see PA's above 4GB?
> 
> >         return pte;
> >  }
> >
> > @@ -504,7 +519,9 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
> >         if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
> >                 return 0;
> >
> > -       if (WARN_ON(upper_32_bits(iova) || upper_32_bits(paddr)))
> > +       if (WARN_ON(upper_32_bits(iova)) ||
> > +           WARN_ON(upper_32_bits(paddr) &&
> > +                   !(iop->cfg.quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)))
> >                 return -ERANGE;
> >
> >         ret = __arm_v7s_map(data, iova, paddr, size, prot, 1, data->pgd);
> > diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> > index 47d5ae5..69db115 100644
> > --- a/drivers/iommu/io-pgtable.h
> > +++ b/drivers/iommu/io-pgtable.h
> > @@ -62,10 +62,9 @@ struct io_pgtable_cfg {
> >          *      (unmapped) entries but the hardware might do so anyway, perform
> >          *      TLB maintenance when mapping as well as when unmapping.
> >          *
> > -        * IO_PGTABLE_QUIRK_ARM_MTK_4GB: (ARM v7s format) Set bit 9 in all
> > -        *      PTEs, for Mediatek IOMMUs which treat it as a 33rd address bit
> > -        *      when the SoC is in "4GB mode" and they can only access the high
> > -        *      remap of DRAM (0x1_00000000 to 0x1_ffffffff).
> > +        * IO_PGTABLE_QUIRK_ARM_MTK_4GB: (ARM v7s format) MediaTek IOMMUs extend
> > +        *      to support up to 34 bits PA where the bit32 and bit33 are
> > +        *      encoded in the bit9 and bit4 of the PTE respectively.
> >          *
> >          * IO_PGTABLE_QUIRK_NO_DMA: Guarantees that the tables will only ever
> >          *      be accessed by a fully cache-coherent IOMMU or CPU (e.g. for a
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 189d1b5..ae1aa5a 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -367,12 +367,16 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
> >                          phys_addr_t paddr, size_t size, int prot)
> >  {
> >         struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> > +       struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
> >         unsigned long flags;
> >         int ret;
> >
> > +       /* The "4GB mode" M4U physically can not use the lower remap of Dram. */
> > +       if (data->plat_data->has_4gb_mode && data->enable_4GB)
> > +               paddr |= BIT_ULL(32);
> > +
> 
> Ok here's where I get lost. How is this okay? Is the same physical RAM
> accessible at multiple locations in the physical address space? Won't
> this map an iova to a different pa than the one requested?

In 4GB mode, HW will remap 0x4000_0000-0x1_3fff_ffff to 0x1_0000_0000-
0x1_ffff_ffff. M4U help multimedia HW access dram, thus from M4U point
of view, the dram always is 0x1_0000_0000 to 0x1_ffff_ffff.

The detailed mapping relationship is like this:

0x4000_0000  -0xffff_ffff   map to 0x1_4000_0000 - 0x1_ffff_ffff.
0x1_0000_0000-0x1_3fff_ffff map to 0x1_0000_0000 - 0x1_3fff_ffff.

Thus, we can only add bit32 for the PA in the 4GB mode.

> 
> Also, you could have rolled the has_4gb_mode check into whether or not
> you set enable_4GB. Then you're doing the check for has_4gb_mode once,
> rather than on every map call.

"has_4gb_mode" means this SoC support 4GB mode.
"enable_4GB" means whether the current dram size is 4GB.

> -Evan


