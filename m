Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932574AbeCMRVm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:21:42 -0400
Received: from foss.arm.com ([217.140.101.70]:42006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932474AbeCMRVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:21:16 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/3] irqchip/gic-v3: Reset APgRn registers at boot time
Date: Tue, 13 Mar 2018 17:21:02 +0000
Message-Id: <20180313172103.24281-3-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180313172103.24281-1-marc.zyngier@arm.com>
References: <20180313172103.24281-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting a crash kernel while in an interrupt handler is likely
to leave the Active Priority Registers with some state that
is not relevant to the new kernel, and is likely to lead
to erratic behaviours such as interrupts not firing as their
priority is already active.

As a sanity measure, wipe the APRs clean on startup. We make
sure to wipe both group 0 and 1 registers in order to avoid
any surprise.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arch_gicv3.h | 41 +++++++++++++++++++++++++++++----------
 drivers/irqchip/irq-gic-v3.c      | 23 ++++++++++++++++++++++
 2 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index 1070044f5c3f..27288bdbd840 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -35,6 +35,18 @@
 #define ICC_IGRPEN1			__ACCESS_CP15(c12, 0, c12, 7)
 #define ICC_BPR1			__ACCESS_CP15(c12, 0, c12, 3)
 
+#define __ICC_AP0Rx(x)			__ACCESS_CP15(c12, 0, c8, 4 | x)
+#define ICC_AP0R0			__ICC_AP0Rx(0)
+#define ICC_AP0R1			__ICC_AP0Rx(1)
+#define ICC_AP0R2			__ICC_AP0Rx(2)
+#define ICC_AP0R3			__ICC_AP0Rx(3)
+
+#define __ICC_AP1Rx(x)			__ACCESS_CP15(c12, 0, c9, x)
+#define ICC_AP1R0			__ICC_AP1Rx(0)
+#define ICC_AP1R1			__ICC_AP1Rx(1)
+#define ICC_AP1R2			__ICC_AP1Rx(2)
+#define ICC_AP1R3			__ICC_AP1Rx(3)
+
 #define ICC_HSRE			__ACCESS_CP15(c12, 4, c9, 5)
 
 #define ICH_VSEIR			__ACCESS_CP15(c12, 4, c9, 4)
@@ -86,17 +98,17 @@
 #define ICH_LRC14			__LRC8(6)
 #define ICH_LRC15			__LRC8(7)
 
-#define __AP0Rx(x)			__ACCESS_CP15(c12, 4, c8, x)
-#define ICH_AP0R0			__AP0Rx(0)
-#define ICH_AP0R1			__AP0Rx(1)
-#define ICH_AP0R2			__AP0Rx(2)
-#define ICH_AP0R3			__AP0Rx(3)
+#define __ICH_AP0Rx(x)			__ACCESS_CP15(c12, 4, c8, x)
+#define ICH_AP0R0			__ICH_AP0Rx(0)
+#define ICH_AP0R1			__ICH_AP0Rx(1)
+#define ICH_AP0R2			__ICH_AP0Rx(2)
+#define ICH_AP0R3			__ICH_AP0Rx(3)
 
-#define __AP1Rx(x)			__ACCESS_CP15(c12, 4, c9, x)
-#define ICH_AP1R0			__AP1Rx(0)
-#define ICH_AP1R1			__AP1Rx(1)
-#define ICH_AP1R2			__AP1Rx(2)
-#define ICH_AP1R3			__AP1Rx(3)
+#define __ICH_AP1Rx(x)			__ACCESS_CP15(c12, 4, c9, x)
+#define ICH_AP1R0			__ICH_AP1Rx(0)
+#define ICH_AP1R1			__ICH_AP1Rx(1)
+#define ICH_AP1R2			__ICH_AP1Rx(2)
+#define ICH_AP1R3			__ICH_AP1Rx(3)
 
 /* A32-to-A64 mappings used by VGIC save/restore */
 
@@ -125,6 +137,15 @@ static inline u64 read_ ## a64(void)		\
 	return val; 				\
 }
 
+CPUIF_MAP(ICC_AP0R0, ICC_AP0R0_EL1)
+CPUIF_MAP(ICC_AP0R1, ICC_AP0R1_EL1)
+CPUIF_MAP(ICC_AP0R2, ICC_AP0R2_EL1)
+CPUIF_MAP(ICC_AP0R3, ICC_AP0R3_EL1)
+CPUIF_MAP(ICC_AP1R0, ICC_AP1R0_EL1)
+CPUIF_MAP(ICC_AP1R1, ICC_AP1R1_EL1)
+CPUIF_MAP(ICC_AP1R2, ICC_AP1R2_EL1)
+CPUIF_MAP(ICC_AP1R3, ICC_AP1R3_EL1)
+
 CPUIF_MAP(ICH_HCR, ICH_HCR_EL2)
 CPUIF_MAP(ICH_VTR, ICH_VTR_EL2)
 CPUIF_MAP(ICH_MISR, ICH_MISR_EL2)
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d99cc07903ec..0ea02504115d 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -532,6 +532,7 @@ static void gic_cpu_sys_reg_init(void)
 	int i, cpu = smp_processor_id();
 	u64 mpidr = cpu_logical_map(cpu);
 	u64 need_rss = MPIDR_RS(mpidr);
+	u32 val;
 
 	/*
 	 * Need to check that the SRE bit has actually been set. If
@@ -562,6 +563,28 @@ static void gic_cpu_sys_reg_init(void)
 		gic_write_ctlr(ICC_CTLR_EL1_EOImode_drop_dir);
 	}
 
+	val = gic_read_ctlr();
+	val &= ICC_CTLR_EL1_PRI_BITS_MASK;
+	val >>= ICC_CTLR_EL1_PRI_BITS_SHIFT;
+
+	switch(val + 1) {
+	case 8:
+	case 7:
+		write_gicreg(0, ICC_AP0R3_EL1);
+		write_gicreg(0, ICC_AP1R3_EL1);
+		write_gicreg(0, ICC_AP0R2_EL1);
+		write_gicreg(0, ICC_AP1R2_EL1);
+	case 6:
+		write_gicreg(0, ICC_AP0R1_EL1);
+		write_gicreg(0, ICC_AP1R1_EL1);
+	case 5:
+	case 4:
+		write_gicreg(0, ICC_AP0R0_EL1);
+		write_gicreg(0, ICC_AP1R0_EL1);
+	}
+
+	isb();
+
 	/* ... and let's hit the road... */
 	gic_write_grpen1(1);
 
-- 
2.14.2
