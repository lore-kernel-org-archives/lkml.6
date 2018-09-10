Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715EBC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342BF20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342BF20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbeIJSug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:50:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39535 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbeIJSug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:50:36 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fzMfo-00013A-4g; Mon, 10 Sep 2018 15:56:16 +0200
Date:   Mon, 10 Sep 2018 15:56:16 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] rcu: Use cpus_read_lock() while looking at cpu_online_mask
Message-ID: <20180910135615.tr3cvipwbhq6xug4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was possible that sync_rcu_exp_select_cpus() enqueued something on
CPU0 while CPU0 was offline. Such a work item wouldn't be processed
until CPU0 gets back online. This problem was addressed in commit
fcc6354365015 ("rcu: Make expedited GPs handle CPU 0 being offline"). I
don't think the issue fully addressed.

Assume grplo = 0 and grphi = 7 and sync_rcu_exp_select_cpus() is invoked
on CPU1. The preempt_disable() section on CPU1 won't ensure that CPU0
remains online between looking at cpu_online_mask and invoking
queue_work_on() on CPU1.

Use cpus_read_lock() to ensure that `cpu' is not going down between
looking at cpu_online_mask at invoking queue_work_on() and waiting for
its completion. It is added around the loop + flush_work() which is
similar to work_on_cpu_safe() (and we can have multiple jobs running on
NUMA systems).

Fixes: fcc6354365015 ("rcu: Make expedited GPs handle CPU 0 being
		      offline")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/rcu/tree_exp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 01b6ddeb4f050..a104cf91e6b90 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -479,6 +479,7 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
 	sync_exp_reset_tree(rsp);
 	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("select"));
 
+	cpus_read_lock();
 	/* Schedule work for each leaf rcu_node structure. */
 	rcu_for_each_leaf_node(rsp, rnp) {
 		rnp->exp_need_flush = false;
@@ -493,13 +494,11 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
 			continue;
 		}
 		INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
-		preempt_disable();
 		cpu = cpumask_next(rnp->grplo - 1, cpu_online_mask);
 		/* If all offline, queue the work on an unbound CPU. */
 		if (unlikely(cpu > rnp->grphi))
 			cpu = WORK_CPU_UNBOUND;
 		queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
-		preempt_enable();
 		rnp->exp_need_flush = true;
 	}
 
@@ -507,6 +506,7 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
 	rcu_for_each_leaf_node(rsp, rnp)
 		if (rnp->exp_need_flush)
 			flush_work(&rnp->rew.rew_work);
+	cpus_read_unlock();
 }
 
 static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
-- 
2.19.0.rc2

