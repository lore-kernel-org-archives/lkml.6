Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B632C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0604217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbfB0Oez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:34:55 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:46123 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726866AbfB0Oez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:34:55 -0500
X-UUID: e51b820e1080497487b9872f867f8a00-20190227
X-UUID: e51b820e1080497487b9872f867f8a00-20190227
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1484565171; Wed, 27 Feb 2019 22:34:45 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 27 Feb
 2019 22:34:44 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Feb 2019 22:34:43 +0800
Message-ID: <1551278083.17917.53.camel@mhfsdcap03>
Subject: Re: [PATCH 04/13] iommu/mediatek: Add device_link between the
 consumer and the larb devices
From:   Yong Wu <yong.wu@mediatek.com>
To:     Evan Green <evgreen@chromium.org>
CC:     <youlin.pei@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, <srv_heupstream@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <yingjoe.chen@mediatek.com>, Robin Murphy <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 27 Feb 2019 22:34:43 +0800
In-Reply-To: <CAE=gft7R4tkR9hAif4izQi1J1QTcC0rUVyrLAnDdzu_RHV6yHA@mail.gmail.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
         <1546318276-18993-5-git-send-email-yong.wu@mediatek.com>
         <CAE=gft7R4tkR9hAif4izQi1J1QTcC0rUVyrLAnDdzu_RHV6yHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-25 at 15:54 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > MediaTek IOMMU don't have its power-domain. all the consumer connect
> > with smi-larb, then connect with smi-common.
> >
> >         M4U
> >          |
> >     smi-common
> >          |
> >   -------------
> >   |         |    ...
> >   |         |
> > larb1     larb2
> >   |         |
> > vdec       venc
> >
> > When the consumer works, it should enable the smi-larb's power which
> > also need enable the smi-common's power firstly.
> >
> > Thus, First of all, use the device link connect the consumer and the
> > smi-larbs. then add device link between the smi-larb and smi-common.
> >
> > This patch adds device_link between the consumer and the larbs.
> >
> > Suggested-by: Tomasz Figa <tfiga@chromium.org>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c    | 15 +++++++++++++--
> >  drivers/iommu/mtk_iommu_v1.c | 14 ++++++++++++--
> >  2 files changed, 25 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 202e41b..735ae8d 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -247,6 +247,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
> >         struct mtk_smi_larb_iommu    *larb_mmu;
> >         unsigned int                 larbid, portid;
> >         struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +       struct device_link *link;
> >         int i;
> >
> >         for (i = 0; i < fwspec->num_ids; ++i) {
> > @@ -257,10 +258,20 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
> >                 dev_dbg(dev, "%s iommu port: %d\n",
> >                         enable ? "enable" : "disable", portid);
> >
> > -               if (enable)
> > +               if (enable) {
> >                         larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
> > -               else
> > +                       /* Link the consumer with the larb device(supplier) */
> > +                       link = device_link_add(dev, larb_mmu->dev,
> > +                                              DL_FLAG_PM_RUNTIME |
> > +                                              DL_FLAG_AUTOREMOVE_CONSUMER);
> > +                       if (!link) {
> > +                               dev_err(dev, "Unable to link %s\n",
> > +                                       dev_name(larb_mmu->dev));
> > +                               return;
> 
> The return is a little odd here, given that you don't return an error
> and this function doesn't do anything else. If it's non-fatal that
> this link didn't get set up, then remove the return. If it is fatal,
> then return an error code.

I will remove the "return". Thanks.

> 
> > +                       }
> > +               } else {
> >                         larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
> > +               }
> >         }
> >  }
> >
> > diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> > index 9386aee..022bad9 100644
> > --- a/drivers/iommu/mtk_iommu_v1.c
> > +++ b/drivers/iommu/mtk_iommu_v1.c
> > @@ -201,6 +201,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
> >         struct mtk_smi_larb_iommu    *larb_mmu;
> >         unsigned int                 larbid, portid;
> >         struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +       struct device_link *link;
> >         int i;
> >
> >         for (i = 0; i < fwspec->num_ids; ++i) {
> > @@ -211,10 +212,19 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
> >                 dev_dbg(dev, "%s iommu port: %d\n",
> >                         enable ? "enable" : "disable", portid);
> >
> > -               if (enable)
> > +               if (enable) {
> >                         larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
> > -               else
> > +                       link = device_link_add(dev, larb_mmu->dev,
> > +                                              DL_FLAG_PM_RUNTIME |
> > +                                              DL_FLAG_AUTOREMOVE_CONSUMER);
> > +                       if (!link) {
> > +                               dev_err(dev, "Unable to link %s\n",
> > +                                       dev_name(larb_mmu->dev));
> > +                               return;
> 
> Same for this one.
> 
> > +                       }
> > +               } else {
> >                         larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
> > +               }
> >         }
> >  }
> >
> > --
> > 1.9.1
> >
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


