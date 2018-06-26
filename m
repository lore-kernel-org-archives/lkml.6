Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4718FC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D2D26C34
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D2D26C34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933703AbeFZUYQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:24:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755011AbeFZUYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:24:15 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QKJIEu016989
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 16:24:14 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jusn6xghw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 16:24:14 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 16:24:13 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 16:24:10 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QKO9WR10420722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 20:24:09 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19B1EB205F;
        Tue, 26 Jun 2018 16:24:03 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBE37B206C;
        Tue, 26 Jun 2018 16:24:02 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 16:24:02 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0B76E16CA156; Tue, 26 Jun 2018 13:26:15 -0700 (PDT)
Date:   Tue, 26 Jun 2018 13:26:15 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 13/22] rcu: Fix grace-period hangs due to
 race with CPU offline
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180626002052.GA24146@linux.vnet.ibm.com>
 <20180626171048.2181-13-paulmck@linux.vnet.ibm.com>
 <20180626175119.GL2494@hirez.programming.kicks-ass.net>
 <20180626182950.GH3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626182950.GH3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062620-0040-0000-0000-0000044589C1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052733; UDB=6.00539708; IPR=6.00830658;
 MB=3.00021868; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 20:24:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062620-0041-0000-0000-0000084BA035
Message-Id: <20180626202615.GA32162@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 11:29:50AM -0700, Paul E. McKenney wrote:
> On Tue, Jun 26, 2018 at 07:51:19PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 26, 2018 at 10:10:39AM -0700, Paul E. McKenney wrote:
> > > Without special fail-safe quiescent-state-propagation checks, grace-period
> > > hangs can result from the following scenario:
> > > 
> > > 1.	CPU 1 goes offline.
> > > 
> > > 2.	Because CPU 1 is the only CPU in the system blocking the current
> > > 	grace period, as soon as rcu_cleanup_dying_idle_cpu()'s call to
> > > 	rcu_report_qs_rnp() returns.
> > > 
> > > 3.	At this point, the leaf rcu_node structure's ->lock is no longer
> > > 	held: rcu_report_qs_rnp() has released it, as it must in order
> > > 	to awaken the RCU grace-period kthread.
> > > 
> > > 4.	At this point, that same leaf rcu_node structure's ->qsmaskinitnext
> > > 	field still records CPU 1 as being online.  This is absolutely
> > > 	necessary because the scheduler uses RCU, and ->qsmaskinitnext
> > 
> > Can you expand a bit on this, where does the scheduler care about the
> > online state of the CPU that's about to call into arch_cpu_idle_dead()?
> 
> Because the CPU does a context switch between the time that the CPU gets
> marked offline from the viewpoint of cpu_offline() and the time that
> the CPU finally makes it to arch_cpu_idle_dead().  Plus reporting the
> quiescent state (rcu_report_qs_rnp()) can result in waking up RCU's
> grace-period kthread.  During that context switch and that wakeup,
> the scheduler needs RCU to continue paying attention to the outgoing
> CPU, right?

And is the following a reasonable expansion?

							Thanx, Paul

------------------------------------------------------------------------

commit 2e5b2ff4047b138d6b56e4e3ba91bc47503cdebe
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Fri May 25 19:23:09 2018 -0700

    rcu: Fix grace-period hangs due to race with CPU offline
    
    Without special fail-safe quiescent-state-propagation checks, grace-period
    hangs can result from the following scenario:
    
    1.      CPU 1 goes offline.
    
    2.      Because CPU 1 is the only CPU in the system blocking the current
            grace period, the grace period ends as soon as
            rcu_cleanup_dying_idle_cpu()'s call to rcu_report_qs_rnp()
            returns.
    
    3.      At this point, the leaf rcu_node structure's ->lock is no longer
            held: rcu_report_qs_rnp() has released it, as it must in order
            to awaken the RCU grace-period kthread.
    
    4.      At this point, that same leaf rcu_node structure's ->qsmaskinitnext
            field still records CPU 1 as being online.  This is absolutely
            necessary because the scheduler uses RCU (in this case on the
            wake-up path while awakening RCU's grace-period kthread), and
            ->qsmaskinitnext contains RCU's idea as to which CPUs are online.
            Therefore, invoking rcu_report_qs_rnp() after clearing CPU 1's
            bit from ->qsmaskinitnext would result in a lockdep-RCU splat
            due to RCU being used from an offline CPU.
    
    5.      RCU's grace-period kthread awakens, sees that the old grace period
            has completed and that a new one is needed.  It therefore starts
            a new grace period, but because CPU 1's leaf rcu_node structure's
            ->qsmaskinitnext field still shows CPU 1 as being online, this new
            grace period is initialized to wait for a quiescent state from the
            now-offline CPU 1.
    
    6.      Without the fail-safe force-quiescent-state checks, there would
            be no quiescent state from the now-offline CPU 1, which would
            eventually result in RCU CPU stall warnings and memory exhaustion.
    
    It would be good to get rid of the special fail-safe quiescent-state
    propagation checks, and thus it would be good to fix things so that
    he above scenario cannot happen.  This commit therefore adds a new
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

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2cfd5d3da4f8..bb8f45c0fa68 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -101,6 +101,7 @@ struct rcu_state sname##_state = { \
 	.abbr = sabbr, \
 	.exp_mutex = __MUTEX_INITIALIZER(sname##_state.exp_mutex), \
 	.exp_wake_mutex = __MUTEX_INITIALIZER(sname##_state.exp_wake_mutex), \
+	.ofl_lock = __SPIN_LOCK_UNLOCKED(sname##_state.ofl_lock), \
 }
 
 RCU_STATE_INITIALIZER(rcu_sched, 's', call_rcu_sched);
@@ -1900,11 +1901,13 @@ static bool rcu_gp_init(struct rcu_state *rsp)
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
 
@@ -1940,6 +1943,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 		}
 
 		raw_spin_unlock_irq_rcu_node(rnp);
+		spin_unlock(&rsp->ofl_lock);
 	}
 
 	/*
@@ -3747,6 +3751,7 @@ static void rcu_cleanup_dying_idle_cpu(int cpu, struct rcu_state *rsp)
 
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
 	mask = rdp->grpmask;
+	spin_lock(&rsp->ofl_lock);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
 	if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
 		/* Report quiescent state -before- changing ->qsmaskinitnext! */
@@ -3755,6 +3760,7 @@ static void rcu_cleanup_dying_idle_cpu(int cpu, struct rcu_state *rsp)
 	}
 	rnp->qsmaskinitnext &= ~mask;
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	spin_unlock(&rsp->ofl_lock);
 }
 
 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 3def94fc9c74..6683da6e4ecc 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -363,6 +363,10 @@ struct rcu_state {
 	const char *name;			/* Name of structure. */
 	char abbr;				/* Abbreviated name. */
 	struct list_head flavors;		/* List of RCU flavors. */
+
+	spinlock_t ofl_lock ____cacheline_internodealigned_in_smp;
+						/* Synchronize offline with */
+						/*  GP pre-initialization. */
 };
 
 /* Values for rcu_state structure's gp_flags field. */

