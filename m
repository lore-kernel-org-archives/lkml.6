Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163888AbeE1NNb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163706AbeE1Kuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:50:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 179/496] ARC: mcip: update MCIP debug mask when the new cpu came online
Date: Mon, 28 May 2018 11:59:24 +0200
Message-Id: <20180528100327.453478721@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

[ Upstream commit f3205de98db2fc8083796dd5ad81b191e436fab8 ]

As of today we use hardcoded MCIP debug mask, so if we launch
kernel via debugger and kick fever cores than HW has all cpus
hang at the momemt of setup MCIP debug mask.

So update MCIP debug mask when the new cpu came online, instead of
use hardcoded MCIP debug mask.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arc/kernel/mcip.c |   37 ++++++++++++++++++++++++++++++++-----
 include/soc/arc/mcip.h |    2 ++
 2 files changed, 34 insertions(+), 5 deletions(-)

--- a/arch/arc/kernel/mcip.c
+++ b/arch/arc/kernel/mcip.c
@@ -51,6 +51,34 @@ static void mcip_update_gfrc_halt_mask(i
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
