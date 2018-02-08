Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeBHChg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 21:37:36 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37674 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbeBHCgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 21:36:55 -0500
X-Google-Smtp-Source: AH8x226/XakZ0P0zPIhwTrAJ6zdsdSwIE1Mlr5RL3Tw33iCEdZPferebdfGPu3n/QyyZ5laE+Egf1A==
From: Derek Basehore <dbasehore@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, tglx@linutronix.de,
        briannorris@chromium.org, marc.zyngier@arm.com,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v6 1/3] irqchip/gic-v3-its: add ability to save/restore ITS state
Date: Wed,  7 Feb 2018 18:36:46 -0800
Message-Id: <20180208023648.89124-2-dbasehore@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <20180208023648.89124-1-dbasehore@chromium.org>
References: <20180208023648.89124-1-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms power off GIC logic in suspend, so we need to
save/restore state. The distributor and redistributor registers need
to be handled in platform code due to access permissions on those
registers, but the ITS registers can be restored in the kernel.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 103 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 06f025fd5726..35ad48f51dfa 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -33,6 +33,7 @@
 #include <linux/of_platform.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
+#include <linux/syscore_ops.h>
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-v3.h>
@@ -46,6 +47,7 @@
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
+#define ITS_FLAGS_SAVE_SUSPEND_STATE		(1ULL << 3)
 
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 
@@ -101,6 +103,8 @@ struct its_node {
 	struct its_collection	*collections;
 	struct fwnode_handle	*fwnode_handle;
 	u64			(*get_msi_base)(struct its_device *its_dev);
+	u64			cbaser_save;
+	u32			ctlr_save;
 	struct list_head	its_device_list;
 	u64			flags;
 	unsigned long		list_nr;
@@ -3042,6 +3046,100 @@ static void its_enable_quirks(struct its_node *its)
 	gic_enable_quirks(iidr, its_quirks, its);
 }
 
+static int its_save_disable(void)
+{
+	struct its_node *its;
+	int err = 0;
+
+	spin_lock(&its_lock);
+	list_for_each_entry(its, &its_nodes, entry) {
+		void __iomem *base;
+
+		if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
+			continue;
+
+		base = its->base;
+		its->ctlr_save = readl_relaxed(base + GITS_CTLR);
+		err = its_force_quiescent(base);
+		if (err) {
+			pr_err("ITS failed to quiesce\n");
+			writel_relaxed(its->ctlr_save, base + GITS_CTLR);
+			goto err;
+		}
+
+		its->cbaser_save = gits_read_cbaser(base + GITS_CBASER);
+	}
+
+err:
+	if (err) {
+		list_for_each_entry_continue_reverse(its, &its_nodes, entry) {
+			void __iomem *base;
+
+			if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
+				continue;
+
+			base = its->base;
+			writel_relaxed(its->ctlr_save, base + GITS_CTLR);
+		}
+	}
+	spin_unlock(&its_lock);
+
+	return err;
+}
+
+static void its_restore_enable(void)
+{
+	struct its_node *its;
+
+	spin_lock(&its_lock);
+	list_for_each_entry(its, &its_nodes, entry) {
+		void __iomem *base;
+		int i;
+
+		if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
+			continue;
+
+		base = its->base;
+
+		/*
+		 * Make sure that the ITS is disabled. If it fails to quiesce,
+		 * don't restore it since writing to CBASER or BASER<n>
+		 * registers is undefined according to the GIC v3 ITS
+		 * Specification.
+		 */
+		if (its_force_quiescent(base)) {
+			pr_err("ITS(%p): failed to quiesce on resume\n", base);
+			continue;
+		}
+
+		gits_write_cbaser(its->cbaser_save, base + GITS_CBASER);
+
+		/*
+		 * Writing CBASER resets CREADR to 0, so make CWRITER and
+		 * cmd_write line up with it.
+		 */
+		its->cmd_write = its->cmd_base;
+		gits_write_cwriter(0, base + GITS_CWRITER);
+
+		/* Restore GITS_BASER from the value cache. */
+		for (i = 0; i < GITS_BASER_NR_REGS; i++) {
+			struct its_baser *baser = &its->tables[i];
+
+			if (!(baser->val & GITS_BASER_VALID))
+				continue;
+
+			its_write_baser(its, baser, baser->val);
+		}
+		writel_relaxed(its->ctlr_save, base + GITS_CTLR);
+	}
+	spin_unlock(&its_lock);
+}
+
+static struct syscore_ops its_syscore_ops = {
+	.suspend = its_save_disable,
+	.resume = its_restore_enable,
+};
+
 static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
 {
 	struct irq_domain *inner_domain;
@@ -3261,6 +3359,9 @@ static int __init its_probe_one(struct resource *res,
 		ctlr |= GITS_CTLR_ImDe;
 	writel_relaxed(ctlr, its->base + GITS_CTLR);
 
+	if (fwnode_property_present(handle, "reset-on-suspend"))
+		its->flags |= ITS_FLAGS_SAVE_SUSPEND_STATE;
+
 	err = its_init_domain(handle, its);
 	if (err)
 		goto out_free_tables;
@@ -3515,5 +3616,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		}
 	}
 
+	register_syscore_ops(&its_syscore_ops);
+
 	return 0;
 }
-- 
2.16.0.rc1.238.g530d649a79-goog
