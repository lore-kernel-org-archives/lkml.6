Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0144C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4A824110
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4A824110
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753878AbeGEP36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:29:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753816AbeGEP35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:29:57 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65FTkZE086561
        for <linux-kernel@vger.kernel.org>; Thu, 5 Jul 2018 11:29:56 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k1kpqersu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 11:29:54 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 5 Jul 2018 11:29:30 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Jul 2018 11:29:25 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w65FTOFh19005854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Jul 2018 15:29:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBFABB2064;
        Thu,  5 Jul 2018 11:29:05 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 877B4B2065;
        Thu,  5 Jul 2018 11:29:05 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.138.104])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  5 Jul 2018 11:29:05 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 89F9B16CA3C3; Thu,  5 Jul 2018 08:31:40 -0700 (PDT)
Date:   Thu, 5 Jul 2018 08:31:40 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Will Deacon <will.deacon@arm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        dlustig@nvidia.com
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180704121103.GB26941@arm.com>
 <Pine.LNX.4.44L0.1807051010380.1697-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1807051010380.1697-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070515-0064-0000-0000-000003257E7F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009313; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01056955; UDB=6.00542240; IPR=6.00834875;
 MB=3.00022011; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-05 15:29:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070515-0065-0000-0000-000039D46F05
Message-Id: <20180705153140.GO3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807050176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 10:21:36AM -0400, Alan Stern wrote:
> On Wed, 4 Jul 2018, Will Deacon wrote:
> 
> > Hi Alan,
> > 
> > On Tue, Jul 03, 2018 at 01:28:17PM -0400, Alan Stern wrote:
> > > On Mon, 25 Jun 2018, Andrea Parri wrote:
> > > 
> > > > On Fri, Jun 22, 2018 at 07:30:08PM +0100, Will Deacon wrote:
> > > > > > > I think the second example would preclude us using LDAPR for load-acquire,
> > > > 
> > > > > I don't think it's a moot point. We want new architectures to implement
> > > > > acquire/release efficiently, and it's not unlikely that they will have
> > > > > acquire loads that are similar in semantics to LDAPR. This patch prevents
> > > > > them from doing so,
> > > > 
> > > > By this same argument, you should not be a "big fan" of rfi-rel-acq in ppo ;)
> > > > consider, e.g., the two litmus tests below: what am I missing?
> > > 
> > > This is an excellent point, which seems to have gotten lost in the 
> > > shuffle.  I'd like to see your comments.
> > 
> > Yeah, sorry. Loads going on at the moment. You could ask herd instead of me
> > though ;)
> 
> Indeed; and the answer was as expected.  Sometimes one gains additional 
> insights by asking a person, though.
> 
> > > In essence, if you're using release-acquire instructions that only
> > > provide RCpc consistency, does store-release followed by load-acquire
> > > of the same address provide read-read ordering?  In theory it doesn't
> > > have to, because if the value from the store-release is forwarded to
> > > the load-acquire then:
> > > 
> > > 	LOAD A
> > > 	STORE-RELEASE X, v
> > > 	LOAD-ACQUIRE X
> > > 	LOAD B
> > > 
> > > could be executed by the CPU in the order:
> > > 
> > > 	LOAD-ACQUIRE X
> > > 	LOAD B
> > > 	LOAD A
> > > 	STORE-RELEASE X, v
> > > 
> > > thereby accessing A and B out of program order without violating the
> > > requirements on the release or the acquire.
> > > 
> > > Of course PPC doesn't allow this, but should we rule it out entirely?
> > 
> > This would be allowed if LOAD-ACQUIRE was implemented using LDAPR on Arm.
> > I don't think we should be ruling out architectures using RCpc
> > acquire/release primitives, because doing so just feels like an artifact of
> > most architectures building these out of fences today.
> > 
> > It's funny really, because from an Arm-perspective I don't plan to stray
> > outside of RCsc, but I feel like other weak architectures aren't being
> > well represented here. If we just care about x86, Arm and Power (and assume
> > that Power doesn't plan to implement RCpc acquire/release instructions)
> > then we're good to tighten things up. But I fear that RISC-V should probably
> > be more engaged (adding Daniel) and who knows about MIPS or these other
> > random architectures popping up on linux-arch.
> 
> I don't object to having weak versions of acquire/release in the LKMM.  
> Perhaps the stronger versions could be kept in the hardware model 
> (which has not been published and is not in the kernel source), but 
> even that might be a bad idea in view of what RISC-V is liable to do.
> 
> > > > C MP+fencewmbonceonce+pooncerelease-rfireleaseacquire-poacquireonce
> > > > 
> > > > {}
> > > > 
> > > > P0(int *x, int *y)
> > > > {
> > > > 	WRITE_ONCE(*x, 1);
> > > > 	smp_wmb();
> > > > 	WRITE_ONCE(*y, 1);
> > > > }
> > > > 
> > > > P1(int *x, int *y, int *z)
> > > > {
> > > > 	r0 = READ_ONCE(*y);
> > > > 	smp_store_release(z, 1);
> > > > 	r1 = smp_load_acquire(z);
> > > > 	r2 = READ_ONCE(*x);
> > > > }
> > > > 
> > > > exists (1:r0=1 /\ 1:r1=1 /\ 1:r2=0)
> > > > 
> > > > 
> > > > AArch64 MP+dmb.st+popl-rfilq-poqp
> > > > "DMB.STdWW Rfe PodRWPL RfiLQ PodRRQP Fre"
> > > > Generator=diyone7 (version 7.49+02(dev))
> > > > Prefetch=0:x=F,0:y=W,1:y=F,1:x=T
> > > > Com=Rf Fr
> > > > Orig=DMB.STdWW Rfe PodRWPL RfiLQ PodRRQP Fre
> > > > {
> > > > 0:X1=x; 0:X3=y;
> > > > 1:X1=y; 1:X3=z; 1:X6=x;
> > > > }
> > > >  P0          | P1            ;
> > > >  MOV W0,#1   | LDR W0,[X1]   ;
> > > >  STR W0,[X1] | MOV W2,#1     ;
> > > >  DMB ST      | STLR W2,[X3]  ;
> > > >  MOV W2,#1   | LDAPR W4,[X3] ;
> > > >  STR W2,[X3] | LDR W5,[X6]   ;
> > > > exists
> > > > (1:X0=1 /\ 1:X4=1 /\ 1:X5=0)
> > 
> > (you can also run this yourself, since 'Q' is supported in the .cat file
> > I contributed to herdtools7)
> > 
> > Test MP+dmb.sy+popl-rfilq-poqp Allowed
> > States 4
> > 1:X0=0; 1:X4=1; 1:X5=0;
> > 1:X0=0; 1:X4=1; 1:X5=1;
> > 1:X0=1; 1:X4=1; 1:X5=0;
> > 1:X0=1; 1:X4=1; 1:X5=1;
> > Ok
> > Witnesses
> > Positive: 1 Negative: 3
> > Condition exists (1:X0=1 /\ 1:X4=1 /\ 1:X5=0)
> > Observation MP+dmb.sy+popl-rfilq-poqp Sometimes 1 3
> > Time MP+dmb.sy+popl-rfilq-poqp 0.01
> > Hash=61858b7b59a6310d869f99cd05718f96
> > 
> > > There's also read-write ordering, in the form of the LB pattern:
> > > 
> > > P0(int *x, int *y, int *z)
> > > {
> > > 	r0 = READ_ONCE(*x);
> > > 	smp_store_release(z, 1);
> > > 	r1 = smp_load_acquire(z);
> > > 	WRITE_ONCE(*y, 1);
> > > }
> > > 
> > > P1(int *x, int *y)
> > > {
> > > 	r2 = READ_ONCE(*y);
> > > 	smp_mp();
> > > 	WRITE_ONCE(*x, 1);
> > > }
> > > 
> > > exists (0:r0=1 /\ 1:r2=1)
> > 
> > The access types are irrelevant to the acquire/release primitives, so yes
> > that's also allowed.
> > 
> > > Would this be allowed if smp_load_acquire() was implemented with LDAPR?
> > > If the answer is yes then we will have to remove the rfi-rel-acq and
> > > rel-rf-acq-po relations from the memory model entirely.
> > 
> > I don't understand what you mean by "rfi-rel-acq-po", and I assume you mean
> > rel-rfi-acq-po for the other? Sounds like I'm confused here.
> 
> "rfi-rel-acq" is the relation which was removed by the first of my two
> patches (it is now back in business since Paul reverted the commits),
> and "rel-rf-acq-po" is the relation that was introduced to replace it.
> 
> At any rate, it looks like instead of strengthening the relation, I
> should write a patch that removes it entirely.  I also will add new,
> stronger relations for use with locking, essentially making spin_lock
> and spin_unlock be RCsc.

Only in the presence of smp_mb__after_unlock_lock() or
smp_mb__after_spinlock(), correct?  Or am I confused about RCsc?

							Thanx, Paul

