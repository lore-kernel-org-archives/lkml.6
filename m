Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeCLMYN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:24:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47065 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeCLMYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:24:09 -0400
Date: Mon, 12 Mar 2018 05:23:39 -0700
From: tip-bot for Dmitry Vyukov <tipbot@zytor.com>
Message-ID: <tip-b06ed71a624ba088a3e3e3ac7d4185f48c7c1660@git.kernel.org>
Cc: tglx@linutronix.de, peterz@infradead.org, mark.rutland@arm.com,
        will.deacon@arm.com, akpm@linux-foundation.org,
        aryabinin@virtuozzo.com, hpa@zytor.com, mingo@kernel.org,
        dvyukov@google.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Reply-To: tglx@linutronix.de, mark.rutland@arm.com, peterz@infradead.org,
        will.deacon@arm.com, akpm@linux-foundation.org,
        aryabinin@virtuozzo.com, mingo@kernel.org, hpa@zytor.com,
        dvyukov@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <4ffbfa72c29134ac87b1f69da1506a5720590b5d.1497690003.git.dvyukov@google.com>
References: <31040b4e126bce801d2cc85a9c444b4332a88aa8.1517246437.git.dvyukov@google.com>
        <4ffbfa72c29134ac87b1f69da1506a5720590b5d.1497690003.git.dvyukov@google.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomic, asm-generic: Add
 asm-generic/atomic-instrumented.h
Git-Commit-ID: b06ed71a624ba088a3e3e3ac7d4185f48c7c1660
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

Commit-ID:  b06ed71a624ba088a3e3e3ac7d4185f48c7c1660
Gitweb:     https://git.kernel.org/tip/b06ed71a624ba088a3e3e3ac7d4185f48c7c1660
Author:     Dmitry Vyukov <dvyukov@google.com>
AuthorDate: Mon, 29 Jan 2018 18:26:04 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 12:15:27 +0100

locking/atomic, asm-generic: Add asm-generic/atomic-instrumented.h

The new header allows to wrap per-arch atomic operations
and add common functionality to all of them.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/31040b4e126bce801d2cc85a9c444b4332a88aa8.1517246437.git.dvyukov@google.com
Link: http://lkml.kernel.org/r/4ffbfa72c29134ac87b1f69da1506a5720590b5d.1497690003.git.dvyukov@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/asm-generic/atomic-instrumented.h | 393 ++++++++++++++++++++++++++++++
 1 file changed, 393 insertions(+)

diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
new file mode 100644
index 000000000000..b966194d120a
--- /dev/null
+++ b/include/asm-generic/atomic-instrumented.h
@@ -0,0 +1,393 @@
+#ifndef _LINUX_ATOMIC_INSTRUMENTED_H
+#define _LINUX_ATOMIC_INSTRUMENTED_H
+
+#include <linux/build_bug.h>
+
+static __always_inline int atomic_read(const atomic_t *v)
+{
+	return arch_atomic_read(v);
+}
+
+static __always_inline s64 atomic64_read(const atomic64_t *v)
+{
+	return arch_atomic64_read(v);
+}
+
+static __always_inline void atomic_set(atomic_t *v, int i)
+{
+	arch_atomic_set(v, i);
+}
+
+static __always_inline void atomic64_set(atomic64_t *v, s64 i)
+{
+	arch_atomic64_set(v, i);
+}
+
+static __always_inline int atomic_xchg(atomic_t *v, int i)
+{
+	return arch_atomic_xchg(v, i);
+}
+
+static __always_inline s64 atomic64_xchg(atomic64_t *v, s64 i)
+{
+	return arch_atomic64_xchg(v, i);
+}
+
+static __always_inline int atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	return arch_atomic_cmpxchg(v, old, new);
+}
+
+static __always_inline s64 atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
+{
+	return arch_atomic64_cmpxchg(v, old, new);
+}
+
+#ifdef arch_atomic_try_cmpxchg
+#define atomic_try_cmpxchg atomic_try_cmpxchg
+static __always_inline bool atomic_try_cmpxchg(atomic_t *v, int *old, int new)
+{
+	return arch_atomic_try_cmpxchg(v, old, new);
+}
+#endif
+
+#ifdef arch_atomic64_try_cmpxchg
+#define atomic64_try_cmpxchg atomic64_try_cmpxchg
+static __always_inline bool atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
+{
+	return arch_atomic64_try_cmpxchg(v, old, new);
+}
+#endif
+
+static __always_inline int __atomic_add_unless(atomic_t *v, int a, int u)
+{
+	return __arch_atomic_add_unless(v, a, u);
+}
+
+
+static __always_inline bool atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	return arch_atomic64_add_unless(v, a, u);
+}
+
+static __always_inline void atomic_inc(atomic_t *v)
+{
+	arch_atomic_inc(v);
+}
+
+static __always_inline void atomic64_inc(atomic64_t *v)
+{
+	arch_atomic64_inc(v);
+}
+
+static __always_inline void atomic_dec(atomic_t *v)
+{
+	arch_atomic_dec(v);
+}
+
+static __always_inline void atomic64_dec(atomic64_t *v)
+{
+	arch_atomic64_dec(v);
+}
+
+static __always_inline void atomic_add(int i, atomic_t *v)
+{
+	arch_atomic_add(i, v);
+}
+
+static __always_inline void atomic64_add(s64 i, atomic64_t *v)
+{
+	arch_atomic64_add(i, v);
+}
+
+static __always_inline void atomic_sub(int i, atomic_t *v)
+{
+	arch_atomic_sub(i, v);
+}
+
+static __always_inline void atomic64_sub(s64 i, atomic64_t *v)
+{
+	arch_atomic64_sub(i, v);
+}
+
+static __always_inline void atomic_and(int i, atomic_t *v)
+{
+	arch_atomic_and(i, v);
+}
+
+static __always_inline void atomic64_and(s64 i, atomic64_t *v)
+{
+	arch_atomic64_and(i, v);
+}
+
+static __always_inline void atomic_or(int i, atomic_t *v)
+{
+	arch_atomic_or(i, v);
+}
+
+static __always_inline void atomic64_or(s64 i, atomic64_t *v)
+{
+	arch_atomic64_or(i, v);
+}
+
+static __always_inline void atomic_xor(int i, atomic_t *v)
+{
+	arch_atomic_xor(i, v);
+}
+
+static __always_inline void atomic64_xor(s64 i, atomic64_t *v)
+{
+	arch_atomic64_xor(i, v);
+}
+
+static __always_inline int atomic_inc_return(atomic_t *v)
+{
+	return arch_atomic_inc_return(v);
+}
+
+static __always_inline s64 atomic64_inc_return(atomic64_t *v)
+{
+	return arch_atomic64_inc_return(v);
+}
+
+static __always_inline int atomic_dec_return(atomic_t *v)
+{
+	return arch_atomic_dec_return(v);
+}
+
+static __always_inline s64 atomic64_dec_return(atomic64_t *v)
+{
+	return arch_atomic64_dec_return(v);
+}
+
+static __always_inline s64 atomic64_inc_not_zero(atomic64_t *v)
+{
+	return arch_atomic64_inc_not_zero(v);
+}
+
+static __always_inline s64 atomic64_dec_if_positive(atomic64_t *v)
+{
+	return arch_atomic64_dec_if_positive(v);
+}
+
+static __always_inline bool atomic_dec_and_test(atomic_t *v)
+{
+	return arch_atomic_dec_and_test(v);
+}
+
+static __always_inline bool atomic64_dec_and_test(atomic64_t *v)
+{
+	return arch_atomic64_dec_and_test(v);
+}
+
+static __always_inline bool atomic_inc_and_test(atomic_t *v)
+{
+	return arch_atomic_inc_and_test(v);
+}
+
+static __always_inline bool atomic64_inc_and_test(atomic64_t *v)
+{
+	return arch_atomic64_inc_and_test(v);
+}
+
+static __always_inline int atomic_add_return(int i, atomic_t *v)
+{
+	return arch_atomic_add_return(i, v);
+}
+
+static __always_inline s64 atomic64_add_return(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_add_return(i, v);
+}
+
+static __always_inline int atomic_sub_return(int i, atomic_t *v)
+{
+	return arch_atomic_sub_return(i, v);
+}
+
+static __always_inline s64 atomic64_sub_return(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_sub_return(i, v);
+}
+
+static __always_inline int atomic_fetch_add(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_add(i, v);
+}
+
+static __always_inline s64 atomic64_fetch_add(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_add(i, v);
+}
+
+static __always_inline int atomic_fetch_sub(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_sub(i, v);
+}
+
+static __always_inline s64 atomic64_fetch_sub(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_sub(i, v);
+}
+
+static __always_inline int atomic_fetch_and(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_and(i, v);
+}
+
+static __always_inline s64 atomic64_fetch_and(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_and(i, v);
+}
+
+static __always_inline int atomic_fetch_or(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_or(i, v);
+}
+
+static __always_inline s64 atomic64_fetch_or(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_or(i, v);
+}
+
+static __always_inline int atomic_fetch_xor(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_xor(i, v);
+}
+
+static __always_inline s64 atomic64_fetch_xor(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_xor(i, v);
+}
+
+static __always_inline bool atomic_sub_and_test(int i, atomic_t *v)
+{
+	return arch_atomic_sub_and_test(i, v);
+}
+
+static __always_inline bool atomic64_sub_and_test(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_sub_and_test(i, v);
+}
+
+static __always_inline bool atomic_add_negative(int i, atomic_t *v)
+{
+	return arch_atomic_add_negative(i, v);
+}
+
+static __always_inline bool atomic64_add_negative(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_add_negative(i, v);
+}
+
+static __always_inline unsigned long
+cmpxchg_size(volatile void *ptr, unsigned long old, unsigned long new, int size)
+{
+	switch (size) {
+	case 1:
+		return arch_cmpxchg((u8 *)ptr, (u8)old, (u8)new);
+	case 2:
+		return arch_cmpxchg((u16 *)ptr, (u16)old, (u16)new);
+	case 4:
+		return arch_cmpxchg((u32 *)ptr, (u32)old, (u32)new);
+	case 8:
+		BUILD_BUG_ON(sizeof(unsigned long) != 8);
+		return arch_cmpxchg((u64 *)ptr, (u64)old, (u64)new);
+	}
+	BUILD_BUG();
+	return 0;
+}
+
+#define cmpxchg(ptr, old, new)						\
+({									\
+	((__typeof__(*(ptr)))cmpxchg_size((ptr), (unsigned long)(old),	\
+		(unsigned long)(new), sizeof(*(ptr))));			\
+})
+
+static __always_inline unsigned long
+sync_cmpxchg_size(volatile void *ptr, unsigned long old, unsigned long new,
+		  int size)
+{
+	switch (size) {
+	case 1:
+		return arch_sync_cmpxchg((u8 *)ptr, (u8)old, (u8)new);
+	case 2:
+		return arch_sync_cmpxchg((u16 *)ptr, (u16)old, (u16)new);
+	case 4:
+		return arch_sync_cmpxchg((u32 *)ptr, (u32)old, (u32)new);
+	case 8:
+		BUILD_BUG_ON(sizeof(unsigned long) != 8);
+		return arch_sync_cmpxchg((u64 *)ptr, (u64)old, (u64)new);
+	}
+	BUILD_BUG();
+	return 0;
+}
+
+#define sync_cmpxchg(ptr, old, new)					\
+({									\
+	((__typeof__(*(ptr)))sync_cmpxchg_size((ptr),			\
+		(unsigned long)(old), (unsigned long)(new),		\
+		sizeof(*(ptr))));					\
+})
+
+static __always_inline unsigned long
+cmpxchg_local_size(volatile void *ptr, unsigned long old, unsigned long new,
+		   int size)
+{
+	switch (size) {
+	case 1:
+		return arch_cmpxchg_local((u8 *)ptr, (u8)old, (u8)new);
+	case 2:
+		return arch_cmpxchg_local((u16 *)ptr, (u16)old, (u16)new);
+	case 4:
+		return arch_cmpxchg_local((u32 *)ptr, (u32)old, (u32)new);
+	case 8:
+		BUILD_BUG_ON(sizeof(unsigned long) != 8);
+		return arch_cmpxchg_local((u64 *)ptr, (u64)old, (u64)new);
+	}
+	BUILD_BUG();
+	return 0;
+}
+
+#define cmpxchg_local(ptr, old, new)					\
+({									\
+	((__typeof__(*(ptr)))cmpxchg_local_size((ptr),			\
+		(unsigned long)(old), (unsigned long)(new),		\
+		sizeof(*(ptr))));					\
+})
+
+static __always_inline u64
+cmpxchg64_size(volatile u64 *ptr, u64 old, u64 new)
+{
+	return arch_cmpxchg64(ptr, old, new);
+}
+
+#define cmpxchg64(ptr, old, new)					\
+({									\
+	((__typeof__(*(ptr)))cmpxchg64_size((ptr), (u64)(old),		\
+		(u64)(new)));						\
+})
+
+static __always_inline u64
+cmpxchg64_local_size(volatile u64 *ptr, u64 old, u64 new)
+{
+	return arch_cmpxchg64_local(ptr, old, new);
+}
+
+#define cmpxchg64_local(ptr, old, new)					\
+({									\
+	((__typeof__(*(ptr)))cmpxchg64_local_size((ptr), (u64)(old),	\
+		(u64)(new)));						\
+})
+
+#define cmpxchg_double(p1, p2, o1, o2, n1, n2)				\
+({									\
+	arch_cmpxchg_double((p1), (p2), (o1), (o2), (n1), (n2));	\
+})
+
+#define cmpxchg_double_local(p1, p2, o1, o2, n1, n2)			\
+({									\
+	arch_cmpxchg_double_local((p1), (p2), (o1), (o2), (n1), (n2));	\
+})
+
+#endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
