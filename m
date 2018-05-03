Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751603AbeECJ01 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:26:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51219 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbeECJ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:26:23 -0400
Date: Thu, 3 May 2018 02:25:28 -0700
From: tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-457be908c83637ee10bda085a23dc05afa3b14a0@git.kernel.org>
Cc: mingo@kernel.org, hpa@zytor.com, paulmck@linux.vnet.ibm.com,
        hkallweit1@gmail.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        geert+renesas@glider.be, vincent.guittot@linaro.org,
        peterz@infradead.org, torvalds@linux-foundation.org
Reply-To: hkallweit1@gmail.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        torvalds@linux-foundation.org, geert+renesas@glider.be,
        vincent.guittot@linaro.org
In-Reply-To: <20180426103133.GA6953@linaro.org>
References: <20180426103133.GA6953@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/fair: Fix the update of blocked load when
 newly idle
Git-Commit-ID: 457be908c83637ee10bda085a23dc05afa3b14a0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  457be908c83637ee10bda085a23dc05afa3b14a0
Gitweb:     https://git.kernel.org/tip/457be908c83637ee10bda085a23dc05afa3b14a0
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Thu, 26 Apr 2018 12:19:32 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 3 May 2018 07:38:03 +0200

sched/fair: Fix the update of blocked load when newly idle

With commit:

  31e77c93e432 ("sched/fair: Update blocked load when newly idle")

... we release the rq->lock when updating blocked load of idle CPUs.

This opens a time window during which another CPU can add a task to this
CPU's cfs_rq.

The check for newly added task of idle_balance() is not in the common path.
Move the out label to include this check.

Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 31e77c93e432 ("sched/fair: Update blocked load when newly idle")
Link: http://lkml.kernel.org/r/20180426103133.GA6953@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 54dc31e7ab9b..e3002e5ada31 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9847,6 +9847,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (curr_cost > this_rq->max_idle_balance_cost)
 		this_rq->max_idle_balance_cost = curr_cost;
 
+out:
 	/*
 	 * While browsing the domains, we released the rq lock, a task could
 	 * have been enqueued in the meantime. Since we're not going idle,
@@ -9855,7 +9856,6 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (this_rq->cfs.h_nr_running && !pulled_task)
 		pulled_task = 1;
 
-out:
 	/* Move the next balance forward */
 	if (time_after(this_rq->next_balance, next_balance))
 		this_rq->next_balance = next_balance;
