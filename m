Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeEGGn3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 02:43:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39687 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeEGGnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 02:43:25 -0400
X-Google-Smtp-Source: AB8JxZo1o02t0gvOqAQ8+SSDvlZwCqZ/Wog3TSwy3TkOpPfad+nFAp83JhM47WlrAO6tSz5CuHjnEQ==
Date: Mon, 7 May 2018 08:43:20 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH] locking/atomics/x86/64: Clean up and fix details of
 <asm/atomic64_64.h>
Message-ID: <20180507064320.emmhsiwx5gj5vatl@gmail.com>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505084721.GA32344@noisy.programming.kicks-ass.net>
 <CACT4Y+Z1WKxdkodRBc5PzfyQQmfJCJ3n1JyQc-+WCkqGZeg5Wg@mail.gmail.com>
 <20180505093237.GD12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505093237.GD12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Sat, May 05, 2018 at 11:05:51AM +0200, Dmitry Vyukov wrote:
> > On Sat, May 5, 2018 at 10:47 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > > And I seriously hate this one:
> > >
> > >   ba1c9f83f633 ("locking/atomic/x86: Un-macro-ify atomic ops implementation")
> > >
> > > and will likely undo that the moment I need to change anything there.
> 
> > That was asked by Ingo:
> > https://groups.google.com/d/msg/kasan-dev/3sNHjjb4GCI/Xz1uVWaaAAAJ
> > 
> > I think in the end all of current options suck in one way or another,
> > so we are just going in circles.
> 
> Yeah, and I disagree with him, but didn't have the energy to fight at
> that time (and still don't really, I'm just complaining).

Ok, this negative side effect of the un-macro-ifying still bothers me, so I tried 
to do something about it:

  1 file changed, 81 insertions(+), 172 deletions(-)

That's actually better than what we had before ba1c9f83f633, which did:

  3 files changed, 147 insertions(+), 70 deletions(-)

( Also consider that my patch adds new DocBook comments and only touches the 
  64-bit side, so if we do the same to the 32-bit header as well we'll gain even 
  more. )

But I don't think you'll like my solution: it requires twice as wide terminals to 
look at those particular functions...

The trick is to merge the C functions into a single line: this makes it look a bit 
weird, but it's still very readable (because the functions are simple), and, most 
importantly, the _differences_ are now easily visible.

This is how that part looks like on my terminal:

 ... do { } while (!arch_atomic64_try_cmpxchg(v, &val, val & i)); return val; }
 ... do { } while (!arch_atomic64_try_cmpxchg(v, &val, val | i)); return val; }
 ... do { } while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i)); return val; }
 ...
 ... { asm(LOCK_PREFIX "orq  %1,%0" : "+m" (v->counter) : "er" (i) : "memory"); }
 ... { asm(LOCK_PREFIX "xorq %1,%0" : "+m" (v->counter) : "er" (i) : "memory"); }
 ... { asm(LOCK_PREFIX "andq %1,%0" : "+m" (v->counter) : "er" (i) : "memory"); }

Which makes the '&|^' and orq/xorq/andq differences easily visible. I kept all 
those long lines at the end of the header, to make it easy not to look at it, 
unless someone wants to actively change or understand the code.

The prototype/parameters are visible even with col80 terminals.

But please give it a try and at least _look_ at the result in a double-wide 
terminal.

There's also a ton of other small fixes and enhancements I did to the header file 
- see the changelog.

But I won't commit this without your explicit Acked-by.

Thanks,

	Ingo

================>
From: Ingo Molnar <mingo@kernel.org>
Date: Mon, 7 May 2018 07:59:12 +0200
Subject: [PATCH] locking/atomics/x86/64: Clean up and fix details of <asm/atomic64_64.h>

PeterZ complained that the following macro elimination:

  ba1c9f83f633: locking/atomic/x86: Un-macro-ify atomic ops implementation

bloated the header and made it less readable/maintainable.

Try to undo some of that damage, without reintroducing a macro mess:

 - Merge the previously macro generated C inline functions into a single line.
   While this looks weird on smaller terminals because of line wraps
   (and violates the col80 style rule brutally), it's surprisingly readable
   on larger terminals. An advantage with this format is that the repeated
   patterns are obviously visible, while the actual differences stick out
   very clearly. To me this is much more readable than the old macro solution.

While at it, also do a no-prisoners taken cleanup pass of all the code and comments
in this file:

 - Fix the DocBook comment of arch_atomic64_add_unless(), which incorrectly claimed:

     "Returns the old value of @v."

   In reality the function returns true if the operation was performed, or false otherwise.

 - Fix __always_inline use: where one member of a 'pair' of an operation has it,
   add it to both. There's no reason for them to ever deviate.

 - Fix/clarify the arch_atomic64_read() documentation: it not only reads but also
   returns the value.

 - Fix DocBook comments that referred to 'i' and 'v' instead of '@i' and '@v'.

 - Remove unnecessary parentheses from arch_atomic64_read() that was probably
   inherited from ancient macro versions.

 - Add DocBook description for arch_atomic64_[add|sub]_return() and
   arch_atomic64_fetch_[add|sub]().

 - Harmonize to a single variant of referring to atomic64_t pointers in
   comments, instead of these two variants:

      "@v: pointer of type atomic64_t"
      "@v: pointer to type atomic64_t"

   Use a single, shorter variant:

      "@v: pointer to atomic64_t"

   (Because the _t already implies that this is a type - no need to repeat that.)

 - Harmonize local variable naming, from a sometimes inconsistent selection of ad-hoc
   and sometimes cryptic variable names ('c', 'val', 'dec', 'val_old', etc.), to the
   following set of standardized local variable names:

     'i' for integer arguments
     'val_old' for old atomic values
     'val_new' for old atomic values

   From now on the name of the local variable is "obviously descriptive" of its
   role in the code.

 - Add newlines after local variable definitions and before return statements, consistently.

 - Change weird "@i: required value" phrase (all arguments to function calls are
   required, what does 'required' mean here?) to '@i: new value'

 - Add "Doesn't imply a write memory barrier" to arch_atomic64_set(), to
   mirror the read barrier comment of arch_atomic64_read().

 - Change the weird "or false for all other cases" phrase to the simpler "or false otherwise"
   formulation that is standard in DocBook comments.

 - Harmonize the punctuation of DocBook comments: detailed descriptions always end with a period.

 - Change the order of addition in the arch_atomic64_[add|sub]_return() code,
   to make it match the order in the description. (No change in functionality,
   addition is commutative.)

 - Remove unnecessary double newlines.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/atomic64_64.h | 253 ++++++++++++-------------------------
 1 file changed, 81 insertions(+), 172 deletions(-)

diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 6106b59d3260..1c451871b391 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -12,22 +12,23 @@
 
 /**
  * arch_atomic64_read - read atomic64 variable
- * @v: pointer of type atomic64_t
+ * @v: pointer to atomic64_t
  *
- * Atomically reads the value of @v.
+ * Atomically reads and returns the value of @v.
  * Doesn't imply a read memory barrier.
  */
 static inline long arch_atomic64_read(const atomic64_t *v)
 {
-	return READ_ONCE((v)->counter);
+	return READ_ONCE(v->counter);
 }
 
 /**
  * arch_atomic64_set - set atomic64 variable
- * @v: pointer to type atomic64_t
- * @i: required value
+ * @v: pointer to atomic64_t
+ * @i: new value
  *
  * Atomically sets the value of @v to @i.
+ * Doesn't imply a write memory barrier.
  */
 static inline void arch_atomic64_set(atomic64_t *v, long i)
 {
@@ -35,41 +36,22 @@ static inline void arch_atomic64_set(atomic64_t *v, long i)
 }
 
 /**
- * arch_atomic64_add - add integer to atomic64 variable
- * @i: integer value to add
- * @v: pointer to type atomic64_t
+ * arch_atomic64_[add|sub] - add|subtract integer to/from atomic64 variable
+ * @i: integer value to add/subtract
+ * @v: pointer to atomic64_t
  *
- * Atomically adds @i to @v.
+ * Atomically adds/subtracts @i to/from @v.
  */
-static __always_inline void arch_atomic64_add(long i, atomic64_t *v)
-{
-	asm volatile(LOCK_PREFIX "addq %1,%0"
-		     : "=m" (v->counter)
-		     : "er" (i), "m" (v->counter));
-}
-
-/**
- * arch_atomic64_sub - subtract the atomic64 variable
- * @i: integer value to subtract
- * @v: pointer to type atomic64_t
- *
- * Atomically subtracts @i from @v.
- */
-static inline void arch_atomic64_sub(long i, atomic64_t *v)
-{
-	asm volatile(LOCK_PREFIX "subq %1,%0"
-		     : "=m" (v->counter)
-		     : "er" (i), "m" (v->counter));
-}
+static __always_inline void arch_atomic64_sub(long i, atomic64_t *v) { asm(LOCK_PREFIX "subq %1,%0" : "=m" (v->counter) : "er" (i), "m" (v->counter)); }
+static __always_inline void arch_atomic64_add(long i, atomic64_t *v) { asm(LOCK_PREFIX "addq %1,%0" : "=m" (v->counter) : "er" (i), "m" (v->counter)); }
 
 /**
  * arch_atomic64_sub_and_test - subtract value from variable and test result
  * @i: integer value to subtract
- * @v: pointer to type atomic64_t
+ * @v: pointer to atomic64_t
  *
  * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
+ * true if the result is zero, or false otherwise.
  */
 static inline bool arch_atomic64_sub_and_test(long i, atomic64_t *v)
 {
@@ -77,133 +59,101 @@ static inline bool arch_atomic64_sub_and_test(long i, atomic64_t *v)
 }
 
 /**
- * arch_atomic64_inc - increment atomic64 variable
- * @v: pointer to type atomic64_t
+ * arch_atomic64_[inc|dec] - increment/decrement atomic64 variable
+ * @v: pointer to atomic64_t
  *
- * Atomically increments @v by 1.
+ * Atomically increments/decrements @v by 1.
  */
-static __always_inline void arch_atomic64_inc(atomic64_t *v)
-{
-	asm volatile(LOCK_PREFIX "incq %0"
-		     : "=m" (v->counter)
-		     : "m" (v->counter));
-}
+static __always_inline void arch_atomic64_inc(atomic64_t *v) { asm(LOCK_PREFIX "incq %0" : "=m" (v->counter) : "m" (v->counter)); }
+static __always_inline void arch_atomic64_dec(atomic64_t *v) { asm(LOCK_PREFIX "decq %0" : "=m" (v->counter) : "m" (v->counter)); }
 
 /**
- * arch_atomic64_dec - decrement atomic64 variable
- * @v: pointer to type atomic64_t
+ * arch_atomic64_[inc|dec]_and_test - increment/decrement and test
+ * @v: pointer to atomic64_t
  *
- * Atomically decrements @v by 1.
+ * Atomically increments/decrements @v by 1 and
+ * returns true if the result is 0, or false otherwise.
  */
-static __always_inline void arch_atomic64_dec(atomic64_t *v)
-{
-	asm volatile(LOCK_PREFIX "decq %0"
-		     : "=m" (v->counter)
-		     : "m" (v->counter));
-}
+static inline bool arch_atomic64_dec_and_test(atomic64_t *v) { GEN_UNARY_RMWcc(LOCK_PREFIX "decq", v->counter, "%0", e); }
+static inline bool arch_atomic64_inc_and_test(atomic64_t *v) { GEN_UNARY_RMWcc(LOCK_PREFIX "incq", v->counter, "%0", e); }
 
 /**
- * arch_atomic64_dec_and_test - decrement and test
- * @v: pointer to type atomic64_t
+ * arch_atomic64_add_negative - add and test if negative
+ * @i: integer value to add
+ * @v: pointer to atomic64_t
  *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
+ * Atomically adds @i to @v and returns true
+ * if the result is negative, or false otherwise.
  */
-static inline bool arch_atomic64_dec_and_test(atomic64_t *v)
+static inline bool arch_atomic64_add_negative(long i, atomic64_t *v)
 {
-	GEN_UNARY_RMWcc(LOCK_PREFIX "decq", v->counter, "%0", e);
+	GEN_BINARY_RMWcc(LOCK_PREFIX "addq", v->counter, "er", i, "%0", s);
 }
 
 /**
- * arch_atomic64_inc_and_test - increment and test
- * @v: pointer to type atomic64_t
+ * arch_atomic64_[add|sub]_return - add/subtract and return
+ * @i: integer value to add/subtract
+ * @v: pointer to atomic64_t
  *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
+ * Atomically adds/subtracts @i to/from @v and returns the new value of @v.
  */
-static inline bool arch_atomic64_inc_and_test(atomic64_t *v)
-{
-	GEN_UNARY_RMWcc(LOCK_PREFIX "incq", v->counter, "%0", e);
-}
+static __always_inline long arch_atomic64_add_return(long i, atomic64_t *v) { return xadd(&v->counter, +i) + i; }
+static __always_inline long arch_atomic64_sub_return(long i, atomic64_t *v) { return xadd(&v->counter, -i) - i; }
 
 /**
- * arch_atomic64_add_negative - add and test if negative
- * @i: integer value to add
- * @v: pointer to type atomic64_t
+ * arch_atomic64_fetch_[add|sub]_return - add/subtract and return old value
+ * @i: integer value to add/subtract
+ * @v: pointer to atomic64_t
  *
- * Atomically adds @i to @v and returns true
- * if the result is negative, or false when
- * result is greater than or equal to zero.
+ * Atomically adds/subtracts @i to/from @v and returns the old value of @v.
  */
-static inline bool arch_atomic64_add_negative(long i, atomic64_t *v)
-{
-	GEN_BINARY_RMWcc(LOCK_PREFIX "addq", v->counter, "er", i, "%0", s);
-}
+static __always_inline long arch_atomic64_fetch_add (long i, atomic64_t *v) { return xadd(&v->counter, +i); }
+static __always_inline long arch_atomic64_fetch_sub (long i, atomic64_t *v) { return xadd(&v->counter, -i); }
 
 /**
- * arch_atomic64_add_return - add and return
- * @i: integer value to add
- * @v: pointer to type atomic64_t
+ * arch_atomic64_[inc|dec]_return - increment/decrement and return
+ * @v: pointer to atomic64_t
  *
- * Atomically adds @i to @v and returns @i + @v
+ * Atomically increments/decrements @v and returns the new value of @v.
  */
-static __always_inline long arch_atomic64_add_return(long i, atomic64_t *v)
-{
-	return i + xadd(&v->counter, i);
-}
-
-static inline long arch_atomic64_sub_return(long i, atomic64_t *v)
-{
-	return arch_atomic64_add_return(-i, v);
-}
+#define arch_atomic64_inc_return(v)  arch_atomic64_add_return(1, (v))
+#define arch_atomic64_dec_return(v)  arch_atomic64_sub_return(1, (v))
 
-static inline long arch_atomic64_fetch_add(long i, atomic64_t *v)
+static inline long arch_atomic64_cmpxchg(atomic64_t *v, long val_old, long val_new)
 {
-	return xadd(&v->counter, i);
-}
-
-static inline long arch_atomic64_fetch_sub(long i, atomic64_t *v)
-{
-	return xadd(&v->counter, -i);
-}
-
-#define arch_atomic64_inc_return(v)  (arch_atomic64_add_return(1, (v)))
-#define arch_atomic64_dec_return(v)  (arch_atomic64_sub_return(1, (v)))
-
-static inline long arch_atomic64_cmpxchg(atomic64_t *v, long old, long new)
-{
-	return arch_cmpxchg(&v->counter, old, new);
+	return arch_cmpxchg(&v->counter, val_old, val_new);
 }
 
 #define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
-static __always_inline bool arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, long new)
+
+static __always_inline bool arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *val_old, long val_new)
 {
-	return try_cmpxchg(&v->counter, old, new);
+	return try_cmpxchg(&v->counter, val_old, val_new);
 }
 
-static inline long arch_atomic64_xchg(atomic64_t *v, long new)
+static inline long arch_atomic64_xchg(atomic64_t *v, long val_new)
 {
-	return xchg(&v->counter, new);
+	return xchg(&v->counter, val_new);
 }
 
 /**
  * arch_atomic64_add_unless - add unless the number is a given value
- * @v: pointer of type atomic64_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
+ * @v: pointer to atomic64_t
+ * @i: the amount to add to @v...
+ * @u: ...unless @v is equal to @u
  *
- * Atomically adds @a to @v, so long as it was not @u.
- * Returns the old value of @v.
+ * Atomically adds @i to @v, so long as @v was not @u.
+ * Returns true if the operation was performed, or false otherwise.
  */
-static inline bool arch_atomic64_add_unless(atomic64_t *v, long a, long u)
+static inline bool arch_atomic64_add_unless(atomic64_t *v, long i, long u)
 {
-	s64 c = arch_atomic64_read(v);
+	s64 val_old = arch_atomic64_read(v);
+
 	do {
-		if (unlikely(c == u))
+		if (unlikely(val_old == u))
 			return false;
-	} while (!arch_atomic64_try_cmpxchg(v, &c, c + a));
+	} while (!arch_atomic64_try_cmpxchg(v, &val_old, val_old + i));
+
 	return true;
 }
 
@@ -211,71 +161,30 @@ static inline bool arch_atomic64_add_unless(atomic64_t *v, long a, long u)
 
 /*
  * arch_atomic64_dec_if_positive - decrement by 1 if old value positive
- * @v: pointer of type atomic_t
+ * @v: pointer to type atomic_t
  *
  * The function returns the old value of *v minus 1, even if
- * the atomic variable, v, was not decremented.
+ * @v was not decremented.
  */
 static inline long arch_atomic64_dec_if_positive(atomic64_t *v)
 {
-	s64 dec, c = arch_atomic64_read(v);
-	do {
-		dec = c - 1;
-		if (unlikely(dec < 0))
-			break;
-	} while (!arch_atomic64_try_cmpxchg(v, &c, dec));
-	return dec;
-}
-
-static inline void arch_atomic64_and(long i, atomic64_t *v)
-{
-	asm volatile(LOCK_PREFIX "andq %1,%0"
-			: "+m" (v->counter)
-			: "er" (i)
-			: "memory");
-}
-
-static inline long arch_atomic64_fetch_and(long i, atomic64_t *v)
-{
-	s64 val = arch_atomic64_read(v);
-
-	do {
-	} while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
-	return val;
-}
-
-static inline void arch_atomic64_or(long i, atomic64_t *v)
-{
-	asm volatile(LOCK_PREFIX "orq %1,%0"
-			: "+m" (v->counter)
-			: "er" (i)
-			: "memory");
-}
-
-static inline long arch_atomic64_fetch_or(long i, atomic64_t *v)
-{
-	s64 val = arch_atomic64_read(v);
+	s64 val_new, val = arch_atomic64_read(v);
 
 	do {
-	} while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
-	return val;
-}
+		val_new = val - 1;
+		if (unlikely(val_new < 0))
+			break;
+	} while (!arch_atomic64_try_cmpxchg(v, &val, val_new));
 
-static inline void arch_atomic64_xor(long i, atomic64_t *v)
-{
-	asm volatile(LOCK_PREFIX "xorq %1,%0"
-			: "+m" (v->counter)
-			: "er" (i)
-			: "memory");
+	return val_new;
 }
 
-static inline long arch_atomic64_fetch_xor(long i, atomic64_t *v)
-{
-	s64 val = arch_atomic64_read(v);
+static inline long arch_atomic64_fetch_and(long i, atomic64_t *v) { s64 val = arch_atomic64_read(v); do { } while (!arch_atomic64_try_cmpxchg(v, &val, val & i)); return val; }
+static inline long arch_atomic64_fetch_or (long i, atomic64_t *v) { s64 val = arch_atomic64_read(v); do { } while (!arch_atomic64_try_cmpxchg(v, &val, val | i)); return val; }
+static inline long arch_atomic64_fetch_xor(long i, atomic64_t *v) { s64 val = arch_atomic64_read(v); do { } while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i)); return val; }
 
-	do {
-	} while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
-	return val;
-}
+static inline void arch_atomic64_or (long i, atomic64_t *v) { asm(LOCK_PREFIX "orq  %1,%0" : "+m" (v->counter) : "er" (i) : "memory"); }
+static inline void arch_atomic64_xor(long i, atomic64_t *v) { asm(LOCK_PREFIX "xorq %1,%0" : "+m" (v->counter) : "er" (i) : "memory"); }
+static inline void arch_atomic64_and(long i, atomic64_t *v) { asm(LOCK_PREFIX "andq %1,%0" : "+m" (v->counter) : "er" (i) : "memory"); }
 
 #endif /* _ASM_X86_ATOMIC64_64_H */
