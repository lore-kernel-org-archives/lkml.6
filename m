Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753343AbeBSQzH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:55:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753202AbeBSQyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:54:23 -0500
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Waiman Long <longman@redhat.com>
Subject: [PATCH 3/3] ipc: Clamp msgmni and shmmni to the real IPC_MNI limit
Date: Mon, 19 Feb 2018 11:53:51 -0500
Message-Id: <1519059231-2456-4-git-send-email-longman@redhat.com>
In-Reply-To: <1519059231-2456-1-git-send-email-longman@redhat.com>
References: <1519059231-2456-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A user can write arbitrary integer values to msgmni and shmmni sysctl
parameters without getting error, but the actual limit is really
IPC_MNI (32k). This can mislead users as they think they can get a
value that is not real.

Enforcing the limit by failing the sysctl parameter write, however,
can break existing user applications. Instead, the clamping version
of the sysctl parameter range checking API is used to enforce the
limit without failing existing user code. Users can easily figure out
if the sysctl parameter value is out of range by either reading back
the parameter value or checking the kernel ring buffer for warning.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 ipc/ipc_sysctl.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 8ad93c2..03abcdd 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -46,7 +46,8 @@ static int proc_ipc_dointvec_minmax(struct ctl_table *table, int write,
 	memcpy(&ipc_table, table, sizeof(ipc_table));
 	ipc_table.data = get_ipc(table);
 
-	return proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
+	return proc_dointvec_clamp_minmax(&ipc_table, write, buffer, lenp,
+					  ppos);
 }
 
 static int proc_ipc_dointvec_minmax_orphans(struct ctl_table *table, int write,
@@ -99,6 +100,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 static int zero;
 static int one = 1;
 static int int_max = INT_MAX;
+static int ipc_mni = IPCMNI;
 
 static struct ctl_table ipc_kern_table[] = {
 	{
@@ -120,7 +122,9 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 		.data		= &init_ipc_ns.shm_ctlmni,
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlmni),
 		.mode		= 0644,
-		.proc_handler	= proc_ipc_dointvec,
+		.proc_handler	= proc_ipc_dointvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &ipc_mni,
 	},
 	{
 		.procname	= "shm_rmid_forced",
@@ -147,7 +151,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
 		.extra1		= &zero,
-		.extra2		= &int_max,
+		.extra2		= &ipc_mni,
 	},
 	{
 		.procname	= "auto_msgmni",
-- 
1.8.3.1
