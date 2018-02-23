Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbeBWJZH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 04:25:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751481AbeBWJZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 04:25:05 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68152178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Russell King <linux@armlinux.org.uk>
Cc: Wang Nan <wangnan0@huawei.com>, Will Deacon <will.deacon@arm.com>,
        Jon Medhurst <tixy@linaro.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org
Subject: [PATCH] [BUGFIX] arm: kprobes: Fix to use get_kprobe_ctlblk after irq-disabed
Date: Fri, 23 Feb 2018 18:24:40 +0900
Message-Id: <151937788067.22527.14819753928851623471.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since get_kprobe_ctlblk() uses smp_processor_id() to access
per-cpu variable, it hits smp_processor_id sanity check as below.

[    7.006928] BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
[    7.007859] caller is debug_smp_processor_id+0x20/0x24
[    7.008438] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc1-00192-g4eb17253e4b5 #1
[    7.008890] Hardware name: Generic DT based system
[    7.009917] [<c0313f0c>] (unwind_backtrace) from [<c030e6d8>] (show_stack+0x20/0x24)
[    7.010473] [<c030e6d8>] (show_stack) from [<c0c64694>] (dump_stack+0x84/0x98)
[    7.010990] [<c0c64694>] (dump_stack) from [<c071ca5c>] (check_preemption_disabled+0x138/0x13c)
[    7.011592] [<c071ca5c>] (check_preemption_disabled) from [<c071ca80>] (debug_smp_processor_id+0x20/0x24)
[    7.012214] [<c071ca80>] (debug_smp_processor_id) from [<c03335e0>] (optimized_callback+0x2c/0xe4)
[    7.013077] [<c03335e0>] (optimized_callback) from [<bf0021b0>] (0xbf0021b0)

To fix this issue, call get_kprobe_ctlblk() right after
irq-disabled since that disables preemption.

Fixes: 0dc016dbd820 ("ARM: kprobes: enable OPTPROBES for ARM 32")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm/probes/kprobes/opt-arm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
index bcdecc25461b..ddc5a82eb10d 100644
--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -165,13 +165,14 @@ optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
 {
 	unsigned long flags;
 	struct kprobe *p = &op->kp;
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+	struct kprobe_ctlblk *kcb;
 
 	/* Save skipped registers */
 	regs->ARM_pc = (unsigned long)op->kp.addr;
 	regs->ARM_ORIG_r0 = ~0UL;
 
 	local_irq_save(flags);
+	kcb = get_kprobe_ctlblk();
 
 	if (kprobe_running()) {
 		kprobes_inc_nmissed_count(&op->kp);
