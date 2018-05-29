Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936906AbeE2PsA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:48:00 -0400
Received: from foss.arm.com ([217.140.101.70]:43412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934948AbeE2PoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:44:13 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>
Subject: [PATCHv2 05/16] atomics: prepare for atomic64_fetch_add_unless()
Date: Tue, 29 May 2018 16:43:35 +0100
Message-Id: <20180529154346.3168-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180529154346.3168-1-mark.rutland@arm.com>
References: <20180529154346.3168-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently architecture must implement atomic_fetch_add_unless(), with
common code providing atomic_add_unless(). Architectures must also
implement atmic64_add_unless() directly, with no corresponding
atomic64_fetch_add_unless().

This divergenece is unfortunate, and means that the APIs for atomic_t,
atomic64_t, and atomic_long_t differ.

In preparation for unifying things, with architectures providing
atomic64_fetch_add_unless, this patch adds a generic
atomic64_add_unless() which will use atomic64_fetch_add_unless(). The
instrumented atomics are updated to take this case into account.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <albert@sifive.com>
---
 include/asm-generic/atomic-instrumented.h |  9 +++++++++
 include/linux/atomic.h                    | 16 ++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index 6e0818c182e2..e22d7e5f4ce7 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -93,11 +93,20 @@ static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 }
 #endif
 
+#ifdef arch_atomic64_fetch_add_unless
+#define atomic64_fetch_add_unless atomic64_fetch_add_unless
+static __always_inline int atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	kasan_check_write(v, sizeof(*v));
+	return arch_atomic64_fetch_add_unless(v, a, u);
+}
+#else
 static __always_inline bool atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_add_unless(v, a, u);
 }
+#endif
 
 static __always_inline void atomic_inc(atomic_t *v)
 {
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 1105c0b37f27..8d93209052e1 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -1072,6 +1072,22 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 #endif /* atomic64_try_cmpxchg */
 
 /**
+ * atomic64_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as @v was not already @u.
+ * Returns non-zero if @v was not @u, and zero otherwise.
+ */
+#ifdef atomic64_fetch_add_unless
+static inline int atomic64_add_unless(atomic64_t *v, long long a, long long u)
+{
+	return atomic64_fetch_add_unless(v, a, u) != u;
+}
+#endif
+
+/**
  * atomic64_inc_not_zero - increment unless the number is zero
  * @v: pointer of type atomic64_t
  *
-- 
2.11.0
