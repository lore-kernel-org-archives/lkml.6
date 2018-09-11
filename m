Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFB3C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639F420839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639F420839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeIKO1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:27:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41327 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeIKO1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:27:47 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fzeyy-00021S-2B; Tue, 11 Sep 2018 11:29:16 +0200
Date:   Tue, 11 Sep 2018 11:29:16 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v4.18.7-rt5
Message-ID: <20180911092915.jdody6z6oufck75a@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.18.7-rt5 patch set. 

Changes since v4.18.7-rt4:

  - Avoid a memory allocation with disabled interrupts in the "cached
    device tree" code

  - Avoid queuing a work item with disabled preemption in the "srcu"
    code.

  - The simple-work queue code used a constant shifted by zero. This is
    reported by smack as an error because it should have been a plain
    number (in function it is used). Reported by Dan Carpenter.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.18.7-rt4 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.18/incr/patch-4.18.7-rt4-rt5.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.18.7-rt5

The RT patch against v4.18.7 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.18/older/patch-4.18.7-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.18/older/patches-4.18.7-rt5.tar.xz

Sebastian

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 466e3c8582f0f..7394d9dcc2a1b 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -108,43 +108,49 @@ void of_populate_phandle_cache(void)
 	u32 cache_entries;
 	struct device_node *np;
 	u32 phandles = 0;
+	struct device_node **shadow;
 
 	raw_spin_lock_irqsave(&devtree_lock, flags);
-
-	kfree(phandle_cache);
+	shadow = phandle_cache;
 	phandle_cache = NULL;
 
 	for_each_of_allnodes(np)
 		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
 			phandles++;
 
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+
 	cache_entries = roundup_pow_of_two(phandles);
 	phandle_cache_mask = cache_entries - 1;
 
-	phandle_cache = kcalloc(cache_entries, sizeof(*phandle_cache),
-				GFP_ATOMIC);
-	if (!phandle_cache)
-		goto out;
+	kfree(shadow);
+	shadow = kcalloc(cache_entries, sizeof(*phandle_cache), GFP_KERNEL);
+
+	if (!shadow)
+		return;
+	raw_spin_lock_irqsave(&devtree_lock, flags);
+	phandle_cache = shadow;
 
 	for_each_of_allnodes(np)
 		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
 			phandle_cache[np->phandle & phandle_cache_mask] = np;
 
-out:
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 }
 
 int of_free_phandle_cache(void)
 {
 	unsigned long flags;
+	struct device_node **shadow;
 
 	raw_spin_lock_irqsave(&devtree_lock, flags);
 
-	kfree(phandle_cache);
+	shadow = phandle_cache;
 	phandle_cache = NULL;
 
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 
+	kfree(shadow);
 	return 0;
 }
 #if !defined(CONFIG_MODULES)
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
diff --git a/kernel/sched/swork.c b/kernel/sched/swork.c
index 1950f40ca7258..5559c22f664cf 100644
--- a/kernel/sched/swork.c
+++ b/kernel/sched/swork.c
@@ -12,7 +12,7 @@
 #include <linux/spinlock.h>
 #include <linux/export.h>
 
-#define SWORK_EVENT_PENDING     (1 << 0)
+#define SWORK_EVENT_PENDING     1
 
 static DEFINE_MUTEX(worker_mutex);
 static struct sworker *glob_worker;
diff --git a/localversion-rt b/localversion-rt
index ad3da1bcab7e8..0efe7ba1930e1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt4
+-rt5
