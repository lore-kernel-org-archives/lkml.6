Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1460DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30F021906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732795AbeLUIDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:03:04 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:38213 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732379AbeLUIDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:03:01 -0500
X-UUID: 825da9160cde4d3f86d22be463450247-20181221
X-UUID: 825da9160cde4d3f86d22be463450247-20181221
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 967893425; Fri, 21 Dec 2018 16:02:49 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 21 Dec
 2018 16:02:47 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 21 Dec 2018 16:02:46 +0800
Message-ID: <1545379367.29587.53.camel@mhfsdcap03>
Subject: Re: [PATCH v4 13/18] memory: mtk-smi: Add bus_sel for mt8183
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
Date:   Fri, 21 Dec 2018 16:02:47 +0800
In-Reply-To: <CANMq1KA4GLZHcDH31=W==8BTBZOVbRX9HBTJrpPFNQ3rWaM4xg@mail.gmail.com>
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
         <1544258371-4600-14-git-send-email-yong.wu@mediatek.com>
         <CANMq1KA4GLZHcDH31=W==8BTBZOVbRX9HBTJrpPFNQ3rWaM4xg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-21 at 12:47 +0800, Nicolas Boichat wrote:
> On Sat, Dec 8, 2018 at 4:43 PM Yong Wu <yong.wu@mediatek.com> wrote:
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
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/memory/mtk-smi.c | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index ee6165e..88eb61a 100644
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
> > @@ -409,6 +416,8 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
> >  static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
> >         .gen      = MTK_SMI_GEN2,
> >         .has_gals = true,
> > +       .bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
> > +                   F_MMU1_LARB(7),
> 
> Maybe it's ok for now, but I wonder if this is something that should
> be specified in device tree? Maybe different applications will want
> different larb split between MMU0 and MMU1?

Good question. Many Thanks. This value is recommended from the HW DE. In
some SoCs, It may be different in different scenarios. and in some SoCs
like mt8183, the bus_sel always use a fixed value.

I guess it should not be in device tree if it may be changed in
different applications.

BTW, Is there some existed IOCTL command or the similar interface that
can tell the kernel driver(SMI here) which scenario it is currently,
like it is playing video or the camera is running. 

Currently the SMI driver is so simple, it doesn't know which application
it is. All use the HW default value. of course, the default also is ok,
only the bandwidth may be not so good.

For the bus_sel of mt8183, I think it is ok right now. Sure, it can be
improved if we can change it dynamically.

> 
> >  };
> >
> >  static const struct of_device_id mtk_smi_common_of_ids[] = {
> > @@ -481,6 +490,11 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
> >                 ret = clk_prepare_enable(common->clk_async);
> >                 if (ret)
> >                         return ret;
> > +       } else {
> > +               res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +               common->base = devm_ioremap_resource(dev, res);
> > +               if (IS_ERR(common->base))
> > +                       return PTR_ERR(common->base);
> >         }
> >         pm_runtime_enable(dev);
> >         platform_set_drvdata(pdev, common);
> > @@ -496,6 +510,7 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
> >  static int __maybe_unused mtk_smi_common_resume(struct device *dev)
> >  {
> >         struct mtk_smi *common = dev_get_drvdata(dev);
> > +       u32 bus_sel = common->plat->bus_sel;
> >         int ret;
> >
> >         ret = mtk_smi_clk_enable(common);
> > @@ -503,6 +518,9 @@ static int __maybe_unused mtk_smi_common_resume(struct device *dev)
> >                 dev_err(common->dev, "Failed to enable clock(%d).\n", ret);
> >                 return ret;
> >         }
> > +
> > +       if (common->plat->gen == MTK_SMI_GEN2 && bus_sel)
> > +               writel(bus_sel, common->base + SMI_BUS_SEL);
> >         return 0;
> >  }
> >
> > --
> > 1.9.1
> >


