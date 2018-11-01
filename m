Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6741DC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18485205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18485205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeKBIRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:17:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726386AbeKBIRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:17:34 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA1N46bN111261
        for <linux-kernel@vger.kernel.org>; Thu, 1 Nov 2018 19:12:32 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ngah7rv69-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 19:12:32 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Nov 2018 23:12:31 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Nov 2018 23:12:28 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA1NCRbW22478872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Nov 2018 23:12:27 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEEA8B2064;
        Thu,  1 Nov 2018 23:12:27 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F1EBB205F;
        Thu,  1 Nov 2018 23:12:27 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.141])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Nov 2018 23:12:27 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 10A1216C359F; Thu,  1 Nov 2018 16:12:28 -0700 (PDT)
Date:   Thu, 1 Nov 2018 16:12:28 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     bigeasy@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: srcu: use cpu_online() instead custom check
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110123-0052-0000-0000-0000034E7A76
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009968; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01111301; UDB=6.00575897; IPR=6.00891393;
 MB=3.00023997; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-01 23:12:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110123-0053-0000-0000-00005E9F5131
Message-Id: <20181101231228.GA9118@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-01_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811010192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The current check via srcu_online is slightly racy because after looking
> at srcu_online there could be an interrupt that interrupted us long
> enough until the CPU we checked against went offline.

I don't see how this can happen, even in -rt.  The call to
srcu_offline_cpu() happens very early in the CPU removal process,
which means that the synchronize_rcu_mult(call_rcu, call_rcu_sched)
in sched_cpu_deactivate() would wait for the interrupt to complete.
And for the enclosing preempt_disable region to complete.

Or is getting rid of that preempt_disable region the real reason for
this change?

> An alternative would be to hold the hotplug rwsem (so the CPUs don't
> change their state) and then check based on cpu_online() if we queue it
> on a specific CPU or not. queue_work_on() itself can handle if something
> is enqueued on an offline CPU but a timer which is enqueued on an offline
> CPU won't fire until the CPU is back online.
> 
> I am not sure if the removal in rcu_init() is okay or not. I assume that
> SRCU won't enqueue a work item before SRCU is up and ready.

That was the case before the current merge window, but use of call_srcu()
by tracing means that SRCU needs to be able to deal with call_srcu()
long before any initialization has happened.  The actual callbacks
won't be invoked until much later, after the scheduler and workqueues
are completely up and running, but call_srcu() can be invoked very early.

But I am not seeing any removal in rcu_init() in this patch, so I might
be missing something.

							Thanx, Paul

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 6c9866a854b1..3428a40a813e 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -38,6 +38,7 @@
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/srcu.h>
> +#include <linux/cpu.h>
>  
>  #include "rcu.h"
>  #include "rcu_segcblist.h"
> @@ -458,21 +459,6 @@ static void srcu_gp_start(struct srcu_struct *sp)
>  	WARN_ON_ONCE(state != SRCU_STATE_SCAN1);
>  }
>  
> -/*
> - * Track online CPUs to guide callback workqueue placement.
> - */
> -DEFINE_PER_CPU(bool, srcu_online);
> -
> -void srcu_online_cpu(unsigned int cpu)
> -{
> -	WRITE_ONCE(per_cpu(srcu_online, cpu), true);
> -}
> -
> -void srcu_offline_cpu(unsigned int cpu)
> -{
> -	WRITE_ONCE(per_cpu(srcu_online, cpu), false);
> -}
> -
>  /*
>   * Place the workqueue handler on the specified CPU if online, otherwise
>   * just run it whereever.  This is useful for placing workqueue handlers
> @@ -484,12 +470,12 @@ static bool srcu_queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
>  {
>  	bool ret;
>  
> -	preempt_disable();
> -	if (READ_ONCE(per_cpu(srcu_online, cpu)))
> +	cpus_read_lock();
> +	if (cpu_online(cpu))
>  		ret = queue_delayed_work_on(cpu, wq, dwork, delay);
>  	else
>  		ret = queue_delayed_work(wq, dwork, delay);
> -	preempt_enable();
> +	cpus_read_unlock();
>  	return ret;
>  }
>  
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 6868ef417e9f..e2e68250009b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3767,8 +3767,6 @@ int rcutree_online_cpu(unsigned int cpu)
>  		rnp->ffmask |= rdp->grpmask;
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	}
> -	if (IS_ENABLED(CONFIG_TREE_SRCU))
> -		srcu_online_cpu(cpu);
>  	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
>  		return 0; /* Too early in boot for scheduler work. */
>  	sync_sched_exp_online_cleanup(cpu);
> @@ -3796,8 +3794,6 @@ int rcutree_offline_cpu(unsigned int cpu)
>  	}
>  
>  	rcutree_affinity_setting(cpu, cpu);
> -	if (IS_ENABLED(CONFIG_TREE_SRCU))
> -		srcu_offline_cpu(cpu);
>  	return 0;
>  }
>  

