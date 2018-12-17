Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AA3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651902133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388303AbeLQQki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:40:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34729 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387905AbeLQQki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:40:38 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBHGdvnh2536264
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Dec 2018 08:39:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBHGdvMq2536260;
        Mon, 17 Dec 2018 08:39:57 -0800
Date:   Mon, 17 Dec 2018 08:39:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-0e334db6bb4b1fd1e2d72c1f3d8f004313cd9f94@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, hpa@zytor.com, tglx@linutronix.de,
        john.stultz@linaro.org, linux-kernel@vger.kernel.org
Reply-To: john.stultz@linaro.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          torvalds@linux-foundation.org, peterz@infradead.org
In-Reply-To: <alpine.DEB.2.21.1812171328050.1880@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1812171328050.1880@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] posix-timers: Fix division by zero bug
Git-Commit-ID: 0e334db6bb4b1fd1e2d72c1f3d8f004313cd9f94
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0e334db6bb4b1fd1e2d72c1f3d8f004313cd9f94
Gitweb:     https://git.kernel.org/tip/0e334db6bb4b1fd1e2d72c1f3d8f004313cd9f94
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Dec 2018 13:31:05 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Dec 2018 17:35:45 +0100

posix-timers: Fix division by zero bug

The signal delivery path of posix-timers can try to rearm the timer even if
the interval is zero. That's handled for the common case (hrtimer) but not
for alarm timers. In that case the forwarding function raises a division by
zero exception.

The handling for hrtimer based posix timers is wrong because it marks the
timer as active despite the fact that it is stopped.

Move the check from common_hrtimer_rearm() to posixtimer_rearm() to cure
both issues.

Reported-by: syzbot+9d38bedac9cc77b8ad5e@syzkaller.appspotmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: sboyd@kernel.org
Cc: stable@vger.kernel.org
Cc: syzkaller-bugs@googlegroups.com
Link: http://lkml.kernel.org/r/alpine.DEB.2.21.1812171328050.1880@nanos.tec.linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/time/posix-timers.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index bd62b5eeb5a0..31f49ae80f43 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -289,9 +289,6 @@ static void common_hrtimer_rearm(struct k_itimer *timr)
 {
 	struct hrtimer *timer = &timr->it.real.timer;
 
-	if (!timr->it_interval)
-		return;
-
 	timr->it_overrun += hrtimer_forward(timer, timer->base->get_time(),
 					    timr->it_interval);
 	hrtimer_restart(timer);
@@ -317,7 +314,7 @@ void posixtimer_rearm(struct kernel_siginfo *info)
 	if (!timr)
 		return;
 
-	if (timr->it_requeue_pending == info->si_sys_private) {
+	if (timr->it_interval && timr->it_requeue_pending == info->si_sys_private) {
 		timr->kclock->timer_rearm(timr);
 
 		timr->it_active = 1;
