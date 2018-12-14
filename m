Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686D3C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9322054F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9322054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbeLNAUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 19:20:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726254AbeLNAUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 19:20:52 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBE0JG02116697
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 19:20:50 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pbwcgufmr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 19:20:50 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 14 Dec 2018 00:20:49 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Dec 2018 00:20:44 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBE0KhuD20119760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Dec 2018 00:20:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3018BB2067;
        Fri, 14 Dec 2018 00:20:43 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00AE3B205F;
        Fri, 14 Dec 2018 00:20:42 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 14 Dec 2018 00:20:42 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4A50416C5F6F; Thu, 13 Dec 2018 16:20:43 -0800 (PST)
Date:   Thu, 13 Dec 2018 16:20:43 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     David Goldblatt <davidtgoldblatt@gmail.com>,
        mathieu.desnoyers@efficios.com,
        Florian Weimer <fweimer@redhat.com>, triegel@redhat.com,
        libc-alpha@sourceware.org, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux: Implement membarrier function
Reply-To: paulmck@linux.ibm.com
References: <20181212224931.GD4170@linux.ibm.com>
 <Pine.LNX.4.44L0.1812131026570.1586-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1812131026570.1586-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18121400-0052-0000-0000-00000366EC17
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010221; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01131394; UDB=6.00587980; IPR=6.00911526;
 MB=3.00024685; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-14 00:20:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121400-0053-0000-0000-00005F191544
Message-Id: <20181214002043.GP4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-13_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812140001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 10:49:49AM -0500, Alan Stern wrote:
> On Wed, 12 Dec 2018, Paul E. McKenney wrote:
> 
> > > Well, what are you trying to accomplish?  Do you want to find an 
> > > argument similar to the one I posted for the 6-CPU test to show that 
> > > this test should be forbidden?
> > 
> > I am trying to check odd corner cases.  Your sys_membarrier() model
> > is quite nice and certainly fits nicely with the rest of the model,
> > but where I come from, that is actually reason for suspicion.  ;-)
> > 
> > All kidding aside, your argument for the 6-CPU test was extremely
> > valuable, as it showed me a way to think of that test from an
> > implementation viewpoint.  Then the question is whether or not that
> > viewpoint actually matches the model, which seems to be the case thus far.
> 
> It should, since I formulated the reasoning behind that viewpoint 
> directly from the model.  The basic idea is this:
> 
> 	By induction, show that whenever we have A ->rcu-fence B then
> 	anything po-before A executes before anything po-after B, and
> 	furthermore, any write which propagates to A's CPU before A
> 	executes will propagate to every CPU before B finishes (i.e.,
> 	before anything po-after B executes).
> 
> 	Using this, show that whenever X ->rb Y holds then X must
> 	execute before Y.
> 
> That's what the 6-CPU argument did.  In that litmus test we have
> mb2 ->rcu-fence mb23, Rc ->rb Re, mb1 ->rcu-fence mb14, Rb ->rb Rf,
> mb0 ->rcu-fence mb05, and lastly Ra ->rb Ra.  The last one is what 
> shows that the test is forbidden.

I really am not trying to be difficult.  Well, no more difficult than
I normally am, anyway.  Which admittedly isn't saying much.  ;-)

> > A good next step would be to automatically generate random tests along
> > with an automatically generated prediction, like I did for RCU a few
> > years back.  I should be able to generalize my time-based cheat for RCU to
> > also cover SRCU, though sys_membarrier() will require a bit more thought.
> > (The time-based cheat was to have fixed duration RCU grace periods and
> > RCU read-side critical sections, with the grace period duration being
> > slightly longer than that of the critical sections.  The number of
> > processes is of course limited by the chosen durations, but that limit
> > can easily be made insanely large.)
> 
> Imagine that each sys_membarrier call takes a fixed duration and each 
> other instruction takes slightly less (the idea being that each 
> instruction is a critical section).  Instructions can be reordered 
> (although not across a sys_membarrier call), but no matter how the 
> reordering is done, the result is disallowed.

It gets a bit trickier with interleavings of different combinations
of RCU, SRCU, and sys_membarrier().  Yes, your cat code very elegantly
sorts this out, but my goal is to be able to explain a given example
to someone.

> > I guess that I still haven't gotten over being a bit surprised that the
> > RCU counting rule also applies to sys_membarrier().  ;-)
> 
> Why not?  They are both synchronization mechanisms with heavy-weight
> write sides and light-weight read sides, and most importantly, they
> provide the same Guarantee.

True, but I do feel the need to poke at it.

The zero-size sys_membarrier() read-side critical sections do make
things act a bit differently, for example, interchanging the accesses
in an RCU read-side critical section has no effect, while doing so in
a sys_membarrier() reader can cause the result to be allowed.  One key
point is that everything before the end of a read-side critical section
of any type is ordered before any later grace period of that same type,
and vice versa.

This is why reordering accesses matters for sys_membarrier() readers but
not for RCU and SRCU readers -- in the case of RCU and SRCU readers,
the accesses are inside the read-side critical section, while for
sys_membarrier() readers, the read-side critical sections don't have
an inside.  So yes, ordering also matters in the case of SRCU and
RCU readers for accesses outside of the read-side critical sections.
The reason sys_membarrier() seems surprising to me isn't because it is
any different in theoretical structure, but rather because the practice
is to put RCU and SRCU read-side accesses inside a read-side critical
sections, which is impossible for sys_membarrier().

The other thing that took some time to get used to is the possibility
of long delays during sys_membarrier() execution, allowing significant
execution and reordering between different CPUs' IPIs.  This was key
to my understanding of the six-process example, and probably needs to
be clearly called out, including in an example or two.

The interleaving restrictions are straightforward for me, but the
fixed-time approach does have some interesting cross-talk potential
between sys_membarrier() and RCU read-side critical sections whose
accesses have been reversed.  I don't believe that it is possible to
leverage this "order the other guy's read-side critical sections" effect
in the general case, but I could be missing something.

If you are claiming that I am worrying unnecessarily, you are probably
right.  But if I didn't worry unnecessarily, RCU wouldn't work at all!  ;-)

							Thanx, Paul

