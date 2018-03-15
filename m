Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932302AbeCOObe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:31:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33476 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752587AbeCOObb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:31:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B471860452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=shankerd@codeaurora.org
From: Shanker Donthineni <shankerd@codeaurora.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Vikram Sethi <vikrams@codeaurora.org>,
        Shanker Donthineni <shankerd@codeaurora.org>
Subject: [PATCH v2] irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is observed before enabling
Date: Thu, 15 Mar 2018 09:31:27 -0500
Message-Id: <1521124287-25009-1-git-send-email-shankerd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definition of the GICR_CTLR.RWP control bit was expanded to indicate
status of changing GICR_CTLR.EnableLPI from 1 to 0 is being in progress
or completed. Software must observe GICR_CTLR.RWP==0 after clearing
GICR_CTLR.EnableLPI from 1 to 0 and before writing GICR_PENDBASER and/or
GICR_PROPBASER, otherwise behavior is UNPREDICTABLE.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
Changes since v1:
  -Moved LPI disable code to a seperate function as Marc suggested.
  -Mark's suggestion to use readl_relaxed_poll_timeout() helper functions.
  
 drivers/irqchip/irq-gic-v3-its.c   | 66 ++++++++++++++++++++++++++++++--------
 include/linux/irqchip/arm-gic-v3.h |  1 +
 2 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1d3056f..cba71a7 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -33,6 +33,8 @@
 #include <linux/of_platform.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
+#include <linux/time64.h>
+#include <linux/iopoll.h>
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-v3.h>
@@ -1875,16 +1877,6 @@ static void its_cpu_init_lpis(void)
 		gic_data_rdist()->pend_page = pend_page;
 	}
 
-	/* Disable LPIs */
-	val = readl_relaxed(rbase + GICR_CTLR);
-	val &= ~GICR_CTLR_ENABLE_LPIS;
-	writel_relaxed(val, rbase + GICR_CTLR);
-
-	/*
-	 * Make sure any change to the table is observable by the GIC.
-	 */
-	dsb(sy);
-
 	/* set PROPBASE */
 	val = (page_to_phys(gic_rdists->prop_page) |
 	       GICR_PROPBASER_InnerShareable |
@@ -3288,13 +3280,59 @@ static bool gic_rdists_supports_plpis(void)
 	return !!(gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER) & GICR_TYPER_PLPIS);
 }
 
+static int redist_disable_lpis(void)
+{
+	void __iomem *rbase = gic_data_rdist_rd_base();
+	u64 val;
+	int ret;
+
+	if (!gic_rdists_supports_plpis()) {
+		pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
+		return -ENXIO;
+	}
+
+	val = readl_relaxed(rbase + GICR_CTLR);
+	if (!(val & GICR_CTLR_ENABLE_LPIS))
+		return 0;
+
+	/* Disable LPIs */
+	val &= ~GICR_CTLR_ENABLE_LPIS;
+	writel_relaxed(val, rbase + GICR_CTLR);
+
+	/* Make sure any change to GICR_CTLR is observable by the GIC */
+	dsb(sy);
+
+	/* Wait for GICR_CTLR.GICR_CTLR_ENABLE_LPIS==0 or timeout */
+	ret = readl_relaxed_poll_timeout_atomic(rbase + GICR_CTLR, val,
+					 !(val & GICR_CTLR_ENABLE_LPIS), 1,
+					 USEC_PER_SEC);
+	if (ret) {
+		pr_err("CPU%d: Failed to disable LPIs\n", smp_processor_id());
+		return -EBUSY;
+	}
+
+	/* Wait for GICR_CTLR.RWP==0 or timeout */
+	ret = readl_relaxed_poll_timeout_atomic(rbase + GICR_CTLR, val,
+					 !(val & GICR_CTLR_RWP), 1,
+					 USEC_PER_SEC);
+	if (ret) {
+		pr_err("CPU%d: Failed to observe RWP==0 after enabling LPIs\n",
+		       smp_processor_id());
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 int its_cpu_init(void)
 {
+	int ret;
+
 	if (!list_empty(&its_nodes)) {
-		if (!gic_rdists_supports_plpis()) {
-			pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
-			return -ENXIO;
-		}
+		ret = redist_disable_lpis();
+		if (ret)
+			return ret;
+
 		its_cpu_init_lpis();
 		its_cpu_init_collection();
 	}
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index c00c4c33..4d5fb60 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -106,6 +106,7 @@
 #define GICR_PIDR2			GICD_PIDR2
 
 #define GICR_CTLR_ENABLE_LPIS		(1UL << 0)
+#define GICR_CTLR_RWP			(1UL << 3)
 
 #define GICR_TYPER_CPU_NUMBER(r)	(((r) >> 8) & 0xffff)
 
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
