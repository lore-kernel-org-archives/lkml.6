Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URG_BIZ,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99883C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A0E208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A0E208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933178AbeGIVDV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:03:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932956AbeGIVDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:03:19 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w69Kwg72117738
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 17:03:19 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k4e76uyjw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 17:03:18 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Jul 2018 17:03:18 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Jul 2018 17:03:15 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w69L3EGF14418272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Jul 2018 21:03:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3536B2065;
        Mon,  9 Jul 2018 17:02:48 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD863B2064;
        Mon,  9 Jul 2018 17:02:48 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  9 Jul 2018 17:02:48 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8D94116C2E19; Mon,  9 Jul 2018 14:05:32 -0700 (PDT)
Date:   Mon, 9 Jul 2018 14:05:32 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180709125516.GO2476@hirez.programming.kicks-ass.net>
 <20180709130227.GQ2512@hirez.programming.kicks-ass.net>
 <20180709142932.GO3593@linux.vnet.ibm.com>
 <20180709152632.GX2476@hirez.programming.kicks-ass.net>
 <20180709163432.GV3593@linux.vnet.ibm.com>
 <1531162254.26547.3.camel@infradead.org>
 <20180709203441.GE3593@linux.vnet.ibm.com>
 <1531168538.26547.5.camel@infradead.org>
 <20180709204248.GF3593@linux.vnet.ibm.com>
 <1531169145.26547.8.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531169145.26547.8.camel@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070921-0068-0000-0000-0000031587AA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009341; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01058987; UDB=6.00543460; IPR=6.00836907;
 MB=3.00022076; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-09 21:03:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070921-0069-0000-0000-000044F8EA18
Message-Id: <20180709210532.GH3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807090237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 09:45:45PM +0100, David Woodhouse wrote:
> On Mon, 2018-07-09 at 13:42 -0700, Paul E. McKenney wrote:
> > On Mon, Jul 09, 2018 at 09:35:38PM +0100, David Woodhouse wrote:
> > > 
> > > 
> > > On Mon, 2018-07-09 at 13:34 -0700, Paul E. McKenney wrote:
> > > > 
> > > > So here are the possible code paths when .rcu_urgent_qs is set to true:
> > > > 
> > > > 1.      A context switch will record the quiescent state and clear
> > > >         .rcu_urgent_qs.  (The failure to do the clearing in current -rcu
> > > >         for PREEMPT builds is a performance bug that I need to fix.)
> > > 
> > > What if there's nothing else runnable and there is no actual context
> > > switch?
> > 
> > The scheduler invokes rcu_note_context_switch() before looking to see
> > if there really will or won't be a context switch.
> > 
> > I am sure that Peter will correct me if I am confused on this point.  ;-)
> 
> Ah, OK. Yes, that looks correct. Thanks.

Here is hoping!

> I'll give your patch a spin tomorrow, unless Marius beats me to it.

Please see below for the version that I eventually queued.  Should Marius
have a Reported-by?  If so, please tell me his full name so I can add that.

							Thanx, Paul

------------------------------------------------------------------------

commit e1e91fd0796dc544a77ddfaa5afbfc1f5fb42ecd
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Mon Jul 9 13:47:30 2018 -0700

    rcu: Make need_resched() respond to urgent RCU-QS needs
    
    The per-CPU rcu_dynticks.rcu_urgent_qs variable communicates an urgent
    need for an RCU quiescent state from the force-quiescent-state processing
    within the grace-period kthread to context switches and to cond_resched().
    Unfortunately, such urgent needs are not communicated to need_resched(),
    which is sometimes used to decide when to invoke cond_resched(), for
    but one example, within the KVM vcpu_run() function.  As of v4.15, this
    can result in synchronize_sched() being delayed by up to ten seconds,
    which can be problematic, to say nothing of annoying.
    
    This commit therefore checks rcu_dynticks.rcu_urgent_qs from within
    rcu_check_callbacks(), which is invoked from the scheduling-clock
    interrupt handler.  If the current task is not an idle task and is
    not executing in usermode, a context switch is forced, and either way,
    the rcu_dynticks.rcu_urgent_qs variable is set to false.  If the current
    task is an idle task, then RCU's dyntick-idle code will detect the
    quiescent state, so no further action is required.  Similarly, if the
    task is executing in usermode, other code in rcu_check_callbacks() and
    its called functions will report the corresponding quiescent state.
    
    Reported-by: David Woodhouse <dwmw2@infradead.org>
    Suggested-by: Peter Zijlstra <peterz@infradead.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 51919985f6cf..ea756bb64eb3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2496,6 +2496,15 @@ void rcu_check_callbacks(int user)
 {
 	trace_rcu_utilization(TPS("Start scheduler-tick"));
 	raw_cpu_inc(rcu_data.ticks_this_gp);
+	/* The load-acquire pairs with the store-release setting to true. */
+	if (smp_load_acquire(this_cpu_ptr(&rcu_dynticks.rcu_urgent_qs))) {
+		/* Idle and userspace execution already are quiescent states. */
+		if (!is_idle_task(current) && !user) {
+			set_tsk_need_resched(current);
+			set_preempt_need_resched();
+		}
+		__this_cpu_write(rcu_dynticks.rcu_urgent_qs, false);
+	}
 	rcu_flavor_check_callbacks(user);
 	if (rcu_pending())
 		invoke_rcu_core();

