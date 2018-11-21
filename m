Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE1EC04EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012A221479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012A221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeKULFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:05:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:30250 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbeKULF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 06:05:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 16:33:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,259,1539673200"; 
   d="scan'208";a="93650243"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by orsmga008.jf.intel.com with ESMTP; 20 Nov 2018 16:33:30 -0800
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
Subject: [Patch v6 14/16] x86/speculation: Use STIBP to restrict speculation on non-dumpable task
Date:   Tue, 20 Nov 2018 16:00:06 -0800
Message-Id: <6652faa67f8c4e90c737f9fd9c7e0e2d3cd51cca.1542757030.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1542757030.git.tim.c.chen@linux.intel.com>
References: <cover.1542757030.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1542757030.git.tim.c.chen@linux.intel.com>
References: <cover.1542757030.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a task changes its dumpability, arch_update_spec_ctrl_restriction()
is called to place restriction on the task's speculative execution
according to dumpability changes.

Implements arch_update_spec_restriction() for x86.  Use STIBP to
restrict speculative execution when running a task set to non-dumpable,
or clear the restriction if the task is set to dumpable.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 ++-
 arch/x86/kernel/cpu/bugs.c                      | 23 ++++++++++++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 89b193c..3979b12 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4229,7 +4229,8 @@
 				  If the CPU is vulnerable, the default mitigation
 				  is architecture and Kconfig dependent. See below.
 			prctl   - Enable mitigations per thread by restricting
-				  indirect branch speculation via prctl.
+				  indirect branch speculation via prctl or setting
+				  the thread as non-dumpable.
 				  Mitigation for a thread is not enabled by default to
 				  avoid mitigation overhead. The state of
 				  of the control is inherited on fork.
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f349b3f..6cd64445 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/nospec.h>
 #include <linux/prctl.h>
+#include <linux/coredump.h>
 
 #include <asm/spec-ctrl.h>
 #include <asm/cmdline.h>
@@ -153,8 +154,8 @@ static const char *spectre_v2_strings[] = {
 static const char *spectre_v2_app2app_strings[] = {
 	[SPECTRE_V2_APP2APP_NONE]    = "App-App Vulnerable",
 	[SPECTRE_V2_APP2APP_STRICT]  = "App-App Mitigation: Full app to app attack protection",
-	[SPECTRE_V2_APP2APP_PRCTL]   = "App-App Mitigation: Protect branch speculation restricted tasks",
-	[SPECTRE_V2_APP2APP_SECCOMP] = "App-App Mitigation: Protect branch speculation restricted and seccomp tasks",
+	[SPECTRE_V2_APP2APP_PRCTL]   = "App-App Mitigation: Protect non-dumpable and branch speculation restricted tasks",
+	[SPECTRE_V2_APP2APP_SECCOMP] = "App-App Mitigation: Protect non-dumpable, branch speculation restricted and seccomp tasks",
 };
 
 /* Lightweight mitigation: mitigate only tasks with TIF_SPEC_INDIR_BRANCH */
@@ -792,13 +793,29 @@ static void set_task_restrict_indir_branch(struct task_struct *tsk, bool restric
 
 	if (restrict_on)
 		update = !test_and_set_tsk_thread_flag(tsk, TIF_SPEC_INDIR_BRANCH);
-	else
+	else if (!task_spec_indir_branch_disable(tsk))
 		update = test_and_clear_tsk_thread_flag(tsk, TIF_SPEC_INDIR_BRANCH);
 
 	if (tsk == current && update)
 		speculation_ctrl_update_current();
 }
 
+int arch_update_spec_restriction(struct task_struct *task)
+{
+	if (!static_branch_unlikely(&spectre_v2_app_lite))
+		return 0;
+
+	if (!task->mm)
+		return -EINVAL;
+
+	if (get_dumpable(task->mm) != SUID_DUMP_USER)
+		set_task_restrict_indir_branch(task, true);
+	else
+		set_task_restrict_indir_branch(task, false);
+
+	return 0;
+}
+
 static int indir_branch_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
 	switch (ctrl) {
-- 
2.9.4

