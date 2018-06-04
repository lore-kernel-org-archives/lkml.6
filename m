Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeFDGrT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:47:19 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:44061 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeFDGrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:47:18 -0400
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From: Byungchul Park <byungchul.park@lge.com>
To: peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org
Cc: tglx@linutronix.de, raistlin@linux.it, linux-kernel@vger.kernel.org,
        juri.lelli@gmail.com, bristot@redhat.com, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: [PATCH v5 2/2] sched/deadline: Set cp->elements[0].cpu to -1 when the heap is empty
Date: Mon,  4 Jun 2018 15:45:51 +0900
Message-Id: <1528094751-19559-2-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528094751-19559-1-git-send-email-byungchul.park@lge.com>
References: <1528094751-19559-1-git-send-email-byungchul.park@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steven and Daniel,

I've changed the 2nd patch a little bit to consider cpudl_clear()
additionally. Can I keep your Acked-by on?

(I temporarily removed the Acked-by you gave me.)

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Daniel Bristot de Oliveira <bristot@redhat.com>

-----8<-----
>From 1e368d276186c22f9da298206c718b33e805828d Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul.park@lge.com>
Date: Mon, 4 Jun 2018 15:05:08 +0900
Subject: [PATCH v5 2/2] sched/deadline: Set cp->elements[0].cpu to -1 when the
 heap is empty

Currently, migrating tasks to cpu0 unconditionally happens when the
heap is empty, since cp->elements[0].cpu is initialized to 0(=cpu0).
We have to distinguish between the empty case and cpu0 to avoid the
unnecessary migrations. Therefore, it has to return an invalid value
e.i. -1 in the case the heap is empty.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
Suggested-by: Joel Fernandes <joelaf@google.com>
---
 kernel/sched/cpudeadline.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index ae4fbdc..a200b36 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -136,6 +136,10 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 
 		WARN_ON(best_cpu != -1 && !cpu_present(best_cpu));
 
+		/* The heap tree is empty, just return. */
+		if (best_cpu == -1)
+			return 0;
+
 		if (cpumask_test_cpu(best_cpu, &p->cpus_allowed) &&
 		    dl_time_before(dl_se->deadline, cpudl_maximum_dl(cp))) {
 			if (later_mask)
@@ -172,6 +176,13 @@ void cpudl_clear(struct cpudl *cp, int cpu)
 		 * This could happen if a rq_offline_dl is
 		 * called for a CPU without -dl tasks running.
 		 */
+	} else if (cp->size == 1){
+		/* Only one element in the heap, clear it. */
+		cp->elements[0].cpu = -1;
+		cp->elements[cpu].idx = IDX_INVALID;
+		cp->size = 0;
+
+		cpumask_set_cpu(cpu, cp->free_cpus);
 	} else {
 		new_cpu = cp->elements[cp->size - 1].cpu;
 		cp->elements[old_idx].dl = cp->elements[cp->size - 1].dl;
@@ -267,6 +278,9 @@ int cpudl_init(struct cpudl *cp)
 	for_each_possible_cpu(i)
 		cp->elements[i].idx = IDX_INVALID;
 
+	/* Mark heap as initially empty. */
+	cp->elements[0].cpu = -1;
+
 	return 0;
 }
 
-- 
1.9.1
