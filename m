Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeDHVNx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 17:13:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43476 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752720AbeDHVNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 17:13:51 -0400
Date: Sun, 8 Apr 2018 14:14:46 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 1/3] locking: Document the semantics of
 spin_is_locked()
Reply-To: paulmck@linux.vnet.ibm.com
References: <1522600912-6208-2-git-send-email-andrea.parri@amarulasolutions.com>
 <1523044060-5568-1-git-send-email-andrea.parri@amarulasolutions.com>
 <b0dbf383-6403-a408-047d-0dd0d2135a03@infradead.org>
 <20180406210741.GF3948@linux.vnet.ibm.com>
 <30d15756-1cb4-7123-b4d9-ce2e66861df3@infradead.org>
 <20180406215825.GA3646@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406215825.GA3646@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18040821-0008-0000-0000-000002F2F917
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008820; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000256; SDB=6.01015068; UDB=6.00517536; IPR=6.00794319;
 MB=3.00020476; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-08 21:13:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040821-0009-0000-0000-000038D3FC90
Message-Id: <20180408211446.GU3948@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804080232
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 11:58:25PM +0200, Andrea Parri wrote:
> On Fri, Apr 06, 2018 at 02:08:16PM -0700, Randy Dunlap wrote:
> > On 04/06/2018 02:07 PM, Paul E. McKenney wrote:
> > > On Fri, Apr 06, 2018 at 02:01:41PM -0700, Randy Dunlap wrote:
> > >> On 04/06/2018 12:47 PM, Andrea Parri wrote:
> > >>> There appeared to be a certain, recurrent uncertainty concerning the
> > >>> semantics of spin_is_locked(), likely a consequence of the fact that
> > >>> this semantics remains undocumented or that it has been historically
> > >>> linked to the (likewise unclear) semantics of spin_unlock_wait().
> > >>>
> > >>> A recent auditing [1] of the callers of the primitive confirmed that
> > >>> none of them are relying on particular ordering guarantees; document
> > >>> this semantics by adding a docbook header to spin_is_locked(). Also,
> > >>> describe behaviors specific to certain CONFIG_SMP=n builds.
> > >>>
> > >>> [1] https://marc.info/?l=linux-kernel&m=151981440005264&w=2
> > >>>     https://marc.info/?l=linux-kernel&m=152042843808540&w=2
> > >>>     https://marc.info/?l=linux-kernel&m=152043346110262&w=2
> > >>>
> > >>> Co-Developed-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> > >>> Co-Developed-by: Alan Stern <stern@rowland.harvard.edu>
> > >>> Co-Developed-by: David Howells <dhowells@redhat.com>
> > >>> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> > >>> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > >>> Signed-off-by: David Howells <dhowells@redhat.com>
> > >>> Cc: Will Deacon <will.deacon@arm.com>
> > >>> Cc: Peter Zijlstra <peterz@infradead.org>
> > >>> Cc: Boqun Feng <boqun.feng@gmail.com>
> > >>> Cc: Nicholas Piggin <npiggin@gmail.com>
> > >>> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> > >>> Cc: Luc Maranget <luc.maranget@inria.fr>
> > >>> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > >>> Cc: Akira Yokosawa <akiyks@gmail.com>
> > >>> Cc: Ingo Molnar <mingo@kernel.org>
> > >>> ---
> > >>>  include/linux/spinlock.h | 18 ++++++++++++++++++
> > >>>  1 file changed, 18 insertions(+)
> > >>>
> > >>> diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> > >>> index 4894d322d2584..1e8a464358384 100644
> > >>> --- a/include/linux/spinlock.h
> > >>> +++ b/include/linux/spinlock.h
> > >>> @@ -380,6 +380,24 @@ static __always_inline int spin_trylock_irq(spinlock_t *lock)
> > >>>  	raw_spin_trylock_irqsave(spinlock_check(lock), flags); \
> > >>>  })
> > >>>  
> > >>> +/**
> > >>> + * spin_is_locked() - Check whether a spinlock is locked.
> > >>> + * @lock: Pointer to the spinlock.
> > >>> + *
> > >>> + * This function is NOT required to provide any memory ordering
> > >>> + * guarantees; it could be used for debugging purposes or, when
> > >>> + * additional synchronization is needed, accompanied with other
> > >>> + * constructs (memory barriers) enforcing the synchronization.
> > >>> + *
> > >>> + * Returns: 1 if @lock is locked, 0 otherwise.
> > >>
> > >> Sorry, minor nit:
> > >> s/Returns:/Return:/
> > >> (according to kernel-doc.rst)
> > >>
> > >> although I agree that "Returns:" is better.
> > >> [I should have changed that years ago.]
> > > 
> > > Agreed, English grammar and templates often seem to conflict.
> > > 
> > > So should we change this comment, or are you instead proposing to add
> > > "Returns:" as valid kernel-doc?
> > 
> > Please change this patch to current doc syntax.
> > Any changes to kernel-doc syntax would come later.

Are you sure?

$ git grep "\* Returns:" | wc -l
2470
$ git grep "\* Return:" | wc -l
4144

Looks like more than a third of them are already "Returns:".  ;-)

> Paul: I understand that you're going to do this change "in place"; please
> let me know if I'm wrong/if you need a new submission.

If Randy is certain that he would like to continue propagating
this grammatical infelicity, sure.  ;-)

							Thanx, Paul

> Thanks,
>   Andrea
> 
> 
> > 
> > Thanks.
> > 
> > > 							Thanx, Paul
> > > 
> > >>> + *
> > >>> + * Note that the function only tells you that the spinlock is
> > >>> + * seen to be locked, not that it is locked on your CPU.
> > >>> + *
> > >>> + * Further, on CONFIG_SMP=n builds with CONFIG_DEBUG_SPINLOCK=n,
> > >>> + * the return value is always 0 (see include/linux/spinlock_up.h).
> > >>> + * Therefore you should not rely heavily on the return value.
> > >>> + */
> > >>>  static __always_inline int spin_is_locked(spinlock_t *lock)
> > >>>  {
> > >>>  	return raw_spin_is_locked(&lock->rlock);
> > >>>
> > >>
> > >>
> > >> -- 
> > >> ~Randy
> > >>
> > > 
> > 
> > 
> > -- 
> > ~Randy
> 
