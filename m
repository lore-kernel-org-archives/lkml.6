Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D52EC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFCB2088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFCB2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388668AbeG0RMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:12:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732059AbeG0RMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:12:05 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RFinaZ071145
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 11:49:34 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kg4n8wa84-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 11:49:34 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 27 Jul 2018 11:49:33 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Jul 2018 11:49:32 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6RFnVnl18481484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Jul 2018 15:49:31 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3438EB206A;
        Fri, 27 Jul 2018 11:49:10 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04689B2065;
        Fri, 27 Jul 2018 11:49:09 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jul 2018 11:49:09 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B319816CA3C6; Fri, 27 Jul 2018 08:49:31 -0700 (PDT)
Date:   Fri, 27 Jul 2018 08:49:31 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RFC tip/core/rcu] Avoid resched_cpu() when rescheduling the
 current CPU
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18072715-2213-0000-0000-000002D0C9DD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009438; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01066924; UDB=6.00548196; IPR=6.00844790;
 MB=3.00022355; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-27 15:49:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072715-2214-0000-0000-00005AFC1CF8
Message-Id: <20180727154931.GA12106@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807270160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Peter,

It occurred to me that it is wasteful to let resched_cpu() acquire
->pi_lock when doing something like resched_cpu(smp_processor_id()),
and that it would be better to instead use set_tsk_need_resched(current)
and set_preempt_need_resched().

But is doing so really worthwhile?  For that matter, are there some
constraints on the use of those two functions that I am failing to
allow for in the patch below?

							Thanx, Paul

------------------------------------------------------------------------

commit e95e2d26fff60af9bb4111a9c17461ecd5e17a7d
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Thu Jul 26 13:44:00 2018 -0700

    rcu: Avoid resched_cpu() when rescheduling the current CPU
    
    The resched_cpu() interface is quite handy, but it does acquire the
    specified CPU's runqueue lock, which does not come for free.  This
    commit therefore substitutes the following when directing resched_cpu()
    at the current CPU:
    
            set_tsk_need_resched(current);
            set_preempt_need_resched();
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Peter Zijlstra <peterz@infradead.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 595059141c40..061ceb171d8e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1353,7 +1353,8 @@ static void print_cpu_stall(void)
 	 * progress and it could be we're stuck in kernel space without context
 	 * switches for an entirely unreasonable amount of time.
 	 */
-	resched_cpu(smp_processor_id());
+	set_tsk_need_resched(current);
+	set_preempt_need_resched();
 }
 
 static void check_cpu_stall(struct rcu_data *rdp)
@@ -2674,10 +2675,12 @@ static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused
 	WARN_ON_ONCE(!rdp->beenonline);
 
 	/* Report any deferred quiescent states if preemption enabled. */
-	if (!(preempt_count() & PREEMPT_MASK))
+	if (!(preempt_count() & PREEMPT_MASK)) {
 		rcu_preempt_deferred_qs(current);
-	else if (rcu_preempt_need_deferred_qs(current))
-		resched_cpu(rdp->cpu); /* Provoke future context switch. */
+	} else if (rcu_preempt_need_deferred_qs(current)) {
+		set_tsk_need_resched(current);
+		set_preempt_need_resched();
+	}
 
 	/* Update RCU state based on any recent quiescent states. */
 	rcu_check_quiescent_state(rdp);
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index b3e2c873b8e4..62d363d7fab2 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -672,7 +672,8 @@ static void sync_rcu_exp_handler(void *unused)
 			rcu_report_exp_rdp(rdp);
 		} else {
 			rdp->deferred_qs = true;
-			resched_cpu(rdp->cpu);
+			set_tsk_need_resched(t);
+			set_preempt_need_resched();
 		}
 		return;
 	}
@@ -710,15 +711,16 @@ static void sync_rcu_exp_handler(void *unused)
 	 * because we are in an interrupt handler, which will cause that
 	 * function to take an early exit without doing anything.
 	 *
-	 * Otherwise, use resched_cpu() to force a context switch after
-	 * the CPU enables everything.
+	 * Otherwise, force a context switch after the CPU enables everything.
 	 */
 	rdp->deferred_qs = true;
 	if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
-	    WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs()))
+	    WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs())) {
 		rcu_preempt_deferred_qs(t);
-	else
-		resched_cpu(rdp->cpu);
+	} else {
+		set_tsk_need_resched(t);
+		set_preempt_need_resched();
+	}
 }
 
 /* PREEMPT=y, so no PREEMPT=n expedited grace period to clean up after. */
@@ -779,7 +781,8 @@ static void sync_sched_exp_handler(void *unused)
 	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, true);
 	/* Store .exp before .rcu_urgent_qs. */
 	smp_store_release(this_cpu_ptr(&rcu_dynticks.rcu_urgent_qs), true);
-	resched_cpu(smp_processor_id());
+	set_tsk_need_resched(current);
+	set_preempt_need_resched();
 }
 
 /* Send IPI for expedited cleanup if needed at end of CPU-hotplug operation. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 5f4c8bab7c72..d3ccf4389a67 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -791,8 +791,10 @@ static void rcu_flavor_check_callbacks(int user)
 	if (t->rcu_read_lock_nesting > 0 ||
 	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
 		/* No QS, force context switch if deferred. */
-		if (rcu_preempt_need_deferred_qs(t))
-			resched_cpu(smp_processor_id());
+		if (rcu_preempt_need_deferred_qs(t)) {
+			set_tsk_need_resched(t);
+			set_preempt_need_resched();
+		}
 	} else if (rcu_preempt_need_deferred_qs(t)) {
 		rcu_preempt_deferred_qs(t); /* Report deferred QS. */
 		return;

