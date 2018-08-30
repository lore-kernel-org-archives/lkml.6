Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC7CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D1520661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D1520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeH3HXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 03:23:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727233AbeH3HXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 03:23:24 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7U3IjtI001644
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 23:23:23 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m61x8n1gs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 23:23:23 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 23:23:21 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 23:23:17 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7U3NGrj66584668
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Aug 2018 03:23:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4A4AB205F;
        Wed, 29 Aug 2018 23:22:11 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68962B2064;
        Wed, 29 Aug 2018 23:22:11 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.196.106])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 23:22:11 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5DAD016C8DED; Wed, 29 Aug 2018 20:23:15 -0700 (PDT)
Date:   Wed, 29 Aug 2018 20:23:15 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH tip/core/rcu 3/3] srcu: Make early-boot call_srcu() reuse
 workqueue lists
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180829212036.GA22033@linux.vnet.ibm.com>
 <20180829212313.22903-3-paulmck@linux.vnet.ibm.com>
 <20180829215616.1c10e476@vmware.local.home>
 <20180830020701.GE4225@linux.vnet.ibm.com>
 <20180829224609.5ffdc9ec@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829224609.5ffdc9ec@vmware.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18083003-0064-0000-0000-0000034440C3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009637; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080838; UDB=6.00557554; IPR=6.00860822;
 MB=3.00023004; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-30 03:23:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18083003-0065-0000-0000-00003A78FA11
Message-Id: <20180830032315.GG4225@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808300032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:46:09PM -0400, Steven Rostedt wrote:
> On Wed, 29 Aug 2018 19:07:01 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Wed, Aug 29, 2018 at 09:56:16PM -0400, Steven Rostedt wrote:
> > > On Wed, 29 Aug 2018 14:23:13 -0700
> > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > >   
> > > > Allocating a list_head structure that is almost never used, and, when
> > > > used, is used only during early boot (rcu_init() and earlier), is a bit
> > > > wasteful.  This commit therefore eliminates that list_head in favor of
> > > > the one in the work_struct structure.  This is safe because the work_struct
> > > > structure cannot be used until after rcu_init() returns.
> > > > 
> > > > Reported-by: Steven Rostedt <rostedt@goodmis.org>
> > > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > Cc: Tejun Heo <tj@kernel.org>
> > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > ---
> > > >  include/linux/srcutiny.h |  2 --
> > > >  include/linux/srcutree.h |  3 +--
> > > >  kernel/rcu/srcutiny.c    | 10 +++++-----
> > > >  kernel/rcu/srcutree.c    | 11 +++++------
> > > >  4 files changed, 11 insertions(+), 15 deletions(-)
> > > > 
> > > > diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> > > > index 2b5c0822e683..f41d2fb09f87 100644
> > > > --- a/include/linux/srcutiny.h
> > > > +++ b/include/linux/srcutiny.h
> > > > @@ -36,7 +36,6 @@ struct srcu_struct {
> > > >  	struct rcu_head *srcu_cb_head;	/* Pending callbacks: Head. */
> > > >  	struct rcu_head **srcu_cb_tail;	/* Pending callbacks: Tail. */
> > > >  	struct work_struct srcu_work;	/* For driving grace periods. */
> > > > -	struct list_head srcu_boot_entry; /* Early-boot callbacks. */
> > > >  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> > > >  	struct lockdep_map dep_map;
> > > >  #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> > > > @@ -49,7 +48,6 @@ void srcu_drive_gp(struct work_struct *wp);
> > > >  	.srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),	\
> > > >  	.srcu_cb_tail = &name.srcu_cb_head,				\
> > > >  	.srcu_work = __WORK_INITIALIZER(name.srcu_work, srcu_drive_gp),	\
> > > > -	.srcu_boot_entry = LIST_HEAD_INIT(name.srcu_boot_entry),	\
> > > >  	__SRCU_DEP_MAP_INIT(name)					\
> > > >  }
> > > >  
> > > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > > index 9cfa4610113a..0ae91b3a7406 100644
> > > > --- a/include/linux/srcutree.h
> > > > +++ b/include/linux/srcutree.h
> > > > @@ -94,7 +94,6 @@ struct srcu_struct {
> > > >  						/*  callback for the barrier */
> > > >  						/*  operation. */
> > > >  	struct delayed_work work;
> > > > -	struct list_head srcu_boot_entry;	/* Early-boot callbacks. */
> > > >  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> > > >  	struct lockdep_map dep_map;
> > > >  #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> > > > @@ -110,7 +109,7 @@ struct srcu_struct {
> > > >  	.sda = &pcpu_name,						\
> > > >  	.lock = __SPIN_LOCK_UNLOCKED(name.lock),			\
> > > >  	.srcu_gp_seq_needed = -1UL,					\
> > > > -	.srcu_boot_entry = LIST_HEAD_INIT(name.srcu_boot_entry),	\
> > > > +	.work = __DELAYED_WORK_INITIALIZER(name.work, NULL, 0),		\  
> > > 
> > > Thanks!  
> > 
> > Glad you like it!  Does it actually work for you?  ;-)
> 
> Oh, you want me to actually test it too? ;-)

;-) ;-) ;-)

> I'll try to add that in my todo list tomorrow.

Much appreciated!

							Thanx, Paul

> -- Steve
> 
> > 
> > 							Thanx, Paul
> > 
> > > -- Steve
> > >   
> > > >  	__SRCU_DEP_MAP_INIT(name)					\
> > > >  }
> > > >  
> > > > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > > > index d233f0c63f6f..b46e6683f8c9 100644
> > > > --- a/kernel/rcu/srcutiny.c
> > > > +++ b/kernel/rcu/srcutiny.c
> > > > @@ -48,7 +48,7 @@ static int init_srcu_struct_fields(struct srcu_struct *sp)
> > > >  	sp->srcu_gp_waiting = false;
> > > >  	sp->srcu_idx = 0;
> > > >  	INIT_WORK(&sp->srcu_work, srcu_drive_gp);
> > > > -	INIT_LIST_HEAD(&sp->srcu_boot_entry);
> > > > +	INIT_LIST_HEAD(&sp->srcu_work.entry);
> > > >  	return 0;
> > > >  }
> > > >  
> > > > @@ -185,8 +185,8 @@ void call_srcu(struct srcu_struct *sp, struct rcu_head *rhp,
> > > >  	if (!READ_ONCE(sp->srcu_gp_running)) {
> > > >  		if (likely(srcu_init_done))
> > > >  			schedule_work(&sp->srcu_work);
> > > > -		else if (list_empty(&sp->srcu_boot_entry))
> > > > -			list_add(&sp->srcu_boot_entry, &srcu_boot_list);
> > > > +		else if (list_empty(&sp->srcu_work.entry))
> > > > +			list_add(&sp->srcu_work.entry, &srcu_boot_list);
> > > >  	}
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(call_srcu);
> > > > @@ -224,8 +224,8 @@ void __init srcu_init(void)
> > > >  	srcu_init_done = true;
> > > >  	while (!list_empty(&srcu_boot_list)) {
> > > >  		sp = list_first_entry(&srcu_boot_list,
> > > > -				      struct srcu_struct, srcu_boot_entry);
> > > > -		list_del_init(&sp->srcu_boot_entry);
> > > > +				      struct srcu_struct, srcu_work.entry);
> > > > +		list_del_init(&sp->srcu_work.entry);
> > > >  		schedule_work(&sp->srcu_work);
> > > >  	}
> > > >  }
> > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > index e79c1929328f..36a2857c84e0 100644
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -186,7 +186,6 @@ static int init_srcu_struct_fields(struct srcu_struct *sp, bool is_static)
> > > >  	mutex_init(&sp->srcu_barrier_mutex);
> > > >  	atomic_set(&sp->srcu_barrier_cpu_cnt, 0);
> > > >  	INIT_DELAYED_WORK(&sp->work, process_srcu);
> > > > -	INIT_LIST_HEAD(&sp->srcu_boot_entry);
> > > >  	if (!is_static)
> > > >  		sp->sda = alloc_percpu(struct srcu_data);
> > > >  	init_srcu_struct_nodes(sp, is_static);
> > > > @@ -709,8 +708,8 @@ static void srcu_funnel_gp_start(struct srcu_struct *sp, struct srcu_data *sdp,
> > > >  		if (likely(srcu_init_done))
> > > >  			queue_delayed_work(rcu_gp_wq, &sp->work,
> > > >  					   srcu_get_delay(sp));
> > > > -		else if (list_empty(&sp->srcu_boot_entry))
> > > > -			list_add(&sp->srcu_boot_entry, &srcu_boot_list);
> > > > +		else if (list_empty(&sp->work.work.entry))
> > > > +			list_add(&sp->work.work.entry, &srcu_boot_list);
> > > >  	}
> > > >  	spin_unlock_irqrestore_rcu_node(sp, flags);
> > > >  }
> > > > @@ -1324,10 +1323,10 @@ void __init srcu_init(void)
> > > >  
> > > >  	srcu_init_done = true;
> > > >  	while (!list_empty(&srcu_boot_list)) {
> > > > -		sp = list_first_entry(&srcu_boot_list,
> > > > -				      struct srcu_struct, srcu_boot_entry);
> > > > +		sp = list_first_entry(&srcu_boot_list, struct srcu_struct,
> > > > +				      work.work.entry);
> > > >  		check_init_srcu_struct(sp);
> > > > -		list_del_init(&sp->srcu_boot_entry);
> > > > +		list_del_init(&sp->work.work.entry);
> > > >  		queue_work(rcu_gp_wq, &sp->work.work);
> > > >  	}
> > > >  }  
> > >   
> 

