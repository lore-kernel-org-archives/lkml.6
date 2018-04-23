Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755947AbeDWQaQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:30:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53894 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755608AbeDWQ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:29:37 -0400
Message-Id: <20180423162642.218493878@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 23 Apr 2018 18:16:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        diego.viola@gmail.com, len.brown@intel.com, rjw@rjwysocki.net,
        rui.zhang@intel.com
Subject: [PATCH 5/5] clocksource: Consistent de-rate when marking unstable
References: <20180423161648.622657048@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-tsc-early-fix-5.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we mark a registered clocksource unstable the watchdog_kthread
will de-rate and re-select the clocksource. Ensure we also de-rate
when getting called on an unregistered clocksource.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/clocksource.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -152,12 +152,19 @@ static void __clocksource_unstable(struc
 	cs->flags &= ~(CLOCK_SOURCE_VALID_FOR_HRES | CLOCK_SOURCE_WATCHDOG);
 	cs->flags |= CLOCK_SOURCE_UNSTABLE;
 
-	if (list_empty(&cs->list))
+	/*
+	 * If the clocksource is registered clocksource_watchdog_kthread() will
+	 * re-rate and re-select.
+	 */
+	if (list_empty(&cs->list)) {
+		cs->rating = 0;
 		return;
+	}
 
 	if (cs->mark_unstable)
 		cs->mark_unstable(cs);
 
+	/* kick clocksource_watchdog_kthread() */
 	if (finished_booting)
 		schedule_work(&watchdog_work);
 }
