Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B83C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF1F2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF1F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbeIKVFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:05:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726689AbeIKVFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:05:38 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8BFxgkC073864
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 12:05:38 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2megfascb5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 12:05:38 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 11 Sep 2018 12:05:37 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Sep 2018 12:05:33 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8BG5Wmc65339614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Sep 2018 16:05:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDF0BB205F;
        Tue, 11 Sep 2018 12:04:11 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC7D9B2064;
        Tue, 11 Sep 2018 12:04:11 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 11 Sep 2018 12:04:11 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 88E5F16C37B7; Tue, 11 Sep 2018 09:05:32 -0700 (PDT)
Date:   Tue, 11 Sep 2018 09:05:32 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: Use cpus_read_lock() while looking at
 cpu_online_mask
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180910135615.tr3cvipwbhq6xug4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910135615.tr3cvipwbhq6xug4@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18091116-2213-0000-0000-000002EC8F19
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009703; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01086819; UDB=6.00561157; IPR=6.00866831;
 MB=3.00023233; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-11 16:05:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091116-2214-0000-0000-00005B84C64C
Message-Id: <20180911160532.GJ4225@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809110161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 03:56:16PM +0200, Sebastian Andrzej Siewior wrote:
> It was possible that sync_rcu_exp_select_cpus() enqueued something on
> CPU0 while CPU0 was offline. Such a work item wouldn't be processed
> until CPU0 gets back online. This problem was addressed in commit
> fcc6354365015 ("rcu: Make expedited GPs handle CPU 0 being offline"). I
> don't think the issue fully addressed.
> 
> Assume grplo = 0 and grphi = 7 and sync_rcu_exp_select_cpus() is invoked
> on CPU1. The preempt_disable() section on CPU1 won't ensure that CPU0
> remains online between looking at cpu_online_mask and invoking
> queue_work_on() on CPU1.
> 
> Use cpus_read_lock() to ensure that `cpu' is not going down between
> looking at cpu_online_mask at invoking queue_work_on() and waiting for
> its completion. It is added around the loop + flush_work() which is
> similar to work_on_cpu_safe() (and we can have multiple jobs running on
> NUMA systems).

Is this experimental or theoretical?  If theoretical, the counter-theory
is that the stop-machine processing prevents any of the cpu_online_mask
bits from changing, though, yes, we would like to get rid of the
stop-machine processing.  So either way, yes, the current state could
use some improvement.

But one problem with the patch below is that sync_rcu_exp_select_cpus()
can be called while the cpu_hotplug_lock is write-held.  Or is that
somehow OK these days?  Assuming not, how about the (untested) patch
below?

							Thanx, Paul

> Fixes: fcc6354365015 ("rcu: Make expedited GPs handle CPU 0 being
> 		      offline")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/rcu/tree_exp.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 01b6ddeb4f050..a104cf91e6b90 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -479,6 +479,7 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
>  	sync_exp_reset_tree(rsp);
>  	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("select"));
> 
> +	cpus_read_lock();
>  	/* Schedule work for each leaf rcu_node structure. */
>  	rcu_for_each_leaf_node(rsp, rnp) {
>  		rnp->exp_need_flush = false;
> @@ -493,13 +494,11 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
>  			continue;
>  		}
>  		INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
> -		preempt_disable();
>  		cpu = cpumask_next(rnp->grplo - 1, cpu_online_mask);
>  		/* If all offline, queue the work on an unbound CPU. */
>  		if (unlikely(cpu > rnp->grphi))
>  			cpu = WORK_CPU_UNBOUND;
>  		queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
> -		preempt_enable();
>  		rnp->exp_need_flush = true;
>  	}
> 
> @@ -507,6 +506,7 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
>  	rcu_for_each_leaf_node(rsp, rnp)
>  		if (rnp->exp_need_flush)
>  			flush_work(&rnp->rew.rew_work);
> +	cpus_read_unlock();
>  }
> 
>  static void synchronize_sched_expedited_wait(struct rcu_state *rsp)

commit 5214cbbfe6a5d6b92c76c4e411a049fe57245d4a
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Tue Sep 11 08:57:48 2018 -0700

    rcu: Stop expedited grace periods from relying on stop-machine
    
    The CPU-selection code in sync_rcu_exp_select_cpus() disables preemption
    to prevent the cpu_online_mask from changing.  However, this relies on
    the stop-machine mechanism in the CPU-hotplug offline code, which is not
    desirable (it would be good to someday remove the stop-machine mechanism).
    
    This commit therefore instead uses the relevant leaf rcu_node structure's
    ->ffmask, which has a bit set for all CPUs that are fully functional.
    A given CPU's bit is cleared very early during offline processing by
    rcutree_offline_cpu() and set very late during online processsing by
    rcutree_online_cpu().  Therefore, if a CPU's bit is set in this mask, and
    preemption is disabled, we have to be before the synchronize_sched() in
    the CPU-hotplug offline code, which means that the CPU is guaranteed to be
    workqueue-ready throughout the duration of the enclosing preempt_disable()
    region of code.
    
    This also has the side-effect of using WORK_CPU_UNBOUND if all the CPUs for
    this leaf rcu_node structure are offline, which is an acceptable difference
    in behavior.
    
    Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 8d18c1014e2b..e669ccf3751b 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -450,10 +450,12 @@ static void sync_rcu_exp_select_cpus(smp_call_func_t func)
 		}
 		INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
 		preempt_disable();
-		cpu = cpumask_next(rnp->grplo - 1, cpu_online_mask);
+		cpu = find_next_bit(&rnp->ffmask, BITS_PER_LONG, -1);
 		/* If all offline, queue the work on an unbound CPU. */
-		if (unlikely(cpu > rnp->grphi))
+		if (unlikely(cpu > rnp->grphi - rnp->grplo))
 			cpu = WORK_CPU_UNBOUND;
+		else
+			cpu += rnp->grplo;
 		queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
 		preempt_enable();
 		rnp->exp_need_flush = true;

