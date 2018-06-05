Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeFEMgo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:36:44 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54561 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751718AbeFEMgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:36:43 -0400
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org
Cc: minghuan.lian@nxp.com, zhiqiang.hou@nxp.com,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH] irqchip/ls-scfg-msi: map MSIs in the iommu
Date: Tue,  5 Jun 2018 15:27:27 +0300
Message-Id: <20180605122727.12831-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required iommu_dma_map_msi_msg() when composing the MSI message,
otherwise the interrupts will not work.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/irqchip/irq-ls-scfg-msi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 57e3d900f19e..1ec3bfe56693 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -21,6 +21,7 @@
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/spinlock.h>
+#include <linux/dma-iommu.h>
 
 #define MSI_IRQS_PER_MSIR	32
 #define MSI_MSIR_OFFSET		4
@@ -94,6 +95,8 @@ static void ls_scfg_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 
 	if (msi_affinity_flag)
 		msg->data |= cpumask_first(data->common->affinity);
+
+	iommu_dma_map_msi_msg(data->irq, msg);
 }
 
 static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,
-- 
2.17.0
