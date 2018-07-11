Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABA0C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BB7208EB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52BB7208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbeGKCsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:48:17 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:40143 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732292AbeGKCsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:48:16 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fd58w-00012n-S2; Tue, 10 Jul 2018 20:46:14 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fd58u-00063R-C8; Tue, 10 Jul 2018 20:46:14 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 10 Jul 2018 21:44:51 -0500
Message-Id: <20180711024459.10654-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <877em2jxyr.fsf_-_@xmission.com>
References: <877em2jxyr.fsf_-_@xmission.com>
X-XM-SPF: eid=1fd58u-00063R-C8;;;mid=<20180711024459.10654-3-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18xj147MAApgUOZorZ8UDBzmMGhEuNS+SE=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [RFC][PATCH 03/11] pids: Compute task_tgid using signal->leader_pid
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cost is the the same and this removes the need
to worry about complications that come from de_thread
and group_leader changing.

__task_pid_nr_ns has been updated to take advantage of this change.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/ia64/kernel/asm-offsets.c       |  2 +-
 arch/ia64/kernel/fsys.S              |  8 ++++----
 drivers/platform/x86/thinkpad_acpi.c |  1 +
 fs/fuse/file.c                       |  1 +
 fs/notify/fanotify/fanotify.c        |  1 +
 include/linux/sched.h                |  5 -----
 include/linux/sched/signal.h         |  5 +++++
 include/net/scm.h                    |  1 +
 kernel/pid.c                         | 15 ++++++++-------
 9 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/arch/ia64/kernel/asm-offsets.c b/arch/ia64/kernel/asm-offsets.c
index f4db2168d1b8..f5433bb7f04a 100644
--- a/arch/ia64/kernel/asm-offsets.c
+++ b/arch/ia64/kernel/asm-offsets.c
@@ -50,7 +50,6 @@ void foo(void)
 
 	DEFINE(IA64_TASK_BLOCKED_OFFSET,offsetof (struct task_struct, blocked));
 	DEFINE(IA64_TASK_CLEAR_CHILD_TID_OFFSET,offsetof (struct task_struct, clear_child_tid));
-	DEFINE(IA64_TASK_GROUP_LEADER_OFFSET, offsetof (struct task_struct, group_leader));
 	DEFINE(IA64_TASK_TGIDLINK_OFFSET, offsetof (struct task_struct, pids[PIDTYPE_PID].pid));
 	DEFINE(IA64_PID_LEVEL_OFFSET, offsetof (struct pid, level));
 	DEFINE(IA64_PID_UPID_OFFSET, offsetof (struct pid, numbers[0]));
@@ -68,6 +67,7 @@ void foo(void)
 	DEFINE(IA64_SIGNAL_GROUP_STOP_COUNT_OFFSET,offsetof (struct signal_struct,
 							     group_stop_count));
 	DEFINE(IA64_SIGNAL_SHARED_PENDING_OFFSET,offsetof (struct signal_struct, shared_pending));
+	DEFINE(IA64_SIGNAL_LEADER_PID_OFFSET, offsetof (struct signal_struct, leader_pid));
 
 	BLANK();
 
diff --git a/arch/ia64/kernel/fsys.S b/arch/ia64/kernel/fsys.S
index fe742ffafc7a..eaf5a0d6f3e0 100644
--- a/arch/ia64/kernel/fsys.S
+++ b/arch/ia64/kernel/fsys.S
@@ -62,16 +62,16 @@ ENTRY(fsys_getpid)
 	.prologue
 	.altrp b6
 	.body
-	add r17=IA64_TASK_GROUP_LEADER_OFFSET,r16
+	add r17=IA64_TASK_SIGNAL_OFFSET,r16
 	;;
-	ld8 r17=[r17]				// r17 = current->group_leader
+	ld8 r17=[r17]				// r17 = current->signal
 	add r9=TI_FLAGS+IA64_TASK_SIZE,r16
 	;;
 	ld4 r9=[r9]
-	add r17=IA64_TASK_TGIDLINK_OFFSET,r17
+	add r17=IA64_SIGNAL_LEADER_PID_OFFSET,r17
 	;;
 	and r9=TIF_ALLWORK_MASK,r9
-	ld8 r17=[r17]				// r17 = current->group_leader->pids[PIDTYPE_PID].pid
+	ld8 r17=[r17]				// r17 = current->signal->leader_pid
 	;;
 	add r8=IA64_PID_LEVEL_OFFSET,r17
 	;;
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index cae9b0595692..d556e95c532c 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -57,6 +57,7 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/sched.h>
+#include <linux/sched/signal.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
 #include <linux/delay.h>
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a201fb0ac64f..b00a3f126a89 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/sched/signal.h>
 #include <linux/module.h>
 #include <linux/compat.h>
 #include <linux/swap.h>
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index f90842efea13..6e828cb82e5e 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -8,6 +8,7 @@
 #include <linux/mount.h>
 #include <linux/sched.h>
 #include <linux/sched/user.h>
+#include <linux/sched/signal.h>
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <linux/audit.h>
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 87bf02d93a27..a461ff89a3af 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1202,11 +1202,6 @@ static inline struct pid *task_pid(struct task_struct *task)
 	return task->pids[PIDTYPE_PID].pid;
 }
 
-static inline struct pid *task_tgid(struct task_struct *task)
-{
-	return task->group_leader->pids[PIDTYPE_PID].pid;
-}
-
 /*
  * Without tasklist or RCU lock it is not safe to dereference
  * the result of task_pgrp/task_session even if task == current,
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index d8ef0a3d2e7e..b95a272c1ab5 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -564,6 +564,11 @@ struct pid *task_pid_type(struct task_struct *task, enum pid_type type)
 	return task->pids[type].pid;
 }
 
+static inline struct pid *task_tgid(struct task_struct *task)
+{
+	return task->signal->leader_pid;
+}
+
 static inline int get_nr_threads(struct task_struct *tsk)
 {
 	return tsk->signal->nr_threads;
diff --git a/include/net/scm.h b/include/net/scm.h
index 903771c8d4e3..1ce365f4c256 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -8,6 +8,7 @@
 #include <linux/security.h>
 #include <linux/pid.h>
 #include <linux/nsproxy.h>
+#include <linux/sched/signal.h>
 
 /* Well, we should have at least one descriptor open
  * to accept passed FDs 8)
diff --git a/kernel/pid.c b/kernel/pid.c
index 157fe4b19971..d0de2b59f86f 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -421,13 +421,14 @@ pid_t __task_pid_nr_ns(struct task_struct *task, enum pid_type type,
 	if (!ns)
 		ns = task_active_pid_ns(current);
 	if (likely(pid_alive(task))) {
-		if (type != PIDTYPE_PID) {
-			if (type == __PIDTYPE_TGID)
-				type = PIDTYPE_PID;
-
-			task = task->group_leader;
-		}
-		nr = pid_nr_ns(rcu_dereference(task->pids[type].pid), ns);
+		struct pid *pid;
+		if (type == PIDTYPE_PID)
+			pid = task_pid(task);
+		else if (type == __PIDTYPE_TGID)
+			pid = task_tgid(task);
+		else
+			pid = rcu_dereference(task->group_leader->pids[type].pid);
+		nr = pid_nr_ns(pid, ns);
 	}
 	rcu_read_unlock();
 
-- 
2.17.1

