Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754774AbeDWKfY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:35:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38700 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754764AbeDWKfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:35:18 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] genirq/msi: Limit level-triggered MSI to platform devices
Date: Mon, 23 Apr 2018 11:34:35 +0100
Message-Id: <20180423103440.26592-3-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180423103440.26592-1-marc.zyngier@arm.com>
References: <20180423103440.26592-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody would be insane enough to try and use level triggered
MSIs on PCI, but let's make sure it doesn't happen. Also,
let's mandate that the irqchip backing the platform MSI domain
is providing an irq_set_type method (or the whole thing would
be a bit useless).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/base/platform-msi.c | 3 +++
 drivers/pci/msi.c           | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 8e22073aeeed..3b9694a6beaa 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -101,6 +101,9 @@ static void platform_msi_update_chip_ops(struct msi_domain_info *info)
 		chip->irq_set_affinity = msi_domain_set_affinity;
 	if (!chip->irq_write_msi_msg)
 		chip->irq_write_msi_msg = platform_msi_write_msg;
+	if (WARN_ON((info->flags & MSI_FLAG_LEVEL_CAPABLE) &&
+		    !chip->irq_set_type))
+		info->flags &= ~MSI_FLAG_LEVEL_CAPABLE;
 }
 
 static void platform_msi_free_descs(struct device *dev, int base, int nvec)
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 30250631efe7..f45b74fcc059 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1434,6 +1434,9 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 {
 	struct irq_domain *domain;
 
+	if (WARN_ON(info->flags & MSI_FLAG_LEVEL_CAPABLE))
+		info->flags &= ~MSI_FLAG_LEVEL_CAPABLE;
+
 	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
 		pci_msi_domain_update_dom_ops(info);
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
-- 
2.14.2
