Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163920AbeE1NOJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163694AbeE1Kuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:50:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 178/496] ARC: mcip: halt GFRC counter when ARC cores halt
Date: Mon, 28 May 2018 11:59:23 +0200
Message-Id: <20180528100327.367664260@linuxfoundation.org>
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

[ Upstream commit 07423d00a2b2a71a97e4287d9262cb83c4c4c89f ]

In SMP systems, GFRC is used for clocksource. However by default the
counter keeps running even when core is halted (say when debugging via a
JTAG debugger). This confuses Linux timekeeping and triggers flase RCU stall
splat such as below:

| [ARCLinux]# while true; do ./shm_open_23-1.run-test ; done
| Running with 1000 processes for 1000 objects
| hrtimer: interrupt took 485060 ns
|
| create_cnt: 1000
| Running with 1000 processes for 1000 objects
| [ARCLinux]# INFO: rcu_preempt self-detected stall on CPU
|       2-...: (1 GPs behind) idle=a01/1/0 softirq=135770/135773 fqs=0
| INFO: rcu_preempt detected stalls on CPUs/tasks:
| 	0-...: (1 GPs behind) idle=71e/0/0 softirq=135264/135264 fqs=0
|	2-...: (1 GPs behind) idle=a01/1/0 softirq=135770/135773 fqs=0
|	3-...: (1 GPs behind) idle=4e0/0/0 softirq=134304/134304 fqs=0
|	(detected by 1, t=13648 jiffies, g=31493, c=31492, q=1)

Starting from ARC HS v3.0 it's possible to tie GFRC to state of up-to 4
ARC cores with help of GFRC's CORE register where we set a mask for
cores which state we need to rely on.

We update cpu mask every time new cpu came online instead of using
hardcoded one or using mask generated from "possible_cpus" as we
want it set correctly even if we run kernel on HW which has fewer cores
than expected (or we launch kernel via debugger and kick fever cores
than HW has)

Note that GFRC halts when all cores have halted and thus relies on
programming of Inter-Core-dEbug register to halt all cores when one
halts.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
[vgupta: rewrote changelog]
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arc/kernel/mcip.c |   37 +++++++++++++++++++++++++++++++++++++
 include/soc/arc/mcip.h |    3 +++
 2 files changed, 40 insertions(+)

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
