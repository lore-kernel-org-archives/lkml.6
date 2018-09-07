Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CC3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAE62075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAE62075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeIHBoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbeIHBmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:42:13 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BACAA2086B;
        Fri,  7 Sep 2018 20:59:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fyNqk-0001k7-JU; Fri, 07 Sep 2018 16:59:30 -0400
Message-Id: <20180907205930.506114347@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 07 Sep 2018 16:59:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: [PATCH RT 05/24] PM / wakeup: Make events_lock a RAW_SPINLOCK
References: <20180907205857.262840394@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.63-rt41-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 1debb85a1d7d5c7655b4574f5b0ddf5f7c84873e ]

The `events_lock' is acquired during suspend while interrupts are
disabled even on RT. The lock is taken only for a very brief moment.
Make it a RAW lock which avoids "sleeping while atomic" warnings on RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/base/power/wakeup.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index cdd6f256da59..2269d379c92f 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -52,7 +52,7 @@ static void split_counters(unsigned int *cnt, unsigned int *inpr)
 /* A preserved old value of the events counter. */
 static unsigned int saved_count;
 
-static DEFINE_SPINLOCK(events_lock);
+static DEFINE_RAW_SPINLOCK(events_lock);
 
 static void pm_wakeup_timer_fn(unsigned long data);
 
@@ -180,9 +180,9 @@ void wakeup_source_add(struct wakeup_source *ws)
 	ws->active = false;
 	ws->last_time = ktime_get();
 
-	spin_lock_irqsave(&events_lock, flags);
+	raw_spin_lock_irqsave(&events_lock, flags);
 	list_add_rcu(&ws->entry, &wakeup_sources);
-	spin_unlock_irqrestore(&events_lock, flags);
+	raw_spin_unlock_irqrestore(&events_lock, flags);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_add);
 
@@ -197,9 +197,9 @@ void wakeup_source_remove(struct wakeup_source *ws)
 	if (WARN_ON(!ws))
 		return;
 
-	spin_lock_irqsave(&events_lock, flags);
+	raw_spin_lock_irqsave(&events_lock, flags);
 	list_del_rcu(&ws->entry);
-	spin_unlock_irqrestore(&events_lock, flags);
+	raw_spin_unlock_irqrestore(&events_lock, flags);
 	synchronize_srcu(&wakeup_srcu);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_remove);
@@ -844,7 +844,7 @@ bool pm_wakeup_pending(void)
 	unsigned long flags;
 	bool ret = false;
 
-	spin_lock_irqsave(&events_lock, flags);
+	raw_spin_lock_irqsave(&events_lock, flags);
 	if (events_check_enabled) {
 		unsigned int cnt, inpr;
 
@@ -852,7 +852,7 @@ bool pm_wakeup_pending(void)
 		ret = (cnt != saved_count || inpr > 0);
 		events_check_enabled = !ret;
 	}
-	spin_unlock_irqrestore(&events_lock, flags);
+	raw_spin_unlock_irqrestore(&events_lock, flags);
 
 	if (ret) {
 		pr_info("PM: Wakeup pending, aborting suspend\n");
@@ -941,13 +941,13 @@ bool pm_save_wakeup_count(unsigned int count)
 	unsigned long flags;
 
 	events_check_enabled = false;
-	spin_lock_irqsave(&events_lock, flags);
+	raw_spin_lock_irqsave(&events_lock, flags);
 	split_counters(&cnt, &inpr);
 	if (cnt == count && inpr == 0) {
 		saved_count = count;
 		events_check_enabled = true;
 	}
-	spin_unlock_irqrestore(&events_lock, flags);
+	raw_spin_unlock_irqrestore(&events_lock, flags);
 	return events_check_enabled;
 }
 
-- 
2.18.0


