Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374B3C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C262087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C262087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeJMCPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 22:15:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52020 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeJMCPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 22:15:13 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gB2N9-0006FP-CI; Fri, 12 Oct 2018 20:41:15 +0200
Date:   Fri, 12 Oct 2018 20:41:15 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: Use cpus_read_lock() while looking at
 cpu_online_mask
Message-ID: <20181012184114.w332lnkc34evd4sm@linutronix.de>
References: <20180910135615.tr3cvipwbhq6xug4@linutronix.de>
 <20180911160532.GJ4225@linux.vnet.ibm.com>
 <20180911162142.cc3vgook2gctus4c@linutronix.de>
 <20180911170222.GO4225@linux.vnet.ibm.com>
 <20180919205521.GE902964@devbig004.ftw2.facebook.com>
 <20180919221140.GH4222@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180919221140.GH4222@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-19 15:11:40 [-0700], Paul E. McKenney wrote:
> On Wed, Sep 19, 2018 at 01:55:21PM -0700, Tejun Heo wrote:
> > Unbound workqueue is NUMA-affine by default, so using it by default
> > might not harm anything.
> 
> OK, so the above workaround would function correctly on -rt, thank you!
> 
> Sebastian, is there a counterpart to CONFIG_PREEMPT_RT already in
> mainline?  If so, I would be happy to make mainline safe for -rt.

Now that I stumbled upon it again, I noticed that I never replied here.
Sorry for that.

Let me summarize:
sync_rcu_exp_select_cpus() used
	queue_work_on(rnp->grplo, rcu_par_gp_wq, &rnp->rew.rew_work);

which was changed in commit fcc6354365015 ("rcu: Make expedited GPs
handle CPU 0 being offline"). The commit claims that this is needed in
case CPU0 is offline so it tries to find another CPU starting with the
possible offline CPU. It might cross to another NUMA node but that is
not really a problem, it just tries to remain on the "local NUMA node".

After that commit, the code invokes queue_work_on() within a
preempt_disable() section because it can't use cpus_read_lock() to
ensure that the CPU won't go offline in the middle of testing (and
preempt_disable() does the trick).
For RT reasons I would like to get rid of queue_work_on() within the
preempt_disable() section.
Tejun said that enqueueing an item on an unbound workqueue is NUMA
affine.

I figured out that enqueueing an item on an offline CPU is not a problem
and it will pop up on a "random" CPU which means it will be carried out
asap and will not wait until the CPU gets back online. Therefore I don't
understand the commit fcc6354365015.

May I suggest the following change? It will enqueue the work item on
the first CPU on the NUMA node and the "unbound" part of the work queue
ensures that a CPU of that NUMA node will perform the work.
This is mostly a revert of fcc6354365015 except that the workqueue
gained the WQ_UNBOUND flag.

------------------>8----

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0b760c1369f76..94d6c50c4e796 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4162,7 +4162,7 @@ void __init rcu_init(void)
 	/* Create workqueue for expedited GPs and for Tree SRCU. */
 	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_gp_wq);
-	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
+	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	WARN_ON(!rcu_par_gp_wq);
 }
 
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 0b2c2ad69629c..a0486414edb40 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -472,7 +472,6 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
 				     smp_call_func_t func)
 {
-	int cpu;
 	struct rcu_node *rnp;
 
 	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("reset"));
@@ -494,13 +493,7 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
 			continue;
 		}
 		INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
-		preempt_disable();
-		cpu = cpumask_next(rnp->grplo - 1, cpu_online_mask);
-		/* If all offline, queue the work on an unbound CPU. */
-		if (unlikely(cpu > rnp->grphi))
-			cpu = WORK_CPU_UNBOUND;
-		queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
-		preempt_enable();
+		queue_work_on(rnp->grplo, rcu_par_gp_wq, &rnp->rew.rew_work);
 		rnp->exp_need_flush = true;
 	}
 

> 
> 							Thanx, Paul

Sebastian
