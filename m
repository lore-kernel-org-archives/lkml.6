Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2954C282D8
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA3220870
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbfAaDWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:22:38 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:47111 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725535AbfAaDWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:22:37 -0500
X-UUID: ed683dd48cba48979fdad166c2250e71-20190131
X-UUID: ed683dd48cba48979fdad166c2250e71-20190131
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 63297672; Thu, 31 Jan 2019 11:22:33 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 11:22:31 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 11:22:31 +0800
Message-ID: <1548904951.19710.41.camel@mhfsdcap03>
Subject: Re: [PATCH v5 14/20] iommu/mediatek: Add mmu1 support
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
Date:   Thu, 31 Jan 2019 11:22:31 +0800
In-Reply-To: <CAE=gft58E0p3KEYLtKZBfvGysNq+CfX5LDR38incdM+tjDr-1g@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
         <1546314952-15990-15-git-send-email-yong.wu@mediatek.com>
         <CAE=gft58E0p3KEYLtKZBfvGysNq+CfX5LDR38incdM+tjDr-1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-30 at 10:55 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > Normally the M4U HW connect EMI with smi. the diagram is like below:
> >               EMI
> >                |
> >               M4U
> >                |
> >             smi-common
> >                |
> >        -----------------
> >        |    |    |     |    ...
> >     larb0 larb1  larb2 larb3
> >
> > Actually there are 2 mmu cells in the M4U HW, like this diagram:
> >
> >               EMI
> >            ---------
> >             |     |
> >            mmu0  mmu1     <- M4U
> >             |     |
> >            ---------
> >                |
> >             smi-common
> >                |
> >        -----------------
> >        |    |    |     |    ...
> >     larb0 larb1  larb2 larb3
> >
> > This patch add support for mmu1. In order to get better performance,
> > we could adjust some larbs go to mmu1 while the others still go to
> > mmu0. This is controlled by a SMI COMMON register SMI_BUS_SEL(0x220).
> >
> > mt2712, mt8173 and mt8183 M4U HW all have 2 mmu cells. the default
> > value of that register is 0 which means all the larbs go to mmu0
> > defaultly.
> >
> > This is a preparing patch for adjusting SMI_BUS_SEL for mt8183.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 47 +++++++++++++++++++++++++++++------------------
> >  1 file changed, 29 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 66e3615..7fcef19 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -70,27 +70,32 @@
> >  #define F_MISS_FIFO_ERR_INT_EN                 BIT(6)
> >  #define F_INT_CLR_BIT                          BIT(12)
> >
> > -#define REG_MMU_INT_MAIN_CONTROL               0x124
> > -#define F_INT_TRANSLATION_FAULT                        BIT(0)
> > -#define F_INT_MAIN_MULTI_HIT_FAULT             BIT(1)
> > -#define F_INT_INVALID_PA_FAULT                 BIT(2)
> > -#define F_INT_ENTRY_REPLACEMENT_FAULT          BIT(3)
> > -#define F_INT_TLB_MISS_FAULT                   BIT(4)
> > -#define F_INT_MISS_TRANSACTION_FIFO_FAULT      BIT(5)
> > -#define F_INT_PRETETCH_TRANSATION_FIFO_FAULT   BIT(6)
> > +#define REG_MMU_INT_MAIN_CONTROL               0x124 /* mmu0 | mmu1 */
> 
> The comment being on that line is kind of weird, since the comment
> really applies to the lines below it. Maybe the comment should be on
> its own line, or on the TRANSLATION_FAULT line.

Sharp eye. You are right, this comment applies the lines below.
But If I move it below, then the next line will be over 80 chars.

How about I add a "below:" like this: 
> +#define REG_MMU_INT_MAIN_CONTROL               0x124 /* below: mmu0 |
mmu1 */

> 
> Other than that,
> Reviewed-by: Evan Green <evgreen@chromium.org>


