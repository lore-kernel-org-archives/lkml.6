Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A54C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8B02086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfBTJRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:17:23 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:12735 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725816AbfBTJRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:17:23 -0500
X-UUID: 8467bad73e5f4c428da23767aa6d3c4f-20190220
X-UUID: 8467bad73e5f4c428da23767aa6d3c4f-20190220
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2023570188; Wed, 20 Feb 2019 17:17:17 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 20 Feb
 2019 17:17:16 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Feb 2019 17:17:15 +0800
Message-ID: <1550654235.26244.10.camel@mhfsdcap03>
Subject: Re: [PATCH v6 21/22] iommu/mediatek: Fix iova_to_phys PA start for
 4GB mode
From:   Yong Wu <yong.wu@mediatek.com>
To:     Evan Green <evgreen@chromium.org>
CC:     <youlin.pei@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <yingjoe.chen@mediatek.com>, <anan.sun@mediatek.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 20 Feb 2019 17:17:15 +0800
In-Reply-To: <CAE=gft783rOUubODiFHxa9NKeUJxGk4FCeguDsyoqrUxsGDEsQ@mail.gmail.com>
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
         <1550394300-17420-22-git-send-email-yong.wu@mediatek.com>
         <CAE=gft783rOUubODiFHxa9NKeUJxGk4FCeguDsyoqrUxsGDEsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-19 at 15:33 -0800, Evan Green wrote:
> On Sun, Feb 17, 2019 at 1:09 AM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > In the 4GB mode, the physical address is remapped,
> >
> > Here is the detailed remap relationship.
> > CPU PA         ->    HW PA
> > 0x4000_0000          0x1_4000_0000 (Add bit32)
> > 0x8000_0000          0x1_8000_0000 ...
> > 0xc000_0000          0x1_c000_0000 ...
> > 0x1_0000_0000        0x1_0000_0000 (No change)
> >
> > Thus, we always add bit32 for PA when entering mtk_iommu_map.
> > But in the iova_to_phys, the CPU don't need this bit32 if the
> > PA is from 0x1_4000_0000 to 0x1_ffff_ffff.
> > This patch discards the bit32 in this iova_to_phys in the 4GB mode.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 0277396..076d333 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -119,6 +119,19 @@ struct mtk_iommu_domain {
> >
> >  static const struct iommu_ops mtk_iommu_ops;
> >
> > +/*
> > + * In M4U 4GB mode, the physical address is remapped as below:
> > + *  CPU PA         ->   M4U HW PA
> > + *  0x4000_0000         0x1_4000_0000 (Add bit32)
> > + *  0x8000_0000         0x1_8000_0000 ...
> > + *  0xc000_0000         0x1_c000_0000 ...
> > + *  0x1_0000_0000       0x1_0000_0000 (No change)
> > + *
> > + * Thus, We always add BIT32 in the iommu_map and disable BIT32 if PA is >=
> > + * 0x1_4000_0000 in the iova_to_phys.
> > + */
> > +#define MTK_IOMMU_4GB_MODE_PA_140000000     0x140000000UL
> > +
> >  static LIST_HEAD(m4ulist);     /* List all the M4U HWs */
> >
> >  #define for_each_m4u(data)     list_for_each_entry(data, &m4ulist, list)
> > @@ -415,6 +428,7 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
> >                                           dma_addr_t iova)
> >  {
> >         struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> > +       struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
> >         unsigned long flags;
> >         phys_addr_t pa;
> >
> > @@ -422,6 +436,10 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
> >         pa = dom->iop->iova_to_phys(dom->iop, iova);
> >         spin_unlock_irqrestore(&dom->pgtlock, flags);
> >
> > +       if (data->plat_data->has_4gb_mode && data->dram_is_4gb &&
> > +           pa >= MTK_IOMMU_4GB_MODE_PA_140000000)
> > +               pa &= ~BIT_ULL(32);
> > +
> 
> The define doesn't really make it much better, but I guess it doesn't
> make it worse either. As I was reviewing this I was thinking that this
> should be rolled into patch 6 "iommu/io-pgtable-arm-v7s: Extend
> MediaTek 4GB Mode". But I guess this was returning bad PAs since
> before this series, right? So does this need a Fixes tag?

Thanks very much for your reviewing so many patches.

Yes. The issue exist before this series, It was introduced by this
commit:
30e2fccf9512 ("iommu/mediatek: Enlarge the validate PA range for 4GB
mode")

I will send a new version to add this tag.

> -Evan
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


