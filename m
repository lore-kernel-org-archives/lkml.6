Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E159C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517212170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517212170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeHTT3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:29:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58953 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeHTT3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:29:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7KGD0QM2126367
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 20 Aug 2018 09:13:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7KGCxws2126364;
        Mon, 20 Aug 2018 09:12:59 -0700
Date:   Mon, 20 Aug 2018 09:12:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrew Banman <tipbot@zytor.com>
Message-ID: <tip-99f3965878759d36baac944df004b4dafcc272b4@git.kernel.org>
Cc:     colin.king@canonical.com, hpa@zytor.com, mike.travis@hpe.com,
        sivanich@hpe.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        abanman@hpe.com, tglx@linutronix.de
Reply-To: colin.king@canonical.com, abanman@hpe.com, tglx@linutronix.de,
          sivanich@hpe.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          mike.travis@hpe.com, hpa@zytor.com
In-Reply-To: <1534168477-311448-1-git-send-email-abanman@hpe.com>
References: <1534168477-311448-1-git-send-email-abanman@hpe.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/platform/uv/BAU: Gracefully disable BAU during
 panic
Git-Commit-ID: 99f3965878759d36baac944df004b4dafcc272b4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  99f3965878759d36baac944df004b4dafcc272b4
Gitweb:     https://git.kernel.org/tip/99f3965878759d36baac944df004b4dafcc272b4
Author:     Andrew Banman <abanman@hpe.com>
AuthorDate: Mon, 13 Aug 2018 08:54:37 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 20 Aug 2018 18:04:43 +0200

x86/platform/uv/BAU: Gracefully disable BAU during panic

When a panic happens while the BAU is active, outstanding broadcasts may go
un-acknowledged by the kernel. These broadcasts cause timeouts in the UV
ASIC that tie up BAU resources, which may cause a fatal error that brings
down the system, thereby crashing the kdump kexec.

Add uv_bau_crash_shutdown() to bring BAU to quiescence ahead of the crash
shutdown routine saved in smp machine_ops. Assign uv_bau_crash_shutdown
to machine_ops during init.

Signed-off-by: Andrew Banman <abanman@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Mike Travis <mike.travis@hpe.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Dimitri Sivanich <sivanich@hpe.com>
Link: https://lkml.kernel.org/r/1534168477-311448-1-git-send-email-abanman@hpe.com

---
 arch/x86/platform/uv/tlb_uv.c | 49 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index a4130b84d1ff..4c1e1197b82d 100644
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
@@ -2196,6 +2201,44 @@ static const struct bau_operations uv4_bau_ops __initconst = {
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
@@ -2268,6 +2311,12 @@ static int __init uv_bau_init(void)
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
