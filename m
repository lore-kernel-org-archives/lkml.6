Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932434AbeDWTQp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 15:16:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58567 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932175AbeDWTQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 15:16:43 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] stop_machine: Use raw spinlocks
Date: Mon, 23 Apr 2018 21:16:35 +0200
Message-Id: <20180423191635.6014-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Use raw-locks in stop_machine() to allow locking in irq-off and
preempt-disabled regions on -RT.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: update patch description.]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/stop_machine.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index b7591261652d..c25ba18274fb 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -36,7 +36,7 @@ struct cpu_stop_done {
 struct cpu_stopper {
 	struct task_struct	*thread;
=20
-	spinlock_t		lock;
+	raw_spinlock_t		lock;
 	bool			enabled;	/* is this stopper enabled? */
 	struct list_head	works;		/* list of pending works */
=20
@@ -78,13 +78,13 @@ static bool cpu_stop_queue_work(unsigned int cpu, struc=
t cpu_stop_work *work)
 	unsigned long flags;
 	bool enabled;
=20
-	spin_lock_irqsave(&stopper->lock, flags);
+	raw_spin_lock_irqsave(&stopper->lock, flags);
 	enabled =3D stopper->enabled;
 	if (enabled)
 		__cpu_stop_queue_work(stopper, work);
 	else if (work->done)
 		cpu_stop_signal_done(work->done);
-	spin_unlock_irqrestore(&stopper->lock, flags);
+	raw_spin_unlock_irqrestore(&stopper->lock, flags);
=20
 	return enabled;
 }
@@ -231,8 +231,8 @@ static int cpu_stop_queue_two_works(int cpu1, struct cp=
u_stop_work *work1,
 	struct cpu_stopper *stopper2 =3D per_cpu_ptr(&cpu_stopper, cpu2);
 	int err;
 retry:
-	spin_lock_irq(&stopper1->lock);
-	spin_lock_nested(&stopper2->lock, SINGLE_DEPTH_NESTING);
+	raw_spin_lock_irq(&stopper1->lock);
+	raw_spin_lock_nested(&stopper2->lock, SINGLE_DEPTH_NESTING);
=20
 	err =3D -ENOENT;
 	if (!stopper1->enabled || !stopper2->enabled)
@@ -255,8 +255,8 @@ static int cpu_stop_queue_two_works(int cpu1, struct cp=
u_stop_work *work1,
 	__cpu_stop_queue_work(stopper1, work1);
 	__cpu_stop_queue_work(stopper2, work2);
 unlock:
-	spin_unlock(&stopper2->lock);
-	spin_unlock_irq(&stopper1->lock);
+	raw_spin_unlock(&stopper2->lock);
+	raw_spin_unlock_irq(&stopper1->lock);
=20
 	if (unlikely(err =3D=3D -EDEADLK)) {
 		while (stop_cpus_in_progress)
@@ -448,9 +448,9 @@ static int cpu_stop_should_run(unsigned int cpu)
 	unsigned long flags;
 	int run;
=20
-	spin_lock_irqsave(&stopper->lock, flags);
+	raw_spin_lock_irqsave(&stopper->lock, flags);
 	run =3D !list_empty(&stopper->works);
-	spin_unlock_irqrestore(&stopper->lock, flags);
+	raw_spin_unlock_irqrestore(&stopper->lock, flags);
 	return run;
 }
=20
@@ -461,13 +461,13 @@ static void cpu_stopper_thread(unsigned int cpu)
=20
 repeat:
 	work =3D NULL;
-	spin_lock_irq(&stopper->lock);
+	raw_spin_lock_irq(&stopper->lock);
 	if (!list_empty(&stopper->works)) {
 		work =3D list_first_entry(&stopper->works,
 					struct cpu_stop_work, list);
 		list_del_init(&work->list);
 	}
-	spin_unlock_irq(&stopper->lock);
+	raw_spin_unlock_irq(&stopper->lock);
=20
 	if (work) {
 		cpu_stop_fn_t fn =3D work->fn;
@@ -541,7 +541,7 @@ static int __init cpu_stop_init(void)
 	for_each_possible_cpu(cpu) {
 		struct cpu_stopper *stopper =3D &per_cpu(cpu_stopper, cpu);
=20
-		spin_lock_init(&stopper->lock);
+		raw_spin_lock_init(&stopper->lock);
 		INIT_LIST_HEAD(&stopper->works);
 	}
=20
--=20
2.17.0
