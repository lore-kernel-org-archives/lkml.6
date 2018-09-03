Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF34C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CCB20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CCB20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbeIDBH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 21:07:58 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:60195 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbeIDBH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 21:07:57 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fwvjX-0008K5-JB; Mon, 03 Sep 2018 14:46:03 -0600
Received: from [105.225.206.69] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fwvjW-0008G7-Eo; Mon, 03 Sep 2018 14:46:03 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon,  3 Sep 2018 22:44:30 +0200
Message-Id: <20180903204430.25473-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87musyl3fa.fsf@xmission.com>
References: <87musyl3fa.fsf@xmission.com>
X-XM-SPF: eid=1fwvjW-0008G7-Eo;;;mid=<20180903204430.25473-10-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.225.206.69;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/PJw6ciHwovaR0yVOjJNwQpLk6k5BN98c=
X-SA-Exim-Connect-IP: 105.225.206.69
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 10/10] signal: Remove SEND_SIG_FORCED
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no more users of SEND_SIG_FORCED so it may be safely removed.

Remove the definition of SEND_SIG_FORCED, it's use in is_si_special,
it's use in TP_STORE_SIGINFO, and it's use in __send_signal as without
any users the uses of SEND_SIG_FORCED are now unncessary.

This makes the code simpler, easier to understand and use.  Users of
signal sending functions now no longer need to ask themselves do I
need to use SEND_SIG_FORCED.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h  | 1 -
 include/trace/events/signal.h | 3 +--
 kernel/signal.c               | 7 +++----
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 9b6968cbde14..9e07f3521549 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -477,7 +477,6 @@ static inline int kill_cad_pid(int sig, int priv)
 /* These can be the second arg to send_sig_info/send_group_sig_info.  */
 #define SEND_SIG_NOINFO ((struct siginfo *) 0)
 #define SEND_SIG_PRIV	((struct siginfo *) 1)
-#define SEND_SIG_FORCED	((struct siginfo *) 2)
 
 /*
  * True if we are on the alternate signal stack.
diff --git a/include/trace/events/signal.h b/include/trace/events/signal.h
index 86582923d51c..3deeed50ffd0 100644
--- a/include/trace/events/signal.h
+++ b/include/trace/events/signal.h
@@ -11,8 +11,7 @@
 
 #define TP_STORE_SIGINFO(__entry, info)				\
 	do {							\
-		if (info == SEND_SIG_NOINFO ||			\
-		    info == SEND_SIG_FORCED) {			\
+		if (info == SEND_SIG_NOINFO) {			\
 			__entry->errno	= 0;			\
 			__entry->code	= SI_USER;		\
 		} else if (info == SEND_SIG_PRIV) {		\
diff --git a/kernel/signal.c b/kernel/signal.c
index d7d1adf735f4..ec136fda457a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -736,7 +736,7 @@ static void flush_sigqueue_mask(sigset_t *mask, struct sigpending *s)
 
 static inline int is_si_special(const struct siginfo *info)
 {
-	return info <= SEND_SIG_FORCED;
+	return info <= SEND_SIG_PRIV;
 }
 
 static inline bool si_fromuser(const struct siginfo *info)
@@ -1039,7 +1039,7 @@ static int __send_signal(int sig, struct siginfo *info, struct task_struct *t,
 
 	result = TRACE_SIGNAL_IGNORED;
 	if (!prepare_signal(sig, t,
-			from_ancestor_ns || (info == SEND_SIG_PRIV) || (info == SEND_SIG_FORCED)))
+			from_ancestor_ns || (info == SEND_SIG_PRIV)))
 		goto ret;
 
 	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
@@ -1057,8 +1057,7 @@ static int __send_signal(int sig, struct siginfo *info, struct task_struct *t,
 	 * Skip useless siginfo allocation for SIGKILL SIGSTOP,
 	 * and kernel threads.
 	 */
-	if ((info == SEND_SIG_FORCED) ||
-	    sig_kernel_only(sig) || (t->flags & PF_KTHREAD))
+	if (sig_kernel_only(sig) || (t->flags & PF_KTHREAD))
 		goto out_set;
 
 	/*
-- 
2.17.1

