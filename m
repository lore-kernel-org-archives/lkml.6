Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753135AbeCPOVt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:21:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55948 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753119AbeCPOVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:21:47 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RT PATCH 1/2] kernel/cpu_chill: use schedule_hrtimeout()
Date: Fri, 16 Mar 2018 15:21:34 +0100
Message-Id: <20180316142135.9664-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_chill() uses __hrtimer_nanosleep() with a hack to get
TASK_UNINTERRUPTIBLE state. It seems to work but it does not.
The problem is that we may have a signal pending and receive a sporadic
wake up _before_ the timer expires. At that point the code will look at
->restart_block and use it based on its value from the previous syscall
resulting in a possible copy-to-user.
Instead all this trouble, we could use schedule_hrtimeout() which is not
an user-space interface and does not have this side effects.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/hrtimer.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 6c77643eaf02..c0efc22ba635 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1873,14 +1873,13 @@ COMPAT_SYSCALL_DEFINE2(nanosleep, struct compat_tim=
espec __user *, rqtp,
  */
 void cpu_chill(void)
 {
-	struct timespec64 tu =3D {
-		.tv_nsec =3D NSEC_PER_MSEC,
-	};
+	ktime_t chill_time;
 	unsigned int freeze_flag =3D current->flags & PF_NOFREEZE;
=20
+	chill_time =3D ktime_set(0, NSEC_PER_MSEC);
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	current->flags |=3D PF_NOFREEZE;
-	__hrtimer_nanosleep(&tu, HRTIMER_MODE_REL_HARD, CLOCK_MONOTONIC,
-			    TASK_UNINTERRUPTIBLE);
+	schedule_hrtimeout(&chill_time, HRTIMER_MODE_REL_HARD);
 	if (!freeze_flag)
 		current->flags &=3D ~PF_NOFREEZE;
 }
--=20
2.16.2
