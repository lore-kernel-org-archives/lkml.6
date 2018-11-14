Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B282C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42292086B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42292086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbeKOQXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 11:23:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:13841 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbeKOQXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 11:23:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 22:17:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,235,1539673200"; 
   d="scan'208";a="281236377"
Received: from aubrey-skl.sh.intel.com ([10.239.53.9])
  by fmsmga006.fm.intel.com with ESMTP; 14 Nov 2018 22:17:18 -0800
From:   Aubrey Li <aubrey.li@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, aubrey.li@intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH v3 2/2] proc: add /proc/<pid>/arch_state
Date:   Thu, 15 Nov 2018 07:00:07 +0800
Message-Id: <1542236407-4323-2-git-send-email-aubrey.li@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542236407-4323-1-git-send-email-aubrey.li@intel.com>
References: <1542236407-4323-1-git-send-email-aubrey.li@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a /proc/<pid>/arch_state interface to expose per-task cpu specific
state values.

Exposing AVX-512 Hi16_ZMM registers usage is for the user space job
scheduler to cluster AVX-512 using tasks together, because these tasks
could cause core turbo frequency drop.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 16 ++++++++++++++++
 fs/proc/base.c               | 13 +++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 87a57b7..10224ee 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -7,6 +7,7 @@
 #include <linux/cpu.h>
 #include <linux/mman.h>
 #include <linux/pkeys.h>
+#include <linux/seq_file.h>
 
 #include <asm/fpu/api.h>
 #include <asm/fpu/internal.h>
@@ -1245,3 +1246,18 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 
 	return 0;
 }
+
+/*
+ * report CPU specific thread state
+ */
+void arch_thread_state(struct seq_file *m, struct task_struct *task)
+{
+	/*
+	 * Report AVX-512 Hi16_ZMM registers usage
+	 */
+	if (task->thread.fpu.hi16zmm_usage)
+		seq_putc(m, '1');
+	else
+		seq_putc(m, '0');
+	seq_putc(m, '\n');
+}
diff --git a/fs/proc/base.c b/fs/proc/base.c
index aaffc0c..efd51ec 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2893,6 +2893,17 @@ static int proc_pid_patch_state(struct seq_file *m, struct pid_namespace *ns,
 }
 #endif /* CONFIG_LIVEPATCH */
 
+void __weak arch_thread_state(struct seq_file *m, struct task_struct *task)
+{
+}
+
+static int proc_pid_arch_state(struct seq_file *m, struct pid_namespace *ns,
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
+	ONE("arch_state",  S_IRUSR, proc_pid_arch_state),
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
@@ -3372,6 +3384,7 @@ static const struct pid_entry tid_base_stuff[] = {
 #ifdef CONFIG_LIVEPATCH
 	ONE("patch_state",  S_IRUSR, proc_pid_patch_state),
 #endif
+	ONE("arch_state",  S_IRUSR, proc_pid_arch_state),
 };
 
 static int proc_tid_base_readdir(struct file *file, struct dir_context *ctx)
-- 
2.7.4

