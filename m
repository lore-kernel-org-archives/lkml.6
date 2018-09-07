Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F39EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE862075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE862075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeIHBzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:55:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39248 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbeIHBzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:55:07 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0EF4EFA4;
        Fri,  7 Sep 2018 21:12:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 4.18 001/145] rcu: Make expedited GPs handle CPU 0 being offline
Date:   Fri,  7 Sep 2018 23:07:47 +0200
Message-Id: <20180907210903.744555886@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boqun Feng <boqun.feng@gmail.com>

commit fcc63543650150629c8a873cbef3578770acecd9 upstream.

Currently, the parallelized initialization of expedited grace periods uses
the workqueue associated with each rcu_node structure's ->grplo field.
This works fine unless that CPU is offline.  This commit therefore uses
the CPU corresponding to the lowest-numbered online CPU, or just queues
the work on WORK_CPU_UNBOUND if there are no online CPUs corresponding
to this rcu_node structure.

Note that this patch uses cpu_is_offline() instead of the usual approach
of checking bits in the rcu_node structure's ->qsmaskinitnext field.  This
is safe because preemption is disabled across both the cpu_is_offline()
check and the call to queue_work_on().

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
[ paulmck: Disable preemption to close offline race window. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ paulmck: Apply Peter Zijlstra feedback on CPU selection. ]
Tested-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/rcu/tree_exp.h |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -472,6 +472,7 @@ retry_ipi:
 static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
 				     smp_call_func_t func)
 {
+	int cpu;
 	struct rcu_node *rnp;
 
 	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("reset"));
@@ -492,7 +493,13 @@ static void sync_rcu_exp_select_cpus(str
 			continue;
 		}
 		INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
-		queue_work_on(rnp->grplo, rcu_par_gp_wq, &rnp->rew.rew_work);
+		preempt_disable();
+		cpu = cpumask_next(rnp->grplo - 1, cpu_online_mask);
+		/* If all offline, queue the work on an unbound CPU. */
+		if (unlikely(cpu > rnp->grphi))
+			cpu = WORK_CPU_UNBOUND;
+		queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
+		preempt_enable();
 		rnp->exp_need_flush = true;
 	}
 


