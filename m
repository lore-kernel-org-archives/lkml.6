Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A892C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C90420895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C90420895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeJMVZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 17:25:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726281AbeJMVZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 17:25:30 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9DDhfQp041042
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 09:48:16 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n3cw8g2pj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 09:48:16 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 13 Oct 2018 09:48:16 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 13 Oct 2018 09:48:13 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9DDmCGU27132156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 Oct 2018 13:48:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11AF5B2064;
        Sat, 13 Oct 2018 09:46:10 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA071B205F;
        Sat, 13 Oct 2018 09:46:09 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.131.128])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 13 Oct 2018 09:46:09 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B246616C0F04; Sat, 13 Oct 2018 06:48:13 -0700 (PDT)
Date:   Sat, 13 Oct 2018 06:48:13 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: Use cpus_read_lock() while looking at
 cpu_online_mask
Reply-To: paulmck@linux.ibm.com
References: <20180910135615.tr3cvipwbhq6xug4@linutronix.de>
 <20180911160532.GJ4225@linux.vnet.ibm.com>
 <20180911162142.cc3vgook2gctus4c@linutronix.de>
 <20180911170222.GO4225@linux.vnet.ibm.com>
 <20180919205521.GE902964@devbig004.ftw2.facebook.com>
 <20180919221140.GH4222@linux.ibm.com>
 <20181012184114.w332lnkc34evd4sm@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012184114.w332lnkc34evd4sm@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18101313-0052-0000-0000-000003431887
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009872; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01102078; UDB=6.00570337; IPR=6.00882123;
 MB=3.00023742; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-13 13:48:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101313-0053-0000-0000-00005E66AFB8
Message-Id: <20181013134813.GD2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-13_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810130131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 08:41:15PM +0200, Sebastian Andrzej Siewior wrote:
> On 2018-09-19 15:11:40 [-0700], Paul E. McKenney wrote:
> > On Wed, Sep 19, 2018 at 01:55:21PM -0700, Tejun Heo wrote:
> > > Unbound workqueue is NUMA-affine by default, so using it by default
> > > might not harm anything.
> > 
> > OK, so the above workaround would function correctly on -rt, thank you!
> > 
> > Sebastian, is there a counterpart to CONFIG_PREEMPT_RT already in
> > mainline?  If so, I would be happy to make mainline safe for -rt.
> 
> Now that I stumbled upon it again, I noticed that I never replied here.
> Sorry for that.
> 
> Let me summarize:
> sync_rcu_exp_select_cpus() used
> 	queue_work_on(rnp->grplo, rcu_par_gp_wq, &rnp->rew.rew_work);
> 
> which was changed in commit fcc6354365015 ("rcu: Make expedited GPs
> handle CPU 0 being offline"). The commit claims that this is needed in
> case CPU0 is offline so it tries to find another CPU starting with the
> possible offline CPU. It might cross to another NUMA node but that is
> not really a problem, it just tries to remain on the "local NUMA node".
> 
> After that commit, the code invokes queue_work_on() within a
> preempt_disable() section because it can't use cpus_read_lock() to
> ensure that the CPU won't go offline in the middle of testing (and
> preempt_disable() does the trick).
> For RT reasons I would like to get rid of queue_work_on() within the
> preempt_disable() section.
> Tejun said that enqueueing an item on an unbound workqueue is NUMA
> affine.
> 
> I figured out that enqueueing an item on an offline CPU is not a problem
> and it will pop up on a "random" CPU which means it will be carried out
> asap and will not wait until the CPU gets back online. Therefore I don't
> understand the commit fcc6354365015.
> 
> May I suggest the following change? It will enqueue the work item on
> the first CPU on the NUMA node and the "unbound" part of the work queue
> ensures that a CPU of that NUMA node will perform the work.
> This is mostly a revert of fcc6354365015 except that the workqueue
> gained the WQ_UNBOUND flag.

My concern would be that it would queue it by default for the current
CPU, which would serialize the processing, losing the concurrency of
grace-period initialization.  But that was a long time ago, and perhaps
workqueues have changed.  So, have you tried using rcuperf to test the
update performance on a large system?

If this change does not impact performance on an rcuperf test, why not
send me a formal patch with Signed-off-by and commit log (including
performance testing results)?  I will then apply it, it will be exposed
to 0day and eventually -next testing, and if no problems arise, it will go
to mainline, perhaps as soon as the merge window after the upcoming one.

Fair enough?

							Thanx, Paul

> ------------------>8----
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 0b760c1369f76..94d6c50c4e796 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4162,7 +4162,7 @@ void __init rcu_init(void)
>  	/* Create workqueue for expedited GPs and for Tree SRCU. */
>  	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
>  	WARN_ON(!rcu_gp_wq);
> -	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
> +	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
>  	WARN_ON(!rcu_par_gp_wq);
>  }
>  
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 0b2c2ad69629c..a0486414edb40 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -472,7 +472,6 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
>  static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
>  				     smp_call_func_t func)
>  {
> -	int cpu;
>  	struct rcu_node *rnp;
>  
>  	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("reset"));
> @@ -494,13 +493,7 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
>  			continue;
>  		}
>  		INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
> -		preempt_disable();
> -		cpu = cpumask_next(rnp->grplo - 1, cpu_online_mask);
> -		/* If all offline, queue the work on an unbound CPU. */
> -		if (unlikely(cpu > rnp->grphi))
> -			cpu = WORK_CPU_UNBOUND;
> -		queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
> -		preempt_enable();
> +		queue_work_on(rnp->grplo, rcu_par_gp_wq, &rnp->rew.rew_work);
>  		rnp->exp_need_flush = true;
>  	}
>  
> 
> > 
> > 							Thanx, Paul
> 
> Sebastian
> 

