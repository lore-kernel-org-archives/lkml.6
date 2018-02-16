Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933410AbeBPKVG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 05:21:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933129AbeBPKVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 05:21:04 -0500
Date: Fri, 16 Feb 2018 11:21:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@kernel.org
Subject: Re: [RFC PATCH 3/5] asm-generic/bitops/atomic.h: Rewrite using
 atomic_fetch_*
Message-ID: <20180216102100.GB25201@hirez.programming.kicks-ass.net>
References: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
 <1518708575-12284-4-git-send-email-will.deacon@arm.com>
 <20180215170847.GD25181@hirez.programming.kicks-ass.net>
 <20180215182049.GC15274@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215182049.GC15274@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 06:20:49PM +0000, Will Deacon wrote:
> On Thu, Feb 15, 2018 at 06:08:47PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 15, 2018 at 03:29:33PM +0000, Will Deacon wrote:
> > > +static inline void __clear_bit_unlock(unsigned int nr,
> > > +				      volatile unsigned long *p)
> > > +{
> > > +	unsigned long old;
> > >  
> > > +	p += BIT_WORD(nr);
> > > +	old = READ_ONCE(*p);
> > > +	old &= ~BIT_MASK(nr);
> > > +	smp_store_release(p, old);
> > 
> > This should be atomic_set_release() I think, for the special case where
> > atomics are implemented with spinlocks, see the 'fun' case in
> > Documentation/atomic_t.txt.
> 
> My understanding of __clear_bit_unlock is that there is guaranteed to be
> no concurrent accesses to the same word, so why would it matter whether
> locks are used to implement atomics?


commit f75d48644c56a31731d17fa693c8175328957e1d
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Wed Mar 9 12:40:54 2016 +0100

    bitops: Do not default to __clear_bit() for __clear_bit_unlock()
    
    __clear_bit_unlock() is a special little snowflake. While it carries the
    non-atomic '__' prefix, it is specifically documented to pair with
    test_and_set_bit() and therefore should be 'somewhat' atomic.
    
    Therefore the generic implementation of __clear_bit_unlock() cannot use
    the fully non-atomic __clear_bit() as a default.
    
    If an arch is able to do better; is must provide an implementation of
    __clear_bit_unlock() itself.
    
    Specifically, this came up as a result of hackbench livelock'ing in
    slab_lock() on ARC with SMP + SLUB + !LLSC.
    
    The issue was incorrect pairing of atomic ops.
    
     slab_lock() -> bit_spin_lock() -> test_and_set_bit()
     slab_unlock() -> __bit_spin_unlock() -> __clear_bit()
    
    The non serializing __clear_bit() was getting "lost"
    
     80543b8e:      ld_s       r2,[r13,0] <--- (A) Finds PG_locked is set
     80543b90:      or         r3,r2,1    <--- (B) other core unlocks right here
     80543b94:      st_s       r3,[r13,0] <--- (C) sets PG_locked (overwrites unlock)
    
    Fixes ARC STAR 9000817404 (and probably more).
    
    Reported-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
    Tested-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Christoph Lameter <cl@linux.com>
    Cc: David Rientjes <rientjes@google.com>
    Cc: Helge Deller <deller@gmx.de>
    Cc: James E.J. Bottomley <jejb@parisc-linux.org>
    Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Noam Camus <noamc@ezchip.com>
    Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Pekka Enberg <penberg@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: stable@vger.kernel.org
    Link: http://lkml.kernel.org/r/20160309114054.GJ6356@twins.programming.kicks-ass.net
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h
index c30266e94806..8ef0ccbf8167 100644
--- a/include/asm-generic/bitops/lock.h
+++ b/include/asm-generic/bitops/lock.h
@@ -29,16 +29,16 @@ do {					\
  * @nr: the bit to set
  * @addr: the address to start counting from
  *
- * This operation is like clear_bit_unlock, however it is not atomic.
- * It does provide release barrier semantics so it can be used to unlock
- * a bit lock, however it would only be used if no other CPU can modify
- * any bits in the memory until the lock is released (a good example is
- * if the bit lock itself protects access to the other bits in the word).
+ * A weaker form of clear_bit_unlock() as used by __bit_lock_unlock(). If all
+ * the bits in the word are protected by this lock some archs can use weaker
+ * ops to safely unlock.
+ *
+ * See for example x86's implementation.
  */
 #define __clear_bit_unlock(nr, addr)	\
 do {					\
-	smp_mb();			\
-	__clear_bit(nr, addr);		\
+	smp_mb__before_atomic();	\
+	clear_bit(nr, addr);		\
 } while (0)
 
 #endif /* _ASM_GENERIC_BITOPS_LOCK_H_ */
