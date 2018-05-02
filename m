Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbeEBOPO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:15:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38769 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbeEBOPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:15:12 -0400
Date: Wed, 2 May 2018 07:14:52 -0700
From: tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-cd2af07d823e5287cd6c91d54337348c2a873462@git.kernel.org>
Cc: peterz@infradead.org, rafael.j.wysocki@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, rafael.j.wysocki@intel.com, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20180430100344.594904898@infradead.org>
References: <20180430100344.594904898@infradead.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] clocksource: Consistent de-rate when marking
 unstable
Git-Commit-ID: cd2af07d823e5287cd6c91d54337348c2a873462
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

Commit-ID:  cd2af07d823e5287cd6c91d54337348c2a873462
Gitweb:     https://git.kernel.org/tip/cd2af07d823e5287cd6c91d54337348c2a873462
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 30 Apr 2018 12:00:13 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 2 May 2018 16:10:41 +0200

clocksource: Consistent de-rate when marking unstable

When a registered clocksource gets marked unstable the watchdog_kthread
will de-rate and re-select the clocksource. Ensure it also de-rates
when getting called on an unregistered clocksource.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: len.brown@intel.com
Cc: rjw@rjwysocki.net
Cc: diego.viola@gmail.com
Cc: rui.zhang@intel.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180430100344.594904898@infradead.org

---
 kernel/time/clocksource.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 935f39eb8aac..605656df16c4 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -152,12 +152,19 @@ static void __clocksource_unstable(struct clocksource *cs)
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
