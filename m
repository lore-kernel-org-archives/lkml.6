Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752994AbeCPOVk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:21:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55947 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751575AbeCPOVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:21:39 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RT PATCH 2/2] Revert "cpu_chill: Add a UNINTERRUPTIBLE hrtimer_nanosleep"
Date: Fri, 16 Mar 2018 15:21:35 +0100
Message-Id: <20180316142135.9664-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316142135.9664-1-bigeasy@linutronix.de>
References: <20180316142135.9664-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit "cpu_chill: Add a UNINTERRUPTIBLE
hrtimer_nanosleep". Since cpu_chill() is now using schedule_hrtimeout()
we can remove that change since we have no users for it.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/hrtimer.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index c0efc22ba635..ce2c2d04cbaa 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1742,13 +1742,12 @@ int nanosleep_copyout(struct restart_block *restart=
, struct timespec64 *ts)
 	return -ERESTART_RESTARTBLOCK;
 }
=20
-static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mo=
de mode,
-				unsigned long state)
+static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mo=
de mode)
 {
 	struct restart_block *restart;
=20
 	do {
-		set_current_state(state);
+		set_current_state(TASK_INTERRUPTIBLE);
 		hrtimer_start_expires(&t->timer, mode);
=20
 		if (likely(t->task))
@@ -1786,15 +1785,13 @@ static long __sched hrtimer_nanosleep_restart(struc=
t restart_block *restart)
 	hrtimer_init_sleeper_on_stack(&t, restart->nanosleep.clockid,
 				      HRTIMER_MODE_ABS, current);
 	hrtimer_set_expires_tv64(&t.timer, restart->nanosleep.expires);
-	/* cpu_chill() does not care about restart state. */
-	ret =3D do_nanosleep(&t, HRTIMER_MODE_ABS, TASK_INTERRUPTIBLE);
+	ret =3D do_nanosleep(&t, HRTIMER_MODE_ABS);
 	destroy_hrtimer_on_stack(&t.timer);
 	return ret;
 }
=20
-static long __hrtimer_nanosleep(const struct timespec64 *rqtp,
-				const enum hrtimer_mode mode, const clockid_t clockid,
-				unsigned long state)
+long hrtimer_nanosleep(const struct timespec64 *rqtp,
+		       const enum hrtimer_mode mode, const clockid_t clockid)
 {
 	struct restart_block *restart;
 	struct hrtimer_sleeper t;
@@ -1807,7 +1804,7 @@ static long __hrtimer_nanosleep(const struct timespec=
64 *rqtp,
=20
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode, current);
 	hrtimer_set_expires_range_ns(&t.timer, timespec64_to_ktime(*rqtp), slack);
-	ret =3D do_nanosleep(&t, mode, state);
+	ret =3D do_nanosleep(&t, mode);
 	if (ret !=3D -ERESTART_RESTARTBLOCK)
 		goto out;
=20
@@ -1826,12 +1823,6 @@ static long __hrtimer_nanosleep(const struct timespe=
c64 *rqtp,
 	return ret;
 }
=20
-long hrtimer_nanosleep(const struct timespec64 *rqtp,
-		       const enum hrtimer_mode mode, const clockid_t clockid)
-{
-	return __hrtimer_nanosleep(rqtp, mode, clockid, TASK_INTERRUPTIBLE);
-}
-
 SYSCALL_DEFINE2(nanosleep, struct timespec __user *, rqtp,
 		struct timespec __user *, rmtp)
 {
--=20
2.16.2
