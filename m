Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeA3BAw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 20:00:52 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33434 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbeA3BAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 20:00:22 -0500
X-Google-Smtp-Source: AH8x226hkAc+e/dP+Ltr5DY0cuDxt3XzL1jsn6PA43vqJ4ziot10rugdxmPy45vFWxy9slk7/Hw22Q==
From: Derek Basehore <dbasehore@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, tglx@linutronix.de,
        briannorris@chromium.org, marc.zyngier@arm.com,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v3 4/5] irqchip/gic-v3-its: add ability to resend MAPC on resume
Date: Mon, 29 Jan 2018 17:00:06 -0800
Message-Id: <20180130010007.256564-5-dbasehore@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <20180130010007.256564-1-dbasehore@chromium.org>
References: <20180130010007.256564-1-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds functionality to resend the MAPC command to an ITS node on
resume. If the ITS is powered down during suspend and the collections
are not backed by memory, the ITS will lose that state. This just sets
up the known state for the collections after the ITS is restored.

This feature is enabled via Kconfig and a device tree entry.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 arch/arm64/Kconfig               |  10 ++++
 drivers/irqchip/irq-gic-v3-its.c | 101 ++++++++++++++++++++++++---------------
 2 files changed, 73 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 53612879fe56..f38f1a7b4266 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -571,6 +571,16 @@ config HISILICON_ERRATUM_161600802
 
 	  If unsure, say Y.
 
+config ARM_GIC500_COLLECTIONS_RESET
+	bool "GIC-500 Collections: Workaround for GIC-500 Collections on suspend reset"
+	default y
+	help
+	  The GIC-500 can store Collections state internally for the ITS. If
+	  the ITS is reset on suspend (ie from power getting disabled), the
+	  collections need to be reconfigured on resume.
+
+	  If unsure, say Y.
+
 config QCOM_FALKOR_ERRATUM_E1041
 	bool "Falkor E1041: Speculative instruction fetches might cause errant memory access"
 	default y
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 759ede7048ed..7fc533cf3bf7 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -48,6 +48,7 @@
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
 #define ITS_FLAGS_SAVE_SUSPEND_STATE		(1ULL << 3)
+#define ITS_FLAGS_WORKAROUND_GIC500_MAPC	(1ULL << 4)
 
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 
@@ -1950,52 +1951,53 @@ static void its_cpu_init_lpis(void)
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
@@ -2997,6 +2999,18 @@ static bool __maybe_unused its_enable_quirk_hip07_161600802(void *data)
 	return true;
 }
 
+static bool __maybe_unused its_enable_quirk_gic500_collections(void *data)
+{
+	struct its_node *its = data;
+
+	if (fwnode_property_present(its->fwnode_handle,
+				    "collections-reset-on-suspend")) {
+		its->flags |= ITS_FLAGS_WORKAROUND_GIC500_MAPC;
+		return true;
+	}
+	return false;
+}
+
 static const struct gic_quirk its_quirks[] = {
 #ifdef CONFIG_CAVIUM_ERRATUM_22375
 	{
@@ -3042,6 +3056,14 @@ static const struct gic_quirk its_quirks[] = {
 		.mask	= 0xffffffff,
 		.init	= its_enable_quirk_hip07_161600802,
 	},
+#endif
+#ifdef CONFIG_ARM_GIC500_COLLECTIONS_RESET
+	{
+		.desc	= "ITS: GIC-500 Collections Reset on Resume",
+		.iidr	= 0x00000000,
+		.mask	= 0xff000000,
+		.init	= its_enable_quirk_gic500_collections,
+	},
 #endif
 	{
 	}
@@ -3114,6 +3136,9 @@ static void its_restore_enable(void)
 			}
 			writel_relaxed(ctx->ctlr, base + GITS_CTLR);
 		}
+
+		if (its->flags & ITS_FLAGS_WORKAROUND_GIC500_MAPC)
+			its_cpu_init_collection(its);
 	}
 	spin_unlock(&its_lock);
 }
@@ -3380,7 +3405,7 @@ int its_cpu_init(void)
 			return -ENXIO;
 		}
 		its_cpu_init_lpis();
-		its_cpu_init_collection();
+		its_cpu_init_collections();
 	}
 
 	return 0;
-- 
2.16.0.rc1.238.g530d649a79-goog
