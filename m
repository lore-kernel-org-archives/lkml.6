Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932297AbeEHMPo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 08:15:44 -0400
Received: from foss.arm.com ([217.140.101.70]:57566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932170AbeEHMPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 08:15:15 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] irqchip/gic-v3: Add PCI/MSI support to the GICv3 MBI sub-driver
Date: Tue,  8 May 2018 13:14:37 +0100
Message-Id: <20180508121438.11301-9-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180508121438.11301-1-marc.zyngier@arm.com>
References: <20180508121438.11301-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You would hope that if you have a GICv3 in your system, you'd use the ITS,
as it provides a large interrupt ID space and device isolation. Sadly,
some SoC integrations are less than perfect, and the ITS is not usesable on
those.

The only solution for these systems is to use the MBI interface, and
rely on a very small number of possible vectors.

This patch thus adds minimal support for PCI/MSI on top of the GICv3
MBI driver. Please don't use it if you can avoid it.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-mbi.c | 62 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index 2b3b767050aa..ad70e7c416e3 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
+#include <linux/of_pci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -144,6 +145,55 @@ static void mbi_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	iommu_dma_map_msi_msg(data->irq, msg);
 }
 
+#ifdef CONFIG_PCI_MSI
+/* PCI-specific irqchip */
+static void mbi_mask_msi_irq(struct irq_data *d)
+{
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
+
+static void mbi_unmask_msi_irq(struct irq_data *d)
+{
+	pci_msi_unmask_irq(d);
+	irq_chip_unmask_parent(d);
+}
+
+static struct irq_chip mbi_msi_irq_chip = {
+	.name			= "MSI",
+	.irq_mask		= mbi_mask_msi_irq,
+	.irq_unmask		= mbi_unmask_msi_irq,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_compose_msi_msg	= mbi_compose_msi_msg,
+	.irq_write_msi_msg	= pci_msi_domain_write_msg,
+};
+
+static struct msi_domain_info mbi_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
+	.chip	= &mbi_msi_irq_chip,
+};
+
+static int mbi_allocate_pci_domain(struct irq_domain *nexus_domain,
+				   struct irq_domain **pci_domain)
+{
+	*pci_domain = pci_msi_create_irq_domain(nexus_domain->parent->fwnode,
+						&mbi_msi_domain_info,
+						nexus_domain);
+	if (!*pci_domain)
+		return -ENOMEM;
+
+	return 0;
+}
+#else
+static int mbi_allocate_pci_domain(struct irq_domain *nexus_domain,
+				   struct irq_domain **pci_domain)
+{
+	*pci_domain = NULL;
+	return 0;
+}
+#endif
+
 static void mbi_compose_mbi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	mbi_compose_msi_msg(data, msg);
@@ -175,7 +225,8 @@ static struct msi_domain_info mbi_pmsi_domain_info = {
 
 static int mbi_allocate_domains(struct irq_domain *parent)
 {
-	struct irq_domain *nexus_domain, *plat_domain;
+	struct irq_domain *nexus_domain, *pci_domain, *plat_domain;
+	int err;
 
 	nexus_domain = irq_domain_create_tree(parent->fwnode,
 					      &mbi_domain_ops, NULL);
@@ -185,12 +236,17 @@ static int mbi_allocate_domains(struct irq_domain *parent)
 	irq_domain_update_bus_token(nexus_domain, DOMAIN_BUS_NEXUS);
 	nexus_domain->parent = parent;
 
+	err = mbi_allocate_pci_domain(nexus_domain, &pci_domain);
+
 	plat_domain = platform_msi_create_irq_domain(parent->fwnode,
 						     &mbi_pmsi_domain_info,
 						     nexus_domain);
 
-	if (!plat_domain) {
-		irq_domain_remove(plat_domain);
+	if (err || !plat_domain) {
+		if (plat_domain)
+			irq_domain_remove(plat_domain);
+		if (pci_domain)
+			irq_domain_remove(pci_domain);
 		irq_domain_remove(nexus_domain);
 		return -ENOMEM;
 	}
-- 
2.14.2
