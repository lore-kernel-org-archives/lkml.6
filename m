Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932172AbeDWQKg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:10:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56560 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932085AbeDWQKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:10:34 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] delayacct: use raw_spinlocks
Date: Mon, 23 Apr 2018 18:10:23 +0200
Message-Id: <20180423161024.6710-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

try_to_wake_up() might invoke delayacct_blkio_end() while holding the
pi_lock (which is a raw_spinlock_t). The lock is only held for a short
amount of time so it should be safe to make it raw.
Make struct task_delay_info.lock a raw_spinlock_t.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/delayacct.h |  2 +-
 kernel/delayacct.c        | 17 +++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 5e335b6203f4..e6c0448ebcc7 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -29,7 +29,7 @@
=20
 #ifdef CONFIG_TASK_DELAY_ACCT
 struct task_delay_info {
-	spinlock_t	lock;
+	raw_spinlock_t	lock;
 	unsigned int	flags;	/* Private per-task flags */
=20
 	/* For each stat XXX, add following, aligned appropriately
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index e2764d767f18..ca8ac2824f0b 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -44,23 +44,24 @@ void __delayacct_tsk_init(struct task_struct *tsk)
 {
 	tsk->delays =3D kmem_cache_zalloc(delayacct_cache, GFP_KERNEL);
 	if (tsk->delays)
-		spin_lock_init(&tsk->delays->lock);
+		raw_spin_lock_init(&tsk->delays->lock);
 }
=20
 /*
  * Finish delay accounting for a statistic using its timestamps (@start),
  * accumalator (@total) and @count
  */
-static void delayacct_end(spinlock_t *lock, u64 *start, u64 *total, u32 *c=
ount)
+static void delayacct_end(raw_spinlock_t *lock, u64 *start, u64 *total,
+			  u32 *count)
 {
 	s64 ns =3D ktime_get_ns() - *start;
 	unsigned long flags;
=20
 	if (ns > 0) {
-		spin_lock_irqsave(lock, flags);
+		raw_spin_lock_irqsave(lock, flags);
 		*total +=3D ns;
 		(*count)++;
-		spin_unlock_irqrestore(lock, flags);
+		raw_spin_unlock_irqrestore(lock, flags);
 	}
 }
=20
@@ -127,7 +128,7 @@ int __delayacct_add_tsk(struct taskstats *d, struct tas=
k_struct *tsk)
=20
 	/* zero XXX_total, non-zero XXX_count implies XXX stat overflowed */
=20
-	spin_lock_irqsave(&tsk->delays->lock, flags);
+	raw_spin_lock_irqsave(&tsk->delays->lock, flags);
 	tmp =3D d->blkio_delay_total + tsk->delays->blkio_delay;
 	d->blkio_delay_total =3D (tmp < d->blkio_delay_total) ? 0 : tmp;
 	tmp =3D d->swapin_delay_total + tsk->delays->swapin_delay;
@@ -137,7 +138,7 @@ int __delayacct_add_tsk(struct taskstats *d, struct tas=
k_struct *tsk)
 	d->blkio_count +=3D tsk->delays->blkio_count;
 	d->swapin_count +=3D tsk->delays->swapin_count;
 	d->freepages_count +=3D tsk->delays->freepages_count;
-	spin_unlock_irqrestore(&tsk->delays->lock, flags);
+	raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);
=20
 	return 0;
 }
@@ -147,10 +148,10 @@ __u64 __delayacct_blkio_ticks(struct task_struct *tsk)
 	__u64 ret;
 	unsigned long flags;
=20
-	spin_lock_irqsave(&tsk->delays->lock, flags);
+	raw_spin_lock_irqsave(&tsk->delays->lock, flags);
 	ret =3D nsec_to_clock_t(tsk->delays->blkio_delay +
 				tsk->delays->swapin_delay);
-	spin_unlock_irqrestore(&tsk->delays->lock, flags);
+	raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);
 	return ret;
 }
=20
--=20
2.17.0
