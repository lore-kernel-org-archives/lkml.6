Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FF8C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C2025ACC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C2025ACC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752637AbeF1BRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 21:17:40 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:56283 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751114AbeF1BRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 21:17:38 -0400
X-UUID: 2c77f741283b4d6d870f353a6a835d63-20180628
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1293185427; Thu, 28 Jun 2018 09:17:34 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Thu, 28 Jun
 2018 09:17:33 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 28 Jun 2018 09:17:32 +0800
Message-ID: <1530148652.28284.4.camel@mhfsdcap03>
Subject: Re: [PATCH 4/4] PCI: mediatek: Add loadable kernel module support
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
Date:   Thu, 28 Jun 2018 09:17:32 +0800
In-Reply-To: <CAHp75VdsSZifb5xZ2Q8cmJV=PgAaoN=iOhMfyVX4uE4vNpo=Mg@mail.gmail.com>
References: <1530091298-28120-1-git-send-email-honghui.zhang@mediatek.com>
         <1530091298-28120-5-git-send-email-honghui.zhang@mediatek.com>
         <CAHp75VdsSZifb5xZ2Q8cmJV=PgAaoN=iOhMfyVX4uE4vNpo=Mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-27 at 19:39 +0300, Andy Shevchenko wrote:
> On Wed, Jun 27, 2018 at 12:21 PM,  <honghui.zhang@mediatek.com> wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> >
> > Implement remove callback function for Mediatek PCIe driver to add
> > loadable kernel module support.
> 
> > +static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
> > +{
> > +       struct mtk_pcie_port *port, *tmp;
> > +
> 
> > +       if (list_empty(&pcie->ports))
> > +               return;
> 
> This is redundant.

Yeah, you are right, I will remove it.

> 
> > +
> > +       list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> > +               irq_set_chained_handler_and_data(port->irq, NULL, NULL);
> > +
> > +               if (port->irq_domain)
> > +                       irq_domain_remove(port->irq_domain);
> > +
> > +               if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +                       if (port->msi_domain)
> > +                               irq_domain_remove(port->msi_domain);
> > +                       if (port->inner_domain)
> > +                               irq_domain_remove(port->inner_domain);
> > +               }
> > +
> > +               irq_dispose_mapping(port->irq);
> > +       }
> > +}
> 
> > +static void mtk_pcie_free_resources(struct mtk_pcie *pcie)
> > +{
> > +       struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> > +       struct list_head *windows = &host->windows;
> > +
> > +       pci_unmap_iospace(&pcie->pio);
> > +       pci_free_resource_list(windows);
> > +}
> > +
> > +static int mtk_pcie_remove(struct platform_device *pdev)
> > +{
> > +       struct mtk_pcie *pcie = platform_get_drvdata(pdev);
> > +       struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> > +
> > +       pci_stop_root_bus(host->bus);
> > +       pci_remove_root_bus(host->bus);
> > +       mtk_pcie_free_resources(pcie);
> > +
> > +       mtk_pcie_irq_teardown(pcie);
> > +
> 
> > +       if (!list_empty(&pcie->ports))
> 
> I think this is also not needed. Do you put runtime PM by the way?

Yes, it's could be removed.
the pm was putted in mtk_pcie_put_resources which will call
mtk_pcie_subsys_powerdown, and the pm was putted in that function.

thanks.

> 
> > +               mtk_pcie_put_resources(pcie);
> > +
> > +       return 0;
> > +}
> 


