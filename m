Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5C0C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6F12098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6F12098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732204AbeIXWrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:47:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729788AbeIXWrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:47:13 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8OGd25r067309
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:44:11 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mq2mpka92-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:44:11 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 24 Sep 2018 12:44:10 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Sep 2018 12:44:08 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8OGi7nX27394050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Sep 2018 16:44:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71666B2066;
        Mon, 24 Sep 2018 12:42:29 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4875EB2065;
        Mon, 24 Sep 2018 12:42:29 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.213.95])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 24 Sep 2018 12:42:29 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9134D16C0AAB; Mon, 24 Sep 2018 09:44:06 -0700 (PDT)
Date:   Mon, 24 Sep 2018 09:44:06 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.18 207/235] rcu: Fix grace-period hangs due to race
 with CPU offline
Reply-To: paulmck@linux.ibm.com
References: <20180924113103.999624566@linuxfoundation.org>
 <20180924113124.637508442@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924113124.637508442@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18092416-0064-0000-0000-000003543D8B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009763; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093031; UDB=6.00564900; IPR=6.00873068;
 MB=3.00023484; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-24 16:44:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092416-0065-0000-0000-00003AC2045C
Message-Id: <20180924164406.GE4222@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-24_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809240163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 01:53:13PM +0200, Greg Kroah-Hartman wrote:
> 4.18-stable review patch.  If anyone has any objections, please let me know.

This should not be needed in 4.18 because of a number of crude but
effective grace-period forward-progress failsafes.  I have not tested
it in isolation.  It looks harmless enough, but all testing has been in
conjunction with a large number of preceding patches.

I therefore strongly recommend against backporting this one.

							Thanx, Paul

> ------------------
> 
> From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> 
> [ Upstream commit 1e64b15a4b102e1cd059d4d798b7a78f93341333 ]
> 
> Without special fail-safe quiescent-state-propagation checks, grace-period
> hangs can result from the following scenario:
> 
> 1.	CPU 1 goes offline.
> 
> 2.	Because CPU 1 is the only CPU in the system blocking the current
> 	grace period, the grace period ends as soon as
> 	rcu_cleanup_dying_idle_cpu()'s call to rcu_report_qs_rnp()
> 	returns.
> 
> 3.	At this point, the leaf rcu_node structure's ->lock is no longer
> 	held: rcu_report_qs_rnp() has released it, as it must in order
> 	to awaken the RCU grace-period kthread.
> 
> 4.	At this point, that same leaf rcu_node structure's ->qsmaskinitnext
> 	field still records CPU 1 as being online.  This is absolutely
> 	necessary because the scheduler uses RCU (in this case on the
> 	wake-up path while awakening RCU's grace-period kthread), and
> 	->qsmaskinitnext contains RCU's idea as to which CPUs are online.
> 	Therefore, invoking rcu_report_qs_rnp() after clearing CPU 1's
> 	bit from ->qsmaskinitnext would result in a lockdep-RCU splat
> 	due to RCU being used from an offline CPU.
> 
> 5.	RCU's grace-period kthread awakens, sees that the old grace period
> 	has completed and that a new one is needed.  It therefore starts
> 	a new grace period, but because CPU 1's leaf rcu_node structure's
> 	->qsmaskinitnext field still shows CPU 1 as being online, this new
> 	grace period is initialized to wait for a quiescent state from the
> 	now-offline CPU 1.
> 
> 6.	Without the fail-safe force-quiescent-state checks, there would
> 	be no quiescent state from the now-offline CPU 1, which would
> 	eventually result in RCU CPU stall warnings and memory exhaustion.
> 
> It would be good to get rid of the special fail-safe quiescent-state
> propagation checks, and thus it would be good to fix things so that
> the above scenario cannot happen.  This commit therefore adds a new
> ->ofl_lock to the rcu_state structure.  This lock is held by rcu_gp_init()
> across the applying of buffered online and offline operations to the
> rcu_node tree, and it is also held by rcu_cleanup_dying_idle_cpu()
> when buffering a new offline operation.  This prevents rcu_gp_init()
> from acquiring the leaf rcu_node structure's lock during the interval
> between when rcu_cleanup_dying_idle_cpu() invokes rcu_report_qs_rnp(),
> which releases ->lock and the re-acquisition of that same lock.
> This in turn prevents the failure scenario outlined above, and will
> hopefully eventually allow removal of the offline-CPU checks from the
> force-quiescent-state code path.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  kernel/rcu/tree.c |    6 ++++++
>  kernel/rcu/tree.h |    4 ++++
>  2 files changed, 10 insertions(+)
> 
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -102,6 +102,7 @@ struct rcu_state sname##_state = { \
>  	.abbr = sabbr, \
>  	.exp_mutex = __MUTEX_INITIALIZER(sname##_state.exp_mutex), \
>  	.exp_wake_mutex = __MUTEX_INITIALIZER(sname##_state.exp_wake_mutex), \
> +	.ofl_lock = __SPIN_LOCK_UNLOCKED(sname##_state.ofl_lock), \
>  }
> 
>  RCU_STATE_INITIALIZER(rcu_sched, 's', call_rcu_sched);
> @@ -1925,11 +1926,13 @@ static bool rcu_gp_init(struct rcu_state
>  	 */
>  	rcu_for_each_leaf_node(rsp, rnp) {
>  		rcu_gp_slow(rsp, gp_preinit_delay);
> +		spin_lock(&rsp->ofl_lock);
>  		raw_spin_lock_irq_rcu_node(rnp);
>  		if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
>  		    !rnp->wait_blkd_tasks) {
>  			/* Nothing to do on this leaf rcu_node structure. */
>  			raw_spin_unlock_irq_rcu_node(rnp);
> +			spin_unlock(&rsp->ofl_lock);
>  			continue;
>  		}
> 
> @@ -1964,6 +1967,7 @@ static bool rcu_gp_init(struct rcu_state
>  		}
> 
>  		raw_spin_unlock_irq_rcu_node(rnp);
> +		spin_unlock(&rsp->ofl_lock);
>  	}
> 
>  	/*
> @@ -3725,9 +3729,11 @@ static void rcu_cleanup_dying_idle_cpu(i
> 
>  	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
>  	mask = rdp->grpmask;
> +	spin_lock(&rsp->ofl_lock);
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
>  	rnp->qsmaskinitnext &= ~mask;
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> +	spin_unlock(&rsp->ofl_lock);
>  }
> 
>  /*
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -384,6 +384,10 @@ struct rcu_state {
>  	const char *name;			/* Name of structure. */
>  	char abbr;				/* Abbreviated name. */
>  	struct list_head flavors;		/* List of RCU flavors. */
> +
> +	spinlock_t ofl_lock ____cacheline_internodealigned_in_smp;
> +						/* Synchronize offline with */
> +						/*  GP pre-initialization. */
>  };
> 
>  /* Values for rcu_state structure's gp_flags field. */
> 
> 

