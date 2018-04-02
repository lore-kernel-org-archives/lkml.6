Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757098AbeDBTew (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 15:34:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757069AbeDBTeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 15:34:50 -0400
Date: Mon, 2 Apr 2018 12:35:40 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 1/3] locking: Document the semantics of
 spin_is_locked()
Reply-To: paulmck@linux.vnet.ibm.com
References: <1522600912-6208-2-git-send-email-andrea.parri@amarulasolutions.com>
 <Pine.LNX.4.44L0.1804021001130.1415-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1804021001130.1415-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18040219-2213-0000-0000-00000288E8D0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008790; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01012160; UDB=6.00515827; IPR=6.00791430;
 MB=3.00020378; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-02 19:34:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040219-2214-0000-0000-0000599D2444
Message-Id: <20180402193540.GB3948@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-02_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804020212
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 10:03:22AM -0400, Alan Stern wrote:
> On Sun, 1 Apr 2018, Andrea Parri wrote:
> 
> > There appeared to be a certain, recurrent uncertainty concerning the
> > semantics of spin_is_locked(), likely a consequence of the fact that
> > this semantics remains undocumented or that it has been historically
> > linked to the (likewise unclear) semantics of spin_unlock_wait().
> > 
> > A recent auditing [1] of the callers of the primitive confirmed that
> > none of them are relying on particular ordering guarantees; document
> > this semantics by adding a docbook header to spin_is_locked().
> > 
> > [1] https://marc.info/?l=linux-kernel&m=151981440005264&w=2
> > 
> > Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> > Cc: Luc Maranget <luc.maranget@inria.fr>
> > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > Cc: Akira Yokosawa <akiyks@gmail.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > ---
> >  include/linux/spinlock.h | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> > index 4894d322d2584..2639fdc9a916c 100644
> > --- a/include/linux/spinlock.h
> > +++ b/include/linux/spinlock.h
> > @@ -380,6 +380,17 @@ static __always_inline int spin_trylock_irq(spinlock_t *lock)
> >  	raw_spin_trylock_irqsave(spinlock_check(lock), flags); \
> >  })
> >  
> > +/**
> > + * spin_is_locked() - Check whether a spinlock is locked.
> > + * @lock: Pointer to the spinlock.
> > + *
> > + * This function is NOT required to provide any memory ordering
> > + * guarantees; it could be used for debugging purposes or, when
> > + * additional synchronization is needed, accompanied with other
> > + * constructs (memory barriers) enforcing the synchronization.
> > + *
> > + * Return: 1, if @lock is (found to be) locked; 0, otherwise.
> 
> This is a good addition.  But please remove the parenthetical phrase.  
> Or if you prefer to keep it, at least remove the parentheses.

Unless someone objects or proposes a different course of action, I will
make this change in -rcu.

							Thanx, Paul

> Alan
> 
> > + */
> >  static __always_inline int spin_is_locked(spinlock_t *lock)
> >  {
> >  	return raw_spin_is_locked(&lock->rlock);
> > 
> 
