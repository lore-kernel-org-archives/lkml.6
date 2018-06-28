Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121F0C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B045B2582E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B045B2582E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752233AbeF1Bod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 21:44:33 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:63321 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751172AbeF1Boc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 21:44:32 -0400
X-UUID: ec8d6c81d1994d92bc015cb420c86950-20180628
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 936062138; Thu, 28 Jun 2018 09:44:27 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Thu, 28 Jun
 2018 09:44:26 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 28 Jun 2018 09:44:25 +0800
Message-ID: <1530150265.28284.25.camel@mhfsdcap03>
Subject: Re: [PATCH 3/4] PCI: mediatek: Add system pm support for MT2712 and
 MT7622
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>, <hongkun.cao@mediatek.com>,
        <youlin.pei@mediatek.com>, <yong.wu@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>, <sean.wang@mediatek.com>
Date:   Thu, 28 Jun 2018 09:44:25 +0800
In-Reply-To: <CAHp75VcHgJrujzqstSc4RWpUbjip1vtJu87HN3uTosoLdOiT3A@mail.gmail.com>
References: <1530091298-28120-1-git-send-email-honghui.zhang@mediatek.com>
         <1530091298-28120-4-git-send-email-honghui.zhang@mediatek.com>
         <CAHp75VcHgJrujzqstSc4RWpUbjip1vtJu87HN3uTosoLdOiT3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-27 at 19:45 +0300, Andy Shevchenko wrote:
> On Wed, Jun 27, 2018 at 12:21 PM,  <honghui.zhang@mediatek.com> wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> >
> > The MTCMOS of PCIe Host for MT2712 and MT7622 will be off when system
> > suspend, and all the internal control register will be reset after system
> > resume. The PCIe link should be re-established and the related control
> > register values should be re-set after system resume.
> 
> >  struct mtk_pcie_soc {
> >         bool need_fix_class_id;
> 
> > +       bool pm_support;
> 
> Hmm... Do you really need this flag? Can't runtime PM API tell you this?

This host driver is both for MT2712, MT7622 and MT7623, but MT7623 do
not this this patch.
I only add this flag to identify whether we need to do the PM operation
for this SoC since I do not want to touch anything for MT7623.
 
> 
> >         struct pci_ops *ops;
> >         int (*startup)(struct mtk_pcie_port *port);
> >         int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
> > @@ -1195,12 +1197,76 @@ static int mtk_pcie_probe(struct platform_device *pdev)
> >         return err;
> >  }
> >
> > +#ifdef CONFIG_PM_SLEEP
> > +static int mtk_pcie_suspend_noirq(struct device *dev)
> 
> Perhaps __maybe_unused?

Ok, I'm a bit confused about this, if there's some discussion about
this, do you have the link of those discussion and kindly point put it
in this thread? Or I guess I can change this back to __maybe_unused if
there's no other comments about this.

> 
> > +{
> > +       struct mtk_pcie *pcie = dev_get_drvdata(dev);
> > +       const struct mtk_pcie_soc *soc = pcie->soc;
> > +       struct mtk_pcie_port *port;
> > +
> > +       if (!soc->pm_support)
> > +               return 0;
> > +
> 
> > +       if (list_empty(&pcie->ports))
> > +               return 0;
> 
> So, if the list is empty you are not suspending for the host?
> 

if the list was empty then it indicate that all the PCIe slot was not
connected with any EP device, and all the resource have been release in
probe time. So the host driver does not need to save or restore
anything.

> 
> > +
> > +       list_for_each_entry(port, &pcie->ports, list) {
> > +               clk_disable_unprepare(port->pipe_ck);
> > +               clk_disable_unprepare(port->obff_ck);
> > +               clk_disable_unprepare(port->axi_ck);
> > +               clk_disable_unprepare(port->aux_ck);
> > +               clk_disable_unprepare(port->ahb_ck);
> > +               clk_disable_unprepare(port->sys_ck);
> > +               phy_power_off(port->phy);
> > +               phy_exit(port->phy);
> > +       }
> > +
> > +       mtk_pcie_subsys_powerdown(pcie);
> > +
> > +       return 0;
> > +}
> > +
> > +static int mtk_pcie_resume_noirq(struct device *dev)
> > +{
> > +       struct mtk_pcie *pcie = dev_get_drvdata(dev);
> > +       const struct mtk_pcie_soc *soc = pcie->soc;
> > +       struct mtk_pcie_port *port;
> > +
> > +       if (!soc->pm_support)
> > +               return 0;
> > +
> 
> > +       if (list_empty(&pcie->ports))
> > +               return 0;
> 
> No runtime PM for this case?
> (It seems now I understand why in previous patch you have a similar check)
> 
I guess host driver does not need to resume anything if there's no EP
device was connected.

> > +
> > +       if (dev->pm_domain) {
> > +               pm_runtime_enable(dev);
> > +               pm_runtime_get_sync(dev);
> > +       }
> > +
> > +       clk_prepare_enable(pcie->free_ck);
> > +
> > +       list_for_each_entry(port, &pcie->ports, list)
> > +               mtk_pcie_enable_port(port);
> > +
> 
> > +       if (list_empty(&pcie->ports))
> 
> Hmm... How it would be true if you already bailed out above on the
> same condition?

Assuming that there's EP device connected before suspend, and the EP was
removed from the link while system suspend. It means that when enter
this function the list is not empty, but after the function of
mtk_pcie_enable_port was called, host driver found there's no EP device
was connected anymore, it will free this list and some other resources
in mtk_pcie_enable_port,(after mtk_pcie_enable_port was called, the list
is empty in this scenario) but leave the subsys power along, I guess we
need to take care of this scenario.
> 
> > +               mtk_pcie_subsys_powerdown(pcie);
> > +
> > +       return 0;
> > +}
> > +#endif
> > +
> > +static const struct dev_pm_ops mtk_pcie_pm_ops = {
> > +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_pcie_suspend_noirq,
> > +                                     mtk_pcie_resume_noirq)
> > +};
> > +
> >  static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
> >         .ops = &mtk_pcie_ops,
> >         .startup = mtk_pcie_startup_port,
> >  };
> >
> >  static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
> > +       .pm_support = true,
> >         .ops = &mtk_pcie_ops_v2,
> >         .startup = mtk_pcie_startup_port_v2,
> >         .setup_irq = mtk_pcie_setup_irq,
> 
> No update for .pm ?

I'm not get your point, I update the .pm callbacks in the
platform_driver struct, this SoC data just store the different
information for SoCs. Did I missed something?

> 
> > @@ -1208,6 +1274,7 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
> >
> >  static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
> >         .need_fix_class_id = true,
> > +       .pm_support = true,
> >         .ops = &mtk_pcie_ops_v2,
> >         .startup = mtk_pcie_startup_port_v2,
> >         .setup_irq = mtk_pcie_setup_irq,
> > @@ -1227,6 +1294,7 @@ static struct platform_driver mtk_pcie_driver = {
> >                 .name = "mtk-pcie",
> >                 .of_match_table = mtk_pcie_ids,
> >                 .suppress_bind_attrs = true,
> > +               .pm = &mtk_pcie_pm_ops,
> >         },
> >  };
> >  builtin_platform_driver(mtk_pcie_driver);
> > --
> > 2.6.4
> >
> 
> 
> 


