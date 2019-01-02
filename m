Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED32C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A29206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbfABJdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:33:44 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:20537 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726782AbfABJdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:33:43 -0500
X-UUID: 2c62b20328dd418f82c946b7842ab049-20190102
X-UUID: 2c62b20328dd418f82c946b7842ab049-20190102
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1227216572; Wed, 02 Jan 2019 17:33:39 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 2 Jan
 2019 17:33:35 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 2 Jan 2019 17:33:34 +0800
Message-ID: <1546421615.32203.14.camel@mhfsdcap03>
Subject: Re: [PATCH v5 09/20] iommu/mediatek: Refine protect memory
 definition
From:   Yong Wu <yong.wu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>, Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        <youlin.pei@mediatek.com>
Date:   Wed, 2 Jan 2019 17:33:35 +0800
In-Reply-To: <CANMq1KC0zciUAtvcYoxfBOOMbGFu_Un031QemtuDopjWvwk3cw@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
         <1546314952-15990-10-git-send-email-yong.wu@mediatek.com>
         <CANMq1KC0zciUAtvcYoxfBOOMbGFu_Un031QemtuDopjWvwk3cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-02 at 14:23 +0800, Nicolas Boichat wrote:
> On Tue, Jan 1, 2019 at 11:58 AM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > The protect memory setting is a little different in the different SoCs.
> > In the register REG_MMU_CTRL_REG(0x110), the TF_PROT(translation fault
> > protect) shift bit is normally 4 while it shift 5 bits only in the
> > mt8173. This patch delete the complex MACRO and use a common if-else
> > instead.
> >
> > Also, use "F_MMU_TF_PROT_TO_PROGRAM_ADDR" instead of the hard code(2)
> > which means the M4U will output the dirty data to the programmed
> > address that we allocated dynamically when translation fault occurs.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> > @Nicalos, I don't put it in the plat_data since only the previous mt8173
> > shift 5. As I know, the latest SoC always use the new setting like mt2712
> > and mt8183. Thus, I think it is unnecessary to put it in plat_data and
> > let all the latest SoC set it. Hence, I still keep "== mt8173" for this
> > like the reg REG_MMU_CTRL_REG.
> 
> Should be ok this way. But maybe one way to avoid hard-coding 4/5
> below is to have 2 macros:
> 
> #define F_MMU_TF_PROT_TO_PROGRAM_ADDR (2 << 4)
> #define F_MMU_TF_PROT_TO_PROGRAM_ADDR_MT8173 (2 << 5)
> 
> And still use the if below?

Thanks for your quick review.

OK for me.

I will wait Matthias's review for memory/ part. then send the next
version.

> 
> > ---
> >  drivers/iommu/mtk_iommu.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index eca1536..35a1263 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -53,11 +53,7 @@
> >
> >  #define REG_MMU_CTRL_REG                       0x110
> >  #define F_MMU_PREFETCH_RT_REPLACE_MOD          BIT(4)
> > -#define F_MMU_TF_PROTECT_SEL_SHIFT(data) \
> > -       ((data)->plat_data->m4u_plat == M4U_MT2712 ? 4 : 5)
> > -/* It's named by F_MMU_TF_PROT_SEL in mt2712. */
> > -#define F_MMU_TF_PROTECT_SEL(prot, data) \
> > -       (((prot) & 0x3) << F_MMU_TF_PROTECT_SEL_SHIFT(data))
> > +#define F_MMU_TF_PROT_TO_PROGRAM_ADDR          2
> >
> >  #define REG_MMU_IVRP_PADDR                     0x114
> >
> > @@ -521,9 +517,11 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> >                 return ret;
> >         }
> >
> > -       regval = F_MMU_TF_PROTECT_SEL(2, data);
> >         if (data->plat_data->m4u_plat == M4U_MT8173)
> > -               regval |= F_MMU_PREFETCH_RT_REPLACE_MOD;
> > +               regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
> > +                         (F_MMU_TF_PROT_TO_PROGRAM_ADDR << 5);
> > +       else
> > +               regval = F_MMU_TF_PROT_TO_PROGRAM_ADDR << 4;
> >         writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
> >
> >         regval = F_L2_MULIT_HIT_EN |
> > --
> > 1.9.1
> >


