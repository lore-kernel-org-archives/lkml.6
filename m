Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033762AbeBOPMi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:12:38 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:40078 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033584AbeBOPMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:12:36 -0500
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        Ed Blake <ed.blake@sondrel.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Dengcheng Zhu <dengcheng.zhu@mips.com>, <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] MIPS: pm-cps: Block system suspend when a JTAG probe is present
Date: Thu, 15 Feb 2018 14:59:19 +0000
Message-ID: <1518706759-9890-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1518707531-321459-9889-6160-11
X-BESS-VER: 2018.2-r1802142118
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190054
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a JTAG probe is connected to a MIPS cluster, then the CPC detects it
and latches the CPC.STAT_CONF.EJTAG_PROBE bit to 1. While set,
attempting to send a power-down command to a core will be blocked, and
the CPC will instead send the core to clock-off state. This can
interfere with systems fully entering a low power state where all
cores, CM, GIC, etc are powered down.

Detect that a JTAG probe is / has been connected to the cluster and
block the suspend attempt.

Attempting to suspend the system while a JTAG probe is connected now
yields:
 # echo mem > /sys/power/state
 [   11.654000] PM: Syncing filesystems ... done.
 [   11.658000] JTAG probe is connected - abort suspend
 -sh: echo: write error: Operation not permitted
 #

To restore suspend, the JTAG probe should be disconnected or put into
quiescent state. Platform code can then clear the
CPC.STAT_CONF.EJTAG_PROBE bit.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

---

 arch/mips/kernel/pm-cps.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index 421e06dfee72..2e0f4bad72b9 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 
 #include <asm/asm-offsets.h>
 #include <asm/cacheflush.h>
@@ -670,6 +671,36 @@ static int cps_pm_online_cpu(unsigned int cpu)
 	return 0;
 }
 
+#if defined(CONFIG_PM_SLEEP)
+static int cps_pm_power_notifier(struct notifier_block *this,
+				 unsigned long event, void *ptr)
+{
+	unsigned int stat;
+
+	switch (event) {
+	case PM_SUSPEND_PREPARE:
+		stat = read_cpc_cl_stat_conf();
+		/*
+		 * If we're attempting to suspend the system and power down all
+		 * of the cores, the JTAG detect bit indicates that the CPC will
+		 * instead put the cores into clock-off state. In this state
+		 * a connected debugger can cause the CPU to attempt
+		 * interactions with the powered down system. At best this will
+		 * fail. At worst, it can hang the NoC, requiring a hard reset.
+		 * To avoid this, just block system suspend if a JTAG probe
+		 * is detected.
+		 */
+		if (stat & CPC_Cx_STAT_CONF_EJTAG_PROBE_MSK) {
+			pr_warn("JTAG probe is connected - abort suspend\n");
+			return NOTIFY_BAD;
+		}
+		return NOTIFY_DONE;
+	default:
+		return NOTIFY_DONE;
+	}
+}
+#endif /* CONFIG_PM_SLEEP */
+
 static int __init cps_pm_init(void)
 {
 	/* A CM is required for all non-coherent states */
@@ -705,6 +736,8 @@ static int __init cps_pm_init(void)
 		pr_warn("pm-cps: no CPC, clock & power gating unavailable\n");
 	}
 
+	pm_notifier(cps_pm_power_notifier, 0);
+
 	return cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mips/cps_pm:online",
 				 cps_pm_online_cpu, NULL);
 }
-- 
2.7.4
