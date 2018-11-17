Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B021C04EBC
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC432075B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC432075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbeKQMmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:42:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:45904 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731204AbeKQMmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:42:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 18:27:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,242,1539673200"; 
   d="scan'208";a="281852630"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2018 18:27:49 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [Patch v5 13/16] security: Update speculation restriction of a process when modifying its dumpability
Date:   Fri, 16 Nov 2018 17:53:56 -0800
Message-Id: <ad3c32ce99639be118f8c0ca864a4ea1c5e6fbdd.1542418937.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1542418936.git.tim.c.chen@linux.intel.com>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1542418936.git.tim.c.chen@linux.intel.com>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a task is made non-dumpable, a higher level of security is implied
implicitly as its memory is imposed with access restriction.  Many
daemons touching sensitive data (e.g. sshd) make theselves non-dumpable.
Such tasks should have speculative execution restricted to protect them
from attacks taking advantage of CPU speculation side channels.

Add calls to arch_update_spec_restiction() to put speculative restriction
on a task when changing its dumpability.  Restrict speculative execution
on a non-dumpable task and relax the restrictions on a dumpable task.

A change to dumpability occurs via setgid, setuid, or
prctl(SUID_SET_DUMPABLE) syscalls.  The user should expect associated
change in speculative restriction occurs only on the task that issued
such syscall. Speculative restriction changes are not extended to other
threads in the same process.  This should not be a problem as such
changes should be made before spawning additional threads.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 fs/exec.c           | 3 +++
 include/linux/cpu.h | 3 +++
 kernel/cpu.c        | 4 ++++
 kernel/cred.c       | 5 ++++-
 kernel/sys.c        | 7 +++++++
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index fc281b7..d72e20d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -62,6 +62,7 @@
 #include <linux/oom.h>
 #include <linux/compat.h>
 #include <linux/vmalloc.h>
+#include <linux/cpu.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1366,6 +1367,8 @@ void setup_new_exec(struct linux_binprm * bprm)
 	else
 		set_dumpable(current->mm, SUID_DUMP_USER);
 
+	arch_update_spec_restriction(current);
+
 	arch_setup_new_exec();
 	perf_event_exec();
 	__set_task_comm(current, kbasename(bprm->filename), true);
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 00af2ae..3d90155 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -182,4 +182,7 @@ static inline void cpu_smt_check_topology(void) { }
 #endif
 DECLARE_STATIC_KEY_TRUE(cpu_smt_enabled);
 
+/* Update CPU's speculation restrictions on a task based on task's properties */
+extern int arch_update_spec_restriction(struct task_struct *task);
+
 #endif /* _LINUX_CPU_H_ */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 54cf3f6..d57ab2c 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2291,6 +2291,10 @@ void init_cpu_online(const struct cpumask *src)
 	cpumask_copy(&__cpu_online_mask, src);
 }
 
+int __weak arch_update_spec_ctrl_restriction(struct task_struct *task)
+{
+}
+
 /*
  * Activate the first processor.
  */
diff --git a/kernel/cred.c b/kernel/cred.c
index ecf0365..bc47653 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -19,6 +19,7 @@
 #include <linux/security.h>
 #include <linux/binfmts.h>
 #include <linux/cn_proc.h>
+#include <linux/cpu.h>
 
 #if 0
 #define kdebug(FMT, ...)						\
@@ -445,8 +446,10 @@ int commit_creds(struct cred *new)
 	    !uid_eq(old->fsuid, new->fsuid) ||
 	    !gid_eq(old->fsgid, new->fsgid) ||
 	    !cred_cap_issubset(old, new)) {
-		if (task->mm)
+		if (task->mm) {
 			set_dumpable(task->mm, suid_dumpable);
+			arch_update_spec_restriction(task);
+		}
 		task->pdeath_signal = 0;
 		smp_wmb();
 	}
diff --git a/kernel/sys.c b/kernel/sys.c
index 123bd73..621ea94 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2290,6 +2290,13 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			break;
 		}
 		set_dumpable(me->mm, arg2);
+		/*
+		 * Any speculative execution restriction updates
+		 * associated with change in dumpability
+		 * applies only to the current task that issues
+		 * the request.
+		 */
+		arch_update_spec_restriction(me);
 		break;
 
 	case PR_SET_UNALIGN:
-- 
2.9.4

