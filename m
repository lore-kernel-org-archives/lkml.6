Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965474AbeEYJrE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:47:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55144 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965212AbeEYJrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:47:02 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] PM / wakeup: Make events_lock a RAW_SPINLOCK
Date: Fri, 25 May 2018 11:46:46 +0200
Message-Id: <20180525094648.15464-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525094648.15464-1-bigeasy@linutronix.de>
References: <20180525094648.15464-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `events_lock' is acquired during suspend while interrupts are
disabled even on RT. The lock is taken only for a very brief moment.
Make it a RAW lock which avoids "sleeping while atomic" warnings on RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/base/power/wakeup.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index ea01621ed769..2e76fbcba76e 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -57,7 +57,7 @@ static void split_counters(unsigned int *cnt, unsigned in=
t *inpr)
 /* A preserved old value of the events counter. */
 static unsigned int saved_count;
=20
-static DEFINE_SPINLOCK(events_lock);
+static DEFINE_RAW_SPINLOCK(events_lock);
=20
 static void pm_wakeup_timer_fn(struct timer_list *t);
=20
@@ -185,9 +185,9 @@ void wakeup_source_add(struct wakeup_source *ws)
 	ws->active =3D false;
 	ws->last_time =3D ktime_get();
=20
-	spin_lock_irqsave(&events_lock, flags);
+	raw_spin_lock_irqsave(&events_lock, flags);
 	list_add_rcu(&ws->entry, &wakeup_sources);
-	spin_unlock_irqrestore(&events_lock, flags);
+	raw_spin_unlock_irqrestore(&events_lock, flags);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_add);
=20
@@ -202,9 +202,9 @@ void wakeup_source_remove(struct wakeup_source *ws)
 	if (WARN_ON(!ws))
 		return;
=20
-	spin_lock_irqsave(&events_lock, flags);
+	raw_spin_lock_irqsave(&events_lock, flags);
 	list_del_rcu(&ws->entry);
-	spin_unlock_irqrestore(&events_lock, flags);
+	raw_spin_unlock_irqrestore(&events_lock, flags);
 	synchronize_srcu(&wakeup_srcu);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_remove);
@@ -843,7 +843,7 @@ bool pm_wakeup_pending(void)
 	unsigned long flags;
 	bool ret =3D false;
=20
-	spin_lock_irqsave(&events_lock, flags);
+	raw_spin_lock_irqsave(&events_lock, flags);
 	if (events_check_enabled) {
 		unsigned int cnt, inpr;
=20
@@ -851,7 +851,7 @@ bool pm_wakeup_pending(void)
 		ret =3D (cnt !=3D saved_count || inpr > 0);
 		events_check_enabled =3D !ret;
 	}
-	spin_unlock_irqrestore(&events_lock, flags);
+	raw_spin_unlock_irqrestore(&events_lock, flags);
=20
 	if (ret) {
 		pr_info("PM: Wakeup pending, aborting suspend\n");
@@ -940,13 +940,13 @@ bool pm_save_wakeup_count(unsigned int count)
 	unsigned long flags;
=20
 	events_check_enabled =3D false;
-	spin_lock_irqsave(&events_lock, flags);
+	raw_spin_lock_irqsave(&events_lock, flags);
 	split_counters(&cnt, &inpr);
 	if (cnt =3D=3D count && inpr =3D=3D 0) {
 		saved_count =3D count;
 		events_check_enabled =3D true;
 	}
-	spin_unlock_irqrestore(&events_lock, flags);
+	raw_spin_unlock_irqrestore(&events_lock, flags);
 	return events_check_enabled;
 }
=20
--=20
2.17.0
