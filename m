Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeB0Qte (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:49:34 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46686 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751735AbeB0QtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:49:02 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org, tglx@linutronix.de,
        Julia Cartwright <juliac@eso.teric.us>, Ingo Molnar <mingo@elte.hu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] kernel/sofirq: consolidate common code in __tasklet_schedule() + _hi_
Date: Tue, 27 Feb 2018 17:48:07 +0100
Message-Id: <20180227164808.10093-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180227164808.10093-1-bigeasy@linutronix.de>
References: <20180227164808.10093-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

__tasklet_schedule() and __tasklet_hi_schedule() are almost identical.
Move the common code from both function into __tasklet_schedule_common()
and let both functions invoke it with different arguments.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: splitted out from RT's "tasklet: Prevent tasklets from going
into infinite spin in RT" and added commit message. Do
this_cpu_ptr(headp) in __tasklet_schedule_common() as suggested by Julia
Cartwright]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/softirq.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 24d243ef8e71..2394b009994f 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -460,29 +460,33 @@ struct tasklet_head {
 static DEFINE_PER_CPU(struct tasklet_head, tasklet_vec);
 static DEFINE_PER_CPU(struct tasklet_head, tasklet_hi_vec);
=20
-void __tasklet_schedule(struct tasklet_struct *t)
+static void __tasklet_schedule_common(struct tasklet_struct *t,
+				      struct tasklet_head __percpu *headp,
+				      unsigned int softirq_nr)
 {
+	struct tasklet_head *head;
 	unsigned long flags;
=20
 	local_irq_save(flags);
+	head =3D this_cpu_ptr(headp);
 	t->next =3D NULL;
-	*__this_cpu_read(tasklet_vec.tail) =3D t;
-	__this_cpu_write(tasklet_vec.tail, &(t->next));
-	raise_softirq_irqoff(TASKLET_SOFTIRQ);
+	*head->tail =3D t;
+	head->tail =3D &(t->next);
+	raise_softirq_irqoff(softirq_nr);
 	local_irq_restore(flags);
 }
+
+void __tasklet_schedule(struct tasklet_struct *t)
+{
+	__tasklet_schedule_common(t, &tasklet_vec,
+				  TASKLET_SOFTIRQ);
+}
 EXPORT_SYMBOL(__tasklet_schedule);
=20
 void __tasklet_hi_schedule(struct tasklet_struct *t)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
-	t->next =3D NULL;
-	*__this_cpu_read(tasklet_hi_vec.tail) =3D t;
-	__this_cpu_write(tasklet_hi_vec.tail,  &(t->next));
-	raise_softirq_irqoff(HI_SOFTIRQ);
-	local_irq_restore(flags);
+	__tasklet_schedule_common(t, &tasklet_hi_vec,
+				  HI_SOFTIRQ);
 }
 EXPORT_SYMBOL(__tasklet_hi_schedule);
=20
--=20
2.16.2
