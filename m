Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F69C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6C42133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfB0Odp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:33:45 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:57075 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730222AbfB0Odo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:33:44 -0500
X-UUID: 32ccbe40588d4c92bb112a32100dda41-20190227
X-UUID: 32ccbe40588d4c92bb112a32100dda41-20190227
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1938627348; Wed, 27 Feb 2019 22:33:35 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 27 Feb
 2019 22:33:33 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Feb 2019 22:33:32 +0800
Message-ID: <1551278012.17917.51.camel@mhfsdcap03>
Subject: Re: [PATCH 11/13] iommu/mediatek: Use builtin_platform_driver
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
Date:   Wed, 27 Feb 2019 22:33:32 +0800
In-Reply-To: <CAE=gft4Z_C0NRmP0A_rnDzvB3txt3cGV=rvZhJOQZk_1qahiQQ@mail.gmail.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
         <1546318276-18993-12-git-send-email-yong.wu@mediatek.com>
         <CAE=gft4Z_C0NRmP0A_rnDzvB3txt3cGV=rvZhJOQZk_1qahiQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-25 at 15:56 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 8:53 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > MediaTek IOMMU should wait for smi larb which need wait for the
> > power domain(mtk-scpsys.c) and the multimedia ccf who both are
> > module init. Thus, subsys_initcall for MediaTek IOMMU is not helpful.
> > Switch to builtin_platform_driver.
> >
> > Meanwhile, the ".remove" can be removed. Move its content to
> > ".shutdown".
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c    | 23 ++---------------------
> >  drivers/iommu/mtk_iommu_v1.c | 16 ++--------------
> >  2 files changed, 4 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 735ae8d..2798b12 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -690,7 +690,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >         return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
> >  }
> >
> > -static int mtk_iommu_remove(struct platform_device *pdev)
> > +static void mtk_iommu_shutdown(struct platform_device *pdev)
> >  {
> >         struct mtk_iommu_data *data = platform_get_drvdata(pdev);
> >
> > @@ -703,12 +703,6 @@ static int mtk_iommu_remove(struct platform_device *pdev)
> >         clk_disable_unprepare(data->bclk);
> >         devm_free_irq(&pdev->dev, data->irq, data);
> >         component_master_del(&pdev->dev, &mtk_iommu_com_ops);
> > -       return 0;
> > -}
> > -
> > -static void mtk_iommu_shutdown(struct platform_device *pdev)
> > -{
> > -       mtk_iommu_remove(pdev);
> 
> Is there a reason all these things are happening in shutdown()? Don't
> we normally just not clean things up and let the machine turn off?
> Normally I'm a big advocate of proper symmetric teardown, so it hurts
> a little to ask.

In this patch I change the driver to builtin driver. I guess the
"_remove" is not helpful now. thus I remove it.

About the shutdown, I don't have a special reason for it. I only want to
mute the m4u log when something go wrong in the shutdown flow.

> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


