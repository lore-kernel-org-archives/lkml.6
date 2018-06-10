Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id b6WPFu6aHFtoBQAAmS7hNA
	; Sun, 10 Jun 2018 05:20:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A57C860795; Sun, 10 Jun 2018 05:20:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id ED3566074D;
	Sun, 10 Jun 2018 05:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED3566074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753680AbeFJFUA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 01:20:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35716 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753529AbeFJFT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 01:19:58 -0400
Received: from [217.76.163.81] (helo=nanos.fritz.box)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fRslh-0007Cu-6y; Sun, 10 Jun 2018 07:19:57 +0200
Date: Sun, 10 Jun 2018 07:19:52 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] core updates for 4.18
Message-ID: <alpine.DEB.2.21.1806100713320.1606@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

A small set of core updates:

 - Make objtool cope with GCC8 oddities some more
 
 - Remove a stale local_irq_save/restore sequence in the signal code along
   with the stale comment in the RCU code. The underlying issue which led
   to this has been solved long time ago, but nobody cared to cleanup the
   hackarounds.

Note: The signal commit was refreshed today to pick up the reworked
changelog and the reviewed/acked-by tags.

Thanks,

	tglx

------------------>
Anna-Maria Gleixner (2):
      rcu: Update documentation of rcu_read_unlock()
      signal: Remove no longer required irqsave/restore

Josh Poimboeuf (1):
      objtool: Fix GCC 8 cold subfunction detection for aliased functions


 include/linux/rcupdate.h |  4 +---
 kernel/signal.c          | 24 +++++++-----------------
 tools/objtool/check.c    | 22 ++++++++++++++++++++++
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index e679b175b411..65163aa0bb04 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -652,9 +652,7 @@ static inline void rcu_read_lock(void)
  * Unfortunately, this function acquires the scheduler's runqueue and
  * priority-inheritance spinlocks.  This means that deadlock could result
  * if the caller of rcu_read_unlock() already holds one of these locks or
- * any lock that is ever acquired while holding them; or any lock which
- * can be taken from interrupt context because rcu_boost()->rt_mutex_lock()
- * does not disable irqs while taking ->wait_lock.
+ * any lock that is ever acquired while holding them.
  *
  * That said, RCU readers are never priority boosted unless they were
  * preempted.  Therefore, one way to avoid deadlock is to make sure
diff --git a/kernel/signal.c b/kernel/signal.c
index 0f865d67415d..8d8a940422a8 100644
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
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3a31b238f885..38047c6aa575 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -543,6 +543,28 @@ static int add_jump_destinations(struct objtool_file *file)
 				  dest_off);
 			return -1;
 		}
+
+		/*
+		 * For GCC 8+, create parent/child links for any cold
+		 * subfunctions.  This is _mostly_ redundant with a similar
+		 * initialization in read_symbols().
+		 *
+		 * If a function has aliases, we want the *first* such function
+		 * in the symbol table to be the subfunction's parent.  In that
+		 * case we overwrite the initialization done in read_symbols().
+		 *
+		 * However this code can't completely replace the
+		 * read_symbols() code because this doesn't detect the case
+		 * where the parent function's only reference to a subfunction
+		 * is through a switch table.
+		 */
+		if (insn->func && insn->jump_dest->func &&
+		    insn->func != insn->jump_dest->func &&
+		    !strstr(insn->func->name, ".cold.") &&
+		    strstr(insn->jump_dest->func->name, ".cold.")) {
+			insn->func->cfunc = insn->jump_dest->func;
+			insn->jump_dest->func->pfunc = insn->func;
+		}
 	}
 
 	return 0;
