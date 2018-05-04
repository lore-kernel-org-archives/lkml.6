Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbeEDPcZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:32:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41213 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEDPcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:32:23 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Nicholas Bellinger <nab@linux-iscsi.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] percpu_ida: Use _irqsave() instead of local_irq_save() + spin_lock
Date: Fri,  4 May 2018 17:32:18 +0200
Message-Id: <20180504153218.7301-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

percpu_ida() decouples disabling interrupts from the locking operations.
This breaks some assumptions if the locking operations are replaced like
they are under -RT.
The same locking can be achieved by avoiding local_irq_save() and using
spin_lock_irqsave() instead. percpu_ida_alloc() gains one more
preemption point because after unlocking the fastpath and before the
pool lock is acquired, the interrupts are briefly enabled.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/percpu_ida.c | 63 ++++++++++++++++--------------------------------
 1 file changed, 21 insertions(+), 42 deletions(-)

diff --git a/lib/percpu_ida.c b/lib/percpu_ida.c
index 6016f1deb1f5..9bbd9c5d375a 100644
--- a/lib/percpu_ida.c
+++ b/lib/percpu_ida.c
@@ -112,18 +112,6 @@ static inline void alloc_global_tags(struct percpu_ida=
 *pool,
 		  min(pool->nr_free, pool->percpu_batch_size));
 }
=20
-static inline unsigned alloc_local_tag(struct percpu_ida_cpu *tags)
-{
-	int tag =3D -ENOSPC;
-
-	spin_lock(&tags->lock);
-	if (tags->nr_free)
-		tag =3D tags->freelist[--tags->nr_free];
-	spin_unlock(&tags->lock);
-
-	return tag;
-}
-
 /**
  * percpu_ida_alloc - allocate a tag
  * @pool: pool to allocate from
@@ -147,20 +135,22 @@ int percpu_ida_alloc(struct percpu_ida *pool, int sta=
te)
 	DEFINE_WAIT(wait);
 	struct percpu_ida_cpu *tags;
 	unsigned long flags;
-	int tag;
+	int tag =3D -ENOSPC;
=20
-	local_irq_save(flags);
-	tags =3D this_cpu_ptr(pool->tag_cpu);
+	tags =3D raw_cpu_ptr(pool->tag_cpu);
+	spin_lock_irqsave(&tags->lock, flags);
=20
 	/* Fastpath */
-	tag =3D alloc_local_tag(tags);
-	if (likely(tag >=3D 0)) {
-		local_irq_restore(flags);
+	if (likely(tags->nr_free >=3D 0)) {
+		tag =3D tags->freelist[--tags->nr_free];
+		spin_unlock_irqrestore(&tags->lock, flags);
 		return tag;
 	}
+	spin_unlock_irqrestore(&tags->lock, flags);
=20
 	while (1) {
-		spin_lock(&pool->lock);
+		spin_lock_irqsave(&pool->lock, flags);
+		tags =3D this_cpu_ptr(pool->tag_cpu);
=20
 		/*
 		 * prepare_to_wait() must come before steal_tags(), in case
@@ -184,8 +174,7 @@ int percpu_ida_alloc(struct percpu_ida *pool, int state)
 						&pool->cpus_have_tags);
 		}
=20
-		spin_unlock(&pool->lock);
-		local_irq_restore(flags);
+		spin_unlock_irqrestore(&pool->lock, flags);
=20
 		if (tag >=3D 0 || state =3D=3D TASK_RUNNING)
 			break;
@@ -196,9 +185,6 @@ int percpu_ida_alloc(struct percpu_ida *pool, int state)
 		}
=20
 		schedule();
-
-		local_irq_save(flags);
-		tags =3D this_cpu_ptr(pool->tag_cpu);
 	}
 	if (state !=3D TASK_RUNNING)
 		finish_wait(&pool->wait, &wait);
@@ -222,28 +208,24 @@ void percpu_ida_free(struct percpu_ida *pool, unsigne=
d tag)
=20
 	BUG_ON(tag >=3D pool->nr_tags);
=20
-	local_irq_save(flags);
-	tags =3D this_cpu_ptr(pool->tag_cpu);
+	tags =3D raw_cpu_ptr(pool->tag_cpu);
=20
-	spin_lock(&tags->lock);
+	spin_lock_irqsave(&tags->lock, flags);
 	tags->freelist[tags->nr_free++] =3D tag;
=20
 	nr_free =3D tags->nr_free;
-	spin_unlock(&tags->lock);
=20
 	if (nr_free =3D=3D 1) {
 		cpumask_set_cpu(smp_processor_id(),
 				&pool->cpus_have_tags);
 		wake_up(&pool->wait);
 	}
+	spin_unlock_irqrestore(&tags->lock, flags);
=20
 	if (nr_free =3D=3D pool->percpu_max_size) {
-		spin_lock(&pool->lock);
+		spin_lock_irqsave(&pool->lock, flags);
+		spin_lock(&tags->lock);
=20
-		/*
-		 * Global lock held and irqs disabled, don't need percpu
-		 * lock
-		 */
 		if (tags->nr_free =3D=3D pool->percpu_max_size) {
 			move_tags(pool->freelist, &pool->nr_free,
 				  tags->freelist, &tags->nr_free,
@@ -251,10 +233,9 @@ void percpu_ida_free(struct percpu_ida *pool, unsigned=
 tag)
=20
 			wake_up(&pool->wait);
 		}
-		spin_unlock(&pool->lock);
+		spin_unlock(&tags->lock);
+		spin_unlock_irqrestore(&pool->lock, flags);
 	}
-
-	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(percpu_ida_free);
=20
@@ -346,29 +327,27 @@ int percpu_ida_for_each_free(struct percpu_ida *pool,=
 percpu_ida_cb fn,
 	struct percpu_ida_cpu *remote;
 	unsigned cpu, i, err =3D 0;
=20
-	local_irq_save(flags);
 	for_each_possible_cpu(cpu) {
 		remote =3D per_cpu_ptr(pool->tag_cpu, cpu);
-		spin_lock(&remote->lock);
+		spin_lock_irqsave(&remote->lock, flags);
 		for (i =3D 0; i < remote->nr_free; i++) {
 			err =3D fn(remote->freelist[i], data);
 			if (err)
 				break;
 		}
-		spin_unlock(&remote->lock);
+		spin_unlock_irqrestore(&remote->lock, flags);
 		if (err)
 			goto out;
 	}
=20
-	spin_lock(&pool->lock);
+	spin_lock_irqsave(&pool->lock, flags);
 	for (i =3D 0; i < pool->nr_free; i++) {
 		err =3D fn(pool->freelist[i], data);
 		if (err)
 			break;
 	}
-	spin_unlock(&pool->lock);
+	spin_unlock_irqrestore(&pool->lock, flags);
 out:
-	local_irq_restore(flags);
 	return err;
 }
 EXPORT_SYMBOL_GPL(percpu_ida_for_each_free);
--=20
2.17.0
