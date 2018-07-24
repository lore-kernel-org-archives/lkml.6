Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E916C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2846420852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2846420852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388525AbeGXEcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:32:00 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:58874 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388391AbeGXEby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:31:54 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnz5-0005px-Ng; Mon, 23 Jul 2018 21:27:35 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnxR-0008AK-Cl; Mon, 23 Jul 2018 21:25:54 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 23 Jul 2018 22:24:11 -0500
Message-Id: <20180724032419.20231-12-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87efft5ncd.fsf_-_@xmission.com>
References: <87efft5ncd.fsf_-_@xmission.com>
X-XM-SPF: eid=1fhnxR-0008AK-Cl;;;mid=<20180724032419.20231-12-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19HXzQ6CKVE4dsiA+nHfKC3ld4spwDbPvM=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 12/20] signal: Pass pid type into do_send_sig_info
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This passes the information we already have at the call sight into
do_send_sig_info.  Ultimately allowing for better handling of signals
sent to a group of processes during fork.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 drivers/tty/sysrq.c    |  2 +-
 fs/fcntl.c             |  6 +++---
 include/linux/signal.h |  2 +-
 kernel/signal.c        | 10 +++++-----
 mm/oom_kill.c          |  4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 6364890575ec..06ed20dd01ba 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -348,7 +348,7 @@ static void send_sig_all(int sig)
 		if (is_global_init(p))
 			continue;
 
-		do_send_sig_info(sig, SEND_SIG_FORCED, p, true);
+		do_send_sig_info(sig, SEND_SIG_FORCED, p, PIDTYPE_MAX);
 	}
 	read_unlock(&tasklist_lock);
 }
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 5d596a00f40b..a04accf6847f 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -767,11 +767,11 @@ static void send_sigio_to_task(struct task_struct *p,
 			else
 				si.si_band = mangle_poll(band_table[reason - POLL_IN]);
 			si.si_fd    = fd;
-			if (!do_send_sig_info(signum, &si, p, type != PIDTYPE_PID))
+			if (!do_send_sig_info(signum, &si, p, type))
 				break;
 		/* fall-through: fall back on the old plain SIGIO signal */
 		case 0:
-			do_send_sig_info(SIGIO, SEND_SIG_PRIV, p, type != PIDTYPE_PID);
+			do_send_sig_info(SIGIO, SEND_SIG_PRIV, p, type);
 	}
 }
 
@@ -808,7 +808,7 @@ static void send_sigurg_to_task(struct task_struct *p,
 				struct fown_struct *fown, enum pid_type type)
 {
 	if (sigio_perm(p, fown, SIGURG))
-		do_send_sig_info(SIGURG, SEND_SIG_PRIV, p, type != PIDTYPE_PID);
+		do_send_sig_info(SIGURG, SEND_SIG_PRIV, p, type);
 }
 
 int send_sigurg(struct fown_struct *fown)
diff --git a/include/linux/signal.h b/include/linux/signal.h
index d8f2bf3d41e6..fe125b0335f7 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -258,7 +258,7 @@ enum pid_type;
 
 extern int next_signal(struct sigpending *pending, sigset_t *mask);
 extern int do_send_sig_info(int sig, struct siginfo *info,
-				struct task_struct *p, bool group);
+				struct task_struct *p, enum pid_type type);
 extern int group_send_sig_info(int sig, struct siginfo *info,
 			       struct task_struct *p, enum pid_type type);
 extern int __group_send_sig_info(int, struct siginfo *, struct task_struct *);
diff --git a/kernel/signal.c b/kernel/signal.c
index c7527338fe9d..2c09e6143dd8 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1161,13 +1161,13 @@ specific_send_sig_info(int sig, struct siginfo *info, struct task_struct *t)
 }
 
 int do_send_sig_info(int sig, struct siginfo *info, struct task_struct *p,
-			bool group)
+			enum pid_type type)
 {
 	unsigned long flags;
 	int ret = -ESRCH;
 
 	if (lock_task_sighand(p, &flags)) {
-		ret = send_signal(sig, info, p, group);
+		ret = send_signal(sig, info, p, type != PIDTYPE_PID);
 		unlock_task_sighand(p, &flags);
 	}
 
@@ -1284,7 +1284,7 @@ int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p,
 	rcu_read_unlock();
 
 	if (!ret && sig)
-		ret = do_send_sig_info(sig, info, p, true);
+		ret = do_send_sig_info(sig, info, p, type);
 
 	return ret;
 }
@@ -1448,7 +1448,7 @@ int send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 	if (!valid_signal(sig))
 		return -EINVAL;
 
-	return do_send_sig_info(sig, info, p, false);
+	return do_send_sig_info(sig, info, p, PIDTYPE_PID);
 }
 
 #define __si_special(priv) \
@@ -3199,7 +3199,7 @@ do_send_specific(pid_t tgid, pid_t pid, int sig, struct siginfo *info)
 		 * probe.  No signal is actually delivered.
 		 */
 		if (!error && sig) {
-			error = do_send_sig_info(sig, info, p, false);
+			error = do_send_sig_info(sig, info, p, PIDTYPE_PID);
 			/*
 			 * If lock_task_sighand() failed we pretend the task
 			 * dies after receiving the signal. The window is tiny,
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 84081e77bc51..2cc9b238368f 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -920,7 +920,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	 * in order to prevent the OOM victim from depleting the memory
 	 * reserves from the user space under its control.
 	 */
-	do_send_sig_info(SIGKILL, SEND_SIG_FORCED, victim, true);
+	do_send_sig_info(SIGKILL, SEND_SIG_FORCED, victim, PIDTYPE_TGID);
 	mark_oom_victim(victim);
 	pr_err("Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
 		task_pid_nr(victim), victim->comm, K(victim->mm->total_vm),
@@ -958,7 +958,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 		 */
 		if (unlikely(p->flags & PF_KTHREAD))
 			continue;
-		do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, true);
+		do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, PIDTYPE_TGID);
 	}
 	rcu_read_unlock();
 
-- 
2.17.1

