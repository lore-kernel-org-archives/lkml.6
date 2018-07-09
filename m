Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URG_BIZ,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E924FC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98452087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98452087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933015AbeGIMcq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:32:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932568AbeGIMco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:32:44 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w69CTO7E034686
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 08:32:44 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k45n9yw8e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:32:44 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Jul 2018 08:32:42 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Jul 2018 08:32:38 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w69CWb7e62521566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Jul 2018 12:32:38 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D2D3B2064;
        Mon,  9 Jul 2018 08:32:13 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D43CB205F;
        Mon,  9 Jul 2018 08:32:13 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.209])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  9 Jul 2018 08:32:13 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4989916C166E; Mon,  9 Jul 2018 05:34:57 -0700 (PDT)
Date:   Mon, 9 Jul 2018 05:34:57 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     David Woodhouse <dwmw2@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Reply-To: paulmck@linux.vnet.ibm.com
References: <bb77e730a5ada3689650b636e1dd03ac5cc87256.camel@infradead.org>
 <20180706162905.GZ2476@hirez.programming.kicks-ass.net>
 <20180706171150.GI3593@linux.vnet.ibm.com>
 <20180709085351.GC2476@hirez.programming.kicks-ass.net>
 <1531127935.18697.57.camel@infradead.org>
 <20180709104429.GI2476@hirez.programming.kicks-ass.net>
 <1531133801.18697.73.camel@infradead.org>
 <20180709110657.GL2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709110657.GL2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070912-0060-0000-0000-000002898283
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009337; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01058816; UDB=6.00543357; IPR=6.00836736;
 MB=3.00022070; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-09 12:32:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070912-0061-0000-0000-000045BC2491
Message-Id: <20180709123457.GM3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=456 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807090144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 01:06:57PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 09, 2018 at 11:56:41AM +0100, David Woodhouse wrote:
> 
> > > But either proposal is exactly the same in this respect. The whole
> > > rcu_urgent_qs thing won't be set any earlier either.
> > 
> > Er.... Marius, our latencies in expand_fdtable() definitely went from
> > ~10s to well below one second when we just added the rcu_all_qs() into
> > the loop, didn't they? And that does nothing if !rcu_urgent_qs.
> 
> Argh I never found that, because obfuscation:
> 
> 	ruqp = per_cpu_ptr(&rcu_dynticks.rcu_urgent_qs, rdp->cpu);
> 	...
> 		smp_store_release(ruqp, true);
> 
> I, using git grep "rcu_urgent_qs.*true" only found
> rcu_request_urgent_qs_task() and sync_sched_exp_handler().

Yeah, got tired of typing that long string too many times, so made a
short-named pointer...

> But how come KVM even triggers that case; rcu_implicit_dynticks_qs() is
> for NOHZ and offline CPUs.

Mostly, yes.  But it also takes measures when CPUs take too long to
check in.

The reason that David's latencies went from 100ms to one second is
because I made this code less aggressive about invoking resched_cpu().
The reason I did that was to allow cond_resched_rcu_qs() to be used less
without performance regressions.  And just plain cond_resched() on
!PREEMPT is intended to handle the faster checks.  But KVM defeats
this by checking need_resched() before invoking cond_resched().

For PREEMPT, either the scheduling-clock interrupt sees that there
is no RCU-read-side critical section or we have either idle or
nohz_full userspace execution.

Of course, if there really is a huge RCU read-side critical section that
really does take 15 seconds to execute, there is of course nothing that
RCU can do about that.  But as you say later, even a one-second critical
section is huge and needs to be broken up somehow.  Which should
introduce (at the very least) a cond_resched() for !PREEMPT or an
rcu_read_unlock() and thus rcu_read_unlock_special() for PREEMPT.

							Thanx, Paul

