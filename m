Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04278C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F1320850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F1320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934323AbeFRN0M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:26:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933524AbeFRN0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:26:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B959530C10EF;
        Mon, 18 Jun 2018 13:26:09 +0000 (UTC)
Received: from llong.com (ovpn-117-25.phx2.redhat.com [10.3.117.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAB25600C0;
        Mon, 18 Jun 2018 13:26:03 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v8 5/5 RESEND] ipc: Add a new ipcmni_compat sysctl to fall back to old behavior
Date:   Mon, 18 Jun 2018 21:25:38 +0800
Message-Id: <1529328338-18803-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 18 Jun 2018 13:26:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With strict range limit enforcement of msgmni, shmmni and sem, it is
possible that some existing applications that set those values to above
32k may fail. To help users to work around this potential problem, a new
boolean ipcmni_compat sysctl is added to provide the old beahavior for
compatibility when it is set to 1. In other word, the limit will then be
enforced internally but no error will be reported.

This compatibility mode can only be enabled if the ipcmni_extend kernel
boot parameter is not specified.

The sysctl documentation is also updated accordingly.

RESEND: Add missing ipcmni_max macro in util.h.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/sysctl/kernel.txt | 15 +++++++++++++++
 ipc/ipc_sysctl.c                | 42 ++++++++++++++++++++++++++++++++++++++---
 ipc/util.h                      |  6 ++++--
 3 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index eded671d..e98d967 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -39,6 +39,7 @@ show up in /proc/sys/kernel:
 - hung_task_check_count
 - hung_task_timeout_secs
 - hung_task_warnings
+- ipcmni_compat
 - kexec_load_disabled
 - kptr_restrict
 - l2cr                        [ PPC only ]
@@ -374,6 +375,20 @@ This file shows up if CONFIG_DETECT_HUNG_TASK is enabled.
 
 ==============================================================
 
+ipcmni_compat:
+
+A boolean flag to control range checking behavior of msgmni, shmmni
+and the mni portion of sem.
+
+0: Range limits will be strictly enforced and error will be returned
+   if limits are exceeded.
+1: Range limits will only be enforced internally and no error will be
+   returned if the upper limit is exceeded. This compatibility behavior
+   can only be selected if the ipcmni_extend kernel boot parameter is
+   not specified.
+
+==============================================================
+
 kexec_load_disabled:
 
 A toggle indicating if the kexec_load syscall has been disabled. This
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index d9ac6ca..5c0eac4 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -18,6 +18,8 @@
 #include <linux/msg.h>
 #include "util.h"
 
+static int ipcmni_compat;
+
 static void *get_ipc(struct ctl_table *table)
 {
 	char *which = table->data;
@@ -108,6 +110,25 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 	return ret;
 }
 
+static int proc_ipcmni_compat_minmax(struct ctl_table *table, int write,
+	void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	if (ret)
+		return ret;
+
+	/*
+	 * ipcmni_compat can only be set if !ipcmni_extend.
+	 */
+	if (ipcmni_compat && ipc_mni_extended) {
+		ipcmni_compat = 0;
+		return -EINVAL;
+	}
+	ipcmni_max = ipcmni_compat ? INT_MAX : ipc_mni;
+	return 0;
+}
+
 #else
 #define proc_ipc_doulongvec_minmax NULL
 #define proc_ipc_dointvec	   NULL
@@ -115,11 +136,13 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 #define proc_ipc_dointvec_minmax_orphans   NULL
 #define proc_ipc_auto_msgmni	   NULL
 #define proc_ipc_sem_dointvec	   NULL
+#define proc_ipcmni_compat_minmax  NULL
 #endif
 
 static int zero;
 static int one = 1;
 static int int_max = INT_MAX;
+int ipcmni_max = IPCMNI;
 int ipc_mni = IPCMNI;
 int ipc_mni_shift = IPCMNI_SHIFT;
 bool ipc_mni_extended;
@@ -146,7 +169,7 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
 		.extra1		= &zero,
-		.extra2		= &ipc_mni,
+		.extra2		= &ipcmni_max,
 	},
 	{
 		.procname	= "shm_rmid_forced",
@@ -173,7 +196,7 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
 		.extra1		= &zero,
-		.extra2		= &ipc_mni,
+		.extra2		= &ipcmni_max,
 	},
 	{
 		.procname	= "auto_msgmni",
@@ -229,6 +252,19 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 		.extra2		= &int_max,
 	},
 #endif
+	/*
+	 * Unlike other IPC sysctl parameters above, the following sysctl
+	 * parameter is global and affect behavior for all the namespaces.
+	 */
+	{
+		.procname	= "ipcmni_compat",
+		.data		= &ipcmni_compat,
+		.maxlen		= sizeof(ipcmni_compat),
+		.mode		= 0644,
+		.proc_handler	= proc_ipcmni_compat_minmax,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
 	{}
 };
 
@@ -251,7 +287,7 @@ static int __init ipc_sysctl_init(void)
 
 static int __init ipc_mni_extend(char *str)
 {
-	ipc_mni = IPCMNI_EXTEND;
+	ipc_mni = ipcmni_max = IPCMNI_EXTEND;
 	ipc_mni_shift = IPCMNI_EXTEND_SHIFT;
 	ipc_mni_extended = true;
 	pr_info("IPCMNI extended to %d.\n", ipc_mni);
diff --git a/ipc/util.h b/ipc/util.h
index 62b6247..ce2db71 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -29,6 +29,7 @@
 #ifdef CONFIG_SYSVIPC_SYSCTL
 extern int ipc_mni;
 extern int ipc_mni_shift;
+extern int ipcmni_max;
 extern bool ipc_mni_extended;
 
 #define SEQ_SHIFT		ipc_mni_shift
@@ -38,6 +39,7 @@
 
 #define ipc_mni 		IPCMNI
 #define ipc_mni_extended	false
+#define ipcmni_max		IPCMNI
 #define SEQ_SHIFT		IPCMNI_SHIFT
 #define SEQ_MASK		((1 << IPCMNI_SHIFT) - 1)
 #endif /* CONFIG_SYSVIPC_SYSCTL */
@@ -244,10 +246,10 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
 
 static inline int sem_check_semmni(struct ipc_namespace *ns) {
 	/*
-	 * Check semmni range [0, ipc_mni]
+	 * Check semmni range [0, ipcmni_max]
 	 * semmni is the last element of sem_ctls[4] array
 	 */
-	return ((ns->sem_ctls[3] < 0) || (ns->sem_ctls[3] > ipc_mni))
+	return ((ns->sem_ctls[3] < 0) || (ns->sem_ctls[3] > ipcmni_max))
 		? -ERANGE : 0;
 }
 
-- 
1.8.3.1

