Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BsQwE7KTGVtaTgAAmS7hNA
	; Thu, 07 Jun 2018 20:22:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AFEAC60452; Thu,  7 Jun 2018 20:22:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F2840608B8;
	Thu,  7 Jun 2018 20:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2840608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753614AbeFGUWI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:22:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43105 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753028AbeFGUWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:22:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w57KLwqn2320798
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 13:21:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w57KLvcN2320795;
        Thu, 7 Jun 2018 13:21:57 -0700
Date: Thu, 7 Jun 2018 13:21:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Anna-Maria Gleixner <tipbot@zytor.com>
Message-ID: <tip-e79e0f38083e607da5d7b493e7a0f78ba38d788e@git.kernel.org>
Cc: mingo@kernel.org, ebiederm@xmission.com, bigeasy@linutronix.de,
        paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, anna-maria@linutronix.de, hpa@zytor.com
Reply-To: anna-maria@linutronix.de, hpa@zytor.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
          ebiederm@xmission.com, bigeasy@linutronix.de, mingo@kernel.org
In-Reply-To: <20180504144014.5378-1-bigeasy@linutronix.de>
References: <20180504144014.5378-1-bigeasy@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] signal: Remove no longer required irqsave/restore
Git-Commit-ID: e79e0f38083e607da5d7b493e7a0f78ba38d788e
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

Commit-ID:  e79e0f38083e607da5d7b493e7a0f78ba38d788e
Gitweb:     https://git.kernel.org/tip/e79e0f38083e607da5d7b493e7a0f78ba38d788e
Author:     Anna-Maria Gleixner <anna-maria@linutronix.de>
AuthorDate: Fri, 4 May 2018 16:40:14 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 7 Jun 2018 22:18:55 +0200

signal: Remove no longer required irqsave/restore

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

Testing was done over an extensive period with RCU torture, especially with
TREE03 as requested by Paul.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Link: https://lkml.kernel.org/r/20180504144014.5378-1-bigeasy@linutronix.de
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
