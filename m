Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753829AbeDAQm7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 12:42:59 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45754 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753803AbeDAQm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 12:42:56 -0400
X-Google-Smtp-Source: AIpwx4/GKmian6CpD9y2vvTQAIyn5GFtnyDKP1XTu86syDvZAxzNk+pnIiTQCNP7sdB6Htbc6FLn7Q==
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: paulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v3 2/3] arm64: Remove smp_mb() from arch_spin_is_locked()
Date: Sun,  1 Apr 2018 18:41:51 +0200
Message-Id: <1522600912-6208-3-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522600912-6208-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1522600912-6208-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 38b850a73034f ("arm64: spinlock: order spin_{is_locked,unlock_wait}
against local locks") added an smp_mb() to arch_spin_is_locked(), in order
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

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/arm64/include/asm/spinlock.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index ebdae15d665de..26c5bd7d88d8d 100644
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
 
-- 
2.7.4
