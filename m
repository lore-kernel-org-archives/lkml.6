Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD89C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C447E2124D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C447E2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeHQNam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:30:42 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:58943 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbeHQNaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:30:35 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MC1IG-1fhmHo0FzU-008rTJ; Fri, 17 Aug 2018 12:27:20 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 12/15] PCI: make pcibios_bus_add_device() a callback function
Date:   Fri, 17 Aug 2018 12:26:42 +0200
Message-Id: <20180817102645.3839621-13-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817102645.3839621-1-arnd@arndb.de>
References: <20180817102645.3839621-1-arnd@arndb.de>
X-Provags-ID: V03:K1:R1utoXtX1xNh6nDBCTDKYtshx4x5Ad5wYNBJAgXrFk787hWLNDF
 5obZ97/w/5En0hskq/pxyK7SOPl4UhPJ2PTwKnGPNKAKwSSdQ44BRgnjAIpA6XYIYn0Er06
 Pc2dX6A+UrbraMGwdzGaTIO5CmmDZNbHiidjXfSMXOaA8lWZRiNZ9X5Rk7imkL9cOwKt3Sk
 D03IBJSMeL9atj01F6mqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+d5rM4wws+U=:XOOzHLEIzDhldl610OMod6
 Zap/qlXbAkH836yGeY/ib2fecXn6x4Y+6uThsJIVQJyn1cS1tX2TZ4owbnjdpC4UEm9ToZpZt
 QLMMZq8rhF/NIBw7YW1Gprxc5Hng3xGnBj9P/BV/mJoznZWMtHwuSpaGZB/Izug6RIcyqqRvd
 wUf/G+k24qNuyRjJopb5WPzsOluIBzDSiO5d2e57HCuJBS8iAtlRKCdHhRtghBuztlo8P7ktL
 fyvt0pz6K/sFh+VMz77tGl9B42B1WlrFRXUZYMSi8U6zq20RGyTFSfjeClcdkGW08EcwR85Q3
 GccZApVCV2R3XGaUbH9SfyZ9ip2eyb+Q7DTP7COv8HAyFVquOZsid+9KhPnsBGu7k04/8a1Rv
 rtVTUu+qgS7Mq/XVDsHemBgXHs0bMKPFYvDwxSLr7TVeUDIkah1OYgh0CqHSEfWTpzrp91vxs
 g05h5QYibqxZ/EMLEuPJQnSEFQ64U2MljnkMnk1tMqvzNVkOocrGSXWsOgztBl8aN+tm9r1uN
 B1xw3o2sf/jUMlEHE4njh3nfstIXMdtG2ehg/F4tZU11is8jqyrZGSB5gVmCRzeIyItMc1dlT
 vkpYm6hS+SoavmhiL98V9H/X0+vW72Llfqsmb5M5AzlIGeJ37cFqN5tRz6j0pTb1QXr1RzIP6
 EGr0f7BPgHqn64IaeBC3USy0HuUGf2QxRfTCJE77+kiUQMT+auy//1ddRGoRrYgQP6So=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Weak functions are confusion, and we can now add callback pointers
to pci host bridges for any controller, so let's make this one
a callback rather than a __weak global function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/pci-common.c  | 7 +------
 arch/sh/drivers/pci/pci.c         | 1 +
 arch/sh/drivers/pci/pcie-sh7786.c | 3 ++-
 arch/sh/include/asm/pci.h         | 2 ++
 drivers/pci/bus.c                 | 8 +++++++-
 include/linux/pci.h               | 2 +-
 6 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 096011ec8670..afc9598e4349 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -270,12 +270,6 @@ int pcibios_sriov_disable(struct pci_dev *pdev)
 
 #endif /* CONFIG_PCI_IOV */
 
-void pcibios_bus_add_device(struct pci_dev *pdev)
-{
-	if (ppc_md.pcibios_bus_add_device)
-		ppc_md.pcibios_bus_add_device(pdev);
-}
-
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
 {
 #ifdef CONFIG_PPC64
@@ -1617,6 +1611,7 @@ void pcibios_scan_phb(struct pci_controller *hose)
 	hose->busn.flags = IORESOURCE_BUS;
 	pci_add_resource(&bridge->windows, &hose->busn);
 
+	bridge->bus_add_device = ppc_md->pcibios_bus_add_device;
 	bridge->dev.parent = hose->parent;
 	bridge->sysdata = hose;
 	bridge->busnr = hose->first_busno;
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 8256626bc53c..d5c01a86cde1 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -65,6 +65,7 @@ static void pcibios_scanbus(struct pci_channel *hose)
 	bridge->ops = hose->pci_ops;
 	bridge->swizzle_irq = pci_common_swizzle;
 	bridge->map_irq = pcibios_map_platform_irq;
+	bridge->bus_add_device = hose->bus_add_device;
 
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret) {
diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
index 3d81a8b80942..ab78356681a0 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -122,6 +122,7 @@ extern struct pci_ops sh7786_pci_ops;
 	.reg_base	= start,					\
 	.mem_offset	= 0,						\
 	.io_offset	= 0,						\
+	.bus_add_device = sh7786_pci_bus_add_device,			\
 }
 
 static struct pci_channel sh7786_pci_channels[] = {
@@ -488,7 +489,7 @@ int pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
         return evt2irq(0xae0);
 }
 
-void pcibios_bus_add_device(struct pci_dev *pdev)
+static void sh7786_pci_bus_add_device(struct pci_dev *pdev)
 {
 	pdev->dev.dma_pfn_offset = dma_pfn_offset;
 }
diff --git a/arch/sh/include/asm/pci.h b/arch/sh/include/asm/pci.h
index 10a36b1cf2ea..e605141cbcbe 100644
--- a/arch/sh/include/asm/pci.h
+++ b/arch/sh/include/asm/pci.h
@@ -35,6 +35,8 @@ struct pci_channel {
 	/* Optional error handling */
 	struct timer_list	err_timer, serr_timer;
 	unsigned int		err_irq, serr_irq;
+
+	void (*bus_add_device)(struct pci_dev *pdev);
 };
 
 /* arch/sh/drivers/pci/pci.c */
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 5cb40b2518f9..45873ac1a49c 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -299,7 +299,13 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx)
 
 void __weak pcibios_resource_survey_bus(struct pci_bus *bus) { }
 
-void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
+static void pcibios_bus_add_device(struct pci_dev *pdev)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
+
+	if (bridge->bus_add_device)
+		bridge->bus_add_device(pdev);
+}
 
 /**
  * pci_bus_add_device - start driver for a single device
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1dd8a3ecf753..d1072690cb4f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -475,6 +475,7 @@ struct pci_host_bridge {
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
+	void (*bus_add_device)(struct pci_dev *pdev);
 	void		*release_data;
 	struct msi_controller *msi;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
@@ -880,7 +881,6 @@ extern struct list_head pci_root_buses;	/* List of all known PCI buses */
 int no_pci_devices(void);
 
 void pcibios_resource_survey_bus(struct pci_bus *bus);
-void pcibios_bus_add_device(struct pci_dev *pdev);
 void pcibios_add_bus(struct pci_bus *bus);
 void pcibios_remove_bus(struct pci_bus *bus);
 void pcibios_fixup_bus(struct pci_bus *);
-- 
2.18.0

