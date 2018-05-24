Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971577AbeEXVOR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 17:14:17 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:51202 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967358AbeEXVOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 17:14:14 -0400
X-Google-Smtp-Source: AB8JxZomeNky/loeRugOxyutaAzJTNgOw2hrJzcXA8CfKW8kTe112ZUO8UjY+4Fn81C5mwuUt3Rmng==
Date: Thu, 24 May 2018 23:14:05 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        psodagud@codeaurora.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>, sherryy@android.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Christoph Lameter <cl@linux.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sasha Levin <alexander.levin@verizon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        paulmck@linux.vnet.ibm.com, stern@rowland.harvard.edu
Subject: Re: write_lock_irq(&tasklist_lock)
Message-ID: <20180524211405.GA7206@andrea>
References: <0879f797135033e05e8e9166a3c85628@codeaurora.org>
 <20180523130547.GF26965@arm.com>
 <CA+55aFwKLBKdf3gdWkJSdewQYYXYYfN29SPT+etPqpopxA0CMQ@mail.gmail.com>
 <20180523153607.GD2983@arm.com>
 <CA+55aFy9mVCJUniAMVvJjqaa=ke2mx6HfkPhCGP54ncdh70peQ@mail.gmail.com>
 <20180524124928.GH8689@arm.com>
 <20180524135158.GA19987@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524135158.GA19987@tardis>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, lemme put some details here:
> 
> So we have three cases:
> 
> Case #1 (from Will)
> 
> 	P0:			P1:			P2:
> 
> 	spin_lock(&slock)	read_lock(&rwlock)
> 							write_lock(&rwlock)
> 	read_lock(&rwlock)	spin_lock(&slock)
> 
> , which is a deadlock, and couldn't not be detected by lockdep yet. And
> lockdep could detect this with the patch I attach at the end of the
> mail.
> 
> Case #2
> 
> 	P0:			P1:			P2:
> 
> 	<in irq handler>
> 	spin_lock(&slock)	read_lock(&rwlock)
> 							write_lock(&rwlock)
> 	read_lock(&rwlock)	spin_lock_irq(&slock)
> 
> , which is not a deadlock, as the read_lock() on P0 can use the unfair
> fastpass.
> 
> Case #3
> 
> 	P0:			P1:			P2:
> 
> 				<in irq handler>
> 	spin_lock_irq(&slock)	read_lock(&rwlock)
> 							write_lock_irq(&rwlock)
> 	read_lock(&rwlock)	spin_lock(&slock)
> 
> , which is a deadlock, as the read_lock() on P0 cannot use the fastpass.

Mmh, I'm starting to think that, maybe, we need a model (a tool) to
distinguish these and other(?) cases (sorry, I could not resist ;-)

[...]


> ------------------->8
> Subject: [PATCH] locking: More accurate annotations for read_lock()
> 
> On the archs using QUEUED_RWLOCKS, read_lock() is not always a recursive
> read lock, actually it's only recursive if in_interrupt() is true. So

Mmh, taking the "common denominator" over archs/Kconfig options and
CPU states, this would suggest that read_lock() is non-recursive;

it looks like I can say "good-bye" to my idea to define (formalize)
consistent executions/the memory ordering of RW-LOCKS "by following"
the following _emulation_:

void read_lock(rwlock_t *s)
{
	r0 = atomic_fetch_inc_acquire(&s->val);
}

void read_unlock(rwlock_t *s)
{
	r0 = atomic_fetch_sub_release(&s->val);
}

void write_lock(rwlock_t *s)
{
	r0 = atomic_cmpxchg_acquire(&s->val, 0, -1);
}

void write_unlock(rwlock_t *s)
{
	atomic_set_release(&s->val, 0);
}

filter (~read_lock:r0=-1 /\ write_lock:r0=0)

[...]


> The code is done, I'm just working on the rework for documention stuff,
> so if anyone is interested, could try it out ;-)

Any idea on how to "educate" the LKMM about this code/documentation?

  Andrea
