Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeB0Uul (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 15:50:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751898AbeB0UuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 15:50:02 -0500
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 5/5] ipc: Clamp semmni to the real IPCMNI limit
Date: Tue, 27 Feb 2018 15:49:51 -0500
Message-Id: <1519764591-27456-6-git-send-email-longman@redhat.com>
In-Reply-To: <1519764591-27456-1-git-send-email-longman@redhat.com>
References: <1519764591-27456-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch clamps the semmni value (fourth element of sem_ctls[]
array) to within the [0, IPCMNI] range and prints a warning message
once when an out-of-range value is being written.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 ipc/ipc_sysctl.c | 13 ++++++++++++-
 ipc/sem.c        | 33 +++++++++++++++++++++++++++++++++
 ipc/util.h       |  4 ++++
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index e4ab272..5a5b50b 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -93,12 +93,22 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 	return proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
 }
 
+static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
+	void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret = proc_ipc_dointvec(table, write, buffer, lenp, ppos);
+
+	sem_check_semmni(table, current->nsproxy->ipc_ns);
+	return ret;
+}
+
 #else
 #define proc_ipc_doulongvec_minmax NULL
 #define proc_ipc_dointvec	   NULL
 #define proc_ipc_dointvec_minmax   NULL
 #define proc_ipc_dointvec_minmax_orphans   NULL
 #define proc_ipc_auto_msgmni	   NULL
+#define proc_ipc_sem_dointvec	   NULL
 #endif
 
 static int zero;
@@ -182,7 +192,8 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 		.data		= &init_ipc_ns.sem_ctls,
 		.maxlen		= 4*sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_ipc_dointvec,
+		.proc_handler	= proc_ipc_sem_dointvec,
+		.flags		= CTL_FLAGS_CLAMP_RANGE,
 	},
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	{
diff --git a/ipc/sem.c b/ipc/sem.c
index a4af049..0af13e8 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -2337,3 +2337,36 @@ static int sysvipc_sem_proc_show(struct seq_file *s, void *it)
 	return 0;
 }
 #endif
+
+#ifdef CONFIG_PROC_SYSCTL
+/*
+ * Check to see if semmni is out of range and clamp it if necessary.
+ */
+void sem_check_semmni(struct ctl_table *table, struct ipc_namespace *ns)
+{
+#define SYSCTL_WARN_MSG	\
+"Kernel parameter \"sem[3]\" was set out of range [%d, %d], clamped to %d.\n"
+
+	bool clamped = false;
+
+	if (!(table->flags & CTL_FLAGS_CLAMP_RANGE))
+		return;
+
+	/*
+	 * Clamp semmni to the range [0, IPCMNI].
+	 */
+	if (ns->sc_semmni < 0) {
+		ns->sc_semmni = 0;
+		clamped = true;
+	}
+	if (ns->sc_semmni > IPCMNI) {
+		ns->sc_semmni = IPCMNI;
+		clamped = true;
+	}
+	if (clamped && !(table->flags & CTL_FLAGS_OOR_WARNED)) {
+		pr_warn(SYSCTL_WARN_MSG, 0, IPCMNI, ns->sc_semmni);
+		table->flags |= CTL_FLAGS_OOR_WARNED;
+	}
+#undef SYSCTL_WARN_MSG
+}
+#endif
diff --git a/ipc/util.h b/ipc/util.h
index 89b8ec1..af57394 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -206,6 +206,10 @@ int ipcget(struct ipc_namespace *ns, struct ipc_ids *ids,
 void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
 		void (*free)(struct ipc_namespace *, struct kern_ipc_perm *));
 
+#ifdef CONFIG_PROC_SYSCTL
+extern void sem_check_semmni(struct ctl_table *table, struct ipc_namespace *ns);
+#endif
+
 #ifdef CONFIG_COMPAT
 #include <linux/compat.h>
 struct compat_ipc_perm {
-- 
1.8.3.1
