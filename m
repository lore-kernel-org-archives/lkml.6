Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E86ECE563
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 18:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FC220883
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 18:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FC220883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbeIPXak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 19:30:40 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:52721 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbeIPXaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 19:30:39 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1bRf-0005r5-33; Sun, 16 Sep 2018 12:06:55 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1bRd-0002Jx-QX; Sun, 16 Sep 2018 12:06:54 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <87musyl3fa.fsf@xmission.com> <87lg81pbe2.fsf@xmission.com>
Date:   Sun, 16 Sep 2018 20:06:45 +0200
In-Reply-To: <87lg81pbe2.fsf@xmission.com> (Eric W. Biederman's message of
        "Sun, 16 Sep 2018 20:04:05 +0200")
Message-ID: <87y3c1nwp6.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g1bRd-0002Jx-QX;;;mid=<87y3c1nwp6.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19pozAdZ/GcZ8TOK6YNTFvPh9TcFvOnWVk=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 4/4] signal: Pair exports with their functions
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


For readability and consistency with the other exports in
kernel/signal.c pair the exports of signal sending functions with
their functions, instead of having the exports in one big clump.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 99e91163c9a3..e16278710b36 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -176,6 +176,7 @@ void recalc_sigpending(void)
 		clear_thread_flag(TIF_SIGPENDING);
 
 }
+EXPORT_SYMBOL(recalc_sigpending);
 
 void calculate_sigpending(void)
 {
@@ -466,6 +467,7 @@ void flush_signals(struct task_struct *t)
 	flush_sigqueue(&t->signal->shared_pending);
 	spin_unlock_irqrestore(&t->sighand->siglock, flags);
 }
+EXPORT_SYMBOL(flush_signals);
 
 #ifdef CONFIG_POSIX_TIMERS
 static void __flush_itimer_signals(struct sigpending *pending)
@@ -684,6 +686,7 @@ int dequeue_signal(struct task_struct *tsk, sigset_t *mask, siginfo_t *info)
 #endif
 	return signr;
 }
+EXPORT_SYMBOL_GPL(dequeue_signal);
 
 /*
  * Tell a process that it has a new active signal..
@@ -1490,6 +1493,7 @@ int send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 
 	return do_send_sig_info(sig, info, p, PIDTYPE_PID);
 }
+EXPORT_SYMBOL(send_sig_info);
 
 #define __si_special(priv) \
 	((priv) ? SEND_SIG_PRIV : SEND_SIG_NOINFO)
@@ -1499,11 +1503,13 @@ send_sig(int sig, struct task_struct *p, int priv)
 {
 	return send_sig_info(sig, __si_special(priv), p);
 }
+EXPORT_SYMBOL(send_sig);
 
 void force_sig(int sig, struct task_struct *p)
 {
 	force_sig_info(sig, SEND_SIG_PRIV, p);
 }
+EXPORT_SYMBOL(force_sig);
 
 /*
  * When things go south during signal handling, we
@@ -2634,14 +2640,6 @@ void exit_signals(struct task_struct *tsk)
 	}
 }
 
-EXPORT_SYMBOL(recalc_sigpending);
-EXPORT_SYMBOL_GPL(dequeue_signal);
-EXPORT_SYMBOL(flush_signals);
-EXPORT_SYMBOL(force_sig);
-EXPORT_SYMBOL(send_sig);
-EXPORT_SYMBOL(send_sig_info);
-EXPORT_SYMBOL(sigprocmask);
-
 /*
  * System call entry points.
  */
@@ -2735,6 +2733,7 @@ int sigprocmask(int how, sigset_t *set, sigset_t *oldset)
 	__set_current_blocked(&newset);
 	return 0;
 }
+EXPORT_SYMBOL(sigprocmask);
 
 /**
  *  sys_rt_sigprocmask - change the list of currently blocked signals
-- 
2.17.1

