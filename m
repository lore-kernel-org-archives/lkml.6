Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492F6C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0187226EFA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0187226EFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeFZS1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:27:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752231AbeFZS1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:27:52 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QIQFZJ085443
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 14:27:52 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jutrtg1tt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 14:27:52 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 14:27:51 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 14:27:45 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QIRinU8585548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 18:27:44 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6025BB2065;
        Tue, 26 Jun 2018 14:27:38 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EEE9B205F;
        Tue, 26 Jun 2018 14:27:38 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 14:27:38 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2C0A516C15BE; Tue, 26 Jun 2018 11:29:50 -0700 (PDT)
Date:   Tue, 26 Jun 2018 11:29:50 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626175119.GL2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062618-0068-0000-0000-0000030E8884
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052695; UDB=6.00539684; IPR=6.00830618;
 MB=3.00021866; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 18:27:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062618-0069-0000-0000-000044D15980
Message-Id: <20180626182950.GH3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=928 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 07:51:19PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 26, 2018 at 10:10:39AM -0700, Paul E. McKenney wrote:
> > Without special fail-safe quiescent-state-propagation checks, grace-period
> > hangs can result from the following scenario:
> > 
> > 1.	CPU 1 goes offline.
> > 
> > 2.	Because CPU 1 is the only CPU in the system blocking the current
> > 	grace period, as soon as rcu_cleanup_dying_idle_cpu()'s call to
> > 	rcu_report_qs_rnp() returns.
> > 
> > 3.	At this point, the leaf rcu_node structure's ->lock is no longer
> > 	held: rcu_report_qs_rnp() has released it, as it must in order
> > 	to awaken the RCU grace-period kthread.
> > 
> > 4.	At this point, that same leaf rcu_node structure's ->qsmaskinitnext
> > 	field still records CPU 1 as being online.  This is absolutely
> > 	necessary because the scheduler uses RCU, and ->qsmaskinitnext
> 
> Can you expand a bit on this, where does the scheduler care about the
> online state of the CPU that's about to call into arch_cpu_idle_dead()?

Because the CPU does a context switch between the time that the CPU gets
marked offline from the viewpoint of cpu_offline() and the time that
the CPU finally makes it to arch_cpu_idle_dead().  Plus reporting the
quiescent state (rcu_report_qs_rnp()) can result in waking up RCU's
grace-period kthread.  During that context switch and that wakeup,
the scheduler needs RCU to continue paying attention to the outgoing
CPU, right?

> > 	contains RCU's idea as to which CPUs are online.  Therefore,
> > 	invoking rcu_report_qs_rnp() after clearing CPU 1's bit from
> > 	->qsmaskinitnext would result in a lockdep-RCU splat due to
> > 	RCU being used from an offline CPU.
> > 
> > 5.	RCU's grace-period kthread awakens, sees that the old grace period
> > 	has completed and that a new one is needed.  It therefore starts
> > 	a new grace period, but because CPU 1's leaf rcu_node structure's
> > 	->qsmaskinitnext field still shows CPU 1 as being online, this new
> > 	grace period is initialized to wait for a quiescent state from the
> > 	now-offline CPU 1.
> 
> If we're past cpuhp_report_idle_cpu() -> rcu_report_dead(), then
> cpu_offline() is true. Is that not sufficient state to avoid this?

Not from what I can see.  To avoid this, I need to synchronize
with rcu_gp_init(), but I cannot rely on the usual rcu_node ->lock
synchronization without severely complicating quiescent-state reporting.
For one thing, quiescent-state reporting can require waking up the
grace-period kthread, which cannot be done while holding any rcu_node
->lock due to deadlock.  I -could- defer the wakeup (as is done in
several other places), but adding the separate lock is much simpler,
and given that both grace-period initialization and CPU hotplug are
relatively rare operations, the extra overhead is way down in the noise.

Or am I missing a trick here?

							Thanx, Paul

> > 6.	Without the fail-safe force-quiescent-state checks, there would
> > 	be no quiescent state from the now-offline CPU 1, which would
> > 	eventually result in RCU CPU stall warnings and memory exhaustion.
> 

