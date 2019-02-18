Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A75C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE53F204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498807;
	bh=wtMcvNe8DQvtfize5akKGLAu9e4TFOXF6QjhzB6LyFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AucTSIoQmC2pqYjNshpDkaR9NgQEZcNiKjrJcc293asK/5tneSqVGhUeprkyuWTIW
	 2niyfHrj93v2gzq1O3LTzTH+Rzd68nYpgwj+QxcsdWipxcpY2Z/EpJNaxR9E+z3U2O
	 TcF2tCZZU6SHpQo3TvLNcG6EEV+KLI3/D4Eq6DhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbfBROGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:06:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:49762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390460AbfBROGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:06:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53EC821916;
        Mon, 18 Feb 2019 14:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498801;
        bh=wtMcvNe8DQvtfize5akKGLAu9e4TFOXF6QjhzB6LyFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SfVk80en6EKcsvG0KyND14CJfNIxLAb/j5CZYvRyTKXtVPKamKkbht1bTHlW/xwQb
         qEdlKYCLhRE/QHVyj5r/P+mbDPbf1joGfeQkGws22yeKpdsh4K4SkBSW6fRiimW9aK
         TWHqhx7YlQAwBBB9z551CBQ72WIzB5AXPi+e+c4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.4 100/143] signal: Better detection of synchronous signals
Date:   Mon, 18 Feb 2019 14:43:48 +0100
Message-Id: <20190218133532.697787362@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

commit 7146db3317c67b517258cb5e1b08af387da0618b upstream.

Recently syzkaller was able to create unkillablle processes by
creating a timer that is delivered as a thread local signal on SIGHUP,
and receiving SIGHUP SA_NODEFERER.  Ultimately causing a loop failing
to deliver SIGHUP but always trying.

When the stack overflows delivery of SIGHUP fails and force_sigsegv is
called.  Unfortunately because SIGSEGV is numerically higher than
SIGHUP next_signal tries again to deliver a SIGHUP.

>From a quality of implementation standpoint attempting to deliver the
timer SIGHUP signal is wrong.  We should attempt to deliver the
synchronous SIGSEGV signal we just forced.

We can make that happening in a fairly straight forward manner by
instead of just looking at the signal number we also look at the
si_code.  In particular for exceptions (aka synchronous signals) the
si_code is always greater than 0.

That still has the potential to pick up a number of asynchronous
signals as in a few cases the same si_codes that are used
for synchronous signals are also used for asynchronous signals,
and SI_KERNEL is also included in the list of possible si_codes.

Still the heuristic is much better and timer signals are definitely
excluded.  Which is enough to prevent all known ways for someone
sending a process signals fast enough to cause unexpected and
arguably incorrect behavior.

Cc: stable@vger.kernel.org
Fixes: a27341cd5fcb ("Prioritize synchronous signals over 'normal' signals")
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/signal.c |   52 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -696,6 +696,48 @@ static inline bool si_fromuser(const str
 		(!is_si_special(info) && SI_FROMUSER(info));
 }
 
+static int dequeue_synchronous_signal(siginfo_t *info)
+{
+	struct task_struct *tsk = current;
+	struct sigpending *pending = &tsk->pending;
+	struct sigqueue *q, *sync = NULL;
+
+	/*
+	 * Might a synchronous signal be in the queue?
+	 */
+	if (!((pending->signal.sig[0] & ~tsk->blocked.sig[0]) & SYNCHRONOUS_MASK))
+		return 0;
+
+	/*
+	 * Return the first synchronous signal in the queue.
+	 */
+	list_for_each_entry(q, &pending->list, list) {
+		/* Synchronous signals have a postive si_code */
+		if ((q->info.si_code > SI_USER) &&
+		    (sigmask(q->info.si_signo) & SYNCHRONOUS_MASK)) {
+			sync = q;
+			goto next;
+		}
+	}
+	return 0;
+next:
+	/*
+	 * Check if there is another siginfo for the same signal.
+	 */
+	list_for_each_entry_continue(q, &pending->list, list) {
+		if (q->info.si_signo == sync->info.si_signo)
+			goto still_pending;
+	}
+
+	sigdelset(&pending->signal, sync->info.si_signo);
+	recalc_sigpending();
+still_pending:
+	list_del_init(&sync->list);
+	copy_siginfo(info, &sync->info);
+	__sigqueue_free(sync);
+	return info->si_signo;
+}
+
 /*
  * called with RCU read lock from check_kill_permission()
  */
@@ -2216,7 +2258,15 @@ relock:
 			goto relock;
 		}
 
-		signr = dequeue_signal(current, &current->blocked, &ksig->info);
+		/*
+		 * Signals generated by the execution of an instruction
+		 * need to be delivered before any other pending signals
+		 * so that the instruction pointer in the signal stack
+		 * frame points to the faulting instruction.
+		 */
+		signr = dequeue_synchronous_signal(&ksig->info);
+		if (!signr)
+			signr = dequeue_signal(current, &current->blocked, &ksig->info);
 
 		if (!signr)
 			break; /* will return 0 */


