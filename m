Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932852AbeCNAuH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 20:50:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53708 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932667AbeCNAuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 20:50:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 39AB160452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=shankerd@codeaurora.org
From: Shanker Donthineni <shankerd@codeaurora.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Vikram Sethi <vikrams@codeaurora.org>,
        Shanker Donthineni <shankerd@codeaurora.org>
Subject: [PATCH] irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is observed before enabling
Date: Tue, 13 Mar 2018 19:50:01 -0500
Message-Id: <1520988601-16705-1-git-send-email-shankerd@codeaurora.org>
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
 drivers/irqchip/irq-gic-v3-its.c   | 30 +++++++++++++++++++++++-------
 include/linux/irqchip/arm-gic-v3.h |  1 +
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1d3056f..85cd158 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1875,15 +1875,31 @@ static void its_cpu_init_lpis(void)
 		gic_data_rdist()->pend_page = pend_page;
 	}
 
-	/* Disable LPIs */
 	val = readl_relaxed(rbase + GICR_CTLR);
-	val &= ~GICR_CTLR_ENABLE_LPIS;
-	writel_relaxed(val, rbase + GICR_CTLR);
 
-	/*
-	 * Make sure any change to the table is observable by the GIC.
-	 */
-	dsb(sy);
+	/* Make sure LPIs are disabled before programming PEND/PROP registers */
+	if (val & GICR_CTLR_ENABLE_LPIS) {
+		u32 count = 1000000; /* 1s! */
+
+		/* Disable LPIs */
+		val &= ~GICR_CTLR_ENABLE_LPIS;
+		writel_relaxed(val, rbase + GICR_CTLR);
+
+		/* Make sure any change to GICR_CTLR is observable by the GIC */
+		dsb(sy);
+
+		/* Wait for GICR_CTLR.RWP==0 or timeout */
+		while (readl_relaxed(rbase + GICR_CTLR) & GICR_CTLR_RWP) {
+			if (!count) {
+				pr_err("CPU%d: Failed to disable LPIs\n",
+				       smp_processor_id());
+				return;
+			}
+			cpu_relax();
+			udelay(1);
+			count--;
+		};
+	}
 
 	/* set PROPBASE */
 	val = (page_to_phys(gic_rdists->prop_page) |
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
