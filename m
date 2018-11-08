Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B616AECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F132089F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F132089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeKIDKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:10:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726634AbeKIDKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:10:21 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8HStxN008005
        for <linux-kernel@vger.kernel.org>; Thu, 8 Nov 2018 12:33:49 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nmqtq5j39-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 12:33:49 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 8 Nov 2018 17:33:48 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Nov 2018 17:33:46 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA8HXj8128835960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 17:33:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AC80B2065;
        Thu,  8 Nov 2018 17:33:45 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26271B2066;
        Thu,  8 Nov 2018 17:33:45 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.215.156])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Nov 2018 17:33:45 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B840716C35ED; Thu,  8 Nov 2018 09:33:44 -0800 (PST)
Date:   Thu, 8 Nov 2018 09:33:44 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: EXP rcu: Revert expedited GP parallelization cleverness
Reply-To: paulmck@linux.ibm.com
References: <20181101233031.GA13002@linux.ibm.com>
 <20181108165845.bzx6pjtmm3u7yur7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108165845.bzx6pjtmm3u7yur7@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110817-0052-0000-0000-00000352BE16
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010008; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000269; SDB=6.01114539; UDB=6.00577845; IPR=6.00894638;
 MB=3.00024077; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-08 17:33:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110817-0053-0000-0000-00005EB31054
Message-Id: <20181108173344.GN4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 05:58:45PM +0100, Sebastian Andrzej Siewior wrote:
> On 2018-11-01 16:30:31 [-0700], Paul E. McKenney wrote:
> > > (Commit 258ba8e089db23f760139266c232f01bad73f85c from linux-rcu)
> > > 
> > > This commit reverts a series of commits starting with fcc635436501 ("rcu:
> > > Make expedited GPs handle CPU 0 being offline") and its successors, thus
> > > queueing each rcu_node structure's expedited grace-period initialization
> > > work on the first CPU of that rcu_node structure.
> > > 
> > > Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > 
> > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > index 0b2c2ad69629..a0486414edb4 100644
> > > --- a/kernel/rcu/tree_exp.h
> > > +++ b/kernel/rcu/tree_exp.h
> > > @@ -472,7 +472,6 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> > >  static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
> > >  				     smp_call_func_t func)
> > >  {
> > > -	int cpu;
> > >  	struct rcu_node *rnp;
> > >  
> > >  	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("reset"));
> > > @@ -494,13 +493,7 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
> > >  			continue;
> > >  		}
> > >  		INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
> > > -		preempt_disable();
> > > -		cpu = cpumask_next(rnp->grplo - 1, cpu_online_mask);
> > > -		/* If all offline, queue the work on an unbound CPU. */
> > > -		if (unlikely(cpu > rnp->grphi))
> > > -			cpu = WORK_CPU_UNBOUND;
> > > -		queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
> > > -		preempt_enable();
> > > +		queue_work_on(rnp->grplo, rcu_par_gp_wq, &rnp->rew.rew_work);
> > >  		rnp->exp_need_flush = true;
> > >  	}
> > 
> > How about instead changing the earlier "if" statement to read as follows?
> > 
> > 		if (!READ_ONCE(rcu_par_gp_wq) ||
> > 		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
> > 		    rcu_is_last_leaf_node(rnp) ||
> > 		    IS_ENABLED(CONFIG_PREEMPT_RT_FULL)) {
> > 			/* No workqueues yet or last leaf, do direct call. */
> > 			sync_rcu_exp_select_node_cpus(&rnp->rew.rew_work);
> > 			continue;
> > 		}
> > 
> > This just adds the "|| IS_ENABLED(CONFIG_PREEMPT_RT_FULL)" to the "if"
> > condition.
> > 
> > The advantage of this approach is that it leaves the parallelization
> > alone for mainline, and avoids the overhead of the workqueues for -rt.
> 
> I don't oppose to the workqueue approach. It is just preempt_disable() +
> workqueue don't work on -RT. And if I remember correctly, we can't take
> CPU hotplug lock for other reasons (which woould make the
> preempt_disable() go away). Also the original argument why that patch
> went in was not solid so I though removing the extra complexity would be
> a good thing.

From what I can see, always using the unbound workqueue can serialize
things on some platforms, which kind of defeats the whole purpose of
using the workqueues in the first place.

> However using sync_rcu_exp_select_node_cpus() (based von v4.20-rc1)
> should work on -RT from what I can see. And performance wise it should
> not matter for -RT because the whole synchronize_.*_expedited() is
> disabled on -RT anyway. So it should be used only during boot-up.

Agreed, which was why I proposed making -RT use the boot-time code path,
given that -RT only uses this code during boot.  ;-)

							Thanx, Paul

