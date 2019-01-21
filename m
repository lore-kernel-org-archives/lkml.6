Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF501C7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BE020663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfAULZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:25:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51897 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfAULZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:25:57 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LBPiHY2495707
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 03:25:44 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LBPilc2495704;
        Mon, 21 Jan 2019 03:25:44 -0800
Date:   Mon, 21 Jan 2019 03:25:44 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Prateek Sood <tipbot@zytor.com>
Message-ID: <tip-6dc080eeb2ba01973bfff0d79844d7a59e12542e@git.kernel.org>
Cc:     prsood@codeaurora.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, dbueso@suse.de,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        andrea.parri@amarulasolutions.com, hpa@zytor.com,
        peterz@infradead.org
Reply-To: prsood@codeaurora.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, andrea.parri@amarulasolutions.com,
          peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de,
          dbueso@suse.de, torvalds@linux-foundation.org
In-Reply-To: <1543590656-7157-1-git-send-email-prsood@codeaurora.org>
References: <1543590656-7157-1-git-send-email-prsood@codeaurora.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] sched/wait: Fix rcuwait_wake_up() ordering
Git-Commit-ID: 6dc080eeb2ba01973bfff0d79844d7a59e12542e
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

Commit-ID:  6dc080eeb2ba01973bfff0d79844d7a59e12542e
Gitweb:     https://git.kernel.org/tip/6dc080eeb2ba01973bfff0d79844d7a59e12542e
Author:     Prateek Sood <prsood@codeaurora.org>
AuthorDate: Fri, 30 Nov 2018 20:40:56 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 11:15:36 +0100

sched/wait: Fix rcuwait_wake_up() ordering

For some peculiar reason rcuwait_wake_up() has the right barrier in
the comment, but not in the code.

This mistake has been observed to cause a deadlock in the following
situation:

    P1					P2

    percpu_up_read()			percpu_down_write()
      rcu_sync_is_idle() // false
					  rcu_sync_enter()
					  ...
      __percpu_up_read()

[S] ,-  __this_cpu_dec(*sem->read_count)
    |   smp_rmb();
[L] |   task = rcu_dereference(w->task) // NULL
    |
    |				    [S]	    w->task = current
    |					    smp_mb();
    |				    [L]	    readers_active_check() // fail
    `-> <store happens here>

Where the smp_rmb() (obviously) fails to constrain the store.

[ peterz: Added changelog. ]

Signed-off-by: Prateek Sood <prsood@codeaurora.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 8f95c90ceb54 ("sched/wait, RCU: Introduce rcuwait machinery")
Link: https://lkml.kernel.org/r/1543590656-7157-1-git-send-email-prsood@codeaurora.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 284f2fe9a293..3fb7be001964 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -307,7 +307,7 @@ void rcuwait_wake_up(struct rcuwait *w)
 	 *        MB (A)	      MB (B)
 	 *    [L] cond		  [L] tsk
 	 */
-	smp_rmb(); /* (B) */
+	smp_mb(); /* (B) */
 
 	/*
 	 * Avoid using task_rcu_dereference() magic as long as we are careful,
