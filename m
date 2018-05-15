Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeEOG0n (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:26:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59491 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752354AbeEOG0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:26:41 -0400
Date: Mon, 14 May 2018 23:26:17 -0700
From: tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-c6f5d02b6a0fb91be5d656885ce02cf28952181d@git.kernel.org>
Cc: catalin.marinas@arm.com, andrea.parri@amarulasolutions.com,
        hpa@zytor.com, will.deacon@arm.com, peterz@infradead.org,
        mingo@kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        paulmck@linux.vnet.ibm.com, tglx@linutronix.de
Reply-To: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        paulmck@linux.vnet.ibm.com, hpa@zytor.com,
        andrea.parri@amarulasolutions.com, catalin.marinas@arm.com,
        mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org
In-Reply-To: <1526338889-7003-2-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526338889-7003-2-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/spinlocks/arm64: Remove smp_mb() from
 arch_spin_is_locked()
Git-Commit-ID: c6f5d02b6a0fb91be5d656885ce02cf28952181d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c6f5d02b6a0fb91be5d656885ce02cf28952181d
Gitweb:     https://git.kernel.org/tip/c6f5d02b6a0fb91be5d656885ce02cf28952181d
Author:     Andrea Parri <andrea.parri@amarulasolutions.com>
AuthorDate: Mon, 14 May 2018 16:01:28 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:15 +0200

locking/spinlocks/arm64: Remove smp_mb() from arch_spin_is_locked()

The following commit:

  38b850a73034f ("arm64: spinlock: order spin_{is_locked,unlock_wait} against local locks")

... added an smp_mb() to arch_spin_is_locked(), in order
"to ensure that the lock value is always loaded after any other locks have
been taken by the current CPU", and reported one example (the "insane case"
in ipc/sem.c) relying on such guarantee.

It is however understood that spin_is_locked() is not required to provide
such an ordering guarantee (a guarantee that is currently not provided by
all the implementations/archs), and that callers relying on such ordering
should instead insert suitable memory barriers before acting on the result
of spin_is_locked().

Following a recent auditing [1] of the callers of {,raw_}spin_is_locked(),
revealing that none of them are relying on the ordering guarantee anymore,
this commit removes the leading smp_mb() from the primitive thus reverting
38b850a73034f.

[1] https://marc.info/?l=linux-kernel&m=151981440005264&w=2
    https://marc.info/?l=linux-kernel&m=152042843808540&w=2
    https://marc.info/?l=linux-kernel&m=152043346110262&w=2

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: stern@rowland.harvard.edu
Link: http://lkml.kernel.org/r/1526338889-7003-2-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm64/include/asm/spinlock.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index ebdae15d665d..26c5bd7d88d8 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -122,11 +122,6 @@ static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 
 static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
-	/*
-	 * Ensure prior spin_lock operations to other locks have completed
-	 * on this CPU before we test whether "lock" is locked.
-	 */
-	smp_mb(); /* ^^^ */
 	return !arch_spin_value_unlocked(READ_ONCE(*lock));
 }
 
