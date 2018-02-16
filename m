Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032422AbeBPRIo convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:08:44 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56905 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032362AbeBPRIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:08:41 -0500
Date: Fri, 16 Feb 2018 18:08:36 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 1/2 v2] kernel/sofirq: consolidate common code in
 __tasklet_schedule() + _hi_
Message-ID: <20180216170836.ex2uxcgkk7gniwqi@linutronix.de>
References: <20180215172042.31573-1-bigeasy@linutronix.de>
 <20180215172042.31573-2-bigeasy@linutronix.de>
 <20180215150707.49cc2332@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180215150707.49cc2332@gandalf.local.home>
User-Agent: NeoMutt/20171215
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
v1…v2: use local_irq_save() within the non-common.

 kernel/softirq.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 24d243ef8e71..860679e357e2 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -460,15 +460,24 @@ struct tasklet_head {
 static DEFINE_PER_CPU(struct tasklet_head, tasklet_vec);
 static DEFINE_PER_CPU(struct tasklet_head, tasklet_hi_vec);
 
+static void __tasklet_schedule_common(struct tasklet_struct *t,
+				      struct tasklet_head *head,
+				      unsigned int softirq_nr)
+{
+
+	t->next = NULL;
+	*head->tail = t;
+	head->tail = &(t->next);
+	raise_softirq_irqoff(softirq_nr);
+}
+
 void __tasklet_schedule(struct tasklet_struct *t)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
-	t->next = NULL;
-	*__this_cpu_read(tasklet_vec.tail) = t;
-	__this_cpu_write(tasklet_vec.tail, &(t->next));
-	raise_softirq_irqoff(TASKLET_SOFTIRQ);
+	__tasklet_schedule_common(t, this_cpu_ptr(&tasklet_vec),
+				  TASKLET_SOFTIRQ);
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(__tasklet_schedule);
@@ -478,10 +487,8 @@ void __tasklet_hi_schedule(struct tasklet_struct *t)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	t->next = NULL;
-	*__this_cpu_read(tasklet_hi_vec.tail) = t;
-	__this_cpu_write(tasklet_hi_vec.tail,  &(t->next));
-	raise_softirq_irqoff(HI_SOFTIRQ);
+	__tasklet_schedule_common(t, this_cpu_ptr(&tasklet_hi_vec),
+				  HI_SOFTIRQ);
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(__tasklet_hi_schedule);
-- 
2.16.1
