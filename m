Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbeEDOkV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:40:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41003 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEDOkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:40:20 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, "Eric W. Biederman" <ebiederm@xmission.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] kernel/signal: Remove no longer required irqsave/restore
Date: Fri,  4 May 2018 16:40:14 +0200
Message-Id: <20180504144014.5378-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

Commit a841796f11c9 ("signal: align __lock_task_sighand() irq disabling and
RCU") introduced a rcu read side critical section with interrupts
disabled. The changelog suggested that a better long-term fix would be "to
make rt_mutex_unlock() disable irqs when acquiring the rt_mutex structure's
->wait_lock".

This long-term fix has been made in commit 4abf91047cf ("rtmutex: Make >
wait_lock irq safe") for different reason.

Therefore revert commit a841796f11c9 ("signal: align >
__lock_task_sighand() irq disabling and RCU") as the interrupt disable
dance is not longer required.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/signal.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index c6e4c83dc090..16b87c54d027 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1244,19 +1244,12 @@ struct sighand_struct *__lock_task_sighand(struct t=
ask_struct *tsk,
 {
 	struct sighand_struct *sighand;
=20
+	rcu_read_lock();
 	for (;;) {
-		/*
-		 * Disable interrupts early to avoid deadlocks.
-		 * See rcu_read_unlock() comment header for details.
-		 */
-		local_irq_save(*flags);
-		rcu_read_lock();
 		sighand =3D rcu_dereference(tsk->sighand);
-		if (unlikely(sighand =3D=3D NULL)) {
-			rcu_read_unlock();
-			local_irq_restore(*flags);
+		if (unlikely(sighand =3D=3D NULL))
 			break;
-		}
+
 		/*
 		 * This sighand can be already freed and even reused, but
 		 * we rely on SLAB_TYPESAFE_BY_RCU and sighand_ctor() which
@@ -1268,15 +1261,12 @@ struct sighand_struct *__lock_task_sighand(struct t=
ask_struct *tsk,
 		 * __exit_signal(). In the latter case the next iteration
 		 * must see ->sighand =3D=3D NULL.
 		 */
-		spin_lock(&sighand->siglock);
-		if (likely(sighand =3D=3D tsk->sighand)) {
-			rcu_read_unlock();
+		spin_lock_irqsave(&sighand->siglock, *flags);
+		if (likely(sighand =3D=3D tsk->sighand))
 			break;
-		}
-		spin_unlock(&sighand->siglock);
-		rcu_read_unlock();
-		local_irq_restore(*flags);
+		spin_unlock_irqrestore(&sighand->siglock, *flags);
 	}
+	rcu_read_unlock();
=20
 	return sighand;
 }
--=20
2.17.0
