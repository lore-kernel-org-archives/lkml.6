Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A68CC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B2720838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B2720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeLFV5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:57:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726044AbeLFV5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:57:13 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB6LvAQ2101031
        for <linux-kernel@vger.kernel.org>; Thu, 6 Dec 2018 16:57:11 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p79paen1f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 16:57:09 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 6 Dec 2018 21:54:12 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Dec 2018 21:54:07 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB6Ls6wa21364958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Dec 2018 21:54:06 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D4BCB2065;
        Thu,  6 Dec 2018 21:54:06 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF929B2064;
        Thu,  6 Dec 2018 21:54:05 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  6 Dec 2018 21:54:05 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7D86416C5F8B; Thu,  6 Dec 2018 13:54:05 -0800 (PST)
Date:   Thu, 6 Dec 2018 13:54:05 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     David Goldblatt <davidtgoldblatt@gmail.com>
Cc:     mathieu.desnoyers@efficios.com,
        Florian Weimer <fweimer@redhat.com>, triegel@redhat.com,
        libc-alpha@sourceware.org, stern@rowland.harvard.edu,
        andrea.parri@amarulasolutions.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux: Implement membarrier function
Reply-To: paulmck@linux.ibm.com
References: <8736rldyzm.fsf@oldenburg.str.redhat.com>
 <1543444466.5493.220.camel@redhat.com>
 <87y39c2dsg.fsf@oldenburg.str.redhat.com>
 <1689938209.14804.1543502662882.JavaMail.zimbra@efficios.com>
 <20181129150433.GH4170@linux.ibm.com>
 <CAHD6eXcvx1bskbp-X+vuMYoMQiCLOt0PiCZ5FT1yFsda9Ud-yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHD6eXcvx1bskbp-X+vuMYoMQiCLOt0PiCZ5FT1yFsda9Ud-yA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18120621-0040-0000-0000-0000049EA3A5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010184; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01127988; UDB=6.00577119; IPR=6.00908118;
 MB=3.00024515; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-06 21:54:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120621-0041-0000-0000-000008A7C01D
Message-Id: <20181206215405.GL4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812060184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, David,

I took a crack at extending LKMM to accommodate what I think would
support what you have in your paper.  Please see the very end of this
email for a patch against the "dev" branch of my -rcu tree.

This gives the expected result for the following three litmus tests,
but is probably deficient or otherwise misguided in other ways.  I have
added the LKMM maintainers on CC for their amusement.  ;-)

Thoughts?

						Thanx, Paul

------------------------------------------------------------------------

C C-Goldblat-memb-1
{
}

P0(int *x0, int *x1)
{
	WRITE_ONCE(*x0, 1);
	r1 = READ_ONCE(*x1);
}


P1(int *x0, int *x1)
{
	WRITE_ONCE(*x1, 1);
	smp_memb();
	r2 = READ_ONCE(*x0);
}

exists (0:r1=0 /\ 1:r2=0)

------------------------------------------------------------------------

C C-Goldblat-memb-2
{
}

P0(int *x0, int *x1)
{
	WRITE_ONCE(*x0, 1);
	r1 = READ_ONCE(*x1);
}


P1(int *x1, int *x2)
{
	WRITE_ONCE(*x1, 1);
	smp_memb();
	r1 = READ_ONCE(*x2);
}

P2(int *x2, int *x0)
{
	WRITE_ONCE(*x2, 1);
	r1 = READ_ONCE(*x0);
}

exists (0:r1=0 /\ 1:r1=0 /\ 2:r1=0)

------------------------------------------------------------------------

C C-Goldblat-memb-3
{
}

P0(int *x0, int *x1)
{
	WRITE_ONCE(*x0, 1);
	r1 = READ_ONCE(*x1);
}


P1(int *x1, int *x2)
{
	WRITE_ONCE(*x1, 1);
	smp_memb();
	r1 = READ_ONCE(*x2);
}

P2(int *x2, int *x3)
{
	WRITE_ONCE(*x2, 1);
	r1 = READ_ONCE(*x3);
}

P3(int *x3, int *x0)
{
	WRITE_ONCE(*x3, 1);
	smp_memb();
	r1 = READ_ONCE(*x0);
}

exists (0:r1=0 /\ 1:r1=0 /\ 2:r1=0 /\ 3:r1=0)

------------------------------------------------------------------------

On Thu, Nov 29, 2018 at 11:02:17AM -0800, David Goldblatt wrote:
> One note with the suggested patch is that
> `atomic_thread_fence(memory_order_acq_rel)` should probably be
> `atomic_thread_fence (memory_order_seq_cst)` (otherwise the call would
> be a no-op on, say, x86, which it very much isn't).
> 
> The non-transitivity thing makes the resulting description arguably
> incorrect, but this is informal enough that it might not be a big deal
> to add something after "For these threads, the membarrier function
> call turns an existing compiler barrier (see above) executed by these
> threads into full memory barriers" that clarifies it. E.g. you could
> make it into "turns an existing compiler barrier [...] into full
> memory barriers, with respect to the calling thread".
> 
> Since this is targeting the description of the OS call (and doesn't
> have to concern itself with also being implementable by other
> asymmetric techniques or degrading to architectural barriers), I think
> that the description in "approach 2" in P1202 would also make sense
> for a formal description of the syscall. (Of course, without the
> kernel itself committing to a rigorous semantics, anything specified
> on top of it will be on slightly shaky ground).
> 
> - David
> 
> On Thu, Nov 29, 2018 at 7:04 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> >
> > On Thu, Nov 29, 2018 at 09:44:22AM -0500, Mathieu Desnoyers wrote:
> > > ----- On Nov 29, 2018, at 8:50 AM, Florian Weimer fweimer@redhat.com wrote:
> > >
> > > > * Torvald Riegel:
> > > >
> > > >> On Wed, 2018-11-28 at 16:05 +0100, Florian Weimer wrote:
> > > >>> This is essentially a repost of last year's patch, rebased to the glibc
> > > >>> 2.29 symbol version and reflecting the introduction of
> > > >>> MEMBARRIER_CMD_GLOBAL.
> > > >>>
> > > >>> I'm not including any changes to manual/ here because the set of
> > > >>> supported operations is evolving rapidly, we could not get consensus for
> > > >>> the language I proposed the last time, and I do not want to contribute
> > > >>> to the manual for the time being.
> > > >>
> > > >> Fair enough.  Nonetheless, can you summarize how far you're along with
> > > >> properly defining the semantics (eg, based on the C/C++ memory model)?
> > > >
> > > > I wrote down what you could, but no one liked it.
> > > >
> > > > <https://sourceware.org/ml/libc-alpha/2017-12/msg00796.html>
> > > >
> > > > I expect that a formalization would interact in non-trivial ways with
> > > > any potential formalization of usable relaxed memory order semantics,
> > > > and I'm not sure if anyone knows how to do the latter today.
> > >
> > > Adding Paul E. McKenney in CC.
> >
> > There is some prototype C++ memory model wording from David Goldblatt (CCed)
> > here (search for "Standarese"):
> >
> > http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p1202r0.pdf
> >
> > David's key insight is that (in Linuxese) light fences cannot pair with
> > each other.

------------------------------------------------------------------------

commit 17e3b6b60e57d1cb791f68a1a6a36e942cb2baad
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Thu Dec 6 13:40:40 2018 -0800

    EXP tools/memory-model: Add semantics for sys_membarrier()
    
    This prototype commit extends LKMM to accommodate sys_membarrier(),
    which is a asymmetric barrier with a limited ability to insert full
    ordering into tasks that provide only compiler ordering.  This commit
    currently uses the "po" relation for this purpose, but something more
    sophisticated will be required when plain accesses are added, which
    the compiler can reorder.
    
    For more detail, please see David Goldblatt's C++ working paper:
    http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p1202r0.pdf
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 9c42cd9ddcb4..4ef41453f569 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -24,6 +24,7 @@ instructions RMW[{'once,'acquire,'release}]
 enum Barriers = 'wmb (*smp_wmb*) ||
 		'rmb (*smp_rmb*) ||
 		'mb (*smp_mb*) ||
+		'memb (*sys_membarrier*) ||
 		'rcu-lock (*rcu_read_lock*)  ||
 		'rcu-unlock (*rcu_read_unlock*) ||
 		'sync-rcu (*synchronize_rcu*) ||
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 8dcb37835b61..837c3ee20bea 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -33,9 +33,10 @@ let mb = ([M] ; fencerel(Mb) ; [M]) |
 	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
 	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
 		fencerel(After-unlock-lock) ; [M])
+let memb = [M] ; fencerel(Memb) ; [M]
 let gp = po ; [Sync-rcu | Sync-srcu] ; po?
 
-let strong-fence = mb | gp
+let strong-fence = mb | gp | memb
 
 (* Release Acquire *)
 let acq-po = [Acquire] ; po ; [M]
@@ -86,6 +87,13 @@ acyclic hb as happens-before
 let pb = prop ; strong-fence ; hb*
 acyclic pb as propagation
 
+(********************)
+(* sys_membarrier() *)
+(********************)
+
+let memb-step = ( prop ; po ; prop )? ; memb
+acyclic memb-step as memb-before
+
 (*******)
 (* RCU *)
 (*******)
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index 1d6a120cde14..9ff0691c5f2c 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -17,6 +17,7 @@ rcu_dereference(X) __load{once}(X)
 smp_store_mb(X,V) { __store{once}(X,V); __fence{mb}; }
 
 // Fences
+smp_memb() { __fence{memb}; }
 smp_mb() { __fence{mb}; }
 smp_rmb() { __fence{rmb}; }
 smp_wmb() { __fence{wmb}; }

