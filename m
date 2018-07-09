Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URG_BIZ,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96D4C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614B42087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614B42087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932827AbeGIO1V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:27:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750996AbeGIO1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:27:20 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w69ENvNd033533
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 10:27:20 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k48k53q2y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 10:27:19 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Jul 2018 10:27:18 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Jul 2018 10:27:15 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w69ERE3e47186108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Jul 2018 14:27:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 528A4B2070;
        Mon,  9 Jul 2018 10:26:49 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E3AFB206C;
        Mon,  9 Jul 2018 10:26:49 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  9 Jul 2018 10:26:49 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 57E4916C0F7D; Mon,  9 Jul 2018 07:29:32 -0700 (PDT)
Date:   Mon, 9 Jul 2018 07:29:32 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     David Woodhouse <dwmw2@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180706162905.GZ2476@hirez.programming.kicks-ass.net>
 <20180706171150.GI3593@linux.vnet.ibm.com>
 <20180709085351.GC2476@hirez.programming.kicks-ass.net>
 <1531127935.18697.57.camel@infradead.org>
 <20180709104429.GI2476@hirez.programming.kicks-ass.net>
 <1531133801.18697.73.camel@infradead.org>
 <20180709110657.GL2476@hirez.programming.kicks-ass.net>
 <20180709123457.GM3593@linux.vnet.ibm.com>
 <20180709125516.GO2476@hirez.programming.kicks-ass.net>
 <20180709130227.GQ2512@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709130227.GQ2512@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070914-0064-0000-0000-000003274FB3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009338; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01058854; UDB=6.00543380; IPR=6.00836775;
 MB=3.00022073; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-09 14:27:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070914-0065-0000-0000-000039E00C6B
Message-Id: <20180709142932.GO3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=985 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807090165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 03:02:27PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 09, 2018 at 02:55:16PM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 09, 2018 at 05:34:57AM -0700, Paul E. McKenney wrote:
> > > But KVM defeats this by checking need_resched() before invoking
> > > cond_resched().
> > 
> > That's not wrong or even uncommon I think.
> 
> In fact, I think we recently put that pattern in crypto code in order to
> break up very long kernel_fpu sections.

OK, so here are our options:

1.	Add the RCU conditional to need_resched(), as David suggests.
	Peter has concerns about overhead.

2.	Create a new need_resched_rcu_qs() that is to be used when
	deciding whether or not to do cond_resched().  This would
	exact the overhead only where it is needed, but is one more
	thing for people to get wrong.

3.	Revert my changes to de-emphasize cond_resched_rcu_qs(),
	and go back to sprinkling cond_resched_rcu_qs() throughout
	the code.  This also is one more thing for people to get wrong,
	and might well eventually convert all cond_resched() calls to
	cond_resched_rcu_qs(), which sure seems like a failure mode to me.

4.	Others?

> Note that you also 'broke' cond_resched_lock() as that no longer matches
> cond_resched().

Given that cond_resched_lock() was there first, I believe that you can
just say "broke" without the quote marks.  :-/

Given that this code is releasing and acquiring a lock, I believe that
the patch below should cure this, aside from also needing to check
whether RCU needs a quiescent state.  Any other similar gotchas out there?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 537bced8f4bc..b559b556f464 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5017,6 +5017,7 @@ int __cond_resched_lock(spinlock_t *lock)
 			preempt_schedule_common();
 		else
 			cpu_relax();
+		rcu_all_qs();
 		ret = 1;
 		spin_lock(lock);
 	}

