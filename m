Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753055AbeCPSRw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 14:17:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752885AbeCPSOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 14:14:34 -0400
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 4/9] ipc: Clamp msgmni and shmmni to the real IPCMNI limit
Date: Fri, 16 Mar 2018 14:13:45 -0400
Message-Id: <1521224030-2185-5-git-send-email-longman@redhat.com>
In-Reply-To: <1521224030-2185-1-git-send-email-longman@redhat.com>
References: <1521224030-2185-1-git-send-email-longman@redhat.com>
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
 ipc/ipc_sysctl.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 8ad93c2..088721e 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -99,6 +99,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 static int zero;
 static int one = 1;
 static int int_max = INT_MAX;
+static int ipc_mni = IPCMNI;
 
 static struct ctl_table ipc_kern_table[] = {
 	{
@@ -120,7 +121,10 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 		.data		= &init_ipc_ns.shm_ctlmni,
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlmni),
 		.mode		= 0644,
-		.proc_handler	= proc_ipc_dointvec,
+		.proc_handler	= proc_ipc_dointvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &ipc_mni,
+		.flags		= CTL_FLAGS_CLAMP_RANGE_SIGNED,
 	},
 	{
 		.procname	= "shm_rmid_forced",
@@ -147,7 +151,8 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
 		.extra1		= &zero,
-		.extra2		= &int_max,
+		.extra2		= &ipc_mni,
+		.flags		= CTL_FLAGS_CLAMP_RANGE_SIGNED,
 	},
 	{
 		.procname	= "auto_msgmni",
-- 
1.8.3.1
