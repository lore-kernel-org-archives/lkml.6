Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427256AbeBORVV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:21:21 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54906 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422692AbeBORVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:21:20 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org, tglx@linutronix.de,
        Ingo Molnar <mingo@elte.hu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] kernel/sofirq: consolidate common code in tasklet_action() + tasklet_hi_action()
Date: Thu, 15 Feb 2018 18:20:42 +0100
Message-Id: <20180215172042.31573-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215172042.31573-1-bigeasy@linutronix.de>
References: <20180215172042.31573-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

tasklet_action() + tasklet_hi_action() are almost identical.
Move the common code from both function into __tasklet_schedule_common()
and let both functions invoke it with different arguments.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: splitted out from RT's "tasklet: Prevent tasklets from going
into infinite spin in RT" and added commit message]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/softirq.c | 54 +++++++++++++++-------------------------------------=
--
 1 file changed, 15 insertions(+), 39 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 145cf6a2e7c9..fa7ed89a9fcf 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -488,14 +488,16 @@ void __tasklet_hi_schedule(struct tasklet_struct *t)
 }
 EXPORT_SYMBOL(__tasklet_hi_schedule);
=20
-static __latent_entropy void tasklet_action(struct softirq_action *a)
+static void tasklet_action_common(struct softirq_action *a,
+				  struct tasklet_head *tl_head,
+				  unsigned int softirq_nr)
 {
 	struct tasklet_struct *list;
=20
 	local_irq_disable();
-	list =3D __this_cpu_read(tasklet_vec.head);
-	__this_cpu_write(tasklet_vec.head, NULL);
-	__this_cpu_write(tasklet_vec.tail, this_cpu_ptr(&tasklet_vec.head));
+	list =3D tl_head->head;
+	tl_head->head =3D NULL;
+	tl_head->tail =3D &tl_head->head;
 	local_irq_enable();
=20
 	while (list) {
@@ -517,47 +519,21 @@ static __latent_entropy void tasklet_action(struct so=
ftirq_action *a)
=20
 		local_irq_disable();
 		t->next =3D NULL;
-		*__this_cpu_read(tasklet_vec.tail) =3D t;
-		__this_cpu_write(tasklet_vec.tail, &(t->next));
-		__raise_softirq_irqoff(TASKLET_SOFTIRQ);
+		*tl_head->tail =3D t;
+		tl_head->tail =3D &t->next;
+		__raise_softirq_irqoff(softirq_nr);
 		local_irq_enable();
 	}
 }
=20
+static __latent_entropy void tasklet_action(struct softirq_action *a)
+{
+	tasklet_action_common(a, this_cpu_ptr(&tasklet_vec), TASKLET_SOFTIRQ);
+}
+
 static __latent_entropy void tasklet_hi_action(struct softirq_action *a)
 {
-	struct tasklet_struct *list;
-
-	local_irq_disable();
-	list =3D __this_cpu_read(tasklet_hi_vec.head);
-	__this_cpu_write(tasklet_hi_vec.head, NULL);
-	__this_cpu_write(tasklet_hi_vec.tail, this_cpu_ptr(&tasklet_hi_vec.head));
-	local_irq_enable();
-
-	while (list) {
-		struct tasklet_struct *t =3D list;
-
-		list =3D list->next;
-
-		if (tasklet_trylock(t)) {
-			if (!atomic_read(&t->count)) {
-				if (!test_and_clear_bit(TASKLET_STATE_SCHED,
-							&t->state))
-					BUG();
-				t->func(t->data);
-				tasklet_unlock(t);
-				continue;
-			}
-			tasklet_unlock(t);
-		}
-
-		local_irq_disable();
-		t->next =3D NULL;
-		*__this_cpu_read(tasklet_hi_vec.tail) =3D t;
-		__this_cpu_write(tasklet_hi_vec.tail, &(t->next));
-		__raise_softirq_irqoff(HI_SOFTIRQ);
-		local_irq_enable();
-	}
+	tasklet_action_common(a, this_cpu_ptr(&tasklet_hi_vec), HI_SOFTIRQ);
 }
=20
 void tasklet_init(struct tasklet_struct *t,
--=20
2.16.1
