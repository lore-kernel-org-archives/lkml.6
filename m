Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965950AbeEYJuO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:50:14 -0400
Received: from foss.arm.com ([217.140.101.70]:57448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965880AbeEYJuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:50:08 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v4 05/26] irqchip/gic: Unify GIC priority definitions
Date: Fri, 25 May 2018 10:49:11 +0100
Message-Id: <1527241772-48007-6-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LPIs use the same priority value as other GIC interrupts.

Make the GIC default priority definition visible to ITS implementation
and use this same definition for LPI priorities.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c       | 2 +-
 include/linux/irqchip/arm-gic-common.h | 6 ++++++
 include/linux/irqchip/arm-gic.h        | 5 -----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5416f2b..9ac146c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -62,7 +62,7 @@
 #define LPI_PROPBASE_SZ		ALIGN(BIT(LPI_NRBITS), SZ_64K)
 #define LPI_PENDBASE_SZ		ALIGN(BIT(LPI_NRBITS) / 8, SZ_64K)
 
-#define LPI_PROP_DEFAULT_PRIO	0xa0
+#define LPI_PROP_DEFAULT_PRIO	GICD_INT_DEF_PRI
 
 /*
  * Collection structure - just an ID, and a redistributor address to
diff --git a/include/linux/irqchip/arm-gic-common.h b/include/linux/irqchip/arm-gic-common.h
index 0a83b43..9a1a479 100644
--- a/include/linux/irqchip/arm-gic-common.h
+++ b/include/linux/irqchip/arm-gic-common.h
@@ -13,6 +13,12 @@
 #include <linux/types.h>
 #include <linux/ioport.h>
 
+#define GICD_INT_DEF_PRI		0xa0
+#define GICD_INT_DEF_PRI_X4		((GICD_INT_DEF_PRI << 24) |\
+					(GICD_INT_DEF_PRI << 16) |\
+					(GICD_INT_DEF_PRI << 8) |\
+					GICD_INT_DEF_PRI)
+
 enum gic_type {
 	GIC_V2,
 	GIC_V3,
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 68d8b1f..5f2129b 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -65,11 +65,6 @@
 #define GICD_INT_EN_CLR_X32		0xffffffff
 #define GICD_INT_EN_SET_SGI		0x0000ffff
 #define GICD_INT_EN_CLR_PPI		0xffff0000
-#define GICD_INT_DEF_PRI		0xa0
-#define GICD_INT_DEF_PRI_X4		((GICD_INT_DEF_PRI << 24) |\
-					(GICD_INT_DEF_PRI << 16) |\
-					(GICD_INT_DEF_PRI << 8) |\
-					GICD_INT_DEF_PRI)
 
 #define GICH_HCR			0x0
 #define GICH_VTR			0x4
-- 
1.9.1
