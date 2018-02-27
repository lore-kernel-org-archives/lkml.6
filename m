Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeB0UvA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 15:51:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751889AbeB0UuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 15:50:01 -0500
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 4/5] ipc: Clamp msgmni and shmmni to the real IPCMNI limit
Date: Tue, 27 Feb 2018 15:49:50 -0500
Message-Id: <1519764591-27456-5-git-send-email-longman@redhat.com>
In-Reply-To: <1519764591-27456-1-git-send-email-longman@redhat.com>
References: <1519764591-27456-1-git-send-email-longman@redhat.com>
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
 ipc/ipc_sysctl.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 8ad93c2..e4ab272 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -41,12 +41,17 @@ static int proc_ipc_dointvec(struct ctl_table *table, int write,
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
+	table->flags |= ipc_table.flags; /* Copy back any change in flags */
+
+	return ret;
 }
 
 static int proc_ipc_dointvec_minmax_orphans(struct ctl_table *table, int write,
@@ -99,6 +104,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 static int zero;
 static int one = 1;
 static int int_max = INT_MAX;
+static int ipc_mni = IPCMNI;
 
 static struct ctl_table ipc_kern_table[] = {
 	{
@@ -120,7 +126,10 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
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
@@ -147,7 +156,8 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
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
