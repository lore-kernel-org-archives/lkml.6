Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756909AbeDKTR3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 15:17:29 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33234 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753602AbeDKTRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 15:17:12 -0400
X-Google-Smtp-Source: AIpwx48M7PJMBLaK/+/hEHPQ4LPfScRyQWbJqbBm9sOYYuueiHnyaZWjsr9QJqGDBbeg3jlFSqj0Aw==
From: Vasyl Gomonovych <gomonovych@gmail.com>
To: gomonovych@gmail.com, ssantosh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: ti: knav_qmss: Use percpu instead atomic for stats counter
Date: Wed, 11 Apr 2018 21:16:29 +0200
Message-Id: <20180411191629.21545-1-gomonovych@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hwqueue has collect statistics in heavy use queue_pop/queu_push functions
for cache efficiency and make push/pop faster use percpu variables.
For performance reasons, driver should keep descriptor in software handler
as short as possible and quickly return it back to hardware queue.
Descriptors coming into driver from hardware after pop and return back
by push to reduce descriptor lifetime in driver collect statistics on percpu.

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 drivers/soc/ti/knav_qmss.h       | 14 ++++++----
 drivers/soc/ti/knav_qmss_queue.c | 60 ++++++++++++++++++++++++++--------------
 2 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss.h b/drivers/soc/ti/knav_qmss.h
index 905b974d1bdc..22f409b86107 100644
--- a/drivers/soc/ti/knav_qmss.h
+++ b/drivers/soc/ti/knav_qmss.h
@@ -19,6 +19,8 @@
 #ifndef __KNAV_QMSS_H__
 #define __KNAV_QMSS_H__
 
+#include <linux/percpu.h>
+
 #define THRESH_GTE	BIT(7)
 #define THRESH_LT	0
 
@@ -162,11 +164,11 @@ struct knav_qmgr_info {
  * notifies:			notifier counts
  */
 struct knav_queue_stats {
-	atomic_t	 pushes;
-	atomic_t	 pops;
-	atomic_t	 push_errors;
-	atomic_t	 pop_errors;
-	atomic_t	 notifies;
+	unsigned int pushes;
+	unsigned int pops;
+	unsigned int push_errors;
+	unsigned int pop_errors;
+	unsigned int notifies;
 };
 
 /**
@@ -283,7 +285,7 @@ struct knav_queue_inst {
 struct knav_queue {
 	struct knav_reg_queue __iomem	*reg_push, *reg_pop, *reg_peek;
 	struct knav_queue_inst		*inst;
-	struct knav_queue_stats	stats;
+	struct knav_queue_stats __percpu	*stats;
 	knav_queue_notify_fn		notifier_fn;
 	void				*notifier_fn_arg;
 	atomic_t			notifier_enabled;
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 77d6b5c03aae..384d70bd8605 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -83,7 +83,7 @@ void knav_queue_notify(struct knav_queue_inst *inst)
 			continue;
 		if (WARN_ON(!qh->notifier_fn))
 			continue;
-		atomic_inc(&qh->stats.notifies);
+		this_cpu_inc(qh->stats->notifies);
 		qh->notifier_fn(qh->notifier_fn_arg);
 	}
 	rcu_read_unlock();
@@ -214,6 +214,12 @@ static struct knav_queue *__knav_queue_open(struct knav_queue_inst *inst,
 	if (!qh)
 		return ERR_PTR(-ENOMEM);
 
+	qh->stats = alloc_percpu(struct knav_queue_stats);
+	if (!qh->stats) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
 	qh->flags = flags;
 	qh->inst = inst;
 	id = inst->id - inst->qmgr->start_queue;
@@ -229,13 +235,17 @@ static struct knav_queue *__knav_queue_open(struct knav_queue_inst *inst,
 		if (range->ops && range->ops->open_queue)
 			ret = range->ops->open_queue(range, inst, flags);
 
-		if (ret) {
-			devm_kfree(inst->kdev->dev, qh);
-			return ERR_PTR(ret);
-		}
+		if (ret)
+			goto err;
 	}
 	list_add_tail_rcu(&qh->list, &inst->handles);
 	return qh;
+
+err:
+	if (qh->stats)
+		free_percpu(qh->stats);
+	devm_kfree(inst->kdev->dev, qh);
+	return ERR_PTR(ret);
 }
 
 static struct knav_queue *
@@ -411,6 +421,12 @@ static void knav_queue_debug_show_instance(struct seq_file *s,
 {
 	struct knav_device *kdev = inst->kdev;
 	struct knav_queue *qh;
+	int cpu = 0;
+	int pushes = 0;
+	int pops = 0;
+	int push_errors = 0;
+	int pop_errors = 0;
+	int notifies = 0;
 
 	if (!knav_queue_is_busy(inst))
 		return;
@@ -418,19 +434,22 @@ static void knav_queue_debug_show_instance(struct seq_file *s,
 	seq_printf(s, "\tqueue id %d (%s)\n",
 		   kdev->base_id + inst->id, inst->name);
 	for_each_handle_rcu(qh, inst) {
-		seq_printf(s, "\t\thandle %p: ", qh);
-		seq_printf(s, "pushes %8d, ",
-			   atomic_read(&qh->stats.pushes));
-		seq_printf(s, "pops %8d, ",
-			   atomic_read(&qh->stats.pops));
-		seq_printf(s, "count %8d, ",
-			   knav_queue_get_count(qh));
-		seq_printf(s, "notifies %8d, ",
-			   atomic_read(&qh->stats.notifies));
-		seq_printf(s, "push errors %8d, ",
-			   atomic_read(&qh->stats.push_errors));
-		seq_printf(s, "pop errors %8d\n",
-			   atomic_read(&qh->stats.pop_errors));
+		for_each_possible_cpu(cpu) {
+			pushes += per_cpu_ptr(qh->stats, cpu)->pushes;
+			pops += per_cpu_ptr(qh->stats, cpu)->pops;
+			push_errors += per_cpu_ptr(qh->stats, cpu)->push_errors;
+			pop_errors += per_cpu_ptr(qh->stats, cpu)->pop_errors;
+			notifies += per_cpu_ptr(qh->stats, cpu)->notifies;
+		}
+
+		seq_printf(s, "\t\thandle %p: pushes %8d, pops %8d, count %8d, notifies %8d, push errors %8d, pop errors %8d\n",
+				qh,
+				pushes,
+				pops,
+				knav_queue_get_count(qh),
+				notifies,
+				push_errors,
+				pop_errors);
 	}
 }
 
@@ -547,6 +566,7 @@ void knav_queue_close(void *qhandle)
 		if (range->ops && range->ops->close_queue)
 			range->ops->close_queue(range, inst);
 	}
+	free_percpu(qh->stats);
 	devm_kfree(inst->kdev->dev, qh);
 }
 EXPORT_SYMBOL_GPL(knav_queue_close);
@@ -620,7 +640,7 @@ int knav_queue_push(void *qhandle, dma_addr_t dma,
 	val = (u32)dma | ((size / 16) - 1);
 	writel_relaxed(val, &qh->reg_push[0].ptr_size_thresh);
 
-	atomic_inc(&qh->stats.pushes);
+	this_cpu_inc(qh->stats->pushes);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(knav_queue_push);
@@ -658,7 +678,7 @@ dma_addr_t knav_queue_pop(void *qhandle, unsigned *size)
 	if (size)
 		*size = ((val & DESC_SIZE_MASK) + 1) * 16;
 
-	atomic_inc(&qh->stats.pops);
+	this_cpu_inc(qh->stats->pops);
 	return dma;
 }
 EXPORT_SYMBOL_GPL(knav_queue_pop);
-- 
2.14.1
