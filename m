Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751198AbeCIKzY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:55:24 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54831 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeCIKzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:55:23 -0500
Date: Fri, 9 Mar 2018 02:55:15 -0800
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-82b691bedf05f258f1c86c96ee574b0d7795c0a1@git.kernel.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, juliac@eso.teric.us,
        hpa@zytor.com, bigeasy@linutronix.de, tglx@linutronix.de,
        rostedt@goodmis.org
Reply-To: tglx@linutronix.de, bigeasy@linutronix.de, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, juliac@eso.teric.us,
        mingo@kernel.org
In-Reply-To: <20180227164808.10093-3-bigeasy@linutronix.de>
References: <20180227164808.10093-3-bigeasy@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] softirq: Consolidate common code in
 tasklet_[hi]_action()
Git-Commit-ID: 82b691bedf05f258f1c86c96ee574b0d7795c0a1
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

Commit-ID:  82b691bedf05f258f1c86c96ee574b0d7795c0a1
Gitweb:     https://git.kernel.org/tip/82b691bedf05f258f1c86c96ee574b0d7795c0a1
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Tue, 27 Feb 2018 17:48:08 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 9 Mar 2018 11:50:55 +0100

softirq: Consolidate common code in tasklet_[hi]_action()

tasklet_action() + tasklet_hi_action() are almost identical.  Move the
common code from both function into __tasklet_action_common() and let
both functions invoke it with different arguments.

[ bigeasy: Splitted out from RT's "tasklet: Prevent tasklets from going
	   into infinite spin in RT" and added commit message]

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Julia Cartwright <juliac@eso.teric.us>
Link: https://lkml.kernel.org/r/20180227164808.10093-3-bigeasy@linutronix.de

---
 kernel/softirq.c | 54 +++++++++++++++---------------------------------------
 1 file changed, 15 insertions(+), 39 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 2394b009994f..177de3640c78 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -490,14 +490,16 @@ void __tasklet_hi_schedule(struct tasklet_struct *t)
 }
 EXPORT_SYMBOL(__tasklet_hi_schedule);
 
-static __latent_entropy void tasklet_action(struct softirq_action *a)
+static void tasklet_action_common(struct softirq_action *a,
+				  struct tasklet_head *tl_head,
+				  unsigned int softirq_nr)
 {
 	struct tasklet_struct *list;
 
 	local_irq_disable();
-	list = __this_cpu_read(tasklet_vec.head);
-	__this_cpu_write(tasklet_vec.head, NULL);
-	__this_cpu_write(tasklet_vec.tail, this_cpu_ptr(&tasklet_vec.head));
+	list = tl_head->head;
+	tl_head->head = NULL;
+	tl_head->tail = &tl_head->head;
 	local_irq_enable();
 
 	while (list) {
@@ -519,47 +521,21 @@ static __latent_entropy void tasklet_action(struct softirq_action *a)
 
 		local_irq_disable();
 		t->next = NULL;
-		*__this_cpu_read(tasklet_vec.tail) = t;
-		__this_cpu_write(tasklet_vec.tail, &(t->next));
-		__raise_softirq_irqoff(TASKLET_SOFTIRQ);
+		*tl_head->tail = t;
+		tl_head->tail = &t->next;
+		__raise_softirq_irqoff(softirq_nr);
 		local_irq_enable();
 	}
 }
 
-static __latent_entropy void tasklet_hi_action(struct softirq_action *a)
+static __latent_entropy void tasklet_action(struct softirq_action *a)
 {
-	struct tasklet_struct *list;
-
-	local_irq_disable();
-	list = __this_cpu_read(tasklet_hi_vec.head);
-	__this_cpu_write(tasklet_hi_vec.head, NULL);
-	__this_cpu_write(tasklet_hi_vec.tail, this_cpu_ptr(&tasklet_hi_vec.head));
-	local_irq_enable();
-
-	while (list) {
-		struct tasklet_struct *t = list;
-
-		list = list->next;
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
+	tasklet_action_common(a, this_cpu_ptr(&tasklet_vec), TASKLET_SOFTIRQ);
+}
 
-		local_irq_disable();
-		t->next = NULL;
-		*__this_cpu_read(tasklet_hi_vec.tail) = t;
-		__this_cpu_write(tasklet_hi_vec.tail, &(t->next));
-		__raise_softirq_irqoff(HI_SOFTIRQ);
-		local_irq_enable();
-	}
+static __latent_entropy void tasklet_hi_action(struct softirq_action *a)
+{
+	tasklet_action_common(a, this_cpu_ptr(&tasklet_hi_vec), HI_SOFTIRQ);
 }
 
 void tasklet_init(struct tasklet_struct *t,
