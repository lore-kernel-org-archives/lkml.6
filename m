Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeC0KLJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 06:11:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49925 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbeC0KLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 06:11:08 -0400
Date: Tue, 27 Mar 2018 03:10:39 -0700
From: tip-bot for Eric Dumazet <tipbot@zytor.com>
Message-ID: <tip-67bbd7a8d6bcdc44cc27105ae8c374e9176ceaf1@git.kernel.org>
Cc: hughd@google.com, edumazet@google.com, linux-kernel@vger.kernel.org,
        eric.dumazet@gmail.com, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, bp@alien8.de
Reply-To: tglx@linutronix.de, eric.dumazet@gmail.com, mingo@kernel.org,
        bp@alien8.de, hpa@zytor.com, edumazet@google.com,
        linux-kernel@vger.kernel.org, hughd@google.com
In-Reply-To: <20180323215818.127774-2-edumazet@google.com>
References: <20180323215818.127774-2-edumazet@google.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/cpuid: Allow cpuid_read() to schedule
Git-Commit-ID: 67bbd7a8d6bcdc44cc27105ae8c374e9176ceaf1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  67bbd7a8d6bcdc44cc27105ae8c374e9176ceaf1
Gitweb:     https://git.kernel.org/tip/67bbd7a8d6bcdc44cc27105ae8c374e9176ceaf1
Author:     Eric Dumazet <edumazet@google.com>
AuthorDate: Fri, 23 Mar 2018 14:58:18 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 27 Mar 2018 12:01:48 +0200

x86/cpuid: Allow cpuid_read() to schedule

High latencies can be observed caused by a daemon periodically reading
CPUID on all cpus. On KASAN enabled kernels ~10ms latencies can be
observed. Even without KASAN, sending an IPI to a CPU, which is in a deep
sleep state or in a long hard IRQ disabled section, waiting for the answer
can consume hundreds of microseconds.

cpuid_read() is invoked in preemptible context, so it can be converted to
sleep instead of busy wait.

Switching to smp_call_function_single_async() and a completion allows to
reschedule and reduces CPU usage and latencies.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Link: https://lkml.kernel.org/r/20180323215818.127774-2-edumazet@google.com

---
 arch/x86/kernel/cpuid.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpuid.c b/arch/x86/kernel/cpuid.c
index 0931a105ffe1..1d300f96df4b 100644
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
