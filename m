Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F85C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3590E20844
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3590E20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389289AbeKGLId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:08:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:51975 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389019AbeKGLId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 06:08:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 17:40:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,473,1534834800"; 
   d="scan'208";a="84529823"
Received: from aubrey-skl.sh.intel.com ([10.239.53.9])
  by fmsmga008.fm.intel.com with ESMTP; 06 Nov 2018 17:40:23 -0800
From:   Aubrey Li <aubrey.li@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        arjan@linux.intel.com, aubrey.li@intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: [RFC PATCH v1 2/2] proc: add /proc/<pid>/thread_state
Date:   Wed,  7 Nov 2018 02:23:10 +0800
Message-Id: <1541528590-30296-2-git-send-email-aubrey.li@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541528590-30296-1-git-send-email-aubrey.li@intel.com>
References: <1541528590-30296-1-git-send-email-aubrey.li@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the per-task cpu specific thread state value, it's helpful
for userland to classify and schedule the tasks by different policies

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 13 +++++++++++++
 fs/proc/base.c               | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 87a57b7..5a4a1d5 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -7,6 +7,7 @@
 #include <linux/cpu.h>
 #include <linux/mman.h>
 #include <linux/pkeys.h>
+#include <linux/seq_file.h>
 
 #include <asm/fpu/api.h>
 #include <asm/fpu/internal.h>
@@ -1245,3 +1246,15 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 
 	return 0;
 }
+
+/*
+ * report AVX state
+ */
+void arch_thread_state(struct seq_file *m, struct task_struct *task)
+{
+	if (task->thread.fpu.avx.state)
+		seq_putc(m, '1');
+	else
+		seq_putc(m, '0');
+	seq_putc(m, '\n');
+}
diff --git a/fs/proc/base.c b/fs/proc/base.c
index aaffc0c..be24327 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2893,6 +2893,17 @@ static int proc_pid_patch_state(struct seq_file *m, struct pid_namespace *ns,
 }
 #endif /* CONFIG_LIVEPATCH */
 
+void __weak arch_thread_state(struct seq_file *m, struct task_struct *task)
+{
+}
+
+static int proc_pid_thread_state(struct seq_file *m, struct pid_namespace *ns,
+				 struct pid *pid, struct task_struct *task)
+{
+	arch_thread_state(m, task);
+	return 0;
+}
+
 /*
  * Thread groups
  */
@@ -2994,6 +3005,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_LIVEPATCH
 	ONE("patch_state",  S_IRUSR, proc_pid_patch_state),
 #endif
+	ONE("thread_state",  S_IRUSR, proc_pid_thread_state),
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
@@ -3372,6 +3384,7 @@ static const struct pid_entry tid_base_stuff[] = {
 #ifdef CONFIG_LIVEPATCH
 	ONE("patch_state",  S_IRUSR, proc_pid_patch_state),
 #endif
+	ONE("thread_state",  S_IRUSR, proc_pid_thread_state),
 };
 
 static int proc_tid_base_readdir(struct file *file, struct dir_context *ctx)
-- 
2.7.4

