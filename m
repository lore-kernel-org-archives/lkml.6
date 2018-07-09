Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URG_BIZ,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ADDC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322F9208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322F9208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933135AbeGIUca (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:32:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932856AbeGIUc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:32:28 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w69KSmGJ125204
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 16:32:28 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k4dp9c9d1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 16:32:28 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Jul 2018 16:32:27 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Jul 2018 16:32:24 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w69KWN009699830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Jul 2018 20:32:23 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E0C3B2066;
        Mon,  9 Jul 2018 16:31:58 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E62DB205F;
        Mon,  9 Jul 2018 16:31:58 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  9 Jul 2018 16:31:58 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id F3B0616C1972; Mon,  9 Jul 2018 13:34:41 -0700 (PDT)
Date:   Mon, 9 Jul 2018 13:34:41 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180709104429.GI2476@hirez.programming.kicks-ass.net>
 <1531133801.18697.73.camel@infradead.org>
 <20180709110657.GL2476@hirez.programming.kicks-ass.net>
 <20180709123457.GM3593@linux.vnet.ibm.com>
 <20180709125516.GO2476@hirez.programming.kicks-ass.net>
 <20180709130227.GQ2512@hirez.programming.kicks-ass.net>
 <20180709142932.GO3593@linux.vnet.ibm.com>
 <20180709152632.GX2476@hirez.programming.kicks-ass.net>
 <20180709163432.GV3593@linux.vnet.ibm.com>
 <1531162254.26547.3.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531162254.26547.3.camel@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070920-0052-0000-0000-0000030B6535
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009340; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01058976; UDB=6.00543453; IPR=6.00836896;
 MB=3.00022076; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-09 20:32:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070920-0053-0000-0000-00005D4D90D7
Message-Id: <20180709203441.GE3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807090232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 07:50:54PM +0100, David Woodhouse wrote:
> 
> 
> On Mon, 2018-07-09 at 09:34 -0700, Paul E. McKenney wrote:
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 51919985f6cf..33b0a1ec0536 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2496,6 +2496,10 @@ void rcu_check_callbacks(int user)
> >  {
> >  	trace_rcu_utilization(TPS("Start scheduler-tick"));
> >  	raw_cpu_inc(rcu_data.ticks_this_gp);
> > +	if (smp_load_acquire(this_cpu_ptr(&rcu_dynticks.rcu_urgent_qs)) &&
> > +	   !is_idle_task(current))
> > +		set_tsk_need_resched(current);
> 
> OK, so this will make KVM (and various other code) see that
> need_resched() is true, and they'll call cond_resched() or something
> else that might not actually schedule another task, but will at least
> end up in rcu_all_qs()...
> 
> > +	__this_cpu_write(rcu_dynticks.rcu_urgent_qs, false);
> 
> ... which bails out immediately and does nothing, because that's set to
> false?
> 
> Am I missing something?

If this is the idle task, RCU will detect that as a quiescent state via
its dyntick-idle mechanism.  In which case, there is no point in leaving
.rcu_urgent_qs being true.

If this is not the idle task, the scheduler will invoke
rcu_note_context_switch(), which will in turn invoke rcu_sched_qs(),
rcu_preempt_qs(), or rcu_qs(), depending on kernel version and
configuration.  This will happen independently of .rcu_urgent_qs, so it
is OK to set .rcu_urgent_qs to false.  And doing so reduces the overhead
of the next cond_resched().

I may end up using rcu_is_cpu_rrupt_from_idle() instead of is_idle_task()
at some point, but the former eases backporting.  And the only difference
is if someone has a long loop within an _rcuidle tracepoint used in the
idle loop, and where that loop check need_resched().  Which currently
seems to be the empty set.

And I should treat interruption of a usermode task the same as that of an
idle task.  In the PREEMPT case, ->rcu_read_lock_nesting better be zero
(lockdep would have complained), so the quiescent state will be reported.
In the !PREEMPT case, user=1 directly causes reporting of a quiescent
state.

So here are the possible code paths when .rcu_urgent_qs is set to true:

1.	A context switch will record the quiescent state and clear
	.rcu_urgent_qs.  (The failure to do the clearing in current -rcu
	for PREEMPT builds is a performance bug that I need to fix.)

2.	A cond_resched() will cause rcu_all_qs() to be invoked, which
	will record a quiescent state and clear .rcu_urgent_qs.

3.	With the patch below, a scheduling-clock interrupt of a
	non-idle non-userspace task will force a reschedule, which
	will result in #1 above happening.

However, I should avoid setting .rcu_urgent_qs to false when it is
already false, shouldn't I?

So how about the following instead?

I am doing some light testing and will let you know how that goes.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 51919985f6cf..c3b688c7127a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2496,6 +2496,15 @@ void rcu_check_callbacks(int user)
 {
 	trace_rcu_utilization(TPS("Start scheduler-tick"));
 	raw_cpu_inc(rcu_data.ticks_this_gp);
+	/* The load-acquire pairs with the store-release setting to true. */
+	if (smp_load_acquire(this_cpu_ptr(&rcu_dynticks.rcu_urgent_qs))) {
+		/* Idle already is a quiescent state. */
+		if (!is_idle_task(current) && !user) {
+			set_tsk_need_resched(current);
+			set_preempt_need_resched();
+		}
+		__this_cpu_write(rcu_dynticks.rcu_urgent_qs, false);
+	}
 	rcu_flavor_check_callbacks(user);
 	if (rcu_pending())
 		invoke_rcu_core();

