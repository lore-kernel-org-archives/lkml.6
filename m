Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE80AC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E1326AF9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E1326AF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753064AbeFZTZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:25:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752034AbeFZTZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:25:47 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QJE8u7107579
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 15:25:47 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jusqwvdpu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 15:25:47 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 15:25:46 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 15:25:42 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QJPfvR6357630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 19:25:41 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26782B2068;
        Tue, 26 Jun 2018 15:25:35 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1E62B2064;
        Tue, 26 Jun 2018 15:25:34 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 15:25:34 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 05BD616CA0A3; Tue, 26 Jun 2018 12:27:47 -0700 (PDT)
Date:   Tue, 26 Jun 2018 12:27:47 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 2/2] rcu: Make expedited GPs handle CPU 0
 being offline
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180625224308.GA10064@linux.vnet.ibm.com>
 <20180625224332.10596-2-paulmck@linux.vnet.ibm.com>
 <20180626093820.GG2494@hirez.programming.kicks-ass.net>
 <20180626104447.GG9125@tardis>
 <20180626114652.GH9125@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626114652.GH9125@tardis>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062619-0072-0000-0000-00000374D527
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052714; UDB=6.00539696; IPR=6.00830638;
 MB=3.00021867; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 19:25:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062619-0073-0000-0000-0000487EBDE4
Message-Id: <20180626192746.GJ3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 07:46:52PM +0800, Boqun Feng wrote:
> On Tue, Jun 26, 2018 at 06:44:47PM +0800, Boqun Feng wrote:
> > On Tue, Jun 26, 2018 at 11:38:20AM +0200, Peter Zijlstra wrote:
> > > On Mon, Jun 25, 2018 at 03:43:32PM -0700, Paul E. McKenney wrote:
> > > > +		preempt_disable();
> > > > +		for_each_leaf_node_possible_cpu(rnp, cpu) {
> > > > +			if (cpu_is_offline(cpu)) /* Preemption disabled. */
> > > > +				continue;
> > > 
> > > Create for_each_node_online_cpu() instead? Seems a bit pointless to
> > > iterate possible mask only to then check it against the online mask.
> > > Just iterate the online mask directly.
> > > 
> > > Or better yet, write this as:
> > > 
> > > 	preempt_disable();
> > > 	cpu = cpumask_next(rnp->grplo - 1, cpu_online_mask);
> > > 	if (cpu > rnp->grphi)
> > > 		cpu = WORK_CPU_UNBOUND;
> > > 	queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
> > > 	preempt_enable();
> > > 
> > > Which is what it appears to be doing.
> > > 
> > 
> > Make sense! Thanks ;-)
> > 
> > Applied this and running a TREE03 rcutorture. If all go well, I will
> > send the updated patch.
> > 
> 
> So the patch has passed one 30 min run for TREE03 rcutorture. Paul,
> if it looks good, could you take it for your next spin or pull request
> in the future? Thanks.

I ended up with the following, mostly just rewording the comment and
adding a one-liner on the change.  Does this work for you?

							Thanx, Paul

------------------------------------------------------------------------

commit ef31fa78032536d594630d7bd315d3faf60d98ca
Author: Boqun Feng <boqun.feng@gmail.com>
Date:   Fri Jun 15 12:06:31 2018 -0700

    rcu: Make expedited GPs handle CPU 0 being offline
    
    Currently, the parallelized initialization of expedited grace periods uses
    the workqueue associated with each rcu_node structure's ->grplo field.
    This works fine unless that CPU is offline.  This commit therefore
    uses the CPU corresponding to the lowest-numbered online CPU, or just
    reports the quiescent states if there are no online CPUs on this rcu_node
    structure.
    
    Note that this patch uses cpu_is_offline() instead of the usual
    approach of checking bits in the rcu_node structure's ->qsmaskinitnext
    field.  This is safe because preemption is disabled across both the
    cpu_is_offline() check and the call to queue_work_on().
    
    Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
    [ paulmck: Disable preemption to close offline race window. ]
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    [ paulmck: Apply Peter Zijlstra feedback on CPU selection. ]

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index c6385ee1af65..b3df3b770afb 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -472,6 +472,7 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
 				     smp_call_func_t func)
 {
+	int cpu;
 	struct rcu_node *rnp;
 
 	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("reset"));
@@ -493,7 +494,13 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
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
 

