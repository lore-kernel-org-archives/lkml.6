Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753335AbeD3KE6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 06:04:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60124 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753029AbeD3KEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 06:04:50 -0400
Message-Id: <20180430100344.533326547@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 30 Apr 2018 12:00:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        diego.viola@gmail.com, len.brown@intel.com, rjw@rjwysocki.net,
        rui.zhang@intel.com, stable@kernel.org
Subject: [PATCH v2 4/7] x86,tsc: Fix mark_tsc_unstable()
References: <20180430100008.503783478@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-tsc-early-fix-4.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mark_tsc_unstable() also needs to affect tsc_early, Now that
clocksource_mark_unstable() can be used on a clocksource irrespective
of its registration state, use it on both tsc_early and tsc.

This does however require cs->list to be initialized empty, otherwise
it cannot tell the registation state before registation.

Tested-by: Diego Viola <diego.viola@gmail.com>
Fixes: aa83c45762a2 ("x86/tsc: Introduce early tsc clocksource")
Cc: stable@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/tsc.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1067,6 +1067,7 @@ static struct clocksource clocksource_ts
 	.resume			= tsc_resume,
 	.mark_unstable		= tsc_cs_mark_unstable,
 	.tick_stable		= tsc_cs_tick_stable,
+	.list			= LIST_HEAD_INIT(clocksource_tsc_early.list),
 };
 
 /*
@@ -1086,6 +1087,7 @@ static struct clocksource clocksource_ts
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
