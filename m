Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E705ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495EE214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495EE214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbeJRC3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:29:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:29659 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbeJRC3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:29:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 11:32:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,393,1534834800"; 
   d="scan'208";a="82003896"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by orsmga007.jf.intel.com with ESMTP; 17 Oct 2018 11:32:57 -0700
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
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [Patch v3 06/13] mm: Pass task instead of task->mm as argument to set_dumpable
Date:   Wed, 17 Oct 2018 10:59:34 -0700
Message-Id: <c793fcd092063a68f1de7ce982df2ebb347a3542.1539798901.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1539798901.git.tim.c.chen@linux.intel.com>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1539798901.git.tim.c.chen@linux.intel.com>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the argument to set_dumpable from task->mm to task.  This allows us
to later add hooks to modify a task's property according to whether it is
a non-dumpable task. Non dumpable tasks demand a higher level of security.
Changes the dumpable value from in to unsigned int as negative number is
not allowed.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 fs/exec.c                      | 14 ++++++++------
 include/linux/sched/coredump.h |  2 +-
 kernel/cred.c                  |  2 +-
 kernel/sys.c                   |  2 +-
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 1ebf6e5..e204830 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1362,9 +1362,9 @@ void setup_new_exec(struct linux_binprm * bprm)
 	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
 	    !(uid_eq(current_euid(), current_uid()) &&
 	      gid_eq(current_egid(), current_gid())))
-		set_dumpable(current->mm, suid_dumpable);
+		set_dumpable(current, (unsigned int) suid_dumpable);
 	else
-		set_dumpable(current->mm, SUID_DUMP_USER);
+		set_dumpable(current, SUID_DUMP_USER);
 
 	arch_setup_new_exec();
 	perf_event_exec();
@@ -1943,17 +1943,19 @@ EXPORT_SYMBOL(set_binfmt);
 /*
  * set_dumpable stores three-value SUID_DUMP_* into mm->flags.
  */
-void set_dumpable(struct mm_struct *mm, int value)
+void set_dumpable(struct task_struct *tsk, unsigned int value)
 {
 	unsigned long old, new;
 
-	if (WARN_ON((unsigned)value > SUID_DUMP_ROOT))
+	if (WARN_ON(value > SUID_DUMP_ROOT))
+		return;
+	if (WARN_ON(!tsk->mm))
 		return;
 
 	do {
-		old = READ_ONCE(mm->flags);
+		old = READ_ONCE(tsk->mm->flags);
 		new = (old & ~MMF_DUMPABLE_MASK) | value;
-	} while (cmpxchg(&mm->flags, old, new) != old);
+	} while (cmpxchg(&tsk->mm->flags, old, new) != old);
 }
 
 SYSCALL_DEFINE3(execve,
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index ec912d0..c02b1ab 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -14,7 +14,7 @@
 #define MMF_DUMPABLE_BITS 2
 #define MMF_DUMPABLE_MASK ((1 << MMF_DUMPABLE_BITS) - 1)
 
-extern void set_dumpable(struct mm_struct *mm, int value);
+extern void set_dumpable(struct task_struct *tsk, unsigned int value);
 /*
  * This returns the actual value of the suid_dumpable flag. For things
  * that are using this for checking for privilege transitions, it must
diff --git a/kernel/cred.c b/kernel/cred.c
index ecf0365..18ef774 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -446,7 +446,7 @@ int commit_creds(struct cred *new)
 	    !gid_eq(old->fsgid, new->fsgid) ||
 	    !cred_cap_issubset(old, new)) {
 		if (task->mm)
-			set_dumpable(task->mm, suid_dumpable);
+			set_dumpable(task, (unsigned int) suid_dumpable);
 		task->pdeath_signal = 0;
 		smp_wmb();
 	}
diff --git a/kernel/sys.c b/kernel/sys.c
index cf5c675..d0892cd 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2292,7 +2292,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			error = -EINVAL;
 			break;
 		}
-		set_dumpable(me->mm, arg2);
+		set_dumpable(me, (unsigned int) arg2);
 		break;
 
 	case PR_SET_UNALIGN:
-- 
2.9.4

