Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeEDP0G (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:26:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41189 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbeEDP0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:26:05 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] posix-cpu-timers: remove lockdep_assert_irqs_disabled()
Date: Fri,  4 May 2018 17:25:48 +0200
Message-Id: <20180504152548.7166-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lockdep_assert_irqs_disabled() was a BUG_ON() statement in the
beginning and it was added just before the "spin_lock(siglock)"
statement to ensure this lock was taken with disabled interrupts.
This is no longer the case: the siglock is acquired via
lock_task_sighand() and this function already disables the interrupts.
The lock is also acquired before this "lockdep_assert_irqs_disabled" so
it is beset to remove it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/posix-cpu-timers.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 2541bd89f20e..d4f54df9c9fa 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -604,7 +604,6 @@ static int posix_cpu_timer_set(struct k_itimer *timer, =
int timer_flags,
 	/*
 	 * Disarm any old timer after extracting its expiry time.
 	 */
-	lockdep_assert_irqs_disabled();
=20
 	ret =3D 0;
 	old_incr =3D timer->it.cpu.incr;
@@ -1049,7 +1048,6 @@ static void posix_cpu_timer_rearm(struct k_itimer *ti=
mer)
 	/*
 	 * Now re-arm for the new expiry time.
 	 */
-	lockdep_assert_irqs_disabled();
 	arm_timer(timer);
 unlock:
 	unlock_task_sighand(p, &flags);
--=20
2.17.0
