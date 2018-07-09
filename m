Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URG_BIZ,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A83AC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32C520844
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32C520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933418AbeGIQmH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:42:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932755AbeGIQmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:42:06 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w69GdRVk143992
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 12:42:06 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k499grssy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 12:42:05 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Jul 2018 12:42:04 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Jul 2018 12:42:03 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w69Gg2lI2752888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Jul 2018 16:42:02 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5503EB2067;
        Mon,  9 Jul 2018 12:41:37 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25B67B2064;
        Mon,  9 Jul 2018 12:41:37 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  9 Jul 2018 12:41:37 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8275316C2E35; Mon,  9 Jul 2018 09:44:20 -0700 (PDT)
Date:   Mon, 9 Jul 2018 09:44:20 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     David Woodhouse <dwmw2@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Reply-To: paulmck@linux.vnet.ibm.com
References: <1531127935.18697.57.camel@infradead.org>
 <20180709104429.GI2476@hirez.programming.kicks-ass.net>
 <1531133801.18697.73.camel@infradead.org>
 <20180709110657.GL2476@hirez.programming.kicks-ass.net>
 <20180709123457.GM3593@linux.vnet.ibm.com>
 <20180709125516.GO2476@hirez.programming.kicks-ass.net>
 <20180709130227.GQ2512@hirez.programming.kicks-ass.net>
 <20180709142932.GO3593@linux.vnet.ibm.com>
 <20180709152632.GX2476@hirez.programming.kicks-ass.net>
 <20180709163432.GV3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709163432.GV3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070916-2213-0000-0000-000002C827BA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009339; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01058899; UDB=6.00543407; IPR=6.00836820;
 MB=3.00022074; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-09 16:42:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070916-2214-0000-0000-00005AC5D4A5
Message-Id: <20180709164420.GA8249@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807090190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 09:34:32AM -0700, Paul E. McKenney wrote:
> On Mon, Jul 09, 2018 at 05:26:32PM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 09, 2018 at 07:29:32AM -0700, Paul E. McKenney wrote:
> > > OK, so here are our options:
> > > 
> > > 1.	Add the RCU conditional to need_resched(), as David suggests.
> > > 	Peter has concerns about overhead.
> > > 
> > > 2.	Create a new need_resched_rcu_qs() that is to be used when
> > > 	deciding whether or not to do cond_resched().  This would
> > > 	exact the overhead only where it is needed, but is one more
> > > 	thing for people to get wrong.
> > 
> > Also, with the crypto guys checking need_resched() in asm that won't
> > really work either.
> 
> Fair point!  Ease of use is a good thing, even within the Linux kernel.
> Or maybe especially within the Linux kernel...
> 
> > > 3.	Revert my changes to de-emphasize cond_resched_rcu_qs(),
> > > 	and go back to sprinkling cond_resched_rcu_qs() throughout
> > > 	the code.  This also is one more thing for people to get wrong,
> > > 	and might well eventually convert all cond_resched() calls to
> > > 	cond_resched_rcu_qs(), which sure seems like a failure mode to me.
> > 
> >  4a.	use resched_cpu() more agressive
> >  4b.	use the tick to set TIF_NEED_RESCHED when it finds rcu_urgent_qs
> > 	(avoids the IPI at the 'cost' of a slight delay in processing)
> 
> 4b sounds eminently reasonable to me!  Something like the (untested,
> probably doesn't even build) patch below?
> 
> David, any reason why this wouldn't work?  Seems to me that this would
> make need_resched() respond to RCU's need for quiescent states in a
> timely manner without need_resched() having to become heavier weight,
> but figured I should ask.
> 
> >  5.	make guest mode a quiescent state (like supposedly already done
> > 	for NOHZ_FULL) (but this would not help the crypto guys).
> > 
> >  6.	....
> > 
> > ok I ran out of ideas here I think.
> > 
> > 
> > So for PREEMPT the tick can check preempt_count() == 0 and if so, know
> > it _could_ have rescheduled and advance the qs, right? But since we
> > don't have a preempt count for !PREEMPT_COUNT kernels this doesn't work.
> > 
> > And thus we need to invoke actual scheduling events and then through the
> > schedule() callback RCU knows things happened.
> > 
> > 4b seems like something worth trying for !PREEMPT kernels I suppose
> 
> David is running a !PREEMPT kernel.
> 
> For PREEMPT kernels, the patch below results in a quiescent state for
> the CPU, and the forced schedule queues the task.  This queuing enables
> later RCU priority boosting (if enabled) once all other CPUs sharing
> the same leaf rcu_node structure have passed through quiescent states.
> 
> And yes, for PREEMPT kernels the scheduling-clock interrupt handler
> already checks for a quiescent state using a combination of
> preempt_count() (as you say, but ignoring the hardirq bits because
> we are in an interrupt handler) and current->rcu_read_lock_nesting.
> 
> So I believe that this will cover it.
> 
> Thoughts?

Updated per Peter's feedback on IRC.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 51919985f6cf..ccde5f8aff61 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2496,6 +2496,12 @@ void rcu_check_callbacks(int user)
 {
 	trace_rcu_utilization(TPS("Start scheduler-tick"));
 	raw_cpu_inc(rcu_data.ticks_this_gp);
+	if (smp_load_acquire(this_cpu_ptr(&rcu_dynticks.rcu_urgent_qs)) &&
+	   !is_idle_task(current)) {
+		set_tsk_need_resched(current);
+		set_preempt_need_resched();
+	}
+	__this_cpu_write(rcu_dynticks.rcu_urgent_qs, false);
 	rcu_flavor_check_callbacks(user);
 	if (rcu_pending())
 		invoke_rcu_core();

