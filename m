Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbeCIKy6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:54:58 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47829 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbeCIKy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:54:56 -0500
Date: Fri, 9 Mar 2018 02:54:47 -0800
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-6498ddad301c7a94162915d06d1efe2e5d20f6dc@git.kernel.org>
Cc: bigeasy@linutronix.de, juliac@eso.teric.us, mingo@kernel.org,
        rostedt@goodmis.org, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, bigeasy@linutronix.de, mingo@kernel.org,
        juliac@eso.teric.us
In-Reply-To: <20180227164808.10093-2-bigeasy@linutronix.de>
References: <20180227164808.10093-2-bigeasy@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] softirq: Consolidate common code in
 __tasklet_[hi]_schedule()
Git-Commit-ID: 6498ddad301c7a94162915d06d1efe2e5d20f6dc
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

Commit-ID:  6498ddad301c7a94162915d06d1efe2e5d20f6dc
Gitweb:     https://git.kernel.org/tip/6498ddad301c7a94162915d06d1efe2e5d20f6dc
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Tue, 27 Feb 2018 17:48:07 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 9 Mar 2018 11:50:55 +0100

softirq: Consolidate common code in __tasklet_[hi]_schedule()

__tasklet_schedule() and __tasklet_hi_schedule() are almost identical.
Move the common code from both function into __tasklet_schedule_common()
and let both functions invoke it with different arguments.

[ bigeasy: Splitted out from RT's "tasklet: Prevent tasklets from going
  	   into infinite spin in RT" and added commit message. Use
  	   this_cpu_ptr(headp) in __tasklet_schedule_common() as suggested
  	   by Julia Cartwright ]

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Julia Cartwright <juliac@eso.teric.us>
Link: https://lkml.kernel.org/r/20180227164808.10093-2-bigeasy@linutronix.de

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
 
-void __tasklet_schedule(struct tasklet_struct *t)
+static void __tasklet_schedule_common(struct tasklet_struct *t,
+				      struct tasklet_head __percpu *headp,
+				      unsigned int softirq_nr)
 {
+	struct tasklet_head *head;
 	unsigned long flags;
 
 	local_irq_save(flags);
+	head = this_cpu_ptr(headp);
 	t->next = NULL;
-	*__this_cpu_read(tasklet_vec.tail) = t;
-	__this_cpu_write(tasklet_vec.tail, &(t->next));
-	raise_softirq_irqoff(TASKLET_SOFTIRQ);
+	*head->tail = t;
+	head->tail = &(t->next);
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
 
 void __tasklet_hi_schedule(struct tasklet_struct *t)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
-	t->next = NULL;
-	*__this_cpu_read(tasklet_hi_vec.tail) = t;
-	__this_cpu_write(tasklet_hi_vec.tail,  &(t->next));
-	raise_softirq_irqoff(HI_SOFTIRQ);
-	local_irq_restore(flags);
+	__tasklet_schedule_common(t, &tasklet_hi_vec,
+				  HI_SOFTIRQ);
 }
 EXPORT_SYMBOL(__tasklet_hi_schedule);
 
