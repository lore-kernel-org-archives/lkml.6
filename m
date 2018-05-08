Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932384AbeEHNht (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:37:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932164AbeEHNhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:37:47 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: mhiramat@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [RFC PATCH -tip 2/4] kprobes: Remove jprobe generic code
Date: Tue,  8 May 2018 22:37:23 +0900
Message-Id: <152578664349.31022.13591383815605124106.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152578658468.31022.8952561651556318637.stgit@devbox>
References: <152578658468.31022.8952561651556318637.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove jprobe arch independent generic code
from kernel/kprobes.c.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |   76 ------------------------------------------------------
 1 file changed, 76 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ea619021d901..cb1c372eef62 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1812,77 +1812,6 @@ unsigned long __weak arch_deref_entry_point(void *entry)
 	return (unsigned long)entry;
 }
 
-#if 0
-int register_jprobes(struct jprobe **jps, int num)
-{
-	int ret = 0, i;
-
-	if (num <= 0)
-		return -EINVAL;
-
-	for (i = 0; i < num; i++) {
-		ret = register_jprobe(jps[i]);
-
-		if (ret < 0) {
-			if (i > 0)
-				unregister_jprobes(jps, i);
-			break;
-		}
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(register_jprobes);
-
-int register_jprobe(struct jprobe *jp)
-{
-	unsigned long addr, offset;
-	struct kprobe *kp = &jp->kp;
-
-	/*
-	 * Verify probepoint as well as the jprobe handler are
-	 * valid function entry points.
-	 */
-	addr = arch_deref_entry_point(jp->entry);
-
-	if (kallsyms_lookup_size_offset(addr, NULL, &offset) && offset == 0 &&
-	    kprobe_on_func_entry(kp->addr, kp->symbol_name, kp->offset)) {
-		kp->pre_handler = setjmp_pre_handler;
-		kp->break_handler = longjmp_break_handler;
-		return register_kprobe(kp);
-	}
-
-	return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(register_jprobe);
-
-void unregister_jprobe(struct jprobe *jp)
-{
-	unregister_jprobes(&jp, 1);
-}
-EXPORT_SYMBOL_GPL(unregister_jprobe);
-
-void unregister_jprobes(struct jprobe **jps, int num)
-{
-	int i;
-
-	if (num <= 0)
-		return;
-	mutex_lock(&kprobe_mutex);
-	for (i = 0; i < num; i++)
-		if (__unregister_kprobe_top(&jps[i]->kp) < 0)
-			jps[i]->kp.addr = NULL;
-	mutex_unlock(&kprobe_mutex);
-
-	synchronize_sched();
-	for (i = 0; i < num; i++) {
-		if (jps[i]->kp.addr)
-			__unregister_kprobe_bottom(&jps[i]->kp);
-	}
-}
-EXPORT_SYMBOL_GPL(unregister_jprobes);
-#endif
-
 #ifdef CONFIG_KRETPROBES
 /*
  * This kprobe pre_handler is registered with every kretprobe. When probe
@@ -2329,8 +2258,6 @@ static void report_probe(struct seq_file *pi, struct kprobe *p,
 
 	if (p->pre_handler == pre_handler_kretprobe)
 		kprobe_type = "r";
-	else if (p->pre_handler == setjmp_pre_handler)
-		kprobe_type = "j";
 	else
 		kprobe_type = "k";
 
@@ -2637,6 +2564,3 @@ late_initcall(debugfs_kprobe_init);
 #endif /* CONFIG_DEBUG_FS */
 
 module_init(init_kprobes);
-
-/* defined in arch/.../kernel/kprobes.c */
-EXPORT_SYMBOL_GPL(jprobe_return);
