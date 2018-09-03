Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3C1C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F62A20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F62A20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbeIDBHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 21:07:54 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:60189 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbeIDBHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 21:07:54 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fwvjT-0008JL-7z; Mon, 03 Sep 2018 14:45:59 -0600
Received: from [105.225.206.69] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fwvjD-0008G7-Ar; Mon, 03 Sep 2018 14:45:59 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon,  3 Sep 2018 22:44:29 +0200
Message-Id: <20180903204430.25473-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87musyl3fa.fsf@xmission.com>
References: <87musyl3fa.fsf@xmission.com>
X-XM-SPF: eid=1fwvjD-0008G7-Ar;;;mid=<20180903204430.25473-9-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.225.206.69;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+K1vzjkqBk5fIeyKn24QHa+LQLqyuesPQ=
X-SA-Exim-Connect-IP: 105.225.206.69
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 09/10] signal: Use SEND_SIG_PRIV not SEND_SIG_FORCED with SIGKILL and SIGSTOP
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that siginfo is never allocated for SIGKILL and SIGSTOP there is
no difference between SEND_SIG_PRIV and SEND_SIG_FORCED for SIGKILL
and SIGSTOP.  This makes SEND_SIG_FORCED unnecessary and redundant in
the presence of SIGKILL and SIGSTOP.  Therefore change users of
SEND_SIG_FORCED that are sending SIGKILL or SIGSTOP to use
SEND_SIG_PRIV instead.

This removes the last users of SEND_SIG_FORCED.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/pid_namespace.c | 2 +-
 kernel/ptrace.c        | 4 ++--
 mm/oom_kill.c          | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 2a2ac53d8b8b..c8d53397bbdd 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -216,7 +216,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	idr_for_each_entry_continue(&pid_ns->idr, pid, nr) {
 		task = pid_task(pid, PIDTYPE_PID);
 		if (task && !__fatal_signal_pending(task))
-			send_sig_info(SIGKILL, SEND_SIG_FORCED, task);
+			send_sig_info(SIGKILL, SEND_SIG_PRIV, task);
 	}
 	read_unlock(&tasklist_lock);
 	rcu_read_unlock();
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 21fec73d45d4..45f77a1b9c97 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -396,7 +396,7 @@ static int ptrace_attach(struct task_struct *task, long request,
 
 	/* SEIZE doesn't trap tracee on attach */
 	if (!seize)
-		send_sig_info(SIGSTOP, SEND_SIG_FORCED, task);
+		send_sig_info(SIGSTOP, SEND_SIG_PRIV, task);
 
 	spin_lock(&task->sighand->siglock);
 
@@ -563,7 +563,7 @@ void exit_ptrace(struct task_struct *tracer, struct list_head *dead)
 
 	list_for_each_entry_safe(p, n, &tracer->ptraced, ptrace_entry) {
 		if (unlikely(p->ptrace & PT_EXITKILL))
-			send_sig_info(SIGKILL, SEND_SIG_FORCED, p);
+			send_sig_info(SIGKILL, SEND_SIG_PRIV, p);
 
 		if (__ptrace_detach(tracer, p))
 			list_add(&p->ptrace_entry, dead);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index b5b25e4dcbbb..3bcfeaaeed87 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -858,7 +858,7 @@ static void __oom_kill_process(struct task_struct *victim)
 	 * in order to prevent the OOM victim from depleting the memory
 	 * reserves from the user space under its control.
 	 */
-	do_send_sig_info(SIGKILL, SEND_SIG_FORCED, victim, PIDTYPE_TGID);
+	do_send_sig_info(SIGKILL, SEND_SIG_PRIV, victim, PIDTYPE_TGID);
 	mark_oom_victim(victim);
 	pr_err("Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
 		task_pid_nr(victim), victim->comm, K(victim->mm->total_vm),
@@ -896,7 +896,7 @@ static void __oom_kill_process(struct task_struct *victim)
 		 */
 		if (unlikely(p->flags & PF_KTHREAD))
 			continue;
-		do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, PIDTYPE_TGID);
+		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_TGID);
 	}
 	rcu_read_unlock();
 
-- 
2.17.1

