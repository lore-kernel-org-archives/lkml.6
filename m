Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E388DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90E1218FC
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfABJcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:32:09 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:13035 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726782AbfABJcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:32:08 -0500
X-UUID: 6bb6328efc2e4d2da87376707b0603b3-20190102
X-UUID: 6bb6328efc2e4d2da87376707b0603b3-20190102
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1232002991; Wed, 02 Jan 2019 17:32:03 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 2 Jan
 2019 17:31:53 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 2 Jan 2019 17:31:53 +0800
Message-ID: <1546421513.32203.12.camel@mhfsdcap03>
Subject: Re: [PATCH v5 18/20] iommu/mediatek: Fix VLD_PA_RANGE register
 backup when suspend
From:   Yong Wu <yong.wu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        <youlin.pei@mediatek.com>
Date:   Wed, 2 Jan 2019 17:31:53 +0800
In-Reply-To: <CANMq1KDnduh+X30GzNgTb7Q3Dace8O4uNAzeULTgBRUdEsp_XA@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
         <1546314952-15990-19-git-send-email-yong.wu@mediatek.com>
         <CANMq1KDnduh+X30GzNgTb7Q3Dace8O4uNAzeULTgBRUdEsp_XA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-02 at 14:54 +0800, Nicolas Boichat wrote:
> On Tue, Jan 1, 2019 at 11:59 AM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > The register VLD_PA_RNG(0x118) was forgot to backup while adding 4GB
> > mode support for mt2712. this patch add it.
> >
> > Fixes: 30e2fccf9512 ("iommu/mediatek: Enlarge the validate PA range
> > for 4GB mode")
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 2 ++
> >  drivers/iommu/mtk_iommu.h | 1 +
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 7fcef19..ddf1969 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -716,6 +716,7 @@ static int __maybe_unused mtk_iommu_suspend(struct device *dev)
> >         reg->int_control0 = readl_relaxed(base + REG_MMU_INT_CONTROL0);
> >         reg->int_main_control = readl_relaxed(base + REG_MMU_INT_MAIN_CONTROL);
> >         reg->ivrp_paddr = readl_relaxed(base + REG_MMU_IVRP_PADDR);
> > +       reg->vld_pa_range = readl_relaxed(base + REG_MMU_VLD_PA_RNG);
> 
> Don't we want to add:
> if (data->plat_data->vld_pa_rng)
> before this save/restore operation? Or it doesn't matter?

It doesn't matter. If some SoCs don't have it, the register doesn't
conflict with the others. Reading it will return 0, and writing 0 will
have no effect.

> 
> >         clk_disable_unprepare(data->bclk);
> >         return 0;
> >  }
> > @@ -740,6 +741,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
> >         writel_relaxed(reg->int_control0, base + REG_MMU_INT_CONTROL0);
> >         writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
> >         writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
> > +       writel_relaxed(reg->vld_pa_range, base + REG_MMU_VLD_PA_RNG);
> >         if (m4u_dom)
> >                 writel(m4u_dom->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
> >                        base + REG_MMU_PT_BASE_ADDR);
> > diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> > index 0a7c463..c500bfd 100644
> > --- a/drivers/iommu/mtk_iommu.h
> > +++ b/drivers/iommu/mtk_iommu.h
> > @@ -33,6 +33,7 @@ struct mtk_iommu_suspend_reg {
> >         u32                             int_control0;
> >         u32                             int_main_control;
> >         u32                             ivrp_paddr;
> > +       u32                             vld_pa_range;
> 
> Well, please be consistent ,-) Either vld_pa_rng, or valid_pa_range ,-)

Thanks. I will use "vld_pa_rng", Keep same with the register name from
CODA.

> 
> >  };
> >
> >  enum mtk_iommu_plat {
> > --
> > 1.9.1
> >


