Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbeFCQve (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 12:51:34 -0400
Received: from relay2.sgi.com ([192.48.180.65]:33330 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750952AbeFCQvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 12:51:32 -0400
From: Andrew Banman <abanman@hpe.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Mike Travis <mike.travis@hpe.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Andrew Banman <abanman@hpe.com>
Subject: [PATCH] x86/platform/uv/BAU: gracefully disable BAU during panic
Date: Sun,  3 Jun 2018 11:42:32 -0500
Message-Id: <1528044152-148686-1-git-send-email-abanman@hpe.com>
X-Mailer: git-send-email 1.8.2.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When panic happens while BAU is active there is a chance that
outstanding broadcasts tie up BAU resources enough to cause timeouts in
the UV ASIC. These timeouts are hardware errors that immediately bring
down the system, preventing kdump from completing.

Add uv_bau_crash_shutdown() to bring BAU to quiescence during panic before
continuing with the native crash shutdown. Assign uv_bau_crash_shutdown
to machine_ops during init.

Signed-off-by: Andrew Banman <abanman@hpe.com>
---
 arch/x86/platform/uv/tlb_uv.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index b36caae..e7f9aea 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -22,6 +22,7 @@
 #include <asm/tsc.h>
 #include <asm/irq_vectors.h>
 #include <asm/timer.h>
+#include <asm/reboot.h>
 
 static struct bau_operations ops __ro_after_init;
 
@@ -2197,6 +2198,32 @@ static int __init init_per_cpu(int nuvhubs, int base_part_pnode)
 	.wait_completion         = uv4_wait_completion,
 };
 
+#ifdef CONFIG_KEXEC_CORE
+/*
+ * Bring BAU to quiesence by disabling future broadcasts and abandoning
+ * current broadcasts during panic.
+ */
+void uv_bau_crash_shutdown(struct pt_regs *regs)
+{
+	set_bau_off();
+	nobau_perm = 1;
+
+	for_each_possible_blade(uvhub) {
+		if (!uv_blade_nr_possible_cpus(uvhub))
+			continue;
+		int pnode = uv_blade_to_pnode(uvhub);
+		/* Set STATUS registers to idle to free source cpus */
+		write_gmmr(pnode, UVH_LB_BAU_SB_ACTIVATION_STATUS_0, 0x0);
+		write_gmmr(pnode, UVH_LB_BAU_SB_ACTIVATION_STATUS_1, 0x0);
+		write_gmmr(pnode, UVH_LB_BAU_SB_ACTIVATION_STATUS_2, 0x0);
+		/* Clear TIMEOUT and PENDING bits to free up BAU resources */
+		ops.write_g_sw_ack(pnode, ops.read_g_sw_ack(pnode) & 0xFFFF);
+	}
+
+	native_machine_crash_shutdown(regs);
+}
+#endif
+
 /*
  * Initialization of BAU-related structures
  */
@@ -2269,6 +2296,10 @@ static int __init uv_bau_init(void)
 		}
 	}
 
+#ifdef CONFIG_KEXEC_CORE
+	machine_ops.crash_shutdown = uv_bau_crash_shutdown;
+#endif
+
 	return 0;
 
 err_bau_disable:
-- 
1.8.2.1
