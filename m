Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753412AbeEGVCK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 17:02:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753300AbeEGU7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:59:22 -0400
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
Subject: [PATCH v7 2/4] ipc: IPCMNI limit check for semmni
Date: Mon,  7 May 2018 16:59:10 -0400
Message-Id: <1525726752-29281-3-git-send-email-longman@redhat.com>
In-Reply-To: <1525726752-29281-1-git-send-email-longman@redhat.com>
References: <1525726752-29281-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SysV semaphores, the semmni value is the last part of the 4-element
sem number array. To make semmni behave in a similar way to msgmni and
shmmni, we can't directly use the _minmax handler. Instead, a special
sem specific handler is added to check the last argument to make sure
that it is limited to the [0, IPCMNI] range. An error will be returned
if this is not the case.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 ipc/ipc_sysctl.c | 23 ++++++++++++++++++++++-
 ipc/util.h       |  9 +++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index f87cb29..49f9bf4 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -88,12 +88,33 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 	return proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
 }
 
+static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
+	void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret, semmni;
+	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
+
+	semmni = ns->sem_ctls[3];
+	ret = proc_ipc_dointvec(table, write, buffer, lenp, ppos);
+
+	if (!ret)
+		ret = sem_check_semmni(current->nsproxy->ipc_ns);
+
+	/*
+	 * Reset the semmni value if an error happens.
+	 */
+	if (ret)
+		ns->sem_ctls[3] = semmni;
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
@@ -175,7 +196,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 		.data		= &init_ipc_ns.sem_ctls,
 		.maxlen		= 4*sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_ipc_dointvec,
+		.proc_handler	= proc_ipc_sem_dointvec,
 	},
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	{
diff --git a/ipc/util.h b/ipc/util.h
index acc5159..8b413f1 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -218,6 +218,15 @@ int ipcget(struct ipc_namespace *ns, struct ipc_ids *ids,
 void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
 		void (*free)(struct ipc_namespace *, struct kern_ipc_perm *));
 
+static inline int sem_check_semmni(struct ipc_namespace *ns) {
+	/*
+	 * Check semmni range [0, IPCMNI]
+	 * semmni is the last element of sem_ctls[4] array
+	 */
+	return ((ns->sem_ctls[3] < 0) || (ns->sem_ctls[3] > IPCMNI))
+		? -ERANGE : 0;
+}
+
 #ifdef CONFIG_COMPAT
 #include <linux/compat.h>
 struct compat_ipc_perm {
-- 
1.8.3.1
