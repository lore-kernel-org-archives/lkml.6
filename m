Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84711C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33BD8208B6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BD8208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933804AbeGDL0q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:26:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932594AbeGDL0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:26:44 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w64BPvJl026662
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 07:26:44 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0wbx010n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:26:43 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 4 Jul 2018 07:26:43 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 07:26:39 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w64BQceE42598530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 11:26:38 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 985E4B2065;
        Wed,  4 Jul 2018 07:26:20 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63E11B205F;
        Wed,  4 Jul 2018 07:26:20 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.138.104])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  4 Jul 2018 07:26:20 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3F6FD16CA478; Wed,  4 Jul 2018 04:28:52 -0700 (PDT)
Date:   Wed, 4 Jul 2018 04:28:52 -0700
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
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180625081920.GA5619@andrea>
 <Pine.LNX.4.44L0.1807031228250.1513-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1807031228250.1513-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070411-0060-0000-0000-000002873107
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009307; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01056394; UDB=6.00541904; IPR=6.00834316;
 MB=3.00021991; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-04 11:26:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070411-0061-0000-0000-000045AD0559
Message-Id: <20180704112852.GH3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 01:28:17PM -0400, Alan Stern wrote:
> Will:
> 
> On Mon, 25 Jun 2018, Andrea Parri wrote:
> 
> > On Fri, Jun 22, 2018 at 07:30:08PM +0100, Will Deacon wrote:
> > > > > I think the second example would preclude us using LDAPR for load-acquire,
> > 
> > > I don't think it's a moot point. We want new architectures to implement
> > > acquire/release efficiently, and it's not unlikely that they will have
> > > acquire loads that are similar in semantics to LDAPR. This patch prevents
> > > them from doing so,
> > 
> > By this same argument, you should not be a "big fan" of rfi-rel-acq in ppo ;)
> > consider, e.g., the two litmus tests below: what am I missing?
> 
> This is an excellent point, which seems to have gotten lost in the 
> shuffle.  I'd like to see your comments.
> 
> In essence, if you're using release-acquire instructions that only
> provide RCpc consistency, does store-release followed by load-acquire
> of the same address provide read-read ordering?  In theory it doesn't
> have to, because if the value from the store-release is forwarded to
> the load-acquire then:
> 
> 	LOAD A
> 	STORE-RELEASE X, v
> 	LOAD-ACQUIRE X
> 	LOAD B
> 
> could be executed by the CPU in the order:
> 
> 	LOAD-ACQUIRE X
> 	LOAD B
> 	LOAD A
> 	STORE-RELEASE X, v
> 
> thereby accessing A and B out of program order without violating the
> requirements on the release or the acquire.
> 
> Of course PPC doesn't allow this, but should we rule it out entirely?
> 
> > C MP+fencewmbonceonce+pooncerelease-rfireleaseacquire-poacquireonce
> > 
> > {}
> > 
> > P0(int *x, int *y)
> > {
> > 	WRITE_ONCE(*x, 1);
> > 	smp_wmb();
> > 	WRITE_ONCE(*y, 1);
> > }
> > 
> > P1(int *x, int *y, int *z)
> > {
> > 	r0 = READ_ONCE(*y);
> > 	smp_store_release(z, 1);
> > 	r1 = smp_load_acquire(z);
> > 	r2 = READ_ONCE(*x);
> > }
> > 
> > exists (1:r0=1 /\ 1:r1=1 /\ 1:r2=0)
> > 
> > 
> > AArch64 MP+dmb.st+popl-rfilq-poqp
> > "DMB.STdWW Rfe PodRWPL RfiLQ PodRRQP Fre"
> > Generator=diyone7 (version 7.49+02(dev))
> > Prefetch=0:x=F,0:y=W,1:y=F,1:x=T
> > Com=Rf Fr
> > Orig=DMB.STdWW Rfe PodRWPL RfiLQ PodRRQP Fre
> > {
> > 0:X1=x; 0:X3=y;
> > 1:X1=y; 1:X3=z; 1:X6=x;
> > }
> >  P0          | P1            ;
> >  MOV W0,#1   | LDR W0,[X1]   ;
> >  STR W0,[X1] | MOV W2,#1     ;
> >  DMB ST      | STLR W2,[X3]  ;
> >  MOV W2,#1   | LDAPR W4,[X3] ;
> >  STR W2,[X3] | LDR W5,[X6]   ;
> > exists
> > (1:X0=1 /\ 1:X4=1 /\ 1:X5=0)
> 
> There's also read-write ordering, in the form of the LB pattern:
> 
> P0(int *x, int *y, int *z)
> {
> 	r0 = READ_ONCE(*x);
> 	smp_store_release(z, 1);
> 	r1 = smp_load_acquire(z);
> 	WRITE_ONCE(*y, 1);
> }
> 
> P1(int *x, int *y)
> {
> 	r2 = READ_ONCE(*y);
> 	smp_mp();
> 	WRITE_ONCE(*x, 1);
> }
> 
> exists (0:r0=1 /\ 1:r2=1)
> 
> Would this be allowed if smp_load_acquire() was implemented with LDAPR?
> If the answer is yes then we will have to remove the rfi-rel-acq and
> rel-rf-acq-po relations from the memory model entirely.
> 
> Alan
> 
> PS: Paul, is the patch which introduced rel-rf-acq-po currently present
> in any of your branches?  I couldn't find it.

It is not, I will add it back in.  I misinterpreted your "drop this
patch" on 2/2 as "drop both patches".  Please accept my apologies!

Just to double-check, the patch below should be added, correct?

							Thanx, Paul

------------------------------------------------------------------------

Date: Thu, 21 Jun 2018 13:26:49 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,        Andrea Parri
 <andrea.parri@amarulasolutions.com>,        Boqun Feng
 <boqun.feng@gmail.com>, David Howells <dhowells@redhat.com>,        
 Jade Alglave <j.alglave@ucl.ac.uk>,        Luc Maranget <luc.maranget@inria.fr>,
 Nicholas Piggin <npiggin@gmail.com>,        
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,        Peter Zijlstra <peterz@infradead.org>,
 Will Deacon <will.deacon@arm.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] tools/memory-model: Change rel-rfi-acq ordering to
 (rel-rf-acq-po & int)
Message-ID: <Pine.LNX.4.44L0.1806211315550.2381-100000@iolanthe.rowland.org>

This patch changes the LKMM rule which says that an acquire which
reads from an earlier release must be executed after that release (in
other words, the release cannot be forwarded to the acquire).  This is
not true on PowerPC, for example.

What is true instead is that any instruction following the acquire
must be executed after the release.  On some architectures this is
because a write-release cannot be forwarded to a read-acquire; on
others (including PowerPC) it is because the implementation of
smp_load_acquire() places a memory barrier immediately after the
load.

This change to the model does not cause any change to the model's
predictions.  This is because any link starting from a load must be an
instance of either po or fr.  In the po case, the new rule will still
provide ordering.  In the fr case, we also have ordering because there
must be a co link to the same destination starting from the
write-release.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---


[as1870]


 tools/memory-model/Documentation/explanation.txt |   35 ++++++++++++-----------
 tools/memory-model/linux-kernel.cat              |    6 +--
 2 files changed, 22 insertions(+), 19 deletions(-)

Index: usb-4.x/tools/memory-model/linux-kernel.cat
===================================================================
--- usb-4.x.orig/tools/memory-model/linux-kernel.cat
+++ usb-4.x/tools/memory-model/linux-kernel.cat
@@ -38,7 +38,7 @@ let strong-fence = mb | gp
 (* Release Acquire *)
 let acq-po = [Acquire] ; po ; [M]
 let po-rel = [M] ; po ; [Release]
-let rfi-rel-acq = [Release] ; rfi ; [Acquire]
+let rel-rf-acq-po = [Release] ; rf ; [Acquire] ; po

 (**********************************)
 (* Fundamental coherence ordering *)
@@ -60,9 +60,9 @@ let dep = addr | data
 let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int)
-let to-r = addr | (dep ; rfi) | rfi-rel-acq
+let to-r = addr | (dep ; rfi)
 let fence = strong-fence | wmb | po-rel | rmb | acq-po
-let ppo = to-r | to-w | fence
+let ppo = to-r | to-w | fence | (rel-rf-acq-po & int)

 (* Propagation: Ordering from release operations and strong fences. *)
 let A-cumul(r) = rfe? ; r
Index: usb-4.x/tools/memory-model/Documentation/explanation.txt
===================================================================
--- usb-4.x.orig/tools/memory-model/Documentation/explanation.txt
+++ usb-4.x/tools/memory-model/Documentation/explanation.txt
@@ -1067,27 +1067,30 @@ allowing out-of-order writes like this t
 violating the write-write coherence rule by requiring the CPU not to
 send the W write to the memory subsystem at all!)

-There is one last example of preserved program order in the LKMM: when
-a load-acquire reads from an earlier store-release.  For example:
+There is one last example of preserved program order in the LKMM; it
+applies to instructions po-after a load-acquire which reads from an
+earlier store-release.  For example:

 	smp_store_release(&x, 123);
 	r1 = smp_load_acquire(&x);
+	WRITE_ONCE(&y, 246);

 If the smp_load_acquire() ends up obtaining the 123 value that was
-stored by the smp_store_release(), the LKMM says that the load must be
-executed after the store; the store cannot be forwarded to the load.
-This requirement does not arise from the operational model, but it
-yields correct predictions on all architectures supported by the Linux
-kernel, although for differing reasons.
-
-On some architectures, including x86 and ARMv8, it is true that the
-store cannot be forwarded to the load.  On others, including PowerPC
-and ARMv7, smp_store_release() generates object code that starts with
-a fence and smp_load_acquire() generates object code that ends with a
-fence.  The upshot is that even though the store may be forwarded to
-the load, it is still true that any instruction preceding the store
-will be executed before the load or any following instructions, and
-the store will be executed before any instruction following the load.
+written by the smp_store_release(), the LKMM says that the store to y
+must be executed after the store to x.  In fact, the only way this
+could fail would be if the store-release was forwarded to the
+load-acquire; the LKMM says it holds even in that case.  This
+requirement does not arise from the operational model, but it yields
+correct predictions on all architectures supported by the Linux
+kernel, although for differing reasons:
+
+On some architectures, including x86 and ARMv8, a store-release cannot
+be forwarded to a load-acquire.  On others, including PowerPC and
+ARMv7, smp_load_acquire() generates object code that ends with a
+fence.  The result is that even though the store-release may be
+forwarded to the load-acquire, it is still true that the store-release
+(and all preceding instructions) will be executed before any
+instruction following the load-acquire.


 AND THEN THERE WAS ALPHA


