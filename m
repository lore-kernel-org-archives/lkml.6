Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427269AbeBORVY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:21:24 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54904 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1427240AbeBORVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:21:20 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org, tglx@linutronix.de,
        Ingo Molnar <mingo@elte.hu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] kernel/sofirq: consolidate common code in __tasklet_schedule() + _hi_
Date: Thu, 15 Feb 2018 18:20:41 +0100
Message-Id: <20180215172042.31573-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215172042.31573-1-bigeasy@linutronix.de>
References: <20180215172042.31573-1-bigeasy@linutronix.de>
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
into infinite spin in RT" and added commit message]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/softirq.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 24d243ef8e71..145cf6a2e7c9 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -460,29 +460,31 @@ struct tasklet_head {
 static DEFINE_PER_CPU(struct tasklet_head, tasklet_vec);
 static DEFINE_PER_CPU(struct tasklet_head, tasklet_hi_vec);
=20
-void __tasklet_schedule(struct tasklet_struct *t)
+static void __tasklet_schedule_common(struct tasklet_struct *t,
+				      struct tasklet_head *head,
+				      unsigned int softirq_nr)
 {
 	unsigned long flags;
=20
 	local_irq_save(flags);
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
+	__tasklet_schedule_common(t, this_cpu_ptr(&tasklet_vec),
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
+	__tasklet_schedule_common(t, this_cpu_ptr(&tasklet_hi_vec),
+				  HI_SOFTIRQ);
 }
 EXPORT_SYMBOL(__tasklet_hi_schedule);
=20
--=20
2.16.1
