Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E4BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F06920877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F06920877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbeIXSIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:08:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54142 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbeIXSIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:08:37 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B8CAD107B;
        Mon, 24 Sep 2018 12:06:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 094/111] rcu: Fix grace-period hangs due to race with CPU offline
Date:   Mon, 24 Sep 2018 13:53:01 +0200
Message-Id: <20180924113114.247174991@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.337261320@linuxfoundation.org>
References: <20180924113103.337261320@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

[ Upstream commit 1e64b15a4b102e1cd059d4d798b7a78f93341333 ]

Without special fail-safe quiescent-state-propagation checks, grace-period
hangs can result from the following scenario:

1.	CPU 1 goes offline.

2.	Because CPU 1 is the only CPU in the system blocking the current
	grace period, the grace period ends as soon as
	rcu_cleanup_dying_idle_cpu()'s call to rcu_report_qs_rnp()
	returns.

3.	At this point, the leaf rcu_node structure's ->lock is no longer
	held: rcu_report_qs_rnp() has released it, as it must in order
	to awaken the RCU grace-period kthread.

4.	At this point, that same leaf rcu_node structure's ->qsmaskinitnext
	field still records CPU 1 as being online.  This is absolutely
	necessary because the scheduler uses RCU (in this case on the
	wake-up path while awakening RCU's grace-period kthread), and
	->qsmaskinitnext contains RCU's idea as to which CPUs are online.
	Therefore, invoking rcu_report_qs_rnp() after clearing CPU 1's
	bit from ->qsmaskinitnext would result in a lockdep-RCU splat
	due to RCU being used from an offline CPU.

5.	RCU's grace-period kthread awakens, sees that the old grace period
	has completed and that a new one is needed.  It therefore starts
	a new grace period, but because CPU 1's leaf rcu_node structure's
	->qsmaskinitnext field still shows CPU 1 as being online, this new
	grace period is initialized to wait for a quiescent state from the
	now-offline CPU 1.

6.	Without the fail-safe force-quiescent-state checks, there would
	be no quiescent state from the now-offline CPU 1, which would
	eventually result in RCU CPU stall warnings and memory exhaustion.

It would be good to get rid of the special fail-safe quiescent-state
propagation checks, and thus it would be good to fix things so that
the above scenario cannot happen.  This commit therefore adds a new
->ofl_lock to the rcu_state structure.  This lock is held by rcu_gp_init()
across the applying of buffered online and offline operations to the
rcu_node tree, and it is also held by rcu_cleanup_dying_idle_cpu()
when buffering a new offline operation.  This prevents rcu_gp_init()
from acquiring the leaf rcu_node structure's lock during the interval
between when rcu_cleanup_dying_idle_cpu() invokes rcu_report_qs_rnp(),
which releases ->lock and the re-acquisition of that same lock.
This in turn prevents the failure scenario outlined above, and will
hopefully eventually allow removal of the offline-CPU checks from the
force-quiescent-state code path.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/rcu/tree.c |    6 ++++++
 kernel/rcu/tree.h |    4 ++++
 2 files changed, 10 insertions(+)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -102,6 +102,7 @@ struct rcu_state sname##_state = { \
 	.abbr = sabbr, \
 	.exp_mutex = __MUTEX_INITIALIZER(sname##_state.exp_mutex), \
 	.exp_wake_mutex = __MUTEX_INITIALIZER(sname##_state.exp_wake_mutex), \
+	.ofl_lock = __SPIN_LOCK_UNLOCKED(sname##_state.ofl_lock), \
 }
 
 RCU_STATE_INITIALIZER(rcu_sched, 's', call_rcu_sched);
@@ -1966,11 +1967,13 @@ static bool rcu_gp_init(struct rcu_state
 	 */
 	rcu_for_each_leaf_node(rsp, rnp) {
 		rcu_gp_slow(rsp, gp_preinit_delay);
+		spin_lock(&rsp->ofl_lock);
 		raw_spin_lock_irq_rcu_node(rnp);
 		if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
 		    !rnp->wait_blkd_tasks) {
 			/* Nothing to do on this leaf rcu_node structure. */
 			raw_spin_unlock_irq_rcu_node(rnp);
+			spin_unlock(&rsp->ofl_lock);
 			continue;
 		}
 
@@ -2005,6 +2008,7 @@ static bool rcu_gp_init(struct rcu_state
 		}
 
 		raw_spin_unlock_irq_rcu_node(rnp);
+		spin_unlock(&rsp->ofl_lock);
 	}
 
 	/*
@@ -3915,9 +3919,11 @@ static void rcu_cleanup_dying_idle_cpu(i
 
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
 	mask = rdp->grpmask;
+	spin_lock(&rsp->ofl_lock);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
 	rnp->qsmaskinitnext &= ~mask;
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	spin_unlock(&rsp->ofl_lock);
 }
 
 void rcu_report_dead(unsigned int cpu)
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -550,6 +550,10 @@ struct rcu_state {
 	const char *name;			/* Name of structure. */
 	char abbr;				/* Abbreviated name. */
 	struct list_head flavors;		/* List of RCU flavors. */
+
+	spinlock_t ofl_lock ____cacheline_internodealigned_in_smp;
+						/* Synchronize offline with */
+						/*  GP pre-initialization. */
 };
 
 /* Values for rcu_state structure's gp_flags field. */


