Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeC0AH6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 20:07:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:34537 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751160AbeC0AH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 20:07:57 -0400
Message-ID: <1522109216.7364.30.camel@kernel.crashing.org>
Subject: Re: [PATCH for-4.17 2/2] powerpc: Remove smp_mb() from
 arch_spin_is_locked()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Mar 2018 11:06:56 +1100
In-Reply-To: <1522060667-7034-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1522060667-7034-1-git-send-email-andrea.parri@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-26 at 12:37 +0200, Andrea Parri wrote:
> Commit 51d7d5205d338 ("powerpc: Add smp_mb() to arch_spin_is_locked()")
> added an smp_mb() to arch_spin_is_locked(), in order to ensure that
> 
> 	Thread 0			Thread 1
> 
> 	spin_lock(A);			spin_lock(B);
> 	r0 = spin_is_locked(B)		r1 = spin_is_locked(A);
> 
> never ends up with r0 = r1 = 0, and reported one example (in ipc/sem.c)
> relying on such guarantee.
> 
> It's however understood (and undocumented) that spin_is_locked() is not
> required to ensure such ordering guarantee,

Shouldn't we start by documenting it ?

>  guarantee that is currently
> _not_ provided by all implementations/arch, and that callers relying on
> such ordering should instead use suitable memory barriers before acting
> on the result of spin_is_locked().
> 
> Following a recent auditing[1] of the callers of {,raw_}spin_is_locked()
> revealing that none of them are relying on this guarantee anymore, this
> commit removes the leading smp_mb() from the primitive thus effectively
> reverting 51d7d5205d338.

I would rather wait until it is properly documented. Debugging that IPC
problem took a *LOT* of time and energy, I wouldn't want these issues
to come and bite us again.

> [1] https://marc.info/?l=linux-kernel&m=151981440005264&w=2
> 
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  arch/powerpc/include/asm/spinlock.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
> index b9ebc3085fb79..ecc141e3f1a73 100644
> --- a/arch/powerpc/include/asm/spinlock.h
> +++ b/arch/powerpc/include/asm/spinlock.h
> @@ -67,7 +67,6 @@ static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
>  
>  static inline int arch_spin_is_locked(arch_spinlock_t *lock)
>  {
> -	smp_mb();
>  	return !arch_spin_value_unlocked(*lock);
>  }
>  
