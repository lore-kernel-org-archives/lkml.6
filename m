Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752269AbeCWV7b (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 17:59:31 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46597 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752152AbeCWV71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 17:59:27 -0400
X-Google-Smtp-Source: AG47ELsW98P55+AOGWXrkPv1oseBx5bk0dC6Ywc/ruR5300Hjpg+JHrhe61mK6+In7Ln3Uav/2wA5g==
From: Eric Dumazet <edumazet@google.com>
To: x86 <x86@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v3 2/2] x86, cpuid: allow cpuid_read() to schedule
Date: Fri, 23 Mar 2018 14:58:18 -0700
Message-Id: <20180323215818.127774-2-edumazet@google.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
In-Reply-To: <20180323215818.127774-1-edumazet@google.com>
References: <20180323215818.127774-1-edumazet@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed high latencies caused by a daemon periodically reading various
MSR and cpuid on all cpus. KASAN kernels would see ~10ms latencies
simply reading one cpuid. Even without KASAN, sending IPI to CPU
in deep sleep state or blocking hard IRQ in a a long section,
then waiting for the answer can consume hundreds of usec or more.

Switching to smp_call_function_single_async() and a completion
allows to reschedule and not burn cpu cycles.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
---
 arch/x86/kernel/cpuid.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpuid.c b/arch/x86/kernel/cpuid.c
index 0931a105ffe16cde4640e759efa600b23a756d84..1d300f96df4b316dbe3392c8221467cfd8593272 100644
--- a/arch/x86/kernel/cpuid.c
+++ b/arch/x86/kernel/cpuid.c
@@ -40,6 +40,7 @@
 #include <linux/notifier.h>
 #include <linux/uaccess.h>
 #include <linux/gfp.h>
+#include <linux/completion.h>
 
 #include <asm/processor.h>
 #include <asm/msr.h>
@@ -47,19 +48,27 @@
 static struct class *cpuid_class;
 static enum cpuhp_state cpuhp_cpuid_state;
 
+struct cpuid_regs_done {
+	struct cpuid_regs regs;
+	struct completion done;
+};
+
 static void cpuid_smp_cpuid(void *cmd_block)
 {
-	struct cpuid_regs *cmd = (struct cpuid_regs *)cmd_block;
+	struct cpuid_regs_done *cmd = cmd_block;
+
+	cpuid_count(cmd->regs.eax, cmd->regs.ecx,
+		    &cmd->regs.eax, &cmd->regs.ebx,
+		    &cmd->regs.ecx, &cmd->regs.edx);
 
-	cpuid_count(cmd->eax, cmd->ecx,
-		    &cmd->eax, &cmd->ebx, &cmd->ecx, &cmd->edx);
+	complete(&cmd->done);
 }
 
 static ssize_t cpuid_read(struct file *file, char __user *buf,
 			  size_t count, loff_t *ppos)
 {
 	char __user *tmp = buf;
-	struct cpuid_regs cmd;
+	struct cpuid_regs_done cmd;
 	int cpu = iminor(file_inode(file));
 	u64 pos = *ppos;
 	ssize_t bytes = 0;
@@ -68,19 +77,28 @@ static ssize_t cpuid_read(struct file *file, char __user *buf,
 	if (count % 16)
 		return -EINVAL;	/* Invalid chunk size */
 
+	init_completion(&cmd.done);
 	for (; count; count -= 16) {
-		cmd.eax = pos;
-		cmd.ecx = pos >> 32;
-		err = smp_call_function_single(cpu, cpuid_smp_cpuid, &cmd, 1);
+		call_single_data_t csd = {
+			.func = cpuid_smp_cpuid,
+			.info = &cmd,
+		};
+
+		cmd.regs.eax = pos;
+		cmd.regs.ecx = pos >> 32;
+
+		err = smp_call_function_single_async(cpu, &csd);
 		if (err)
 			break;
-		if (copy_to_user(tmp, &cmd, 16)) {
+		wait_for_completion(&cmd.done);
+		if (copy_to_user(tmp, &cmd.regs, 16)) {
 			err = -EFAULT;
 			break;
 		}
 		tmp += 16;
 		bytes += 16;
 		*ppos = ++pos;
+		reinit_completion(&cmd.done);
 	}
 
 	return bytes ? bytes : err;
-- 
2.17.0.rc0.231.g781580f067-goog
