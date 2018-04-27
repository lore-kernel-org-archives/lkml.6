Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759396AbeD0VB5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:01:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759291AbeD0VAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:00:54 -0400
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v6 5/8] ipc: Clamp semmni to the real IPCMNI limit
Date: Fri, 27 Apr 2018 17:00:35 -0400
Message-Id: <1524862838-8247-6-git-send-email-longman@redhat.com>
In-Reply-To: <1524862838-8247-1-git-send-email-longman@redhat.com>
References: <1524862838-8247-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SysV semaphores, the semmni value is the last part of the 4-element
sem number array. To make semmni behave in a similar way to msgmni
and shmmni, we can't directly use the _minmax handler. Instead,
a special sem specific handler is added to check the last argument
to make sure that it is clamped to the [0, IPCMNI] range and prints
a warning message once when an out-of-range value is being written.
This does require duplicating some of the code in the _minmax handlers.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 ipc/ipc_sysctl.c | 12 +++++++++++-
 ipc/sem.c        | 25 +++++++++++++++++++++++++
 ipc/util.h       |  4 ++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index d71f949..478e634 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -88,12 +88,22 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
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
@@ -177,7 +187,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 		.data		= &init_ipc_ns.sem_ctls,
 		.maxlen		= 4*sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_ipc_dointvec,
+		.proc_handler	= proc_ipc_sem_dointvec,
 	},
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	{
diff --git a/ipc/sem.c b/ipc/sem.c
index 06be75d..96bdec6 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -2397,3 +2397,28 @@ static int sysvipc_sem_proc_show(struct seq_file *s, void *it)
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
+	bool clamped = false;
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
+	if (clamped)
+		pr_warn_ratelimited("sysctl: \"sem[3]\" was set out of range [%d, %d], clamped to %d.\n",
+				     0, IPCMNI, ns->sc_semmni);
+}
+#endif
diff --git a/ipc/util.h b/ipc/util.h
index acc5159..7c20871 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -218,6 +218,10 @@ int ipcget(struct ipc_namespace *ns, struct ipc_ids *ids,
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
