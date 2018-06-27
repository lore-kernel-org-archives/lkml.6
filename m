Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7920C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA4125E7C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA4125E7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934966AbeF0QNc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:13:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964884AbeF0QNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:13:31 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5RG3cS3136494
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:13:31 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jvdc3htx4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:13:30 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 27 Jun 2018 12:13:29 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Jun 2018 12:13:25 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5RGDOfR10879456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jun 2018 16:13:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEA26B2065;
        Wed, 27 Jun 2018 12:13:16 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76603B205F;
        Wed, 27 Jun 2018 12:13:16 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jun 2018 12:13:16 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1692716C3E2E; Wed, 27 Jun 2018 09:15:31 -0700 (PDT)
Date:   Wed, 27 Jun 2018 09:15:31 -0700
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
 <20180626192746.GJ3593@linux.vnet.ibm.com>
 <20180627024201.GA27704@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627024201.GA27704@tardis>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062716-2213-0000-0000-000002C0C98A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009264; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01053130; UDB=6.00539945; IPR=6.00831054;
 MB=3.00021883; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-27 16:13:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062716-2214-0000-0000-00005AA0A9A3
Message-Id: <20180627161531.GB3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 10:42:01AM +0800, Boqun Feng wrote:
> On Tue, Jun 26, 2018 at 12:27:47PM -0700, Paul E. McKenney wrote:
> > On Tue, Jun 26, 2018 at 07:46:52PM +0800, Boqun Feng wrote:
> > > On Tue, Jun 26, 2018 at 06:44:47PM +0800, Boqun Feng wrote:
> > > > On Tue, Jun 26, 2018 at 11:38:20AM +0200, Peter Zijlstra wrote:
> > > > > On Mon, Jun 25, 2018 at 03:43:32PM -0700, Paul E. McKenney wrote:
> > > > > > +		preempt_disable();
> > > > > > +		for_each_leaf_node_possible_cpu(rnp, cpu) {
> > > > > > +			if (cpu_is_offline(cpu)) /* Preemption disabled. */
> > > > > > +				continue;
> > > > > 
> > > > > Create for_each_node_online_cpu() instead? Seems a bit pointless to
> > > > > iterate possible mask only to then check it against the online mask.
> > > > > Just iterate the online mask directly.
> > > > > 
> > > > > Or better yet, write this as:
> > > > > 
> > > > > 	preempt_disable();
> > > > > 	cpu = cpumask_next(rnp->grplo - 1, cpu_online_mask);
> > > > > 	if (cpu > rnp->grphi)
> > > > > 		cpu = WORK_CPU_UNBOUND;
> > > > > 	queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
> > > > > 	preempt_enable();
> > > > > 
> > > > > Which is what it appears to be doing.
> > > > > 
> > > > 
> > > > Make sense! Thanks ;-)
> > > > 
> > > > Applied this and running a TREE03 rcutorture. If all go well, I will
> > > > send the updated patch.
> > > > 
> > > 
> > > So the patch has passed one 30 min run for TREE03 rcutorture. Paul,
> > > if it looks good, could you take it for your next spin or pull request
> > > in the future? Thanks.
> > 
> > I ended up with the following, mostly just rewording the comment and
> > adding a one-liner on the change.  Does this work for you?
> 
> Looks good to me. Only one thing I think we need to modify a little,
> please see below:
> 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit ef31fa78032536d594630d7bd315d3faf60d98ca
> > Author: Boqun Feng <boqun.feng@gmail.com>
> > Date:   Fri Jun 15 12:06:31 2018 -0700
> > 
> >     rcu: Make expedited GPs handle CPU 0 being offline
> >     
> >     Currently, the parallelized initialization of expedited grace periods uses
> >     the workqueue associated with each rcu_node structure's ->grplo field.
> >     This works fine unless that CPU is offline.  This commit therefore
> >     uses the CPU corresponding to the lowest-numbered online CPU, or just
> >     reports the quiescent states if there are no online CPUs on this rcu_node
> >     structure.
> 
> better write "or just queue the work on WORK_CPU_UNBOUND if there are
> no online CPUs on this rcu_node structure"? Because we currently don't
> report the QS directly if all CPU are offline.
> 
> Thoughts?

Any objections?  If I don't hear any by tomorrow morning (Pacific Time),
I will make this change.

							Thanx, Paul

> Regards,
> Boqun
> 
> >     
> >     Note that this patch uses cpu_is_offline() instead of the usual
> >     approach of checking bits in the rcu_node structure's ->qsmaskinitnext
> >     field.  This is safe because preemption is disabled across both the
> >     cpu_is_offline() check and the call to queue_work_on().
> >     
> >     Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> >     [ paulmck: Disable preemption to close offline race window. ]
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >     [ paulmck: Apply Peter Zijlstra feedback on CPU selection. ]
> > 
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index c6385ee1af65..b3df3b770afb 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -472,6 +472,7 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> >  static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
> >  				     smp_call_func_t func)
> >  {
> > +	int cpu;
> >  	struct rcu_node *rnp;
> >  
> >  	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("reset"));
> > @@ -493,7 +494,13 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
> >  			continue;
> >  		}
> >  		INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
> > -		queue_work_on(rnp->grplo, rcu_par_gp_wq, &rnp->rew.rew_work);
> > +		preempt_disable();
> > +		cpu = cpumask_next(rnp->grplo - 1, cpu_online_mask);
> > +		/* If all offline, queue the work on an unbound CPU. */
> > +		if (unlikely(cpu > rnp->grphi))
> > +			cpu = WORK_CPU_UNBOUND;
> > +		queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
> > +		preempt_enable();
> >  		rnp->exp_need_flush = true;
> >  	}
> >  
> > 


