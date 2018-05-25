Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965513AbeEYJrG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:47:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55145 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965197AbeEYJrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:47:02 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] PM / wakeup: Make s2idle_lock a RAW_SPINLOCK
Date: Fri, 25 May 2018 11:46:48 +0200
Message-Id: <20180525094648.15464-5-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525094648.15464-1-bigeasy@linutronix.de>
References: <20180525094648.15464-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `s2idle_lock' is acquired during suspend while interrupts are
disabled even on RT. The lock is acquired for short sections only.
Make it a RAW lock which avoids "sleeping while atomic" warnings on RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/power/suspend.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index f865aa934835..ca2abb5e5109 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -61,7 +61,7 @@ static const struct platform_s2idle_ops *s2idle_ops;
 static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
=20
 enum s2idle_states __read_mostly s2idle_state;
-static DEFINE_SPINLOCK(s2idle_lock);
+static DEFINE_RAW_SPINLOCK(s2idle_lock);
=20
 void s2idle_set_ops(const struct platform_s2idle_ops *ops)
 {
@@ -79,12 +79,12 @@ static void s2idle_enter(void)
 {
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, true);
=20
-	spin_lock_irq(&s2idle_lock);
+	raw_spin_lock_irq(&s2idle_lock);
 	if (pm_wakeup_pending())
 		goto out;
=20
 	s2idle_state =3D S2IDLE_STATE_ENTER;
-	spin_unlock_irq(&s2idle_lock);
+	raw_spin_unlock_irq(&s2idle_lock);
=20
 	get_online_cpus();
 	cpuidle_resume();
@@ -98,11 +98,11 @@ static void s2idle_enter(void)
 	cpuidle_pause();
 	put_online_cpus();
=20
-	spin_lock_irq(&s2idle_lock);
+	raw_spin_lock_irq(&s2idle_lock);
=20
  out:
 	s2idle_state =3D S2IDLE_STATE_NONE;
-	spin_unlock_irq(&s2idle_lock);
+	raw_spin_unlock_irq(&s2idle_lock);
=20
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, false);
 }
@@ -159,12 +159,12 @@ void s2idle_wake(void)
 {
 	unsigned long flags;
=20
-	spin_lock_irqsave(&s2idle_lock, flags);
+	raw_spin_lock_irqsave(&s2idle_lock, flags);
 	if (s2idle_state > S2IDLE_STATE_NONE) {
 		s2idle_state =3D S2IDLE_STATE_WAKE;
 		swake_up(&s2idle_wait_head);
 	}
-	spin_unlock_irqrestore(&s2idle_lock, flags);
+	raw_spin_unlock_irqrestore(&s2idle_lock, flags);
 }
 EXPORT_SYMBOL_GPL(s2idle_wake);
=20
--=20
2.17.0
