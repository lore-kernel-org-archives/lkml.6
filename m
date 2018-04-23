Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755961AbeDWQaU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:30:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53890 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755549AbeDWQ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:29:37 -0400
Message-Id: <20180423162642.166624284@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 23 Apr 2018 18:16:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        diego.viola@gmail.com, len.brown@intel.com, rjw@rjwysocki.net,
        rui.zhang@intel.com
Subject: [PATCH 4/5] x86,tsc: Fix mark_tsc_unstable()
References: <20180423161648.622657048@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-tsc-early-fix-4.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mark_tsc_unstable() also needs to affect tsc_early, now that we can
use clocksource_mark_unstable() on a clocksource irrespective of its
registation state, use it on both tsc_early and tsc.

This does however require we initialize cs->list to empty.

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
