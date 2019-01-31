Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622A4C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1D320870
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbfAaDU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:20:56 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:52014 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725535AbfAaDU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:20:56 -0500
X-UUID: 1c43b1d4d83b49d1ad36c4b52ef01100-20190131
X-UUID: 1c43b1d4d83b49d1ad36c4b52ef01100-20190131
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1503932866; Thu, 31 Jan 2019 11:20:43 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 11:20:42 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 11:20:41 +0800
Message-ID: <1548904841.19710.36.camel@mhfsdcap03>
Subject: Re: [PATCH v5 11/20] iommu/mediatek: Move vld_pa_rng into plat_data
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
Date:   Thu, 31 Jan 2019 11:20:41 +0800
In-Reply-To: <CAE=gft4=4h_1MAnrC8CosSe3gOWx+DwFJSLvGNtOFNMZN8oZ3w@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
         <1546314952-15990-12-git-send-email-yong.wu@mediatek.com>
         <CAE=gft4=4h_1MAnrC8CosSe3gOWx+DwFJSLvGNtOFNMZN8oZ3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-30 at 10:30 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 7:58 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > Both mt8173 and mt8183 don't have this vld_pa_rng(valid physical address
> > range) register while mt2712 have. Move it into the plat_data.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 3 ++-
> >  drivers/iommu/mtk_iommu.h | 1 +
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 8d8ab21..2913ddb 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -548,7 +548,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> >                          upper_32_bits(data->protect_base);
> >         writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
> >
> > -       if (data->enable_4GB && data->plat_data->m4u_plat != M4U_MT8173) {
> > +       if (data->enable_4GB && data->plat_data->vld_pa_rng) {
> >                 /*
> >                  * If 4GB mode is enabled, the validate PA range is from
> >                  * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
> > @@ -741,6 +741,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
> >         .m4u_plat     = M4U_MT2712,
> >         .has_4gb_mode = true,
> >         .has_bclk     = true,
> > +       .vld_pa_rng   = true,
> >         .larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
> >  };
> >
> > diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> > index b46aeaa..a8c5d1e 100644
> > --- a/drivers/iommu/mtk_iommu.h
> > +++ b/drivers/iommu/mtk_iommu.h
> > @@ -48,6 +48,7 @@ struct mtk_iommu_plat_data {
> >         /* HW will use the EMI clock if there isn't the "bclk". */
> >         bool                has_bclk;
> >         bool                reset_axi;
> > +       bool                vld_pa_rng;
> 
> I agree with Nicolas that valid_pa_range would be much clearer...
> although, even now that I know what it's supposed to mean, I don't get
> what it represents. What is this saying?

This register in the coda is called "vld_pa_rng".

How about I change it to "has_vld_pa_rng"?. In the comment above, I have
explained the meaning(valid physical address range).

> 
> -Evan


