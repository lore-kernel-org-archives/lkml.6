Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B94CC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BAC20870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbfBAJmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:42:42 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:56047 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726116AbfBAJml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:42:41 -0500
X-UUID: 956c5f8fe85245a18646b25dceae52e1-20190201
X-UUID: 956c5f8fe85245a18646b25dceae52e1-20190201
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 567560713; Fri, 01 Feb 2019 17:42:22 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 17:42:20 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 17:42:19 +0800
Message-ID: <1549014139.12663.26.camel@mhfsdcap03>
Subject: Re: [PATCH v5 17/20] memory: mtk-smi: Get rid of need_larbid
From:   Yong Wu <yong.wu@mediatek.com>
To:     Evan Green <evgreen@chromium.org>
CC:     <youlin.pei@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, <srv_heupstream@mediatek.com>,
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
Date:   Fri, 1 Feb 2019 17:42:19 +0800
In-Reply-To: <CAE=gft6do4Ku7ErqxY2tbPwqDN_3w6i_ygxvyUSyXLYzxvNwTg@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
         <1546314952-15990-18-git-send-email-yong.wu@mediatek.com>
         <CAE=gft4vOxt7G0CqZxvNUxCmuGq_L4wc2Wv6LF4Y62BoJQEUXw@mail.gmail.com>
         <1548904937.19710.39.camel@mhfsdcap03>
         <CAE=gft6do4Ku7ErqxY2tbPwqDN_3w6i_ygxvyUSyXLYzxvNwTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-31 at 09:45 -0800, Evan Green wrote:
> On Wed, Jan 30, 2019 at 7:22 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > On Wed, 2019-01-30 at 11:11 -0800, Evan Green wrote:
> > > On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > > >
> > > > The "mediatek,larb-id" has already been parsed in MTK IOMMU driver.
> > > > It's no need to parse it again in SMI driver. Only clean some codes.
> > > > This patch is fit for all the current mt2701, mt2712, mt7623, mt8173
> > > > and mt8183.
> > > >
> > > > After this patch, the "mediatek,larb-id" only be needed for mt2712
> > > > which have 2 M4Us. In the other SoCs, we can get the larb-id from M4U
> > > > in which the larbs in the "mediatek,larbs" always are ordered.
> > > >
> > > > CC: Matthias Brugger <matthias.bgg@gmail.com>
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > ---
> > > >  drivers/memory/mtk-smi.c | 26 ++------------------------
> > > >  1 file changed, 2 insertions(+), 24 deletions(-)
> > > >
> > > > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > > > index 08cf40d..10e6493 100644
> > > > --- a/drivers/memory/mtk-smi.c
> > > > +++ b/drivers/memory/mtk-smi.c
> > > > @@ -67,7 +67,6 @@ struct mtk_smi_common_plat {
> > > >  };
> > > >
> > > >  struct mtk_smi_larb_gen {
> > > > -       bool need_larbid;
> > > >         int port_in_larb[MTK_LARB_NR_MAX + 1];
> > > >         void (*config_port)(struct device *);
> > > >         unsigned int larb_direct_to_common_mask;
> > > > @@ -153,18 +152,9 @@ void mtk_smi_larb_put(struct device *larbdev)
> > > >         struct mtk_smi_iommu *smi_iommu = data;
> > > >         unsigned int         i;
> > > >
> > > > -       if (larb->larb_gen->need_larbid) {
> > > > -               larb->mmu = &smi_iommu->larb_imu[larb->larbid].mmu;
> > > > -               return 0;
> > > > -       }
> > > > -
> > > > -       /*
> > > > -        * If there is no larbid property, Loop to find the corresponding
> > > > -        * iommu information.
> > > > -        */
> > > > -       for (i = 0; i < smi_iommu->larb_nr; i++) {
> > > > +       for (i = 0; i < MTK_LARB_NR_MAX; i++) {
> > >
> > > Looks like this was the only use of mtk_smi_iommu.larb_nr. Should we
> > > remove that now?
> >
> > This is necessary since the mt2712 which has two M4U HW.
> >
> > From its dtsi[1], take iommu1 as a example, its larb_nr only is 3, but
> > we need scan all the larb.
> >
> > [1]
> > http://lists.infradead.org/pipermail/linux-mediatek/2018-December/016119.html
> 
> I'm not sure I follow. My point was that this structure member is only
> ever set but never read:
> $ git grep '[.>]larb_nr'
> drivers/iommu/mtk_iommu.c:      data->smi_imu.larb_nr = larb_nr;
> drivers/iommu/mtk_iommu_v1.c:   data->smi_imu.larb_nr = larb_nr;
> 
> Maybe I've applied the patches to the wrong tree, and there is a use
> of this member I'm not seeing?

Thanks. I misunderstood. It looks right, this variable can be deleted I
didn't realize this. Maybe I need use a new patch for this.

> -Evan


