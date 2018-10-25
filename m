Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F929C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1BB2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmsJWf/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1BB2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbeJYWua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:50:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729604AbeJYWu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:29 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A55F120834;
        Thu, 25 Oct 2018 14:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477052;
        bh=+GvmHo+RKtfx3g77spIQGuTIIAMhtRDzhL8W7EldYUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jmsJWf/jWiwnzShXYxWtbEvcBd3BsQaSYn7y/egP+Y2JL+q8j0qSeAv2S8FEIKjHX
         RS7FGL12f8lAuDxrxKPKM29nuHk1/rhkBRMd/h2Xf2IWKAD6VM9aPneopoJiYwR83w
         N6ugFmn+6syUO6PoJJrZsSiBH4zxoa1/oluNyVzU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 14/65] sched/cgroup: Fix cgroup entity load tracking tear-down
Date:   Thu, 25 Oct 2018 10:16:14 -0400
Message-Id: <20181025141705.213937-14-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 6fe1f348b3dd1f700f9630562b7d38afd6949568 ]

When a cgroup's CPU runqueue is destroyed, it should remove its
remaining load accounting from its parent cgroup.

The current site for doing so it unsuited because its far too late and
unordered against other cgroup removal (->css_free() will be, but we're also
in an RCU callback).

Put it in the ->css_offline() callback, which is the start of cgroup
destruction, right after the group has been made unavailable to
userspace. The ->css_offline() callbacks are called in hierarchical order
after the following v4.4 commit:

  aa226ff4a1ce ("cgroup: make sure a parent css isn't offlined before its children")

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20160121212416.GL6357@twins.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c  |  4 +---
 kernel/sched/fair.c  | 37 +++++++++++++++++++++----------------
 kernel/sched/sched.h |  2 +-
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 65ed3501c2ca..4743e1f2a3d1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7817,11 +7817,9 @@ void sched_destroy_group(struct task_group *tg)
 void sched_offline_group(struct task_group *tg)
 {
 	unsigned long flags;
-	int i;
 
 	/* end participation in shares distribution */
-	for_each_possible_cpu(i)
-		unregister_fair_sched_group(tg, i);
+	unregister_fair_sched_group(tg);
 
 	spin_lock_irqsave(&task_group_lock, flags);
 	list_del_rcu(&tg->list);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3b136fb4422c..a0c5bb93a3ab 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8154,11 +8154,8 @@ void free_fair_sched_group(struct task_group *tg)
 	for_each_possible_cpu(i) {
 		if (tg->cfs_rq)
 			kfree(tg->cfs_rq[i]);
-		if (tg->se) {
-			if (tg->se[i])
-				remove_entity_load_avg(tg->se[i]);
+		if (tg->se)
 			kfree(tg->se[i]);
-		}
 	}
 
 	kfree(tg->cfs_rq);
@@ -8206,21 +8203,29 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 	return 0;
 }
 
-void unregister_fair_sched_group(struct task_group *tg, int cpu)
+void unregister_fair_sched_group(struct task_group *tg)
 {
-	struct rq *rq = cpu_rq(cpu);
 	unsigned long flags;
+	struct rq *rq;
+	int cpu;
 
-	/*
-	* Only empty task groups can be destroyed; so we can speculatively
-	* check on_list without danger of it being re-added.
-	*/
-	if (!tg->cfs_rq[cpu]->on_list)
-		return;
+	for_each_possible_cpu(cpu) {
+		if (tg->se[cpu])
+			remove_entity_load_avg(tg->se[cpu]);
 
-	raw_spin_lock_irqsave(&rq->lock, flags);
-	list_del_leaf_cfs_rq(tg->cfs_rq[cpu]);
-	raw_spin_unlock_irqrestore(&rq->lock, flags);
+		/*
+		 * Only empty task groups can be destroyed; so we can speculatively
+		 * check on_list without danger of it being re-added.
+		 */
+		if (!tg->cfs_rq[cpu]->on_list)
+			continue;
+
+		rq = cpu_rq(cpu);
+
+		raw_spin_lock_irqsave(&rq->lock, flags);
+		list_del_leaf_cfs_rq(tg->cfs_rq[cpu]);
+		raw_spin_unlock_irqrestore(&rq->lock, flags);
+	}
 }
 
 void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
@@ -8302,7 +8307,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 	return 1;
 }
 
-void unregister_fair_sched_group(struct task_group *tg, int cpu) { }
+void unregister_fair_sched_group(struct task_group *tg) { }
 
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0c9ebd82a684..af8d8c3eb8ab 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -308,7 +308,7 @@ extern int tg_nop(struct task_group *tg, void *data);
 
 extern void free_fair_sched_group(struct task_group *tg);
 extern int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent);
-extern void unregister_fair_sched_group(struct task_group *tg, int cpu);
+extern void unregister_fair_sched_group(struct task_group *tg);
 extern void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 			struct sched_entity *se, int cpu,
 			struct sched_entity *parent);
-- 
2.17.1

