Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752967AbeC1KH6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 06:07:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50185 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752754AbeC1KHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 06:07:55 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        stable-rt@vger.kernel.org
Subject: [PATCH RT 2/3] posix-timers: user proper timer while waiting for alarmtimer
Date: Wed, 28 Mar 2018 12:07:45 +0200
Message-Id: <20180328100746.18668-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180328100746.18668-1-bigeasy@linutronix.de>
References: <20180328100746.18668-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On RT the timer can be preempted while running and therefore we wait
with timer_wait_for_callback() for the timer to complete (instead of
busy looping).
The POSIX timer has an hrtimer underneath and this hrtimer is used to
wait for its completion. The alartimer has also an hrtimer but at a
different location.

Instead of checking for ->timer_set which is the same for the alarmtimer
and the "posix-timers" I instead check for ->arm which is only used by
the "posix-timers". To match the alarmtimer I check for the alarm_clock
struct.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/posix-timers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 0b568087bd64..8a16cb8f684a 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -802,8 +802,10 @@ SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 static void timer_wait_for_callback(const struct k_clock *kc, struct k_iti=
mer *timr)
 {
 #ifdef CONFIG_PREEMPT_RT_FULL
-	if (kc->timer_set =3D=3D common_timer_set)
+	if (kc->arm =3D=3D common_hrtimer_arm)
 		hrtimer_wait_for_timer(&timr->it.real.timer);
+	else if (kc =3D=3D alarm_clock)
+		hrtimer_wait_for_timer(&timr->it.alarm.alarmtimer.timer);
 	else
 		/* FIXME: Whacky hack for posix-cpu-timers */
 		schedule_timeout(1);
--=20
2.16.3
