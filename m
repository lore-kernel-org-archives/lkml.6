Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbeEOG0f (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:26:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43785 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbeEOG0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:26:33 -0400
Date: Mon, 14 May 2018 23:25:49 -0700
From: tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-b7e4aadef28f217de8907eec60a964328797a2be@git.kernel.org>
Cc: torvalds@linux-foundation.org, peterz@infradead.org,
        j.alglave@ucl.ac.uk, dhowells@redhat.com,
        andrea.parri@amarulasolutions.com, will.deacon@arm.com,
        akiyks@gmail.com, npiggin@gmail.com, akpm@linux-foundation.org,
        paulmck@linux.vnet.ibm.com, stern@rowland.harvard.edu, hpa@zytor.com,
        boqun.feng@gmail.com, mingo@kernel.org, luc.maranget@inria.fr,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Reply-To: will.deacon@arm.com, andrea.parri@amarulasolutions.com,
        akiyks@gmail.com, npiggin@gmail.com, j.alglave@ucl.ac.uk,
        torvalds@linux-foundation.org, peterz@infradead.org,
        dhowells@redhat.com, tglx@linutronix.de, luc.maranget@inria.fr,
        mingo@kernel.org, linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        paulmck@linux.vnet.ibm.com, akpm@linux-foundation.org, hpa@zytor.com,
        stern@rowland.harvard.edu, boqun.feng@gmail.com
In-Reply-To: <1526338889-7003-1-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526338889-7003-1-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/spinlocks: Document the semantics of
 spin_is_locked()
Git-Commit-ID: b7e4aadef28f217de8907eec60a964328797a2be
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

Commit-ID:  b7e4aadef28f217de8907eec60a964328797a2be
Gitweb:     https://git.kernel.org/tip/b7e4aadef28f217de8907eec60a964328797a2be
Author:     Andrea Parri <andrea.parri@amarulasolutions.com>
AuthorDate: Mon, 14 May 2018 16:01:27 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:15 +0200

locking/spinlocks: Document the semantics of spin_is_locked()

There appeared to be a certain, recurrent uncertainty concerning the
semantics of spin_is_locked(), likely a consequence of the fact that
this semantics remains undocumented or that it has been historically
linked to the (likewise unclear) semantics of spin_unlock_wait().

A recent auditing [1] of the callers of the primitive confirmed that
none of them are relying on particular ordering guarantees; document
this semantics by adding a docbook header to spin_is_locked(). Also,
describe behaviors specific to certain CONFIG_SMP=n builds.

[1] https://marc.info/?l=linux-kernel&m=151981440005264&w=2
    https://marc.info/?l=linux-kernel&m=152042843808540&w=2
    https://marc.info/?l=linux-kernel&m=152043346110262&w=2

Co-Developed-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Co-Developed-by: Alan Stern <stern@rowland.harvard.edu>
Co-Developed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: parri.andrea@gmail.com
Link: http://lkml.kernel.org/r/1526338889-7003-1-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/spinlock.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 4894d322d258..1e8a46435838 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -380,6 +380,24 @@ static __always_inline int spin_trylock_irq(spinlock_t *lock)
 	raw_spin_trylock_irqsave(spinlock_check(lock), flags); \
 })
 
+/**
+ * spin_is_locked() - Check whether a spinlock is locked.
+ * @lock: Pointer to the spinlock.
+ *
+ * This function is NOT required to provide any memory ordering
+ * guarantees; it could be used for debugging purposes or, when
+ * additional synchronization is needed, accompanied with other
+ * constructs (memory barriers) enforcing the synchronization.
+ *
+ * Returns: 1 if @lock is locked, 0 otherwise.
+ *
+ * Note that the function only tells you that the spinlock is
+ * seen to be locked, not that it is locked on your CPU.
+ *
+ * Further, on CONFIG_SMP=n builds with CONFIG_DEBUG_SPINLOCK=n,
+ * the return value is always 0 (see include/linux/spinlock_up.h).
+ * Therefore you should not rely heavily on the return value.
+ */
 static __always_inline int spin_is_locked(spinlock_t *lock)
 {
 	return raw_spin_is_locked(&lock->rlock);
