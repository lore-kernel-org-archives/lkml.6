Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751606AbeDFTsN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 15:48:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50681 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbeDFTsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 15:48:11 -0400
X-Google-Smtp-Source: AIpwx49LafS4kL41jKSe6rbrW6BC9TspqOsQ3Yspc1sI4TO9kDTmuHd48vU8fs3oVbpvv4n8nF10Ng==
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: paulmck@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        David Howells <dhowells@redhat.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v4 1/3] locking: Document the semantics of spin_is_locked()
Date: Fri,  6 Apr 2018 21:47:39 +0200
Message-Id: <1523044060-5568-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522600912-6208-2-git-send-email-andrea.parri@amarulasolutions.com>
References: <1522600912-6208-2-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/spinlock.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 4894d322d2584..1e8a464358384 100644
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
-- 
2.7.4
