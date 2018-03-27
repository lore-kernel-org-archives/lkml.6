Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752477AbeC0KZc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 06:25:32 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38392 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752394AbeC0KZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 06:25:31 -0400
X-Google-Smtp-Source: AG47ELuY6a5EYiEdpEt7s5D6AaKqCKwLZpb9SzdJWOzoyFVcZW67QDv18As9AinHFlozOTqw9BWYbg==
Date: Tue, 27 Mar 2018 12:25:21 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH for-4.17 2/2] powerpc: Remove smp_mb() from
 arch_spin_is_locked()
Message-ID: <20180327102521.GA7347@andrea>
References: <1522060667-7034-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1522109216.7364.30.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522109216.7364.30.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 11:06:56AM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2018-03-26 at 12:37 +0200, Andrea Parri wrote:
> > Commit 51d7d5205d338 ("powerpc: Add smp_mb() to arch_spin_is_locked()")
> > added an smp_mb() to arch_spin_is_locked(), in order to ensure that
> > 
> > 	Thread 0			Thread 1
> > 
> > 	spin_lock(A);			spin_lock(B);
> > 	r0 = spin_is_locked(B)		r1 = spin_is_locked(A);
> > 
> > never ends up with r0 = r1 = 0, and reported one example (in ipc/sem.c)
> > relying on such guarantee.
> > 
> > It's however understood (and undocumented) that spin_is_locked() is not
> > required to ensure such ordering guarantee,
> 
> Shouldn't we start by documenting it ?

I do sympathize with your concern about the documentation! ;) The patch in
[1] was my (re)action to this concern; the sort of the patch is unclear to
me by this time (and I'm not aware of other proposals in this respect).


> 
> >  guarantee that is currently
> > _not_ provided by all implementations/arch, and that callers relying on
> > such ordering should instead use suitable memory barriers before acting
> > on the result of spin_is_locked().
> > 
> > Following a recent auditing[1] of the callers of {,raw_}spin_is_locked()
> > revealing that none of them are relying on this guarantee anymore, this
> > commit removes the leading smp_mb() from the primitive thus effectively
> > reverting 51d7d5205d338.
> 
> I would rather wait until it is properly documented. Debugging that IPC
> problem took a *LOT* of time and energy, I wouldn't want these issues
> to come and bite us again.

I understand. And I'm grateful for this debugging as well as for the (IMO)
excellent account of it you provided in 51d7d5205d338.

Said this ;) I cannot except myself from saying that I would probably have
resisted that solution (adding an smp_mb() in my arch_spin_is_locked), and
instead "blamed"/suggested that caller to fix his memory ordering...

  Andrea


> 
> > [1] https://marc.info/?l=linux-kernel&m=151981440005264&w=2
> > 
> > Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > ---
> >  arch/powerpc/include/asm/spinlock.h | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
> > index b9ebc3085fb79..ecc141e3f1a73 100644
> > --- a/arch/powerpc/include/asm/spinlock.h
> > +++ b/arch/powerpc/include/asm/spinlock.h
> > @@ -67,7 +67,6 @@ static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> >  
> >  static inline int arch_spin_is_locked(arch_spinlock_t *lock)
> >  {
> > -	smp_mb();
> >  	return !arch_spin_value_unlocked(*lock);
> >  }
> >  
