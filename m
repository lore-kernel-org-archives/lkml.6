Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB65BC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633EF2795E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633EF2795E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932409AbeF2E2C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 00:28:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41956 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932267AbeF2E2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 00:28:01 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5T4O51X033476
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 00:28:00 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jwdh18jc9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 00:28:00 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 29 Jun 2018 00:27:59 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Jun 2018 00:27:54 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5T4RrDn9175454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Jun 2018 04:27:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92FD7B2066;
        Fri, 29 Jun 2018 00:27:43 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56D93B2064;
        Fri, 29 Jun 2018 00:27:43 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.206.224])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 29 Jun 2018 00:27:43 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EAB3D16CA2DE; Thu, 28 Jun 2018 21:30:00 -0700 (PDT)
Date:   Thu, 28 Jun 2018 21:30:00 -0700
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
References: <20180626203225.GT2494@hirez.programming.kicks-ass.net>
 <20180626234004.GQ3593@linux.vnet.ibm.com>
 <20180627091106.GB7184@worktop.programming.kicks-ass.net>
 <20180627094633.GG2512@hirez.programming.kicks-ass.net>
 <20180627155721.GZ3593@linux.vnet.ibm.com>
 <20180627175134.GV2494@hirez.programming.kicks-ass.net>
 <20180628051334.GG3593@linux.vnet.ibm.com>
 <20180628082653.GX2494@hirez.programming.kicks-ass.net>
 <20180628123833.GJ3593@linux.vnet.ibm.com>
 <20180628130646.GH2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628130646.GH2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062904-0064-0000-0000-000003220FEB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009275; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01053854; UDB=6.00540380; IPR=6.00831777;
 MB=3.00021919; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-29 04:27:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062904-0065-0000-0000-000039C1182E
Message-Id: <20180629043000.GW3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=919 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806290048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 03:06:46PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 28, 2018 at 05:38:33AM -0700, Paul E. McKenney wrote:
> > Please let me try again.
> > 
> > The approach you are suggesting, clever though it is, disables a check
> 
>   https://lkml.kernel.org/r/20180627094633.GG2512@hirez.programming.kicks-ass.net
> 
> Is the one we're talking about, right?

Yes.

> That does not disable any actual check afaict. It simply does not do a
> wakeup when ran on an offline CPU. And ensures we do an unconditional
> wakeup soon after from a still running CPU.

It does implicitly by avoiding doing the wakeup when the CPU is offline.
This has the effect of disabling the RCU checks in your wakeup code.

> > of a type that has proved to be an important diagnostic in the past.
> > It is only reasonable to assume that this check would be important
> > and helpful in the future, but only if that check remains in the code.
> 
> I am confused..
> 
> > Yes, agreed, given the current structure of the code, this particular
> > instance of the check would not matter, but experience indicates that
> > RCU code restructuring is not at all uncommon, with the current effort
> > being but one case in point.
> 
> Once more confused...
> 
> > So, unless I am missing something, the only possible benefit of disabling
> > this check is getting rid of an acquisition of an uncontended lock in
> > a code path that is miles (sorry, kilometers) away from any fastpath.
> > So, again, yes, it is clever.  If it sped up a fastpath, I might be
> > sorely tempted to take it.  But the alternative is straightforward and
> > isn't anywhere near a fastpath.  So, though I do very much appreciate
> > the cleverness and creativity, I am not seeing your change to be a
> > good tradeoff from a long-term maintainability viewpoint.
> 
> I think you mean guarantee/invariant instead of check. But I see it no
> different than any other missed rcu_gp_kthread_wake(). You can similarly
> fail to make the call while restructuring.

Well, we do use checks to detect failures to provide guarantees and to
maintain invariants, so they are closely related.  And yes, for any check
you might provide, there are ways to defeat that check.  Software and
all that.

But we do seem to be talking past each other.  One option would be for
me to take another look after I get the cleanup code generated for the
RCU flavor consolidation, which will be some weeks.  Either or both of
us might have come up with a better approach in that time anyway, right?

							Thanx, Paul

