Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36A7C282D8
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E34218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbfAaDWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:22:34 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:39717 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725535AbfAaDWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:22:33 -0500
X-UUID: 50c21c77f80b43e4b440f3235d984d2d-20190131
X-UUID: 50c21c77f80b43e4b440f3235d984d2d-20190131
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 279568872; Thu, 31 Jan 2019 11:22:28 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 11:22:26 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 11:22:26 +0800
Message-ID: <1548904946.19710.40.camel@mhfsdcap03>
Subject: Re: [PATCH v5 10/20] iommu/mediatek: Move reset_axi into plat_data
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
Date:   Thu, 31 Jan 2019 11:22:26 +0800
In-Reply-To: <CAE=gft72KfZ9RdDTJeEpQJ7h3_cOXzm1YRQG-U47s64QVOhabA@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
         <1546314952-15990-11-git-send-email-yong.wu@mediatek.com>
         <CAE=gft72KfZ9RdDTJeEpQJ7h3_cOXzm1YRQG-U47s64QVOhabA@mail.gmail.com>
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
> > In mt8173 and mt8183, 0x48 is REG_MMU_STANDARD_AXI_MODE while
> > it is extended to REG_MMU_CTRL which contains _STANDARD_AXI_MODE in
> > the other SoCs. I move this property to plat_data since both mt8173
> > and mt8183 use this property.
> >
> > It is a preparing patch for mt8183.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 4 ++--
> >  drivers/iommu/mtk_iommu.h | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 35a1263..8d8ab21 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -558,8 +558,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> >         }
> >         writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
> >
> > -       /* It's MISC control register whose default value is ok except mt8173.*/
> > -       if (data->plat_data->m4u_plat == M4U_MT8173)
> > +       if (data->plat_data->reset_axi)
> >                 writel_relaxed(0, data->base + REG_MMU_STANDARD_AXI_MODE);
> 
> The commit description makes it sound like the overall format of the
> register is the same, but the "other SoCs" have some extra bits they'd
> like to leave alone. Would it be easier to do a read-modify-write to
> always clear some bits in the register, instead of doing something
> based on the SoC? Or do the bits mean completely different things in
> the different versions (in which case what you've got makes sense to
> me)?

The bits mean completely is different.(the axi bit position also is
different. I will add this in the comment of this patch.)

> -Evan


