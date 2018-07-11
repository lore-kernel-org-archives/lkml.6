Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3FFC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6BC208EB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6BC208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732568AbeGKCsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:48:32 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:40175 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732484AbeGKCsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:48:31 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fd59B-0001AF-Fa; Tue, 10 Jul 2018 20:46:29 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fd599-00063R-RO; Tue, 10 Jul 2018 20:46:29 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 10 Jul 2018 21:44:55 -0500
Message-Id: <20180711024459.10654-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <877em2jxyr.fsf_-_@xmission.com>
References: <877em2jxyr.fsf_-_@xmission.com>
X-XM-SPF: eid=1fd599-00063R-RO;;;mid=<20180711024459.10654-7-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1++bhn549EXEP1yIIyJKthVzpN4/B615i0=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [RFC][PATCH 07/11] signal: Deliver group signals via PIDTYPE_TGID not PIDTYPE_PID
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we can make the distinction use PIDTYPE_TGID rather than
PIDTYPE_PID.  There is no immediate effect as they point point at the
same task, but this allows using enum pid_type instead of bool group
in the signal sending functions.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c            | 4 ++--
 kernel/time/posix-timers.c | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 8d8a940422a8..7caf17d76a84 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1315,7 +1315,7 @@ int kill_pid_info(int sig, struct siginfo *info, struct pid *pid)
 
 	for (;;) {
 		rcu_read_lock();
-		p = pid_task(pid, PIDTYPE_PID);
+		p = pid_task(pid, PIDTYPE_TGID);
 		if (p)
 			error = group_send_sig_info(sig, info, p);
 		rcu_read_unlock();
@@ -1361,7 +1361,7 @@ int kill_pid_info_as_cred(int sig, struct siginfo *info, struct pid *pid,
 		return ret;
 
 	rcu_read_lock();
-	p = pid_task(pid, PIDTYPE_PID);
+	p = pid_task(pid, PIDTYPE_TGID);
 	if (!p) {
 		ret = -ESRCH;
 		goto out_unlock;
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index e08ce3f27447..d640e26d0de0 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -347,12 +347,11 @@ int posix_timer_event(struct k_itimer *timr, int si_private)
 	 */
 	timr->sigq->info.si_sys_private = si_private;
 
+	shared = !(timr->it_sigev_notify & SIGEV_THREAD_ID);
 	rcu_read_lock();
-	task = pid_task(timr->it_pid, PIDTYPE_PID);
-	if (task) {
-		shared = !(timr->it_sigev_notify & SIGEV_THREAD_ID);
+	task = pid_task(timr->it_pid, shared ? PIDTYPE_TGID : PIDTYPE_PID);
+	if (task)
 		ret = send_sigqueue(timr->sigq, task, shared);
-	}
 	rcu_read_unlock();
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
-- 
2.17.1

