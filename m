Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6730DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0742133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbfB0OdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:33:16 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:3774 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730222AbfB0OdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:33:16 -0500
X-UUID: f55e4a5a8f51462190eff2082b83c161-20190227
X-UUID: f55e4a5a8f51462190eff2082b83c161-20190227
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1393374690; Wed, 27 Feb 2019 22:33:07 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 27 Feb
 2019 22:33:05 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Feb 2019 22:33:05 +0800
Message-ID: <1551277985.17917.48.camel@mhfsdcap03>
Subject: Re: [PATCH 05/13] memory: mtk-smi: Add device-link between smi-larb
 and smi-common
From:   Yong Wu <yong.wu@mediatek.com>
To:     Evan Green <evgreen@chromium.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
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
Date:   Wed, 27 Feb 2019 22:33:05 +0800
In-Reply-To: <CAE=gft71J+5ui_FFm4D+62uSy6KHYzT7wru_NNdPsvrCDV3ekw@mail.gmail.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
         <1546318276-18993-6-git-send-email-yong.wu@mediatek.com>
         <CAE=gft71J+5ui_FFm4D+62uSy6KHYzT7wru_NNdPsvrCDV3ekw@mail.gmail.com>
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
> > Normally, If the smi-larb HW need work, we should enable the smi-common
> > HW power and clock firstly.
> > This patch adds device-link between the smi-larb dev and the smi-common
> > dev. then If pm_runtime_get_sync(smi-larb-dev), the pm_runtime_get_sync
> > (smi-common-dev) will be called automatically.
> >
> > Since smi is built-in driver like IOMMU and never unbound,
> > DL_FLAG_AUTOREMOVE_* is not needed.
> >
> > CC: Matthias Brugger <matthias.bgg@gmail.com>
> > Suggested-by: Tomasz Figa <tfiga@chromium.org>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/memory/mtk-smi.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index 9688341..30930e4 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -271,6 +271,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
> >         struct device *dev = &pdev->dev;
> >         struct device_node *smi_node;
> >         struct platform_device *smi_pdev;
> > +       struct device_link *link;
> >
> >         larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
> >         if (!larb)
> > @@ -310,6 +311,12 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
> >                 if (!platform_get_drvdata(smi_pdev))
> >                         return -EPROBE_DEFER;
> >                 larb->smi_common_dev = &smi_pdev->dev;
> > +               link = device_link_add(dev, larb->smi_common_dev,
> > +                                      DL_FLAG_PM_RUNTIME);
> 
> Doesn't this need to be torn down in remove()? You mention that it's
> built-in and never removed, but it does seem to have a remove()

The MTK IOMMU driver need depend on this SMI driver. the IOMMU is a
builtin driver, thus the SMI also should be a builtin driver.

Technically, If the driver is builtin, then the "remove" function can be
removed? If yes, I could use a new patch do it.

It looks the MACRO(builtin_platform_driver) only support one driver, but
we have two driver(smi-common and smi-larb) here.

> function that tears down everything else, so it seemed a shame to
> start leaking now. Maybe the AUTOREMOVE flag would do it.


