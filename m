Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753788AbeDAQmk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 12:42:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55048 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753730AbeDAQmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 12:42:36 -0400
X-Google-Smtp-Source: AIpwx4/qQnd4UZ1UNwIPiHGaheeBT4dq6uZ9m2w34Wctt4ylKblDtJz7la9v7KKy8cp5DppBEJuG4A==
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: paulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v2 1/3] locking: Document the semantics of spin_is_locked()
Date: Sun,  1 Apr 2018 18:41:50 +0200
Message-Id: <1522600912-6208-2-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522600912-6208-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1522600912-6208-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There appeared to be a certain, recurrent uncertainty concerning the
semantics of spin_is_locked(), likely a consequence of the fact that
this semantics remains undocumented or that it has been historically
linked to the (likewise unclear) semantics of spin_unlock_wait().

A recent auditing [1] of the callers of the primitive confirmed that
none of them are relying on particular ordering guarantees; document
this semantics by adding a docbook header to spin_is_locked().

[1] https://marc.info/?l=linux-kernel&m=151981440005264&w=2

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
---
 include/linux/spinlock.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 4894d322d2584..2639fdc9a916c 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -380,6 +380,17 @@ static __always_inline int spin_trylock_irq(spinlock_t *lock)
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
+ * Return: 1, if @lock is (found to be) locked; 0, otherwise.
+ */
 static __always_inline int spin_is_locked(spinlock_t *lock)
 {
 	return raw_spin_is_locked(&lock->rlock);
-- 
2.7.4
