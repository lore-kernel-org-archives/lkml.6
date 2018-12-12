Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98F8C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9650B2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9650B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeLLPmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:42:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726325AbeLLPmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:42:31 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBCFYmje078718
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:42:29 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pb4kxswvv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:42:29 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 12 Dec 2018 15:42:27 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Dec 2018 15:42:24 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBCFgNv321299314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Dec 2018 15:42:23 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5446B2064;
        Wed, 12 Dec 2018 15:42:23 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4A02B2066;
        Wed, 12 Dec 2018 15:42:23 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 12 Dec 2018 15:42:23 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6C07516C17E5; Wed, 12 Dec 2018 07:42:24 -0800 (PST)
Date:   Wed, 12 Dec 2018 07:42:24 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "He, Bo" <bo.he@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "Zhang, Jun" <jun.zhang@intel.com>,
        "Xiao, Jin" <jin.xiao@intel.com>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>,
        "Bai, Jie A" <jie.a.bai@intel.com>
Subject: Re: rcu_preempt caused oom
Reply-To: paulmck@linux.ibm.com
References: <20181206173808.GI4170@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A180C5@SHSMSX104.ccr.corp.intel.com>
 <20181207141131.GP4170@linux.ibm.com>
 <20181209195601.GA7854@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A186D0@SHSMSX104.ccr.corp.intel.com>
 <20181211003838.GD4170@linux.ibm.com>
 <20181211044631.GA19942@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A18E53@SHSMSX104.ccr.corp.intel.com>
 <20181212022446.GV4170@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A192C3@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CD6925E8781EFD4D8E11882D20FC406D52A192C3@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18121215-0072-0000-0000-000003D857CE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010214; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01130741; UDB=6.00582089; IPR=6.00910875;
 MB=3.00024669; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-12 15:42:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121215-0073-0000-0000-00004A6B6145
Message-Id: <20181212154224.GX4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812120135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 01:21:33PM +0000, He, Bo wrote:
> we reproduce on two boards, but I still not see the show_rcu_gp_kthreads() dump logs, it seems the patch can't catch the scenario.
> I double confirmed the CONFIG_PROVE_RCU=y is enabled in the config as it's extracted from the /proc/config.gz.

Strange.

Are the systems responsive to sysrq keys once failure occurs?  If so, I will
provide you a sysrq-R or some such to dump out the RCU state.

								Thanx, Paul

> -----Original Message-----
> From: Paul E. McKenney <paulmck@linux.ibm.com> 
> Sent: Wednesday, December 12, 2018 10:25 AM
> To: He, Bo <bo.he@intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>; linux-kernel@vger.kernel.org; josh@joshtriplett.org; mathieu.desnoyers@efficios.com; jiangshanlai@gmail.com; Zhang, Jun <jun.zhang@intel.com>; Xiao, Jin <jin.xiao@intel.com>; Zhang, Yanmin <yanmin.zhang@intel.com>; Bai, Jie A <jie.a.bai@intel.com>
> Subject: Re: rcu_preempt caused oom
> 
> On Wed, Dec 12, 2018 at 01:37:40AM +0000, He, Bo wrote:
> > We reproduced the issue panic in hung_task with the patch "Improve diagnostics for failed RCU grace-period start", but unfortunately maybe it's due to the loglevel, the show_rcu_gp_kthreads doesn't print any logs, we will improve the build and run the test to double check.
> 
> Well, at least the diagnostics didn't prevent the problem from happening.  ;-)
> 
> 							Thanx, Paul
> 
> > -----Original Message-----
> > From: Paul E. McKenney <paulmck@linux.ibm.com>
> > Sent: Tuesday, December 11, 2018 12:47 PM
> > To: He, Bo <bo.he@intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>; 
> > linux-kernel@vger.kernel.org; josh@joshtriplett.org; 
> > mathieu.desnoyers@efficios.com; jiangshanlai@gmail.com; Zhang, Jun 
> > <jun.zhang@intel.com>; Xiao, Jin <jin.xiao@intel.com>; Zhang, Yanmin 
> > <yanmin.zhang@intel.com>; Bai, Jie A <jie.a.bai@intel.com>
> > Subject: Re: rcu_preempt caused oom
> > 
> > On Mon, Dec 10, 2018 at 04:38:38PM -0800, Paul E. McKenney wrote:
> > > On Mon, Dec 10, 2018 at 06:56:18AM +0000, He, Bo wrote:
> > > > Hi, 
> > > >    We have start the test with the CONFIG_PROVE_RCU=y, and also add one 2s to detect the preempt rcu hang, hope we can get more useful logs tomorrow.
> > > >    I also enclosed the config and the debug patches for you review.
> > > 
> > > I instead suggest the (lightly tested) debug patch shown below, 
> > > which tracks wakeups of RCU's grace-period kthreads and dumps them 
> > > out if a given requested grace period fails to start.  Again, it is 
> > > necessary to build with CONFIG_PROVE_RCU=y, that is, with CONFIG_PROVE_LOCKING=y.
> > 
> > Right.  This time without commenting out the wakeup as a test of the 
> > diagnostic.  :-/
> > 
> > Please use the patch below instead of the one that I sent in my previous email.
> > 
> > 							Thanx, Paul
> > 
> > ----------------------------------------------------------------------
> > --
> > 
> > commit adfc7dff659495a3433d5084256be59eee0ac6df
> > Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > Date:   Mon Dec 10 16:33:59 2018 -0800
> > 
> >     rcu: Improve diagnostics for failed RCU grace-period start
> >     
> >     Backported from v4.21/v5.0
> >     
> >     If a grace period fails to start (for example, because you commented
> >     out the last two lines of rcu_accelerate_cbs_unlocked()), rcu_core()
> >     will invoke rcu_check_gp_start_stall(), which will notice and complain.
> >     However, this complaint is lacking crucial debugging information such
> >     as when the last wakeup executed and what the value of ->gp_seq was at
> >     that time.  This commit therefore removes the current pr_alert() from
> >     rcu_check_gp_start_stall(), instead invoking show_rcu_gp_kthreads(),
> >     which has been updated to print the needed information, which is collected
> >     by rcu_gp_kthread_wake().
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index 
> > 0b760c1369f7..4bcd8753e293 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -626,25 +626,57 @@ void rcu_sched_force_quiescent_state(void)
> >  }
> >  EXPORT_SYMBOL_GPL(rcu_sched_force_quiescent_state);
> >  
> > +/*
> > + * Convert a ->gp_state value to a character string.
> > + */
> > +static const char *gp_state_getname(short gs) {
> > +	if (gs < 0 || gs >= ARRAY_SIZE(gp_state_names))
> > +		return "???";
> > +	return gp_state_names[gs];
> > +}
> > +
> > +/*
> > + * Return the root node of the specified rcu_state structure.
> > + */
> > +static struct rcu_node *rcu_get_root(struct rcu_state *rsp) {
> > +	return &rsp->node[0];
> > +}
> > +
> >  /*
> >   * Show the state of the grace-period kthreads.
> >   */
> >  void show_rcu_gp_kthreads(void)
> >  {
> >  	int cpu;
> > +	unsigned long j;
> > +	unsigned long ja;
> > +	unsigned long jr;
> > +	unsigned long jw;
> >  	struct rcu_data *rdp;
> >  	struct rcu_node *rnp;
> >  	struct rcu_state *rsp;
> >  
> > +	j = jiffies;
> >  	for_each_rcu_flavor(rsp) {
> > -		pr_info("%s: wait state: %d ->state: %#lx\n",
> > -			rsp->name, rsp->gp_state, rsp->gp_kthread->state);
> > +		ja = j - READ_ONCE(rsp->gp_activity);
> > +		jr = j - READ_ONCE(rsp->gp_req_activity);
> > +		jw = j - READ_ONCE(rsp->gp_wake_time);
> > +		pr_info("%s: wait state: %s(%d) ->state: %#lx delta ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
> > +			rsp->name, gp_state_getname(rsp->gp_state),
> > +			rsp->gp_state,
> > +			rsp->gp_kthread ? rsp->gp_kthread->state : 0x1ffffL,
> > +			ja, jr, jw, (long)READ_ONCE(rsp->gp_wake_seq),
> > +			(long)READ_ONCE(rsp->gp_seq),
> > +			(long)READ_ONCE(rcu_get_root(rsp)->gp_seq_needed),
> > +			READ_ONCE(rsp->gp_flags));
> >  		rcu_for_each_node_breadth_first(rsp, rnp) {
> >  			if (ULONG_CMP_GE(rsp->gp_seq, rnp->gp_seq_needed))
> >  				continue;
> > -			pr_info("\trcu_node %d:%d ->gp_seq %lu ->gp_seq_needed %lu\n",
> > -				rnp->grplo, rnp->grphi, rnp->gp_seq,
> > -				rnp->gp_seq_needed);
> > +			pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld\n",
> > +				rnp->grplo, rnp->grphi, (long)rnp->gp_seq,
> > +				(long)rnp->gp_seq_needed);
> >  			if (!rcu_is_leaf_node(rnp))
> >  				continue;
> >  			for_each_leaf_node_possible_cpu(rnp, cpu) { @@ -653,8 +685,8 @@ void show_rcu_gp_kthreads(void)
> >  				    ULONG_CMP_GE(rsp->gp_seq,
> >  						 rdp->gp_seq_needed))
> >  					continue;
> > -				pr_info("\tcpu %d ->gp_seq_needed %lu\n",
> > -					cpu, rdp->gp_seq_needed);
> > +				pr_info("\tcpu %d ->gp_seq_needed %ld\n",
> > +					cpu, (long)rdp->gp_seq_needed);
> >  			}
> >  		}
> >  		/* sched_show_task(rsp->gp_kthread); */ @@ -690,14 +722,6 @@ void 
> > rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,  }  
> > EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
> >  
> > -/*
> > - * Return the root node of the specified rcu_state structure.
> > - */
> > -static struct rcu_node *rcu_get_root(struct rcu_state *rsp) -{
> > -	return &rsp->node[0];
> > -}
> > -
> >  /*
> >   * Enter an RCU extended quiescent state, which can be either the
> >   * idle loop or adaptive-tickless usermode execution.
> > @@ -1285,16 +1309,6 @@ static void record_gp_stall_check_time(struct rcu_state *rsp)
> >  	rsp->n_force_qs_gpstart = READ_ONCE(rsp->n_force_qs);  }
> >  
> > -/*
> > - * Convert a ->gp_state value to a character string.
> > - */
> > -static const char *gp_state_getname(short gs) -{
> > -	if (gs < 0 || gs >= ARRAY_SIZE(gp_state_names))
> > -		return "???";
> > -	return gp_state_names[gs];
> > -}
> > -
> >  /*
> >   * Complain about starvation of grace-period kthread.
> >   */
> > @@ -1693,7 +1707,8 @@ static bool rcu_future_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
> >   * Don't do a self-awaken, and don't bother awakening when there is
> >   * nothing for the grace-period kthread to do (as in several CPUs
> >   * raced to awaken, and we lost), and finally don't try to awaken
> > - * a kthread that has not yet been created.
> > + * a kthread that has not yet been created.  If all those checks are
> > + * passed, track some debug information and awaken.
> >   */
> >  static void rcu_gp_kthread_wake(struct rcu_state *rsp)  { @@ -1701,6 +1716,8 @@ static void rcu_gp_kthread_wake(struct rcu_state *rsp)
> >  	    !READ_ONCE(rsp->gp_flags) ||
> >  	    !rsp->gp_kthread)
> >  		return;
> > +	WRITE_ONCE(rsp->gp_wake_time, jiffies);
> > +	WRITE_ONCE(rsp->gp_wake_seq, READ_ONCE(rsp->gp_seq));
> >  	swake_up_one(&rsp->gp_wq);
> >  }
> >  
> > @@ -2802,16 +2819,11 @@ rcu_check_gp_start_stall(struct rcu_state *rsp, struct rcu_node *rnp,
> >  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >  		return;
> >  	}
> > -	pr_alert("%s: g%ld->%ld gar:%lu ga:%lu f%#x gs:%d %s->state:%#lx\n",
> > -		 __func__, (long)READ_ONCE(rsp->gp_seq),
> > -		 (long)READ_ONCE(rnp_root->gp_seq_needed),
> > -		 j - rsp->gp_req_activity, j - rsp->gp_activity,
> > -		 rsp->gp_flags, rsp->gp_state, rsp->name,
> > -		 rsp->gp_kthread ? rsp->gp_kthread->state : 0x1ffffL);
> >  	WARN_ON(1);
> >  	if (rnp_root != rnp)
> >  		raw_spin_unlock_rcu_node(rnp_root);
> >  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > +	show_rcu_gp_kthreads();
> >  }
> >  
> >  /*
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h index 
> > 4e74df768c57..0e051d9b5f1a 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -327,6 +327,8 @@ struct rcu_state {
> >  	struct swait_queue_head gp_wq;		/* Where GP task waits. */
> >  	short gp_flags;				/* Commands for GP task. */
> >  	short gp_state;				/* GP kthread sleep state. */
> > +	unsigned long gp_wake_time;		/* Last GP kthread wake. */
> > +	unsigned long gp_wake_seq;		/* ->gp_seq at ^^^. */
> >  
> >  	/* End of fields guarded by root rcu_node's lock. */
> >  
> > 
> 
> 




