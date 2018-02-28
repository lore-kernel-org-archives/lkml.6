Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752742AbeB1OkB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:40:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752528AbeB1OkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:40:00 -0500
Date: Wed, 28 Feb 2018 06:39:55 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] Documentation/locking: Document the semantics of
 spin_is_locked()
Reply-To: paulmck@linux.vnet.ibm.com
References: <1519814372-19941-1-git-send-email-parri.andrea@gmail.com>
 <20180228105631.GA7681@arm.com>
 <20180228112403.GA32228@andrea>
 <20180228113456.GC7681@arm.com>
 <20180228121523.GA354@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228121523.GA354@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022814-2213-0000-0000-0000027806A0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008602; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00996345; UDB=6.00506518; IPR=6.00775668;
 MB=3.00019777; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-28 14:39:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022814-2214-0000-0000-000059441CC8
Message-Id: <20180228143955.GL3777@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280179
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 01:15:23PM +0100, Andrea Parri wrote:
> On Wed, Feb 28, 2018 at 11:34:56AM +0000, Will Deacon wrote:
> > On Wed, Feb 28, 2018 at 12:24:03PM +0100, Andrea Parri wrote:
> > > On Wed, Feb 28, 2018 at 10:56:32AM +0000, Will Deacon wrote:
> > > > On Wed, Feb 28, 2018 at 11:39:32AM +0100, Andrea Parri wrote:
> > > > > There appeared to be a certain, recurrent uncertainty concerning the
> > > > > semantics of spin_is_locked(), likely a consequence of the fact that
> > > > > this semantics remains undocumented or that it has been historically
> > > > > linked to the (likewise unclear) semantics of spin_unlock_wait().
> > > > > 
> > > > > Document this semantics.
> > > > > 
> > > > > Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> > > > > Cc: Alan Stern <stern@rowland.harvard.edu>
> > > > > Cc: Will Deacon <will.deacon@arm.com>
> > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > > > Cc: Nicholas Piggin <npiggin@gmail.com>
> > > > > Cc: David Howells <dhowells@redhat.com>
> > > > > Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> > > > > Cc: Luc Maranget <luc.maranget@inria.fr>
> > > > > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > > > > Cc: Akira Yokosawa <akiyks@gmail.com>
> > > > > ---
> > > > >  include/linux/spinlock.h | 11 +++++++++++
> > > > >  1 file changed, 11 insertions(+)
> > > > > 
> > > > > diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> > > > > index 4894d322d2584..2639fdc9a916c 100644
> > > > > --- a/include/linux/spinlock.h
> > > > > +++ b/include/linux/spinlock.h
> > > > > @@ -380,6 +380,17 @@ static __always_inline int spin_trylock_irq(spinlock_t *lock)
> > > > >  	raw_spin_trylock_irqsave(spinlock_check(lock), flags); \
> > > > >  })
> > > > >  
> > > > > +/**
> > > > > + * spin_is_locked() - Check whether a spinlock is locked.
> > > > > + * @lock: Pointer to the spinlock.
> > > > > + *
> > > > > + * This function is NOT required to provide any memory ordering
> > > > > + * guarantees; it could be used for debugging purposes or, when
> > > > > + * additional synchronization is needed, accompanied with other
> > > > > + * constructs (memory barriers) enforcing the synchronization.
> > > > > + *
> > > > > + * Return: 1, if @lock is (found to be) locked; 0, otherwise.
> > > > > + */
> > > > 
> > > > I also don't think this is quite right, since the spin_is_locked check
> > > > must be ordered after all prior lock acquisitions (to any lock) on the same
> > > > CPU. That's why we have an smp_mb() in there on arm64 (see 38b850a73034f).
> > > 
> > > So, arm64 (and powerpc) complies to the semantics I _have_ in mind ...
> > 
> > Sure, but they're offering more than that at present. If I can remove the
> > smp_mb() in our spin_is_locked implementation, I will, but we need to know
> > what that will break even if you consider that code to be broken because it
> > relies on something undocumented.
> > 
> > > > So this is a change in semantics and we need to audit the users before
> > > > proceeding. We should also keep spin_is_locked consistent with the versions
> > > > for mutex, rwsem, bit_spin.
> > > 
> > > Well, strictly speaking, it isn't (given that the current semantics is,
> > > as reported above, currently undocumented); for the same reason, cases
> > > relying on anything more than _nothing_ (if any) are already broken ...
> > 
> > I suppose it depends on whether you consider the code or the documentation
> > to be authoritative. I tend to err on the side of the former for the kernel.
> > To be clear: I'm perfectly ok relaxing the semantics, but only if there's
> > some evidence that you've looked at the callsites and determined that they
> > won't break.  That's why I think a better first step would be to convert a
> > bunch of them to using lockdep for the "assert that I hold this lock"
> > checks, so we can start to see where the interesting cases are.
> 
> Sure, I'll do (queued after the RISC-V patches I'm currently working on).
> 
> So I think that we could all agree that the semantics I'm proposing here
> would be very simple to reason with ;-).  You know, OTOH, this auditing
> could turn out to be all but "simple"...
> 
>   https://marc.info/?l=linux-kernel&m=149910202928559&w=2
>   https://marc.info/?l=linux-kernel&m=149886113629263&w=2
>   https://marc.info/?l=linux-kernel&m=149912971028729&w=2

Indeed, if it was easy, we probably would have already done it.  ;-)

> but I'll have a try, IAC.  Perhaps, a temporary solution/workaround can
> be to simplify/clarify the semantics and to insert the smp_mb() (or the
> smp_mb__before_islocked(), ...) in the "dubious" use cases.

One approach that can be quite helpful is to instrument the code, perhaps
using tracing or perhaps as Will suggests using lockdep, to make it tell
you what it is up to.  Another approach is to find peope who actually
use kdgb and see if any of them mess with CPU hotplug.

							Thanx, Paul
