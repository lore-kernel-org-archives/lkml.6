Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbeCHVDN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 16:03:13 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33960 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbeCHVDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 16:03:11 -0500
X-Google-Smtp-Source: AG47ELvLtTIUIdKWkhbk4WJ5Jgl+hkuAFWMMENY0Zv3CacClkHHNsfNdlwL20JvXxduG1SQ2bhaUMA==
Date: Thu, 8 Mar 2018 22:03:03 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: albert@sifive.com, Daniel Lustig <dlustig@nvidia.com>,
        stern@rowland.harvard.edu, Will Deacon <will.deacon@arm.com>,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        paulmck@linux.vnet.ibm.com, akiyks@gmail.com, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] riscv/spinlock: Strengthen implementations with
 fences
Message-ID: <20180308210303.GA2897@andrea>
References: <20180307105242.GA6133@andrea>
 <mhng-45acdfe8-f932-4e48-aa78-b1fcd1f95344@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-45acdfe8-f932-4e48-aa78-b1fcd1f95344@palmer-si-x1c4>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 10:33:49AM -0800, Palmer Dabbelt wrote:

[...]

> I'm going to go produce a new set of spinlocks, I think it'll be a bit more
> coherent then.
> 
> I'm keeping your other patch in my queue for now, it generally looks good
> but I haven't looked closely yet.

Patches 1 and 2 address a same issue ("release-to-acquire"); this is also
expressed, more or less explicitly, in the corresponding commit messages:
it might make sense to "queue" them together, and to build the new locks
on top of these (even if this meant "rewrite all of/a large portion of
spinlock.h"...).

  Andrea


> 
> Thanks!
> 
> >
> >  Andrea
> >
> >
> >>
> >>   Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> >>
> >>diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> >>index 2fd27e8ef1fd..9b166ea81fe5 100644
> >>--- a/arch/riscv/include/asm/spinlock.h
> >>+++ b/arch/riscv/include/asm/spinlock.h
> >>@@ -15,128 +15,7 @@
> >>#ifndef _ASM_RISCV_SPINLOCK_H
> >>#define _ASM_RISCV_SPINLOCK_H
> >>
> >>-#include <linux/kernel.h>
> >>-#include <asm/current.h>
> >>-
> >>-/*
> >>- * Simple spin lock operations.  These provide no fairness guarantees.
> >>- */
> >>-
> >>-/* FIXME: Replace this with a ticket lock, like MIPS. */
> >>-
> >>-#define arch_spin_is_locked(x)	(READ_ONCE((x)->lock) != 0)
> >>-
> >>-static inline void arch_spin_unlock(arch_spinlock_t *lock)
> >>-{
> >>-	__asm__ __volatile__ (
> >>-		"amoswap.w.rl x0, x0, %0"
> >>-		: "=A" (lock->lock)
> >>-		:: "memory");
> >>-}
> >>-
> >>-static inline int arch_spin_trylock(arch_spinlock_t *lock)
> >>-{
> >>-	int tmp = 1, busy;
> >>-
> >>-	__asm__ __volatile__ (
> >>-		"amoswap.w.aq %0, %2, %1"
> >>-		: "=r" (busy), "+A" (lock->lock)
> >>-		: "r" (tmp)
> >>-		: "memory");
> >>-
> >>-	return !busy;
> >>-}
> >>-
> >>-static inline void arch_spin_lock(arch_spinlock_t *lock)
> >>-{
> >>-	while (1) {
> >>-		if (arch_spin_is_locked(lock))
> >>-			continue;
> >>-
> >>-		if (arch_spin_trylock(lock))
> >>-			break;
> >>-	}
> >>-}
> >>-
> >>-/***********************************************************/
> >>-
> >>-static inline void arch_read_lock(arch_rwlock_t *lock)
> >>-{
> >>-	int tmp;
> >>-
> >>-	__asm__ __volatile__(
> >>-		"1:	lr.w	%1, %0\n"
> >>-		"	bltz	%1, 1b\n"
> >>-		"	addi	%1, %1, 1\n"
> >>-		"	sc.w.aq	%1, %1, %0\n"
> >>-		"	bnez	%1, 1b\n"
> >>-		: "+A" (lock->lock), "=&r" (tmp)
> >>-		:: "memory");
> >>-}
> >>-
> >>-static inline void arch_write_lock(arch_rwlock_t *lock)
> >>-{
> >>-	int tmp;
> >>-
> >>-	__asm__ __volatile__(
> >>-		"1:	lr.w	%1, %0\n"
> >>-		"	bnez	%1, 1b\n"
> >>-		"	li	%1, -1\n"
> >>-		"	sc.w.aq	%1, %1, %0\n"
> >>-		"	bnez	%1, 1b\n"
> >>-		: "+A" (lock->lock), "=&r" (tmp)
> >>-		:: "memory");
> >>-}
> >>-
> >>-static inline int arch_read_trylock(arch_rwlock_t *lock)
> >>-{
> >>-	int busy;
> >>-
> >>-	__asm__ __volatile__(
> >>-		"1:	lr.w	%1, %0\n"
> >>-		"	bltz	%1, 1f\n"
> >>-		"	addi	%1, %1, 1\n"
> >>-		"	sc.w.aq	%1, %1, %0\n"
> >>-		"	bnez	%1, 1b\n"
> >>-		"1:\n"
> >>-		: "+A" (lock->lock), "=&r" (busy)
> >>-		:: "memory");
> >>-
> >>-	return !busy;
> >>-}
> >>-
> >>-static inline int arch_write_trylock(arch_rwlock_t *lock)
> >>-{
> >>-	int busy;
> >>-
> >>-	__asm__ __volatile__(
> >>-		"1:	lr.w	%1, %0\n"
> >>-		"	bnez	%1, 1f\n"
> >>-		"	li	%1, -1\n"
> >>-		"	sc.w.aq	%1, %1, %0\n"
> >>-		"	bnez	%1, 1b\n"
> >>-		"1:\n"
> >>-		: "+A" (lock->lock), "=&r" (busy)
> >>-		:: "memory");
> >>-
> >>-	return !busy;
> >>-}
> >>-
> >>-static inline void arch_read_unlock(arch_rwlock_t *lock)
> >>-{
> >>-	__asm__ __volatile__(
> >>-		"amoadd.w.rl x0, %1, %0"
> >>-		: "+A" (lock->lock)
> >>-		: "r" (-1)
> >>-		: "memory");
> >>-}
> >>-
> >>-static inline void arch_write_unlock(arch_rwlock_t *lock)
> >>-{
> >>-	__asm__ __volatile__ (
> >>-		"amoswap.w.rl x0, x0, %0"
> >>-		: "=A" (lock->lock)
> >>-		:: "memory");
> >>-}
> >>+#include <asm-generic/qspinlock.h>
> >>+#include <asm-generic/qrwlock.h>
> >>
> >>#endif /* _ASM_RISCV_SPINLOCK_H */
> >>
