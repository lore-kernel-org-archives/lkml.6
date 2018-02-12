Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754222AbeBLQtF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:49:05 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37951 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754017AbeBLQse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:48:34 -0500
X-Google-Smtp-Source: AH8x226rFUfD7R80MW35oTnI06hyh7i5WHhYFJDjrpaJrtwzIBgiy/LCZWjAfHnH4fgXkHNazPrb8w==
From: Dmitry Safonov <dima@arista.com>
To: linux-kernel@vger.kernel.org
Cc: 0x7f454c46@gmail.com, Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCHv2 5/6] iommu/intel: Rename dmar_fault() => dmar_serve_faults()
Date: Mon, 12 Feb 2018 16:48:24 +0000
Message-Id: <20180212164825.22421-6-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180212164825.22421-1-dima@arista.com>
References: <20180212164825.22421-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the return value, parameters and a bit better naming.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/iommu/dmar.c                | 8 +++-----
 drivers/iommu/intel-iommu.c         | 2 +-
 drivers/iommu/intel_irq_remapping.c | 2 +-
 include/linux/dmar.h                | 2 +-
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 34a53aeede38..37a1147a7592 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1635,9 +1635,8 @@ static void clear_primary_faults(struct intel_iommu *iommu)
 }
 
 #define PRIMARY_FAULT_REG_LEN (16)
-irqreturn_t dmar_fault(int irq, void *dev_id)
+void dmar_serve_faults(struct intel_iommu *iommu)
 {
-	struct intel_iommu *iommu = dev_id;
 	int reg, fault_index;
 	u32 fault_status;
 	unsigned long flag;
@@ -1706,14 +1705,13 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 
 unlock_exit:
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
-	return IRQ_HANDLED;
 }
 
 static void dmar_fault_work(struct work_struct *work)
 {
 	struct fault *fault = container_of(work, struct fault, work);
 
-	dmar_fault(-1, (void*)fault->iommu);
+	dmar_serve_faults(fault->iommu);
 }
 
 static irqreturn_t dmar_fault_handler(int irq, void *dev_id)
@@ -1786,7 +1784,7 @@ int __init enable_drhd_fault_handling(void)
 		/*
 		 * Clear any previous faults.
 		 */
-		dmar_fault(iommu->irq, iommu);
+		dmar_serve_faults(iommu);
 		fault_status = readl(iommu->reg + DMAR_FSTS_REG);
 		writel(fault_status, iommu->reg + DMAR_FSTS_REG);
 	}
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 64ad9786f5b9..3b55376b3b46 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3015,7 +3015,7 @@ static void intel_iommu_init_qi(struct intel_iommu *iommu)
 		/*
 		 * Clear any previous faults.
 		 */
-		dmar_fault(-1, iommu);
+		dmar_serve_faults(iommu);
 		/*
 		 * Disable queued invalidation if supported and already enabled
 		 * before OS handover.
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 66f69af2c219..0958fdc76564 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -558,7 +558,7 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 		/*
 		 * Clear previous faults.
 		 */
-		dmar_fault(-1, iommu);
+		dmar_serve_faults(iommu);
 		dmar_disable_qi(iommu);
 
 		if (dmar_enable_qi(iommu)) {
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 5de4932a6ad8..6e9a5e4ac73a 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -280,7 +280,7 @@ extern void dmar_msi_mask(struct irq_data *data);
 extern void dmar_msi_read(int irq, struct msi_msg *msg);
 extern void dmar_msi_write(int irq, struct msi_msg *msg);
 extern int dmar_set_interrupt(struct intel_iommu *iommu);
-extern irqreturn_t dmar_fault(int irq, void *dev_id);
+extern void dmar_serve_faults(struct intel_iommu *iommu);
 extern int dmar_alloc_hwirq(int id, int node, void *arg);
 extern void dmar_free_hwirq(int irq);
 
-- 
2.13.6
