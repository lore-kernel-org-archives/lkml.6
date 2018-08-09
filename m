Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93624C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CEA21C3C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CEA21C3C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeHIJU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:20:56 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43860 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeHIJU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:20:56 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fnet0-0008J8-Nh; Thu, 09 Aug 2018 00:57:30 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fnesz-00054s-JD; Thu, 09 Aug 2018 00:57:30 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Thu,  9 Aug 2018 01:56:02 -0500
Message-Id: <20180809065605.32345-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87wot0yqsx.fsf_-_@xmission.com>
References: <87wot0yqsx.fsf_-_@xmission.com>
X-XM-SPF: eid=1fnesz-00054s-JD;;;mid=<20180809065605.32345-3-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18DT9EfHdDJ2Z+e1Imk9CjqzeTQ82b1eDQ=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v5 3/6] signal: Add calculate_sigpending()
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function calculate_sigpending to test to see if any signals are
pending for a new task immediately following fork.  Signals have to
happen either before or after fork.  Today our practice is to push
all of the signals to before the fork, but that has the downside that
frequent or periodic signals can make fork take much much longer than
normal or prevent fork from completing entirely.

So we need move signals that we can after the fork to prevent that.

This updates the code to set TIF_SIGPENDING on a new task if there
are signals or other activities that have moved so that they appear
to happen after the fork.

As the code today restarts if it sees any such activity this won't
immediately have an effect, as there will be no reason for it
to set TIF_SIGPENDING immediately after the fork.

Adding calculate_sigpending means the code in fork can safely be
changed to not always restart if a signal is pending.

The new calculate_sigpending function sets sigpending if there
are pending bits in jobctl, pending signals, the freezer needs
to freeze the new task or the live kernel patching framework
need the new thread to take the slow path to userspace.

I have verified that setting TIF_SIGPENDING does make a new process
take the slow path to userspace before it executes it's first userspace
instruction.

I have looked at the callers of signal_wake_up and the code paths
setting TIF_SIGPENDING and I don't see anything else that needs to be
handled.  The code probably doesn't need to set TIF_SIGPENDING for the
kernel live patching as it uses a separate thread flag as well.  But
at this point it seems safer reuse the recalc_sigpending logic and get
the kernel live patching folks to sort out their story later.

V2: I have moved the test into schedule_tail where siglock can
    be grabbed and recalc_sigpending can be reused directly.
    Further as the last action of setting up a new task this
    guarantees that TIF_SIGPENDING will be properly set in the
    new process.

    The helper calculate_sigpending takes the siglock and
    uncontitionally sets TIF_SIGPENDING and let's recalc_sigpending
    clear TIF_SIGPENDING if it is unnecessary.  This allows reusing
    the existing code and keeps maintenance of the conditions simple.

    Oleg Nesterov <oleg@redhat.com>  suggested the movement
    and pointed out the need to take siglock if this code
    was going to be called while the new task is discoverable.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h |  1 +
 kernel/sched/core.c          |  2 ++
 kernel/signal.c              | 11 +++++++++++
 3 files changed, 14 insertions(+)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 94558ffa82ab..b55fd293c1e5 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -372,6 +372,7 @@ static inline int signal_pending_state(long state, struct task_struct *p)
  */
 extern void recalc_sigpending_and_wake(struct task_struct *t);
 extern void recalc_sigpending(void);
+extern void calculate_sigpending(void);
 
 extern void signal_wake_up_state(struct task_struct *t, unsigned int state);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 78d8facba456..3e4ed4b7aa2d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2813,6 +2813,8 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 
 	if (current->set_child_tid)
 		put_user(task_pid_vnr(current), current->set_child_tid);
+
+	calculate_sigpending();
 }
 
 /*
diff --git a/kernel/signal.c b/kernel/signal.c
index dddbea558455..1e06f1eba363 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -172,6 +172,17 @@ void recalc_sigpending(void)
 
 }
 
+void calculate_sigpending(void)
+{
+	/* Have any signals or users of TIF_SIGPENDING been delayed
+	 * until after fork?
+	 */
+	spin_lock_irq(&current->sighand->siglock);
+	set_tsk_thread_flag(current, TIF_SIGPENDING);
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
+}
+
 /* Given the mask, find the first available signal that should be serviced. */
 
 #define SYNCHRONOUS_MASK \
-- 
2.17.1

