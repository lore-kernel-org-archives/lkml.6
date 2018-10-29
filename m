Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAE2C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCF12082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCF12082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbeJ2Ur3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:47:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51699 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbeJ2Ur3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:47:29 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gH6CG-0000pi-Dj; Mon, 29 Oct 2018 12:59:04 +0100
Date:   Mon, 29 Oct 2018 12:59:04 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v4.18.16-rt9
Message-ID: <20181029115904.yxoreisulsusexky@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.18.16-rt9 patch set. 

Changes since v4.18.16-rt8:

  - The RCU fix, which was introduced in v4.18.7-rt5, leads to a lockdep
    warning during CPU hotplug. After a discussion with upstream it was
    suggested to revert the change that lead to the problem in -RT.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.18.16-rt8 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.18/incr/patch-4.18.16-rt8-rt9.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.18.16-rt9

The RT patch against v4.18.16 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.18/older/patch-4.18.16-rt9.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.18/older/patches-4.18.16-rt9.tar.xz

Sebastian

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index a104cf91e6b90..d40708e8c5d6e 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -472,14 +472,12 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
 				     smp_call_func_t func)
 {
-	int cpu;
 	struct rcu_node *rnp;
 
 	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("reset"));
 	sync_exp_reset_tree(rsp);
 	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("select"));
 
-	cpus_read_lock();
 	/* Schedule work for each leaf rcu_node structure. */
 	rcu_for_each_leaf_node(rsp, rnp) {
 		rnp->exp_need_flush = false;
@@ -494,11 +492,7 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
 			continue;
 		}
 		INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
-		cpu = cpumask_next(rnp->grplo - 1, cpu_online_mask);
-		/* If all offline, queue the work on an unbound CPU. */
-		if (unlikely(cpu > rnp->grphi))
-			cpu = WORK_CPU_UNBOUND;
-		queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
+		queue_work_on(rnp->grplo, rcu_par_gp_wq, &rnp->rew.rew_work);
 		rnp->exp_need_flush = true;
 	}
 
@@ -506,7 +500,6 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
 	rcu_for_each_leaf_node(rsp, rnp)
 		if (rnp->exp_need_flush)
 			flush_work(&rnp->rew.rew_work);
-	cpus_read_unlock();
 }
 
 static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
diff --git a/localversion-rt b/localversion-rt
index 700c857efd9ba..22746d6390a42 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt8
+-rt9
