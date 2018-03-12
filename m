Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932271AbeCLMZh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:25:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37637 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbeCLMZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:25:35 -0400
Date: Mon, 12 Mar 2018 05:25:11 -0700
From: tip-bot for Dmitry Vyukov <tipbot@zytor.com>
Message-ID: <tip-ac605bee0bfab40fd5d11964705e907d2d5a32de@git.kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, akpm@linux-foundation.org,
        will.deacon@arm.com, dvyukov@google.com, aryabinin@virtuozzo.com,
        peterz@infradead.org, mark.rutland@arm.com, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, aryabinin@virtuozzo.com, hpa@zytor.com,
        mark.rutland@arm.com, dvyukov@google.com, will.deacon@arm.com
In-Reply-To: <cc595efc644bb905407012d82d3eb8bac3368e7a.1517246437.git.dvyukov@google.com>
References: <cc595efc644bb905407012d82d3eb8bac3368e7a.1517246437.git.dvyukov@google.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomic, asm-generic, x86: Add comments
 for atomic instrumentation
Git-Commit-ID: ac605bee0bfab40fd5d11964705e907d2d5a32de
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

Commit-ID:  ac605bee0bfab40fd5d11964705e907d2d5a32de
Gitweb:     https://git.kernel.org/tip/ac605bee0bfab40fd5d11964705e907d2d5a32de
Author:     Dmitry Vyukov <dvyukov@google.com>
AuthorDate: Mon, 29 Jan 2018 18:26:07 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 12:15:35 +0100

locking/atomic, asm-generic, x86: Add comments for atomic instrumentation

The comments are factored out from the code changes to make them
easier to read. Add them separately to explain some non-obvious
aspects.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/cc595efc644bb905407012d82d3eb8bac3368e7a.1517246437.git.dvyukov@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/atomic.h             |  4 ++++
 include/asm-generic/atomic-instrumented.h | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 33afc966d6a9..0db6bec95489 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -24,6 +24,10 @@
  */
 static __always_inline int arch_atomic_read(const atomic_t *v)
 {
+	/*
+	 * Note for KASAN: we deliberately don't use READ_ONCE_NOCHECK() here,
+	 * it's non-inlined function that increases binary size and stack usage.
+	 */
 	return READ_ONCE((v)->counter);
 }
 
diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index 82e080505982..ec07f23678ea 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -1,3 +1,15 @@
+/*
+ * This file provides wrappers with KASAN instrumentation for atomic operations.
+ * To use this functionality an arch's atomic.h file needs to define all
+ * atomic operations with arch_ prefix (e.g. arch_atomic_read()) and include
+ * this file at the end. This file provides atomic_read() that forwards to
+ * arch_atomic_read() for actual atomic operation.
+ * Note: if an arch atomic operation is implemented by means of other atomic
+ * operations (e.g. atomic_read()/atomic_cmpxchg() loop), then it needs to use
+ * arch_ variants (i.e. arch_atomic_read()/arch_atomic_cmpxchg()) to avoid
+ * double instrumentation.
+ */
+
 #ifndef _LINUX_ATOMIC_INSTRUMENTED_H
 #define _LINUX_ATOMIC_INSTRUMENTED_H
 
@@ -442,6 +454,15 @@ cmpxchg64_local_size(volatile u64 *ptr, u64 old, u64 new)
 		(u64)(new)));						\
 })
 
+/*
+ * Originally we had the following code here:
+ *     __typeof__(p1) ____p1 = (p1);
+ *     kasan_check_write(____p1, 2 * sizeof(*____p1));
+ *     arch_cmpxchg_double(____p1, (p2), (o1), (o2), (n1), (n2));
+ * But it leads to compilation failures (see gcc issue 72873).
+ * So for now it's left non-instrumented.
+ * There are few callers of cmpxchg_double(), so it's not critical.
+ */
 #define cmpxchg_double(p1, p2, o1, o2, n1, n2)				\
 ({									\
 	arch_cmpxchg_double((p1), (p2), (o1), (o2), (n1), (n2));	\
