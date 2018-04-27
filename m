Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758023AbeD0Mjx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 08:39:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41541 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757373AbeD0Mjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 08:39:51 -0400
Date: Fri, 27 Apr 2018 05:39:45 -0700
From: tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-02acc80d19edb0d5684c997b2004ad19f9f5236e@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bigeasy@linutronix.de, bsingharora@gmail.com
Reply-To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        bsingharora@gmail.com
In-Reply-To: <20180423161024.6710-1-bigeasy@linutronix.de>
References: <20180423161024.6710-1-bigeasy@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] delayacct: Use raw_spinlocks
Git-Commit-ID: 02acc80d19edb0d5684c997b2004ad19f9f5236e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  02acc80d19edb0d5684c997b2004ad19f9f5236e
Gitweb:     https://git.kernel.org/tip/02acc80d19edb0d5684c997b2004ad19f9f5236e
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Mon, 23 Apr 2018 18:10:23 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 27 Apr 2018 14:34:51 +0200

delayacct: Use raw_spinlocks

try_to_wake_up() might invoke delayacct_blkio_end() while holding the
pi_lock (which is a raw_spinlock_t). delayacct_blkio_end() acquires
task_delay_info.lock which is a spinlock_t. This causes a might sleep splat
on -RT where non raw spinlocks are converted to 'sleeping' spinlocks.

task_delay_info.lock is only held for a short amount of time so it's not a
problem latency wise to make convert it to a raw spinlock.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Balbir Singh <bsingharora@gmail.com>
Link: https://lkml.kernel.org/r/20180423161024.6710-1-bigeasy@linutronix.de

---
 include/linux/delayacct.h |  2 +-
 kernel/delayacct.c        | 17 +++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 5e335b6203f4..e6c0448ebcc7 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -29,7 +29,7 @@
 
 #ifdef CONFIG_TASK_DELAY_ACCT
 struct task_delay_info {
-	spinlock_t	lock;
+	raw_spinlock_t	lock;
 	unsigned int	flags;	/* Private per-task flags */
 
 	/* For each stat XXX, add following, aligned appropriately
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index e2764d767f18..ca8ac2824f0b 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -44,23 +44,24 @@ void __delayacct_tsk_init(struct task_struct *tsk)
 {
 	tsk->delays = kmem_cache_zalloc(delayacct_cache, GFP_KERNEL);
 	if (tsk->delays)
-		spin_lock_init(&tsk->delays->lock);
+		raw_spin_lock_init(&tsk->delays->lock);
 }
 
 /*
  * Finish delay accounting for a statistic using its timestamps (@start),
  * accumalator (@total) and @count
  */
-static void delayacct_end(spinlock_t *lock, u64 *start, u64 *total, u32 *count)
+static void delayacct_end(raw_spinlock_t *lock, u64 *start, u64 *total,
+			  u32 *count)
 {
 	s64 ns = ktime_get_ns() - *start;
 	unsigned long flags;
 
 	if (ns > 0) {
-		spin_lock_irqsave(lock, flags);
+		raw_spin_lock_irqsave(lock, flags);
 		*total += ns;
 		(*count)++;
-		spin_unlock_irqrestore(lock, flags);
+		raw_spin_unlock_irqrestore(lock, flags);
 	}
 }
 
@@ -127,7 +128,7 @@ int __delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 
 	/* zero XXX_total, non-zero XXX_count implies XXX stat overflowed */
 
-	spin_lock_irqsave(&tsk->delays->lock, flags);
+	raw_spin_lock_irqsave(&tsk->delays->lock, flags);
 	tmp = d->blkio_delay_total + tsk->delays->blkio_delay;
 	d->blkio_delay_total = (tmp < d->blkio_delay_total) ? 0 : tmp;
 	tmp = d->swapin_delay_total + tsk->delays->swapin_delay;
@@ -137,7 +138,7 @@ int __delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 	d->blkio_count += tsk->delays->blkio_count;
 	d->swapin_count += tsk->delays->swapin_count;
 	d->freepages_count += tsk->delays->freepages_count;
-	spin_unlock_irqrestore(&tsk->delays->lock, flags);
+	raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);
 
 	return 0;
 }
@@ -147,10 +148,10 @@ __u64 __delayacct_blkio_ticks(struct task_struct *tsk)
 	__u64 ret;
 	unsigned long flags;
 
-	spin_lock_irqsave(&tsk->delays->lock, flags);
+	raw_spin_lock_irqsave(&tsk->delays->lock, flags);
 	ret = nsec_to_clock_t(tsk->delays->blkio_delay +
 				tsk->delays->swapin_delay);
-	spin_unlock_irqrestore(&tsk->delays->lock, flags);
+	raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);
 	return ret;
 }
 
