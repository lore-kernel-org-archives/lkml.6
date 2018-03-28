Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeC1Jr4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 05:47:56 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:47068 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeC1Jrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 05:47:55 -0400
X-Google-Smtp-Source: AIpwx48/xTAEJ5HjwYS1EC/TxZppbKabXjkD7cxf8TZubC4SinUyxahrymPFS+J4P6Vt+zocWJC/tw==
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH v2 for-4.17 2/3] powerpc: Remove smp_mb() from arch_spin_is_locked()
Date: Wed, 28 Mar 2018 11:47:37 +0200
Message-Id: <1522230457-12337-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 51d7d5205d338 ("powerpc: Add smp_mb() to arch_spin_is_locked()")
added an smp_mb() to arch_spin_is_locked(), in order to ensure that

	Thread 0			Thread 1

	spin_lock(A);			spin_lock(B);
	r0 = spin_is_locked(B)		r1 = spin_is_locked(A);

never ends up with r0 = r1 = 0, and reported one example (in ipc/sem.c)
relying on such guarantee.

It's however understood (and undocumented) that spin_is_locked() is not
required to ensure such ordering guarantee, guarantee that is currently
_not_ provided by all implementations/arch, and that callers relying on
such ordering should instead use suitable memory barriers before acting
on the result of spin_is_locked().

Following a recent auditing[1] of the callers of {,raw_}spin_is_locked()
revealing that none of them are relying on this guarantee anymore, this
commit removes the leading smp_mb() from the primitive thus effectively
reverting 51d7d5205d338.

[1] https://marc.info/?l=linux-kernel&m=151981440005264&w=2

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/powerpc/include/asm/spinlock.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index b9ebc3085fb79..ecc141e3f1a73 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -67,7 +67,6 @@ static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 
 static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
-	smp_mb();
 	return !arch_spin_value_unlocked(*lock);
 }
 
-- 
2.7.4
