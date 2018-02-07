Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932357AbeBGBle (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 20:41:34 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35183 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932342AbeBGBlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 20:41:31 -0500
X-Google-Smtp-Source: AH8x226DNSkwA5OspbwGdDI0xDy4cIIM75ATM5Gsee/ob9RXojvTyaiVEiAn8JQ77S4+cbIcKkWD0A==
From: Derek Basehore <dbasehore@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, tglx@linutronix.de,
        briannorris@chromium.org, marc.zyngier@arm.com,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v5 4/4] irqchip/gic-v3-its: add ability to resend MAPC on resume
Date: Tue,  6 Feb 2018 17:41:17 -0800
Message-Id: <20180207014117.62611-5-dbasehore@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <20180207014117.62611-1-dbasehore@chromium.org>
References: <20180207014117.62611-1-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds functionality to resend the MAPC command to an ITS node on
resume. If the ITS is powered down during suspend and the collections
are not backed by memory, the ITS will lose that state. This just sets
up the known state for the collections after the ITS is restored.

This is enabled via the reset-on-suspend flag in the DTS for an ITS
that has a non-zero number of collections stored in it.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 80 ++++++++++++++++++++------------------
 include/linux/irqchip/arm-gic-v3.h |  1 +
 2 files changed, 43 insertions(+), 38 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5e63635e2a7b..dd6cd6e68ed0 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1942,52 +1942,53 @@ static void its_cpu_init_lpis(void)
 	dsb(sy);
 }
 
-static void its_cpu_init_collection(void)
+static void its_cpu_init_collection(struct its_node *its)
 {
-	struct its_node *its;
-	int cpu;
-
-	spin_lock(&its_lock);
-	cpu = smp_processor_id();
-
-	list_for_each_entry(its, &its_nodes, entry) {
-		u64 target;
+	int cpu = smp_processor_id();
+	u64 target;
 
-		/* avoid cross node collections and its mapping */
-		if (its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) {
-			struct device_node *cpu_node;
+	/* avoid cross node collections and its mapping */
+	if (its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) {
+		struct device_node *cpu_node;
 
-			cpu_node = of_get_cpu_node(cpu, NULL);
-			if (its->numa_node != NUMA_NO_NODE &&
-				its->numa_node != of_node_to_nid(cpu_node))
-				continue;
-		}
+		cpu_node = of_get_cpu_node(cpu, NULL);
+		if (its->numa_node != NUMA_NO_NODE &&
+			its->numa_node != of_node_to_nid(cpu_node))
+			return;
+	}
 
+	/*
+	 * We now have to bind each collection to its target
+	 * redistributor.
+	 */
+	if (gic_read_typer(its->base + GITS_TYPER) & GITS_TYPER_PTA) {
 		/*
-		 * We now have to bind each collection to its target
+		 * This ITS wants the physical address of the
 		 * redistributor.
 		 */
-		if (gic_read_typer(its->base + GITS_TYPER) & GITS_TYPER_PTA) {
-			/*
-			 * This ITS wants the physical address of the
-			 * redistributor.
-			 */
-			target = gic_data_rdist()->phys_base;
-		} else {
-			/*
-			 * This ITS wants a linear CPU number.
-			 */
-			target = gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER);
-			target = GICR_TYPER_CPU_NUMBER(target) << 16;
-		}
+		target = gic_data_rdist()->phys_base;
+	} else {
+		/* This ITS wants a linear CPU number. */
+		target = gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER);
+		target = GICR_TYPER_CPU_NUMBER(target) << 16;
+	}
 
-		/* Perform collection mapping */
-		its->collections[cpu].target_address = target;
-		its->collections[cpu].col_id = cpu;
+	/* Perform collection mapping */
+	its->collections[cpu].target_address = target;
+	its->collections[cpu].col_id = cpu;
 
-		its_send_mapc(its, &its->collections[cpu], 1);
-		its_send_invall(its, &its->collections[cpu]);
-	}
+	its_send_mapc(its, &its->collections[cpu], 1);
+	its_send_invall(its, &its->collections[cpu]);
+}
+
+static void its_cpu_init_collections(void)
+{
+	struct its_node *its;
+
+	spin_lock(&its_lock);
+
+	list_for_each_entry(its, &its_nodes, entry)
+		its_cpu_init_collection(its);
 
 	spin_unlock(&its_lock);
 }
@@ -3127,6 +3128,9 @@ static void its_restore_enable(void)
 			its_write_baser(its, baser, baser->val);
 		}
 		writel_relaxed(its->ctlr_save, base + GITS_CTLR);
+
+		if (GITS_TYPER_HWCOLLCNT(gic_read_typer(base + GITS_TYPER)) > 0)
+			its_cpu_init_collection(its);
 	}
 	spin_unlock(&its_lock);
 }
@@ -3393,7 +3397,7 @@ int its_cpu_init(void)
 			return -ENXIO;
 		}
 		its_cpu_init_lpis();
-		its_cpu_init_collection();
+		its_cpu_init_collections();
 	}
 
 	return 0;
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index c00c4c33e432..c9c33b91a1f1 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -313,6 +313,7 @@
 #define GITS_TYPER_DEVBITS(r)		((((r) >> GITS_TYPER_DEVBITS_SHIFT) & 0x1f) + 1)
 #define GITS_TYPER_PTA			(1UL << 19)
 #define GITS_TYPER_HWCOLLCNT_SHIFT	24
+#define GITS_TYPER_HWCOLLCNT(r)		(((r) >> GITS_TYPER_HWCOLLCNT_SHIFT) & 0xff)
 #define GITS_TYPER_VMOVP		(1ULL << 37)
 
 #define GITS_IIDR_REV_SHIFT		12
-- 
2.16.0.rc1.238.g530d649a79-goog
