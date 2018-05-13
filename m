Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbeEMOEe (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 10:04:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49859 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeEMOEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 10:04:32 -0400
Date: Sun, 13 May 2018 07:04:19 -0700
From: tip-bot for Marc Zyngier <tipbot@zytor.com>
Message-ID: <tip-6988e0e0d28328467e218f59589b2770675a9ebd@git.kernel.org>
Cc: ard.biesheuvel@linaro.org, thomas.petazzoni@bootlin.com,
        marc.zyngier@arm.com, miquel.raynal@bootlin.com, tglx@linutronix.de,
        mingo@kernel.org, robh@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org,
        jason@lakedaemon.net
Reply-To: marc.zyngier@arm.com, miquel.raynal@bootlin.com,
        ard.biesheuvel@linaro.org, thomas.petazzoni@bootlin.com,
        srinivas.kandagatla@linaro.org, jason@lakedaemon.net, hpa@zytor.com,
        robh@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        tglx@linutronix.de
In-Reply-To: <20180508121438.11301-3-marc.zyngier@arm.com>
References: <20180508121438.11301-3-marc.zyngier@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/msi: Limit level-triggered MSI to platform
 devices
Git-Commit-ID: 6988e0e0d28328467e218f59589b2770675a9ebd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6988e0e0d28328467e218f59589b2770675a9ebd
Gitweb:     https://git.kernel.org/tip/6988e0e0d28328467e218f59589b2770675a9ebd
Author:     Marc Zyngier <marc.zyngier@arm.com>
AuthorDate: Tue, 8 May 2018 13:14:31 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 13 May 2018 15:58:59 +0200

genirq/msi: Limit level-triggered MSI to platform devices

Nobody would be insane enough to try and use level triggered
MSIs on PCI, but let's make sure it doesn't happen. Also,
let's mandate that the irqchip backing the platform MSI domain
is providing the IRQCHIP_SUPPORTS_LEVEL_MSI flag.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lkml.kernel.org/r/20180508121438.11301-3-marc.zyngier@arm.com

---
 drivers/base/platform-msi.c     | 3 +++
 drivers/bus/fsl-mc/fsl-mc-msi.c | 2 ++
 drivers/pci/msi.c               | 3 +++
 include/linux/irq.h             | 1 +
 4 files changed, 9 insertions(+)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 8e22073aeeed..60d6cc618f1c 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -101,6 +101,9 @@ static void platform_msi_update_chip_ops(struct msi_domain_info *info)
 		chip->irq_set_affinity = msi_domain_set_affinity;
 	if (!chip->irq_write_msi_msg)
 		chip->irq_write_msi_msg = platform_msi_write_msg;
+	if (WARN_ON((info->flags & MSI_FLAG_LEVEL_CAPABLE) &&
+		    !(chip->flags & IRQCHIP_SUPPORTS_LEVEL_MSI)))
+		info->flags &= ~MSI_FLAG_LEVEL_CAPABLE;
 }
 
 static void platform_msi_free_descs(struct device *dev, int base, int nvec)
diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index ec35e255b496..8b9c66d7c4ff 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -163,6 +163,8 @@ struct irq_domain *fsl_mc_msi_create_irq_domain(struct fwnode_handle *fwnode,
 {
 	struct irq_domain *domain;
 
+	if (WARN_ON((info->flags & MSI_FLAG_LEVEL_CAPABLE)))
+		info->flags &= ~MSI_FLAG_LEVEL_CAPABLE;
 	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
 		fsl_mc_msi_update_dom_ops(info);
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
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
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 65916a305f3d..b2067083aa94 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -512,6 +512,7 @@ enum {
 	IRQCHIP_SKIP_SET_WAKE		= (1 <<  4),
 	IRQCHIP_ONESHOT_SAFE		= (1 <<  5),
 	IRQCHIP_EOI_THREADED		= (1 <<  6),
+	IRQCHIP_SUPPORTS_LEVEL_MSI	= (1 <<  7),
 };
 
 #include <linux/irqdesc.h>
