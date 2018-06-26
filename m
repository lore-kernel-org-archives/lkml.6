Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD71C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F53526946
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F53526946
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754926AbeFZXiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 19:38:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752465AbeFZXiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 19:38:06 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QNY1fZ052576
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 19:38:06 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2juy3f0c1n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 19:38:06 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 19:38:05 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 19:38:00 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QNbxpu10551814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 23:37:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAA81B2064;
        Tue, 26 Jun 2018 19:37:52 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 739F7B205F;
        Tue, 26 Jun 2018 19:37:52 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 19:37:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 076DD16CA20B; Tue, 26 Jun 2018 16:40:05 -0700 (PDT)
Date:   Tue, 26 Jun 2018 16:40:04 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 13/22] rcu: Fix grace-period hangs due to
 race with CPU offline
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180626002052.GA24146@linux.vnet.ibm.com>
 <20180626171048.2181-13-paulmck@linux.vnet.ibm.com>
 <20180626175119.GL2494@hirez.programming.kicks-ass.net>
 <20180626182950.GH3593@linux.vnet.ibm.com>
 <20180626202615.GA32162@linux.vnet.ibm.com>
 <20180626203225.GT2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626203225.GT2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062623-0052-0000-0000-000003047CCB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009260; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052798; UDB=6.00539746; IPR=6.00830722;
 MB=3.00021871; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 23:38:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062623-0053-0000-0000-00005D26A906
Message-Id: <20180626234004.GQ3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 10:32:25PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 26, 2018 at 01:26:15PM -0700, Paul E. McKenney wrote:
> > commit 2e5b2ff4047b138d6b56e4e3ba91bc47503cdebe
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Fri May 25 19:23:09 2018 -0700
> > 
> >     rcu: Fix grace-period hangs due to race with CPU offline
> >     
> >     Without special fail-safe quiescent-state-propagation checks, grace-period
> >     hangs can result from the following scenario:
> >     
> >     1.      CPU 1 goes offline.
> >     
> >     2.      Because CPU 1 is the only CPU in the system blocking the current
> >             grace period, the grace period ends as soon as
> >             rcu_cleanup_dying_idle_cpu()'s call to rcu_report_qs_rnp()
> >             returns.
> 
> My current code doesn't have that call... So this is a new problem
> earlier in this series.
> 
> >     3.      At this point, the leaf rcu_node structure's ->lock is no longer
> >             held: rcu_report_qs_rnp() has released it, as it must in order
> >             to awaken the RCU grace-period kthread.
> >     
> >     4.      At this point, that same leaf rcu_node structure's ->qsmaskinitnext
> >             field still records CPU 1 as being online.  This is absolutely
> >             necessary because the scheduler uses RCU (in this case on the
> >             wake-up path while awakening RCU's grace-period kthread), and
> >             ->qsmaskinitnext contains RCU's idea as to which CPUs are online.
> >             Therefore, invoking rcu_report_qs_rnp() after clearing CPU 1's
> >             bit from ->qsmaskinitnext would result in a lockdep-RCU splat
> >             due to RCU being used from an offline CPU.
> 
> Argh.. so it's your own wakeup!

That it is.  The outgoing CPU might need to wake up RCU's grace-period
kthread, for example, if that CPU was the last thing holding up the
current grace period.

> This all still smells really bad. But let me try and figure out where
> you introduced the problem.

Well, I can't say that it is the code that I am the most proud of...

On the other hand, there are a number of constraints on this code:

o	The ->qsmask bits indicate which CPUs the current grace period
	is still waiting on.

o	The ->qsmaskinit bits indicate which CPUs the current grace
	period was waiting on at grace-period initialization time.
	In fact, the ->qsmask bits are initialized by copying from
	the corresponding ->qsmaskinit bits.

o	The ->qsmaskinitnext bits indicate which CPUs are online at
	a given time, from an RCU perspective.	RCU will consider
	an incoming CPU to be online before cpu_online_mask does,
	and RCU will also consider an outgoing CPU to be online after
	cpu_online_mask says that it is gone.

o	Only the leaf rcu_node structures' ->qsmaskinitnext bits have
	meaning.  Thus, although the ->qsmaskinit bits are initialized
	for a given grace period based on changes in the values of
	the ->qsmaskinitnext bits since the beginning of the last
	grace period, for the non-leaf ->qsmaskinit bits, this cannot
	be a simple copy operation.  (Instead, changes are pushed up
	the rcu_node tree.)

	Why not instead make the CPU-hotplug operations push the
	changes up the tree?  Because this could race with grace-period
	initialization, in which case it would result in inconsistent
	values for the ->qsmaskinit bits, and thus of the ->qsmask bits.
	These inconsistent values can result in too-short grace periods
	on the one hand and grace-period hangs on the other.

o	The purpose of these three bitmasks is to decouple RCU's
	grace-period initialization from CPU-hotplug operations.
	The reason for this decoupling is that various pieces of the
	CPU-hotplug code wait on RCU grace periods, which means that
	RCU grace-period initialization cannot block CPU hotplug,
	at least not without risk of deadlock.

o	The initial state of all the ->qsmask bits must be consistent (at
	least in the case where no CPU tries to report a quiescent state
	until all these bits are fully initialized).  That is to say,
	if the initial value of a given ->qsmask is all zero (and there
	are no preempted tasks referenced by the ->gp_tasks pointer,
	see below), then the initial value of the corresponding bit of
	the parent rcu_node structure must also be zero.  Similarly, if
	the initial value of a given ->qsmask has at least one non-zero
	bit (or there is at least one task referenced by the ->gp_tasks
	pointer), then the initial value of the corresponding bit of
	the parent rcu_node structure must also be non-zero.  Of course,

	Violation of this rule was the impetus for several of the
	patches under discussion.

o	Only the CPU-hotplug code is allowed to change the values of
	the ->qsmaskinitnext bits.  The grace-period initialization code
	reads these bits, but so does code checking for offline CPUs.
	The rcu_node structure's ->lock must be held when changing
	these bits.

o	Only the grace-period initialization code is allowed to access the
	->qsmaskinit bits (give or take debug prints).	In theory, no lock
	is required when updating these bits, but in practice the rcu_node
	structure's ->lock is held due to the need to hold either the
	->qsmask or the ->qsmaskinitnext bits still while carrying out
	the access.

o	Only the grace-period initialization code is allowed to change
	the values of the ->qsmask bits from zero to one.  Only something
	reporting a quiescent state is allowed to change the values of
	the corresponding ->qsmask bits from one to zero.  If the
	->qsmask field of the root rcu_node structure becomes zero,
	the RCU grace-period kthread should be awakened (one execption
	being when that kthread cleared the last bit, and another where
	the root is also a leaf and there are tasks referenced by the
	->gp_tasks pointer, again, see below).

o	Grace-period initialization first scans the leaf rcu_node
	structures for CPU-hotplug transitions (locking each such
	structure along the way and updating their ->qsmaskinit field),
	then does a breadth-first copy of ->qsmaskinit to ->qsmask for
	each rcu_node structure.  CPUs can come and go at any point
	in this process.  In fact, one CPU can go and another
	(or even the same CPU) can come back during this part of
	grace-period initialization.

o	Leaf rcu_node structures must concern themselves with tasks
	preempted within an RCU-preempt read-side critical section as well
	as CPUs passing through quiescent states.  These preempted tasks
	are placed on the corresponding structure's ->blkd_tasks list.
	It is possible that a grace period might start such that a given
	leaf must wait on a preempted task (non-NULL ->gp_tasks pointer)
	but no online CPUs.  In addition, a CPU could come online
	while this state was in effect.  The boolean ->wait_blkd_tasks
	field helps keep all this straight, allowing that leaf rcu_node
	structure to be taken out of circulation once all its CPUs are
	offline -and- its ->blkd_tasks list has become empty.

o	As soon as a ->qsmask bit is set in a leaf rcu_node structure,
	the CPU corresponding to that bit might immediately start trying
	to report a quiescent state.  This means that the ->qsmask bits
	must be initialized from the root down, in a breadth-first
	fashion.  Otherwise, a quiescent-state report could cause the
	->qsmask bits to become inconsistent (if the report outran
	the bottom-to-top initialization).

o	In the past, the RCU grace-period kthread's force-quiescent-state
	scan would catch CPU-offline races, but the goal is to get rid
	of that fail-safe in order to reduce lock contention.  Therefore,
	if a given leaf rcu_node structure's ->qsmask field has a bit set,
	then that CPU needs to be online at least at the very beginning
	of the grace period.

The options I have considered are as follows:

1.	Stick with the no-failsafe approach, adding the lock as shown
	in this patch.  (I obviously prefer this approach.)

2.	Stick with the no-failsafe approach, but rely on RCU's grace-period
	kthread to wake up later due to its timed wait during the
	force-quiescent-state process.  This would be a bit obnoxious,
	as it requires passing a don't-wake flag (or some such) up the
	quiescent-state reporting mechanism.  It would also needlessly
	delay grace-period ends, especially on large systems (RCU scales
	up the FQS delay on larger systems to maintain limited CPU
	consumption per unit time).

3.	Stick with the no-failsafe approach, but have the quiescent-state
	reporting code hand back a value indicating that a wakeup is needed.
	Also a bit obnoxious, as this value would need to be threaded up
	the reporting code's return path.  Simple in theory, but a bit
	of an ugly change, especially for the many places in the code that
	currently expect quiescent-state reporting to be an unconditional
	fire-and-forget operation.

4.	Re-introduce the old fail-safe code, and don't report the
	quiescent state at CPU-offline time, relying on the fail-safe
	code to do so.	This also potentially introduces delays and can
	add extra FQS scans, which in turn increases lock contention.

So what did you have in mind?

								Thanx, Paul

