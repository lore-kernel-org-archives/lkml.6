Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25594ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D192420852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D192420852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388516AbeGXEbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:31:55 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:51377 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388199AbeGXEby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:31:54 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnz4-0007ik-5Z; Mon, 23 Jul 2018 21:27:34 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnxg-0008AK-3W; Mon, 23 Jul 2018 21:26:23 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 23 Jul 2018 22:24:17 -0500
Message-Id: <20180724032419.20231-18-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87efft5ncd.fsf_-_@xmission.com>
References: <87efft5ncd.fsf_-_@xmission.com>
X-XM-SPF: eid=1fhnxg-0008AK-3W;;;mid=<20180724032419.20231-18-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18qBtVUp59V8gX/MoEQMzOHRYYDx6f6e9g=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 18/20] signal: Add calculate_sigpending()
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
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
setting TIF_SIGPENDING and I don't see else that needs to be handled.
The code probably doesn't need to set TIF_SIGPENDING for the kernel
live patching as it uses a separate thread flag as well.  But at this
point it seems safer to copy recalc_sigpending and get the kernel live
patching folks to sort out their story later.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h |  1 +
 kernel/fork.c                |  1 +
 kernel/signal.c              | 13 +++++++++++++
 3 files changed, 15 insertions(+)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 94558ffa82ab..7cabc0bc38f6 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -372,6 +372,7 @@ static inline int signal_pending_state(long state, struct task_struct *p)
  */
 extern void recalc_sigpending_and_wake(struct task_struct *t);
 extern void recalc_sigpending(void);
+extern void calculate_sigpending(struct task_struct *new);
 
 extern void signal_wake_up_state(struct task_struct *t, unsigned int state);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 22d4cdb9a7ca..e07281254552 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1988,6 +1988,7 @@ static __latent_entropy struct task_struct *copy_process(
 					  &p->signal->thread_head);
 		}
 		attach_pid(p, PIDTYPE_PID);
+		calculate_sigpending(p);
 		nr_threads++;
 	}
 
diff --git a/kernel/signal.c b/kernel/signal.c
index dddbea558455..f6687c7d7a8c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -172,6 +172,19 @@ void recalc_sigpending(void)
 
 }
 
+void calculate_sigpending(struct task_struct *new)
+{
+	/* Have any signals or users of TIF_SIGPENDING been delayed
+	 * until after fork?
+	 */
+	bool pending = (new->jobctl & JOBCTL_PENDING_MASK) ||
+		PENDING(&new->pending, &new->blocked) ||
+		PENDING(&new->signal->shared_pending, &new->blocked) ||
+		freezing(new) || klp_patch_pending(new);
+
+	update_tsk_thread_flag(new, TIF_SIGPENDING, pending);
+}
+
 /* Given the mask, find the first available signal that should be serviced. */
 
 #define SYNCHRONOUS_MASK \
-- 
2.17.1

