Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965914AbeE2SIM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:08:12 -0400
Received: from foss.arm.com ([217.140.101.70]:45892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965792AbeE2SIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:08:06 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 3/7] atomics: separate basic {cmp,}xchg()
Date: Tue, 29 May 2018 19:07:42 +0100
Message-Id: <20180529180746.29684-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180529180746.29684-1-mark.rutland@arm.com>
References: <20180529180746.29684-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the basic {cmp,}xchg() definitions live in the middle of the
atomic_t definitions. Let's pull them earlier so that the file has, in
order:

* __atomic_op_<order>() definitions

* {cmp,}xchg() definitions

* atomic_t definiitions

* atomic64_t definitions

* atomic_long_t definitions

... which will make subsequent rework less messy.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 include/linux/atomic.h | 138 ++++++++++++++++++++++++-------------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 580d15b10bfd..28c4aa3c1a4c 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -77,6 +77,75 @@
 	__ret;								\
 })
 
+/* cmpxchg_relaxed */
+#ifndef cmpxchg_relaxed
+#define  cmpxchg_relaxed		cmpxchg
+#define  cmpxchg_acquire		cmpxchg
+#define  cmpxchg_release		cmpxchg
+
+#else /* cmpxchg_relaxed */
+
+#ifndef cmpxchg_acquire
+#define  cmpxchg_acquire(...)						\
+	__atomic_op_acquire(cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef cmpxchg_release
+#define  cmpxchg_release(...)						\
+	__atomic_op_release(cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef cmpxchg
+#define  cmpxchg(...)							\
+	__atomic_op_fence(cmpxchg, __VA_ARGS__)
+#endif
+#endif /* cmpxchg_relaxed */
+
+/* cmpxchg64_relaxed */
+#ifndef cmpxchg64_relaxed
+#define  cmpxchg64_relaxed		cmpxchg64
+#define  cmpxchg64_acquire		cmpxchg64
+#define  cmpxchg64_release		cmpxchg64
+
+#else /* cmpxchg64_relaxed */
+
+#ifndef cmpxchg64_acquire
+#define  cmpxchg64_acquire(...)						\
+	__atomic_op_acquire(cmpxchg64, __VA_ARGS__)
+#endif
+
+#ifndef cmpxchg64_release
+#define  cmpxchg64_release(...)						\
+	__atomic_op_release(cmpxchg64, __VA_ARGS__)
+#endif
+
+#ifndef cmpxchg64
+#define  cmpxchg64(...)							\
+	__atomic_op_fence(cmpxchg64, __VA_ARGS__)
+#endif
+#endif /* cmpxchg64_relaxed */
+
+/* xchg_relaxed */
+#ifndef xchg_relaxed
+#define  xchg_relaxed			xchg
+#define  xchg_acquire			xchg
+#define  xchg_release			xchg
+
+#else /* xchg_relaxed */
+
+#ifndef xchg_acquire
+#define  xchg_acquire(...)		__atomic_op_acquire(xchg, __VA_ARGS__)
+#endif
+
+#ifndef xchg_release
+#define  xchg_release(...)		__atomic_op_release(xchg, __VA_ARGS__)
+#endif
+
+#ifndef xchg
+#define  xchg(...)			__atomic_op_fence(xchg, __VA_ARGS__)
+#endif
+#endif /* xchg_relaxed */
+
 /* atomic_add_return_relaxed */
 #ifndef atomic_add_return_relaxed
 #define  atomic_add_return_relaxed	atomic_add_return
@@ -480,75 +549,6 @@
 #define atomic_try_cmpxchg_release	atomic_try_cmpxchg
 #endif /* atomic_try_cmpxchg */
 
-/* cmpxchg_relaxed */
-#ifndef cmpxchg_relaxed
-#define  cmpxchg_relaxed		cmpxchg
-#define  cmpxchg_acquire		cmpxchg
-#define  cmpxchg_release		cmpxchg
-
-#else /* cmpxchg_relaxed */
-
-#ifndef cmpxchg_acquire
-#define  cmpxchg_acquire(...)						\
-	__atomic_op_acquire(cmpxchg, __VA_ARGS__)
-#endif
-
-#ifndef cmpxchg_release
-#define  cmpxchg_release(...)						\
-	__atomic_op_release(cmpxchg, __VA_ARGS__)
-#endif
-
-#ifndef cmpxchg
-#define  cmpxchg(...)							\
-	__atomic_op_fence(cmpxchg, __VA_ARGS__)
-#endif
-#endif /* cmpxchg_relaxed */
-
-/* cmpxchg64_relaxed */
-#ifndef cmpxchg64_relaxed
-#define  cmpxchg64_relaxed		cmpxchg64
-#define  cmpxchg64_acquire		cmpxchg64
-#define  cmpxchg64_release		cmpxchg64
-
-#else /* cmpxchg64_relaxed */
-
-#ifndef cmpxchg64_acquire
-#define  cmpxchg64_acquire(...)						\
-	__atomic_op_acquire(cmpxchg64, __VA_ARGS__)
-#endif
-
-#ifndef cmpxchg64_release
-#define  cmpxchg64_release(...)						\
-	__atomic_op_release(cmpxchg64, __VA_ARGS__)
-#endif
-
-#ifndef cmpxchg64
-#define  cmpxchg64(...)							\
-	__atomic_op_fence(cmpxchg64, __VA_ARGS__)
-#endif
-#endif /* cmpxchg64_relaxed */
-
-/* xchg_relaxed */
-#ifndef xchg_relaxed
-#define  xchg_relaxed			xchg
-#define  xchg_acquire			xchg
-#define  xchg_release			xchg
-
-#else /* xchg_relaxed */
-
-#ifndef xchg_acquire
-#define  xchg_acquire(...)		__atomic_op_acquire(xchg, __VA_ARGS__)
-#endif
-
-#ifndef xchg_release
-#define  xchg_release(...)		__atomic_op_release(xchg, __VA_ARGS__)
-#endif
-
-#ifndef xchg
-#define  xchg(...)			__atomic_op_fence(xchg, __VA_ARGS__)
-#endif
-#endif /* xchg_relaxed */
-
 /**
  * atomic_fetch_add_unless - add unless the number is already a given value
  * @v: pointer of type atomic_t
-- 
2.11.0
