Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C48C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C312084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C312084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeLLPzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:55:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726358AbeLLPzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:55:53 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBCFsEwa101921
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:55:51 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pb4pv2781-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:55:51 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 12 Dec 2018 15:55:49 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Dec 2018 15:55:47 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBCFtkK121561410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Dec 2018 15:55:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 072CBB205F;
        Wed, 12 Dec 2018 15:55:46 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9E58B2064;
        Wed, 12 Dec 2018 15:55:45 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 12 Dec 2018 15:55:45 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9282916C17E5; Wed, 12 Dec 2018 07:55:46 -0800 (PST)
Date:   Wed, 12 Dec 2018 07:55:46 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        tglx@linutronix.de, tj@kernel.org
Subject: Re: [PATCH] srcu: Remove srcu_queue_delayed_work_on()
Reply-To: paulmck@linux.ibm.com
References: <20181211111238.13474-1-bigeasy@linutronix.de>
 <20181212014016.GA97542@google.com>
 <20181212140519.GA10937@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212140519.GA10937@tardis>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18121215-0060-0000-0000-000002E2E942
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010214; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01130746; UDB=6.00587591; IPR=6.00910879;
 MB=3.00024669; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-12 15:55:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121215-0061-0000-0000-000047833198
Message-Id: <20181212155546.GY4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812120138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:05:19PM +0800, Boqun Feng wrote:
> Hi Joel,
> 
> On Tue, Dec 11, 2018 at 05:40:16PM -0800, Joel Fernandes wrote:
> > On Tue, Dec 11, 2018 at 12:12:38PM +0100, Sebastian Andrzej Siewior wrote:
> > > srcu_queue_delayed_work_on() disables preemption (and therefore CPU
> > > hotplug in RCU's case) and then checks based on its own accounting if a
> > > CPU is online. If the CPU is online it uses queue_delayed_work_on()
> > > otherwise it fallbacks to queue_delayed_work().
> > > The problem here is that queue_work() on -RT does not work with disabled
> > > preemption.
> > > 
> > > queue_work_on() works also on an offlined CPU. queue_delayed_work_on()
> > > has the problem that it is possible to program a timer on an offlined
> > > CPU. This timer will fire once the CPU is online again. But until then,
> > > the timer remains programmed and nothing will happen.
> > > Add a local timer which will fire (as requested per delay) on the local
> > > CPU and then enqueue the work on the specific CPU.
> > > 
> > > RCUtorture testing with SRCU-P for 24h showed no problems.
> > > 
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > ---
> > >  include/linux/srcutree.h |  3 ++-
> > >  kernel/rcu/srcutree.c    | 57 ++++++++++++++++++----------------------
> > >  kernel/rcu/tree.c        |  4 ---
> > >  kernel/rcu/tree.h        |  8 ------
> > >  4 files changed, 27 insertions(+), 45 deletions(-)
> > > 
> > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > index 6f292bd3e7db7..0faa978c98807 100644
> > > --- a/include/linux/srcutree.h
> > > +++ b/include/linux/srcutree.h
> > > @@ -45,7 +45,8 @@ struct srcu_data {
> > >  	unsigned long srcu_gp_seq_needed;	/* Furthest future GP needed. */
> > >  	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
> > >  	bool srcu_cblist_invoking;		/* Invoking these CBs? */
> > > -	struct delayed_work work;		/* Context for CB invoking. */
> > > +	struct timer_list delay_work;		/* Delay for CB invoking */
> > > +	struct work_struct work;		/* Context for CB invoking. */
> > >  	struct rcu_head srcu_barrier_head;	/* For srcu_barrier() use. */
> > >  	struct srcu_node *mynode;		/* Leaf srcu_node. */
> > >  	unsigned long grpmask;			/* Mask for leaf srcu_node */
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 3600d88d8956b..7f041f2435df9 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -58,6 +58,7 @@ static bool __read_mostly srcu_init_done;
> > >  static void srcu_invoke_callbacks(struct work_struct *work);
> > >  static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay);
> > >  static void process_srcu(struct work_struct *work);
> > > +static void srcu_delay_timer(struct timer_list *t);
> > >  
> > >  /* Wrappers for lock acquisition and release, see raw_spin_lock_rcu_node(). */
> > >  #define spin_lock_rcu_node(p)					\
> > > @@ -156,7 +157,8 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
> > >  			snp->grphi = cpu;
> > >  		}
> > >  		sdp->cpu = cpu;
> > > -		INIT_DELAYED_WORK(&sdp->work, srcu_invoke_callbacks);
> > > +		INIT_WORK(&sdp->work, srcu_invoke_callbacks);
> > > +		timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
> > >  		sdp->ssp = ssp;
> > >  		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
> > >  		if (is_static)
> > > @@ -386,13 +388,19 @@ void _cleanup_srcu_struct(struct srcu_struct *ssp, bool quiesced)
> > >  	} else {
> > >  		flush_delayed_work(&ssp->work);
> > >  	}
> > > -	for_each_possible_cpu(cpu)
> > > +	for_each_possible_cpu(cpu) {
> > > +		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
> > > +
> > >  		if (quiesced) {
> > > -			if (WARN_ON(delayed_work_pending(&per_cpu_ptr(ssp->sda, cpu)->work)))
> > > +			if (WARN_ON(timer_pending(&sdp->delay_work)))
> > > +				return; /* Just leak it! */
> > > +			if (WARN_ON(work_pending(&sdp->work)))
> > >  				return; /* Just leak it! */
> > >  		} else {
> > > -			flush_delayed_work(&per_cpu_ptr(ssp->sda, cpu)->work);
> > > +			del_timer_sync(&sdp->delay_work);
> > > +			flush_work(&sdp->work);
> > >  		}
> > > +	}
> > >  	if (WARN_ON(rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
> > >  	    WARN_ON(srcu_readers_active(ssp))) {
> > >  		pr_info("%s: Active srcu_struct %p state: %d\n",
> > > @@ -463,39 +471,23 @@ static void srcu_gp_start(struct srcu_struct *ssp)
> > >  	WARN_ON_ONCE(state != SRCU_STATE_SCAN1);
> > >  }
> > >  
> > > -/*
> > > - * Track online CPUs to guide callback workqueue placement.
> > > - */
> > > -DEFINE_PER_CPU(bool, srcu_online);
> > >  
> > > -void srcu_online_cpu(unsigned int cpu)
> > > +static void srcu_delay_timer(struct timer_list *t)
> > >  {
> > > -	WRITE_ONCE(per_cpu(srcu_online, cpu), true);
> > > +	struct srcu_data *sdp = container_of(t, struct srcu_data, delay_work);
> > > +
> > > +	queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
> > >  }
> > >  
> > > -void srcu_offline_cpu(unsigned int cpu)
> > > -{
> > > -	WRITE_ONCE(per_cpu(srcu_online, cpu), false);
> > > -}
> > > -
> > > -/*
> > > - * Place the workqueue handler on the specified CPU if online, otherwise
> > > - * just run it whereever.  This is useful for placing workqueue handlers
> > > - * that are to invoke the specified CPU's callbacks.
> > > - */
> > > -static bool srcu_queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
> > > -				       struct delayed_work *dwork,
> > > +static void srcu_queue_delayed_work_on(struct srcu_data *sdp,
> > >  				       unsigned long delay)
> > >  {
> > > -	bool ret;
> > > +	if (!delay) {
> > > +		queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
> > > +		return;
> > > +	}
> > >  
> > > -	preempt_disable();
> > > -	if (READ_ONCE(per_cpu(srcu_online, cpu)))
> > > -		ret = queue_delayed_work_on(cpu, wq, dwork, delay);
> > > -	else
> > > -		ret = queue_delayed_work(wq, dwork, delay);
> > > -	preempt_enable();
> > 
> > The deleted code looks like 'cpu' could be offlined.
> > 
> > Question for my clarification: According to sync_rcu_exp_select_cpus, we have
> > to disable preemption before calling queue_work_on to ensure the CPU is online.
> > 
> > Also same is said in Boqun's presentation on the topic:
> > https://linuxplumbersconf.org/event/2/contributions/158/attachments/68/79/workqueue_and_cpu_hotplug.pdf
> > 
> > Calling queue_work_on on an offline CPU sounds like could be problematic. So
> > in your patch, don't you still need to disable preemption around
> > queue_work_on, or the very least check if said CPU is online before calling
> > queue_work_on?
> > 
> 
> I should be the one who answers this ;-)
> 
> So I found something after my LPC topic, that is queue_work_on() may
> work well even if racing with a cpu offline. The reason is that in the
> cpu offline hook for workqueue only switches the percpu pool into an
> unbound one, so as long as the related cpu has been online once, we are
> fine here. 
> 
> Please note this is only my own analysis, and I'm the one who told
> Sebastian and Paul about this.
> 
> I should send an email to check with workqueue maintainers about this,
> but I didn't find the time. Sorry about this.. But let's do this right
> now, while we at it.
> 
> (Cc TJ)
> 
> So Jiangshan and TJ, what's your opion on this one? If we call a
> queue_work_on() at a place where that target cpu may be offlined, I
> think we have the guarantee that the work will be eventually executed
> even if the cpu is never online again, right? In other words, if a cpu
> has been online once, queue_work_on() on it will be free from racing
> with cpu hotplug.
> 
> Am I right about this, or did I miss something subtle?

Well, what I was relying on was Thomas Gleixner's assertion that it should
work and would be fixed if it didn't.  ;-)

							Thanx, Paul

> Regards,
> Boqun
> 
> > thanks,
> > 
> >  - Joel
> > 


