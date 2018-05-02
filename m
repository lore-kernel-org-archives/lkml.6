Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeEBOOq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:14:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56939 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbeEBOOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:14:41 -0400
Date: Wed, 2 May 2018 07:14:21 -0700
From: tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-e3b4f79025e0a4eb7e2a2c7d24dadfa1e38893b0@git.kernel.org>
Cc: peterz@infradead.org, rafael.j.wysocki@intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        diego.viola@gmail.com, mingo@kernel.org, hpa@zytor.com
Reply-To: mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        diego.viola@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com
In-Reply-To: <20180430100344.533326547@infradead.org>
References: <20180430100344.533326547@infradead.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] x86/tsc: Fix mark_tsc_unstable()
Git-Commit-ID: e3b4f79025e0a4eb7e2a2c7d24dadfa1e38893b0
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

Commit-ID:  e3b4f79025e0a4eb7e2a2c7d24dadfa1e38893b0
Gitweb:     https://git.kernel.org/tip/e3b4f79025e0a4eb7e2a2c7d24dadfa1e38893b0
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 30 Apr 2018 12:00:12 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 2 May 2018 16:10:40 +0200

x86/tsc: Fix mark_tsc_unstable()

mark_tsc_unstable() also needs to affect tsc_early, Now that
clocksource_mark_unstable() can be used on a clocksource irrespective of
its registration state, use it on both tsc_early and tsc.

This does however require cs->list to be initialized empty, otherwise it
cannot tell the registation state before registation.

Fixes: aa83c45762a2 ("x86/tsc: Introduce early tsc clocksource")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Diego Viola <diego.viola@gmail.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: len.brown@intel.com
Cc: rjw@rjwysocki.net
Cc: rui.zhang@intel.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180430100344.533326547@infradead.org

---
 arch/x86/kernel/tsc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 23f36bc236ba..74392d9d51e0 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1067,6 +1067,7 @@ static struct clocksource clocksource_tsc_early = {
 	.resume			= tsc_resume,
 	.mark_unstable		= tsc_cs_mark_unstable,
 	.tick_stable		= tsc_cs_tick_stable,
+	.list			= LIST_HEAD_INIT(clocksource_tsc_early.list),
 };
 
 /*
@@ -1086,6 +1087,7 @@ static struct clocksource clocksource_tsc = {
 	.resume			= tsc_resume,
 	.mark_unstable		= tsc_cs_mark_unstable,
 	.tick_stable		= tsc_cs_tick_stable,
+	.list			= LIST_HEAD_INIT(clocksource_tsc.list),
 };
 
 void mark_tsc_unstable(char *reason)
@@ -1098,13 +1100,9 @@ void mark_tsc_unstable(char *reason)
 		clear_sched_clock_stable();
 	disable_sched_clock_irqtime();
 	pr_info("Marking TSC unstable due to %s\n", reason);
-	/* Change only the rating, when not registered */
-	if (clocksource_tsc.mult) {
-		clocksource_mark_unstable(&clocksource_tsc);
-	} else {
-		clocksource_tsc.flags |= CLOCK_SOURCE_UNSTABLE;
-		clocksource_tsc.rating = 0;
-	}
+
+	clocksource_mark_unstable(&clocksource_tsc_early);
+	clocksource_mark_unstable(&clocksource_tsc);
 }
 
 EXPORT_SYMBOL_GPL(mark_tsc_unstable);
