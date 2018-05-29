Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965076AbeE2PqU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:46:20 -0400
Received: from foss.arm.com ([217.140.101.70]:43512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936866AbeE2Poa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:44:30 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCHv2 14/16] atomics/treewide: remove atomic_inc_not_zero_hint()
Date: Tue, 29 May 2018 16:43:44 +0100
Message-Id: <20180529154346.3168-15-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180529154346.3168-1-mark.rutland@arm.com>
References: <20180529154346.3168-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While documentation suggests atomic_inc_not_zero_hint() will perform better
than atomic_inc_not_zero(), this is unlikely to be the case. No architectures
implement atomic_inc_not_zero_hint() directly, and thus it either falls back to
atomic_inc_not_zero(), or a loop using atomic_cmpxchg().

Whenever the hint does not match the value in memory, the repeated use of
atomic_cmpxchg() will be more expensive than the read that
atomic_inc_not_zero_hint() attempts to avoid. For architectures with LL/SC
atomics, a read cannot be avoided, and it would always be better to use
atomic_inc_not_zero() directly. For other architectures, their own
atomic_inc_not_zero() is likely to be more optimal than an atomic_cmpxchg()
loop regardless.

Generally, atomic_inc_not_zero_hint() is liable to perform worse than
atomic_inc_not_zero(). Further, atomic_inc_not_zero_hint() only exists
for atomic_t, and not atomic64_t or atomic_long_t, and there is only one
user in the kernel tree.

Given all this, let's remove atomic_inc_not_zero_hint(), and migrate the
existing user over to atomic_inc_not_zero().

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 include/linux/atomic.h | 32 --------------------------------
 net/atm/pppoatm.c      |  2 +-
 2 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 7d41b6fffab6..8ec4d120b264 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -656,38 +656,6 @@ static inline int atomic_fetch_andnot_release(int i, atomic_t *v)
 }
 #endif
 
-/**
- * atomic_inc_not_zero_hint - increment if not null
- * @v: pointer of type atomic_t
- * @hint: probable value of the atomic before the increment
- *
- * This version of atomic_inc_not_zero() gives a hint of probable
- * value of the atomic. This helps processor to not read the memory
- * before doing the atomic read/modify/write cycle, lowering
- * number of bus transactions on some arches.
- *
- * Returns: 0 if increment was not done, 1 otherwise.
- */
-#ifndef atomic_inc_not_zero_hint
-static inline int atomic_inc_not_zero_hint(atomic_t *v, int hint)
-{
-	int val, c = hint;
-
-	/* sanity test, should be removed by compiler if hint is a constant */
-	if (!hint)
-		return atomic_inc_not_zero(v);
-
-	do {
-		val = atomic_cmpxchg(v, c, c + 1);
-		if (val == c)
-			return 1;
-		c = val;
-	} while (c);
-
-	return 0;
-}
-#endif
-
 #ifndef atomic_inc_unless_negative
 static inline int atomic_inc_unless_negative(atomic_t *p)
 {
diff --git a/net/atm/pppoatm.c b/net/atm/pppoatm.c
index 21d9d341a619..a4d82afd4586 100644
--- a/net/atm/pppoatm.c
+++ b/net/atm/pppoatm.c
@@ -244,7 +244,7 @@ static int pppoatm_may_send(struct pppoatm_vcc *pvcc, int size)
 	 * the packet count limit, so...
 	 */
 	if (atm_may_send(pvcc->atmvcc, size) &&
-	    atomic_inc_not_zero_hint(&pvcc->inflight, NONE_INFLIGHT))
+	    atomic_inc_not_zero(&pvcc->inflight))
 		return 1;
 
 	/*
-- 
2.11.0
