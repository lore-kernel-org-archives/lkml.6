Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +ZsSLM6mHFt+bgAAmS7hNA
	; Sun, 10 Jun 2018 04:19:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9F81A60795; Sun, 10 Jun 2018 04:19:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0B7036074D;
	Sun, 10 Jun 2018 04:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B7036074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753725AbeFJETX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 00:19:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42499 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753698AbeFJETV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 00:19:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5A4JFtb3241697
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 9 Jun 2018 21:19:15 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5A4JEYh3241694;
        Sat, 9 Jun 2018 21:19:14 -0700
Date: Sat, 9 Jun 2018 21:19:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Anna-Maria Gleixner <tipbot@zytor.com>
Message-ID: <tip-59dc6f3c6d81c0c4379025c4eb56919391d62b67@git.kernel.org>
Cc: mingo@kernel.org, ebiederm@xmission.com, anna-maria@linutronix.de,
        hpa@zytor.com, paulmck@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, hpa@zytor.com, ebiederm@xmission.com,
          anna-maria@linutronix.de, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com
In-Reply-To: <20180525090507.22248-3-anna-maria@linutronix.de>
References: <20180525090507.22248-3-anna-maria@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] signal: Remove no longer required irqsave/restore
Git-Commit-ID: 59dc6f3c6d81c0c4379025c4eb56919391d62b67
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  59dc6f3c6d81c0c4379025c4eb56919391d62b67
Gitweb:     https://git.kernel.org/tip/59dc6f3c6d81c0c4379025c4eb56919391d62b67
Author:     Anna-Maria Gleixner <anna-maria@linutronix.de>
AuthorDate: Fri, 25 May 2018 11:05:07 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 10 Jun 2018 06:14:01 +0200

signal: Remove no longer required irqsave/restore

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: bigeasy@linutronix.de
Link: https://lkml.kernel.org/r/20180525090507.22248-3-anna-maria@linutronix.de

---
 kernel/signal.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

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
