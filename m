Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83606C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAD8218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbfAaDUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:20:22 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:65350 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725535AbfAaDUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:20:22 -0500
X-UUID: d404c1537c0e4a5eac60dab241d354fe-20190131
X-UUID: d404c1537c0e4a5eac60dab241d354fe-20190131
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 807383524; Thu, 31 Jan 2019 11:20:11 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 11:20:09 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 11:20:08 +0800
Message-ID: <1548904808.19710.35.camel@mhfsdcap03>
Subject: Re: [PATCH v5 16/20] memory: mtk-smi: Add bus_sel for mt8183
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
Date:   Thu, 31 Jan 2019 11:20:08 +0800
In-Reply-To: <CAE=gft4q3oj+oQ=Vo-kGD7OYTO0_WMf8t4SLa_H7SCH8G2VFOw@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
         <1546314952-15990-17-git-send-email-yong.wu@mediatek.com>
         <CAE=gft4q3oj+oQ=Vo-kGD7OYTO0_WMf8t4SLa_H7SCH8G2VFOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-30 at 11:07 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > There are 2 mmu cells in a M4U HW. we could adjust some larbs entering
> > mmu0 or mmu1 to balance the bandwidth via the smi-common register
> > SMI_BUS_SEL(0x220)(Each larb occupy 2 bits).
> >
> > In mt8183, For better performance, we switch larb1/2/5/7 to enter
> > mmu1 while the others still keep enter mmu0.
> >
> > In mt8173 and mt2712, we don't get the performance issue,
> > Keep its default value(0x0), that means all the larbs enter mmu0.
> >
> > Note: smi gen1(mt2701/mt7623) don't have this bus_sel.
> >
> > CC: Matthias Brugger <matthias.bgg@gmail.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/memory/mtk-smi.c | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index 9790801..08cf40d 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -49,6 +49,12 @@
> >  #define SMI_LARB_NONSEC_CON(id)        (0x380 + ((id) * 4))
> >  #define F_MMU_EN               BIT(0)
> >
> > +/* SMI COMMON */
> > +#define SMI_BUS_SEL                    0x220
> > +#define SMI_BUS_LARB_SHIFT(larbid)     ((larbid) << 1)
> > +/* All are MMU0 defaultly. Only specialize mmu1 here. */
> > +#define F_MMU1_LARB(larbid)            (0x1 << SMI_BUS_LARB_SHIFT(larbid))
> > +
> >  enum mtk_smi_gen {
> >         MTK_SMI_GEN1,
> >         MTK_SMI_GEN2
> > @@ -57,6 +63,7 @@ enum mtk_smi_gen {
> >  struct mtk_smi_common_plat {
> >         enum mtk_smi_gen gen;
> >         bool             has_gals;
> > +       u32              bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
> >  };
> >
> >  struct mtk_smi_larb_gen {
> > @@ -72,8 +79,8 @@ struct mtk_smi {
> >         struct clk                      *clk_apb, *clk_smi;
> >         struct clk                      *clk_gals0, *clk_gals1;
> >         struct clk                      *clk_async; /*only needed by mt2701*/
> > -       void __iomem                    *smi_ao_base;
> > -
> > +       void __iomem                    *smi_ao_base; /* only for gen1 */
> > +       void __iomem                    *base;        /* only for gen2 */
> >         const struct mtk_smi_common_plat *plat;
> >  };
> >
> > @@ -410,6 +417,8 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
> >  static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
> >         .gen      = MTK_SMI_GEN2,
> >         .has_gals = true,
> > +       .bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
> > +                   F_MMU1_LARB(7),
> >  };
> >
> >  static const struct of_device_id mtk_smi_common_of_ids[] = {
> > @@ -482,6 +491,11 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
> >                 ret = clk_prepare_enable(common->clk_async);
> >                 if (ret)
> >                         return ret;
> > +       } else {
> > +               res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +               common->base = devm_ioremap_resource(dev, res);
> > +               if (IS_ERR(common->base))
> > +                       return PTR_ERR(common->base);
> 
> So you split base and smi_ao_base because they're completely different
> register regions, or because ->base is no longer "always on"? It's
> tempting to recombine them because they appear to be mutually
> exclusive, but if they're truly different register regions then I
> understand.

They are completely different. the common->base is the smi-common normal
base while the common->smi_ao_base only exist in smi-gen1.


