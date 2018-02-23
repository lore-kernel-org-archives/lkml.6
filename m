Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbeBWQmA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:42:00 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:38007 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbeBWQl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:41:59 -0500
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 1/3] ARC: mcip: halt GFRC together with ARC cores
Date: Fri, 23 Feb 2018 19:41:52 +0300
Message-Id: <20180223164154.22377-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.9.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently GFRC is running regardless state of ARC cores in the SMP cluster.
That means even if ARC cores are halted when doing JTAG debugging GFRC
[our source of wall-time] continues to run giving us unexpected warnings
once we allow ARC cores to run due to some tasks being stuck for too
long.

Starting from ARC HS v3.0 it's possible to tie GFRC to state of up-to 4
ARC cores with help of GFRC's CORE register where we set a mask for
cores which state we need to rely on.

We update cpu mask every time new cpu came online instead of using
hardcoded one or using mask generated from "possible_cpus" as we
want it set correctly even if we run kernel on HW which has fewer cores
than expected (or we launch kernel via debugger and kick fever cores
than HW has)

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---

Changes v1->v2:
 * wrap access to __mcip_cmd and __mcip_cmd_data into mcip_lock
   spinlock.
 * add GFRC_BUILD BCR check.
 * move MCIP_BCR read and check to mcip_setup_per_cpu function.

 arch/arc/kernel/mcip.c | 37 +++++++++++++++++++++++++++++++++++++
 include/soc/arc/mcip.h |  3 +++
 2 files changed, 40 insertions(+)

diff --git a/arch/arc/kernel/mcip.c b/arch/arc/kernel/mcip.c
index f61a52b..1119029 100644
--- a/arch/arc/kernel/mcip.c
+++ b/arch/arc/kernel/mcip.c
@@ -22,10 +22,47 @@ static DEFINE_RAW_SPINLOCK(mcip_lock);
 
 static char smp_cpuinfo_buf[128];
 
+/*
+ * Set mask to halt GFRC if any online core in SMP cluster is halted.
+ * Only works for ARC HS v3.0+, on earlier versions has no effect.
+ */
+static void mcip_update_gfrc_halt_mask(int cpu)
+{
+	struct bcr_generic gfrc;
+	unsigned long flags;
+	u32 gfrc_halt_mask;
+
+	READ_BCR(ARC_REG_GFRC_BUILD, gfrc);
+
+	/*
+	 * CMD_GFRC_SET_CORE and CMD_GFRC_READ_CORE commands were added in
+	 * GFRC 0x3 version.
+	 */
+	if (gfrc.ver < 0x3)
+		return;
+
+	raw_spin_lock_irqsave(&mcip_lock, flags);
+
+	__mcip_cmd(CMD_GFRC_READ_CORE, 0);
+	gfrc_halt_mask = read_aux_reg(ARC_REG_MCIP_READBACK);
+	gfrc_halt_mask |= BIT(cpu);
+	__mcip_cmd_data(CMD_GFRC_SET_CORE, 0, gfrc_halt_mask);
+
+	raw_spin_unlock_irqrestore(&mcip_lock, flags);
+}
+
 static void mcip_setup_per_cpu(int cpu)
 {
+	struct mcip_bcr mp;
+
+	READ_BCR(ARC_REG_MCIP_BCR, mp);
+
 	smp_ipi_irq_setup(cpu, IPI_IRQ);
 	smp_ipi_irq_setup(cpu, SOFTIRQ_IRQ);
+
+	/* Update GFRC halt mask as new CPU came online */
+	if (mp.gfrc)
+		mcip_update_gfrc_halt_mask(cpu);
 }
 
 static void mcip_ipi_send(int cpu)
diff --git a/include/soc/arc/mcip.h b/include/soc/arc/mcip.h
index c2d1b15..1138da5 100644
--- a/include/soc/arc/mcip.h
+++ b/include/soc/arc/mcip.h
@@ -15,6 +15,7 @@
 
 #define ARC_REG_MCIP_BCR	0x0d0
 #define ARC_REG_MCIP_IDU_BCR	0x0D5
+#define ARC_REG_GFRC_BUILD	0x0D6
 #define ARC_REG_MCIP_CMD	0x600
 #define ARC_REG_MCIP_WDATA	0x601
 #define ARC_REG_MCIP_READBACK	0x602
@@ -40,6 +41,8 @@ struct mcip_cmd {
 
 #define CMD_GFRC_READ_LO		0x42
 #define CMD_GFRC_READ_HI		0x43
+#define CMD_GFRC_SET_CORE		0x47
+#define CMD_GFRC_READ_CORE		0x48
 
 #define CMD_IDU_ENABLE			0x71
 #define CMD_IDU_DISABLE			0x72
-- 
2.9.3
