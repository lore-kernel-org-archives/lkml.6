Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6374AC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379F5213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379F5213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeKULOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:14:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:16662 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbeKULOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 06:14:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 16:42:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,259,1539673200"; 
   d="scan'208";a="251346850"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by orsmga004.jf.intel.com with ESMTP; 20 Nov 2018 16:42:04 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        stable@vger.kernel.org
Subject: [Patch v7 15/18] security: Update speculation restriction of a process when modifying its dumpability
Date:   Tue, 20 Nov 2018 16:08:54 -0800
Message-Id: <f0b753f3699babfda4ecb93c0ccb6a135147ae36.1542758656.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1542758656.git.tim.c.chen@linux.intel.com>
References: <cover.1542758656.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1542758656.git.tim.c.chen@linux.intel.com>
References: <cover.1542758656.git.tim.c.chen@linux.intel.com>
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
 kernel/cpu.c        | 5 +++++
 kernel/cred.c       | 5 ++++-
 kernel/sys.c        | 7 +++++++
 5 files changed, 22 insertions(+), 1 deletion(-)

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
index 6f43024..4fef90a 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -187,4 +187,7 @@ static inline void cpu_smt_check_topology(void) { }
 DECLARE_STATIC_KEY_TRUE(cpu_smt_enabled);
 #endif
 
+/* Update CPU's speculation restrictions on a task based on task's properties */
+extern int arch_update_spec_restriction(struct task_struct *task);
+
 #endif /* _LINUX_CPU_H_ */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index f846416..fe93a8a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2291,6 +2291,11 @@ void init_cpu_online(const struct cpumask *src)
 	cpumask_copy(&__cpu_online_mask, src);
 }
 
+int __weak arch_update_spec_restriction(struct task_struct *task)
+{
+	return 0;
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

