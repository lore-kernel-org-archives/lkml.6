Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932569AbeBUJkp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:40:45 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:55952 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932349AbeBUJkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:40:43 -0500
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 1/3] ARC: mcip: halt GFRC together with ARC cores
Date: Wed, 21 Feb 2018 12:40:25 +0300
Message-Id: <20180221094027.12674-1-Eugeniy.Paltsev@synopsys.com>
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

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
---
NOTE: with this patch previous patch is not required:
http://patchwork.ozlabs.org/patch/875091/

 arch/arc/kernel/mcip.c | 23 +++++++++++++++++++++++
 include/soc/arc/mcip.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/arch/arc/kernel/mcip.c b/arch/arc/kernel/mcip.c
index f61a52b..e87a4ea 100644
--- a/arch/arc/kernel/mcip.c
+++ b/arch/arc/kernel/mcip.c
@@ -22,10 +22,33 @@ static DEFINE_RAW_SPINLOCK(mcip_lock);
 
 static char smp_cpuinfo_buf[128];
 
+/*
+ * Set mask to halt GFRC if any online core in SMP cluster is halted.
+ * Only works for ARC HS v3.0+, on earlier versions has no effect.
+ */
+static void mcip_update_gfrc_halt_mask(int cpu)
+{
+	struct mcip_bcr mp;
+	u32 gfrc_halt_mask;
+
+	READ_BCR(ARC_REG_MCIP_BCR, mp);
+
+	if (!mp.gfrc)
+		return;
+
+	__mcip_cmd(CMD_GFRC_READ_CORE, 0);
+	gfrc_halt_mask = read_aux_reg(ARC_REG_MCIP_READBACK);
+	gfrc_halt_mask |= BIT(cpu);
+	__mcip_cmd_data(CMD_GFRC_SET_CORE, 0, gfrc_halt_mask);
+}
+
 static void mcip_setup_per_cpu(int cpu)
 {
 	smp_ipi_irq_setup(cpu, IPI_IRQ);
 	smp_ipi_irq_setup(cpu, SOFTIRQ_IRQ);
+
+	/* Update GFRC halt mask as new CPU came online */
+	mcip_update_gfrc_halt_mask(cpu);
 }
 
 static void mcip_ipi_send(int cpu)
diff --git a/include/soc/arc/mcip.h b/include/soc/arc/mcip.h
index c2d1b15..a156fa5 100644
--- a/include/soc/arc/mcip.h
+++ b/include/soc/arc/mcip.h
@@ -40,6 +40,8 @@ struct mcip_cmd {
 
 #define CMD_GFRC_READ_LO		0x42
 #define CMD_GFRC_READ_HI		0x43
+#define CMD_GFRC_SET_CORE		0x47
+#define CMD_GFRC_READ_CORE		0x48
 
 #define CMD_IDU_ENABLE			0x71
 #define CMD_IDU_DISABLE			0x72
-- 
2.9.3
