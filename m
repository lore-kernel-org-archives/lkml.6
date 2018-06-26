Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FFCC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DDC26A84
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DDC26A84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935169AbeFZM3y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:29:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933509AbeFZM3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:29:52 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QCTFVQ078792
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 08:29:51 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jukyccbh6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 08:29:51 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 08:29:50 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 08:29:45 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QCTieP7733622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 12:29:44 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30CF5B2065;
        Tue, 26 Jun 2018 08:29:38 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6EECB2064;
        Tue, 26 Jun 2018 08:29:37 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.202.60])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 08:29:37 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 295C816C5DDD; Tue, 26 Jun 2018 05:31:49 -0700 (PDT)
Date:   Tue, 26 Jun 2018 05:31:49 -0700
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
x-cbid: 18062612-0072-0000-0000-00000374AC3D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009258; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052575; UDB=6.00539612; IPR=6.00830499;
 MB=3.00021861; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 12:29:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062612-0073-0000-0000-0000487DDBA2
Message-Id: <20180626123149.GY3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260142
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
> 
> So the patch has passed one 30 min run for TREE03 rcutorture. Paul,
> if it looks good, could you take it for your next spin or pull request
> in the future? Thanks.

Looks much improved, thank you both!  I will pull this in later
today, Pacific Time.

							Thanx, Paul

> Regards,
> Boqun
> 
> -------------->8
> Subject: [PATCH tip/core/rcu v2] rcu: exp: Make expedited GPs handle CPU 0 being offline
> 
> Currently, the parallelized initialization of expedited grace periods
> uses the workqueue associated with each rcu_node structure's ->grplo
> field.  This works fine unless that CPU is offline.  This commit
> therefore uses the CPU corresponding to the lowest-numbered online CPU,
> or fallback to queue the work on WORK_CPU_UNBOUND if there are no online
> CPUs on this rcu_node structure.
> 
> Note that this patch uses cpu_online_mask instead of the usual approach
> of checking bits in the rcu_node structure's ->qsmaskinitnext field.
> This is safe because preemption is disabled across both the
> cpu_online_mask check and the call to queue_work_on().
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> [ paulmck: Disable preemption to close offline race window. ]
> Not-Yet-Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> ---
> v1 --> v2:
> 	
> *	Replace the for_each_leaf_node_possible_cpu() + cpu_is_offline()
> 	check loop with a single cpumask_next() as suggested by Peter
> 	Zijlstra
> 
>  kernel/rcu/tree_exp.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index d40708e8c5d6..3bf87fd4bd91 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -473,6 +473,7 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
>  				     smp_call_func_t func)
>  {
>  	struct rcu_node *rnp;
> +	int cpu;
> 
>  	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("reset"));
>  	sync_exp_reset_tree(rsp);
> @@ -492,7 +493,13 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
>  			continue;
>  		}
>  		INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
> -		queue_work_on(rnp->grplo, rcu_par_gp_wq, &rnp->rew.rew_work);
> +		preempt_disable();
> +		cpu = cpumask_next(rnp->grplo - 1, cpu_online_mask);
> +		/* All offlines, queue the work on an unbound CPU */
> +		if (unlikely(cpu > rnp->grphi))
> +			cpu = WORK_CPU_UNBOUND;
> +		queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
> +		preempt_enable();
>  		rnp->exp_need_flush = true;
>  	}
> 
> -- 
> 2.17.1
> 

