Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757932AbeD0Jeb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:34:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53298 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757917AbeD0Jea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:34:30 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: "Eric W . Biederman " <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] posix-timers: Prevent broadcast signals
Date: Fri, 27 Apr 2018 11:34:26 +0200
Message-Id: <20180427093426.13321-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Posix timers should not send broadcast signals and kernel only
signals. Prevent it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/posix-timers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index b6899b5060bd..4c4cbebb0d71 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -435,6 +435,7 @@ static enum hrtimer_restart posix_timer_fn(struct hrtim=
er *timer)
 static struct pid *good_sigevent(sigevent_t * event)
 {
 	struct task_struct *rtn =3D current->group_leader;
+	int sig =3D event->sigev_signo;
=20
 	switch (event->sigev_notify) {
 	case SIGEV_SIGNAL | SIGEV_THREAD_ID:
@@ -444,7 +445,8 @@ static struct pid *good_sigevent(sigevent_t * event)
 		/* FALLTHRU */
 	case SIGEV_SIGNAL:
 	case SIGEV_THREAD:
-		if (event->sigev_signo <=3D 0 || event->sigev_signo > SIGRTMAX)
+		if (sig <=3D 0 || sig > SIGRTMAX ||
+		    sig_kernel_only(sig) || sig_kernel_coredump(sig))
 			return NULL;
 		/* FALLTHRU */
 	case SIGEV_NONE:
--=20
2.17.0
