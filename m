Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965245AbeEYJFp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:05:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55000 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965078AbeEYJFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:05:41 -0400
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, bigeasy@linutronix.de, paulmck@linux.vnet.ibm.com,
        ebiederm@xmission.com, Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH v2 2/2] signal: Remove no longer required irqsave/restore
Date: Fri, 25 May 2018 11:05:07 +0200
Message-Id: <20180525090507.22248-3-anna-maria@linutronix.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180525090507.22248-1-anna-maria@linutronix.de>
References: <20180525090507.22248-1-anna-maria@linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a841796f11c9 ("signal: align __lock_task_sighand() irq disabling and
RCU") introduced a rcu read side critical section with interrupts
disabled. The changelog suggested that a better long-term fix would be "to
make rt_mutex_unlock() disable irqs when acquiring the rt_mutex structure's
->wait_lock".

This long-term fix has been made in commit b4abf91047cf ("rtmutex: Make
wait_lock irq safe") for a different reason.

Therefore revert commit a841796f11c9 ("signal: align >
__lock_task_sighand() irq disabling and RCU") as the interrupt disable
dance is not longer required.

The change was tested on the base of b4abf91047cf ("rtmutex: Make wait_lock
irq safe") with a four hour run of rcutorture scenario TREE03 with lockdep
enabled as suggested by Paul McKenney.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/signal.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 9c33163a6165..19679ad77aa6 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1244,19 +1244,12 @@ struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
 {
 	struct sighand_struct *sighand;
 
+	rcu_read_lock();
 	for (;;) {
-		/*
-		 * Disable interrupts early to avoid deadlocks.
-		 * See rcu_read_unlock() comment header for details.
-		 */
-		local_irq_save(*flags);
-		rcu_read_lock();
 		sighand = rcu_dereference(tsk->sighand);
-		if (unlikely(sighand == NULL)) {
-			rcu_read_unlock();
-			local_irq_restore(*flags);
+		if (unlikely(sighand == NULL))
 			break;
-		}
+
 		/*
 		 * This sighand can be already freed and even reused, but
 		 * we rely on SLAB_TYPESAFE_BY_RCU and sighand_ctor() which
@@ -1268,15 +1261,12 @@ struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
 		 * __exit_signal(). In the latter case the next iteration
 		 * must see ->sighand == NULL.
 		 */
-		spin_lock(&sighand->siglock);
-		if (likely(sighand == tsk->sighand)) {
-			rcu_read_unlock();
+		spin_lock_irqsave(&sighand->siglock, *flags);
+		if (likely(sighand == tsk->sighand))
 			break;
-		}
-		spin_unlock(&sighand->siglock);
-		rcu_read_unlock();
-		local_irq_restore(*flags);
+		spin_unlock_irqrestore(&sighand->siglock, *flags);
 	}
+	rcu_read_unlock();
 
 	return sighand;
 }
-- 
2.15.1
