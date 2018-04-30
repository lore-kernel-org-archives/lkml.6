Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753558AbeD3KFd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 06:05:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60114 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752768AbeD3KEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 06:04:47 -0400
Message-Id: <20180430100344.594904898@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 30 Apr 2018 12:00:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        diego.viola@gmail.com, len.brown@intel.com, rjw@rjwysocki.net,
        rui.zhang@intel.com
Subject: [PATCH v2 5/7] clocksource: Consistent de-rate when marking unstable
References: <20180430100008.503783478@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-tsc-early-fix-5.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a registered clocksource gets marked unstable the watchdog_kthread
will de-rate and re-select the clocksource. Ensure it also de-rates
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
