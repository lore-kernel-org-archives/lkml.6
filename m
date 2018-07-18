Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CA3ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8CE20858
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8CE20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeGRGjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:39:14 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:56503 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725975AbeGRGjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:39:14 -0400
X-UUID: 98ea0ea218734344a85327ead7dfd4d9-20180718
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 525608885; Wed, 18 Jul 2018 14:02:43 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Wed, 18 Jul
 2018 14:02:42 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 18 Jul 2018 14:02:41 +0800
Message-ID: <1531893761.31406.15.camel@mhfsdcap03>
Subject: Re: [PATCH v3 3/4] PCI: mediatek: Add system pm support for MT2712
 and MT7622
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <marc.zyngier@arm.com>, <bhelgaas@google.com>,
        <matthias.bgg@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>, <hongkun.cao@mediatek.com>,
        <youlin.pei@mediatek.com>, <yong.wu@mediatek.com>,
        <yt.shen@mediatek.com>, <sean.wang@mediatek.com>,
        <rjw@rjwysocki.net>, <khilman@kernel.org>, <ulf.hansson@linaro.org>
Date:   Wed, 18 Jul 2018 14:02:41 +0800
In-Reply-To: <20180717171543.GA20991@red-moon>
References: <1530518264-6125-1-git-send-email-honghui.zhang@mediatek.com>
         <1530518264-6125-4-git-send-email-honghui.zhang@mediatek.com>
         <20180717171543.GA20991@red-moon>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 18:15 +0100, Lorenzo Pieralisi wrote:
> [+Rafael, Kevin, Ulf]
> 
> On Mon, Jul 02, 2018 at 03:57:43PM +0800, honghui.zhang@mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > The MTCMOS of PCIe Host for MT2712 and MT7622 will be off when system
> > suspend, and all the internal control register will be reset after system
> > resume. The PCIe link should be re-established and the related control
> > register values should be re-set after system resume.
> > 
> > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek.c | 67 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index 86918d4..175d7b6 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> > @@ -134,12 +134,14 @@ struct mtk_pcie_port;
> >  /**
> >   * struct mtk_pcie_soc - differentiate between host generations
> >   * @need_fix_class_id: whether this host's class ID needed to be fixed or not
> > + * @pm_support: whether the host's MTCMOS will be off when suspend
> >   * @ops: pointer to configuration access functions
> >   * @startup: pointer to controller setting functions
> >   * @setup_irq: pointer to initialize IRQ functions
> >   */
> >  struct mtk_pcie_soc {
> >  	bool need_fix_class_id;
> > +	bool pm_support;
> >  	struct pci_ops *ops;
> >  	int (*startup)(struct mtk_pcie_port *port);
> >  	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
> > @@ -1197,12 +1199,75 @@ static int mtk_pcie_probe(struct platform_device *pdev)
> >  	return err;
> >  }
> >  
> > +static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
> > +{
> > +	struct mtk_pcie *pcie = dev_get_drvdata(dev);
> > +	const struct mtk_pcie_soc *soc = pcie->soc;
> > +	struct mtk_pcie_port *port;
> > +
> > +	if (!soc->pm_support)
> > +		return 0;
> > +
> > +	if (list_empty(&pcie->ports))
> > +		return 0;
> > +
> > +	list_for_each_entry(port, &pcie->ports, list) {
> > +		clk_disable_unprepare(port->pipe_ck);
> > +		clk_disable_unprepare(port->obff_ck);
> > +		clk_disable_unprepare(port->axi_ck);
> > +		clk_disable_unprepare(port->aux_ck);
> > +		clk_disable_unprepare(port->ahb_ck);
> > +		clk_disable_unprepare(port->sys_ck);
> > +		phy_power_off(port->phy);
> > +		phy_exit(port->phy);
> > +	}
> > +
> > +	mtk_pcie_subsys_powerdown(pcie);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
> > +{
> > +	struct mtk_pcie *pcie = dev_get_drvdata(dev);
> > +	const struct mtk_pcie_soc *soc = pcie->soc;
> > +	struct mtk_pcie_port *port, *tmp;
> > +
> > +	if (!soc->pm_support)
> > +		return 0;
> > +
> > +	if (list_empty(&pcie->ports))
> > +		return 0;
> > +
> > +	if (dev->pm_domain) {
> > +		pm_runtime_enable(dev);
> > +		pm_runtime_get_sync(dev);
> > +	}
> 
> Are these runtime PM calls needed/abused here ?
> 
> Mind explaining the logic ?
> 
> There is certainly an asymmetry with the suspend callback which made me
> suspicious, I am pretty certain Rafael/Kevin/Ulf can help me clarify so
> that we can make progress with this patch.
> 
> Lorenzo
> 
Hi Lorenzo, thanks for your comments.
Sorry I don't get you.
I believe that in suspend callbacks the pm_runtime_put_sync and
pm_runtime_disable should be called to gated the CMOS for this module,
while the pm_rumtime_enable and pm_rumtime_get_sync should be called in
resume callback.

That's exactly this patch doing.
But the pm_rumtime_put_sync and pm_runtime_disable functions was wrapped
in the mtk_pcie_subsys_powerdown.

I did not call mtk_pcie_subsys_powerup since it does not just wrapped
pm_rumtime related functions but also do the platform_resource_get,
devm_ioremap, and free_ck clock get which I do not needed in resume
callback.

Do you think it will be much clear if I abstract the
platform_resource_get, devm_ioremap functions from
mtk_pcie_subsys_powerup and put it to a new functions like
mtk_pcie_subsys_resource_get, and then we may call the
mtk_pcie_subsys_powerup in the resume function?

thanks
> > +
> > +	clk_prepare_enable(pcie->free_ck);
> > +
> > +	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> > +		mtk_pcie_enable_port(port);
> > +
> > +	/* In case of EP was removed while system suspend. */
> > +	if (list_empty(&pcie->ports))
> > +		mtk_pcie_subsys_powerdown(pcie);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dev_pm_ops mtk_pcie_pm_ops = {
> > +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_pcie_suspend_noirq,
> > +				      mtk_pcie_resume_noirq)
> > +};
> > +
> >  static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
> >  	.ops = &mtk_pcie_ops,
> >  	.startup = mtk_pcie_startup_port,
> >  };
> >  
> >  static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
> > +	.pm_support = true,
> >  	.ops = &mtk_pcie_ops_v2,
> >  	.startup = mtk_pcie_startup_port_v2,
> >  	.setup_irq = mtk_pcie_setup_irq,
> > @@ -1210,6 +1275,7 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
> >  
> >  static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
> >  	.need_fix_class_id = true,
> > +	.pm_support = true,
> >  	.ops = &mtk_pcie_ops_v2,
> >  	.startup = mtk_pcie_startup_port_v2,
> >  	.setup_irq = mtk_pcie_setup_irq,
> > @@ -1229,6 +1295,7 @@ static struct platform_driver mtk_pcie_driver = {
> >  		.name = "mtk-pcie",
> >  		.of_match_table = mtk_pcie_ids,
> >  		.suppress_bind_attrs = true,
> > +		.pm = &mtk_pcie_pm_ops,
> >  	},
> >  };
> >  builtin_platform_driver(mtk_pcie_driver);
> > -- 
> > 2.6.4
> > 


