Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC52ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3652A2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3652A2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387755AbeGMAMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:12:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387719AbeGMAMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:12:32 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6CNsubY057289
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 20:00:35 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k6g2hj2vs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 20:00:35 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 12 Jul 2018 20:00:34 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Jul 2018 20:00:30 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6D00Tne9044534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Jul 2018 00:00:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE069B206C;
        Thu, 12 Jul 2018 20:00:26 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7466B2064;
        Thu, 12 Jul 2018 20:00:26 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jul 2018 20:00:26 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id ECC9316CA29E; Thu, 12 Jul 2018 17:02:49 -0700 (PDT)
Date:   Thu, 12 Jul 2018 17:02:49 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org,
        oleg@redhat.com, edumazet@google.com, davem@davemloft.net,
        tglx@linutronix.de
Subject: Consolidating RCU-bh, RCU-preempt, and RCU-sched
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071300-0052-0000-0000-0000030D2C86
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009359; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01060485; UDB=6.00544359; IPR=6.00838404;
 MB=3.00022123; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-13 00:00:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071300-0053-0000-0000-00005D577888
Message-Id: <20180713000249.GA16907@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-12_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=848 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807120253
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I now have a semi-reasonable prototype of changes consolidating the
RCU-bh, RCU-preempt, and RCU-sched update-side APIs in my -rcu tree.
There are likely still bugs to be fixed and probably other issues as well,
but a prototype does exist.

Assuming continued good rcutorture results and no objections, I am
thinking in terms of this timeline:

o	Preparatory work and cleanups are slated for the v4.19 merge window.

o	The actual consolidation and post-consolidation cleanup is slated
	for the merge window after v4.19 (v5.0?).  These cleanups include
	the replacements called out below within the RCU implementation
	itself (but excluding kernel/rcu/sync.c, see question below).

o	Replacement of now-obsolete update APIs is slated for the second
	merge window after v4.19 (v5.1?).  The replacements are currently
	expected to be as follows:

	synchronize_rcu_bh() -> synchronize_rcu()
	synchronize_rcu_bh_expedited() -> synchronize_rcu_expedited()
	call_rcu_bh() -> call_rcu()
	rcu_barrier_bh() -> rcu_barrier()
	synchronize_sched() -> synchronize_rcu()
	synchronize_sched_expedited() -> synchronize_rcu_expedited()
	call_rcu_sched() -> call_rcu()
	rcu_barrier_sched() -> rcu_barrier()
	get_state_synchronize_sched() -> get_state_synchronize_rcu()
	cond_synchronize_sched() -> cond_synchronize_rcu()
	synchronize_rcu_mult() -> synchronize_rcu()

	I have done light testing of these replacements with good results.

Any objections to this timeline?

I also have some questions on the ultimate end point.  I have default
choices, which I will likely take if there is no discussion.

o	
	Currently, I am thinking in terms of keeping the per-flavor
	read-side functions.  For example, rcu_read_lock_bh() would
	continue to disable softirq, and would also continue to tell
	lockdep about the RCU-bh read-side critical section.  However,
	synchronize_rcu() will wait for all flavors of read-side critical
	sections, including those introduced by (say) preempt_disable(),
	so there will no longer be any possibility of mismatching (say)
	RCU-bh readers with RCU-sched updaters.

	I could imagine other ways of handling this, including:

	a.	Eliminate rcu_read_lock_bh() in favor of
		local_bh_disable() and so on.  Rely on lockdep
		instrumentation of these other functions to identify RCU
		readers, introducing such instrumentation as needed.  I am
		not a fan of this approach because of the large number of
		places in the Linux kernel where interrupts, preemption,
		and softirqs are enabled or disabled "behind the scenes".

	b.	Eliminate rcu_read_lock_bh() in favor of rcu_read_lock(),
		and required callers to also disable softirqs, preemption,
		or whatever as needed.	I am not a fan of this approach
		because it seems a lot less convenient to users of RCU-bh
		and RCU-sched.

	At the moment, I therefore favor keeping the RCU-bh and RCU-sched
	read-side APIs.  But are there better approaches?

o	How should kernel/rcu/sync.c be handled?  Here are some
	possibilities:

	a.	Leave the full gp_ops[] array and simply translate
		the obsolete update-side functions to their RCU
		equivalents.

	b.	Leave the current gp_ops[] array, but only have
		the RCU_SYNC entry.  The __INIT_HELD field would
		be set to a function that was OK with being in an
		RCU read-side critical section, an interrupt-disabled
		section, etc.

		This allows for possible addition of SRCU functionality.
		It is also a trivial change.  Note that the sole user
		of sync.c uses RCU_SCHED_SYNC, and this would need to
		be changed to RCU_SYNC.

		But is it likely that we will ever add SRCU?

	c.	Eliminate that gp_ops[] array, hard-coding the function
		pointers into their call sites.

	I don't really have a preference.  Left to myself, I will be lazy
	and take option #a.  Are there better approaches?

o	Currently, if a lock related to the scheduler's rq or pi locks is
	held across rcu_read_unlock(), that lock must be held across the
	entire read-side critical section in order to avoid deadlock.
	Now that the end of the RCU read-side critical section is
	deferred until sometime after interrupts are re-enabled, this
	requirement could be lifted.  However, because the end of the RCU
	read-side critical section is detected sometime after interrupts
	are re-enabled, this means that a low-priority RCU reader might
	remain priority-boosted longer than need be, which could be a
	problem when running real-time workloads.

	My current thought is therefore to leave this constraint in
	place.  Thoughts?

Anything else that I should be worried about?  ;-)

							Thanx, Paul

