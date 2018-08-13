Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D2BC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F46217CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F46217CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbeHMQnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:43:49 -0400
Received: from relay2.sgi.com ([192.48.180.65]:41316 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729981AbeHMQnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:43:49 -0400
X-Greylist: delayed 526 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Aug 2018 12:43:48 EDT
Received: from stormcage.americas.sgi.com (stormcage.americas.sgi.com [128.162.236.70])
        by relay2.corp.sgi.com (Postfix) with ESMTP id 0D802304043;
        Mon, 13 Aug 2018 06:52:36 -0700 (PDT)
Received: by stormcage.americas.sgi.com (Postfix, from userid 200151)
        id BE2B1200FAD19; Mon, 13 Aug 2018 08:54:40 -0500 (CDT)
From:   Andrew Banman <abanman@hpe.com>
To:     mingo@redhat.com, tglx@linutronix.de
Cc:     Andrew Banman <abanman@hpe.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dimitri Sivanich <sivanich@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/platform/uv/BAU: gracefully disable BAU during panic
Date:   Mon, 13 Aug 2018 08:54:37 -0500
Message-Id: <1534168477-311448-1-git-send-email-abanman@hpe.com>
X-Mailer: git-send-email 1.8.2.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we panic while the BAU is active, outstanding broadcasts may go
un-acknowledged by the kernel. These broadcasts cause timeouts in the
UV ASIC that tie up BAU resources, which may cause a fatal error that
brings down the system, thereby crashing the kdump kexec.

Add uv_bau_crash_shutdown() to bring BAU to quiescence ahead of the crash
shutdown routine saved in smp machine_ops. Assign uv_bau_crash_shutdown
to machine_ops during init.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Dimitri Sivanich <sivanich@hpe.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Andrew Banman <abanman@hpe.com>
---
 arch/x86/platform/uv/tlb_uv.c | 49 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index e26dfad..dae6b3c 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -22,8 +22,13 @@
 #include <asm/tsc.h>
 #include <asm/irq_vectors.h>
 #include <asm/timer.h>
+#include <asm/reboot.h>
 
 static struct bau_operations ops __ro_after_init;
+#ifdef CONFIG_KEXEC_CORE
+static void (*crash_shutdown)(struct pt_regs *regs) __ro_after_init;
+static bool crash_in_progress;
+#endif
 
 /* timeouts in nanoseconds (indexed by UVH_AGING_PRESCALE_SEL urgency7 30:28) */
 static const int timeout_base_ns[] = {
@@ -2195,6 +2200,44 @@ static int __init init_per_cpu(int nuvhubs, int base_part_pnode)
 	.wait_completion         = uv4_wait_completion,
 };
 
+#ifdef CONFIG_KEXEC_CORE
+/*
+ * Bring BAU to quiesence by abandoning current broadcasts and freeing up
+ * resources needed by firmware-initiated BAU broadcasts.
+ */
+void uv_bau_crash_shutdown(struct pt_regs *regs)
+{
+	int pnode = 0;
+	int uvhub = 0;
+
+	if (crash_in_progress)
+		return;
+	crash_in_progress = true;
+
+	/*
+	 * Don't bother turning off BAU in the per-cpu structs. We free up
+	 * enough INTD resources to accommodate any new broadcasts that
+	 * may (however unlikley) start up before we complete the panic,
+	 * without tying up FW-initiated General Broadcasts that must not
+	 * time out.
+	 */
+
+	for_each_possible_blade(uvhub) {
+		if (!uv_blade_nr_possible_cpus(uvhub))
+			continue;
+		pnode = uv_blade_to_pnode(uvhub);
+		/* Set STATUS registers to idle to free source cpus */
+		write_gmmr(pnode, UVH_LB_BAU_SB_ACTIVATION_STATUS_0, 0x0);
+		write_gmmr(pnode, UVH_LB_BAU_SB_ACTIVATION_STATUS_1, 0x0);
+		write_gmmr(pnode, UVH_LB_BAU_SB_ACTIVATION_STATUS_2, 0x0);
+		/* Clear TIMEOUT and PENDING bits to free up BAU resources */
+		ops.write_g_sw_ack(pnode, ops.read_g_sw_ack(pnode) & 0xFFFF);
+	}
+
+	crash_shutdown(regs);
+}
+#endif
+
 /*
  * Initialization of BAU-related structures
  */
@@ -2267,6 +2310,12 @@ static int __init uv_bau_init(void)
 		}
 	}
 
+#ifdef CONFIG_KEXEC_CORE
+	crash_shutdown = machine_ops.crash_shutdown;
+	machine_ops.crash_shutdown = uv_bau_crash_shutdown;
+	crash_in_progress = false;
+#endif
+
 	return 0;
 
 err_bau_disable:
-- 
1.8.2.1

