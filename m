Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E569C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D083620881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D083620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeIMMxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 08:53:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57057 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbeIMMxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 08:53:34 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4012F208AA; Thu, 13 Sep 2018 09:45:16 +0200 (CEST)
Received: from windsurf (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id F115A20728;
        Thu, 13 Sep 2018 09:45:15 +0200 (CEST)
Date:   Thu, 13 Sep 2018 09:45:15 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
Message-ID: <20180913094515.351967bb@windsurf>
In-Reply-To: <20180912231050.GX30658@n2100.armlinux.org.uk>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
        <87zhwm4kl6.fsf@tkos.co.il>
        <20180912231050.GX30658@n2100.armlinux.org.uk>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Russell, Baruch, Jan,

On Thu, 13 Sep 2018 00:10:51 +0100, Russell King - ARM Linux wrote:

> It's probably the latter - the region is probably already mapped, that
> being the PCI IO region.
> 
> The original driver was setup to call pci_ioremap_io() as the very
> last thing - and as the driver is non-removable, we were guaranteed
> to never tear down this mapping (which is sensible, it's published
> to userspace.)
> 
> However, the current code calls pci_ioremap_io() much earlier, in
> a path where probe failures can occur.  This breaks pci_ioremap_io()'s
> requirements - it must not be called more than once.  So:
> 
> ee1604381a37 ("PCI: mvebu: Only remap I/O space if configured")
> 
> is basically incorrect - pci_ioremap_io() needs to move back to a
> place where it is only called in a path which will never fail.
> However, looking at the generic host bits, I'm not sure such a place
> exists in the new effort to make stuff more generic.

What about something like the below. I tested it, including the error
case by forcing an -EPROBE_DEFER. The new pci_unmap_io() is modeled
after pci_unmap_iospace(). Actually, I would prefer to use
pci_remap_iospace() and pci_unmap_iospace() but for now this API
doesn't allow overloading the memory type used for the mapping.

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 2cfbc531f63b..cee0e2be5ac7 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -185,6 +185,7 @@ static inline void pci_ioremap_set_mem_type(int mem_type) {}
 #endif
 
 extern int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr);
+extern void pci_unmap_io(unsigned int offset);
 
 /*
  * PCI configuration space mapping function.
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index fc91205ff46c..f3a4df44bb27 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -482,6 +482,14 @@ int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
 }
 EXPORT_SYMBOL_GPL(pci_ioremap_io);
 
+void pci_unmap_io(unsigned int offset)
+{
+	BUG_ON(offset + SZ_64K > IO_SPACE_LIMIT);
+
+	unmap_kernel_range(PCI_IO_VIRT_BASE + offset, SZ_64K);
+}
+EXPORT_SYMBOL_GPL(pci_unmap_io);
+
 void __iomem *pci_remap_cfgspace(resource_size_t res_cookie, size_t size)
 {
 	return arch_ioremap_caller(res_cookie, size, MT_UNCACHED,
diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 50eb0729385b..772cff19c2ce 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1145,7 +1145,6 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
 	struct device_node *np = dev->of_node;
-	unsigned int i;
 	int ret;
 
 	INIT_LIST_HEAD(&pcie->resources);
@@ -1179,15 +1178,34 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
 					 resource_size(&pcie->io) - 1);
 		pcie->realio.name = "PCI I/O";
 
-		for (i = 0; i < resource_size(&pcie->realio); i += SZ_64K)
-			pci_ioremap_io(i, pcie->io.start + i);
-
 		pci_add_resource(&pcie->resources, &pcie->realio);
 	}
 
 	return devm_request_pci_bus_resources(dev, &pcie->resources);
 }
 
+static void mvebu_pcie_map_io(struct mvebu_pcie *pcie)
+{
+	int i;
+
+	if (resource_size(&pcie->io) == 0)
+		return;
+
+	for (i = 0; i < resource_size(&pcie->realio); i += SZ_64K)
+		pci_ioremap_io(i, pcie->io.start + i);
+}
+
+static void mvebu_pcie_unmap_io(struct mvebu_pcie *pcie)
+{
+	int i;
+
+	if (resource_size(&pcie->io) == 0)
+		return;
+
+	for (i = 0; i < resource_size(&pcie->realio); i += SZ_64K)
+		pci_unmap_io(i);
+}
+
 static int mvebu_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1258,6 +1276,8 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 
 	pcie->nports = i;
 
+	mvebu_pcie_map_io(pcie);
+
 	list_splice_init(&pcie->resources, &bridge->windows);
 	bridge->dev.parent = dev;
 	bridge->sysdata = pcie;
@@ -1268,7 +1288,13 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	bridge->align_resource = mvebu_pcie_align_resource;
 	bridge->msi = pcie->msi;
 
-	return pci_host_probe(bridge);
+	ret = pci_host_probe(bridge);
+	if (ret) {
+		mvebu_pcie_unmap_io(pcie);
+		return ret;
+	}
+
+	return 0;
 }
 
 static const struct of_device_id mvebu_pcie_of_match_table[] = {


-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
