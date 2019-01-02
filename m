Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84650C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6E6218D0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfABJca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:32:30 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:23781 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726782AbfABJca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:32:30 -0500
X-UUID: a40ee9a61528452fa2ae24b94ccf9351-20190102
X-UUID: a40ee9a61528452fa2ae24b94ccf9351-20190102
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1703866915; Wed, 02 Jan 2019 17:32:23 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 2 Jan
 2019 17:32:21 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 2 Jan 2019 17:32:20 +0800
Message-ID: <1546421540.32203.13.camel@mhfsdcap03>
Subject: Re: [PATCH v5 11/20] iommu/mediatek: Move vld_pa_rng into plat_data
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
Date:   Wed, 2 Jan 2019 17:32:20 +0800
In-Reply-To: <CANMq1KAZumH0=iLFgi7=P2mCE4B=7nw_FW9ir4Dwp4M3f8Ukjg@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
         <1546314952-15990-12-git-send-email-yong.wu@mediatek.com>
         <CANMq1KAZumH0=iLFgi7=P2mCE4B=7nw_FW9ir4Dwp4M3f8Ukjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-02 at 14:45 +0800, Nicolas Boichat wrote:
> On Tue, Jan 1, 2019 at 11:58 AM Yong Wu <yong.wu@mediatek.com> wrote:
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
> Since this is not a register name, maybe we can use something more
> readable, like valid_pa_range?
> 
> (or at the very least describe it in a comment in the struct?)

I will add a comment about it. like:

           bool vld_pa_rng; /* valid pa range */


> 
> >         unsigned char       larbid_remap[MTK_LARB_NR_MAX];
> >  };
> >
> > --
> > 1.9.1
> >


