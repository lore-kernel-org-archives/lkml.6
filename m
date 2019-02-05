Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1B7C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E7A217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfBEP0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:26:16 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:49906 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbfBEP0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:26:16 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gr2c1-0006nn-O8; Tue, 05 Feb 2019 08:26:13 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gr2c0-0005BS-Pl; Tue, 05 Feb 2019 08:26:13 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@redhat.com, Namhyung Kim <namhyung@kernel.org>,
        luca abeni <luca.abeni@santannapisa.it>,
        syzkaller <syzkaller@googlegroups.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <CACT4Y+bFh_S3=U+JF7GCzZjZ9R8b_Xqzi-1AyruKxqNqGrFVrQ@mail.gmail.com>
        <CACT4Y+YdVewFEmw2wFrnaHOc78b4bMZ4Nfu0uEzLk08UtvwOMA@mail.gmail.com>
        <alpine.DEB.2.21.1902041025050.8200@nanos.tec.linutronix.de>
        <CACT4Y+agDBRQ8f0kvqU7dJ9nmNZcNyLk1vc4fcGeH3WR-iAFqw@mail.gmail.com>
        <alpine.DEB.2.21.1902041736240.3006@nanos.tec.linutronix.de>
        <8736p37xcn.fsf@xmission.com> <878syu7tcm.fsf@xmission.com>
        <87tvhi4vl7.fsf@xmission.com>
Date:   Tue, 05 Feb 2019 09:26:05 -0600
In-Reply-To: <87tvhi4vl7.fsf@xmission.com> (Eric W. Biederman's message of
        "Tue, 05 Feb 2019 00:07:16 -0600")
Message-ID: <87o97q1cky.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gr2c0-0005BS-Pl;;;mid=<87o97q1cky.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/3EVMqxAMRRvLKoZNJUEMxLhYFZ5TWiFM=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [RFC][PATCH] signal: Store pending signal exit in tsk.jobctl not in tsk.pending
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Recently syzkaller was able to create unkillablle processes by
creating a timer that is delivered as a thread local signal on SIGHUP,
and receiving SIGHUP SA_NODEFERER.  Ultimately causing a loop
failing to deliver SIGHUP but always trying.

Upon examination it turns out part of the problem is actually most of
the solution.  Since 2.5 complete_signal has found all fatal signals
and queued SIGKILL in every threads thread queue relying on
signal->group_exit_code to preserve the information of which was the
actual fatal signal.

The conversion of all fatal signals to SIGKILL results in the
synchronous signal heuristic in next_signal kicking in and preferring
SIGHUP to SIGKILL.  Which is especially problematic as all
fatal signals have already been transformed into SIGKILL.

Now that we have task->jobctl we can do better and set a bit in
task->jobctl instead of reusing tsk->pending[SIGKILL].  This allows
giving already detected process exits a higher priority than any
pending signal.

Cc: stable@vger.kernel.org
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Ref: ebf5ebe31d2c ("[PATCH] signal-fixes-2.5.59-A4")
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
Oleg, can you give this a quick review and see if I am missing anything?
Dmitry, can you verify this runs cleanly in your test setups?

 fs/coredump.c                |  2 +-
 include/linux/sched/jobctl.h |  1 +
 include/linux/sched/signal.h |  2 +-
 kernel/signal.c              | 10 ++++++++--
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index e42e17e55bfd..487995293ef0 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -322,7 +322,7 @@ static int zap_process(struct task_struct *start, int exit_code, int flags)
 	for_each_thread(start, t) {
 		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
 		if (t != current && t->mm) {
-			sigaddset(&t->pending.signal, SIGKILL);
+			t->jobctl |= JOBCTL_TASK_EXIT;
 			signal_wake_up(t, 1);
 			nr++;
 		}
diff --git a/include/linux/sched/jobctl.h b/include/linux/sched/jobctl.h
index 98228bd48aee..ff7b3ea43f4c 100644
--- a/include/linux/sched/jobctl.h
+++ b/include/linux/sched/jobctl.h
@@ -18,6 +18,7 @@ struct task_struct;
 #define JOBCTL_TRAP_NOTIFY_BIT	20	/* trap for NOTIFY */
 #define JOBCTL_TRAPPING_BIT	21	/* switching to TRACED */
 #define JOBCTL_LISTENING_BIT	22	/* ptracer is listening for events */
+#define JOBCTL_TASK_EXIT	23	/* task is exiting */
 
 #define JOBCTL_STOP_DEQUEUED	(1UL << JOBCTL_STOP_DEQUEUED_BIT)
 #define JOBCTL_STOP_PENDING	(1UL << JOBCTL_STOP_PENDING_BIT)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 13789d10a50e..3f3edadf1ae1 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -354,7 +354,7 @@ static inline int signal_pending(struct task_struct *p)
 
 static inline int __fatal_signal_pending(struct task_struct *p)
 {
-	return unlikely(sigismember(&p->pending.signal, SIGKILL));
+	return unlikely(p->jobctl & JOBCTL_TASK_EXIT);
 }
 
 static inline int fatal_signal_pending(struct task_struct *p)
diff --git a/kernel/signal.c b/kernel/signal.c
index 9ca8e5278c8e..0577e37fdf43 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -989,7 +989,7 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 			t = p;
 			do {
 				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
-				sigaddset(&t->pending.signal, SIGKILL);
+				t->jobctl |= JOBCTL_TASK_EXIT;
 				signal_wake_up(t, 1);
 			} while_each_thread(p, t);
 			return;
@@ -1273,7 +1273,7 @@ int zap_other_threads(struct task_struct *p)
 		/* Don't bother with already dead threads */
 		if (t->exit_state)
 			continue;
-		sigaddset(&t->pending.signal, SIGKILL);
+		t->jobctl |= JOBCTL_TASK_EXIT;
 		signal_wake_up(t, 1);
 	}
 
@@ -2393,6 +2393,11 @@ bool get_signal(struct ksignal *ksig)
 		goto relock;
 	}
 
+	/* Has this task already been flagged for death? */
+	ksig->info.si_signo = signr = SIGKILL;
+	if (current->jobctl & JOBCTL_TASK_EXIT)
+		goto fatal;
+
 	for (;;) {
 		struct k_sigaction *ka;
 
@@ -2488,6 +2493,7 @@ bool get_signal(struct ksignal *ksig)
 			continue;
 		}
 
+	fatal:
 		spin_unlock_irq(&sighand->siglock);
 
 		/*
-- 
2.17.1

