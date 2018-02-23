Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbeBWQmF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:42:05 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:52016 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbeBWQmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:42:00 -0500
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 2/3] ARC: mcip: update MCIP debug mask when the new cpu came online
Date: Fri, 23 Feb 2018 19:41:53 +0300
Message-Id: <20180223164154.22377-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180223164154.22377-1-Eugeniy.Paltsev@synopsys.com>
References: <20180223164154.22377-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today we use hardcoded MCIP debug mask, so if we launch
kernel via debugger and kick fever cores than HW has all cpus
hang at the momemt of setup MCIP debug mask.

So update MCIP debug mask when the new cpu came online, instead of
use hardcoded MCIP debug mask.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---

Changes v1->v2:
 * update MCIP debug mask when the new cpu came online instead of
   using MCIP debug mask generated from "possible_cpus" mask.

 arch/arc/kernel/mcip.c | 37 ++++++++++++++++++++++++++++++++-----
 include/soc/arc/mcip.h |  2 ++
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/arc/kernel/mcip.c b/arch/arc/kernel/mcip.c
index 1119029..5fe84e4 100644
--- a/arch/arc/kernel/mcip.c
+++ b/arch/arc/kernel/mcip.c
@@ -51,6 +51,34 @@ static void mcip_update_gfrc_halt_mask(int cpu)
 	raw_spin_unlock_irqrestore(&mcip_lock, flags);
 }
 
+static void mcip_update_debug_halt_mask(int cpu)
+{
+	u32 mcip_mask = 0;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&mcip_lock, flags);
+
+	/*
+	 * mcip_mask is same for CMD_DEBUG_SET_SELECT and CMD_DEBUG_SET_MASK
+	 * commands. So read it once instead of reading both CMD_DEBUG_READ_MASK
+	 * and CMD_DEBUG_READ_SELECT.
+	 */
+	__mcip_cmd(CMD_DEBUG_READ_SELECT, 0);
+	mcip_mask = read_aux_reg(ARC_REG_MCIP_READBACK);
+
+	mcip_mask |= BIT(cpu);
+
+	__mcip_cmd_data(CMD_DEBUG_SET_SELECT, 0, mcip_mask);
+	/*
+	 * Parameter specified halt cause:
+	 * STATUS32[H]/actionpoint/breakpoint/self-halt
+	 * We choose all of them (0xF).
+	 */
+	__mcip_cmd_data(CMD_DEBUG_SET_MASK, 0xF, mcip_mask);
+
+	raw_spin_unlock_irqrestore(&mcip_lock, flags);
+}
+
 static void mcip_setup_per_cpu(int cpu)
 {
 	struct mcip_bcr mp;
@@ -63,6 +91,10 @@ static void mcip_setup_per_cpu(int cpu)
 	/* Update GFRC halt mask as new CPU came online */
 	if (mp.gfrc)
 		mcip_update_gfrc_halt_mask(cpu);
+
+	/* Update MCIP debug mask as new CPU came online */
+	if (mp.dbg)
+		mcip_update_debug_halt_mask(cpu);
 }
 
 static void mcip_ipi_send(int cpu)
@@ -138,11 +170,6 @@ static void mcip_probe_n_setup(void)
 		IS_AVAIL1(mp.gfrc, "GFRC"));
 
 	cpuinfo_arc700[0].extn.gfrc = mp.gfrc;
-
-	if (mp.dbg) {
-		__mcip_cmd_data(CMD_DEBUG_SET_SELECT, 0, 0xf);
-		__mcip_cmd_data(CMD_DEBUG_SET_MASK, 0xf, 0xf);
-	}
 }
 
 struct plat_smp_ops plat_smp_ops = {
diff --git a/include/soc/arc/mcip.h b/include/soc/arc/mcip.h
index 1138da5..a91f251 100644
--- a/include/soc/arc/mcip.h
+++ b/include/soc/arc/mcip.h
@@ -37,7 +37,9 @@ struct mcip_cmd {
 #define CMD_SEMA_RELEASE		0x12
 
 #define CMD_DEBUG_SET_MASK		0x34
+#define CMD_DEBUG_READ_MASK		0x35
 #define CMD_DEBUG_SET_SELECT		0x36
+#define CMD_DEBUG_READ_SELECT		0x37
 
 #define CMD_GFRC_READ_LO		0x42
 #define CMD_GFRC_READ_HI		0x43
-- 
2.9.3
