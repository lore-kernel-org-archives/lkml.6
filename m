Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A5FECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CAD420875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CAD420875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbeGXEaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:30:10 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:58741 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388244AbeGXEaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:30:08 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnxN-0005d2-L5; Mon, 23 Jul 2018 21:25:49 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnxM-0008AK-Ts; Mon, 23 Jul 2018 21:25:49 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 23 Jul 2018 22:24:09 -0500
Message-Id: <20180724032419.20231-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87efft5ncd.fsf_-_@xmission.com>
References: <87efft5ncd.fsf_-_@xmission.com>
X-XM-SPF: eid=1fhnxM-0008AK-Ts;;;mid=<20180724032419.20231-10-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18/BkZuZ7JcPwh53E3mbSLp+MWAxOGe32w=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 10/20] signal: Pass pid type into group_send_sig_info
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This passes the information we already have at the call sight
into group_send_sig_info.  Ultimatelly allowing for to better handle
signals sent to a group of processes.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/signal.h |  4 +++-
 kernel/exit.c          |  3 ++-
 kernel/signal.c        | 10 ++++++----
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index 3c5200137b24..d8f2bf3d41e6 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -254,11 +254,13 @@ static inline int valid_signal(unsigned long sig)
 
 struct timespec;
 struct pt_regs;
+enum pid_type;
 
 extern int next_signal(struct sigpending *pending, sigset_t *mask);
 extern int do_send_sig_info(int sig, struct siginfo *info,
 				struct task_struct *p, bool group);
-extern int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p);
+extern int group_send_sig_info(int sig, struct siginfo *info,
+			       struct task_struct *p, enum pid_type type);
 extern int __group_send_sig_info(int, struct siginfo *, struct task_struct *);
 extern int sigprocmask(int, sigset_t *, sigset_t *);
 extern void set_current_blocked(sigset_t *);
diff --git a/kernel/exit.c b/kernel/exit.c
index 25582b442955..0e21e6d21f35 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -681,7 +681,8 @@ static void forget_original_parent(struct task_struct *father,
 				t->parent = t->real_parent;
 			if (t->pdeath_signal)
 				group_send_sig_info(t->pdeath_signal,
-						    SEND_SIG_NOINFO, t);
+						    SEND_SIG_NOINFO, t,
+						    PIDTYPE_TGID);
 		}
 		/*
 		 * If this is a threaded reparent there is no need to
diff --git a/kernel/signal.c b/kernel/signal.c
index 40feb14e276d..c7527338fe9d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1274,7 +1274,8 @@ struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
 /*
  * send signal info to all the members of a group
  */
-int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
+int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p,
+			enum pid_type type)
 {
 	int ret;
 
@@ -1301,7 +1302,7 @@ int __kill_pgrp_info(int sig, struct siginfo *info, struct pid *pgrp)
 	success = 0;
 	retval = -ESRCH;
 	do_each_pid_task(pgrp, PIDTYPE_PGID, p) {
-		int err = group_send_sig_info(sig, info, p);
+		int err = group_send_sig_info(sig, info, p, PIDTYPE_PGID);
 		success |= !err;
 		retval = err;
 	} while_each_pid_task(pgrp, PIDTYPE_PGID, p);
@@ -1317,7 +1318,7 @@ int kill_pid_info(int sig, struct siginfo *info, struct pid *pid)
 		rcu_read_lock();
 		p = pid_task(pid, PIDTYPE_PID);
 		if (p)
-			error = group_send_sig_info(sig, info, p);
+			error = group_send_sig_info(sig, info, p, PIDTYPE_TGID);
 		rcu_read_unlock();
 		if (likely(!p || error != -ESRCH))
 			return error;
@@ -1420,7 +1421,8 @@ static int kill_something_info(int sig, struct siginfo *info, pid_t pid)
 		for_each_process(p) {
 			if (task_pid_vnr(p) > 1 &&
 					!same_thread_group(p, current)) {
-				int err = group_send_sig_info(sig, info, p);
+				int err = group_send_sig_info(sig, info, p,
+							      PIDTYPE_MAX);
 				++count;
 				if (err != -EPERM)
 					retval = err;
-- 
2.17.1

