Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752763AbeBCBZ2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 20:25:28 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39798 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752191AbeBCBY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 20:24:58 -0500
X-Google-Smtp-Source: AH8x227ZruHOeHoruLwm2KeAp8a2ez+bi+18scAnGVidermcGc0ibFVM/V4uUKqd2xBqW5ivdsy7OQ==
From: Derek Basehore <dbasehore@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, tglx@linutronix.de,
        briannorris@chromium.org, marc.zyngier@arm.com,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v4 2/5] irqchip/gic-v3-its: add ability to save/restore ITS state
Date: Fri,  2 Feb 2018 17:24:47 -0800
Message-Id: <20180203012450.18378-3-dbasehore@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <20180203012450.18378-1-dbasehore@chromium.org>
References: <20180203012450.18378-1-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms power off GIC logic in suspend, so we need to
save/restore state. The distributor and redistributor registers need
to be handled in platform code due to access permissions on those
registers, but the ITS registers can be restored in the kernel.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 101 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 06f025fd5726..e13515cdb68f 100644
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
 
@@ -83,6 +85,15 @@ struct its_baser {
 	u32		psz;
 };
 
+/*
+ * Saved ITS state - this is where saved state for the ITS is stored
+ * when it's disabled during system suspend.
+ */
+struct its_ctx {
+	u64			cbaser;
+	u32			ctlr;
+};
+
 struct its_device;
 
 /*
@@ -101,6 +112,7 @@ struct its_node {
 	struct its_collection	*collections;
 	struct fwnode_handle	*fwnode_handle;
 	u64			(*get_msi_base)(struct its_device *its_dev);
+	struct its_ctx		its_ctx;
 	struct list_head	its_device_list;
 	u64			flags;
 	unsigned long		list_nr;
@@ -3042,6 +3054,90 @@ static void its_enable_quirks(struct its_node *its)
 	gic_enable_quirks(iidr, its_quirks, its);
 }
 
+static int its_save_disable(void)
+{
+	struct its_node *its;
+	int err = 0;
+
+	spin_lock(&its_lock);
+	list_for_each_entry(its, &its_nodes, entry) {
+		struct its_ctx *ctx;
+		void __iomem *base;
+
+		if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
+			continue;
+
+		ctx = &its->its_ctx;
+		base = its->base;
+		ctx->ctlr = readl_relaxed(base + GITS_CTLR);
+		err = its_force_quiescent(base);
+		if (err) {
+			pr_err("ITS failed to quiesce\n");
+			writel_relaxed(ctx->ctlr, base + GITS_CTLR);
+			goto err;
+		}
+
+		ctx->cbaser = gits_read_cbaser(base + GITS_CBASER);
+	}
+
+err:
+	if (err) {
+		list_for_each_entry_continue_reverse(its, &its_nodes, entry) {
+			if (its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE) {
+				struct its_ctx *ctx = &its->its_ctx;
+				void __iomem *base = its->base;
+
+				writel_relaxed(ctx->ctlr, base + GITS_CTLR);
+			}
+		}
+	}
+
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
+		if (its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE) {
+			struct its_ctx *ctx = &its->its_ctx;
+			void __iomem *base = its->base;
+			/*
+			 * Only the lower 32 bits matter here since the upper 32
+			 * don't include any of the offset.
+			 */
+			u32 creader = readl_relaxed(base + GITS_CREADR);
+			int i;
+
+			/*
+			 * Reset the write location to where the ITS is
+			 * currently at.
+			 */
+			gits_write_cbaser(ctx->cbaser, base + GITS_CBASER);
+			gits_write_cwriter(creader, base + GITS_CWRITER);
+			its->cmd_write = &its->cmd_base[
+				creader / sizeof(struct its_cmd_block)];
+			/* Restore GITS_BASER from the value cache. */
+			for (i = 0; i < GITS_BASER_NR_REGS; i++) {
+				struct its_baser *baser = &its->tables[i];
+
+				its_write_baser(its, baser, baser->val);
+			}
+			writel_relaxed(ctx->ctlr, base + GITS_CTLR);
+		}
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
@@ -3261,6 +3357,9 @@ static int __init its_probe_one(struct resource *res,
 		ctlr |= GITS_CTLR_ImDe;
 	writel_relaxed(ctlr, its->base + GITS_CTLR);
 
+	if (fwnode_property_present(handle, "reset-on-suspend"))
+		its->flags |= ITS_FLAGS_SAVE_SUSPEND_STATE;
+
 	err = its_init_domain(handle, its);
 	if (err)
 		goto out_free_tables;
@@ -3515,5 +3614,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		}
 	}
 
+	register_syscore_ops(&its_syscore_ops);
+
 	return 0;
 }
-- 
2.16.0.rc1.238.g530d649a79-goog
