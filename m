Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8112C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F7E213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbfB0OeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:34:11 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:27457 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726866AbfB0OeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:34:10 -0500
X-UUID: 986e6f0e674e4a369015d4b8e0b45207-20190227
X-UUID: 986e6f0e674e4a369015d4b8e0b45207-20190227
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 357067242; Wed, 27 Feb 2019 22:33:56 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 27 Feb
 2019 22:33:55 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Feb 2019 22:33:54 +0800
Message-ID: <1551278034.17917.52.camel@mhfsdcap03>
Subject: Re: [PATCH 03/13] iommu/mediatek: Add probe_defer for smi-larb
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
Date:   Wed, 27 Feb 2019 22:33:54 +0800
In-Reply-To: <CAE=gft4aJxXbrecehAhgYL0TANxdwukmdQtpiLgNkzCDAUO6Cg@mail.gmail.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
         <1546318276-18993-4-git-send-email-yong.wu@mediatek.com>
         <CAE=gft4aJxXbrecehAhgYL0TANxdwukmdQtpiLgNkzCDAUO6Cg@mail.gmail.com>
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
> > The iommu consumer should use device_link to connect with the
> > smi-larb(supplier). then the smi-larb should run before the iommu
> > consumer. Here we delay the iommu driver until the smi driver is
> > ready, then all the iommu consumer always is after the smi driver.
> >
> > When there is no this patch, if some consumer drivers run before
> > smi-larb, the supplier link_status is DL_DEV_NO_DRIVER(0) in the
> > device_link_add, then device_links_driver_bound will use WARN_ON
> > to complain that the link_status of supplier is not right.
> >
> 
> I don't quite have enough knowledge of device links to figure out if
> this is a) the right fix, b) a deficiency in the device_links code, or
> c) neither.

I can not say more about the device link, But from the MTK iommu point
of view, it looks a right fix. As the comment above, we should make sure
the probe sequence, SMI-larb should be before MTK IOMMU which need be
before iommu-consumer. this patch help SMI-larb always is before
MTK_IOMMU.

Then if there is no this patchset, what the MTK_IOMMU will happen?.

The MTK_IOMMU is subsys_initcall, all the consume only need after the
MTK_IOMMU and don't need wait for SMI-larb driver. If some consume run
before SMI-larb driver, It also is OK while it don't call
mtk_smi_larb_get in this probe.(Of course it will abort if it call this
while smi-driver don't probe at that time). the consumer and smi-larb
normally are module_init, we can not guarantee the the sequence. it is a
potential issue.

Some consume know it should wait for SMI-larb like [1], but It don't
work.

[1]
https://elixir.bootlin.com/linux/v5.0-rc1/source/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c#L145

> 
> Perhaps someone else could chime in on this one.
> -Evan
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


