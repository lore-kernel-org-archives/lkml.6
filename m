Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494A9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192F221907
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732665AbeLUIDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:03:00 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:21192 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729898AbeLUIDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:03:00 -0500
X-UUID: 9fe65b3a70c640b19bf2f0a91b128b6e-20181221
X-UUID: 9fe65b3a70c640b19bf2f0a91b128b6e-20181221
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 764756075; Fri, 21 Dec 2018 16:02:46 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 21 Dec
 2018 16:02:44 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 21 Dec 2018 16:02:43 +0800
Message-ID: <1545379363.29587.52.camel@mhfsdcap03>
Subject: Re: [PATCH v4 08/18] iommu/mediatek: Add larb-id remapped support
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
        <iommu@lists.linux-foundation.org>, <arnd@arndb.de>,
        <yingjoe.chen@mediatek.com>, <youlin.pei@mediatek.com>,
        "Arvind Yadav" <arvind.yadav.cs@gmail.com>
Date:   Fri, 21 Dec 2018 16:02:43 +0800
In-Reply-To: <CANMq1KDHTPbYHXVsf+_=ER3HYjfFPjv6LTTZMvmM7WChiFDyZQ@mail.gmail.com>
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
         <1544258371-4600-9-git-send-email-yong.wu@mediatek.com>
         <CANMq1KDHTPbYHXVsf+_=ER3HYjfFPjv6LTTZMvmM7WChiFDyZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Thanks for the review of this patchset.

On Fri, 2018-12-21 at 11:35 +0800, Nicolas Boichat wrote:
> On Sat, Dec 8, 2018 at 4:42 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > The larb-id may be remapped in the smi-common, this means the
> > larb-id reported in the mtk_iommu_isr isn't the real larb-id,
> >
> > Take mt8183 as a example:
> >                        M4U
> >                         |
> > ---------------------------------------------
> > |               SMI common                  |
> > -0-----7-----5-----6-----1-----2------3-----4- <- Id remapped
> >  |     |     |     |     |     |      |     |
> > larb0 larb1 IPU0  IPU1 larb4 larb5  larb6  CCU
> > disp  vdec  img   cam   venc  img    cam
> > As above, larb0 connects with the id 0 in smi-common.
> >           larb1 connects with the id 7 in smi-common.
> >           ...
> > If the larb-id reported in the isr is 7, actually it's larb1(vdec).
> > In order to output the right larb-id in the isr, we add a larb-id
> > remapping relationship in this patch.
> >
> > This also is a preparing patch for mt8183.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 3 +++
> >  drivers/iommu/mtk_iommu.h | 4 ++++
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index eda062a..8ab3b69 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -220,6 +220,9 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
> >         fault_larb = F_MMU0_INT_ID_LARB_ID(regval);
> >         fault_port = F_MMU0_INT_ID_PORT_ID(regval);
> >
> > +       if (data->plat_data->larbid_remap_enable)
> > +               fault_larb = data->plat_data->larbid_remapped[fault_larb];
> > +
> >         if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
> >                                write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
> >                 dev_err_ratelimited(
> > diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> > index b8749ac..3877050 100644
> > --- a/drivers/iommu/mtk_iommu.h
> > +++ b/drivers/iommu/mtk_iommu.h
> > @@ -47,6 +47,10 @@ struct mtk_iommu_plat_data {
> >
> >         /* HW will use the EMI clock if there isn't the "bclk". */
> >         bool                has_bclk;
> > +
> > +       /* The larb-id may be remapped in the smi-common. */
> > +       bool                larbid_remap_enable;
> > +       unsigned int        larbid_remapped[MTK_LARB_NR_MAX];
> 
> Wouldn't it be a little simpler if you just had
> larbid_remap[MTK_LARB_NR_MAX] (no larbid_remap_enable), and just set
> it to {0, 1, 2, 3, 4, 5, 6, 7} in platforms that don't need
> complicated remapping?

Actually I'd like the original way(Print the larb-id from the register
directly if larb-id is not remapped). But this solution is also ok for
me.

> 
> Also, unsigned char/u8 array would be enough.

OK. "unsigned char" is enough.
Originally I think "int" or "long" may be better to access in ARM/ARM64.

> 
> >  };
> >
> >  struct mtk_iommu_domain;
> > --
> > 1.9.1
> >


