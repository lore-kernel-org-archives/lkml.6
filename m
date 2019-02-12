Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A609CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6E820821
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfBLMJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:09:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:39053 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfBLMJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:09:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 04:09:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,361,1544515200"; 
   d="scan'208";a="299112679"
Received: from aubrey-skl.sh.intel.com ([10.239.53.19])
  by orsmga005.jf.intel.com with ESMTP; 12 Feb 2019 04:09:06 -0800
From:   Aubrey Li <aubrey.li@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, aubrey.li@intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH v10 1/3] /proc/pid/status: Add support for architecture specific output
Date:   Tue, 12 Feb 2019 12:49:12 +0800
Message-Id: <20190212044914.15490-1-aubrey.li@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The architecture specific information of the running processes could
be useful to the userland. Add support to examine process architecture
specific information externally.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
---
 fs/proc/array.c         | 5 +++++
 include/linux/proc_fs.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 9d428d5a0ac8..ea7a981f289c 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -401,6 +401,10 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
 	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
 }
 
+void __weak arch_proc_pid_status(struct seq_file *m, struct task_struct *task)
+{
+}
+
 int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 			struct pid *pid, struct task_struct *task)
 {
@@ -424,6 +428,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 	task_cpus_allowed(m, task);
 	cpuset_task_status_allowed(m, task);
 	task_context_switch_counts(m, task);
+	arch_proc_pid_status(m, task);
 	return 0;
 }
 
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index d0e1f1522a78..1de9ba1b064f 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -73,6 +73,8 @@ struct proc_dir_entry *proc_create_net_single_write(const char *name, umode_t mo
 						    int (*show)(struct seq_file *, void *),
 						    proc_write_t write,
 						    void *data);
+/* Add support for architecture specific output in /proc/pid/status */
+extern void arch_proc_pid_status(struct seq_file *m, struct task_struct *task);
 
 #else /* CONFIG_PROC_FS */
 
-- 
2.17.1

