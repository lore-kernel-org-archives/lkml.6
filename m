Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A849C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256B42133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbfB0Od3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:33:29 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:54175 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730222AbfB0Od3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:33:29 -0500
X-UUID: ce4db0ea793c41548216446ed4da2f96-20190227
X-UUID: ce4db0ea793c41548216446ed4da2f96-20190227
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1687198339; Wed, 27 Feb 2019 22:33:22 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 27 Feb
 2019 22:33:20 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Feb 2019 22:33:20 +0800
Message-ID: <1551278000.17917.50.camel@mhfsdcap03>
Subject: Re: [PATCH 02/13] driver core: Remove the link if there is no
 driver with AUTO flag
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
Date:   Wed, 27 Feb 2019 22:33:20 +0800
In-Reply-To: <CAE=gft7mWs1jc+KQQcPuuhcmxpFRnRBTt35+uC3F20N6R554bQ@mail.gmail.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
         <1546318276-18993-3-git-send-email-yong.wu@mediatek.com>
         <CAE=gft7mWs1jc+KQQcPuuhcmxpFRnRBTt35+uC3F20N6R554bQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-25 at 15:53 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > DL_FLAG_AUTOREMOVE_CONSUMER/SUPPLIER means "Remove the link
> > automatically on consumer/supplier driver unbind", that means we should
> > remove whole the device_link when there is no this driver no matter what
> > the ref_count of the link is.
> >
> > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> > The ref_count of our device_link normally is over 1. When the consumer
> > device driver is removed, whole the device_link should be removed.
> > Thus, I add this patch.
> > ---
> 
> I will admit to reading about device links for the first time while
> reviewing this patch, but I don't really get this. Why use a kref at
> all if we're just going to ignore its value? For instance, I see that
> if you call device_link_add() with the same supplier and consumer, it
> uses the kref to return the same link. That machinery is broken with
> your change. Although I don't see any uses of it, you might also
> expect a supplier or consumer could do a kref_get() on the link it got
> back from device_link_add(), and have a reasonable expectation that
> the link wouldn't be freed out from under it. This would also be
> broken.
> 
> Can you explain why your device_links normally have a reference count
> >1, 

I use device link between the smi-larb device and the iommu-consumer
device. Take a example, smi-larb1 have 4 VDEC ports. From 4/13 in this
patchset, we use device_link to link the VDEC device and the smi-larb1
device in the function(mtk_iommu_config). since there are 4 ports, it
will call device_link_add 4 times.

>
> and why those additional references can't be cleaned up in an
> orderly fashion?

If the iommu-consume device(like VDEC above) is removed, It should enter
device_links_driver_cleanup which only ref_put one time. I guess whole
the link should be removed at that time.

> 
> (To be honest, I don't really understand the case for the AUTOREMOVE
> flags at all. Is there some case where the party that set up the link
> can't tear it down? Or is this a way to devm_ify the link, where devm
> itself doesn't work because the links themselves stall out that
> mechanism?)

