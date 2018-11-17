Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5E0C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39782075B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39782075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbeKQMms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:42:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:45905 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731204AbeKQMmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:42:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 18:27:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,242,1539673200"; 
   d="scan'208";a="281852635"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2018 18:27:50 -0800
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
Subject: [Patch v5 14/16] x86/speculation: Use STIBP to restrict speculation on non-dumpable task
Date:   Fri, 16 Nov 2018 17:53:57 -0800
Message-Id: <b90027df45623dea4b3461853332eb7758b5b065.1542418937.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1542418936.git.tim.c.chen@linux.intel.com>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1542418936.git.tim.c.chen@linux.intel.com>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com>
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
 arch/x86/kernel/cpu/bugs.c                      | 21 +++++++++++++++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9c306e3..102f9a1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4221,7 +4221,8 @@
 			vulnerability.
 
 			off    - Unconditionally disable mitigations
-			lite   - Protect tasks which have requested restricted
+			lite   - Protect tasks which are marked non-dumpable
+				 and tasks which have requested restricted
 				 indirect branch speculation via the
 				 PR_SET_SPECULATION_CTRL prctl(). 
 			strict - Protect all processes
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 8f5187e..e7f9334 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/nospec.h>
 #include <linux/prctl.h>
+#include <linux/coredump.h>
 
 #include <asm/spec-ctrl.h>
 #include <asm/cmdline.h>
@@ -152,7 +153,7 @@ static const char *spectre_v2_strings[] = {
 
 static const char *spectre_v2_app2app_strings[] = {
 	[SPECTRE_V2_APP2APP_NONE]   = "App-App Vulnerable",
-	[SPECTRE_V2_APP2APP_LITE]   = "App-App Mitigation: Protect branch speculation restricted tasks",
+	[SPECTRE_V2_APP2APP_LITE]   = "App-App Mitigation: Protect non-dumpable and branch speculation restricted tasks",
 	[SPECTRE_V2_APP2APP_STRICT] = "App-App Mitigation: Full app to app attack protection",
 };
 
@@ -779,13 +780,29 @@ static void set_task_stibp(struct task_struct *tsk, bool stibp_on)
 
 	if (stibp_on)
 		update = !test_and_set_tsk_thread_flag(tsk, TIF_STIBP);
-	else
+	else if (!task_spec_indir_branch_disable(tsk))
 		update = test_and_clear_tsk_thread_flag(tsk, TIF_STIBP);
 
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
+		set_task_stibp(task, true);
+	else
+		set_task_stibp(task, false);
+
+	return 0;
+}
+
 static int indir_branch_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
 	switch (ctrl) {
-- 
2.9.4

