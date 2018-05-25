Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965405AbeEYJrD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:47:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55143 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965130AbeEYJrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:47:02 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] PM / s2idle: Make s2idle_wait_head swait based
Date: Fri, 25 May 2018 11:46:47 +0200
Message-Id: <20180525094648.15464-4-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525094648.15464-1-bigeasy@linutronix.de>
References: <20180525094648.15464-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s2idle_wait_head is used during s2idle with interrupts disabled even on
RT. There is no "custom" wake up function so swait could be used instead
which is also lower weight compared to the wait_queue.
Make s2idle_wait_head a swait_queue_head.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/power/suspend.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 9108a99878bf..f865aa934835 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -27,6 +27,7 @@
 #include <linux/export.h>
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
+#include <linux/swait.h>
 #include <linux/ftrace.h>
 #include <trace/events/power.h>
 #include <linux/compiler.h>
@@ -57,7 +58,7 @@ EXPORT_SYMBOL_GPL(pm_suspend_global_flags);
=20
 static const struct platform_suspend_ops *suspend_ops;
 static const struct platform_s2idle_ops *s2idle_ops;
-static DECLARE_WAIT_QUEUE_HEAD(s2idle_wait_head);
+static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
=20
 enum s2idle_states __read_mostly s2idle_state;
 static DEFINE_SPINLOCK(s2idle_lock);
@@ -91,8 +92,8 @@ static void s2idle_enter(void)
 	/* Push all the CPUs into the idle loop. */
 	wake_up_all_idle_cpus();
 	/* Make the current CPU wait so it can enter the idle loop too. */
-	wait_event(s2idle_wait_head,
-		   s2idle_state =3D=3D S2IDLE_STATE_WAKE);
+	swait_event(s2idle_wait_head,
+		    s2idle_state =3D=3D S2IDLE_STATE_WAKE);
=20
 	cpuidle_pause();
 	put_online_cpus();
@@ -161,7 +162,7 @@ void s2idle_wake(void)
 	spin_lock_irqsave(&s2idle_lock, flags);
 	if (s2idle_state > S2IDLE_STATE_NONE) {
 		s2idle_state =3D S2IDLE_STATE_WAKE;
-		wake_up(&s2idle_wait_head);
+		swake_up(&s2idle_wait_head);
 	}
 	spin_unlock_irqrestore(&s2idle_lock, flags);
 }
--=20
2.17.0
