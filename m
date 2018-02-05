Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeBEHTK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 02:19:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750943AbeBEHTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 02:19:00 -0500
Date: Sun, 4 Feb 2018 23:19:03 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, parri.andrea@gmail.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, boqun.feng@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, npiggin@gmail.com,
        dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com,
        akiyks@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180204101700.GA25520@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1802041119590.16222-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802041119590.16222-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020507-0040-0000-0000-000003EEAC40
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008474; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00985166; UDB=6.00499850; IPR=6.00764538;
 BA=6.00005811; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019368; XFM=3.00000015;
 UTC=2018-02-05 07:18:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020507-0041-0000-0000-000007E41D2A
Message-Id: <20180205071903.GV3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-05_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802050093
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 04, 2018 at 11:37:59AM -0500, Alan Stern wrote:
> On Sun, 4 Feb 2018, Paul E. McKenney wrote:
> 
> > --- a/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
> > +++ b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
> > @@ -1,5 +1,11 @@
> >  C CoRW+poonceonce+Once
> >  
> > +(*
> > + * Test of read-write coherence, that is, whether or not a read from a
> > + * given variable followed by a write to that same variable are ordered.
> 
> The syntax of this sentence is a little tortured.  Suggestion:
> 
> 	... whether or not a read from a given variable and a later
> 	write to that same variable are ordered.
> 
> > + * This should be ordered, that is, this test should be forbidden.
> 
> s/This/They/

Good catches, both changed as suggested.

> > --- a/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
> > +++ b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
> > @@ -1,5 +1,11 @@
> >  C CoWR+poonceonce+Once
> >  
> > +(*
> > + * Test of write-read coherence, that is, whether or not a write to a
> > + * given variable followed by a read from that same variable are ordered.
> 
> Same syntax issue as above.

Analogous fixed applied!

> > --- a/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
> > +++ b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
> > @@ -1,5 +1,13 @@
> >  C ISA2+poonceonces
> >  
> > +(*
> > + * Given a release-acquire chain ordering the first process's store
> > + * against the last process's load, is ordering preserved if all of the
> > + * smp_store_release() invocations be replaced by WRITE_ONCE() and all
> 
> s/be/are/
> 
> > + * of the smp_load_acquire() invocations be replaced by READ_ONCE()?
> 
> s/be/are/

Good eyes, fixed!

> > --- a/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus
> > +++ b/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus
> > @@ -1,5 +1,14 @@
> >  C LB+ctrlonceonce+mbonceonce
> >  
> > +(*
> > + * This litmus test demonstrates that lightweight ordering suffices for
> > + * the load-buffering pattern, in other words, preventing all processes
> > + * reading from the preceding process's write.  In this example, the
> > + * combination of a control dependency and a full memory barrier are to do
> 
> s/are to/are enough to/

Ditto!

> > --- a/tools/memory-model/litmus-tests/MP+polocks.litmus
> > +++ b/tools/memory-model/litmus-tests/MP+polocks.litmus
> > @@ -1,5 +1,14 @@
> >  C MP+polocks
> >  
> > +(*
> > + * This litmus test demonstrates how lock acquisitions and releases can
> > + * stand in for smp_load_acquire() and smp_store_release(), respectively.
> > + * In other words, when holding a given lock (or indeed after relaasing a
> 
> s/relaasing/releasing/
> 
> > + * given lock), a CPU is not only guaranteed to see the accesses that other
> > + * CPOs made while previously holding that lock, it are also guaranteed
> 
> s/CPO/CPU/
> s/are/is/

Andrea beat you to the first two of these three, but fixed.  ;-)

> > + * to see all prior accesses by those other CPUs.
> 
> Doesn't say whether the test should be allowed.  This is true of several
> other litmus tests too.

Added the "Forbidden".

You know, I should use the machine-generated syntax that my scripts
recognize, shouldn't I?  Doing that as well.

> > --- a/tools/memory-model/litmus-tests/MP+porevlocks.litmus
> > +++ b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
> > @@ -1,5 +1,14 @@
> >  C MP+porevlocks
> >  
> > +(*
> > + * This litmus test demonstrates how lock acquisitions and releases can
> > + * stand in for smp_load_acquire() and smp_store_release(), respectively.
> > + * In other words, when holding a given lock (or indeed after relaasing a
> 
> s/relaasing/releasing
> 
> > + * given lock), a CPU is not only guaranteed to see the accesses that other
> > + * CPOs made while previously holding that lock, it are also guaranteed
> 
> s/CPO/CPU/
> s/are/is/

Fixed!

> > --- a/tools/memory-model/litmus-tests/R+poonceonces.litmus
> > +++ b/tools/memory-model/litmus-tests/R+poonceonces.litmus
> > @@ -1,5 +1,11 @@
> >  C R+poonceonces
> >  
> > +(*
> > + * This is the unordered (via smp_mb()) version of one of the classic
> 
> Does "unordered (via smp_mb())" mean that the test uses smp_mb() to
> "unorder" the accesses, or does it mean that the test doesn't use smp_mb()
> to order the accesses?

That is a bit ambiguous...  Though I would be interested in seeing a
litmus test that really did use smp_mb() to unorder the accesses!

How about the following?

	* Result: Sometimes
	*
	* This is the unordered (thus lacking smp_mb()) version of one of the 
	* classic counterintuitive litmus tests that illustrates the effects of
	* store propagation delays.

> > --- a/tools/memory-model/litmus-tests/S+poonceonces.litmus
> > +++ b/tools/memory-model/litmus-tests/S+poonceonces.litmus
> > @@ -1,5 +1,13 @@
> >  C S+poonceonces
> >  
> > +(*
> > + * Starting with a two-process release-acquire chain ordering P0()'s
> > + * first store against P1()'s final load, if the smp_store_release()
> > + * is replaced by WRITE_ONCE() and the smp_load_acquire() replaced by
> > + * READ_ONCE(), is ordering preserved.  The answer is "of course not!",
> 
> s/./?/

Good eyes, fixed!

> > --- a/tools/memory-model/litmus-tests/SB+mbonceonces.litmus
> > +++ b/tools/memory-model/litmus-tests/SB+mbonceonces.litmus
> > @@ -1,5 +1,12 @@
> >  C SB+mbonceonces
> >  
> > +(*
> > + * This litmus test demonstrates that full memory barriers suffice to
> > + * order the store-buffering pattern, where each process writes to the
> > + * variable that the preceding process read.  (Locking and RCU can also
> 
> s/read/reads/

Ditto!

> > --- a/tools/memory-model/litmus-tests/SB+poonceonces.litmus
> > +++ b/tools/memory-model/litmus-tests/SB+poonceonces.litmus
> > @@ -1,5 +1,11 @@
> >  C SB+poonceonces
> >  
> > +(*
> > + * This litmus test demonstrates that at least some ordering is required
> > + * to order the store-buffering pattern, where each process writes to the
> > + * variable that the preceding process read.  This test should be allowed.
> 
> s/read/reads/

And ditto again!  (Hey, at least I was consistent!  If you didn't know
better, you might even think that I was using copy-and-paste.)

> > --- a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
> > +++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
> > @@ -1,5 +1,11 @@
> >  C Z6.0+pooncelock+pooncelock+pombonce
> >  
> > +(*
> > + * This example demonstrates that a pair of accesses made by different
> > + * processes each while holding a given lock will not necessarily be
> > + * seen as ordered by a third process not holding that lock.
> > + *)
> 
> Note that the outcome of this test will be changed by one of the
> patches in our "pending" list.

I decided to anticipate that change and marked it "Result: Never".  ;-)

							Thanx, Paul
