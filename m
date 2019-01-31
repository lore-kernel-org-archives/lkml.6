Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48555C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A108218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfAaDmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:42:55 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:19409 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725771AbfAaDmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:42:55 -0500
X-UUID: b7c35e2b973740bfb33efe2f1bd92647-20190131
X-UUID: b7c35e2b973740bfb33efe2f1bd92647-20190131
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 449330715; Thu, 31 Jan 2019 11:42:43 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 11:42:41 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 11:42:41 +0800
Message-ID: <1548906161.19710.47.camel@mhfsdcap03>
Subject: Re: [PATCH v5 15/20] memory: mtk-smi: Invoke pm runtime_callback to
 enable clocks
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
Date:   Thu, 31 Jan 2019 11:42:41 +0800
In-Reply-To: <CAE=gft6XDC3YGe20iDOpCO0ASg99hucu7rKJwt+5i+3vgrEFvg@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
         <1546314952-15990-16-git-send-email-yong.wu@mediatek.com>
         <CAE=gft6XDC3YGe20iDOpCO0ASg99hucu7rKJwt+5i+3vgrEFvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-30 at 11:05 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > This patch only move the clk_prepare_enable and config_port into the
> > runtime suspend/resume callback. It doesn't change the code content
> > and sequence.
> >
> > This is a preparing patch for adjusting SMI_BUS_SEL for mt8183.
> > (SMI_BUS_SEL need to be restored after smi-common resume every time.)
> > Also it gives a chance to get rid of mtk_smi_larb_get/put which could
> > be a next topic.
> >
> > CC: Matthias Brugger <matthias.bgg@gmail.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> 
> I believe this refactoring is a no-op as described, because the order is still:
> 1) mtk_smi_clk_enable(common)
> 2) mtk_smi_clk_enable(larb)
> 3) larb_gen->config_port()
> 
> And teardown still happens in the opposite order, except for

Thanks your confirm.

> config_port, which they seem not to do in suspend.

After suspend, the HW engine should not work. config_port is not
helpful. At that time, use the HW default value.

> So, looks good to me.
> 
> Reviewed-by: Evan Green <evgreen@chromium.org>

Thanks.

> 
> > ---
> >  drivers/memory/mtk-smi.c | 113 ++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 72 insertions(+), 41 deletions(-)
> >
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index a430721..9790801 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -86,17 +86,13 @@ struct mtk_smi_larb { /* larb: local arbiter */
> >         u32                             *mmu;
> >  };
> >
> > -static int mtk_smi_enable(const struct mtk_smi *smi)
> > +static int mtk_smi_clk_enable(const struct mtk_smi *smi)
> >  {
> >         int ret;
> >
> > -       ret = pm_runtime_get_sync(smi->dev);
> > -       if (ret < 0)
> > -               return ret;
> > -
> >         ret = clk_prepare_enable(smi->clk_apb);
> >         if (ret)
> > -               goto err_put_pm;
> > +               return ret;
> >
> >         ret = clk_prepare_enable(smi->clk_smi);
> >         if (ret)
> > @@ -118,59 +114,28 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
> >         clk_disable_unprepare(smi->clk_smi);
> >  err_disable_apb:
> >         clk_disable_unprepare(smi->clk_apb);
> > -err_put_pm:
> > -       pm_runtime_put_sync(smi->dev);
> >         return ret;
> >  }
> >
> > -static void mtk_smi_disable(const struct mtk_smi *smi)
> > +static void mtk_smi_clk_disable(const struct mtk_smi *smi)
> >  {
> >         clk_disable_unprepare(smi->clk_gals1);
> >         clk_disable_unprepare(smi->clk_gals0);
> >         clk_disable_unprepare(smi->clk_smi);
> >         clk_disable_unprepare(smi->clk_apb);
> > -       pm_runtime_put_sync(smi->dev);
> >  }
> >
> >  int mtk_smi_larb_get(struct device *larbdev)
> >  {
> > -       struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
> > -       const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
> > -       struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
> > -       int ret;
> > +       int ret = pm_runtime_get_sync(larbdev);
> >
> > -       /* Enable the smi-common's power and clocks */
> > -       ret = mtk_smi_enable(common);
> > -       if (ret)
> > -               return ret;
> > -
> > -       /* Enable the larb's power and clocks */
> > -       ret = mtk_smi_enable(&larb->smi);
> > -       if (ret) {
> > -               mtk_smi_disable(common);
> > -               return ret;
> > -       }
> > -
> > -       /* Configure the iommu info for this larb */
> > -       larb_gen->config_port(larbdev);
> > -
> > -       return 0;
> > +       return (ret < 0) ? ret : 0;
> >  }
> >  EXPORT_SYMBOL_GPL(mtk_smi_larb_get);
> >
> >  void mtk_smi_larb_put(struct device *larbdev)
> >  {
> > -       struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
> > -       struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
> > -
> > -       /*
> > -        * Don't de-configure the iommu info for this larb since there may be
> > -        * several modules in this larb.
> > -        * The iommu info will be reset after power off.
> > -        */
> > -
> > -       mtk_smi_disable(&larb->smi);
> > -       mtk_smi_disable(common);
> > +       pm_runtime_put_sync(larbdev);
> >  }
> >  EXPORT_SYMBOL_GPL(mtk_smi_larb_put);
> >
> > @@ -385,12 +350,52 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > +static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
> > +{
> > +       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> > +       const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
> > +       int ret;
> > +
> > +       /* Power on smi-common. */
> > +       ret = pm_runtime_get_sync(larb->smi_common_dev);
> > +       if (ret < 0) {
> > +               dev_err(dev, "Failed to pm get for smi-common(%d).\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       ret = mtk_smi_clk_enable(&larb->smi);
> > +       if (ret < 0) {
> > +               dev_err(dev, "Failed to enable clock(%d).\n", ret);
> > +               pm_runtime_put_sync(larb->smi_common_dev);
> > +               return ret;
> > +       }
> > +
> > +       /* Configure the basic setting for this larb */
> > +       larb_gen->config_port(dev);
> > +
> > +       return 0;
> > +}
> > +
> > +static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
> > +{
> > +       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> > +
> > +       mtk_smi_clk_disable(&larb->smi);
> > +       pm_runtime_put_sync(larb->smi_common_dev);
> > +       return 0;
> > +}
> > +
> > +static const struct dev_pm_ops smi_larb_pm_ops = {
> > +       SET_RUNTIME_PM_OPS(mtk_smi_larb_suspend, mtk_smi_larb_resume, NULL)
> > +};
> > +
> >  static struct platform_driver mtk_smi_larb_driver = {
> >         .probe  = mtk_smi_larb_probe,
> >         .remove = mtk_smi_larb_remove,
> >         .driver = {
> >                 .name = "mtk-smi-larb",
> >                 .of_match_table = mtk_smi_larb_of_ids,
> > +               .pm             = &smi_larb_pm_ops,
> >         }
> >  };
> >
> > @@ -489,12 +494,38 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > +static int __maybe_unused mtk_smi_common_resume(struct device *dev)
> > +{
> > +       struct mtk_smi *common = dev_get_drvdata(dev);
> > +       int ret;
> > +
> > +       ret = mtk_smi_clk_enable(common);
> > +       if (ret) {
> > +               dev_err(common->dev, "Failed to enable clock(%d).\n", ret);
> > +               return ret;
> > +       }
> > +       return 0;
> > +}
> > +
> > +static int __maybe_unused mtk_smi_common_suspend(struct device *dev)
> > +{
> > +       struct mtk_smi *common = dev_get_drvdata(dev);
> > +
> > +       mtk_smi_clk_disable(common);
> > +       return 0;
> > +}
> > +
> > +static const struct dev_pm_ops smi_common_pm_ops = {
> > +       SET_RUNTIME_PM_OPS(mtk_smi_common_suspend, mtk_smi_common_resume, NULL)
> > +};
> > +
> >  static struct platform_driver mtk_smi_common_driver = {
> >         .probe  = mtk_smi_common_probe,
> >         .remove = mtk_smi_common_remove,
> >         .driver = {
> >                 .name = "mtk-smi-common",
> >                 .of_match_table = mtk_smi_common_of_ids,
> > +               .pm             = &smi_common_pm_ops,
> >         }
> >  };
> >
> > --
> > 1.9.1
> >


