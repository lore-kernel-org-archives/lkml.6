Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754049AbeEaHhv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 03:37:51 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:6503 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753972AbeEaHht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 03:37:49 -0400
X-UUID: 1ad1ee7bc0b04c73b3542731e1a60304-20180531
Message-ID: <1527752260.28160.3.camel@mhfsdcap03>
Subject: Re: [PATCH] PCI: mediatek: Add system pm support for MT2712
From: Honghui Zhang <honghui.zhang@mediatek.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <lorenzo.pieralisi@arm.com>, <marc.zyngier@arm.com>,
        <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>, <youlin.pei@mediatek.com>,
        <hongkun.cao@mediatek.com>, <sean.wang@mediatek.com>,
        <xinping.qian@mediatek.com>, <yt.shen@mediatek.com>,
        <yong.wu@mediatek.com>
Date: Thu, 31 May 2018 15:37:40 +0800
In-Reply-To: <20180531042020.GQ39853@bhelgaas-glaptop.roam.corp.google.com>
References: <1527647736-19986-1-git-send-email-honghui.zhang@mediatek.com>
         <20180531042020.GQ39853@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-30 at 23:20 -0500, Bjorn Helgaas wrote:
> On Wed, May 30, 2018 at 10:35:36AM +0800, honghui.zhang@mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > The MTCMOS of PCIe Host for MT2712 will be off when system suspend, and all
> > the internel control register will be reset after system resume. The PCIe
> > link should be re-established and the related control register values should
> > be re-set after system resume.
> > 
> > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > CC: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  drivers/pci/host/pcie-mediatek.c | 82 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> > 
> > diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
> > index dabf1086..60f98d92 100644
> > --- a/drivers/pci/host/pcie-mediatek.c
> > +++ b/drivers/pci/host/pcie-mediatek.c
> > @@ -132,12 +132,14 @@ struct mtk_pcie_port;
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
> > @@ -1179,12 +1181,91 @@ static int mtk_pcie_probe(struct platform_device *pdev)
> >  	return err;
> >  }
> >  
> > +static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
> > +{
> > +	struct platform_device *pdev;
> > +	struct mtk_pcie *pcie;
> > +	struct mtk_pcie_port *port;
> > +	const struct mtk_pcie_soc *soc;
> > +
> > +	pdev = to_platform_device(dev);
> > +	pcie = platform_get_drvdata(pdev);
> > +	soc = pcie->soc;
> > +	if (!soc->pm_support)
> > +		return 0;
> > +
> > +	list_for_each_entry(port, &pcie->ports, list) {
> > +		clk_disable_unprepare(port->ahb_ck);
> > +		clk_disable_unprepare(port->sys_ck);
> > +		phy_power_off(port->phy);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
> 
> I don't really like the __maybe_unused annotations.  Looking at the
> other users of SET_NOIRQ_SYSTEM_SLEEP_PM_OPS, I think a small majority
> of them wrap the function definitions in #ifdef CONFIG_PM_SLEEP
> instead of using __maybe_unused.  That's also a bit ugly, but has the
> advantage of truly omitting the definitions when they're not needed.

Ok, I will follow your advise in the next version.

thanks.
