Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033642AbeCARqF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:46:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033530AbeCARoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:44:10 -0500
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH v3 5/6] ipc: Clamp msgmni and shmmni to the real IPCMNI limit
Date: Thu,  1 Mar 2018 12:43:39 -0500
Message-Id: <1519926220-7453-6-git-send-email-longman@redhat.com>
In-Reply-To: <1519926220-7453-1-git-send-email-longman@redhat.com>
References: <1519926220-7453-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A user can write arbitrary integer values to msgmni and shmmni sysctl
parameters without getting error, but the actual limit is really
IPCMNI (32k). This can mislead users as they think they can get a
value that is not real.

Enforcing the limit by failing the sysctl parameter write, however,
can break existing user applications. Instead, the range clamping flag
is set to enforce the limit without failing existing user code. Users
can easily figure out if the sysctl parameter value is out of range
by either reading back the parameter value or checking the kernel
ring buffer for warning.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 ipc/ipc_sysctl.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 8ad93c2..8eb7268 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -41,12 +41,21 @@ static int proc_ipc_dointvec(struct ctl_table *table, int write,
 static int proc_ipc_dointvec_minmax(struct ctl_table *table, int write,
 	void __user *buffer, size_t *lenp, loff_t *ppos)
 {
+	int ret;
 	struct ctl_table ipc_table;
 
 	memcpy(&ipc_table, table, sizeof(ipc_table));
 	ipc_table.data = get_ipc(table);
 
-	return proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
+	ret = proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
+
+	/*
+	 * Copy back the CTL_FLAGS_OOR_WARNED flag which may be set in
+	 * the temporary ctl_table entry.
+	 */
+	table->flags |= (ipc_table.flags & CTL_FLAGS_OOR_WARNED);
+
+	return ret;
 }
 
 static int proc_ipc_dointvec_minmax_orphans(struct ctl_table *table, int write,
@@ -99,6 +108,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 static int zero;
 static int one = 1;
 static int int_max = INT_MAX;
+static int ipc_mni = IPCMNI;
 
 static struct ctl_table ipc_kern_table[] = {
 	{
@@ -120,7 +130,10 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 		.data		= &init_ipc_ns.shm_ctlmni,
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlmni),
 		.mode		= 0644,
-		.proc_handler	= proc_ipc_dointvec,
+		.proc_handler	= proc_ipc_dointvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &ipc_mni,
+		.flags		= CTL_FLAGS_CLAMP_RANGE,
 	},
 	{
 		.procname	= "shm_rmid_forced",
@@ -147,7 +160,8 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
 		.extra1		= &zero,
-		.extra2		= &int_max,
+		.extra2		= &ipc_mni,
+		.flags		= CTL_FLAGS_CLAMP_RANGE,
 	},
 	{
 		.procname	= "auto_msgmni",
-- 
1.8.3.1
