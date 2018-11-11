Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73344C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3741A20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3741A20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbeKLFxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:53:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51608 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726637AbeKLFxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:53:33 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtC-0000oP-L2; Sun, 11 Nov 2018 19:59:22 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsO-0001P5-GL; Sun, 11 Nov 2018 19:58:32 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Doug Berger" <opendmb@gmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.18575539@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 038/366] PM / wakeup: Only update last time for
 active wakeup sources
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Doug Berger <opendmb@gmail.com>

commit 2ef7c01c0cdb170142058c6d8fe0697aee4e4d7d upstream.

When wakelock support was added, the wakeup_source_add() function
was updated to set the last_time value of the wakeup source. This
has the unintended side effect of producing confusing output from
pm_print_active_wakeup_sources() when a wakeup source is added
prior to a sleep that is blocked by a different wakeup source.

The function pm_print_active_wakeup_sources() will search for the
most recently active wakeup source when no active source is found.
If a wakeup source is added after a different wakeup source blocks
the system from going to sleep it may have a later last_time value
than the blocking source and be output as the last active wakeup
source even if it has never actually been active.

It looks to me like the change to wakeup_source_add() was made to
prevent the wakelock garbage collection from accidentally dropping
a wakelock during the narrow window between adding the wakelock to
the wakelock list in wakelock_lookup_add() and the activation of
the wakeup source in pm_wake_lock().

This commit changes the behavior so that only the last_time of the
wakeup source used by a wakelock is initialized prior to adding it
to the wakeup source list. This preserves the meaning of the
last_time value as the last time the wakeup source was active and
allows a wakeup source that has never been active to have a
last_time value of 0.

Fixes: b86ff9820fd5 (PM / Sleep: Add user space interface for manipulating wakeup sources, v3)
Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/base/power/wakeup.c | 1 -
 kernel/power/wakelock.c     | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -135,7 +135,6 @@ void wakeup_source_add(struct wakeup_sou
 	spin_lock_init(&ws->lock);
 	setup_timer(&ws->timer, pm_wakeup_timer_fn, (unsigned long)ws);
 	ws->active = false;
-	ws->last_time = ktime_get();
 
 	spin_lock_irqsave(&events_lock, flags);
 	list_add_rcu(&ws->entry, &wakeup_sources);
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -175,6 +175,7 @@ static struct wakelock *wakelock_lookup_
 		return ERR_PTR(-ENOMEM);
 	}
 	wl->ws.name = wl->name;
+	wl->ws.last_time = ktime_get();
 	wakeup_source_add(&wl->ws);
 	rb_link_node(&wl->node, parent, node);
 	rb_insert_color(&wl->node, &wakelocks_tree);

